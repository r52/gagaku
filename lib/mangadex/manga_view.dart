import 'package:animations/animations.dart';
import 'package:collection/collection.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:gagaku/mangadex/model.dart';
import 'package:gagaku/mangadex/types.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:gagaku/ui.dart';
import 'package:gagaku/util.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

part 'manga_view.g.dart';

enum _ViewType { chapters, art, related }

const _loadingAction = SizedBox(
  width: 36,
  height: 36,
  child: Padding(
    padding: EdgeInsets.all(8.0),
    child: CircularProgressIndicator(),
  ),
);

Page<dynamic> buildMangaViewPage(BuildContext context, GoRouterState state) {
  final manga = state.extra.asOrNull<Manga>();

  Widget child;

  if (manga != null) {
    child = MangaDexMangaViewWidget(
      manga: manga,
    );
  } else {
    child = QueriedMangaDexMangaViewWidget(
        mangaId: state.pathParameters['mangaId']!);
  }

  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: Styles.scaledSharedAxisTransitionBuilder,
  );
}

@riverpod
Future<Manga> _fetchMangaFromId(
    _FetchMangaFromIdRef ref, String mangaId) async {
  final api = ref.watch(mangadexProvider);
  final manga =
      await api.fetchManga(ids: [mangaId], limit: MangaDexEndpoints.breakLimit);

  await ref.read(statisticsProvider.notifier).get(manga);
  await ref.read(readChaptersProvider.notifier).get(manga);
  await ref.read(ratingsProvider.notifier).get(manga);

  return manga.first;
}

@riverpod
Future<List<Manga>> _fetchRelatedManga(
    _FetchRelatedMangaRef ref, Manga manga) async {
  final related = manga.relatedMangas;

  if (related.isEmpty) {
    return [];
  }

  final api = ref.watch(mangadexProvider);
  final ids = related.map((e) => e.id);
  final mangas =
      await api.fetchManga(ids: ids, limit: MangaDexEndpoints.breakLimit);

  await ref.read(statisticsProvider.notifier).get(mangas);

  ref.disposeAfter(const Duration(minutes: 5));

  return mangas;
}

class QueriedMangaDexMangaViewWidget extends ConsumerWidget {
  const QueriedMangaDexMangaViewWidget({super.key, required this.mangaId});

  final String mangaId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mangaProvider = ref.watch(_fetchMangaFromIdProvider(mangaId));

    return Scaffold(
      body: switch (mangaProvider) {
        AsyncValue(:final error?, :final stackTrace?) => ErrorColumn(
            error: error,
            stackTrace: stackTrace,
            message: "_fetchMangaFromIdProvider($mangaId) failed",
          ),
        AsyncValue(value: final manga?) => MangaDexMangaViewWidget(
            manga: manga,
          ),
        _ => Styles.listSpinner,
      },
    );
  }
}

class MangaDexMangaViewWidget extends HookConsumerWidget {
  const MangaDexMangaViewWidget({super.key, required this.manga});

  final Manga manga;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loggedin = ref.watch(authControlProvider).value ?? false;
    final theme = Theme.of(context);
    final view = useState(_ViewType.chapters);

    final hasRelated = manga.relatedMangas.isNotEmpty;

    String? lastvolchap;

    if ((manga.attributes!.lastVolume != null &&
            manga.attributes!.lastVolume!.isNotEmpty) ||
        (manga.attributes!.lastChapter != null &&
            manga.attributes!.lastChapter!.isNotEmpty)) {
      lastvolchap = '';

      if (manga.attributes!.lastVolume != null &&
          manga.attributes!.lastVolume!.isNotEmpty) {
        lastvolchap += 'Volume ${manga.attributes!.lastVolume}';
      }

      if (manga.attributes!.lastChapter != null &&
          manga.attributes!.lastChapter!.isNotEmpty) {
        lastvolchap +=
            '${lastvolchap.isEmpty ? '' : ', '}Chapter ${manga.attributes!.lastChapter!}';
      }
    }

    final mangaTagChips = useMemoized<Map<TagGroup, List<Widget>>>(() {
      final map =
          manga.attributes!.tags.groupListsBy((tag) => tag.attributes.group);
      return map.map((group, list) {
        if (group == TagGroup.content) {
          return MapEntry(
              group,
              list
                  .map((e) => ContentChip(
                        key: ValueKey(e.id),
                        content: e.attributes.name.get('en'),
                      ))
                  .toList());
        }

        return MapEntry(
            group,
            list
                .map((e) => IconTextChip(
                      key: ValueKey(e.id),
                      text: e.attributes.name.get('en'),
                    ))
                .toList());
      });
    }, [manga]);

    final contentTagChips = useMemoized(() {
      return mangaTagChips[TagGroup.content]?.toList() ?? [];
    }, [manga]);
    final genreTagChips = useMemoized(() {
      final tags = <Widget>[];
      mangaTagChips.forEach((group, list) {
        if (group != TagGroup.content) {
          tags.addAll(list);
        }
      });

      return tags;
    }, [manga]);

    bool onScrollNotification(ScrollEndNotification notification) {
      if (notification.depth == 0 &&
          notification.metrics.axis == Axis.vertical &&
          notification.metrics.axisDirection == AxisDirection.down &&
          notification.metrics.atEdge &&
          notification.metrics.pixels == notification.metrics.maxScrollExtent) {
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

      return false;
    }

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(followingStatusProvider(manga));
          ref.invalidate(readingStatusProvider(manga));

          switch (view.value) {
            case _ViewType.chapters:
              ref.read(mangaChaptersProvider(manga).notifier).clear();
              return ref.refresh(mangaChaptersProvider(manga).future);
            case _ViewType.art:
              ref.read(mangaCoversProvider(manga).notifier).clear();
              return ref.refresh(mangaCoversProvider(manga).future);
            case _ViewType.related:
              return ref.refresh(_fetchRelatedMangaProvider(manga).future);
          }
        },
        notificationPredicate: (notification) {
          // Depth 1 is the top of the NestedScrollView
          return notification.depth == 1;
        },
        child: NestedScrollView(
          scrollBehavior: const MouseTouchScrollBehavior(),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                pinned: true,
                snap: false,
                floating: false,
                forceElevated: innerBoxIsScrolled,
                expandedHeight: 250.0,
                collapsedHeight: 100.0,
                leading: BackButton(
                  onPressed: () {
                    if (context.canPop()) {
                      context.pop();
                    } else {
                      context.go('/');
                    }
                  },
                ),
                flexibleSpace: FlexibleSpaceBar(
                  expandedTitleScale: 3.0,
                  title: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: manga.attributes!.originalLanguage.flag,
                          style: const TextStyle(
                            fontFamily: 'Twemoji',
                            fontSize: 10,
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(0.5, 0.5),
                                blurRadius: 1.0,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ],
                          ),
                        ),
                        const TextSpan(text: ' '),
                        TextSpan(
                          text: manga.attributes!.title.get('en'),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(1.0, 1.0),
                                blurRadius: 1.0,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ],
                          ),
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
                actions: !loggedin
                    ? null
                    : [
                        Consumer(
                          builder: (context, ref, child) {
                            final followProvider =
                                ref.watch(followingStatusProvider(manga));
                            final following = followProvider.value;
                            final statusProvider =
                                ref.watch(readingStatusProvider(manga));
                            final reading = statusProvider.value;

                            if (following == null || statusProvider.isLoading) {
                              return _loadingAction;
                            }

                            if (following == false && reading == null) {
                              return ElevatedButton(
                                style: Styles.buttonStyle(),
                                onPressed: () async {
                                  final result = await showDialog<
                                          (MangaReadingStatus, bool)>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return _AddToLibraryDialog();
                                      });

                                  if (result != null) {
                                    ref
                                        .read(readingStatusProvider(manga)
                                            .notifier)
                                        .set(result.$1);

                                    ref
                                        .read(followingStatusProvider(manga)
                                            .notifier)
                                        .set(result.$2);
                                  }
                                },
                                child: const Text('Add to Library'),
                              );
                            }

                            if (reading != null) {
                              return Tooltip(
                                message: following
                                    ? 'Unfollow Manga'
                                    : 'Follow Manga',
                                child: ElevatedButton(
                                  style: Styles.buttonStyle(),
                                  onPressed: () async {
                                    bool set = !following;
                                    ref
                                        .read(followingStatusProvider(manga)
                                            .notifier)
                                        .set(set);
                                  },
                                  child: Icon(following
                                      ? Icons.notifications_active
                                      : Icons.notifications_off_outlined),
                                ),
                              );
                            }

                            return const SizedBox.shrink();
                          },
                        ),
                        Consumer(
                          builder: (context, ref, child) {
                            final readProvider =
                                ref.watch(readingStatusProvider(manga));
                            final reading = readProvider.value;

                            if (reading != null) {
                              return const SizedBox(
                                width: 8,
                              );
                            }

                            return const SizedBox.shrink();
                          },
                        ),
                        Consumer(
                          builder: (context, ref, child) {
                            final readProvider =
                                ref.watch(readingStatusProvider(manga));
                            final reading = readProvider.value;

                            if (readProvider.isLoading) {
                              return _loadingAction;
                            }

                            if (reading != null) {
                              return _ReadingStatusDropdown(
                                initial: reading,
                                manga: manga,
                              );
                            }

                            return const SizedBox.shrink();
                          },
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        _RatingMenu(
                          manga: manga,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        _UserListsMenu(
                          manga: manga,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
              ),
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Wrap(
                    spacing: 4.0,
                    runSpacing: 4.0,
                    children: [
                      if (manga.attributes!.contentRating != ContentRating.safe)
                        ContentRatingChip(
                            rating: manga.attributes!.contentRating),
                      ...contentTagChips,
                      ...genreTagChips,
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: MangaStatisticsRow(
                    manga: manga,
                  ),
                ),
              ),
              if (manga.attributes!.altTitles.isNotEmpty)
                SliverToBoxAdapter(
                  child: ExpansionTile(
                    title: const Text('Alt. Titles'),
                    children: [
                      for (final Map(entries: entry)
                          in manga.attributes!.altTitles)
                        ExpansionTile(
                          title: Text(Languages.get(entry.first.key).label),
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: Material(
                                color:
                                    theme.colorScheme.surfaceContainerHighest,
                                child: InkWell(
                                  onTap: () => Clipboard.setData(ClipboardData(
                                          text: entry.first.value))
                                      .then((_) {
                                    if (!context.mounted) return;
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text('Copied to clipboard!')));
                                  }),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(entry.first.value),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                    ],
                  ),
                ),
              if (manga.attributes!.description.isNotEmpty)
                SliverToBoxAdapter(
                  child: ExpansionTile(
                    title: const Text('Synopsis'),
                    children: [
                      for (final MapEntry(key: lang, value: desc)
                          in manga.attributes!.description.entries)
                        ExpansionTile(
                          title: Text(Languages.get(lang).label),
                          children: [
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(8),
                              color: theme.colorScheme.surfaceContainerHighest,
                              child: MarkdownBody(
                                data: desc,
                                onTapLink: (text, url, title) async {
                                  if (url != null) {
                                    if (!await launchUrl(Uri.parse(url))) {
                                      throw 'Could not launch $url';
                                    }
                                  }
                                },
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
                      MultiChildExpansionTile(
                        title: 'Author',
                        children: manga.author!
                            .map((e) => ButtonChip(
                                  text: Text(e.attributes.name),
                                  onPressed: () {
                                    context.push('/author/${e.id}', extra: e);
                                  },
                                ))
                            .toList(),
                      ),
                    if (manga.artist != null)
                      MultiChildExpansionTile(
                        title: 'Artist',
                        children: manga.artist!
                            .map((e) => ButtonChip(
                                  text: Text(e.attributes.name),
                                  onPressed: () {
                                    context.push('/author/${e.id}', extra: e);
                                  },
                                ))
                            .toList(),
                      ),
                    if (manga.attributes!.publicationDemographic != null)
                      ExpansionTile(
                        title: const Text('Demograhic'),
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: IconTextChip(
                                text: manga
                                    .attributes!.publicationDemographic!.label,
                              ),
                            ),
                          ),
                        ],
                      ),
                    if (mangaTagChips[TagGroup.genre] != null)
                      MultiChildExpansionTile(
                        title: 'Genres',
                        children: mangaTagChips[TagGroup.genre]!,
                      ),
                    if (mangaTagChips[TagGroup.theme] != null)
                      MultiChildExpansionTile(
                        title: 'Themes',
                        children: mangaTagChips[TagGroup.theme]!,
                      ),
                    if (mangaTagChips[TagGroup.format] != null)
                      MultiChildExpansionTile(
                        title: 'Format',
                        children: mangaTagChips[TagGroup.format]!,
                      ),
                    MultiChildExpansionTile(
                      title: 'Track',
                      children: [
                        if (manga.attributes!.links?.raw != null)
                          ButtonChip(
                            onPressed: () async {
                              final url = manga.attributes!.links!.raw!;
                              if (!await launchUrl(Uri.parse(url))) {
                                throw 'Could not launch $url';
                              }
                            },
                            text: const Text('Official Raw'),
                          ),
                        if (manga.attributes!.links?.mu != null)
                          ButtonChip(
                            onPressed: () async {
                              final seriesnum =
                                  int.tryParse(manga.attributes!.links!.mu!);
                              var url =
                                  'https://www.mangaupdates.com/series/${manga.attributes!.links!.mu!}';

                              if (seriesnum != null) {
                                url =
                                    'https://www.mangaupdates.com/series.html?id=${manga.attributes!.links!.mu!}';
                              }

                              if (!await launchUrl(Uri.parse(url))) {
                                throw 'Could not launch $url';
                              }
                            },
                            text: const Text('MangaUpdates'),
                          ),
                        if (manga.attributes!.links?.al != null)
                          ButtonChip(
                            onPressed: () async {
                              final url =
                                  'https://anilist.co/manga/${manga.attributes!.links!.al!}';
                              if (!await launchUrl(Uri.parse(url))) {
                                throw 'Could not launch $url';
                              }
                            },
                            text: const Text('AniList'),
                          ),
                        if (manga.attributes!.links?.mal != null)
                          ButtonChip(
                            onPressed: () async {
                              final url =
                                  'https://myanimelist.net/manga/${manga.attributes!.links!.mal!}';
                              if (!await launchUrl(Uri.parse(url))) {
                                throw 'Could not launch $url';
                              }
                            },
                            text: const Text('MyAnimeList'),
                          ),
                        ButtonChip(
                          onPressed: () async {
                            var route =
                                GoRouterState.of(context).uri.toString();
                            route =
                                route.replaceFirst('https://mangadex.org', '');
                            final url = Uri.parse('https://mangadex.org$route');

                            if (!await launchUrl(url,
                                mode: LaunchMode.inAppWebView)) {
                              throw 'Could not launch $url';
                            }
                          },
                          text: const Text('Open on MangaDex'),
                        ),
                      ],
                    ),
                    if (lastvolchap != null)
                      ExpansionTile(
                        title: const Text('Final Volume/Chapter'),
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(lastvolchap),
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
                  child: ToggleButtons(
                    isSelected: List<bool>.generate(
                        hasRelated
                            ? _ViewType.values.length
                            : _ViewType.values.length - 1,
                        (index) => view.value.index == index),
                    onPressed: (index) {
                      view.value = _ViewType.values.elementAt(index);
                    },
                    textStyle: const TextStyle(fontSize: 24),
                    borderRadius: const BorderRadius.all(Radius.circular(2.0)),
                    children: [
                      ...(hasRelated
                              ? _ViewType.values
                              : _ViewType.values.take(2))
                          .map((e) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Text(e.name.capitalize())))
                    ],
                  ),
                ),
              ),
              if (view.value == _ViewType.chapters && loggedin)
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Consumer(
                          builder: (context, ref, child) {
                            final sort =
                                ref.watch(mangaChaptersListSortProvider);
                            return ElevatedButton(
                              style: Styles.buttonStyle(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0)),
                              onPressed: () {
                                if (sort == ListSort.descending) {
                                  ref
                                      .read(mangaChaptersListSortProvider
                                          .notifier)
                                      .state = ListSort.ascending;
                                } else {
                                  ref
                                      .read(mangaChaptersListSortProvider
                                          .notifier)
                                      .state = ListSort.descending;
                                }
                              },
                              child: Text(sort.name.capitalize()),
                            );
                          },
                        ),
                        const Spacer(),
                        Consumer(
                          builder: (context, ref, child) {
                            final chapters =
                                ref.watch(mangaChaptersProvider(manga)).value;

                            final allRead = chapters != null
                                ? ref.watch(readChaptersProvider
                                    .select((value) => switch (value) {
                                          AsyncValue(value: final data?) =>
                                            data[manga.id]?.containsAll(chapters
                                                    .map((e) => e.id)) ==
                                                true,
                                          _ => false,
                                        }))
                                : false;

                            final opt = allRead ? 'unread' : 'read';

                            return ElevatedButton(
                              style: Styles.buttonStyle(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0)),
                              onPressed: () async {
                                final result = await showDialog<bool>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    final nav = Navigator.of(context);
                                    return AlertDialog(
                                      title: Text('Mark all as $opt'),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              'Are you sure you want to mark all visible chapters as $opt?'),
                                        ],
                                      ),
                                      actions: <Widget>[
                                        ElevatedButton(
                                          child: const Text('No'),
                                          onPressed: () {
                                            nav.pop(false);
                                          },
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            nav.pop(true);
                                          },
                                          child: const Text('Yes'),
                                        ),
                                      ],
                                    );
                                  },
                                );

                                if (chapters != null && result == true) {
                                  ref.read(readChaptersProvider.notifier).set(
                                      manga,
                                      read: !allRead ? chapters : null,
                                      unread: allRead ? chapters : null);
                                }
                              },
                              child: Text('Mark all visible as $opt'),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
            ];
          },
          body: SafeArea(
              top: false,
              bottom: false,
              child: switch (view.value) {
                _ViewType.chapters => Consumer(
                    builder: (context, ref, child) {
                      final chapterProvider =
                          ref.watch(mangaChaptersProvider(manga));

                      return Stack(
                        children: [
                          switch (chapterProvider) {
                            AsyncValue(:final error?, :final stackTrace?) =>
                              ErrorList(
                                error: error,
                                stackTrace: stackTrace,
                                message:
                                    "mangaChaptersProvider(${manga.id}) failed",
                              ),
                            AsyncValue(value: final chapters?) =>
                              NotificationListener<ScrollEndNotification>(
                                onNotification: onScrollNotification,
                                child: CustomScrollView(
                                  slivers: [
                                    _ChapterListSliver(
                                      chapters: chapters,
                                      manga: manga,
                                    ),
                                  ],
                                ),
                              ),
                            _ => const SizedBox.shrink(),
                          },
                          if (chapterProvider.isLoading)
                            ...Styles.loadingOverlay
                        ],
                      );
                    },
                  ),
                _ViewType.art => Consumer(
                    builder: (context, ref, child) {
                      final coverProvider =
                          ref.watch(mangaCoversProvider(manga));

                      return Stack(
                        children: [
                          switch (coverProvider) {
                            AsyncValue(:final error?, :final stackTrace?) =>
                              ErrorList(
                                error: error,
                                stackTrace: stackTrace,
                                message:
                                    "mangaCoversProvider(${manga.id}) failed",
                              ),
                            AsyncValue(value: final covers?) =>
                              NotificationListener<ScrollEndNotification>(
                                onNotification: onScrollNotification,
                                child: CustomScrollView(
                                  slivers: [
                                    SliverGrid.builder(
                                      gridDelegate:
                                          const SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: 256,
                                        mainAxisSpacing: 8,
                                        crossAxisSpacing: 8,
                                        childAspectRatio: 0.7,
                                      ),
                                      findChildIndexCallback: (key) {
                                        final valueKey =
                                            key as ValueKey<String>;
                                        final val = covers.indexWhere(
                                            (i) => i.id == valueKey.value);
                                        return val >= 0 ? val : null;
                                      },
                                      itemBuilder: (context, index) {
                                        final cover = covers.elementAt(index);
                                        return _CoverArtItem(
                                          key: ValueKey(cover.id),
                                          cover: cover,
                                          manga: manga,
                                          page: index,
                                          onTap: () async {
                                            await showModal(
                                              context: context,
                                              builder: (context) {
                                                return Scaffold(
                                                  appBar: AppBar(
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    leading:
                                                        const CloseButton(),
                                                  ),
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  extendBody: true,
                                                  extendBodyBehindAppBar: true,
                                                  body: PageView.builder(
                                                    scrollBehavior:
                                                        const MouseTouchScrollBehavior(),
                                                    findChildIndexCallback:
                                                        (key) {
                                                      final valueKey = key
                                                          as ValueKey<String>;
                                                      final val = covers
                                                          .indexWhere((i) =>
                                                              i.id ==
                                                              valueKey.value);
                                                      return val >= 0
                                                          ? val
                                                          : null;
                                                    },
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int id) {
                                                      final item =
                                                          covers.elementAt(id);
                                                      final url =
                                                          manga.getUrlFromCover(
                                                              item);
                                                      Widget image =
                                                          ExtendedImage.network(
                                                        url,
                                                        fit: BoxFit.contain,
                                                        mode: ExtendedImageMode
                                                            .gesture,
                                                        enableSlideOutPage:
                                                            true,
                                                        loadStateChanged:
                                                            extendedImageLoadStateHandler,
                                                      );

                                                      image = Container(
                                                        key: ValueKey(cover.id),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5.0),
                                                        color:
                                                            Colors.transparent,
                                                        child: GestureDetector(
                                                          child: image,
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                        ),
                                                      );

                                                      if (id == index) {
                                                        return Hero(
                                                          key: ValueKey(
                                                              cover.id),
                                                          tag: url,
                                                          child: image,
                                                        );
                                                      } else {
                                                        return image;
                                                      }
                                                    },
                                                    itemCount: covers.length,
                                                    controller: PageController(
                                                      initialPage: index,
                                                    ),
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        );
                                      },
                                      itemCount: covers.length,
                                    ),
                                  ],
                                ),
                              ),
                            _ => const SizedBox.shrink(),
                          },
                          if (coverProvider.isLoading) ...Styles.loadingOverlay
                        ],
                      );
                    },
                  ),
                _ViewType.related => Consumer(
                    builder: (context, ref, child) {
                      final relatedProvider =
                          ref.watch(_fetchRelatedMangaProvider(manga));

                      return Stack(
                        children: [
                          switch (relatedProvider) {
                            AsyncValue(:final error?, :final stackTrace?) =>
                              ErrorList(
                                error: error,
                                stackTrace: stackTrace,
                                message:
                                    "_fetchRelatedMangaProvider(${manga.id}) failed",
                              ),
                            AsyncValue(value: final related?) =>
                              MangaListWidget(
                                title: const Text(
                                  'Related Titles',
                                  style: TextStyle(fontSize: 24),
                                ),
                                noController: true,
                                children: [
                                  MangaListViewSliver(
                                    items: related,
                                    headers: manga.relatedMangas.fold({},
                                        (previousValue, element) {
                                      previousValue?[element.id] =
                                          element.related!.label;
                                      return previousValue;
                                    }),
                                  ),
                                ],
                              ),
                            _ => const SizedBox.shrink(),
                          },
                          if (relatedProvider.isLoading)
                            ...Styles.loadingOverlay
                        ],
                      );
                    },
                  ),
              }),
        ),
      ),
    );
  }
}

class _ChapterListSliver extends HookWidget {
  const _ChapterListSliver({
    required this.chapters,
    required this.manga,
  });

  final List<Chapter> chapters;
  final Manga manga;

  static const header = '_HEADER_';

  @override
  Widget build(BuildContext context) {
    final keys = useMemoized(() {
      final keysGrouped =
          chapters.groupListsBy((chapter) => chapter.attributes.volume);

      var keys = <String>[];

      for (final vol in keysGrouped.keys) {
        if (vol == null) {
          keys.add('${header}No Volume');
        } else {
          keys.add('${header}Volume $vol');
        }

        keys = keysGrouped[vol]!.foldIndexed(keys, (index, list, chapter) {
          // If next chapter is the same number
          // AND previous chapter isn't (or doesnt exist)
          if (index < keysGrouped[vol]!.length - 1 &&
              keysGrouped[vol]!.elementAt(index + 1).attributes.chapter ==
                  chapter.attributes.chapter &&
              (index == 0 ||
                  (index > 0 &&
                      keysGrouped[vol]!
                              .elementAt(index - 1)
                              .attributes
                              .chapter !=
                          chapter.attributes.chapter))) {
            list.add('${header}Chapter ${chapter.attributes.chapter}');
          }

          list.add(chapter.id);
          return list;
        });
      }

      return keys;
    }, [chapters]);

    return SliverList.builder(
      findChildIndexCallback: (key) {
        final valueKey = key as ValueKey<String>;
        final val = keys.indexWhere((i) => i == valueKey.value);
        return val >= 0 ? val : null;
      },
      itemBuilder: (BuildContext context, int index) {
        var lastChapIsSame = false;
        var nextChapIsSame = false;

        final key = keys[index];

        if (key.startsWith(header)) {
          final text = key.replaceFirst(header, '');
          return Padding(
            key: ValueKey(key),
            padding: const EdgeInsets.all(6.0),
            child: Text(text,
                style: TextStyle(
                    fontWeight:
                        text.contains('Volume') ? FontWeight.bold : null)),
          );
        }

        final chapid = chapters.indexWhere((c) => c.id == key);
        final thischap = chapters.elementAt(chapid);
        final chapbtn = ChapterButtonWidget(
          key: ValueKey(thischap.id),
          chapter: thischap,
          manga: manga,
          link: Text(
            manga.attributes!.title.get('en'),
            style: const TextStyle(fontSize: 24),
          ),
        );

        if (chapid > 0) {
          lastChapIsSame = chapters.elementAt(chapid - 1).attributes.chapter ==
              thischap.attributes.chapter;
        }

        if (chapid < chapters.length - 1) {
          nextChapIsSame = chapters.elementAt(chapid + 1).attributes.chapter ==
              thischap.attributes.chapter;
        }

        if (lastChapIsSame || nextChapIsSame) {
          return Padding(
            key: ValueKey(thischap.id),
            padding: EdgeInsets.only(
                top: (!lastChapIsSame && nextChapIsSame) ? 6.0 : 2.0,
                bottom: (lastChapIsSame && !nextChapIsSame) ? 6.0 : 2.0),
            child: Row(
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
          );
        }

        return Padding(
          key: ValueKey(thischap.id),
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: chapbtn,
        );
      },
      itemCount: keys.length,
    );
  }
}

class _CoverArtItem extends HookWidget {
  const _CoverArtItem({
    super.key,
    required this.cover,
    required this.manga,
    required this.page,
    this.onTap,
  });

  final CoverArt cover;
  final Manga manga;
  final int page;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final aniController =
        useAnimationController(duration: const Duration(milliseconds: 100));
    final gradient =
        useAnimation(aniController.drive(Styles.coverArtGradientTween));
    final url = manga.getUrlFromCover(cover);

    final Widget image = Material(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4.0))),
      clipBehavior: Clip.antiAlias,
      child: ShaderMask(
        shaderCallback: (rect) {
          return LinearGradient(
            begin: gradient,
            end: Alignment.bottomCenter,
            colors: const [Colors.black, Colors.transparent],
          ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
        },
        blendMode: BlendMode.dstIn,
        child: ExtendedImage.network(
          url.quality(quality: CoverArtQuality.medium),
          cache: true,
          loadStateChanged: extendedImageLoadStateHandler,
          width: 256.0,
        ),
      ),
    );

    return Hero(
      tag: url,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          onHover: (hovering) {
            if (hovering) {
              aniController.forward();
            } else {
              aniController.reverse();
            }
          },
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
                        title: Text(
                          'Volume ${cover.attributes!.volume!}',
                          softWrap: true,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
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

class _ReadingStatusDropdown extends ConsumerWidget {
  const _ReadingStatusDropdown({
    required this.initial,
    required this.manga,
  });

  final MangaReadingStatus initial;
  final Manga manga;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return DropdownMenu<MangaReadingStatus>(
      initialSelection: initial,
      width: 180.0,
      enableFilter: false,
      enableSearch: false,
      requestFocusOnTap: false,
      inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        constraints: BoxConstraints.tight(const Size.fromHeight(36)),
        filled: true,
        fillColor: theme.colorScheme.surface.withAlpha(200),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 2.0,
            color: theme.colorScheme.inversePrimary,
          ),
        ),
      ),
      onSelected: (MangaReadingStatus? status) async {
        ref.read(readingStatusProvider(manga).notifier).set(status);

        if (status == null || status == MangaReadingStatus.remove) {
          ref.read(followingStatusProvider(manga).notifier).set(false);
        }
      },
      dropdownMenuEntries: List<DropdownMenuEntry<MangaReadingStatus>>.generate(
        MangaReadingStatus.values.length,
        (int index) => DropdownMenuEntry<MangaReadingStatus>(
          value: MangaReadingStatus.values.elementAt(index),
          label: MangaReadingStatus.values.elementAt(index).label,
        ),
      ),
    );
  }
}

class _RatingMenu extends ConsumerWidget {
  const _RatingMenu({
    required this.manga,
  });

  final Manga manga;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final ratingProv = ref.watch(ratingsProvider);
    final ratings = ratingProv.value;

    return MenuAnchor(
      builder: (context, controller, child) {
        return Material(
          color: (ratings != null &&
                  ratings.containsKey(manga.id) &&
                  ratings[manga.id]!.rating > 0)
              ? Colors.deepOrange.shade800
              : theme.colorScheme.surfaceContainerHighest,
          borderRadius: const BorderRadius.all(Radius.circular(6.0)),
          child: (ratingProv.isLoading || ratings == null)
              ? _loadingAction
              : InkWell(
                  onTap: () {
                    if (controller.isOpen) {
                      controller.close();
                    } else {
                      controller.open();
                    }
                  },
                  child: child,
                ),
        );
      },
      menuChildren: [
        ...List.generate(
          10,
          (index) => MenuItemButton(
            onPressed: () {
              ref.read(ratingsProvider.notifier).set(manga, index + 1);
            },
            child: Text(RatingLabel[index + 1]),
          ),
        ).reversed,
        if (ratings != null &&
            ratings.containsKey(manga.id) &&
            ratings[manga.id]!.rating > 0)
          MenuItemButton(
            onPressed: () {
              ref.read(ratingsProvider.notifier).set(manga, null);
            },
            child: const Text('Remove Rating'),
          )
      ],
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Text.rich(
          TextSpan(
            children: [
              const WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Icon(
                    Icons.star_border,
                  )),
              if (ratings != null &&
                  ratings.containsKey(manga.id) &&
                  ratings[manga.id]!.rating > 0)
                TextSpan(text: ' ${ratings[manga.id]!.rating}')
            ],
          ),
        ),
      ),
    );
  }
}

class _UserListsMenu extends ConsumerWidget {
  const _UserListsMenu({
    required this.manga,
  });

  final Manga manga;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final userListsProv = ref.watch(userListsProvider);
    final userLists = userListsProv.value;

    return MenuAnchor(
      builder: (context, controller, child) {
        return Material(
          color: theme.colorScheme.surfaceContainerHighest,
          borderRadius: const BorderRadius.all(Radius.circular(6.0)),
          child: (userListsProv.isLoading || userLists == null)
              ? _loadingAction
              : InkWell(
                  onTap: () {
                    if (controller.isOpen) {
                      controller.close();
                    } else {
                      controller.open();
                    }
                  },
                  child: child,
                ),
        );
      },
      menuChildren: [
        if (userLists != null)
          ...List.generate(
            userLists.length,
            (index) => CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              title: Text(userLists.elementAt(index).attributes.name),
              value: userLists.elementAt(index).set.contains(manga.id),
              onChanged: (bool? value) async {
                await ref.read(userListsProvider.notifier).updateList(
                    userLists.elementAt(index), manga, value == true);
              },
            ),
          ),
        MenuItemButton(
          child: const Text('+ Create new list'),
          onPressed: () async {
            final messenger = ScaffoldMessenger.of(context);

            final result = await showDialog<(String, CustomListVisibility)>(
                context: context,
                builder: (BuildContext context) {
                  return HookBuilder(
                    builder: (context) {
                      final nav = Navigator.of(context);
                      final nameController = useTextEditingController();
                      final nprivate =
                          useValueNotifier(CustomListVisibility.private);

                      return AlertDialog(
                        title: const Text('Create New List'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              controller: nameController,
                              decoration: const InputDecoration(
                                filled: true,
                                labelText: 'List Name',
                              ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (String? value) {
                                return (value == null || value.isEmpty)
                                    ? 'List name cannot be empty.'
                                    : null;
                              },
                            ),
                            HookBuilder(
                              builder: (_) {
                                final private = useValueListenable(nprivate);
                                return CheckboxListTile(
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  title: const Text('Private list'),
                                  value:
                                      private == CustomListVisibility.private,
                                  onChanged: (bool? value) async {
                                    nprivate.value = (value == true)
                                        ? CustomListVisibility.private
                                        : CustomListVisibility.public;
                                  },
                                );
                              },
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
                          HookBuilder(
                            builder: (_) {
                              final nameIsEmpty = useListenableSelector(
                                  nameController,
                                  () => nameController.text.isEmpty);
                              return ElevatedButton(
                                onPressed: nameIsEmpty
                                    ? null
                                    : () {
                                        if (nameController.text.isNotEmpty) {
                                          nav.pop((
                                            nameController.text,
                                            nprivate.value
                                          ));
                                        }
                                      },
                                child: const Text('Create'),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  );
                });

            if (result != null) {
              final success = await ref
                  .read(userListsProvider.notifier)
                  .newList(result.$1, result.$2, []);

              if (success) {
                messenger
                  ..removeCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(
                      content: Text('New list created.'),
                      backgroundColor: Colors.green,
                    ),
                  );
              } else {
                messenger
                  ..removeCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(
                      content: Text('Failed to create list.'),
                      backgroundColor: Colors.red,
                    ),
                  );
              }
            }
          },
        )
      ],
      child: const Padding(
        padding: EdgeInsets.all(6.0),
        child: Icon(Icons.playlist_add),
      ),
    );
  }
}

class _AddToLibraryDialog extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final nav = Navigator.of(context);
    final nreading = useValueNotifier(MangaReadingStatus.plan_to_read);
    final nfollowing = useValueNotifier(true);

    return AlertDialog(
      title: const Text('Add to Library'),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          HookBuilder(
            builder: (_) {
              final reading = useValueListenable(nreading);
              return DropdownMenu<MangaReadingStatus>(
                initialSelection: reading,
                enableFilter: false,
                enableSearch: false,
                requestFocusOnTap: false,
                inputDecorationTheme: InputDecorationTheme(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 2.0,
                      color: theme.colorScheme.inversePrimary,
                    ),
                  ),
                ),
                onSelected: (MangaReadingStatus? status) async {
                  if (status != null) {
                    nreading.value = status;
                  }
                },
                dropdownMenuEntries:
                    List<DropdownMenuEntry<MangaReadingStatus>>.generate(
                  MangaReadingStatus.values.length - 1,
                  (int index) => DropdownMenuEntry<MangaReadingStatus>(
                    value: MangaReadingStatus.values.elementAt(index + 1),
                    label: MangaReadingStatus.values.elementAt(index + 1).label,
                  ),
                ),
              );
            },
          ),
          const SizedBox(
            width: 10,
          ),
          HookBuilder(
            builder: (_) {
              final following = useValueListenable(nfollowing);
              return ElevatedButton(
                onPressed: () async {
                  nfollowing.value = !nfollowing.value;
                },
                child: Icon(following
                    ? Icons.notification_add
                    : Icons.notifications_off_outlined),
              );
            },
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
            nav.pop((nreading.value, nfollowing.value));
          },
        ),
      ],
    );
  }
}
