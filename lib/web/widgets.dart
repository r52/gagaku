import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/model/config.dart';
import 'package:gagaku/util/cached_network_image.dart';
import 'package:gagaku/util/ui.dart';
import 'package:gagaku/web/model/model.dart';
import 'package:gagaku/web/model/types.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'widgets.g.dart';

enum WebMangaListView { grid, list }

@Riverpod(keepAlive: true)
class _MangaListView extends _$MangaListView {
  @override
  WebMangaListView build() => WebMangaListView.grid;

  @override
  set state(WebMangaListView newState) => super.state = newState;
  WebMangaListView update(
    WebMangaListView Function(WebMangaListView state) cb,
  ) => state = cb(state);
}

class WebMangaListWidget extends HookConsumerWidget {
  const WebMangaListWidget({
    super.key,
    this.title,
    required this.children,
    this.leading = const <Widget>[],
    this.physics,
    this.controller,
    this.noController = false,
    this.showToggle = true,
    this.isLoading = false,
  });

  final Widget? title;
  final List<Widget> children;
  final List<Widget> leading;
  final ScrollPhysics? physics;
  final ScrollController? controller;
  final bool noController;
  final bool showToggle;
  final bool isLoading;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tr = context.t;
    final scrollController =
        controller ?? (noController ? null : useScrollController());
    final view =
        showToggle ? ref.watch(_mangaListViewProvider) : WebMangaListView.grid;

    return Stack(
      children: [
        CustomScrollView(
          controller: scrollController,
          scrollBehavior: const MouseTouchScrollBehavior(),
          physics: physics,
          cacheExtent: MediaQuery.sizeOf(context).height,
          slivers: [
            ...leading,
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 10.0,
                ),
                child: Row(
                  children: [
                    if (title != null) title!,
                    const Spacer(),
                    const GridExtentSlider(),
                    if (showToggle)
                      SegmentedButton<WebMangaListView>(
                        showSelectedIcon: false,
                        style: SegmentedButton.styleFrom(
                          shape: const RoundedRectangleBorder(),
                        ),
                        segments: <ButtonSegment<WebMangaListView>>[
                          ButtonSegment<WebMangaListView>(
                            value: WebMangaListView.grid,
                            icon: Icon(Icons.grid_view, size: 24),
                            tooltip: tr.ui.gridView,
                          ),
                          ButtonSegment<WebMangaListView>(
                            value: WebMangaListView.list,
                            icon: Icon(Icons.table_rows, size: 24),
                            tooltip: tr.ui.listView,
                          ),
                        ],
                        selected: <WebMangaListView>{view},
                        onSelectionChanged: (
                          Set<WebMangaListView> newSelection,
                        ) {
                          ref.read(_mangaListViewProvider.notifier).state =
                              newSelection.first;
                        },
                      ),
                  ],
                ),
              ),
            ),
            ...children,
          ],
        ),
        if (isLoading) ...Styles.loadingOverlay,
      ],
    );
  }
}

class WebMangaListViewSliver extends ConsumerWidget {
  const WebMangaListViewSliver({
    super.key,
    this.items,
    this.controller,
    required this.favoritesKey,
    this.reorderable = false,
    this.showRemoveButton = true,
    this.removeFromAll = false,
  }) : assert(items != null || controller != null);

  final String favoritesKey;
  final List<HistoryLink>? items;
  final bool reorderable;
  final bool showRemoveButton;
  final bool
  removeFromAll; // Unfavoriting an item removes the item from all categories?

  final PagingController<dynamic, HistoryLink>? controller;

  int? _findChildIndexCb(Key? key) {
    final valueKey = key as ValueKey<int>;
    final val = items!.indexWhere((i) => i.hashCode == valueKey.value);
    return val >= 0 ? val : null;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final api = ref.watch(proxyProvider);
    final view = ref.watch(_mangaListViewProvider);
    final gridExtent = ref.watch(
      gagakuSettingsProvider.select((c) => c.gridAlbumExtent),
    );
    final theme = Theme.of(context);

    final addFavorite = ref.watch(webSourceFavoritesProvider.add);
    final removeFavorite = ref.watch(webSourceFavoritesProvider.remove);

    if (items != null) {
      switch (view) {
        case WebMangaListView.list:
          return reorderable
              ? SliverReorderableList(
                onReorder:
                    (int oldIndex, int newIndex) => ref.read(
                      webSourceFavoritesProvider.updateList,
                    )(favoritesKey, oldIndex, newIndex),
                itemCount: items!.length,
                findChildIndexCallback: _findChildIndexCb,
                itemBuilder: (context, index) {
                  final item = items!.elementAt(index);
                  return ReorderableDelayedDragStartListener(
                    key: ValueKey(item.hashCode),
                    index: index,
                    child: ListTile(
                      tileColor:
                          index.isOdd
                              ? theme.colorScheme.surfaceContainer
                              : theme.colorScheme.surfaceContainerHighest,
                      leading: Consumer(
                        builder: (context, refx, child) {
                          final tr = context.t;
                          final favorited = ref.watch(
                            webSourceFavoritesProvider.select(
                              (value) => switch (value) {
                                AsyncValue(value: final data?) => data.values
                                    .any((l) => l.contains(item)),
                                _ => null,
                              },
                            ),
                          );

                          if (favorited == null) {
                            return const CircularProgressIndicator();
                          }

                          return IconButton(
                            tooltip:
                                favorited
                                    ? tr.mangaActions.unfavorite
                                    : tr.mangaActions.favorite,
                            icon: Icon(
                              favorited
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                            ),
                            color: favorited ? theme.colorScheme.primary : null,
                            onPressed: () async {
                              if (favorited) {
                                removeFavorite(
                                  removeFromAll ? 'all' : favoritesKey,
                                  item,
                                );
                              } else {
                                addFavorite(favoritesKey, item);
                              }
                            },
                          );
                        },
                      ),
                      title: Text(item.title),
                      textColor: Colors.blue,
                      onTap: () async {
                        final tr = context.t;
                        final messenger = ScaffoldMessenger.of(context);
                        final parseResult = await api.handleUrl(
                          url: item.url,
                          context: context,
                        );

                        if (!context.mounted) return;
                        if (!parseResult) {
                          messenger
                            ..removeCurrentSnackBar()
                            ..showSnackBar(
                              SnackBar(
                                content: Text(tr.errors.unsupportedUrl),
                                backgroundColor: Colors.red,
                              ),
                            );
                        }
                      },
                    ),
                  );
                },
              )
              : SliverList.separated(
                itemCount: items!.length,
                separatorBuilder: (_, __) => const SizedBox(height: 4.0),
                findChildIndexCallback: _findChildIndexCb,
                itemBuilder: (context, index) {
                  final tr = context.t;
                  final item = items!.elementAt(index);
                  return ListTile(
                    key: ValueKey(item.hashCode),
                    tileColor:
                        index.isOdd
                            ? theme.colorScheme.surfaceContainer
                            : theme.colorScheme.surfaceContainerHighest,
                    leading: Consumer(
                      builder: (context, refx, child) {
                        final favorited = ref.watch(
                          webSourceFavoritesProvider.select(
                            (value) => switch (value) {
                              AsyncValue(value: final data?) => data.values.any(
                                (l) => l.contains(item),
                              ),
                              _ => null,
                            },
                          ),
                        );

                        if (favorited == null) {
                          return const CircularProgressIndicator();
                        }

                        return IconButton(
                          tooltip:
                              favorited
                                  ? tr.mangaActions.unfavorite
                                  : tr.mangaActions.favorite,
                          icon: Icon(
                            favorited ? Icons.favorite : Icons.favorite_border,
                          ),
                          color: favorited ? theme.colorScheme.primary : null,
                          onPressed: () async {
                            if (favorited) {
                              removeFavorite(
                                removeFromAll ? 'all' : favoritesKey,
                                item,
                              );
                            } else {
                              addFavorite(favoritesKey, item);
                            }
                          },
                        );
                      },
                    ),
                    trailing: IconButton(
                      tooltip: tr.mangaActions.removeHistory,
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        ref.read(webSourceHistoryProvider.remove)(item);
                      },
                    ),
                    title: Text(item.title),
                    textColor: Colors.blue,
                    onTap: () async {
                      final tr = context.t;
                      final messenger = ScaffoldMessenger.of(context);
                      final parseResult = await api.handleUrl(
                        url: item.url,
                        context: context,
                      );

                      if (!context.mounted) return;
                      if (!parseResult) {
                        messenger
                          ..removeCurrentSnackBar()
                          ..showSnackBar(
                            SnackBar(
                              content: Text(tr.errors.unsupportedUrl),
                              backgroundColor: Colors.red,
                            ),
                          );
                      }
                    },
                  );
                },
              );

        case WebMangaListView.grid:
          return SliverGrid.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: gridExtent.grid,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 0.7,
            ),
            findChildIndexCallback: _findChildIndexCb,
            itemBuilder: (context, index) {
              final item = items!.elementAt(index);
              return GridMangaItem(
                key: ValueKey(item.hashCode),
                link: item,
                favoritesKey: favoritesKey,
                showRemoveButton: showRemoveButton,
                removeFromAll: removeFromAll,
              );
            },
            itemCount: items!.length,
          );
      }
    }

    return PagingListener(
      controller: controller!,
      builder: (context, state, fetchNextPage) {
        switch (view) {
          case WebMangaListView.list:
            return PagedSliverList.separated(
              state: state,
              fetchNextPage: fetchNextPage,
              separatorBuilder: (_, __) => const SizedBox(height: 4.0),
              builderDelegate: PagedChildBuilderDelegate<HistoryLink>(
                animateTransitions: true,
                itemBuilder: (context, item, index) {
                  final tr = context.t;
                  return ListTile(
                    key: ValueKey(item.hashCode),
                    tileColor:
                        index.isOdd
                            ? theme.colorScheme.surfaceContainer
                            : theme.colorScheme.surfaceContainerHighest,
                    leading: Consumer(
                      builder: (context, refx, child) {
                        final favorited = ref.watch(
                          webSourceFavoritesProvider.select(
                            (value) => switch (value) {
                              AsyncValue(value: final data?) => data.values.any(
                                (l) => l.contains(item),
                              ),
                              _ => null,
                            },
                          ),
                        );

                        if (favorited == null) {
                          return const CircularProgressIndicator();
                        }

                        return IconButton(
                          tooltip:
                              favorited
                                  ? tr.mangaActions.unfavorite
                                  : tr.mangaActions.favorite,
                          icon: Icon(
                            favorited ? Icons.favorite : Icons.favorite_border,
                          ),
                          color: favorited ? theme.colorScheme.primary : null,
                          onPressed: () async {
                            if (favorited) {
                              removeFavorite(
                                removeFromAll ? 'all' : favoritesKey,
                                item,
                              );
                            } else {
                              addFavorite(favoritesKey, item);
                            }
                          },
                        );
                      },
                    ),
                    trailing: IconButton(
                      tooltip: tr.mangaActions.removeHistory,
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        ref.read(webSourceHistoryProvider.remove)(item);
                      },
                    ),
                    title: Text(item.title),
                    textColor: Colors.blue,
                    onTap: () async {
                      final tr = context.t;
                      final messenger = ScaffoldMessenger.of(context);
                      final parseResult = await api.handleUrl(
                        url: item.url,
                        context: context,
                      );

                      if (!context.mounted) return;
                      if (!parseResult) {
                        messenger
                          ..removeCurrentSnackBar()
                          ..showSnackBar(
                            SnackBar(
                              content: Text(tr.errors.unsupportedUrl),
                              backgroundColor: Colors.red,
                            ),
                          );
                      }
                    },
                  );
                },
              ),
            );
          case WebMangaListView.grid:
            return PagedSliverGrid(
              state: state,
              fetchNextPage: fetchNextPage,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: gridExtent.grid,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 0.7,
              ),
              builderDelegate: PagedChildBuilderDelegate<HistoryLink>(
                animateTransitions: true,
                itemBuilder: (context, item, index) {
                  return GridMangaItem(
                    key: ValueKey(item.hashCode),
                    link: item,
                    favoritesKey: favoritesKey,
                    showRemoveButton: showRemoveButton,
                    removeFromAll: removeFromAll,
                  );
                },
              ),
            );
        }
      },
    );
  }
}

class GridMangaItem extends HookConsumerWidget {
  const GridMangaItem({
    super.key,
    required this.link,
    required this.favoritesKey,
    this.showFavoriteButton = true,
    this.showRemoveButton = true,
    this.removeFromAll = false,
  });

  final String favoritesKey;
  final HistoryLink link;
  final bool showFavoriteButton;
  final bool showRemoveButton;
  final bool
  removeFromAll; // Unfavoriting an item removes the item from all categories?

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tr = context.t;
    useAutomaticKeepAlive();
    final api = ref.watch(proxyProvider);
    final aniController = useAnimationController(
      duration: const Duration(milliseconds: 100),
    );
    final gradient = useAnimation(
      aniController.drive(Styles.coverArtGradientTween),
    );
    final theme = Theme.of(context);

    final image = GridAlbumImage(
      gradient: gradient,
      child:
          link.cover != null
              ? CachedNetworkImage(
                imageUrl: link.cover!,
                cacheManager: gagakuImageCache,
                width: 256.0,
                progressIndicatorBuilder:
                    (context, url, downloadProgress) =>
                        const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.cover,
              )
              : const Icon(Icons.menu_book, size: 128.0),
    );

    return InkWell(
      onTap: () async {
        final messenger = ScaffoldMessenger.of(context);
        final parseResult = await api.handleUrl(
          url: link.url,
          context: context,
        );

        if (!context.mounted) return;
        if (!parseResult) {
          messenger
            ..removeCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(tr.errors.unsupportedUrl),
                backgroundColor: Colors.red,
              ),
            );
        }
      },
      onHover: (hovering) {
        if (hovering) {
          aniController.forward();
        } else {
          aniController.reverse();
        }
      },
      child: Stack(
        children: [
          GridTile(
            footer: GridAlbumTextBar(height: 80, text: link.title),
            child: image,
          ),
          if (showFavoriteButton)
            Align(
              alignment: Alignment.topLeft,
              child: Consumer(
                builder: (context, refx, child) {
                  final favorited = ref.watch(
                    webSourceFavoritesProvider.select(
                      (value) => switch (value) {
                        AsyncValue(value: final data?) => data.values.any(
                          (l) => l.contains(link),
                        ),
                        _ => null,
                      },
                    ),
                  );

                  if (favorited == null) {
                    return const CircularProgressIndicator();
                  }

                  return FloatingActionButton(
                    heroTag: UniqueKey(),
                    mini: true,
                    shape: const CircleBorder(),
                    tooltip:
                        favorited
                            ? tr.mangaActions.unfavorite
                            : tr.mangaActions.favorite,
                    onPressed: () async {
                      if (favorited) {
                        ref.read(webSourceFavoritesProvider.remove)(
                          removeFromAll ? 'all' : favoritesKey,
                          link,
                        );
                      } else {
                        ref.read(webSourceFavoritesProvider.add)(
                          favoritesKey,
                          link,
                        );
                      }
                    },
                    child: Icon(
                      favorited ? Icons.favorite : Icons.favorite_border,
                    ),
                  );
                },
              ),
            ),
          if (showRemoveButton)
            Align(
              alignment: Alignment.topRight,
              child: FloatingActionButton(
                heroTag: UniqueKey(),
                mini: true,
                shape: const CircleBorder(),
                tooltip: tr.mangaActions.removeHistory,
                onPressed: () async {
                  ref.read(webSourceHistoryProvider.remove)(link);
                },
                backgroundColor: theme.colorScheme.errorContainer,
                child: Icon(
                  Icons.delete,
                  color: theme.colorScheme.onErrorContainer,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
