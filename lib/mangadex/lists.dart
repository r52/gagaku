import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/mangadex/model.dart';
import 'package:gagaku/mangadex/types.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:gagaku/model.dart';
import 'package:gagaku/ui.dart';
import 'package:gagaku/util.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum _ListViewType { self, followed }

enum _ListActions { follow, delete, edit }

class MangaDexListsView extends HookConsumerWidget {
  const MangaDexListsView({
    super.key,
    this.controller,
  });

  final ScrollController? controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = controller ?? useScrollController();
    final theme = Theme.of(context);
    //final view = useState(_ListViewType.self);
    final userListsProv = ref.watch(userListsProvider);

    useEffect(() {
      void controllerAtEdge() {
        if (scrollController.position.atEdge &&
            scrollController.position.pixels ==
                scrollController.position.maxScrollExtent) {
          ref.read(userListsProvider.notifier).getMore();
        }
      }

      scrollController.addListener(controllerAtEdge);
      return () => scrollController.removeListener(controllerAtEdge);
    }, [scrollController]);

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          tooltip: 'New List',
          icon: const Icon(Icons.playlist_add),
          label: const Text('New List'),
          onPressed: () {
            final messenger = ScaffoldMessenger.of(context);
            context.push<bool>(GagakuRoute.listCreate).then((success) {
              if (success == true) {
                messenger
                  ..removeCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(
                      content: Text('New list created.'),
                      backgroundColor: Colors.green,
                    ),
                  );
              }
            });
          }),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
              child: Row(
                children: [
                  Text(
                    'My Lists',
                    style: TextStyle(fontSize: 24),
                  ),
                  Spacer(),
                  // ToggleButtons(
                  //   isSelected: List<bool>.generate(
                  //       2, (index) => view.value.index == index),
                  //   onPressed: (index) {
                  //     view.value = _ListViewType.values.elementAt(index);
                  //   },
                  //   borderRadius: const BorderRadius.all(Radius.circular(2.0)),
                  //   children: const [
                  //     Padding(
                  //       padding: EdgeInsets.symmetric(horizontal: 5.0),
                  //       child: Text('My Lists'),
                  //     ),
                  //     Padding(
                  //       padding: EdgeInsets.symmetric(horizontal: 5.0),
                  //       child: Text('Followed Lists'),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
            Expanded(
              child: switch (userListsProv) {
                AsyncValue(:final error?, :final stackTrace?) => () {
                    final messenger = ScaffoldMessenger.of(context);
                    Styles.showErrorSnackBar(messenger, '$error');
                    logger.e("userListsProvider failed",
                        error: error, stackTrace: stackTrace);

                    return RefreshIndicator(
                      onRefresh: () => ref.refresh(userListsProvider.future),
                      child: Styles.errorList(error, stackTrace),
                    );
                  }(),
                AsyncValue(:final value?) => () {
                    if (value.isEmpty) {
                      return const Text('No lists!');
                    }

                    return RefreshIndicator(
                      onRefresh: () {
                        ref.read(userListsProvider.notifier).clear();
                        return ref.refresh(userListsProvider.future);
                      },
                      child: ScrollConfiguration(
                        behavior: MouseTouchScrollBehavior(),
                        child: ListView.builder(
                          controller: controller,
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(6),
                          itemCount: value.length,
                          itemBuilder: (BuildContext context, int index) {
                            final messenger = ScaffoldMessenger.of(context);
                            final listref = value.elementAt(index);
                            final item = listref.get<CustomList>();

                            return Card(
                              child: ListTile(
                                leading: Tooltip(
                                    message: item.attributes.visibility.name
                                        .capitalize(),
                                    child: Icon(
                                      Icons.circle,
                                      size: 16.0,
                                      color: item.attributes.visibility ==
                                              CustomListVisibility.private
                                          ? Colors.red
                                          : Colors.green,
                                    )),
                                title: Text(item.attributes.name),
                                subtitle: Text('${item.set.length} items'),
                                trailing: PopupMenuButton<_ListActions>(
                                  padding: EdgeInsets.zero,
                                  onSelected: (value) async {
                                    switch (value) {
                                      case _ListActions.delete:
                                        final result =
                                            await showDeleteListDialog(
                                                context, item.attributes.name);
                                        if (result == true) {
                                          ref
                                              .read(userListsProvider.notifier)
                                              .deleteList(listref)
                                              .then((success) {
                                            if (success == true) {
                                              messenger
                                                ..removeCurrentSnackBar()
                                                ..showSnackBar(
                                                  const SnackBar(
                                                    content:
                                                        Text('List deleted.'),
                                                    backgroundColor:
                                                        Colors.green,
                                                  ),
                                                );
                                            } else {
                                              messenger
                                                ..removeCurrentSnackBar()
                                                ..showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                        'Failed to delete list.'),
                                                    backgroundColor: Colors.red,
                                                  ),
                                                );
                                            }
                                          });
                                        }
                                        break;
                                      case _ListActions.edit:
                                        context.push('/list/edit/${item.id}',
                                            extra: listref);
                                        break;
                                      default:
                                        break;
                                    }
                                  },
                                  itemBuilder: (context) => [
                                    // const PopupMenuItem(
                                    //   value: _ListActions.follow,
                                    //   child: Text(
                                    //     'Follow',
                                    //   ),
                                    // ),
                                    const PopupMenuItem(
                                      value: _ListActions.delete,
                                      child: Text(
                                        'Delete',
                                      ),
                                    ),
                                    const PopupMenuItem(
                                      value: _ListActions.edit,
                                      child: Text(
                                        'Edit',
                                      ),
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  context.push('/list/${item.id}',
                                      extra: listref);
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  }(),
                _ => const Stack(
                    children: Styles.loadingOverlay,
                  ),
              },
            ),
          ],
        ),
      ),
    );
  }
}
