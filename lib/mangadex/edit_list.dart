import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/model/common.dart';
import 'package:gagaku/mangadex/model/model.dart';
import 'package:gagaku/mangadex/model/types.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:gagaku/routes.dart';
import 'package:gagaku/util/ui.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/experimental/scope.dart';

@Dependencies([chipTextStyle])
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
        AsyncValue(hasValue: true, value: final list) when list != null =>
          MangaDexEditListScreen(list: list),
        AsyncValue(hasValue: true, value: final list) when list == null =>
          Center(child: Text('Invalid listId $listId!')),
        AsyncValue(:final progress) => ListSpinner(
          progress: progress?.toDouble(),
        ),
      },
    );
  }
}

@Dependencies([chipTextStyle])
class MangaDexCreateListScreen extends MangaDexEditListScreen {
  const MangaDexCreateListScreen({super.key}) : super();
}

@Dependencies([chipTextStyle])
class MangaDexEditListScreen extends HookConsumerWidget {
  const MangaDexEditListScreen({super.key, this.listId, this.list});

  final String? listId;
  final CustomList? list;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tr = context.t;
    final messenger = ScaffoldMessenger.of(context);
    final me = ref.watch(loggedUserProvider).value;
    final listNameController = useTextEditingController(
      text: list?.attributes.name,
    );
    final scrollController = useScrollController();

    final visibility = useValueNotifier(
      list != null ? list!.attributes.visibility : CustomListVisibility.private,
    );

    final editList = ref.watch(userListModifyMutation(me?.id));
    final newList = ref.watch(userListNewMutation(me?.id));
    final isLoading = editList is MutationPending || newList is MutationPending;

    final selected = useReducer(
      MangaSetAction.modify,
      initialState: list != null ? {...list!.set} : <String>{},
      initialAction: MangaSetAction(action: MangaSetActions.none),
    );

    final currentPage = useValueNotifier(0);

    if (editList is MutationError) {
      Styles.showSnackBar(
        messenger,
        content: tr.mangadex.editListError(
          error: (editList as MutationError).error.toString(),
        ),
      );
    }

    if (newList is MutationError) {
      Styles.showSnackBar(
        messenger,
        content: tr.mangadex.newListError(
          error: (newList as MutationError).error.toString(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        flexibleSpace: TitleFlexBar(
          title: list != null ? tr.mangadex.editList : tr.mangadex.createList,
        ),
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
                        : listNameController.text.isNotEmpty,
                  );

                  return ElevatedButton(
                    style: Styles.buttonStyle(),
                    onPressed:
                        listNameChanged ||
                            (list != null &&
                                !setEquals(selected.state, list!.set)) ||
                            (list != null && vis != list!.attributes.visibility)
                        ? () async {
                            final messenger = ScaffoldMessenger.of(context);

                            if (listNameController.text.isNotEmpty) {
                              Future<CustomList?> success;

                              if (list != null) {
                                success = userListModifyMutation(me?.id).run(
                                  ref,
                                  (ref) async {
                                    return await ref
                                        .get(userListsProvider(me?.id).notifier)
                                        .editList(
                                          list!,
                                          listNameController.text,
                                          vis,
                                          selected.state,
                                        );
                                  },
                                );
                              } else {
                                success = userListNewMutation(me?.id).run(ref, (
                                  ref,
                                ) async {
                                  return await ref
                                      .get(userListsProvider(me?.id).notifier)
                                      .newList(
                                        listNameController.text,
                                        vis,
                                        selected.state,
                                      );
                                });
                              }

                              success.then((_) {
                                if (!context.mounted) return;
                                context.pop(true);
                              });
                            } else {
                              messenger
                                ..removeCurrentSnackBar()
                                ..showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      tr.mangadex.listNameEmptyWarning,
                                    ),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                            }
                          }
                        : null,
                    child: Text(list != null ? tr.ui.save : tr.ui.create),
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
              spacing: 12.0,
              children: [
                const SizedBox.shrink(),
                Row(
                  spacing: 12.0,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: listNameController,
                        decoration: InputDecoration(
                          filled: true,
                          labelText: tr.mangadex.listName,
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (String? value) {
                          return (value == null || value.isEmpty)
                              ? tr.mangadex.listNameEmptyWarning
                              : null;
                        },
                      ),
                    ),
                    DropdownMenu<CustomListVisibility>(
                      label: Text(tr.mangadex.visibility),
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
                          label: tr[CustomListVisibility.private.label],
                        ),
                        DropdownMenuEntry<CustomListVisibility>(
                          value: CustomListVisibility.public,
                          label: tr[CustomListVisibility.public.label],
                        ),
                      ],
                    ),
                  ],
                ),
                ElevatedButton(
                  style: Styles.buttonStyle(
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.primaryContainer,
                  ),
                  onPressed: () {
                    MangaDexSearchRoute(
                      selectMode: true,
                      selectedTitles: selected.state,
                    ).push<Set<String>>(context).then((result) {
                      if (result != null) {
                        selected.dispatch(
                          MangaSetAction(
                            action: MangaSetActions.replace,
                            replacement: result,
                          ),
                        );
                      }
                    });
                  },
                  child: Text(tr.mangadex.addTitles),
                ),
                Expanded(
                  child: HookConsumer(
                    builder: (context, ref, child) {
                      final page = useValueListenable(currentPage);
                      final data = useMemoized(
                        () => getMangaListByPage(ref, selected.state, page),
                        [selected.state, page],
                      );
                      final future = useFuture(data);

                      return MangaListWidget(
                        title: Text(
                          '${tr.titles} ${list != null ? '(${list!.set.length} > ${selected.state.length})' : '(${selected.state.length})'}',
                          style: CommonTextStyles.twentyfour,
                        ),
                        physics: const AlwaysScrollableScrollPhysics(),
                        controller: scrollController,
                        showToggle: false,
                        future: future,
                        children: [
                          if (future.hasData)
                            MangaListViewSliver(
                              items: future.data,
                              selectMode: true,
                              selectButton: (manga) {
                                return const Icon(Icons.remove);
                              },
                              onSelected: (manga) {
                                selected.dispatch(
                                  MangaSetAction(
                                    action: MangaSetActions.remove,
                                    element: manga.id,
                                  ),
                                );
                              },
                            ),
                        ],
                      );
                    },
                  ),
                ),
                HookBuilder(
                  builder: (context) {
                    final _ = useValueListenable(currentPage);
                    return NumberPaginator(
                      numberPages: max(
                        (selected.state.length / MangaDexEndpoints.searchLimit)
                            .ceil(),
                        1,
                      ),
                      onPageChange: (int index) {
                        scrollController.jumpTo(0.0);
                        currentPage.value = index;
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          if (isLoading) ...Styles.loadingOverlay,
        ],
      ),
    );
  }
}
