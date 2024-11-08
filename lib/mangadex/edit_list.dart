import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/mangadex/model.dart';
import 'package:gagaku/mangadex/types.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:gagaku/util/ui.dart';
import 'package:gagaku/util/util.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:number_paginator/number_paginator.dart';

Page<dynamic> buildListEditPage(BuildContext context, GoRouterState state) {
  final list = state.extra.asOrNull<CustomList>();

  Widget child;

  if (list != null) {
    child = MangaDexEditListScreen(
      list: list,
    );
  } else {
    child = QueriedMangaDexEditListScreen(listId: state.pathParameters['listId']!);
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
    final listProvider = ref.watch(listSourceProvider(listId));

    return Scaffold(
      body: switch (listProvider) {
        AsyncValue(:final error?, :final stackTrace?) => ErrorList(
            error: error,
            stackTrace: stackTrace,
            message: "_fetchListFromIdProvider($listId) failed",
          ),
        AsyncValue(hasValue: true, value: final list) when list != null => MangaDexEditListScreen(
            list: list,
          ),
        AsyncValue(hasValue: true, value: final list) when list == null => Center(
            child: Text('Invalid listId $listId!'),
          ),
        AsyncValue(:final progress) => ListSpinner(
            progress: progress?.toDouble(),
          ),
      },
    );
  }
}

class MangaDexEditListScreen extends HookConsumerWidget {
  const MangaDexEditListScreen({super.key, this.list});

  final CustomList? list;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listNameController = useTextEditingController(text: list?.attributes.name);

    final visibility = useValueNotifier(list != null ? list!.attributes.visibility : CustomListVisibility.private);

    final pendingAction = useState<Future<bool>?>(null);
    final snapshot = useFuture(pendingAction.value);

    final selected = useReducer(MangaSetAction.modify,
        initialState: list != null ? {...list!.set} : <String>{},
        initialAction: MangaSetAction(action: MangaSetActions.none));
    final currentPage = useState(0);

    final titlesProvider = ref.watch(getMangaListByPageProvider(selected.state, currentPage.value));
    final titles = titlesProvider.value;

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
        flexibleSpace: TitleFlexBar(
            title:
                list != null ? 'mangadex.editList'.tr(context: context) : 'mangadex.createList'.tr(context: context)),
        actions: [
          OverflowBar(
            spacing: 8.0,
            children: [
              TextButton(
                style: Styles.buttonStyle(),
                child: const Text('Cancel'),
                onPressed: () {
                  context.pop();
                },
              ),
              HookBuilder(
                builder: (context) {
                  final vis = useValueListenable(visibility);
                  final listNameChanged = useListenableSelector(
                      listNameController,
                      () => list != null
                          ? listNameController.text != list!.attributes.name
                          : listNameController.text.isNotEmpty);

                  return ElevatedButton(
                    style: Styles.buttonStyle(),
                    onPressed: listNameChanged ||
                            (list != null && !setEquals(selected.state, list!.set)) ||
                            (list != null && vis != list!.attributes.visibility)
                        ? () async {
                            final messenger = ScaffoldMessenger.of(context);

                            if (listNameController.text.isNotEmpty) {
                              Future<bool> success;

                              if (list != null) {
                                success = ref
                                    .read(userListsProvider.notifier)
                                    .editList(list!, listNameController.text, vis, selected.state);
                              } else {
                                success = ref
                                    .read(userListsProvider.notifier)
                                    .newList(listNameController.text, vis, selected.state);
                              }

                              success.then((success) {
                                if (!context.mounted) return;
                                if (success) {
                                  context.pop(true);
                                } else {
                                  messenger
                                    ..removeCurrentSnackBar()
                                    ..showSnackBar(
                                      SnackBar(
                                        content: Text(list != null
                                            ? 'mangadex.editListError'.tr(context: context)
                                            : 'mangadex.newListError'.tr(context: context)),
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
                                  SnackBar(
                                    content: Text('mangadex.listNameEmptyWarning'.tr(context: context)),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                            }
                          }
                        : null,
                    child: Text(list != null ? 'ui.save'.tr(context: context) : 'ui.create'.tr(context: context)),
                  );
                },
              ),
              const SizedBox.shrink(),
            ],
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
                        decoration: InputDecoration(
                          filled: true,
                          labelText: 'mangadex.listName'.tr(context: context),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (String? value) {
                          return (value == null || value.isEmpty)
                              ? 'mangadex.listNameEmptyWarning'.tr(context: context)
                              : null;
                        },
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    DropdownMenu<CustomListVisibility>(
                      label: Text('mangadex.visibility'.tr(context: context)),
                      initialSelection: visibility.value,
                      enableFilter: false,
                      enableSearch: false,
                      requestFocusOnTap: false,
                      onSelected: (v) {
                        if (v != null) {
                          visibility.value = v;
                        }
                      },
                      dropdownMenuEntries: [
                        DropdownMenuEntry<CustomListVisibility>(
                          value: CustomListVisibility.private,
                          label: context.tr(CustomListVisibility.private.label),
                        ),
                        DropdownMenuEntry<CustomListVisibility>(
                          value: CustomListVisibility.public,
                          label: context.tr(CustomListVisibility.public.label),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12.0),
                ElevatedButton(
                  style: Styles.buttonStyle(
                    backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  onPressed: () {
                    context.push<Set<String>>('/search?selectMode=true', extra: selected.state).then((result) {
                      if (result != null) {
                        selected.dispatch(MangaSetAction(
                          action: MangaSetActions.replace,
                          replacement: result,
                        ));
                      }
                    });
                  },
                  child: Text('mangadex.addTitles'.tr(context: context)),
                ),
                const SizedBox(height: 12.0),
                Expanded(
                  child: MangaListWidget(
                    title: Text(
                      '${'titles'.tr(context: context)} ${list != null ? '(${list!.set.length} > ${selected.state.length})' : '(${selected.state.length})'}',
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
                            selected.dispatch(MangaSetAction(
                              action: MangaSetActions.remove,
                              element: manga.id,
                            ));
                          },
                        ),
                    ],
                  ),
                ),
                NumberPaginator(
                  numberPages: max((selected.state.length / MangaDexEndpoints.searchLimit).ceil(), 1),
                  onPageChange: (int index) {
                    currentPage.value = index;
                  },
                ),
              ],
            ),
          ),
          if (snapshot.connectionState == ConnectionState.waiting || isLoading) ...Styles.loadingOverlay
        ],
      ),
    );
  }
}
