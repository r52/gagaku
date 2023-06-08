import 'package:animations/animations.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/mangadex/model.dart';
import 'package:gagaku/mangadex/types.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:gagaku/ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Route createMangaViewRoute(Manga manga) {
  return Styles.buildSharedAxisTransitionRoute(
    (context, animation, secondaryAnimation) => MangaDexMangaViewWidget(
      manga: manga,
    ),
    SharedAxisTransitionType.scaled,
  );
}

class MangaDexMangaViewWidget extends HookConsumerWidget {
  const MangaDexMangaViewWidget({Key? key, required this.manga})
      : super(key: key);

  final Manga manga;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authControlProvider);
    final loggedin =
        auth.maybeWhen(data: (loggedin) => loggedin, orElse: () => false);
    final scrollController = useScrollController();
    final theme = Theme.of(context);

    Map<String, Set<String>> readData = {};

    if (loggedin) {
      readData = ref.watch(readChaptersProvider).maybeWhen(
          skipLoadingOnReload: true, data: (data) => data, orElse: () => {});
    }

    final chapters = ref.watch(mangaChaptersProvider(manga));
    final isLoading = chapters.maybeWhen(
      loading: () => true,
      orElse: () => false,
    );

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
          ref.read(mangaChaptersProvider(manga).notifier).getMore();
        }
      }

      scrollController.addListener(controllerAtEdge);
      return () => scrollController.removeListener(controllerAtEdge);
    }, [scrollController]);

    return Scaffold(
      body: CustomScrollView(
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
                manga.getFirstCoverUrl(quality: CoverArtQuality.medium),
                cache: true,
                colorBlendMode: BlendMode.modulate,
                color: Colors.grey,
                fit: BoxFit.cover,
                loadStateChanged: extendedImageLoadStateHandler,
              ),
            ),
            actions: () {
              if (loggedin) {
                final following =
                    ref.watch(followingStatusProvider(manga)).maybeWhen(
                          data: (following) => following,
                          orElse: () => false,
                        );
                final reading =
                    ref.watch(readingStatusProvider(manga)).maybeWhen(
                          data: (reading) => reading,
                          orElse: () => null,
                        );

                if (!following && reading == null) {
                  return [
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
                                              ? Icons.favorite
                                              : Icons.favorite_border),
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
                  ];
                } else {
                  return [
                    Tooltip(
                      message: following ? 'Unfollow Manga' : 'Follow Manga',
                      child: ElevatedButton(
                        onPressed: () async {
                          bool set = !following;
                          ref
                              .read(followingStatusProvider(manga).notifier)
                              .set(set);
                        },
                        child: Icon(
                            following ? Icons.favorite : Icons.favorite_border),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
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
                    const SizedBox(
                      width: 10,
                    ),
                  ];
                }
              }

              return <Widget>[];
            }(),
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
                      ContentRatingChip(rating: manga.attributes.contentRating),
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
                                width: 10,
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
                            const SizedBox(
                              width: 10,
                            ),
                            const IconTextChip(
                              text: Text(statsError),
                            )
                          ];
                        },
                        error: (obj, stack) => [
                          const SizedBox(
                            width: 10,
                          ),
                          const IconTextChip(
                            text: Text(statsError),
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
                  for (final entry in manga.attributes.description.entries)
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
                                  tag.attributes.group == TagGroup.genre)
                              .map((e) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 2),
                                    child: IconTextChip(
                                        text:
                                            Text(e.attributes.name.get('en'))),
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
                                  tag.attributes.group == TagGroup.theme)
                              .map((e) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 2),
                                    child: IconTextChip(
                                        text:
                                            Text(e.attributes.name.get('en'))),
                                  ))
                              .toList(),
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
              child: const Text(
                'Chapters',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
          chapters.when(
            skipLoadingOnReload: true,
            data: (result) {
              return SliverList.builder(
                itemBuilder: (BuildContext context, int index) {
                  var lastChapIsSame = false;
                  var nextChapIsSame = false;

                  final thischap = result.elementAt(index);
                  final chapbtn = ChapterButtonWidget(
                    chapter: thischap,
                    manga: manga,
                    loggedin: loggedin,
                    isRead: readData.containsKey(manga.id) &&
                        readData[manga.id]?.contains(thischap.id) == true,
                    link: Text(
                      manga.attributes.title.get('en'),
                      style: const TextStyle(fontSize: 24),
                    ),
                  );

                  if (index > 0) {
                    lastChapIsSame =
                        result.elementAt(index - 1).attributes.chapter ==
                            thischap.attributes.chapter;
                  }

                  if (index < result.length - 1) {
                    nextChapIsSame =
                        result.elementAt(index + 1).attributes.chapter ==
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
                          top: (!lastChapIsSame && nextChapIsSame) ? 6.0 : 2.0,
                          bottom:
                              (lastChapIsSame && !nextChapIsSame) ? 6.0 : 2.0),
                      child: child,
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    child: chapbtn,
                  );
                },
                itemCount: result.length,
              );
            },
            loading: () => const SliverToBoxAdapter(
              child: SizedBox.shrink(),
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

              return SliverToBoxAdapter(
                child: Center(
                  child: Column(
                    children: [
                      Text('Error: $err'),
                      Text(stackTrace.toString()),
                    ],
                  ),
                ),
              );
            },
          ),
          if (isLoading)
            const SliverToBoxAdapter(
              child: Styles.listSpinner,
            ),
        ],
      ),
    );
  }
}
