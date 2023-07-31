import 'package:animations/animations.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/mangadex/creator_view.dart';
import 'package:gagaku/mangadex/model.dart';
import 'package:gagaku/mangadex/types.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:gagaku/ui.dart';
import 'package:gagaku/util.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

part 'manga_view.g.dart';

enum _ViewType { chapters, art }

Route createMangaViewRoute(Manga manga) {
  return Styles.buildSharedAxisTransitionRoute(
    (context, animation, secondaryAnimation) => MangaDexMangaViewWidget(
      manga: manga,
    ),
    SharedAxisTransitionType.scaled,
  );
}

@riverpod
Future<void> _fetchReadChaptersRedun(
    _FetchReadChaptersRedunRef ref, Manga manga) async {
  final loggedin = await ref.watch(authControlProvider.future);

  if (loggedin) {
    // Redundant retrieve read chapters when opening the manga
    // from places where it hasn't been retrieved yet
    await ref.watch(readChaptersProvider.notifier).get([manga]);

    await ref.watch(ratingsProvider.notifier).get([manga]);
  }

  await ref.watch(statisticsProvider.notifier).get([manga]);
}

class MangaDexMangaViewWidget extends HookConsumerWidget {
  const MangaDexMangaViewWidget({super.key, required this.manga});

  final Manga manga;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nav = Navigator.of(context);
    final loggedin = ref.watch(authControlProvider).valueOrNull ?? false;
    final scrollController = useScrollController();
    final theme = Theme.of(context);
    final view = useState(_ViewType.chapters);

    ref.watch(_fetchReadChaptersRedunProvider(manga));

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

    final chapters = ref.watch(mangaChaptersProvider(manga));
    final covers = ref.watch(mangaCoversProvider(manga));

    final isLoading = chapters.isLoading || covers.isLoading;

    String? lastvolchap;

    if ((manga.attributes.lastVolume != null &&
            manga.attributes.lastVolume!.isNotEmpty) ||
        (manga.attributes.lastChapter != null &&
            manga.attributes.lastChapter!.isNotEmpty)) {
      lastvolchap = '';

      if (manga.attributes.lastVolume != null &&
          manga.attributes.lastVolume!.isNotEmpty) {
        lastvolchap += 'Volume ${manga.attributes.lastVolume}';
      }

      if (manga.attributes.lastChapter != null &&
          manga.attributes.lastChapter!.isNotEmpty) {
        lastvolchap +=
            '${lastvolchap.isEmpty ? '' : ', '}Chapter ${manga.attributes.lastChapter!}';
      }
    }

    useEffect(() {
      void controllerAtEdge() {
        if (scrollController.position.atEdge &&
            scrollController.position.pixels ==
                scrollController.position.maxScrollExtent) {
          switch (view.value) {
            case _ViewType.chapters:
              ref.read(mangaChaptersProvider(manga).notifier).getMore();
              break;
            case _ViewType.art:
              ref.read(mangaCoversProvider(manga).notifier).getMore();
            default:
              break;
          }
        }
      }

      scrollController.addListener(controllerAtEdge);
      return () => scrollController.removeListener(controllerAtEdge);
    }, [scrollController]);

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          switch (view.value) {
            case _ViewType.chapters:
              return await ref.refresh(mangaChaptersProvider(manga).future);
            case _ViewType.art:
              return await ref.refresh(mangaCoversProvider(manga).future);
            default:
              break;
          }
        },
        child: CustomScrollView(
          controller: scrollController,
          scrollBehavior: MouseTouchScrollBehavior(),
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              snap: false,
              floating: false,
              expandedHeight: 200.0,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  manga.attributes.title.get('en'),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(2.0, 2.0),
                        blurRadius: 1.0,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ],
                  ),
                ),
                background: ExtendedImage.network(
                  manga.getFirstCoverUrl(quality: CoverArtQuality.medium),
                  cache: true,
                  colorBlendMode: BlendMode.modulate,
                  color: Colors.grey,
                  fit: BoxFit.cover,
                  loadStateChanged: extendedImageLoadStateHandler,
                ),
              ),
              actions: () {
                if (!loggedin) {
                  return null;
                }

                final actions = <Widget>[];

                final following =
                    ref.watch(followingStatusProvider(manga)).valueOrNull;
                final readProvider = ref.watch(readingStatusProvider(manga));
                final ratingProv = ref.watch(ratingsProvider);
                final reading = readProvider.valueOrNull;
                final ratings = ratingProv.valueOrNull;

                if (following == null || readProvider.isLoading) {
                  actions.add(const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(),
                    ),
                  ));
                } else if (!following && reading == null) {
                  actions.addAll([
                    ElevatedButton(
                      onPressed: () async {
                        final result = await showDialog<
                                (MangaReadingStatus, bool)>(
                            context: context,
                            builder: (BuildContext context) {
                              return HookBuilder(
                                builder: (context) {
                                  final nav = Navigator.of(context);
                                  final nreading =
                                      useState(MangaReadingStatus.plan_to_read);
                                  final nfollowing = useState(true);

                                  return AlertDialog(
                                    title: const Text('Add to Library'),
                                    content: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        DropdownButton<MangaReadingStatus>(
                                          value: nreading.value,
                                          icon:
                                              const Icon(Icons.arrow_drop_down),
                                          iconSize: 24,
                                          elevation: 16,
                                          underline: Container(
                                            height: 2,
                                            color: Colors.deepOrangeAccent,
                                          ),
                                          onChanged: (MangaReadingStatus?
                                              status) async {
                                            if (status != null) {
                                              nreading.value = status;
                                            }
                                          },
                                          items: List<
                                              DropdownMenuItem<
                                                  MangaReadingStatus>>.generate(
                                            MangaReadingStatus.values.length -
                                                1,
                                            (int index) => DropdownMenuItem<
                                                MangaReadingStatus>(
                                              value: MangaReadingStatus.values
                                                  .elementAt(index + 1),
                                              child: Text(
                                                MangaReadingStatus.values
                                                    .elementAt(index + 1)
                                                    .formatted,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        ElevatedButton(
                                          onPressed: () async {
                                            nfollowing.value =
                                                !nfollowing.value;
                                          },
                                          child: Icon(nfollowing.value
                                              ? Icons.notification_add
                                              : Icons
                                                  .notifications_off_outlined),
                                        ),
                                      ],
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text('Cancel'),
                                        onPressed: () {
                                          nav.pop(null);
                                        },
                                      ),
                                      ElevatedButton(
                                        child: const Text('Add'),
                                        onPressed: () {
                                          nav.pop((
                                            nreading.value,
                                            nfollowing.value
                                          ));
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            });

                        if (result != null) {
                          ref
                              .read(readingStatusProvider(manga).notifier)
                              .set(result.$1);

                          ref
                              .read(followingStatusProvider(manga).notifier)
                              .set(result.$2);
                        }
                      },
                      child: const Text('Add to Library'),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ]);
                } else {
                  actions.addAll([
                    Tooltip(
                      message: following ? 'Unfollow Manga' : 'Follow Manga',
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(6.0)),
                          ),
                        ),
                        onPressed: () async {
                          bool set = !following;
                          ref
                              .read(followingStatusProvider(manga).notifier)
                              .set(set);
                        },
                        child: Icon(following
                            ? Icons.notifications_active
                            : Icons.notifications_off_outlined),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4.0)),
                        color: theme.colorScheme.background.withAlpha(200),
                      ),
                      child: DropdownButton<MangaReadingStatus>(
                        value: reading,
                        icon: const Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 16,
                        underline: Container(
                          height: 2,
                          color: Colors.deepOrangeAccent,
                        ),
                        onChanged: (MangaReadingStatus? status) async {
                          ref
                              .read(readingStatusProvider(manga).notifier)
                              .set(status);

                          if (status == null ||
                              status == MangaReadingStatus.remove) {
                            ref
                                .read(followingStatusProvider(manga).notifier)
                                .set(false);
                          }
                        },
                        items:
                            List<DropdownMenuItem<MangaReadingStatus>>.generate(
                          MangaReadingStatus.values.length,
                          (int index) => DropdownMenuItem<MangaReadingStatus>(
                            value: MangaReadingStatus.values.elementAt(index),
                            child: Text(
                              MangaReadingStatus.values
                                  .elementAt(index)
                                  .formatted,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]);
                }

                if (ratingProv.isLoading || ratings == null) {
                  actions.add(const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(),
                    ),
                  ));
                } else {
                  actions.addAll([
                    PopupMenuButton<int>(
                      shape: const RoundedRectangleBorder(),
                      tooltip: 'Rating',
                      icon: Container(
                        padding: const EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          color: ratings.containsKey(manga.id)
                              ? Colors.deepOrange
                              : Colors.grey.shade600,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(6.0)),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.star_border),
                            if (ratings.containsKey(manga.id)) ...[
                              const SizedBox(
                                width: 4.0,
                              ),
                              Text('${ratings[manga.id]!.rating}')
                            ]
                          ],
                        ),
                      ),
                      onSelected: (value) {
                        ref
                            .read(ratingsProvider.notifier)
                            .set(manga, value > 0 ? value : null);
                      },
                      itemBuilder: (context) {
                        final items = List.generate(
                          10,
                          (index) => PopupMenuItem<int>(
                            value: index + 1,
                            child: Text('${index + 1}'),
                          ),
                        ).reversed.toList();

                        items.add(const PopupMenuItem<int>(
                          value: 0,
                          child: Text('Remove'),
                        ));

                        return items;
                      },
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ]);
                }

                return actions;
              }(),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(8),
                color: theme.cardColor,
                child: Wrap(
                  spacing: 4.0,
                  runSpacing: 4.0,
                  children: [
                    ContentRatingChip(rating: manga.attributes.contentRating),
                    const SizedBox(
                      width: 2,
                    ),
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
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(8),
                color: theme.cardColor,
                child: Consumer(
                  builder: (context, ref, child) {
                    final stats = ref.watch(statisticsProvider);
                    return Wrap(
                      runSpacing: 4.0,
                      children: [
                        ...switch (stats) {
                          // ignore: unused_local_variable
                          AsyncValue(:final error?, :final stackTrace?) => [
                              const SizedBox(
                                width: 10,
                              ),
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
                                const SizedBox(
                                  width: 10,
                                ),
                                const IconTextChip(
                                  text: Text(statsError),
                                )
                              ];
                            }(),
                          _ => [
                              const SizedBox(
                                width: 10,
                              ),
                              const IconTextChip(
                                text: CircularProgressIndicator(),
                              )
                            ],
                        },
                        const SizedBox(width: 10),
                        MangaStatusChip(status: manga.attributes.status),
                      ],
                    );
                  },
                ),
              ),
            ),
            if (manga.attributes.altTitles.isNotEmpty)
              SliverToBoxAdapter(
                child: ExpansionTile(
                  title: const Text('Alt. Titles'),
                  children: [
                    for (final Map(entries: entry)
                        in manga.attributes.altTitles)
                      ExpansionTile(
                        title: Text(Languages.get(entry.first.key).name),
                        children: [
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(8),
                            color: theme.colorScheme.surfaceVariant,
                            child: Text(entry.first.value),
                          ),
                        ],
                      )
                  ],
                ),
              ),
            if (manga.attributes.description.isNotEmpty)
              SliverToBoxAdapter(
                child: ExpansionTile(
                  title: const Text('Synopsis'),
                  children: [
                    for (final MapEntry(key: lang, value: desc)
                        in manga.attributes.description.entries)
                      ExpansionTile(
                        title: Text(Languages.get(lang).name),
                        children: [
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(8),
                            color: theme.colorScheme.surfaceVariant,
                            child: MarkdownBody(
                              data: desc,
                            ),
                          ),
                        ],
                      )
                  ],
                ),
              ),
            SliverToBoxAdapter(
              child: ExpansionTile(
                title: const Text('Info'),
                children: [
                  if (manga.author != null)
                    ExpansionTile(
                      expandedAlignment: Alignment.centerLeft,
                      title: const Text('Author'),
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          color: theme.colorScheme.background,
                          child: Wrap(
                            spacing: 4.0,
                            runSpacing: 4.0,
                            children: manga.author!
                                .map((e) => ButtonChip(
                                      text: Text(e.attributes.name),
                                      onPressed: () {
                                        nav.push(createCreatorViewRoute(e));
                                      },
                                    ))
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  if (manga.artist != null)
                    ExpansionTile(
                      expandedAlignment: Alignment.centerLeft,
                      title: const Text('Artist'),
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          color: theme.colorScheme.background,
                          child: Wrap(
                            spacing: 4.0,
                            runSpacing: 4.0,
                            children: manga.artist!
                                .map((e) => ButtonChip(
                                      text: Text(e.attributes.name),
                                      onPressed: () {
                                        nav.push(createCreatorViewRoute(e));
                                      },
                                    ))
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  if (manga.attributes.publicationDemographic != null)
                    ExpansionTile(
                      title: const Text('Demograhic'),
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          color: theme.colorScheme.background,
                          child: Row(
                            children: [
                              IconTextChip(
                                text: Text(manga.attributes
                                    .publicationDemographic!.formatted),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  if (manga.attributes.tags.isNotEmpty)
                    ExpansionTile(
                      expandedAlignment: Alignment.centerLeft,
                      title: const Text('Genres'),
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          color: theme.colorScheme.background,
                          child: Wrap(
                            spacing: 4.0,
                            runSpacing: 4.0,
                            children: manga.attributes.tags
                                .where((tag) =>
                                    tag.attributes.group == TagGroup.genre)
                                .map((e) => IconTextChip(
                                    text: Text(e.attributes.name.get('en'))))
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  if (manga.attributes.tags.isNotEmpty)
                    ExpansionTile(
                      expandedAlignment: Alignment.centerLeft,
                      title: const Text('Themes'),
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          color: theme.colorScheme.background,
                          child: Wrap(
                            spacing: 4.0,
                            runSpacing: 4.0,
                            children: manga.attributes.tags
                                .where((tag) =>
                                    tag.attributes.group == TagGroup.theme)
                                .map((e) => IconTextChip(
                                    text: Text(e.attributes.name.get('en'))))
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  if (manga.attributes.links != null)
                    ExpansionTile(
                      expandedAlignment: Alignment.centerLeft,
                      title: const Text('Track'),
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          color: theme.colorScheme.background,
                          child: Wrap(
                            spacing: 4.0,
                            runSpacing: 4.0,
                            children: [
                              if (manga.attributes.links?.raw != null)
                                ButtonChip(
                                  onPressed: () async {
                                    final url = manga.attributes.links!.raw!;
                                    if (!await launchUrl(Uri.parse(url))) {
                                      throw 'Could not launch $url';
                                    }
                                  },
                                  text: const Text('Official Raw'),
                                ),
                              if (manga.attributes.links?.mu != null)
                                ButtonChip(
                                  onPressed: () async {
                                    final seriesnum = int.tryParse(
                                        manga.attributes.links!.mu!);
                                    var url =
                                        'https://www.mangaupdates.com/series/${manga.attributes.links!.mu!}';

                                    if (seriesnum != null) {
                                      url =
                                          'https://www.mangaupdates.com/series.html?id=${manga.attributes.links!.mu!}';
                                    }

                                    if (!await launchUrl(Uri.parse(url))) {
                                      throw 'Could not launch $url';
                                    }
                                  },
                                  text: const Text('MangaUpdates'),
                                ),
                              if (manga.attributes.links?.al != null)
                                ButtonChip(
                                  onPressed: () async {
                                    final url =
                                        'https://anilist.co/manga/${manga.attributes.links!.al!}';
                                    if (!await launchUrl(Uri.parse(url))) {
                                      throw 'Could not launch $url';
                                    }
                                  },
                                  text: const Text('AniList'),
                                ),
                              if (manga.attributes.links?.mal != null)
                                ButtonChip(
                                  onPressed: () async {
                                    final url =
                                        'https://myanimelist.net/manga/${manga.attributes.links!.mal!}';
                                    if (!await launchUrl(Uri.parse(url))) {
                                      throw 'Could not launch $url';
                                    }
                                  },
                                  text: const Text('MyAnimeList'),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  if (lastvolchap != null)
                    ExpansionTile(
                      title: const Text('Final Volume/Chapter'),
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          color: theme.colorScheme.background,
                          child: Row(
                            children: [
                              Text(lastvolchap),
                            ],
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(8),
                color: theme.cardColor,
                child: ToggleButtons(
                  isSelected: List<bool>.generate(_ViewType.values.length,
                      (index) => view.value.index == index),
                  onPressed: (index) {
                    view.value = _ViewType.values.elementAt(index);
                  },
                  textStyle: const TextStyle(fontSize: 24),
                  borderRadius: const BorderRadius.all(Radius.circular(2.0)),
                  children: [
                    ..._ViewType.values
                        .map((e) => Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Text(e.name.capitalize())))
                        .toList()
                  ],
                ),
              ),
            ),
            if (view.value == _ViewType.chapters)
              switch (chapters) {
                AsyncValue(:final error?, :final stackTrace?) => () {
                    final messenger = ScaffoldMessenger.of(context);
                    Styles.showErrorSnackBar(messenger, '$error');
                    logger.e("mangaChaptersProvider(${manga.id}) failed",
                        error: error, stackTrace: stackTrace);

                    return SliverToBoxAdapter(
                      child: Styles.errorColumn(error, stackTrace),
                    );
                  }(),
                AsyncValue(:final value?) => SliverList.builder(
                    itemBuilder: (BuildContext context, int index) {
                      var lastChapIsSame = false;
                      var nextChapIsSame = false;

                      final thischap = value.elementAt(index);
                      final chapbtn = ChapterButtonWidget(
                        chapter: thischap,
                        manga: manga,
                        loggedin: loggedin,
                        isRead: switch (readData) {
                          null => null,
                          _ =>
                            readData[manga.id]?.contains(thischap.id) == true,
                        },
                        link: Text(
                          manga.attributes.title.get('en'),
                          style: const TextStyle(fontSize: 24),
                        ),
                      );

                      if (index > 0) {
                        lastChapIsSame =
                            value.elementAt(index - 1).attributes.chapter ==
                                thischap.attributes.chapter;
                      }

                      if (index < value.length - 1) {
                        nextChapIsSame =
                            value.elementAt(index + 1).attributes.chapter ==
                                thischap.attributes.chapter;
                      }

                      if (lastChapIsSame || nextChapIsSame) {
                        Widget child = Row(
                          children: [
                            const Icon(
                              Icons.subdirectory_arrow_right,
                              size: 15.0,
                            ),
                            Flexible(
                              child: chapbtn,
                            ),
                          ],
                        );

                        if (!lastChapIsSame && nextChapIsSame) {
                          child = Wrap(
                            children: [
                              Text("Chapter ${thischap.attributes.chapter}"),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.subdirectory_arrow_right,
                                    size: 15.0,
                                  ),
                                  Flexible(
                                    child: chapbtn,
                                  ),
                                ],
                              ),
                            ],
                          );
                        }

                        return Padding(
                          padding: EdgeInsets.only(
                              top: (!lastChapIsSame && nextChapIsSame)
                                  ? 6.0
                                  : 2.0,
                              bottom: (lastChapIsSame && !nextChapIsSame)
                                  ? 6.0
                                  : 2.0),
                          child: child,
                        );
                      }

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: chapbtn,
                      );
                    },
                    itemCount: value.length,
                  ),
                _ => const SliverToBoxAdapter(
                    child: SizedBox.shrink(),
                  ),
              },
            if (view.value == _ViewType.art)
              switch (covers) {
                AsyncValue(:final error?, :final stackTrace?) => () {
                    final messenger = ScaffoldMessenger.of(context);
                    Styles.showErrorSnackBar(messenger, '$error');
                    logger.e("mangaCoversProvider(${manga.id}) failed",
                        error: error, stackTrace: stackTrace);

                    return SliverToBoxAdapter(
                      child: Styles.errorColumn(error, stackTrace),
                    );
                  }(),
                AsyncValue(:final value?) => SliverGrid.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 256,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      childAspectRatio: 0.7,
                    ),
                    itemBuilder: (context, index) {
                      final cover = value.elementAt(index);
                      return _CoverArtItem(
                        cover: cover,
                        manga: manga,
                        page: index,
                        onTap: () async {
                          await showModal(
                            context: context,
                            builder: (context) {
                              return Scaffold(
                                appBar: AppBar(
                                  backgroundColor: Colors.transparent,
                                  leading: const CloseButton(),
                                ),
                                backgroundColor: Colors.transparent,
                                extendBody: true,
                                extendBodyBehindAppBar: true,
                                body: PageView.builder(
                                  scrollBehavior: MouseTouchScrollBehavior(),
                                  itemBuilder: (BuildContext context, int id) {
                                    final item = value.elementAt(id);
                                    final url = manga.getUrlFromCover(item);
                                    Widget image = ExtendedImage.network(
                                      url,
                                      fit: BoxFit.contain,
                                      mode: ExtendedImageMode.gesture,
                                      enableSlideOutPage: true,
                                      loadStateChanged:
                                          extendedImageLoadStateHandler,
                                    );

                                    image = Container(
                                      padding: const EdgeInsets.all(5.0),
                                      color: Colors.transparent,
                                      child: GestureDetector(
                                        child: image,
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    );

                                    if (id == index) {
                                      return Hero(
                                        tag: url,
                                        child: image,
                                      );
                                    } else {
                                      return image;
                                    }
                                  },
                                  itemCount: value.length,
                                  controller: PageController(
                                    initialPage: index,
                                  ),
                                  scrollDirection: Axis.horizontal,
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                    itemCount: value.length,
                  ),
                _ => const SliverToBoxAdapter(
                    child: SizedBox.shrink(),
                  ),
              },
            if (isLoading)
              const SliverToBoxAdapter(
                child: Styles.listSpinner,
              ),
          ],
        ),
      ),
    );
  }
}

class _CoverArtItem extends StatelessWidget {
  const _CoverArtItem({
    required this.cover,
    required this.manga,
    required this.page,
    this.onTap,
  });

  final Cover cover;
  final Manga manga;
  final int page;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final url = manga.getUrlFromCover(cover);

    final Widget image = Material(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4.0))),
      clipBehavior: Clip.antiAlias,
      child: ExtendedImage.network(
        url.quality(quality: CoverArtQuality.medium),
        cache: true,
        loadStateChanged: extendedImageLoadStateHandler,
        width: 256.0,
      ),
    );

    return Hero(
      tag: url,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: GridTile(
            footer: cover.attributes?.volume != null
                ? SizedBox(
                    height: 40,
                    child: Material(
                      color: Colors.transparent,
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(4)),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: GridTileBar(
                        backgroundColor: Colors.black45,
                        title: Text(
                          'Volume ${cover.attributes!.volume!}',
                          softWrap: true,
                          style: const TextStyle(
                            overflow: TextOverflow.fade,
                          ),
                        ),
                      ),
                    ),
                  )
                : null,
            child: image,
          ),
        ),
      ),
    );
  }
}
