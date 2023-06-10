import 'package:extended_image/extended_image.dart';
import 'package:flutter/gestures.dart';
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

const statsError = 'Error Retrieving Stats';

enum MangaListView { grid, list, detailed }

final _mangaListViewProvider = StateProvider((ref) => MangaListView.grid);

class ChapterFeedWidget extends HookConsumerWidget {
  const ChapterFeedWidget({
    super.key,
    required this.provider,
    required this.title,
    this.emptyText,
    this.onAtEdge,
    required this.onRefresh,
    this.controller,
    this.restorationId,
  });

  final AutoDisposeFutureProvider<List<ChapterFeedItemData>> provider;
  final String title;
  final String? emptyText;
  final VoidCallback? onAtEdge;
  final RefreshCallback onRefresh;
  final ScrollController? controller;
  final String? restorationId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = controller ?? useScrollController();
    final results = ref.watch(provider);
    final isLoading = results.isLoading;

    useEffect(() {
      void controllerAtEdge() {
        if (onAtEdge != null &&
            scrollController.position.atEdge &&
            scrollController.position.pixels ==
                scrollController.position.maxScrollExtent) {
          onAtEdge!();
        }
      }

      scrollController.addListener(controllerAtEdge);
      return () => scrollController.removeListener(controllerAtEdge);
    }, [scrollController]);

    return Center(
      child: results.when(
        skipLoadingOnReload: true,
        data: (result) {
          if (result.isEmpty) {
            return Text(emptyText ?? 'No results!');
          }

          return ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
              PointerDeviceKind.trackpad,
            }),
            child: RefreshIndicator(
              onRefresh: onRefresh,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 10.0),
                    child: Row(
                      children: [
                        Text(
                          title,
                          style: const TextStyle(fontSize: 24),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      restorationId: restorationId,
                      padding: const EdgeInsets.all(6),
                      itemCount: result.length,
                      itemBuilder: (context, index) {
                        return ChapterFeedItem(state: result.elementAt(index));
                      },
                    ),
                  ),
                  if (isLoading) Styles.listSpinner,
                ],
              ),
            ),
          );
        },
        loading: () => const Stack(
          children: Styles.loadingOverlay,
        ),
        error: (err, stackTrace) {
          final messenger = ScaffoldMessenger.of(context);
          Future.delayed(
            Duration.zero,
            () => messenger
              ..removeCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text('$err'),
                  backgroundColor: Colors.red,
                ),
              ),
          );

          return Column(
            children: [
              Text('Error: $err'),
              Text(stackTrace.toString()),
            ],
          );
        },
      ),
    );
  }
}

class ChapterFeedItem extends ConsumerWidget {
  const ChapterFeedItem({super.key, required this.state});

  final ChapterFeedItemData state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nav = Navigator.of(context);
    final bool screenSizeSmall = DeviceContext.screenWidthSmall(context);
    final theme = Theme.of(context);
    final loggedin = ref.watch(authControlProvider).valueOrNull ?? false;
    Map<String, Set<String>> readData = {};

    if (loggedin) {
      readData = ref.watch(readChaptersProvider).valueOrNull ?? {};
    }

    final chapterBtns = state.chapters.map((e) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        child: ChapterButtonWidget(
          short: screenSizeSmall,
          chapter: e,
          manga: state.manga,
          loggedin: loggedin,
          isRead: readData[state.manga.id]?.contains(e.id) ?? false,
          link: Text(
            state.manga.attributes.title.get('en'),
            style: const TextStyle(fontSize: 24),
          ),
          onLinkPressed: () {
            nav.push(createMangaViewRoute(state.manga));
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
                nav.push(createMangaViewRoute(state.manga));
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
                        nav.push(createMangaViewRoute(state.manga));
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

class ChapterButtonWidget extends ConsumerWidget {
  const ChapterButtonWidget({
    super.key,
    required this.chapter,
    required this.manga,
    required this.loggedin,
    this.isRead = false,
    this.link,
    this.onLinkPressed,
    this.short = false,
  });

  final Chapter chapter;
  final Manga manga;
  final bool loggedin;
  final bool isRead;
  final Widget? link;
  final VoidCallback? onLinkPressed;
  final bool short;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nav = Navigator.of(context);

    final bool screenSizeSmall = DeviceContext.screenWidthSmall(context);
    final theme = Theme.of(context);
    final tileColor = theme.colorScheme.primaryContainer;
    final iconSize = screenSizeSmall ? 15.0 : 20.0;
    final isEndChapter = manga.attributes.lastChapter != null &&
        manga.attributes.lastChapter?.isNotEmpty == true &&
        chapter.attributes.chapter == manga.attributes.lastChapter;

    String title = '';

    if (chapter.attributes.chapter != null) {
      title += 'Chapter ${chapter.attributes.chapter}';
    }

    if (chapter.attributes.title != null && !short) {
      title += ' - ${chapter.attributes.title}';
    }

    if (title.isEmpty) {
      // Probably a oneshot?
      title = 'Oneshot';
    }

    final pubtime = timeago.format(chapter.attributes.publishAt);

    final flagChip = IconTextChip(
      text: dashflag.CountryFlag(
        country: dashflag.Country.fromCode(
            chapter.attributes.translatedLanguage.flag),
        height: screenSizeSmall ? 15 : 18,
      ),
    );

    final groups = chapter.getGroups();
    final groupChips = <Widget>[];

    for (var g in groups) {
      groupChips.add(const SizedBox(width: 4));
      groupChips.add(IconTextChip(
        icon: Icon(Icons.group, size: iconSize),
        text: Text(g.crop()),
      ));
    }

    final publisherChip = <Widget>[];
    if (chapter.attributes.externalUrl != null) {
      publisherChip.add(const SizedBox(width: 4));
      publisherChip.add(IconTextChip(
        icon: Icon(Icons.check, color: Colors.amber, size: iconSize),
        text: const Text('Official Publisher'),
      ));
    }

    final endChip = <Widget>[];
    if (isEndChapter) {
      endChip.add(const IconTextChip(
        color: Colors.blue,
        text: Text('END'),
      ));
      endChip.add(const SizedBox(width: 4));
    }

    // Logged in components
    IconButton? markReadBtn;
    Border? border;
    TextStyle? textstyle;

    if (!loggedin) {
      border = Border(
        left: BorderSide(color: tileColor, width: 4.0),
      );

      textstyle = TextStyle(
        color: theme.colorScheme.primary,
      );
    } else {
      border = Border(
        left: BorderSide(color: isRead ? tileColor : Colors.blue, width: 4.0),
      );

      textstyle = TextStyle(
          color: (isRead ? theme.highlightColor : theme.colorScheme.primary));

      markReadBtn = IconButton(
        onPressed: () async {
          bool set = !isRead;
          ref.read(readChaptersProvider.notifier).set(manga, [chapter], set);
        },
        padding: const EdgeInsets.all(0.0),
        splashRadius: 15,
        iconSize: 20,
        tooltip: isRead ? 'Unmark as read' : 'Mark as read',
        icon: Icon(isRead ? Icons.visibility_off : Icons.visibility,
            color:
                (isRead ? theme.highlightColor : theme.primaryIconTheme.color)),
        constraints: const BoxConstraints(minWidth: 20.0, minHeight: 20.0),
      );
    }

    final tile = ListTile(
      onTap: () {
        nav.push(
            createMangaDexReaderRoute(chapter, manga, link, onLinkPressed));
      },
      dense: true,
      minVerticalPadding: 0.0,
      contentPadding:
          EdgeInsets.symmetric(horizontal: (screenSizeSmall ? 4.0 : 10.0)),
      minLeadingWidth: 0.0,
      leading: markReadBtn,
      title: Text(
        title,
        style: textstyle,
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
                  Text(pubtime)
                ],
              ),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.schedule, size: 15),
                const SizedBox(width: 5),
                Text(pubtime)
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
        nav.push(
            createMangaDexReaderRoute(chapter, manga, link, onLinkPressed));
      },
      child: Container(
        decoration: BoxDecoration(
          color: tileColor,
          border: border,
        ),
        child: child,
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
        if (onAtEdge != null &&
            scrollController.position.atEdge &&
            scrollController.position.pixels ==
                scrollController.position.maxScrollExtent) {
          onAtEdge!();
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
        return SliverList.builder(
          itemBuilder: (BuildContext context, int index) {
            final manga = items.elementAt(index);
            return _ListMangaItem(
              manga: manga,
            );
          },
          itemCount: items.length,
        );
      case MangaListView.detailed:
        return SliverGrid.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 1024,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: onMobilePortrait ? 1.0 : 3.0,
          ),
          itemBuilder: (context, index) {
            final manga = items.elementAt(index);
            return _GridMangaDetailedItem(manga: manga);
          },
          itemCount: items.length,
        );

      case MangaListView.grid:
      default:
        return SliverGrid.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 256,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 0.7,
          ),
          itemBuilder: (context, index) {
            final manga = items.elementAt(index);
            return _GridMangaItem(manga: manga);
          },
          itemCount: items.length,
        );
    }
  }
}

class _GridMangaItem extends StatelessWidget {
  const _GridMangaItem({Key? key, required this.manga}) : super(key: key);

  final Manga manga;

  @override
  Widget build(BuildContext context) {
    final nav = Navigator.of(context);
    final Widget image = Material(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      clipBehavior: Clip.antiAlias,
      child: ExtendedImage.network(
        manga.getFirstCoverUrl(quality: CoverArtQuality.medium),
        cache: true,
        loadStateChanged: extendedImageLoadStateHandler,
        width: 256.0,
      ),
    );

    return InkWell(
      onTap: () {
        nav.push(createMangaViewRoute(manga));
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
    final nav = Navigator.of(context);
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
                      nav.push(createMangaViewRoute(manga));
                    },
                    child: ExtendedImage.network(
                        manga.getFirstCoverUrl(quality: CoverArtQuality.medium),
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
                            ...stats.when(
                              skipLoadingOnReload: true,
                              data: (data) {
                                if (data.containsKey(manga.id)) {
                                  return [
                                    IconTextChip(
                                      icon: const Icon(
                                        Icons.star_border,
                                        color: Colors.amber,
                                        size: 18,
                                      ),
                                      text: Text(
                                        data[manga.id]
                                                ?.rating
                                                .bayesian
                                                .toStringAsFixed(2) ??
                                            statsError,
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
                                        data[manga.id]?.follows.toString() ??
                                            statsError,
                                      ),
                                    ),
                                  ];
                                }

                                return [
                                  const IconTextChip(
                                    text: Text(statsError),
                                  )
                                ];
                              },
                              error: (obj, stack) => [
                                const IconTextChip(
                                  text: Text(statsError),
                                )
                              ],
                              loading: () => [
                                const IconTextChip(
                                  text: CircularProgressIndicator(),
                                )
                              ],
                            ),
                            const SizedBox(width: 10),
                            MangaStatusChip(status: manga.attributes.status),
                          ],
                        ),
                        const SizedBox(
                          height: 4.0,
                        ),
                        Wrap(
                          runSpacing: 4.0,
                          children: [
                            ContentRatingChip(
                                rating: manga.attributes.contentRating),
                            const SizedBox(width: 2.0),
                            ...manga.attributes.tags
                                .map((e) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 2.0),
                                      child: IconTextChip(
                                          text: Text(
                                              e.attributes.name.get('en'))),
                                    ))
                                .toList(),
                          ],
                        ),
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
    final nav = Navigator.of(context);
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
                nav.push(createMangaViewRoute(manga));
              },
              child: ExtendedImage.network(
                manga.getFirstCoverUrl(quality: CoverArtQuality.medium),
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
                      const SizedBox(width: 2),
                      if (manga.attributes.tags.isNotEmpty)
                        ...manga.attributes.tags
                            .where((tag) =>
                                (tag.attributes.group == TagGroup.genre ||
                                    tag.attributes.group == TagGroup.theme))
                            .map((e) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 2),
                                  child: IconTextChip(
                                      text: Text(e.attributes.name.get('en'))),
                                ))
                            .toList(),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Wrap(
                    runSpacing: 4.0,
                    children: [
                      ...stats.when(
                        skipLoadingOnReload: true,
                        data: (data) {
                          if (data.containsKey(manga.id)) {
                            return [
                              IconTextChip(
                                icon: const Icon(
                                  Icons.star_border,
                                  color: Colors.amber,
                                  size: 18,
                                ),
                                text: Text(
                                  data[manga.id]
                                          ?.rating
                                          .bayesian
                                          .toStringAsFixed(2) ??
                                      statsError,
                                  style: const TextStyle(
                                    color: Colors.amber,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              IconTextChip(
                                icon: const Icon(
                                  Icons.bookmark_outline,
                                  size: 18,
                                ),
                                text: Text(
                                  data[manga.id]?.follows.toString() ??
                                      statsError,
                                ),
                              ),
                            ];
                          }

                          return [
                            const IconTextChip(
                              text: Text(statsError),
                            )
                          ];
                        },
                        error: (obj, stack) => [
                          const IconTextChip(
                            text: Text(statsError),
                          )
                        ],
                        loading: () => [
                          const IconTextChip(
                            text: CircularProgressIndicator(),
                          )
                        ],
                      ),
                      const SizedBox(width: 10),
                      MangaStatusChip(status: manga.attributes.status),
                    ],
                  ),
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
