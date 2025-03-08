import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/routes.gr.dart';
import 'package:gagaku/mangadex/model/model.dart';
import 'package:gagaku/mangadex/model/types.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:gagaku/util/ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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

@RoutePage()
class MangaDexCreateListScreen extends MangaDexEditListScreen {
  const MangaDexCreateListScreen({super.key}) : super();
}

@RoutePage()
class MangaDexEditListScreen extends HookConsumerWidget {
  const MangaDexEditListScreen({
    super.key,
    @PathParam() this.listId,
    this.list,
  });

  final String? listId;
  final CustomList? list;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = AutoRouter.of(context);
    final me = ref.watch(loggedUserProvider).value;
    final listNameController = useTextEditingController(
      text: list?.attributes.name,
    );

    final visibility = useValueNotifier(
      list != null ? list!.attributes.visibility : CustomListVisibility.private,
    );

    final editList = ref.watch(userListsProvider(me?.id).editList);
    final newList = ref.watch(userListsProvider(me?.id).newList);
    final isLoading =
        editList.state is PendingMutationState ||
        newList.state is PendingMutationState;

    final selected = useReducer(
      MangaSetAction.modify,
      initialState: list != null ? {...list!.set} : <String>{},
      initialAction: MangaSetAction(action: MangaSetActions.none),
    );

    final currentPage = useValueNotifier(0);

    ref.listen(userListsProvider(me?.id).editList, (_, edit) {
      if (edit.state is ErrorMutationState) {
        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(
                'mangadex.editListError'.tr(
                  context: context,
                  args: [(edit.state as ErrorMutationState).error.toString()],
                ),
              ),
              backgroundColor: Colors.red,
            ),
          );
      }

      return;
    });

    ref.listen(userListsProvider(me?.id).newList, (_, state) {
      if (state.state is ErrorMutationState) {
        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(
                'mangadex.newListError'.tr(
                  context: context,
                  args: [(state.state as ErrorMutationState).error.toString()],
                ),
              ),
              backgroundColor: Colors.red,
            ),
          );
      }

      return;
    });

    return Scaffold(
      appBar: AppBar(
        leading: AutoLeadingButton(),
        flexibleSpace: TitleFlexBar(
          title:
              list != null
                  ? 'mangadex.editList'.tr(context: context)
                  : 'mangadex.createList'.tr(context: context),
        ),
        actions: [
          OverflowBar(
            spacing: 8.0,
            children: [
              TextButton(
                style: Styles.buttonStyle(),
                child: const Text('Cancel'),
                onPressed: () {
                  context.maybePop();
                },
              ),
              HookBuilder(
                builder: (context) {
                  final vis = useValueListenable(visibility);
                  final listNameChanged = useListenableSelector(
                    listNameController,
                    () =>
                        list != null
                            ? listNameController.text != list!.attributes.name
                            : listNameController.text.isNotEmpty,
                  );

                  return ElevatedButton(
                    style: Styles.buttonStyle(),
                    onPressed:
                        listNameChanged ||
                                (list != null &&
                                    !setEquals(selected.state, list!.set)) ||
                                (list != null &&
                                    vis != list!.attributes.visibility)
                            ? () async {
                              final messenger = ScaffoldMessenger.of(context);

                              if (listNameController.text.isNotEmpty) {
                                Future<CustomList> success;

                                if (list != null) {
                                  success = editList(
                                    list!,
                                    listNameController.text,
                                    vis,
                                    selected.state,
                                  );
                                } else {
                                  success = newList(
                                    listNameController.text,
                                    vis,
                                    selected.state,
                                  );
                                }

                                success.then((_) {
                                  if (!context.mounted) return;
                                  context.maybePop(true);
                                });
                              } else {
                                messenger
                                  ..removeCurrentSnackBar()
                                  ..showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'mangadex.listNameEmptyWarning'.tr(
                                          context: context,
                                        ),
                                      ),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                              }
                            }
                            : null,
                    child: Text(
                      list != null
                          ? 'ui.save'.tr(context: context)
                          : 'ui.create'.tr(context: context),
                    ),
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
                          labelText: 'mangadex.listName'.tr(context: context),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (String? value) {
                          return (value == null || value.isEmpty)
                              ? 'mangadex.listNameEmptyWarning'.tr(
                                context: context,
                              )
                              : null;
                        },
                      ),
                    ),
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
                ElevatedButton(
                  style: Styles.buttonStyle(
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer,
                  ),
                  onPressed: () {
                    router
                        .push<Set<String>>(
                          MangaDexSearchRoute(
                            selectMode: true,
                            selectedTitles: selected.state,
                          ),
                        )
                        .then((result) {
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
                  child: Text('mangadex.addTitles'.tr(context: context)),
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
                          '${'titles'.tr(context: context)} ${list != null ? '(${list!.set.length} > ${selected.state.length})' : '(${selected.state.length})'}',
                          style: const TextStyle(fontSize: 24),
                        ),
                        physics: const AlwaysScrollableScrollPhysics(),
                        showToggle: false,
                        isLoading:
                            future.connectionState == ConnectionState.waiting ||
                            !future.hasData,
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
