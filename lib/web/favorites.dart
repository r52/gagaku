import 'package:flutter/material.dart';
import 'package:gagaku/ui.dart';
import 'package:gagaku/web/model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WebSourceFavorites extends HookConsumerWidget {
  const WebSourceFavorites({
    super.key,
    this.controller,
  });

  final ScrollController? controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final api = ref.watch(proxyProvider);

    final favProvider = ref.watch(webSourceFavoritesProvider);

    return Material(
      child: switch (favProvider) {
        AsyncValue(value: final list?) when list.isEmpty => const Center(
            child: Text('Add some favorites!'),
          ),
        AsyncValue(value: final list?) => Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Favorites',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
              Expanded(
                child: ReorderableListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(6),
                  scrollController: controller,
                  onReorder: (int oldIndex, int newIndex) => ref
                      .read(webSourceFavoritesProvider.notifier)
                      .updateList(oldIndex, newIndex),
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final item = list.elementAt(index);
                    return ListTile(
                      key: ValueKey(item.hashCode),
                      tileColor: index.isOdd
                          ? theme.colorScheme.surfaceContainer
                          : theme.colorScheme.surfaceContainerHighest,
                      leading: Consumer(
                        builder: (context, refx, child) {
                          final favorited =
                              ref.watch(webSourceFavoritesProvider.select(
                            (value) => switch (value) {
                              AsyncValue(value: final data?) =>
                                data.indexWhere((e) => e.url == item.url) > -1,
                              _ => null,
                            },
                          ));

                          if (favorited == null) {
                            return const CircularProgressIndicator();
                          }

                          return IconButton(
                            tooltip: favorited
                                ? 'Remove from Favorites'
                                : 'Add to Favorites',
                            icon: Icon(favorited
                                ? Icons.favorite
                                : Icons.favorite_border),
                            color: favorited ? theme.colorScheme.primary : null,
                            onPressed: () async {
                              if (favorited) {
                                ref
                                    .read(webSourceFavoritesProvider.notifier)
                                    .remove(item);
                              } else {
                                ref
                                    .read(webSourceFavoritesProvider.notifier)
                                    .add(item);
                              }
                            },
                          );
                        },
                      ),
                      title: Text(item.title),
                      textColor: Colors.blue,
                      onTap: () async {
                        final messenger = ScaffoldMessenger.of(context);
                        final parseResult = await api.handleUrl(
                            url: item.url, context: context);

                        if (!parseResult) {
                          messenger
                            ..removeCurrentSnackBar()
                            ..showSnackBar(const SnackBar(
                              content: Text('Unsupported URL'),
                              backgroundColor: Colors.red,
                            ));
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        AsyncValue(:final error?, :final stackTrace?) =>
          ErrorColumn(error: error, stackTrace: stackTrace),
        _ => const Center(
            child: CircularProgressIndicator(),
          ),
      },
    );
  }
}
