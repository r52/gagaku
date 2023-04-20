import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/mangadex/manga_view.dart';
import 'package:gagaku/ui.dart';
import 'package:gagaku/util.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'types.dart';

enum MangaListView { grid, list, detailed }

final mangaListViewProvider = StateProvider((ref) => MangaListView.grid);

class MangaListWidget extends HookConsumerWidget {
  const MangaListWidget({
    Key? key,
    required this.title,
    required this.items,
    this.leading = const <Widget>[],
    this.physics,
    this.onAtEdge,
  }) : super(key: key);

  final Widget title;
  final Iterable<Manga> items;
  final List<Widget> leading;
  final ScrollPhysics? physics;
  final VoidCallback? onAtEdge;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();
    final view = ref.watch(mangaListViewProvider);

    useEffect(() {
      void controllerAtEdge() {
        if (onAtEdge != null && scrollController.position.atEdge) {
          if (scrollController.position.pixels != 0) {
            onAtEdge!();
          }
        }
      }

      scrollController.addListener(controllerAtEdge);
      return () => scrollController.removeListener(controllerAtEdge);
    }, [scrollController]);

    return CustomScrollView(
      controller: scrollController,
      scrollBehavior: MouseTouchScrollBehavior(),
      physics: physics,
      slivers: [
        ...leading,
        SliverToBoxAdapter(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
            child: Row(
              children: [
                title,
                const Spacer(),
                ToggleButtons(
                  isSelected: List<bool>.generate(MangaListView.values.length,
                      (index) => view.index == index),
                  onPressed: (index) {
                    ref.read(mangaListViewProvider.notifier).state =
                        MangaListView.values.elementAt(index);
                  },
                  children: const [
                    Icon(
                      Icons.grid_view,
                    ),
                    Icon(
                      Icons.table_rows,
                    ),
                    Icon(
                      Icons.view_list,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        (() {
          switch (view) {
            case MangaListView.list:
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    var manga = items.elementAt(index);

                    return _ListMangaItem(
                      manga: manga,
                    );
                  },
                  childCount: items.length,
                ),
              );
            case MangaListView.detailed:
              return SliverGrid.extent(
                maxCrossAxisExtent: 1024,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 3,
                children: items
                    .map((manga) => _GridMangaDetailedItem(manga: manga))
                    .toList(),
              );

            case MangaListView.grid:
            default:
              return SliverGrid.extent(
                maxCrossAxisExtent: 256,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 0.7,
                children:
                    items.map((manga) => _GridMangaItem(manga: manga)).toList(),
              );
          }
        }()),
      ],
    );
  }
}

class _GridMangaItem extends StatelessWidget {
  const _GridMangaItem({Key? key, required this.manga}) : super(key: key);

  final Manga manga;

  @override
  Widget build(BuildContext context) {
    final Widget image = Material(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      clipBehavior: Clip.antiAlias,
      child: CachedNetworkImage(
        imageUrl: manga.getCovertArtUrl(quality: CoverArtQuality.medium),
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        width: 256.0,
      ),
    );

    return InkWell(
      onTap: () {
        Navigator.push(context, createMangaViewRoute(manga));
      },
      child: GridTile(
        footer: Material(
          color: Colors.transparent,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(4)),
          ),
          clipBehavior: Clip.antiAlias,
          child: GridTileBar(
            backgroundColor: Colors.black45,
            title: FittedBox(
              fit: BoxFit.none,
              alignment: AlignmentDirectional.centerStart,
              child: Text(manga.attributes.title.get('en')),
            ),
          ),
        ),
        child: image,
      ),
    );
  }
}

class _GridMangaDetailedItem extends StatelessWidget {
  const _GridMangaDetailedItem({Key? key, required this.manga})
      : super(key: key);

  final Manga manga;

  @override
  Widget build(BuildContext context) {
    final bool screenSizeSmall = DeviceContext.screenWidthSmall(context);
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.all(6),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: theme.colorScheme.onSurface,
                  textStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
              onPressed: () async {
                Navigator.push(context, createMangaViewRoute(manga));
              },
              child: Text(
                manga.attributes.title.get('en'),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () async {
                      Navigator.push(context, createMangaViewRoute(manga));
                    },
                    child: CachedNetworkImage(
                        imageUrl: manga.getCovertArtUrl(
                            quality: CoverArtQuality.medium),
                        placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        width: screenSizeSmall ? 80.0 : 128.0),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            MangaStatusChip(status: manga.attributes.status),
                            // TODO: rest of the manga info
                          ],
                        ),
                        Wrap(
                            children: manga.attributes.tags
                                .map((e) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 2.0, horizontal: 2.0),
                                      child: IconTextChip(
                                          text: Text(
                                              e.attributes.name.get('en'))),
                                    ))
                                .toList()),
                        if (manga.attributes.description.isNotEmpty)
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                manga.attributes.description.get('en'),
                                overflow: TextOverflow.clip,
                              ),
                            ),
                          ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ListMangaItem extends StatelessWidget {
  const _ListMangaItem({Key? key, required this.manga}) : super(key: key);

  final Manga manga;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.all(6),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
              onPressed: () async {
                Navigator.push(context, createMangaViewRoute(manga));
              },
              child: CachedNetworkImage(
                imageUrl:
                    manga.getCovertArtUrl(quality: CoverArtQuality.medium),
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                width: 80.0,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: theme.colorScheme.onSurface,
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () async {
                      Navigator.push(context, createMangaViewRoute(manga));
                    },
                    child: Text(manga.attributes.title.get('en')),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      MangaStatusChip(
                        status: manga.attributes.status,
                      ),
                      // TODO: rest of the manga info
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MangaStatusChip extends StatelessWidget {
  const MangaStatusChip({Key? key, required this.status}) : super(key: key);

  final MangaStatus status;

  @override
  Widget build(BuildContext context) {
    var iconColor = Colors.green;

    switch (status) {
      case MangaStatus.ongoing:
        break;
      case MangaStatus.completed:
        iconColor = Colors.blue;
        break;
      case MangaStatus.hiatus:
        iconColor = Colors.orange;
        break;
      case MangaStatus.cancelled:
        iconColor = Colors.red;
        break;
    }

    return IconTextChip(
      icon: Icon(
        Icons.circle,
        color: iconColor,
        size: 10,
      ),
      text: Text(
        status.formatted,
      ),
    );
  }
}

class ContentRatingChip extends StatelessWidget {
  const ContentRatingChip({Key? key, required this.rating}) : super(key: key);

  final ContentRating rating;

  @override
  Widget build(BuildContext context) {
    var iconColor = Colors.orange;

    switch (rating) {
      case ContentRating.suggestive:
        break;
      case ContentRating.safe:
        iconColor = Colors.green;
        break;
      case ContentRating.erotica:
      case ContentRating.pornographic:
        iconColor = Colors.red;
        break;
    }

    return IconTextChip(
      color: iconColor,
      text: Text(
        rating.formatted,
      ),
    );
  }
}
