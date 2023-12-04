import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/mangadex/model.dart';
import 'package:gagaku/mangadex/types.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:gagaku/types.dart';
import 'package:gagaku/ui.dart';
import 'package:gagaku/util.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:number_paginator/number_paginator.dart';

Page<dynamic> buildListEditPage(BuildContext context, GoRouterState state) {
  final list = state.extra.asOrNull<CRef>();

  Widget child;

  if (list != null) {
    child = MangaDexEditListScreen(
      list: list,
    );
  } else {
    child =
        QueriedMangaDexEditListScreen(listId: state.pathParameters['listId']!);
  }

  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: Styles.scaledSharedAxisTransitionBuilder,
  );
}

class QueriedMangaDexEditListScreen extends ConsumerWidget {
  const QueriedMangaDexEditListScreen({super.key, required this.listId});

  final String listId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(listByIdProvider(listId));

    Widget child;

    switch (list) {
      case AsyncData(:final value):
        if (value == null) {
          child = Center(
            child: Text('Invalid listId $listId!'),
          );
        } else {
          return MangaDexEditListScreen(
            list: value,
          );
        }
      case AsyncError(:final error, :final stackTrace):
        final messenger = ScaffoldMessenger.of(context);
        Styles.showErrorSnackBar(messenger, '$error');
        logger.e("_fetchListFromIdProvider($listId) failed",
            error: error, stackTrace: stackTrace);

        child = Styles.errorColumn(error, stackTrace);
        break;
      case _:
        child = Styles.listSpinner;
        break;
    }

    return Scaffold(
      body: child,
    );
  }
}

class MangaDexEditListScreen extends HookConsumerWidget {
  const MangaDexEditListScreen({super.key, this.list});

  final CRef? list;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listNameController =
        useTextEditingController(text: list?.get<CustomList>().attributes.name);
    final listNameChanged = useListenableSelector(
        listNameController,
        () => list != null
            ? listNameController.text != list!.get<CustomList>().attributes.name
            : listNameController.text.isNotEmpty);

    final visibility = useState(list != null
        ? list!.get<CustomList>().attributes.visibility
        : CustomListVisibility.private);

    final pendingAction = useState<Future<bool>?>(null);
    final snapshot = useFuture(pendingAction.value);

    final selected = useState<Set<String>>(
        list != null ? {...list!.get<CustomList>().set} : {});
    final currentPage = useState(0);

    final titlesProvider = ref
        .watch(getMangaListByPageProvider(selected.value, currentPage.value));
    final titles = titlesProvider.valueOrNull;

    final isLoading = titlesProvider.isLoading;

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/');
            }
          },
        ),
        flexibleSpace: GestureDetector(
          child: Styles.titleFlexBar(
              context: context,
              title: '${list != null ? 'Edit' : 'Create'} List'),
        ),
        actions: [
          TextButton(
            style: Styles.buttonStyle(),
            child: const Text('Cancel'),
            onPressed: () {
              context.pop();
            },
          ),
          ElevatedButton(
            style: Styles.buttonStyle(),
            onPressed: listNameChanged ||
                    (list != null &&
                        !setEquals(
                            selected.value, list!.get<CustomList>().set)) ||
                    (list != null &&
                        visibility.value !=
                            list!.get<CustomList>().attributes.visibility)
                ? () async {
                    final messenger = ScaffoldMessenger.of(context);

                    if (listNameController.text.isNotEmpty) {
                      Future<bool> success;

                      if (list != null) {
                        success = ref.read(userListsProvider.notifier).editList(
                            list!,
                            listNameController.text,
                            visibility.value,
                            selected.value);
                      } else {
                        success = ref.read(userListsProvider.notifier).newList(
                            listNameController.text,
                            visibility.value,
                            selected.value);
                      }

                      success.then((success) {
                        if (success) {
                          context.pop(true);
                        } else {
                          messenger
                            ..removeCurrentSnackBar()
                            ..showSnackBar(
                              SnackBar(
                                content: Text(
                                    'Failed to ${list != null ? 'edit' : 'create'} list.'),
                                backgroundColor: Colors.red,
                              ),
                            );
                        }
                      });

                      pendingAction.value = success;
                    } else {
                      messenger
                        ..removeCurrentSnackBar()
                        ..showSnackBar(
                          const SnackBar(
                            content: Text('List name cannot be empty.'),
                            backgroundColor: Colors.red,
                          ),
                        );
                    }
                  }
                : null,
            child: Text(list != null ? 'Save' : 'Create'),
          ),
        ],
      ),
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 12.0),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: listNameController,
                        decoration: const InputDecoration(
                          filled: true,
                          labelText: 'List Name',
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (String? value) {
                          return (value == null || value.isEmpty)
                              ? 'List Name cannot be empty.'
                              : null;
                        },
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    DropdownMenu<CustomListVisibility>(
                      label: const Text('Visibility'),
                      initialSelection: visibility.value,
                      enableFilter: false,
                      enableSearch: false,
                      requestFocusOnTap: false,
                      onSelected: (v) {
                        if (v != null) {
                          visibility.value = v;
                        }
                      },
                      dropdownMenuEntries: const [
                        DropdownMenuEntry<CustomListVisibility>(
                          value: CustomListVisibility.private,
                          label: 'Private',
                        ),
                        DropdownMenuEntry<CustomListVisibility>(
                          value: CustomListVisibility.public,
                          label: 'Public',
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12.0),
                ElevatedButton(
                  style: Styles.buttonStyle(
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer,
                  ),
                  onPressed: () {
                    context
                        .push<Set<String>>('/search?selectMode=true',
                            extra: selected.value)
                        .then((result) {
                      if (result != null) {
                        selected.value = {...result};
                      }
                    });
                  },
                  child: const Text('Add Titles'),
                ),
                const SizedBox(height: 12.0),
                Expanded(
                  child: MangaListWidget(
                    title: Text(
                      'Titles ${list != null ? '(${list!.get<CustomList>().set.length} > ${selected.value.length})' : '(${selected.value.length})'}',
                      style: const TextStyle(fontSize: 24),
                    ),
                    physics: const AlwaysScrollableScrollPhysics(),
                    showToggle: false,
                    children: [
                      if (titles != null)
                        MangaListViewSliver(
                          items: titles,
                          selectMode: true,
                          selectButton: (manga) {
                            return const Icon(Icons.remove);
                          },
                          onSelected: (manga) {
                            selected.value = {
                              ...selected.value..remove(manga.id)
                            };
                          },
                        ),
                    ],
                  ),
                ),
                NumberPaginator(
                  numberPages: max(
                      (selected.value.length / MangaDexEndpoints.searchLimit)
                          .ceil(),
                      1),
                  onPageChange: (int index) {
                    currentPage.value = index;
                  },
                ),
              ],
            ),
          ),
          if (snapshot.connectionState == ConnectionState.waiting || isLoading)
            ...Styles.loadingOverlay
        ],
      ),
    );
  }
}
