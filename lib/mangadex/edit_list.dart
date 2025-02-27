import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/mangadex/model/model.dart';
import 'package:gagaku/mangadex/model/types.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:gagaku/util/ui.dart';
import 'package:gagaku/util/util.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

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
    final me = ref.watch(loggedUserProvider).value;
    final id = useRef(list?.id ?? const Uuid().v4());
    final listNameController = useTextEditingController(text: list?.attributes.name);

    final visibility = useValueNotifier(list != null ? list!.attributes.visibility : CustomListVisibility.private);

    final editList = ref.watch(userListsProvider(me?.id).editList);
    final newList = ref.watch(userListsProvider(me?.id).newList);
    final isLoading = editList.state is PendingMutationState || newList.state is PendingMutationState;

    final selected = useReducer(MangaSetAction.modify,
        initialState: list != null ? {...list!.set} : <String>{},
        initialAction: MangaSetAction(action: MangaSetActions.none));

    ref.listen(userListsProvider(me?.id).editList, (_, edit) {
      if (edit.state is ErrorMutationState) {
        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text('mangadex.editListError'
                  .tr(context: context, args: [(edit.state as ErrorMutationState).error.toString()])),
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
              content: Text('mangadex.newListError'
                  .tr(context: context, args: [(state.state as ErrorMutationState).error.toString()])),
              backgroundColor: Colors.red,
            ),
          );
      }

      return;
    });

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
                              Future<List<CustomList>> success;

                              if (list != null) {
                                success = editList(list!, listNameController.text, vis, selected.state);
                              } else {
                                success = newList(listNameController.text, vis, selected.state);
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
                              ? 'mangadex.listNameEmptyWarning'.tr(context: context)
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
                    backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  onPressed: () {
                    context.push<Set<String>>('/search?selectMode=true', extra: selected.state).then((result) {
                      if (result != null) {
                        selected.dispatch(MangaSetAction(
                          action: MangaSetActions.replace,
                          replacement: result,
                        ));
                        ref.read(persistentMangaListPaginatorProvider(id.value).updateList)(selected.state);
                      }
                    });
                  },
                  child: Text('mangadex.addTitles'.tr(context: context)),
                ),
                Expanded(
                  child: HookConsumer(
                    builder: (context, ref, child) {
                      final titlesProvider = ref.watch(persistentMangaListPaginatorProvider(id.value));
                      final updateList = ref.watch(persistentMangaListPaginatorProvider(id.value).updateList);
                      final getPage = ref.watch(persistentMangaListPaginatorProvider(id.value).getPage);

                      useEffect(() {
                        Future.delayed(Duration.zero,
                            () => ref.read(persistentMangaListPaginatorProvider(id.value).updateList)(selected.state));

                        return null;
                      }, []);

                      return DataProviderWhenWidget(
                        provider: persistentMangaListPaginatorProvider(id.value),
                        data: titlesProvider,
                        builder: (context, mangas) => MangaListWidget(
                          title: Text(
                            '${'titles'.tr(context: context)} ${list != null ? '(${list!.set.length} > ${selected.state.length})' : '(${selected.state.length})'}',
                            style: const TextStyle(fontSize: 24),
                          ),
                          physics: const AlwaysScrollableScrollPhysics(),
                          showToggle: false,
                          isLoading: titlesProvider.isLoading ||
                              updateList.state is PendingMutationState ||
                              getPage.state is PendingMutationState,
                          children: [
                            MangaListViewSliver(
                              items: mangas,
                              selectMode: true,
                              selectButton: (manga) {
                                return const Icon(Icons.remove);
                              },
                              onSelected: (manga) {
                                selected.dispatch(MangaSetAction(
                                  action: MangaSetActions.remove,
                                  element: manga.id,
                                ));
                                ref.read(persistentMangaListPaginatorProvider(id.value).updateList)(selected.state);
                              },
                            ),
                          ],
                        ),
                        loadingWidget: const LoadingOverlayStack(),
                      );
                    },
                  ),
                ),
                HookBuilder(
                  builder: (context) {
                    final currentPage = useState(0);
                    return NumberPaginator(
                      numberPages: max((selected.state.length / MangaDexEndpoints.searchLimit).ceil(), 1),
                      onPageChange: (int index) {
                        currentPage.value = index;
                        ref.read(persistentMangaListPaginatorProvider(id.value).getPage)(index);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          if (isLoading) ...Styles.loadingOverlay
        ],
      ),
    );
  }
}
