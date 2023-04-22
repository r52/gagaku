import 'package:cached_network_image/cached_network_image.dart';
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
  return Styles.buildSlideTransitionRoute(
      (context, animation, secondaryAnimation) => MangaDexMangaViewWidget(
            manga: manga,
          ));
}

@riverpod
Future<_FetchMangaChaptersResult> _fetchMangaViewChapters(
    _FetchMangaViewChaptersRef ref, Manga manga) async {
  final following = await ref.watch(fetchFollowingMangaProvider(manga).future);
  final reading = await ref.watch(fetchReadingStatusProvider(manga).future);
  ref.read(readChaptersProvider.notifier).get([manga]);
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
    final api = ref.watch(mangadexProvider);
    final scrollController = useScrollController();
    final refresh = useState(0);
    final theme = Theme.of(context);

    final author = useRef(manga.getAuthor());
    final artist = useRef(manga.getArtist());

    final result = ref.watch(_fetchMangaViewChaptersProvider(manga));

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
      body: result.when(
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
                  background: CachedNetworkImage(
                    colorBlendMode: BlendMode.modulate,
                    color: Colors.grey,
                    fit: BoxFit.cover,
                    imageUrl:
                        manga.getCovertArtUrl(quality: CoverArtQuality.medium),
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                actions: [
                  ...(() {
                    if (!result.following && result.reading == null) {
                      return [
                        ElevatedButton(
                          onPressed: () async {
                            bool success = await api.setMangaReadingStatus(
                                manga, MangaReadingStatus.plan_to_read);

                            if (success) {
                              success =
                                  await api.setMangaFollowing(manga, true);
                            }

                            if (success) {
                              refresh.value++;
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
                          message: result.following
                              ? 'Unfollow Manga'
                              : 'Follow Manga',
                          child: ElevatedButton(
                            onPressed: () async {
                              bool set = !result.following;
                              bool success =
                                  await api.setMangaFollowing(manga, set);

                              if (success) {
                                success = await api.setMangaReadingStatus(
                                    manga, null);
                              }

                              if (success) {
                                refresh.value++;
                              }
                            },
                            child: Icon(result.following
                                ? Icons.favorite
                                : Icons.favorite_border),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        DropdownButton<MangaReadingStatus>(
                          value: result.reading,
                          icon: const Icon(Icons.arrow_drop_down),
                          iconSize: 24,
                          elevation: 16,
                          underline: Container(
                            height: 2,
                            color: Colors.deepOrangeAccent,
                          ),
                          onChanged: (MangaReadingStatus? status) async {
                            bool success =
                                await api.setMangaReadingStatus(manga, status);

                            if (success && status == null) {
                              success =
                                  await api.setMangaFollowing(manga, false);
                            }

                            if (success) {
                              refresh.value++;
                            }
                          },
                          items: List<
                              DropdownMenuItem<MangaReadingStatus>>.generate(
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
                  child: Row(
                    children: [
                      MangaStatusChip(status: manga.attributes.status),
                      const SizedBox(
                        width: 10,
                      ),
                      ContentRatingChip(rating: manga.attributes.contentRating),
                    ],
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
                    if (author.value != null)
                      ExpansionTile(
                        title: const Text('Author'),
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            color: theme.colorScheme.background,
                            child: Row(
                              children: [
                                IconTextChip(
                                  text: Text(author.value!),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    if (artist.value != null)
                      ExpansionTile(
                        title: const Text('Artist'),
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            color: theme.colorScheme.background,
                            child: Row(
                              children: [
                                IconTextChip(
                                  text: Text(artist.value!),
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
                                            text: Text(
                                                e.attributes.name.get('en'))),
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
                                            text: Text(
                                                e.attributes.name.get('en'))),
                                      ))
                                  .toList(),
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
                    var e = result.chapters.elementAt(index);

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: ChapterButtonWidget(
                        chapter: e,
                        manga: manga,
                        link: Text(
                          manga.attributes.title.get('en'),
                          style: const TextStyle(fontSize: 24),
                        ),
                      ),
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
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Text('$err'),
              backgroundColor: Colors.red,
            ));

          return Text('Error: $err');
        },
      ),
    );
  }
}
