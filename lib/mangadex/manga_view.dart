import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:gagaku/mangadex/model.dart';
import 'package:gagaku/mangadex/types.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:gagaku/util/ui.dart';
import 'package:gagaku/util/util.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photo_view/photo_view.dart';
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
    child = QueriedMangaDexMangaViewWidget(mangaId: state.pathParameters['mangaId']!);
  }

  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: Styles.scaledSharedAxisTransitionBuilder,
  );
}

@Riverpod(retry: noRetry)
Future<Manga> _fetchMangaFromId(Ref ref, String mangaId) async {
  final api = ref.watch(mangadexProvider);
  final manga = await api.fetchManga(ids: [mangaId], limit: MangaDexEndpoints.breakLimit);

  await ref.read(statisticsProvider.notifier).get(manga);
  await ref.read(readChaptersProvider.notifier).get(manga);
  await ref.read(ratingsProvider.notifier).get(manga);

  return manga.first;
}

@Riverpod(retry: noRetry)
Future<List<Manga>> _fetchRelatedManga(Ref ref, Manga manga) async {
  final related = manga.relatedMangas;

  if (related.isEmpty) {
    return [];
  }

  final api = ref.watch(mangadexProvider);
  final ids = related.map((e) => e.id);
  final mangas = await api.fetchManga(ids: ids, limit: MangaDexEndpoints.breakLimit);

  await ref.read(statisticsProvider.notifier).get(mangas);
  await ref.read(readChaptersProvider.notifier).get(mangas);

  ref.disposeAfter(const Duration(minutes: 5));

  return mangas;
}

class QueriedMangaDexMangaViewWidget extends ConsumerWidget {
  const QueriedMangaDexMangaViewWidget({super.key, required this.mangaId});

  final String mangaId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DataProviderWhenWidget(
      provider: _fetchMangaFromIdProvider(mangaId),
      errorBuilder: (context, child) => Scaffold(
        body: RefreshIndicator(
          onRefresh: () async => ref.refresh(_fetchMangaFromIdProvider(mangaId).future),
          child: child,
        ),
      ),
      builder: (context, manga) => MangaDexMangaViewWidget(
        manga: manga,
      ),
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

    final hasRelated = manga.relatedMangas.isNotEmpty;
    final tabController =
        useTabController(initialLength: hasRelated ? _ViewType.values.length : _ViewType.values.length - 1);
    final tabview = useListenableSelector(tabController, () => tabController.index);

    String? lastvolchap;

    if ((manga.attributes!.lastVolume != null && manga.attributes!.lastVolume!.isNotEmpty) ||
        (manga.attributes!.lastChapter != null && manga.attributes!.lastChapter!.isNotEmpty)) {
      lastvolchap = '';

      if (manga.attributes!.lastVolume != null && manga.attributes!.lastVolume!.isNotEmpty) {
        lastvolchap += 'Volume ${manga.attributes!.lastVolume}';
      }

      if (manga.attributes!.lastChapter != null && manga.attributes!.lastChapter!.isNotEmpty) {
        lastvolchap += '${lastvolchap.isEmpty ? '' : ', '}Chapter ${manga.attributes!.lastChapter!}';
      }
    }

    final mangaTagChips = useMemoized<Map<TagGroup, List<Widget>>>(() {
      final map = manga.attributes!.tags.groupListsBy((tag) => tag.attributes.group);
      return map.map((group, list) {
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

    bool onScrollNotification(ScrollEndNotification notification) {
      if (notification.depth == 0 &&
          notification.metrics.axis == Axis.vertical &&
          notification.metrics.axisDirection == AxisDirection.down &&
          notification.metrics.atEdge &&
          notification.metrics.pixels == notification.metrics.maxScrollExtent) {
        switch (_ViewType.values.elementAt(tabview)) {
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
          if (ref.read(followingStatusProvider(manga)).hasError) {
            ref.invalidate(followingStatusProvider(manga));
          }

          if (ref.read(readingStatusProvider(manga)).hasError) {
            ref.invalidate(readingStatusProvider(manga));
          }

          switch (_ViewType.values.elementAt(tabview)) {
            case _ViewType.chapters:
              await ref.read(mangaChaptersProvider(manga).notifier).clear();
              return ref.refresh(mangaChaptersProvider(manga).future);
            case _ViewType.art:
              await ref.read(mangaCoversProvider(manga).notifier).clear();
              return ref.refresh(mangaCoversProvider(manga).future);
            case _ViewType.related:
              return ref.refresh(_fetchRelatedMangaProvider(manga).future);
          }
        },
        notificationPredicate: (notification) {
          // Depth 1 is the top of the NestedScrollView
          if (notification is OverscrollNotification && notification.velocity == 0.0 && notification.overscroll < 0.0) {
            return notification.depth == 1;
          }

          return notification.depth == 0;
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
                  expandedTitleScale: 2.0,
                  title: Text(
                    manga.attributes!.title.get('en'),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(1.0, 1.0),
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ],
                    ),
                  ),
                  background: Stack(
                    fit: StackFit.passthrough,
                    children: [
                      CachedNetworkImage(
                        imageUrl: manga.getFirstCoverUrl(quality: CoverArtQuality.medium),
                        colorBlendMode: BlendMode.modulate,
                        color: Colors.grey,
                        fit: BoxFit.cover,
                        progressIndicatorBuilder: (context, url, downloadProgress) =>
                            Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 20.0, bottom: 10.0),
                          child: CountryFlag(
                            flag: manga.attributes!.originalLanguage.flag,
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                actions: !loggedin
                    ? null
                    : [
                        OverflowBar(
                          spacing: 8.0,
                          children: [
                            Consumer(
                              builder: (context, ref, child) {
                                final followProvider = ref.watch(followingStatusProvider(manga));
                                final following = followProvider.value;
                                final statusProvider = ref.watch(readingStatusProvider(manga));
                                final reading = statusProvider.value;

                                if (following == null || statusProvider.isLoading) {
                                  return _loadingAction;
                                }

                                if (following == false && reading == null) {
                                  return ElevatedButton(
                                    style: Styles.buttonStyle(),
                                    onPressed: () async {
                                      final result = await showDialog<(MangaReadingStatus, bool)>(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return _AddToLibraryDialog();
                                          });

                                      if (result != null) {
                                        ref.read(readingStatusProvider(manga).notifier).set(result.$1);

                                        ref.read(followingStatusProvider(manga).notifier).set(result.$2);
                                      }
                                    },
                                    child: Text('mangaActions.addToLibrary'.tr(context: context)),
                                  );
                                }

                                if (reading != null) {
                                  return IconButton(
                                    padding: EdgeInsets.zero,
                                    tooltip: following
                                        ? 'mangaActions.unfollow'.tr(context: context)
                                        : 'mangaActions.follow'.tr(context: context),
                                    style: Styles.squareIconButtonStyle(
                                        backgroundColor: theme.colorScheme.surface.withAlpha(200)),
                                    color: theme.colorScheme.primary,
                                    onPressed: () async {
                                      bool set = !following;
                                      ref.read(followingStatusProvider(manga).notifier).set(set);
                                    },
                                    icon:
                                        Icon(following ? Icons.notifications_active : Icons.notifications_off_outlined),
                                  );
                                }

                                return const SizedBox.shrink();
                              },
                            ),
                            Consumer(
                              builder: (context, ref, child) {
                                final readProvider = ref.watch(readingStatusProvider(manga));
                                final reading = readProvider.value;

                                if (readProvider.isLoading) {
                                  return _loadingAction;
                                }

                                if (reading != null) {
                                  return _ReadingStatusDropdown(
                                    key: ValueKey('_ReadingStatusDropdown(${manga.id})'),
                                    initial: reading,
                                    manga: manga,
                                  );
                                }

                                return const SizedBox.shrink();
                              },
                            ),
                            _RatingMenu(
                              key: ValueKey('_RatingMenu(${manga.id})'),
                              manga: manga,
                            ),
                            _UserListsMenu(
                              key: ValueKey('_UserListsMenu(${manga.id})'),
                              manga: manga,
                            ),
                            const SizedBox(width: 2),
                          ],
                        ),
                      ],
              ),
              SliverList.list(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: MangaGenreRow(
                      key: ValueKey('MangaGenreRow(${manga.id})'),
                      manga: manga,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: MangaStatisticsRow(
                      key: ValueKey('MangaStatisticsRow(${manga.id})'),
                      manga: manga,
                      shortStatus: false,
                    ),
                  ),
                  if (manga.attributes!.altTitles.isNotEmpty)
                    ExpansionTile(
                      title: Text('mangaView.altTitles'.tr(context: context)),
                      children: [
                        for (final Map(entries: entry) in manga.attributes!.altTitles)
                          ExpansionTile(
                            title: Text(context.tr(Languages.get(entry.first.key).label)),
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: Material(
                                  color: theme.colorScheme.surfaceContainerHighest,
                                  child: InkWell(
                                    onTap: () => Clipboard.setData(ClipboardData(text: entry.first.value)).then((_) {
                                      if (!context.mounted) return;
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text('ui.copyClipboard'.tr(context: context))));
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
                  if (manga.attributes!.description.isNotEmpty)
                    ExpansionTile(
                      title: Text('mangaView.synopsis'.tr(context: context)),
                      children: [
                        for (final MapEntry(key: lang, value: desc) in manga.attributes!.description.entries)
                          ExpansionTile(
                            title: Text(context.tr(Languages.get(lang).label)),
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
                  ExpansionTile(
                    title: Text('mangaView.info'.tr(context: context)),
                    children: [
                      if (manga.author != null)
                        MultiChildExpansionTile(
                          title: 'mangaView.author'.tr(context: context),
                          children: manga.author!
                              .map((e) => ButtonChip(
                                    text: e.attributes.name,
                                    onPressed: () {
                                      context.push('/author/${e.id}', extra: e);
                                    },
                                  ))
                              .toList(),
                        ),
                      if (manga.artist != null)
                        MultiChildExpansionTile(
                          title: 'mangaView.artist'.tr(context: context),
                          children: manga.artist!
                              .map((e) => ButtonChip(
                                    text: e.attributes.name,
                                    onPressed: () {
                                      context.push('/author/${e.id}', extra: e);
                                    },
                                  ))
                              .toList(),
                        ),
                      if (manga.attributes!.publicationDemographic != null)
                        ExpansionTile(
                          title: Text('mangaView.demographic'.tr(context: context)),
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: IconTextChip(
                                  text: manga.attributes!.publicationDemographic!.label,
                                ),
                              ),
                            ),
                          ],
                        ),
                      if (mangaTagChips[TagGroup.genre] != null)
                        MultiChildExpansionTile(
                          title: 'mangaView.genre'.tr(context: context),
                          children: mangaTagChips[TagGroup.genre]!,
                        ),
                      if (mangaTagChips[TagGroup.theme] != null)
                        MultiChildExpansionTile(
                          title: 'mangaView.theme'.tr(context: context),
                          children: mangaTagChips[TagGroup.theme]!,
                        ),
                      if (mangaTagChips[TagGroup.format] != null)
                        MultiChildExpansionTile(
                          title: 'mangaView.format'.tr(context: context),
                          children: mangaTagChips[TagGroup.format]!,
                        ),
                      MultiChildExpansionTile(
                        title: 'mangaView.track'.tr(context: context),
                        children: [
                          if (manga.attributes!.links?.raw != null)
                            ButtonChip(
                              onPressed: () async {
                                final url = manga.attributes!.links!.raw!;
                                if (!await launchUrl(Uri.parse(url))) {
                                  throw 'Could not launch $url';
                                }
                              },
                              text: 'mangaView.officialRaw'.tr(context: context),
                            ),
                          if (manga.attributes!.links?.mu != null)
                            ButtonChip(
                              onPressed: () async {
                                final seriesnum = int.tryParse(manga.attributes!.links!.mu!);
                                var url = 'https://www.mangaupdates.com/series/${manga.attributes!.links!.mu!}';

                                if (seriesnum != null) {
                                  url = 'https://www.mangaupdates.com/series.html?id=${manga.attributes!.links!.mu!}';
                                }

                                if (!await launchUrl(Uri.parse(url))) {
                                  throw 'Could not launch $url';
                                }
                              },
                              text: 'MangaUpdates',
                            ),
                          if (manga.attributes!.links?.al != null)
                            ButtonChip(
                              onPressed: () async {
                                final url = 'https://anilist.co/manga/${manga.attributes!.links!.al!}';
                                if (!await launchUrl(Uri.parse(url))) {
                                  throw 'Could not launch $url';
                                }
                              },
                              text: 'AniList',
                            ),
                          if (manga.attributes!.links?.mal != null)
                            ButtonChip(
                              onPressed: () async {
                                final url = 'https://myanimelist.net/manga/${manga.attributes!.links!.mal!}';
                                if (!await launchUrl(Uri.parse(url))) {
                                  throw 'Could not launch $url';
                                }
                              },
                              text: 'MyAnimeList',
                            ),
                          ButtonChip(
                            onPressed: () async {
                              final route = cleanBaseDomains(GoRouterState.of(context).uri.toString());
                              final url = Uri.parse('http://mangadex.org$route');

                              if (!await launchUrl(url)) {
                                throw 'Could not launch $url';
                              }
                            },
                            text: 'mangaView.openOn'.tr(context: context, args: ['MangaDex']),
                          ),
                        ],
                      ),
                      if (lastvolchap != null)
                        ExpansionTile(
                          title: Text('mangaView.finalChapter'.tr(context: context)),
                          children: [
                            Padding(
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
                  TabBar(
                    controller: tabController,
                    tabs: [
                      Tab(
                        text: 'mangaView.chapters'.tr(context: context),
                      ),
                      Tab(
                        text: 'mangaView.art'.tr(context: context),
                      ),
                      if (hasRelated)
                        Tab(
                          text: 'mangaView.related'.tr(context: context),
                        ),
                    ],
                  ),
                  if (_ViewType.values.elementAt(tabview) == _ViewType.chapters && loggedin)
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Consumer(
                            builder: (context, ref, child) {
                              final sort = ref.watch(mangaChaptersListSortProvider);
                              return ElevatedButton(
                                style: Styles.buttonStyle(padding: const EdgeInsets.symmetric(horizontal: 8.0)),
                                onPressed: () {
                                  if (sort == ListSort.descending) {
                                    ref.read(mangaChaptersListSortProvider.notifier).state = ListSort.ascending;
                                  } else {
                                    ref.read(mangaChaptersListSortProvider.notifier).state = ListSort.descending;
                                  }
                                },
                                child: Text(sort.name.capitalize()),
                              );
                            },
                          ),
                          const Spacer(),
                          Consumer(
                            builder: (context, ref, child) {
                              final chapters = ref.watch(mangaChaptersProvider(manga)).value;

                              final allRead = chapters != null
                                  ? ref.watch(readChaptersProvider.select((value) => switch (value) {
                                        AsyncValue(value: final data?) =>
                                          data[manga.id]?.containsAll(chapters.map((e) => e.id)) == true,
                                        _ => false,
                                      }))
                                  : false;

                              final opt = allRead
                                  ? 'mangaView.unread'.tr(context: context)
                                  : 'mangaView.read'.tr(context: context);

                              return ElevatedButton(
                                style: Styles.buttonStyle(padding: const EdgeInsets.symmetric(horizontal: 8.0)),
                                onPressed: () async {
                                  final result = await showDialog<bool>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      final nav = Navigator.of(context);
                                      return AlertDialog(
                                        title: Text('mangaView.markAllAs'.tr(context: context, args: [opt])),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('mangaView.markAllWarning'.tr(context: context, args: [opt])),
                                          ],
                                        ),
                                        actions: <Widget>[
                                          ElevatedButton(
                                            child: Text('ui.no'.tr(context: context)),
                                            onPressed: () {
                                              nav.pop(false);
                                            },
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              nav.pop(true);
                                            },
                                            child: Text('ui.yes'.tr(context: context)),
                                          ),
                                        ],
                                      );
                                    },
                                  );

                                  if (chapters != null && result == true) {
                                    ref.read(readChaptersProvider.notifier).set(manga,
                                        read: !allRead ? chapters : null, unread: allRead ? chapters : null);
                                  }
                                },
                                child: Text('mangaView.markAllVisibleAs'.tr(context: context, args: [opt])),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ];
          },
          body: SafeArea(
              top: false,
              bottom: false,
              child: switch (_ViewType.values.elementAt(tabview)) {
                _ViewType.chapters => Consumer(
                    builder: (context, ref, child) {
                      final chapterProvider = ref.watch(mangaChaptersProvider(manga));

                      return Stack(
                        children: [
                          DataProviderWhenWidget(
                            provider: mangaChaptersProvider(manga),
                            data: chapterProvider,
                            builder: (context, chapters) => NotificationListener<ScrollEndNotification>(
                              onNotification: onScrollNotification,
                              child: CustomScrollView(
                                cacheExtent: MediaQuery.sizeOf(context).height,
                                slivers: [
                                  _ChapterListSliver(
                                    chapters: chapters,
                                    manga: manga,
                                  ),
                                ],
                              ),
                            ),
                            loadingWidget: const SizedBox.shrink(),
                          ),
                          if (chapterProvider.isLoading) ...Styles.loadingOverlay
                        ],
                      );
                    },
                  ),
                _ViewType.art => Consumer(
                    builder: (context, ref, child) {
                      final coverProvider = ref.watch(mangaCoversProvider(manga));

                      return Stack(
                        children: [
                          DataProviderWhenWidget(
                            provider: mangaCoversProvider(manga),
                            data: coverProvider,
                            builder: (context, covers) => NotificationListener<ScrollEndNotification>(
                              onNotification: onScrollNotification,
                              child: CustomScrollView(
                                slivers: [
                                  SliverGrid.builder(
                                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 256,
                                      mainAxisSpacing: 8,
                                      crossAxisSpacing: 8,
                                      childAspectRatio: 0.7,
                                    ),
                                    findChildIndexCallback: (key) {
                                      final valueKey = key as ValueKey<String>;
                                      final val = covers.indexWhere((i) => i.id == valueKey.value);
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
                                          Navigator.push(context, TransparentOverlay(
                                            builder: (context) {
                                              return HookBuilder(
                                                builder: (context) {
                                                  final controller = usePageController(initialPage: index);
                                                  return Scaffold(
                                                    appBar: AppBar(
                                                      backgroundColor: Colors.transparent,
                                                      leading: CloseButton(
                                                        style: IconButton.styleFrom(backgroundColor: Colors.black),
                                                      ),
                                                    ),
                                                    backgroundColor: Colors.transparent,
                                                    extendBody: true,
                                                    extendBodyBehindAppBar: true,
                                                    body: PageView.builder(
                                                      scrollBehavior: const MouseTouchScrollBehavior(),
                                                      findChildIndexCallback: (key) {
                                                        final valueKey = key as ValueKey<String>;
                                                        final val = covers.indexWhere((i) => i.id == valueKey.value);
                                                        return val >= 0 ? val : null;
                                                      },
                                                      itemBuilder: (BuildContext context, int id) {
                                                        final item = covers.elementAt(id);
                                                        final url = manga.getUrlFromCover(item);

                                                        return Hero(
                                                          key: ValueKey(item.id),
                                                          tag: item.id,
                                                          child: Container(
                                                            padding: const EdgeInsets.all(10.0),
                                                            color: Colors.transparent,
                                                            child: GestureDetector(
                                                              onTap: () {
                                                                Navigator.pop(context);
                                                              },
                                                              child: CachedNetworkImage(
                                                                imageUrl: url,
                                                                imageBuilder: (context, imageProvider) {
                                                                  return PhotoView(
                                                                    backgroundDecoration:
                                                                        const BoxDecoration(color: Colors.transparent),
                                                                    imageProvider: imageProvider,
                                                                    minScale: PhotoViewComputedScale.contained * 0.8,
                                                                    maxScale: PhotoViewComputedScale.covered * 5.0,
                                                                    initialScale: PhotoViewComputedScale.contained,
                                                                  );
                                                                },
                                                                fit: BoxFit.contain,
                                                                progressIndicatorBuilder:
                                                                    (context, url, downloadProgress) => Center(
                                                                        child: CircularProgressIndicator(
                                                                            value: downloadProgress.progress)),
                                                                errorWidget: (context, url, error) =>
                                                                    const Icon(Icons.error),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      itemCount: covers.length,
                                                      controller: controller,
                                                      scrollDirection: Axis.horizontal,
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                          ));
                                        },
                                      );
                                    },
                                    itemCount: covers.length,
                                  ),
                                ],
                              ),
                            ),
                            loadingWidget: const SizedBox.shrink(),
                          ),
                          if (coverProvider.isLoading) ...Styles.loadingOverlay
                        ],
                      );
                    },
                  ),
                _ViewType.related => Consumer(
                    builder: (context, ref, child) {
                      final relatedProvider = ref.watch(_fetchRelatedMangaProvider(manga));

                      return DataProviderWhenWidget(
                        provider: _fetchRelatedMangaProvider(manga),
                        data: relatedProvider,
                        builder: (context, related) => MangaListWidget(
                          title: Text(
                            'mangaView.relatedTitles'.tr(context: context),
                            style: TextStyle(fontSize: 24),
                          ),
                          noController: true,
                          isLoading: relatedProvider.isLoading,
                          children: [
                            MangaListViewSliver(
                              items: related,
                              headers: manga.relatedMangas.fold({}, (previousValue, element) {
                                previousValue?[element.id] = context.tr(element.related!.label);
                                return previousValue;
                              }),
                            ),
                          ],
                        ),
                        loadingWidget: const LoadingOverlayStack(),
                      );
                    },
                  ),
              }),
        ),
      ),
    );
  }
}

class _ChapterListSliver extends HookConsumerWidget {
  const _ChapterListSliver({
    required this.chapters,
    required this.manga,
  });

  final List<Chapter> chapters;
  final Manga manga;

  static const header = '_HEADER_';
  static const _noVolumeKey = 'none';
  static const _noVolumeHeader = '${header}No Volume';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final sort = ref.watch(mangaChaptersListSortProvider);
    // final sortfunc = sort == ListSort.ascending
    //     ? compareNatural
    //     : (a, b) {
    //         return compareNatural(b, a);
    //       };

    // Redundancy
    useEffect(() {
      Future.delayed(Duration.zero, () async {
        await ref.read(readChaptersProvider.notifier).get([manga]);
      });
      return null;
    }, []);

    if (chapters.isEmpty) {
      return SliverToBoxAdapter(
        child: Center(
          child: Text('mangaView.noChaptersMsg'.tr(context: context)),
        ),
      );
    }

    final keys = useMemoized(() {
      final keysGrouped = chapters.groupListsBy((chapter) => chapter.attributes.volume ?? _noVolumeKey);

      var keys = <String>[];

      for (final vol in keysGrouped.keys) {
        if (vol == _noVolumeKey) {
          keys.add(_noVolumeHeader);
        } else {
          keys.add('${header}Volume $vol');
        }

        keys = keysGrouped[vol]!.foldIndexed(keys, (index, list, chapter) {
          // If next chapter is the same number
          // AND previous chapter isn't (or doesnt exist)
          if (index < keysGrouped[vol]!.length - 1 &&
              keysGrouped[vol]!.elementAt(index + 1).attributes.chapter == chapter.attributes.chapter &&
              (index == 0 ||
                  (index > 0 &&
                      keysGrouped[vol]!.elementAt(index - 1).attributes.chapter != chapter.attributes.chapter))) {
            list.add(
                '$header${chapter.attributes.chapter != null ? 'Chapter ${chapter.attributes.chapter}' : chapter.title}');
          }

          list.add(chapter.id);
          return list;
        });
      }

      return keys;
    }, [chapters]);

    return SliverList.separated(
      findChildIndexCallback: (key) {
        final valueKey = key as ValueKey<String>;
        final val = keys.indexWhere((i) => i == valueKey.value);
        return val >= 0 ? val : null;
      },
      separatorBuilder: (_, index) => const SizedBox(
        height: 4.0,
      ),
      itemBuilder: (BuildContext context, int index) {
        var lastChapIsSame = false;
        var nextChapIsSame = false;

        final key = keys[index];

        if (key.startsWith(header)) {
          final text = key.replaceFirst(header, '');
          return _ChapterListHeader(
            key: ValueKey(key),
            text: text,
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
          final lastchap = chapters.elementAt(chapid - 1);
          lastChapIsSame = lastchap.attributes.chapter == thischap.attributes.chapter &&
              lastchap.attributes.volume == thischap.attributes.volume;
        }

        if (chapid < chapters.length - 1) {
          final nextchap = chapters.elementAt(chapid + 1);
          nextChapIsSame = nextchap.attributes.chapter == thischap.attributes.chapter &&
              nextchap.attributes.volume == thischap.attributes.volume;
        }

        if (lastChapIsSame || nextChapIsSame) {
          return Row(
            key: ValueKey(thischap.id),
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
        }

        return chapbtn;
      },
      itemCount: keys.length,
    );
  }
}

class _ChapterListHeader extends HookWidget {
  final String text;

  const _ChapterListHeader({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive();
    return Padding(
      key: ValueKey(key),
      padding: const EdgeInsets.all(6.0),
      child: Text(text, style: TextStyle(fontWeight: text.contains('Volume') ? FontWeight.bold : null)),
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
    useAutomaticKeepAlive();
    final aniController = useAnimationController(duration: const Duration(milliseconds: 100));
    final gradient = useAnimation(aniController.drive(Styles.coverArtGradientTween));
    final url = manga.getUrlFromCover(cover);

    final image = GridAlbumImage(
      gradient: gradient,
      child: CachedNetworkImage(
        imageUrl: url.quality(quality: CoverArtQuality.medium),
        width: 256.0,
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        fit: BoxFit.cover,
      ),
    );

    return Hero(
      tag: cover.id,
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
                ? GridAlbumTextBar(
                    height: 40,
                    text: 'Volume ${cover.attributes!.volume!}',
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
    super.key,
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
      width: 175.0,
      enableFilter: false,
      enableSearch: false,
      requestFocusOnTap: false,
      inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        constraints: BoxConstraints.tight(const Size.fromHeight(38)),
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
          label: context.tr(MangaReadingStatus.values.elementAt(index).label),
        ),
      ),
    );
  }
}

class _RatingMenu extends HookConsumerWidget {
  const _RatingMenu({
    super.key,
    required this.manga,
  });

  final Manga manga;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final ratingProv = ref.watch(ratingsProvider);
    final ratings = ratingProv.value;
    final hasRating = (ratings != null && ratings.containsKey(manga.id) && ratings[manga.id]!.rating > 0);

    // Redundancy
    useEffect(() {
      Future.delayed(Duration.zero, () async {
        await ref.read(ratingsProvider.notifier).get([manga]);
      });
      return null;
    }, []);

    return MenuAnchor(
      builder: (context, controller, child) {
        return Material(
          color: hasRating ? theme.colorScheme.primaryContainer : theme.colorScheme.surfaceContainerHighest,
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
        if (hasRating)
          MenuItemButton(
            onPressed: () {
              ref.read(ratingsProvider.notifier).set(manga, null);
            },
            child: const Text('Remove Rating'),
          )
      ],
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 4.0,
          children: [
            Icon(
              Icons.star_border,
              color: hasRating ? theme.colorScheme.onPrimaryContainer : null,
            ),
            if (hasRating)
              Text(
                '${ratings[manga.id]!.rating}',
                style: TextStyle(
                  color: theme.colorScheme.onPrimaryContainer,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _UserListsMenu extends ConsumerWidget {
  const _UserListsMenu({
    super.key,
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
                await ref.read(userListsProvider.notifier).updateList(userLists.elementAt(index), manga, value == true);
              },
            ),
          ),
        MenuItemButton(
          child: Text('mangadex.createNewListBtn'.tr(context: context)),
          onPressed: () async {
            final messenger = ScaffoldMessenger.of(context);

            final result = await showDialog<(String, CustomListVisibility)>(
                context: context,
                builder: (BuildContext context) {
                  return HookBuilder(
                    builder: (context) {
                      final nav = Navigator.of(context);
                      final nameController = useTextEditingController();
                      final nprivate = useValueNotifier(CustomListVisibility.private);

                      return AlertDialog(
                        title: Text('mangadex.createNewList'.tr(context: context)),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              controller: nameController,
                              decoration: InputDecoration(
                                filled: true,
                                labelText: 'mangadex.listName'.tr(context: context),
                              ),
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (String? value) {
                                return (value == null || value.isEmpty)
                                    ? 'mangadex.listNameEmptyWarning'.tr(context: context)
                                    : null;
                              },
                            ),
                            HookBuilder(
                              builder: (_) {
                                final private = useValueListenable(nprivate);
                                return CheckboxListTile(
                                  controlAffinity: ListTileControlAffinity.leading,
                                  title: Text('mangadex.privateList'.tr(context: context)),
                                  value: private == CustomListVisibility.private,
                                  onChanged: (bool? value) async {
                                    nprivate.value =
                                        (value == true) ? CustomListVisibility.private : CustomListVisibility.public;
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text('ui.cancel'.tr(context: context)),
                            onPressed: () {
                              nav.pop(null);
                            },
                          ),
                          HookBuilder(
                            builder: (_) {
                              final nameIsEmpty =
                                  useListenableSelector(nameController, () => nameController.text.isEmpty);
                              return ElevatedButton(
                                onPressed: nameIsEmpty
                                    ? null
                                    : () {
                                        if (nameController.text.isNotEmpty) {
                                          nav.pop((nameController.text, nprivate.value));
                                        }
                                      },
                                child: Text('ui.create'.tr(context: context)),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  );
                });

            if (result != null) {
              final success = await ref.read(userListsProvider.notifier).newList(result.$1, result.$2, []);

              if (!context.mounted) return;
              if (success) {
                messenger
                  ..removeCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text('mangadex.newListOk'.tr(context: context)),
                      backgroundColor: Colors.green,
                    ),
                  );
              } else {
                messenger
                  ..removeCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text('mangadex.newListError'.tr(context: context)),
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
      title: Text('mangaActions.addToLibrary'.tr(context: context)),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10.0,
        children: [
          HookBuilder(
            builder: (context) {
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
                dropdownMenuEntries: List<DropdownMenuEntry<MangaReadingStatus>>.generate(
                  MangaReadingStatus.values.length - 1,
                  (int index) => DropdownMenuEntry<MangaReadingStatus>(
                    value: MangaReadingStatus.values.elementAt(index + 1),
                    label: context.tr(MangaReadingStatus.values.elementAt(index + 1).label),
                  ),
                ),
              );
            },
          ),
          HookBuilder(
            builder: (_) {
              final following = useValueListenable(nfollowing);
              return ElevatedButton(
                onPressed: () async {
                  nfollowing.value = !nfollowing.value;
                },
                child: Icon(following ? Icons.notification_add : Icons.notifications_off_outlined),
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
