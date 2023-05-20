import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/mangadex/manga_view.dart';
import 'package:gagaku/mangadex/model.dart';
import 'package:gagaku/mangadex/reader.dart';
import 'package:gagaku/ui.dart';
import 'package:gagaku/util.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:dash_flags/dash_flags.dart' as dashflag;

import 'types.dart';

enum MangaListView { grid, list, detailed }

final _mangaListViewProvider = StateProvider((ref) => MangaListView.grid);

class ChapterFeedItem extends HookWidget {
  const ChapterFeedItem({super.key, required this.state});

  final ChapterFeedItemData state;

  @override
  Widget build(BuildContext context) {
    final refresh = useState(0);
    final bool screenSizeSmall = DeviceContext.screenWidthSmall(context);
    final theme = Theme.of(context);

    var chapterBtns = state.chapters.map((e) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        child: ChapterButtonWidget(
          short: screenSizeSmall,
          chapter: e,
          manga: state.manga,
          link: Text(
            state.manga.attributes.title.get('en'),
            style: const TextStyle(fontSize: 24),
          ),
          onLinkPressed: () {
            Navigator.push(context, createMangaViewRoute(state.manga))
                .then((value) {
              // Refresh when the view is closed
              refresh.value++;
            });
          },
        ),
      );
    }).toList();

    return Card(
      margin: const EdgeInsets.all(6),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
              onPressed: () async {
                final nav = Navigator.of(context);
                nav.push(createMangaViewRoute(state.manga)).then((value) {
                  // Refresh when the view is closed
                  refresh.value++;
                });
              },
              child: ExtendedImage.network(state.coverArt,
                  loadStateChanged: extendedImageLoadStateHandler,
                  width: screenSizeSmall ? 80.0 : 128.0),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor: theme.colorScheme.onSurface,
                          textStyle: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      onPressed: () async {
                        final nav = Navigator.of(context);
                        nav
                            .push(createMangaViewRoute(state.manga))
                            .then((value) {
                          // Refresh when the view is closed
                          refresh.value++;
                        });
                      },
                      child: Text(state.manga.attributes.title.get('en'))),
                  const Divider(),
                  ...chapterBtns
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ChapterButtonWidget extends HookConsumerWidget {
  const ChapterButtonWidget({
    super.key,
    required this.chapter,
    required this.manga,
    this.link,
    this.onLinkPressed,
    this.short = false,
  });

  final Chapter chapter;
  final Manga manga;
  final Widget? link;
  final VoidCallback? onLinkPressed;
  final bool short;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authControlProvider);
    final refresh = useState(0);

    final bool screenSizeSmall = DeviceContext.screenWidthSmall(context);
    final theme = Theme.of(context);
    final tileColor = theme.colorScheme.primaryContainer;
    final iconSize = screenSizeSmall ? 15.0 : 20.0;
    final isEndChapter = manga.attributes.lastChapter != null &&
        manga.attributes.lastChapter!.isNotEmpty &&
        chapter.attributes.chapter == manga.attributes.lastChapter;

    String title = '';

    if (chapter.attributes.chapter != null) {
      title += 'Chapter ${chapter.attributes.chapter!}';
    }

    if (chapter.attributes.title != null && !short) {
      title += ' - ${chapter.attributes.title!}';
    }

    final flagChip = IconTextChip(
      text: dashflag.CountryFlag(
        country: dashflag.Country.fromCode(
            chapter.attributes.translatedLanguage.flag),
        height: screenSizeSmall ? 15 : 18,
      ),
    );

    final groups = chapter.getGroups();
    final groupChips = [];

    for (var g in groups) {
      groupChips.addAll([
        const SizedBox(width: 4),
        IconTextChip(
          icon: Icon(Icons.group, size: iconSize),
          text: Text(g.crop()),
        ),
      ]);
    }

    final publisherChip = [];
    if (chapter.attributes.externalUrl != null) {
      publisherChip.addAll([
        const SizedBox(width: 4),
        IconTextChip(
          icon: Icon(Icons.check, color: Colors.amber, size: iconSize),
          text: const Text('Official Publisher'),
        ),
      ]);
    }

    final endChip = [];
    if (isEndChapter) {
      endChip.addAll([
        const IconTextChip(
          color: Colors.blue,
          text: Text('END'),
        ),
        const SizedBox(width: 4),
      ]);
    }

    final tile = ListTile(
      onTap: () {
        Navigator.push(context,
                createMangaDexReaderRoute(chapter, manga, link, onLinkPressed))
            .then((value) {
          // Refresh this when reader view is closed to update read status
          refresh.value++;
        });
      },
      dense: true,
      minVerticalPadding: 0.0,
      contentPadding:
          EdgeInsets.symmetric(horizontal: (screenSizeSmall ? 4.0 : 10.0)),
      minLeadingWidth: 0.0,
      leading: auth.maybeWhen(
        data: (loggedin) {
          if (!loggedin) {
            return null;
          }

          final readChapters = ref.watch(readChaptersProvider);

          return readChapters.maybeWhen(
            skipLoadingOnReload: true,
            data: (data) {
              bool isRead = data.containsKey(manga.id) &&
                  data[manga.id]!.contains(chapter.id);

              return IconButton(
                onPressed: () async {
                  bool set = !isRead;
                  ref
                      .read(readChaptersProvider.notifier)
                      .set(manga, [chapter], set);
                },
                padding: const EdgeInsets.all(0.0),
                splashRadius: 15,
                iconSize: 20,
                tooltip: isRead ? 'Unmark as read' : 'Mark as read',
                icon: Icon(isRead ? Icons.visibility_off : Icons.visibility,
                    color: (isRead
                        ? theme.highlightColor
                        : theme.primaryIconTheme.color)),
                constraints:
                    const BoxConstraints(minWidth: 20.0, minHeight: 20.0),
              );
            },
            orElse: () => null,
          );
        },
        orElse: () => null,
      ),
      title: auth.maybeWhen(
        data: (loggedin) {
          if (!loggedin) {
            return Text(
              title,
              style: TextStyle(
                color: theme.colorScheme.primary,
              ),
            );
          }

          final readChapters = ref.watch(readChaptersProvider);

          return readChapters.maybeWhen(
            skipLoadingOnReload: true,
            data: (data) {
              bool isRead = data.containsKey(manga.id) &&
                  data[manga.id]!.contains(chapter.id);

              return Text(
                title,
                style: TextStyle(
                    color: (isRead
                        ? theme.highlightColor
                        : theme.colorScheme.primary)),
              );
            },
            orElse: () => Text(
              title,
              style: TextStyle(
                color: theme.colorScheme.primary,
              ),
            ),
          );
        },
        orElse: () => Text(
          title,
          style: TextStyle(
            color: theme.colorScheme.primary,
          ),
        ),
      ),
      trailing: !screenSizeSmall
          ? FittedBox(
              fit: BoxFit.fill,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ...endChip,
                  flagChip,
                  ...groupChips,
                  ...publisherChip,
                  const SizedBox(width: 10),
                  const Icon(Icons.schedule, size: 20),
                  const SizedBox(width: 5),
                  Text(timeago.format(chapter.attributes.publishAt))
                ],
              ),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.schedule, size: 15),
                const SizedBox(width: 5),
                Text(timeago.format(chapter.attributes.publishAt))
              ],
            ),
    );

    Widget child = tile;

    if (screenSizeSmall) {
      child = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          tile,
          Wrap(
            runSpacing: 2.0,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              const SizedBox(
                width: 10.0,
              ),
              ...endChip,
              flagChip,
              ...groupChips,
              ...publisherChip,
            ],
          ),
          const SizedBox(
            height: 2.0,
          ),
        ],
      );
    }

    return InkWell(
      onTap: () {
        Navigator.push(context,
                createMangaDexReaderRoute(chapter, manga, link, onLinkPressed))
            .then((value) {
          // Refresh this when reader view is closed to update read status
          refresh.value++;
        });
      },
      child: auth.maybeWhen(
        data: (loggedin) {
          if (!loggedin) {
            return Container(
              decoration: BoxDecoration(
                color: tileColor,
                border: Border(
                  left: BorderSide(color: tileColor, width: 4.0),
                ),
              ),
              child: child,
            );
          }

          final readChapters = ref.watch(readChaptersProvider);

          return readChapters.maybeWhen(
            skipLoadingOnReload: true,
            data: (data) {
              bool isRead = data.containsKey(manga.id) &&
                  data[manga.id]!.contains(chapter.id);

              return Container(
                decoration: BoxDecoration(
                  color: tileColor,
                  border: Border(
                    left: BorderSide(
                        color: isRead ? tileColor : Colors.blue, width: 4.0),
                  ),
                ),
                child: child,
              );
            },
            orElse: () => Container(
              decoration: BoxDecoration(
                color: tileColor,
                border: Border(
                  left: BorderSide(color: tileColor, width: 4.0),
                ),
              ),
              child: child,
            ),
          );
        },
        orElse: () => Container(
          decoration: BoxDecoration(
            color: tileColor,
            border: Border(
              left: BorderSide(color: tileColor, width: 4.0),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}

class MangaListWidget extends HookConsumerWidget {
  const MangaListWidget({
    super.key,
    required this.title,
    required this.children,
    this.leading = const <Widget>[],
    this.physics,
    this.onAtEdge,
    this.controller,
  });

  final Widget title;
  final List<Widget> children;
  final List<Widget> leading;
  final ScrollPhysics? physics;
  final VoidCallback? onAtEdge;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = controller ?? useScrollController();
    final view = ref.watch(_mangaListViewProvider);

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
                    ref.read(_mangaListViewProvider.notifier).state =
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
        ...children,
      ],
    );
  }
}

class MangaListViewSliver extends ConsumerWidget {
  const MangaListViewSliver({
    super.key,
    required this.items,
  });

  final Iterable<Manga> items;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final view = ref.watch(_mangaListViewProvider);
    final onMobilePortrait =
        DeviceContext.isPortraitMode(context) && DeviceContext.isMobile();

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
          childAspectRatio: onMobilePortrait ? 1.0 : 3.0,
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
          children: items.map((manga) => _GridMangaItem(manga: manga)).toList(),
        );
    }
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
      child: ExtendedImage.network(
        manga.getCovertArtUrl(quality: CoverArtQuality.medium),
        cache: true,
        loadStateChanged: extendedImageLoadStateHandler,
        width: 256.0,
      ),
    );

    return InkWell(
      onTap: () {
        Navigator.push(context, createMangaViewRoute(manga));
      },
      child: GridTile(
        footer: SizedBox(
          height: 60,
          child: Material(
            color: Colors.transparent,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(4)),
            ),
            clipBehavior: Clip.antiAlias,
            child: GridTileBar(
              backgroundColor: Colors.black45,
              title: Text(
                manga.attributes.title.get('en'),
                softWrap: true,
                style: const TextStyle(
                  overflow: TextOverflow.fade,
                ),
              ),
            ),
          ),
        ),
        child: image,
      ),
    );
  }
}

class _GridMangaDetailedItem extends ConsumerWidget {
  const _GridMangaDetailedItem({Key? key, required this.manga})
      : super(key: key);

  final Manga manga;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool screenSizeSmall = DeviceContext.screenWidthSmall(context);
    final theme = Theme.of(context);
    final stats = ref.watch(statisticsProvider);

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
                final nav = Navigator.of(context);
                nav.push(createMangaViewRoute(manga));
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
                      final nav = Navigator.of(context);
                      nav.push(createMangaViewRoute(manga));
                    },
                    child: ExtendedImage.network(
                        manga.getCovertArtUrl(quality: CoverArtQuality.medium),
                        cache: true,
                        loadStateChanged: extendedImageLoadStateHandler,
                        width: screenSizeSmall ? 80.0 : 128.0),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          runSpacing: 4.0,
                          children: [
                            ContentRatingChip(
                                rating: manga.attributes.contentRating),
                            ...stats.when(
                              skipLoadingOnReload: true,
                              data: (data) {
                                if (data.containsKey(manga.id)) {
                                  return [
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    IconTextChip(
                                      icon: const Icon(
                                        Icons.star_border,
                                        color: Colors.amber,
                                        size: 18,
                                      ),
                                      text: Text(
                                        data[manga.id]!
                                            .rating
                                            .bayesian
                                            .toStringAsFixed(2),
                                        style: const TextStyle(
                                          color: Colors.amber,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    IconTextChip(
                                      icon: const Icon(
                                        Icons.bookmark_outline,
                                        size: 18,
                                      ),
                                      text: Text(
                                        data[manga.id]!.follows.toString(),
                                      ),
                                    ),
                                  ];
                                }

                                return [
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  const IconTextChip(
                                    text: Text('Error Retrieving Stats'),
                                  )
                                ];
                              },
                              error: (obj, stack) => [
                                const SizedBox(
                                  width: 4,
                                ),
                                const IconTextChip(
                                  text: Text('Error Retrieving Stats'),
                                )
                              ],
                              loading: () => [
                                const SizedBox(
                                  width: 4,
                                ),
                                const IconTextChip(
                                  text: CircularProgressIndicator(),
                                )
                              ],
                            ),
                            const SizedBox(width: 4),
                            MangaStatusChip(status: manga.attributes.status),
                          ],
                        ),
                        const SizedBox(
                          height: 2,
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

class _ListMangaItem extends ConsumerWidget {
  const _ListMangaItem({Key? key, required this.manga}) : super(key: key);

  final Manga manga;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final stats = ref.watch(statisticsProvider);

    return Card(
      margin: const EdgeInsets.all(6),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
              onPressed: () async {
                final nav = Navigator.of(context);
                nav.push(createMangaViewRoute(manga));
              },
              child: ExtendedImage.network(
                manga.getCovertArtUrl(quality: CoverArtQuality.medium),
                cache: true,
                loadStateChanged: extendedImageLoadStateHandler,
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
                      final nav = Navigator.of(context);
                      nav.push(createMangaViewRoute(manga));
                    },
                    child: Text(manga.attributes.title.get('en')),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Wrap(
                    runSpacing: 4.0,
                    children: [
                      ContentRatingChip(rating: manga.attributes.contentRating),
                      ...stats.when(
                        skipLoadingOnReload: true,
                        data: (data) {
                          if (data.containsKey(manga.id)) {
                            return [
                              const SizedBox(
                                width: 4,
                              ),
                              IconTextChip(
                                icon: const Icon(
                                  Icons.star_border,
                                  color: Colors.amber,
                                  size: 18,
                                ),
                                text: Text(
                                  data[manga.id]!
                                      .rating
                                      .bayesian
                                      .toStringAsFixed(2),
                                  style: const TextStyle(
                                    color: Colors.amber,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              IconTextChip(
                                icon: const Icon(
                                  Icons.bookmark_outline,
                                  size: 18,
                                ),
                                text: Text(
                                  data[manga.id]!.follows.toString(),
                                ),
                              ),
                            ];
                          }

                          return [
                            const SizedBox(
                              width: 4,
                            ),
                            const IconTextChip(
                              text: Text('Error Retrieving Stats'),
                            )
                          ];
                        },
                        error: (obj, stack) => [
                          const SizedBox(
                            width: 4,
                          ),
                          const IconTextChip(
                            text: Text('Error Retrieving Stats'),
                          )
                        ],
                        loading: () => [
                          const SizedBox(
                            width: 4,
                          ),
                          const IconTextChip(
                            text: CircularProgressIndicator(),
                          )
                        ],
                      ),
                      const SizedBox(width: 4),
                      MangaStatusChip(status: manga.attributes.status),
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
