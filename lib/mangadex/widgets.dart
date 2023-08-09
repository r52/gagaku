import 'package:extended_image/extended_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/mangadex/model.dart';
import 'package:gagaku/mangadex/reader.dart';
import 'package:gagaku/ui.dart';
import 'package:gagaku/util.dart';
import 'package:go_router/go_router.dart';
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
      child: switch (results) {
        AsyncValue(:final error?, :final stackTrace?) => () {
            final messenger = ScaffoldMessenger.of(context);
            Styles.showErrorSnackBar(messenger, '$error');
            logger.e("${provider.toString()} failed",
                error: error, stackTrace: stackTrace);

            return RefreshIndicator(
              onRefresh: onRefresh,
              child: Styles.errorList(error, stackTrace),
            );
          }(),
        AsyncValue(:final value?) => () {
            if (value.isEmpty) {
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
                        itemCount: value.length,
                        itemBuilder: (context, index) {
                          return ChapterFeedItem(state: value.elementAt(index));
                        },
                      ),
                    ),
                    if (isLoading) Styles.listSpinner,
                  ],
                ),
              ),
            );
          }(),
        _ => const Stack(
            children: Styles.loadingOverlay,
          ),
      },
    );
  }
}

class ChapterFeedItem extends ConsumerWidget {
  const ChapterFeedItem({super.key, required this.state});

  final ChapterFeedItemData state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool screenSizeSmall = DeviceContext.screenWidthSmall(context);
    final theme = Theme.of(context);
    final loggedin = ref.watch(authControlProvider).valueOrNull ?? false;
    ReadChaptersMap? readData;

    if (loggedin) {
      readData = switch (ref.watch(readChaptersProvider)) {
        AsyncValue(:final error?, :final stackTrace?) => () {
            final messenger = ScaffoldMessenger.of(context);
            Styles.showErrorSnackBar(messenger, '$error');
            logger.e("readChaptersProvider failed",
                error: error, stackTrace: stackTrace);

            return null;
          }(),
        AsyncValue(:final value?) => () {
            return value;
          }(),
        _ => null,
      };
    }

    final chapterBtns = state.chapters.map((e) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        child: ChapterButtonWidget(
          chapter: e,
          manga: state.manga,
          loggedin: loggedin,
          isRead: switch (readData) {
            null => null,
            _ => readData[state.manga.id]?.contains(e.id) == true,
          },
          link: Text(
            state.manga.attributes.title.get('en'),
            style: const TextStyle(fontSize: 18),
          ),
          onLinkPressed: () {
            context.push('/title/${state.manga.id}', extra: state.manga);
          },
        ),
      );
    }).toList();

    final titleBtn = TextButton(
      style: TextButton.styleFrom(
        minimumSize: const Size(0.0, 24.0),
        shape: const RoundedRectangleBorder(),
        foregroundColor: theme.colorScheme.onSurface,
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        visualDensity: const VisualDensity(horizontal: -4.0, vertical: -4.0),
      ),
      onPressed: () async {
        context.push('/title/${state.manga.id}', extra: state.manga);
      },
      child: Text(
        state.manga.attributes.title.get('en'),
        overflow: TextOverflow.ellipsis,
      ),
    );

    final coverBtn = TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 6.0),
        shape: const RoundedRectangleBorder(),
      ),
      onPressed: () async {
        context.push('/title/${state.manga.id}', extra: state.manga);
      },
      child: ExtendedImage.network(state.coverArt,
          loadStateChanged: extendedImageLoadStateHandler,
          shape: BoxShape.rectangle,
          borderRadius: const BorderRadius.all(Radius.circular(4.0)),
          width: screenSizeSmall ? 64.0 : 128.0),
    );

    return Card(
      margin: const EdgeInsets.all(6),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: screenSizeSmall
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  titleBtn,
                  const Divider(
                    height: 4.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      coverBtn,
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: chapterBtns,
                      )),
                    ],
                  ),
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  coverBtn,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        titleBtn,
                        const Divider(
                          height: 10.0,
                        ),
                        ...chapterBtns,
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
    this.isRead,
    this.link,
    this.onLinkPressed,
  });

  final Chapter chapter;
  final Manga manga;
  final bool loggedin;
  final bool? isRead;
  final Widget? link;
  final VoidCallback? onLinkPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool screenSizeSmall = DeviceContext.screenWidthSmall(context);
    final theme = Theme.of(context);
    final tileColor = theme.colorScheme.primaryContainer;
    final iconSize = screenSizeSmall ? 15.0 : 20.0;
    final isEndChapter = manga.attributes.lastChapter != null &&
        manga.attributes.lastChapter?.isNotEmpty == true &&
        chapter.attributes.chapter == manga.attributes.lastChapter;

    String title = chapter.getTitle();

    const rowPadding = SizedBox(
      width: 6.0,
    );

    final pubtime = timeago.format(chapter.attributes.publishAt);

    final flagChip = dashflag.CountryFlag(
      country:
          dashflag.Country.fromCode(chapter.attributes.translatedLanguage.flag),
      height: screenSizeSmall ? 15 : 18,
    );

    final groups = chapter.getGroups();
    final groupChips = <Widget>[];

    for (final g in groups) {
      groupChips.add(IconTextChip(
        icon: Icon(Icons.group, size: iconSize),
        text: Text(g.attributes.name.crop()),
        onPressed: () {
          context.push('/group/${g.id}', extra: g);
        },
      ));
      groupChips.add(rowPadding);
    }

    if (groupChips.isEmpty) {
      groupChips.add(IconTextChip(
        icon: Icon(Icons.group, size: iconSize),
        text: const Text('No Group'),
      ));
      groupChips.add(rowPadding);
    }

    final publisherChip = <Widget>[];
    if (chapter.attributes.externalUrl != null) {
      publisherChip.add(IconTextChip(
        icon: Icon(Icons.check, color: Colors.amber, size: iconSize),
        text: const Text('Official Publisher'),
      ));
      publisherChip.add(rowPadding);
    }

    final userChip = IconTextChip(
      icon: Icon(Icons.person, size: iconSize),
      text: Text(chapter.getUploadUser().crop()),
    );

    Widget? endChip;
    if (isEndChapter) {
      endChip = const IconTextChip(
        color: Colors.blue,
        text: Text('END'),
      );
    }

    // Logged in components
    Widget? markReadBtn;
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
        left: BorderSide(
            color: isRead == true ? tileColor : Colors.blue, width: 4.0),
      );

      textstyle = TextStyle(
          color: (isRead == true
              ? theme.highlightColor
              : theme.colorScheme.primary));

      markReadBtn = switch (isRead) {
        null => const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(),
          ),
        true || false => IconButton(
            onPressed: () async {
              bool set = !isRead!;
              ref
                  .read(readChaptersProvider.notifier)
                  .set(manga, [chapter], set);
            },
            padding: const EdgeInsets.all(0.0),
            splashRadius: 15,
            iconSize: 20,
            tooltip: isRead == true ? 'Unmark as read' : 'Mark as read',
            icon: Icon(isRead == true ? Icons.visibility_off : Icons.visibility,
                color: (isRead == true
                    ? theme.highlightColor
                    : theme.primaryIconTheme.color)),
            constraints: const BoxConstraints(
                minWidth: 20.0,
                minHeight: 20.0,
                maxWidth: 30.0,
                maxHeight: 30.0),
            visualDensity:
                const VisualDensity(horizontal: -4.0, vertical: -4.0),
          ),
      };
    }

    final vPadding =
        EdgeInsets.symmetric(vertical: (screenSizeSmall ? 2.0 : 4.0));

    final tile = Padding(
      padding: EdgeInsets.symmetric(horizontal: (screenSizeSmall ? 6.0 : 10.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              children: [
                if (markReadBtn != null) ...[
                  markReadBtn,
                  const SizedBox(
                    width: 10,
                  )
                ],
                flagChip,
                rowPadding,
                Flexible(
                  fit: FlexFit.tight,
                  child: Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: textstyle,
                  ),
                ),
                rowPadding,
                if (endChip != null) endChip,
                if (!screenSizeSmall)
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(Icons.schedule, size: 20),
                        rowPadding,
                        Text(pubtime)
                      ],
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: vPadding,
            child: screenSizeSmall
                ? Wrap(
                    runSpacing: 2.0,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    children: [...groupChips, ...publisherChip],
                  )
                : Row(
                    children: [
                      ...groupChips,
                      ...publisherChip,
                      const Spacer(),
                      userChip,
                    ],
                  ),
          ),
          if (screenSizeSmall)
            Padding(
              padding: vPadding,
              child: Row(
                children: [
                  userChip,
                ],
              ),
            ),
          if (screenSizeSmall)
            Padding(
              padding: vPadding,
              child: Row(
                children: [
                  const Spacer(),
                  const Icon(Icons.schedule, size: 15),
                  rowPadding,
                  Text(
                    pubtime,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
        ],
      ),
    );

    return InkWell(
      onTap: () {
        context.push('/chapter/${chapter.id}',
            extra: ReaderData(
                title: title,
                chapter: chapter,
                manga: manga,
                link: link,
                onLinkPressed: onLinkPressed));
      },
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        clipBehavior: Clip.hardEdge,
        child: Container(
          decoration: BoxDecoration(
            color: tileColor,
            border: border,
          ),
          child: tile,
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
    final Widget image = Material(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4.0))),
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
        context.push('/title/${manga.id}', extra: manga);
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
                context.push('/title/${manga.id}', extra: manga);
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
                      context.push('/title/${manga.id}', extra: manga);
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
                            ...switch (stats) {
                              // ignore: unused_local_variable
                              AsyncValue(:final error?, :final stackTrace?) => [
                                  const IconTextChip(
                                    text: Text(statsError),
                                  )
                                ],
                              AsyncValue(:final value?) => () {
                                  if (value.containsKey(manga.id)) {
                                    return [
                                      IconTextChip(
                                        icon: const Icon(
                                          Icons.star_border,
                                          color: Colors.amber,
                                          size: 18,
                                        ),
                                        text: Text(
                                          value[manga.id]
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
                                          value[manga.id]?.follows.toString() ??
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
                                }(),
                              _ => [
                                  const IconTextChip(
                                    text: CircularProgressIndicator(),
                                  )
                                ],
                            },
                            const SizedBox(width: 10),
                            MangaStatusChip(status: manga.attributes.status),
                          ],
                        ),
                        const SizedBox(
                          height: 4.0,
                        ),
                        Wrap(
                          spacing: 4.0,
                          runSpacing: 4.0,
                          children: [
                            ContentRatingChip(
                                rating: manga.attributes.contentRating),
                            ...manga.attributes.tags
                                .map(
                                  (e) => IconTextChip(
                                      text: Text(e.attributes.name.get('en'))),
                                )
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
                context.push('/title/${manga.id}', extra: manga);
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
                      context.push('/title/${manga.id}', extra: manga);
                    },
                    child: Text(manga.attributes.title.get('en')),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Wrap(
                    spacing: 4.0,
                    runSpacing: 4.0,
                    children: [
                      ContentRatingChip(rating: manga.attributes.contentRating),
                      if (manga.attributes.tags.isNotEmpty)
                        ...manga.attributes.tags
                            .where((tag) =>
                                (tag.attributes.group == TagGroup.genre ||
                                    tag.attributes.group == TagGroup.theme))
                            .map(
                              (e) => IconTextChip(
                                  text: Text(e.attributes.name.get('en'))),
                            )
                            .toList(),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Wrap(
                    runSpacing: 4.0,
                    children: [
                      ...switch (stats) {
                        // ignore: unused_local_variable
                        AsyncValue(:final error?, :final stackTrace?) => [
                            const IconTextChip(
                              text: Text(statsError),
                            )
                          ],
                        AsyncValue(:final value?) => () {
                            if (value.containsKey(manga.id)) {
                              return [
                                IconTextChip(
                                  icon: const Icon(
                                    Icons.star_border,
                                    color: Colors.amber,
                                    size: 18,
                                  ),
                                  text: Text(
                                    value[manga.id]
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
                                    value[manga.id]?.follows.toString() ??
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
                          }(),
                        _ => [
                            const IconTextChip(
                              text: CircularProgressIndicator(),
                            )
                          ],
                      },
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
