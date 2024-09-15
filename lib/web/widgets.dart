import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/config.dart';
import 'package:gagaku/ui.dart';
import 'package:gagaku/web/model/model.dart';
import 'package:gagaku/web/model/types.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hooks_riverpod/legacy.dart';

enum WebMangaListView { grid, list }

final _mangaListViewProvider = StateProvider((ref) => WebMangaListView.grid);

class WebMangaListWidget extends HookConsumerWidget {
  const WebMangaListWidget({
    super.key,
    this.title,
    required this.children,
    this.leading = const <Widget>[],
    this.physics,
    this.onAtEdge,
    this.controller,
    this.noController = false,
    this.showToggle = true,
  });

  final Widget? title;
  final List<Widget> children;
  final List<Widget> leading;
  final ScrollPhysics? physics;
  final VoidCallback? onAtEdge;
  final ScrollController? controller;
  final bool noController;
  final bool showToggle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = controller ?? (noController ? null : useScrollController());
    final view = showToggle ? ref.watch(_mangaListViewProvider) : WebMangaListView.grid;

    useEffect(() {
      void controllerAtEdge() {
        if (scrollController != null &&
            onAtEdge != null &&
            scrollController.position.atEdge &&
            scrollController.position.pixels == scrollController.position.maxScrollExtent) {
          onAtEdge!();
        }
      }

      scrollController?.addListener(controllerAtEdge);
      return () => scrollController?.removeListener(controllerAtEdge);
    }, [scrollController]);

    return CustomScrollView(
      controller: scrollController,
      scrollBehavior: const MouseTouchScrollBehavior(),
      physics: physics,
      cacheExtent: MediaQuery.sizeOf(context).height,
      slivers: [
        ...leading,
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
            child: Row(
              children: [
                if (title != null) title!,
                const Spacer(),
                const GridExtentSlider(),
                if (showToggle)
                  SegmentedButton<WebMangaListView>(
                    showSelectedIcon: false,
                    style: SegmentedButton.styleFrom(shape: const RoundedRectangleBorder()),
                    segments: const <ButtonSegment<WebMangaListView>>[
                      ButtonSegment<WebMangaListView>(
                        value: WebMangaListView.grid,
                        icon: Icon(Icons.grid_view, size: 24),
                        tooltip: 'Grid view',
                      ),
                      ButtonSegment<WebMangaListView>(
                        value: WebMangaListView.list,
                        icon: Icon(Icons.table_rows, size: 24),
                        tooltip: 'List view',
                      ),
                    ],
                    selected: <WebMangaListView>{view},
                    onSelectionChanged: (Set<WebMangaListView> newSelection) {
                      ref.read(_mangaListViewProvider.notifier).state = newSelection.first;
                    },
                  ),
              ],
            ),
          ),
        ),
        ...children,
      ],
    );
  }
}

class WebMangaListViewSliver extends ConsumerWidget {
  const WebMangaListViewSliver({
    super.key,
    required this.items,
    required this.favoritesKey,
    this.reorderable = false,
    this.showRemoveButton = true,
  });

  final String favoritesKey;
  final List<HistoryLink> items;
  final bool reorderable;
  final bool showRemoveButton;

  int? _findChildIndexCb(Key? key) {
    final valueKey = key as ValueKey<int>;
    final val = items.indexWhere((i) => i.hashCode == valueKey.value);
    return val >= 0 ? val : null;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final api = ref.watch(proxyProvider);
    final view = ref.watch(_mangaListViewProvider);
    final gcfg = ref.watch(gagakuSettingsProvider);
    final theme = Theme.of(context);

    switch (view) {
      case WebMangaListView.list:
        return reorderable
            ? SliverReorderableList(
                onReorder: (int oldIndex, int newIndex) =>
                    ref.read(webSourceFavoritesProvider.notifier).updateList(favoritesKey, oldIndex, newIndex),
                itemCount: items.length,
                findChildIndexCallback: _findChildIndexCb,
                itemBuilder: (context, index) {
                  final item = items.elementAt(index);
                  return ReorderableDelayedDragStartListener(
                    key: ValueKey(item.hashCode),
                    index: index,
                    child: ListTile(
                      tileColor:
                          index.isOdd ? theme.colorScheme.surfaceContainer : theme.colorScheme.surfaceContainerHighest,
                      leading: Consumer(
                        builder: (context, refx, child) {
                          final favorited = ref.watch(webSourceFavoritesProvider.select(
                            (value) => switch (value) {
                              AsyncValue(value: final data?) => data.values.any((l) => l.contains(item)),
                              _ => null,
                            },
                          ));

                          if (favorited == null) {
                            return const CircularProgressIndicator();
                          }

                          return IconButton(
                            tooltip: favorited ? 'Remove from Favorites' : 'Add to Favorites',
                            icon: Icon(favorited ? Icons.favorite : Icons.favorite_border),
                            color: favorited ? theme.colorScheme.primary : null,
                            onPressed: () async {
                              if (favorited) {
                                ref.read(webSourceFavoritesProvider.notifier).remove(favoritesKey, item);
                              } else {
                                ref.read(webSourceFavoritesProvider.notifier).add(favoritesKey, item);
                              }
                            },
                          );
                        },
                      ),
                      title: Text(item.title),
                      textColor: Colors.blue,
                      onTap: () async {
                        final messenger = ScaffoldMessenger.of(context);
                        final parseResult = await api.handleUrl(url: item.url, context: context);

                        if (!parseResult) {
                          messenger
                            ..removeCurrentSnackBar()
                            ..showSnackBar(const SnackBar(
                              content: Text('Unsupported URL'),
                              backgroundColor: Colors.red,
                            ));
                        }
                      },
                    ),
                  );
                },
              )
            : SliverList.separated(
                itemCount: items.length,
                separatorBuilder: (_, __) => const SizedBox(
                  height: 4.0,
                ),
                findChildIndexCallback: _findChildIndexCb,
                itemBuilder: (context, index) {
                  final item = items.elementAt(index);
                  return ListTile(
                    key: ValueKey(item.hashCode),
                    tileColor:
                        index.isOdd ? theme.colorScheme.surfaceContainer : theme.colorScheme.surfaceContainerHighest,
                    leading: Consumer(
                      builder: (context, refx, child) {
                        final favorited = ref.watch(webSourceFavoritesProvider.select(
                          (value) => switch (value) {
                            AsyncValue(value: final data?) => data.values.any((l) => l.contains(item)),
                            _ => null,
                          },
                        ));

                        if (favorited == null) {
                          return const CircularProgressIndicator();
                        }

                        return IconButton(
                          tooltip: favorited ? 'Remove from Favorites' : 'Add to Favorites',
                          icon: Icon(favorited ? Icons.favorite : Icons.favorite_border),
                          color: favorited ? theme.colorScheme.primary : null,
                          onPressed: () async {
                            if (favorited) {
                              ref.read(webSourceFavoritesProvider.notifier).remove(favoritesKey, item);
                            } else {
                              ref.read(webSourceFavoritesProvider.notifier).add(favoritesKey, item);
                            }
                          },
                        );
                      },
                    ),
                    trailing: IconButton(
                      tooltip: 'Remove from History',
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () async {
                        ref.read(webSourceHistoryProvider.notifier).remove(item);
                      },
                    ),
                    title: Text(item.title),
                    textColor: Colors.blue,
                    onTap: () async {
                      final messenger = ScaffoldMessenger.of(context);
                      final parseResult = await api.handleUrl(url: item.url, context: context);

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
              );

      case WebMangaListView.grid:
      default:
        return SliverGrid.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: gcfg.gridAlbumExtent.grid,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 0.7,
          ),
          findChildIndexCallback: _findChildIndexCb,
          itemBuilder: (context, index) {
            final item = items.elementAt(index);
            return GridMangaItem(
              key: ValueKey(item.hashCode),
              link: item,
              favoritesKey: favoritesKey,
              showRemoveButton: showRemoveButton,
            );
          },
          itemCount: items.length,
        );
    }
  }
}

class GridMangaItem extends HookConsumerWidget {
  const GridMangaItem({
    super.key,
    required this.link,
    required this.favoritesKey,
    this.showFavoriteButton = true,
    this.showRemoveButton = true,
  });

  final String favoritesKey;
  final HistoryLink link;
  final bool showFavoriteButton;
  final bool showRemoveButton;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();
    final api = ref.watch(proxyProvider);
    final aniController = useAnimationController(duration: const Duration(milliseconds: 100));
    final gradient = useAnimation(aniController.drive(Styles.coverArtGradientTween));
    final theme = Theme.of(context);

    final image = GridAlbumImage(
      gradient: gradient,
      child: link.cover != null
          ? CachedNetworkImage(
              imageUrl: link.cover!,
              width: 256.0,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.cover,
            )
          : const Icon(
              Icons.menu_book,
              size: 128.0,
            ),
    );

    return InkWell(
      onTap: () async {
        final messenger = ScaffoldMessenger.of(context);
        final parseResult = await api.handleUrl(url: link.url, context: context);

        if (!parseResult) {
          messenger
            ..removeCurrentSnackBar()
            ..showSnackBar(const SnackBar(
              content: Text('Unsupported URL'),
              backgroundColor: Colors.red,
            ));
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
            footer: GridAlbumTextBar(
              height: 80,
              text: link.title,
            ),
            child: image,
          ),
          if (showFavoriteButton)
            Align(
              alignment: Alignment.topLeft,
              child: Consumer(
                builder: (context, refx, child) {
                  final favorited = ref.watch(webSourceFavoritesProvider.select(
                    (value) => switch (value) {
                      AsyncValue(value: final data?) => data.values.any((l) => l.contains(link)),
                      _ => null,
                    },
                  ));

                  if (favorited == null) {
                    return const CircularProgressIndicator();
                  }

                  return FloatingActionButton(
                    heroTag: UniqueKey(),
                    mini: true,
                    shape: const CircleBorder(),
                    tooltip: favorited ? 'Remove from Favorites' : 'Add to Favorites',
                    onPressed: () async {
                      if (favorited) {
                        ref.read(webSourceFavoritesProvider.notifier).remove(favoritesKey, link);
                      } else {
                        ref.read(webSourceFavoritesProvider.notifier).add(favoritesKey, link);
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
                tooltip: 'Remove from History',
                onPressed: () async {
                  ref.read(webSourceHistoryProvider.notifier).remove(link);
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
