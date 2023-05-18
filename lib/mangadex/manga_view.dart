import 'package:animations/animations.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/mangadex/model.dart';
import 'package:gagaku/mangadex/types.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:gagaku/ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'manga_view.g.dart';

Route createMangaViewRoute(Manga manga) {
  return Styles.buildSharedAxisTransitionRoute(
    (context, animation, secondaryAnimation) => MangaDexMangaViewWidget(
      manga: manga,
    ),
    SharedAxisTransitionType.scaled,
  );
}

@riverpod
Future<_FetchMangaChaptersResult> _fetchMangaViewChapters(
    _FetchMangaViewChaptersRef ref, Manga manga) async {
  final following = await ref.watch(followingStatusProvider(manga).future);
  await Future.delayed(const Duration(milliseconds: 100));

  final reading = await ref.watch(readingStatusProvider(manga).future);
  await Future.delayed(const Duration(milliseconds: 100));

  await ref.watch(readChaptersProvider.notifier).get([manga]);
  await Future.delayed(const Duration(milliseconds: 100));

  await ref.watch(statisticsProvider.notifier).get([manga]);
  await Future.delayed(const Duration(milliseconds: 100));

  final chapters = await ref.watch(mangaChaptersProvider(manga).future);

  return _FetchMangaChaptersResult(chapters, following, reading);
}

class _FetchMangaChaptersResult {
  _FetchMangaChaptersResult(this.chapters, this.following, this.reading);

  Iterable<Chapter> chapters;
  bool following;
  MangaReadingStatus? reading;
}

class MangaDexMangaViewWidget extends HookConsumerWidget {
  const MangaDexMangaViewWidget({Key? key, required this.manga})
      : super(key: key);

  final Manga manga;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();
    final theme = Theme.of(context);

    useEffect(() {
      void controllerAtEdge() {
        if (scrollController.position.atEdge) {
          if (scrollController.position.pixels != 0) {
            ref.read(mangaChaptersProvider(manga).notifier).getMore();
          }
        }
      }

      scrollController.addListener(controllerAtEdge);
      return () => scrollController.removeListener(controllerAtEdge);
    }, [scrollController]);

    return Scaffold(
      body: Consumer(
        builder: (context, ref, child) {
          final chapters = ref.watch(_fetchMangaViewChaptersProvider(manga));
          return chapters.when(
            skipLoadingOnReload: true,
            data: (result) {
              return CustomScrollView(
                controller: scrollController,
                scrollBehavior: MouseTouchScrollBehavior(),
                slivers: <Widget>[
                  SliverAppBar(
                    pinned: true,
                    snap: false,
                    floating: false,
                    expandedHeight: 180.0,
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
                        manga.getCovertArtUrl(quality: CoverArtQuality.medium),
                        cache: true,
                        colorBlendMode: BlendMode.modulate,
                        color: Colors.grey,
                        fit: BoxFit.cover,
                        loadStateChanged: extendedImageLoadStateHandler,
                      ),
                    ),
                    actions: [
                      ...(() {
                        if (!result.following && result.reading == null) {
                          return [
                            ElevatedButton(
                              onPressed: () async {
                                ref
                                    .read(readingStatusProvider(manga).notifier)
                                    .set(MangaReadingStatus.plan_to_read);

                                ref
                                    .read(
                                        followingStatusProvider(manga).notifier)
                                    .set(true);
                              },
                              child: const Text('Add to Library'),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ];
                        } else {
                          return [
                            Tooltip(
                              message: result.following
                                  ? 'Unfollow Manga'
                                  : 'Follow Manga',
                              child: ElevatedButton(
                                onPressed: () async {
                                  bool set = !result.following;
                                  ref
                                      .read(followingStatusProvider(manga)
                                          .notifier)
                                      .set(set);
                                },
                                child: Icon(result.following
                                    ? Icons.favorite
                                    : Icons.favorite_border),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color:
                                    theme.colorScheme.background.withAlpha(200),
                              ),
                              child: DropdownButton<MangaReadingStatus>(
                                value: result.reading,
                                icon: const Icon(Icons.arrow_drop_down),
                                iconSize: 24,
                                elevation: 16,
                                underline: Container(
                                  height: 2,
                                  color: Colors.deepOrangeAccent,
                                ),
                                onChanged: (MangaReadingStatus? status) async {
                                  ref
                                      .read(
                                          readingStatusProvider(manga).notifier)
                                      .set(status);

                                  if (status == null ||
                                      status == MangaReadingStatus.remove) {
                                    ref
                                        .read(followingStatusProvider(manga)
                                            .notifier)
                                        .set(false);
                                  }
                                },
                                items: List<
                                    DropdownMenuItem<
                                        MangaReadingStatus>>.generate(
                                  MangaReadingStatus.values.length,
                                  (int index) =>
                                      DropdownMenuItem<MangaReadingStatus>(
                                    value: MangaReadingStatus.values
                                        .elementAt(index),
                                    child: Text(
                                      MangaReadingStatus.values
                                          .elementAt(index)
                                          .formatted,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ];
                        }
                      }())
                    ],
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      color: theme.cardColor,
                      child: Consumer(
                        builder: (context, ref, child) {
                          final stats = ref.watch(statisticsProvider);
                          return Row(
                            children: [
                              ContentRatingChip(
                                  rating: manga.attributes.contentRating),
                              ...stats.when(
                                skipLoadingOnReload: true,
                                data: (data) {
                                  if (data.containsKey(manga.id)) {
                                    return [
                                      const SizedBox(
                                        width: 10,
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
                                        width: 10,
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
                                      width: 10,
                                    ),
                                    const IconTextChip(
                                      text: Text('Error Retrieving Stats'),
                                    )
                                  ];
                                },
                                error: (obj, stack) => [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const IconTextChip(
                                    text: Text('Error Retrieving Stats'),
                                  )
                                ],
                                loading: () => [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const IconTextChip(
                                    text: CircularProgressIndicator(),
                                  )
                                ],
                              ),
                              const SizedBox(width: 10),
                              MangaStatusChip(status: manga.attributes.status),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  if (manga.attributes.description.isNotEmpty)
                    SliverToBoxAdapter(
                      child: ExpansionTile(
                        title: const Text('Synopsis'),
                        children: [
                          for (final entry
                              in manga.attributes.description.entries)
                            ExpansionTile(
                              title: Text(Languages.get(entry.key).name),
                              children: [
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(8),
                                  color: theme.colorScheme.background,
                                  child: Text(entry.value),
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
                            title: const Text('Author'),
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                color: theme.colorScheme.background,
                                child: Row(
                                  children: [
                                    IconTextChip(
                                      text: Text(manga.author!),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        if (manga.artist != null)
                          ExpansionTile(
                            title: const Text('Artist'),
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                color: theme.colorScheme.background,
                                child: Row(
                                  children: [
                                    IconTextChip(
                                      text: Text(manga.artist!),
                                    )
                                  ],
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
                            title: const Text('Genres'),
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                color: theme.colorScheme.background,
                                child: Row(
                                  children: manga.attributes.tags
                                      .where((tag) =>
                                          tag.attributes.group ==
                                          TagGroup.genre)
                                      .map((e) => Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 2),
                                            child: IconTextChip(
                                                text: Text(e.attributes.name
                                                    .get('en'))),
                                          ))
                                      .toList(),
                                ),
                              ),
                            ],
                          ),
                        if (manga.attributes.tags.isNotEmpty)
                          ExpansionTile(
                            title: const Text('Themes'),
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                color: theme.colorScheme.background,
                                child: Row(
                                  children: manga.attributes.tags
                                      .where((tag) =>
                                          tag.attributes.group ==
                                          TagGroup.theme)
                                      .map((e) => Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 2),
                                            child: IconTextChip(
                                                text: Text(e.attributes.name
                                                    .get('en'))),
                                          ))
                                      .toList(),
                                ),
                              ),
                            ],
                          ),
                        if (manga.attributes.lastChapter != null &&
                            manga.attributes.lastChapter!.isNotEmpty)
                          ExpansionTile(
                            title: const Text('Final Chapter'),
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                color: theme.colorScheme.background,
                                child: Row(
                                  children: [
                                    Text(manga.attributes.lastVolume != null &&
                                            manga.attributes.lastVolume!
                                                .isNotEmpty
                                        ? 'Volume ${manga.attributes.lastVolume}, Chapter ${manga.attributes.lastChapter}'
                                        : 'Chapter ${manga.attributes.lastChapter}')
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
                      child: const Text(
                        'Chapters',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        var lastChapIsSame = false;
                        var nextChapIsSame = false;

                        final thischap = result.chapters.elementAt(index);
                        final chapbtn = ChapterButtonWidget(
                          chapter: thischap,
                          manga: manga,
                          link: Text(
                            manga.attributes.title.get('en'),
                            style: const TextStyle(fontSize: 24),
                          ),
                        );

                        if (index > 0) {
                          lastChapIsSame = result.chapters
                                  .elementAt(index - 1)
                                  .attributes
                                  .chapter ==
                              thischap.attributes.chapter;
                        }

                        if (index < result.chapters.length - 1) {
                          nextChapIsSame = result.chapters
                                  .elementAt(index + 1)
                                  .attributes
                                  .chapter ==
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
                      childCount: result.chapters.length,
                    ),
                  ),
                ],
              );
            },
            loading: () => const Center(
              child: CircularProgressIndicator(),
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

              return Text('Error: $err');
            },
          );
        },
      ),
    );
  }
}
