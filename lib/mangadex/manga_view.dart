import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/mangadex/model/model.dart';
import 'package:gagaku/mangadex/model/types.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:gagaku/routes.gr.dart';
import 'package:gagaku/util/cached_network_image.dart';
import 'package:gagaku/util/infinite_scroll.dart';
import 'package:gagaku/util/ui.dart';
import 'package:gagaku/util/util.dart';
import 'package:gagaku/web/model/types.dart' show SearchQuery;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:photo_view/photo_view.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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

@Riverpod(retry: noRetry)
Future<Manga> _fetchMangaFromId(Ref ref, String mangaId) async {
  final me = await ref.watch(loggedUserProvider.future);
  final api = ref.watch(mangadexProvider);
  final manga = await api.fetchMangaById(
    ids: [mangaId],
    limit: MangaDexEndpoints.breakLimit,
  );

  await (
    statisticsMutation.run(ref, (ref) async {
      return await ref.get(statisticsProvider.notifier).get(manga);
    }),
    readChaptersMutation(me?.id).run(ref, (ref) async {
      return await ref.get(readChaptersProvider(me?.id).notifier).get(manga);
    }),
  ).wait;

  return manga.first;
}

@RoutePage()
class MangaDexMangaViewWithNamePage extends MangaDexMangaViewPage {
  const MangaDexMangaViewWithNamePage({
    super.key,
    @PathParam() required super.mangaId,
    @PathParam() this.name,
  });

  final String? name;
}

@RoutePage()
class MangaDexMangaViewPage extends ConsumerWidget {
  const MangaDexMangaViewPage({
    super.key,
    @PathParam() required this.mangaId,
    this.manga,
  });

  final String mangaId;

  final Manga? manga;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (manga != null) {
      return MangaDexMangaViewWidget(manga: manga!);
    }

    return DataProviderWhenWidget(
      provider: _fetchMangaFromIdProvider(mangaId),
      errorBuilder: (context, child, _, _) => Scaffold(
        body: RefreshIndicator(
          onRefresh: () async =>
              ref.refresh(_fetchMangaFromIdProvider(mangaId).future),
          child: child,
        ),
      ),
      builder: (context, manga) => MangaDexMangaViewWidget(manga: manga),
    );
  }
}

class MangaDexMangaViewWidget extends StatefulHookConsumerWidget {
  const MangaDexMangaViewWidget({super.key, required this.manga});

  final Manga manga;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MangaDexMangaViewWidgetState();
}

class _MangaDexMangaViewWidgetState
    extends ConsumerState<MangaDexMangaViewWidget> {
  static const chapterInfo = MangaDexFeeds.mangaChapters;
  static const coverInfo = MangaDexFeeds.mangaCovers;

  late final _chapterController = GagakuPagingController<int, Chapter>(
    getNextPageKey: (state) =>
        state.keys?.last != null ? state.keys!.last + chapterInfo.limit : 0,
    fetchPage: (pageKey) async {
      final api = ref.watch(mangadexProvider);
      final sort = ref.watch(mangaChaptersListSortProvider);
      final chapterlist = await api.fetchFeed(
        path: chapterInfo.path!.replaceFirst('{id}', widget.manga.id),
        feedKey: chapterInfo.key,
        limit: chapterInfo.limit,
        offset: pageKey,
        entity: widget.manga,
        orderKey: 'chapter',
        order: sort.order,
        ignoreOriginalLanguage: true,
      );

      final chapters = chapterlist.data.cast<Chapter>();

      try {
        chapterStatsMutation.run(ref, (ref) async {
          return await ref.get(chapterStatsProvider.notifier).get(chapters);
        });
      } catch (e) {
        logger.e(e, error: e);
      }

      return PageResultsMetaData(chapters, chapterlist.total);
    },
    refresh: () async {
      final api = ref.watch(mangadexProvider);
      await api.invalidateAll('${chapterInfo.key}(${widget.manga.id}');
    },
  );

  late final _coverController = GagakuPagingController<int, CoverArt>(
    getNextPageKey: (state) =>
        state.keys?.last != null ? state.keys!.last + coverInfo.limit : 0,
    fetchPage: (pageKey) async {
      final api = ref.watch(mangadexProvider);
      final covers = await api.getCoverList(widget.manga, offset: pageKey);

      return PageResultsMetaData(covers.data.cast<CoverArt>(), covers.total);
    },
    refresh: () async {
      final api = ref.watch(mangadexProvider);
      await api.invalidateAll('${coverInfo.key}(${widget.manga.id}');
    },
  );

  late final _relatedController = GagakuPagingController<int, Manga>(
    getNextPageKey: (state) {
      if (widget.manga.relatedMangas.isEmpty) {
        return null;
      }

      if (state.keys?.last == null) {
        return 0;
      }

      if (state.keys!.last + MangaDexEndpoints.searchLimit >=
          widget.manga.relatedMangas.length) {
        return null;
      }

      return state.keys!.last + MangaDexEndpoints.searchLimit;
    },
    fetchPage: (pageKey) async {
      final related = widget.manga.relatedMangas;

      if (related.isEmpty) {
        return PageResultsMetaData([]);
      }

      final me = await ref.watch(loggedUserProvider.future);
      final api = ref.watch(mangadexProvider);
      final ids = related.map((e) => e.id).toList();
      final page = ids.getRange(
        pageKey,
        min(pageKey + MangaDexEndpoints.searchLimit, ids.length),
      );
      final mangas = await api.fetchMangaById(
        ids: page,
        limit: MangaDexEndpoints.breakLimit,
      );

      try {
        await (
          statisticsMutation.run(ref, (ref) async {
            return await ref.get(statisticsProvider.notifier).get(mangas);
          }),
          readChaptersMutation(me?.id).run(ref, (ref) async {
            return await ref
                .get(readChaptersProvider(me?.id).notifier)
                .get(mangas);
          }),
        ).wait;
      } catch (e) {
        logger.e(e, error: e);
      }

      return PageResultsMetaData(mangas, widget.manga.relatedMangas.length);
    },
  );

  @override
  void dispose() {
    _chapterController.dispose();
    _coverController.dispose();
    _relatedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tr = context.t;
    final messenger = ScaffoldMessenger.of(context);
    final router = AutoRouter.of(context);
    final me = ref.watch(loggedUserProvider).value;
    final theme = Theme.of(context);

    final hasRelated = widget.manga.relatedMangas.isNotEmpty;
    final tabController = useTabController(
      initialLength: hasRelated
          ? _ViewType.values.length
          : _ViewType.values.length - 1,
    );
    final tabview = useListenableSelector(
      tabController,
      () => tabController.index,
    );

    String? lastvolchap;

    if ((widget.manga.attributes!.lastVolume != null &&
            widget.manga.attributes!.lastVolume!.isNotEmpty) ||
        (widget.manga.attributes!.lastChapter != null &&
            widget.manga.attributes!.lastChapter!.isNotEmpty)) {
      lastvolchap = '';

      if (widget.manga.attributes!.lastVolume != null &&
          widget.manga.attributes!.lastVolume!.isNotEmpty) {
        lastvolchap += 'Volume ${widget.manga.attributes!.lastVolume}';
      }

      if (widget.manga.attributes!.lastChapter != null &&
          widget.manga.attributes!.lastChapter!.isNotEmpty) {
        lastvolchap +=
            '${lastvolchap.isEmpty ? '' : ', '}Chapter ${widget.manga.attributes!.lastChapter!}';
      }
    }

    final mangaTagChips = useMemoized<Map<TagGroup, List<Widget>>>(() {
      final map = widget.manga.attributes!.tags.groupListsBy(
        (tag) => tag.attributes.group,
      );
      return map.map((group, list) {
        return MapEntry(
          group,
          list
              .map(
                (e) => IconTextChip(
                  key: ValueKey(e.id),
                  text: e.attributes.name.get(tr.$meta.locale.languageCode),
                  onPressed: () =>
                      router.push(MangaDexTagViewRoute(tagId: e.id, tag: e)),
                ),
              )
              .toList(),
        );
      });
    }, [widget.manga]);

    final newListMutation = ref.watch(userListNewMutation(me?.id));

    if (newListMutation is MutationError) {
      Styles.showSnackBar(
        messenger,
        content: tr.mangadex.newListError(
          error: (newListMutation as MutationError).error.toString(),
        ),
      );
    } else if (newListMutation is MutationSuccess) {
      Styles.showSnackBar(
        messenger,
        content: tr.mangadex.newListOk,
        color: Colors.green,
      );
    }

    final moreMenu = MenuAnchor(
      builder: (context, controller, child) => IconButton(
        style: Styles.squareIconButtonStyle(
          backgroundColor: theme.colorScheme.surface.withAlpha(200),
        ),
        onPressed: () {
          if (controller.isOpen) {
            controller.close();
          } else {
            controller.open();
          }
        },
        icon: const Icon(Icons.more_vert),
      ),
      menuChildren: [
        MenuItemButton(
          onPressed: () => context.router.push(
            ExtensionSearchRoute(
              query: SearchQuery(
                title: widget.manga.attributes!.title.get(
                  tr.$meta.locale.languageCode,
                ),
              ),
            ),
          ),
          leadingIcon: const Icon(Icons.search),
          child: Text(tr.webSources.searchWithExt),
        ),
        MenuItemButton(
          onPressed: () =>
              Clipboard.setData(
                ClipboardData(
                  text: 'gagaku://open${context.router.currentUrl}',
                ),
              ).then((_) {
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    showCloseIcon: true,
                    duration: const Duration(milliseconds: 1000),
                    content: Text(tr.ui.copyClipboard),
                  ),
                );
              }),
          leadingIcon: const Icon(Icons.copy),
          child: Text(tr.mangaView.copyLink),
        ),
      ],
    );

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          if (ref.read(followingStatusProvider(widget.manga)).hasError) {
            ref.invalidate(followingStatusProvider(widget.manga));
          }

          if (ref.read(readingStatusProvider(widget.manga)).hasError) {
            ref.invalidate(readingStatusProvider(widget.manga));
          }

          switch (_ViewType.values[tabview]) {
            case _ViewType.chapters:
              return _chapterController.refresh();
            case _ViewType.art:
              return _coverController.refresh();
            case _ViewType.related:
              return _relatedController.refresh();
          }
        },
        notificationPredicate: (notification) {
          // Depth 1 is the top of the NestedScrollView
          if (notification is OverscrollNotification &&
              notification.velocity == 0.0 &&
              notification.overscroll < 0.0) {
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
                leading: AutoLeadingButton(),
                flexibleSpace: FlexibleSpaceBar(
                  expandedTitleScale: 2.0,
                  title: Text(
                    widget.manga.attributes!.title.get(
                      tr.$meta.locale.languageCode,
                    ),
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
                        imageUrl: widget.manga.getFirstCoverUrl(
                          quality: CoverArtQuality.medium,
                        ),
                        cacheManager: gagakuImageCache,
                        colorBlendMode: BlendMode.modulate,
                        color: Colors.grey,
                        fit: BoxFit.cover,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 20.0, bottom: 10.0),
                          child: CountryFlag(
                            flag:
                                widget.manga.attributes!.originalLanguage.flag,
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  OverflowBar(
                    spacing: 6.0,
                    children: [
                      if (me != null)
                        _FollowingStatusButton(
                          key: ValueKey(
                            '_FollowingStatusButton(${widget.manga.id})',
                          ),
                          manga: widget.manga,
                        ),
                      if (me != null)
                        _ReadingStatusDropdown(
                          key: ValueKey(
                            '_ReadingStatusDropdown(${widget.manga.id})',
                          ),
                          manga: widget.manga,
                        ),
                      if (me != null)
                        _RatingMenu(
                          key: ValueKey('_RatingMenu(${widget.manga.id})'),
                          manga: widget.manga,
                        ),
                      if (me != null)
                        _UserListsMenu(
                          key: ValueKey('_UserListsMenu(${widget.manga.id})'),
                          manga: widget.manga,
                        ),
                      moreMenu,
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
                      key: ValueKey('MangaGenreRow(${widget.manga.id})'),
                      manga: widget.manga,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: MangaStatisticsRow(
                      key: ValueKey('MangaStatisticsRow(${widget.manga.id})'),
                      manga: widget.manga,
                      shortStatus: false,
                    ),
                  ),
                  if (widget.manga.attributes!.altTitles.isNotEmpty)
                    ExpansionTile(
                      title: Text(tr.mangaView.altTitles),
                      children: [
                        for (final Map(entries: entry)
                            in widget.manga.attributes!.altTitles)
                          ExpansionTile(
                            title: Text(
                              tr[Languages.get(entry.first.key).label],
                            ),
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: ListTile(
                                  tileColor:
                                      theme.colorScheme.surfaceContainerHighest,
                                  title: Text(entry.first.value),
                                  onTap: () =>
                                      Clipboard.setData(
                                        ClipboardData(text: entry.first.value),
                                      ).then((_) {
                                        if (!context.mounted) return;
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            showCloseIcon: true,
                                            duration: const Duration(
                                              milliseconds: 1000,
                                            ),
                                            content: Text(tr.ui.copyClipboard),
                                          ),
                                        );
                                      }),
                                  trailing: IconButton(
                                    tooltip: tr.webSources.searchWithExt,
                                    style: Styles.squareIconButtonStyle(
                                      backgroundColor: theme.colorScheme.surface
                                          .withAlpha(200),
                                    ),
                                    onPressed: () => context.router.push(
                                      ExtensionSearchRoute(
                                        query: SearchQuery(
                                          title: entry.first.value,
                                        ),
                                      ),
                                    ),
                                    icon: const Icon(Icons.search),
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  if (widget.manga.attributes!.description.isNotEmpty)
                    ExpansionTile(
                      title: Text(tr.mangaView.synopsis),
                      children: [
                        for (final MapEntry(key: lang, value: desc)
                            in widget.manga.attributes!.description.entries)
                          ExpansionTile(
                            title: Text(tr[Languages.get(lang).label]),
                            children: [
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(8),
                                color:
                                    theme.colorScheme.surfaceContainerHighest,
                                child: MarkdownBody(
                                  data: desc,
                                  onTapLink: (text, url, title) async {
                                    if (url != null) {
                                      await Styles.tryLaunchUrl(context, url);
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ExpansionTile(
                    title: Text(tr.mangaView.info),
                    children: [
                      if (widget.manga.author.isNotEmpty)
                        MultiChildExpansionTile(
                          title: tr.mangaView.author,
                          children: [
                            for (final author in widget.manga.author)
                              ButtonChip(
                                text: author.attributes.name,
                                onPressed: () {
                                  router.pushPath('/author/${author.id}');
                                },
                              ),
                          ],
                        ),
                      if (widget.manga.artist.isNotEmpty)
                        MultiChildExpansionTile(
                          title: tr.mangaView.artist,
                          children: [
                            for (final artist in widget.manga.artist)
                              ButtonChip(
                                text: artist.attributes.name,
                                onPressed: () {
                                  router.pushPath('/author/${artist.id}');
                                },
                              ),
                          ],
                        ),
                      if (widget.manga.attributes!.publicationDemographic !=
                          null)
                        ExpansionTile(
                          title: Text(tr.mangaView.demographic),
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: IconTextChip(
                                  text: widget
                                      .manga
                                      .attributes!
                                      .publicationDemographic!
                                      .label,
                                ),
                              ),
                            ),
                          ],
                        ),
                      if (mangaTagChips[TagGroup.genre] != null)
                        MultiChildExpansionTile(
                          title: tr.mangaView.genre,
                          children: mangaTagChips[TagGroup.genre]!,
                        ),
                      if (mangaTagChips[TagGroup.theme] != null)
                        MultiChildExpansionTile(
                          title: tr.mangaView.theme,
                          children: mangaTagChips[TagGroup.theme]!,
                        ),
                      if (mangaTagChips[TagGroup.format] != null)
                        MultiChildExpansionTile(
                          title: tr.mangaView.format,
                          children: mangaTagChips[TagGroup.format]!,
                        ),
                      MultiChildExpansionTile(
                        title: tr.mangaView.track,
                        children: [
                          if (widget.manga.attributes!.links?.raw != null)
                            ButtonChip(
                              onPressed: () async {
                                final url =
                                    widget.manga.attributes!.links!.raw!;

                                await Styles.tryLaunchUrl(context, url);
                              },
                              text: tr.mangaView.officialRaw,
                            ),
                          if (widget.manga.attributes!.links?.mu != null)
                            ButtonChip(
                              onPressed: () async {
                                final seriesnum = int.tryParse(
                                  widget.manga.attributes!.links!.mu!,
                                );
                                var url =
                                    'https://www.mangaupdates.com/series/${widget.manga.attributes!.links!.mu!}';

                                if (seriesnum != null) {
                                  url =
                                      'https://www.mangaupdates.com/series.html?id=${widget.manga.attributes!.links!.mu!}';
                                }

                                await Styles.tryLaunchUrl(context, url);
                              },
                              text: 'MangaUpdates',
                            ),
                          if (widget.manga.attributes!.links?.al != null)
                            ButtonChip(
                              onPressed: () async {
                                final url =
                                    'https://anilist.co/manga/${widget.manga.attributes!.links!.al!}';
                                await Styles.tryLaunchUrl(context, url);
                              },
                              text: 'AniList',
                            ),
                          if (widget.manga.attributes!.links?.mal != null)
                            ButtonChip(
                              onPressed: () async {
                                final url =
                                    'https://myanimelist.net/manga/${widget.manga.attributes!.links!.mal!}';
                                await Styles.tryLaunchUrl(context, url);
                              },
                              text: 'MyAnimeList',
                            ),
                          ButtonChip(
                            onPressed: () async {
                              final route = Uri.parse(router.currentUrl);
                              await Styles.tryLaunchUrl(
                                context,
                                'http://mangadex.org${route.path}',
                              );
                            },
                            text: tr.mangaView.openOn(arg: 'MangaDex'),
                          ),
                        ],
                      ),
                      if (lastvolchap != null)
                        ExpansionTile(
                          title: Text(tr.mangaView.finalChapter),
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
                      Tab(text: tr.mangaView.chapters),
                      Tab(text: tr.mangaView.art),
                      if (hasRelated) Tab(text: tr.mangaView.related),
                    ],
                  ),
                  if (_ViewType.values[tabview] == _ViewType.chapters)
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Consumer(
                            builder: (context, ref, child) {
                              final sort = ref.watch(
                                mangaChaptersListSortProvider,
                              );
                              return ElevatedButton(
                                style: Styles.buttonStyle(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                  ),
                                ),
                                onPressed: () {
                                  if (sort == ListSort.descending) {
                                    ref
                                            .read(
                                              mangaChaptersListSortProvider
                                                  .notifier,
                                            )
                                            .state =
                                        ListSort.ascending;
                                  } else {
                                    ref
                                            .read(
                                              mangaChaptersListSortProvider
                                                  .notifier,
                                            )
                                            .state =
                                        ListSort.descending;
                                  }

                                  setState(() {
                                    _chapterController.refresh();
                                  });
                                },
                                child: Text(sort.name.capitalize()),
                              );
                            },
                          ),
                          const Spacer(),
                          if (me != null)
                            PagingListener(
                              controller: _chapterController,
                              builder: (context, state, fetchNextPage) {
                                final chapters = state.items;

                                final allRead = chapters != null
                                    ? ref.watch(
                                        readChaptersProvider(me.id).select(
                                          (value) => switch (value) {
                                            AsyncValue(value: final data?) =>
                                              data[widget.manga.id]
                                                      ?.containsAll(
                                                        chapters.map(
                                                          (e) => e.id,
                                                        ),
                                                      ) ==
                                                  true,
                                            _ => false,
                                          },
                                        ),
                                      )
                                    : false;

                                final opt = allRead
                                    ? tr.mangaView.unread
                                    : tr.mangaView.read;

                                return ElevatedButton(
                                  style: Styles.buttonStyle(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                    ),
                                  ),
                                  onPressed: () async {
                                    final result = await showDialog<bool>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        final nav = Navigator.of(context);
                                        return AlertDialog(
                                          title: Text(
                                            tr.mangaView.markAllAs(arg: opt),
                                          ),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                tr.mangaView.markAllWarning(
                                                  arg: opt,
                                                ),
                                              ),
                                            ],
                                          ),
                                          actions: <Widget>[
                                            ElevatedButton(
                                              child: Text(tr.ui.no),
                                              onPressed: () {
                                                nav.pop(false);
                                              },
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                nav.pop(true);
                                              },
                                              child: Text(tr.ui.yes),
                                            ),
                                          ],
                                        );
                                      },
                                    );

                                    if (chapters != null && result == true) {
                                      readChaptersMutation(me.id).run(ref, (
                                        ref,
                                      ) async {
                                        return await ref
                                            .get(
                                              readChaptersProvider(
                                                me.id,
                                              ).notifier,
                                            )
                                            .set(
                                              widget.manga,
                                              read: !allRead ? chapters : null,
                                              unread: allRead ? chapters : null,
                                            );
                                      });
                                    }
                                  },
                                  child: Text(
                                    tr.mangaView.markAllVisibleAs(arg: opt),
                                  ),
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
            child: switch (_ViewType.values[tabview]) {
              _ViewType.chapters => _MangaChaptersView(
                manga: widget.manga,
                controller: _chapterController,
              ),
              _ViewType.art => _MangaCoversView(
                manga: widget.manga,
                controller: _coverController,
              ),
              _ViewType.related => MangaListWidget(
                title: Text(
                  tr.mangaView.relatedTitles,
                  style: TextStyle(fontSize: 24),
                ),
                noController: true,
                children: [
                  MangaListViewSliver(
                    controller: _relatedController,
                    headers: widget.manga.relatedMangas.fold({}, (
                      previousValue,
                      element,
                    ) {
                      previousValue?[element.id] = tr[element.related!.label];
                      return previousValue;
                    }),
                  ),
                ],
              ),
            },
          ),
        ),
      ),
    );
  }
}

class _MangaChaptersView extends StatelessWidget {
  const _MangaChaptersView({required this.manga, required this.controller});

  final Manga manga;
  final PagingController<int, Chapter> controller;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      cacheExtent: MediaQuery.sizeOf(context).height,
      slivers: [
        PagingListener(
          controller: controller,
          builder: (context, state, fetchNextPage) {
            return _ChapterListSliver(
              state: state,
              fetchNextPage: fetchNextPage,
              manga: manga,
            );
          },
        ),
      ],
    );
  }
}

class _MangaCoversView extends StatelessWidget {
  const _MangaCoversView({required this.manga, required this.controller});

  final Manga manga;
  final PagingController<int, CoverArt> controller;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        PagingListener(
          controller: controller,
          builder: (context, state, fetchNextPage) {
            return PagedSliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 256,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 0.7,
              ),
              state: state,
              fetchNextPage: fetchNextPage,
              builderDelegate: PagedChildBuilderDelegate<CoverArt>(
                animateTransitions: true,
                itemBuilder: (context, item, index) => _CoverArtItem(
                  key: ValueKey(item.id),
                  cover: item,
                  manga: manga,
                  page: index,
                  onTap: () async {
                    Navigator.push(
                      context,
                      TransparentOverlay(
                        builder: (context) {
                          return HookBuilder(
                            builder: (context) {
                              final controller = usePageController(
                                initialPage: index,
                              );
                              return Scaffold(
                                appBar: AppBar(
                                  backgroundColor: Colors.transparent,
                                  leading: CloseButton(
                                    style: IconButton.styleFrom(
                                      backgroundColor: Colors.black,
                                    ),
                                  ),
                                ),
                                backgroundColor: Colors.transparent,
                                extendBody: true,
                                extendBodyBehindAppBar: true,
                                body: PageView.builder(
                                  scrollBehavior:
                                      const MouseTouchScrollBehavior(),
                                  findChildIndexCallback: (key) {
                                    final valueKey = key as ValueKey<String>;
                                    final val = state.items!.indexWhere(
                                      (i) => i.id == valueKey.value,
                                    );
                                    return val >= 0 ? val : null;
                                  },
                                  itemBuilder: (BuildContext context, int id) {
                                    final item = state.items![id];
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
                                            cacheManager: gagakuImageCache,
                                            imageBuilder:
                                                (context, imageProvider) {
                                                  return PhotoView(
                                                    backgroundDecoration:
                                                        const BoxDecoration(
                                                          color: Colors
                                                              .transparent,
                                                        ),
                                                    imageProvider:
                                                        imageProvider,
                                                    minScale:
                                                        PhotoViewComputedScale
                                                            .contained *
                                                        0.8,
                                                    maxScale:
                                                        PhotoViewComputedScale
                                                            .covered *
                                                        5.0,
                                                    initialScale:
                                                        PhotoViewComputedScale
                                                            .contained,
                                                  );
                                                },
                                            fit: BoxFit.contain,
                                            progressIndicatorBuilder:
                                                (
                                                  context,
                                                  url,
                                                  downloadProgress,
                                                ) => const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  itemCount: state.items!.length,
                                  controller: controller,
                                  scrollDirection: Axis.horizontal,
                                ),
                              );
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

enum _ChapterListElementType { header, chapter }

class _ChapterListElement {
  const _ChapterListElement(
    this.type, {
    this.header,
    this.chapter,
    this.bold = false,
  }) : assert(header != null || chapter != null);

  final _ChapterListElementType type;
  final String? header;
  final Chapter? chapter;
  final bool bold;
}

class _ChapterListSliver extends HookConsumerWidget {
  const _ChapterListSliver({
    required this.state,
    required this.fetchNextPage,
    required this.manga,
  });

  final PagingState<int, Chapter> state;
  final NextPageCallback fetchNextPage;
  final Manga manga;

  static const _noVolumeKey = 'none';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tr = context.t;
    final me = ref.watch(loggedUserProvider).value;
    // final sort = ref.watch(mangaChaptersListSortProvider);
    // final sortfunc = sort == ListSort.ascending
    //     ? compareNatural
    //     : (a, b) {
    //         return compareNatural(b, a);
    //       };

    // Redundancy
    useEffect(() {
      Future.delayed(Duration.zero, () async {
        await readChaptersMutation(me?.id).run(ref, (ref) async {
          return await ref.get(readChaptersProvider(me?.id).notifier).get([
            manga,
          ]);
        });
      });
      return null;
    }, [manga, me]);

    final chapters = state.items;

    final builtItems = useMemoized(() {
      if (chapters == null) {
        return null;
      }

      final keysGrouped = chapters.groupListsBy(
        (chapter) => chapter.attributes.volume ?? _noVolumeKey,
      );

      var items = <_ChapterListElement>[];

      for (final vol in keysGrouped.keys) {
        if (vol == _noVolumeKey) {
          items.add(
            _ChapterListElement(
              _ChapterListElementType.header,
              header: tr.mangaView.noVolume,
              bold: true,
            ),
          );
        } else {
          items.add(
            _ChapterListElement(
              _ChapterListElementType.header,
              header: tr.mangaView.volume(n: vol),
              bold: true,
            ),
          );
        }

        items = keysGrouped[vol]!.foldIndexed(items, (index, list, chapter) {
          // If next chapter is the same number
          // AND previous chapter isn't (or doesnt exist)
          if (index < keysGrouped[vol]!.length - 1 &&
              keysGrouped[vol]![index + 1].attributes.chapter ==
                  chapter.attributes.chapter &&
              (index == 0 ||
                  (index > 0 &&
                      keysGrouped[vol]![index - 1].attributes.chapter !=
                          chapter.attributes.chapter))) {
            list.add(
              _ChapterListElement(
                _ChapterListElementType.header,
                header: chapter.attributes.chapter != null
                    ? tr.mangaView.chapter(n: chapter.attributes.chapter!)
                    : chapter.title,
              ),
            );
          }

          list.add(
            _ChapterListElement(
              _ChapterListElementType.chapter,
              chapter: chapter,
            ),
          );
          return list;
        });
      }

      return items;
    }, [state]);

    final newState = PagingState<int, _ChapterListElement>(
      error: state.error,
      pages: state.keys == null
          ? null
          : List.generate(state.keys!.length, (i) => i == 0 ? builtItems! : []),
      keys: state.keys,
      hasNextPage: state.hasNextPage,
      isLoading: state.isLoading,
    );

    return PagedSliverList.separated(
      state: newState,
      fetchNextPage: fetchNextPage,
      separatorBuilder: (_, index) => const SizedBox(height: 4.0),
      builderDelegate: PagedChildBuilderDelegate<_ChapterListElement>(
        itemBuilder: (context, item, index) {
          var lastChapIsSame = false;
          var nextChapIsSame = false;

          if (item.type == _ChapterListElementType.header) {
            return _ChapterListHeader(
              key: ValueKey(item.header!),
              text: item.header!,
              bold: item.bold,
            );
          }

          // is chapter beyond this point

          final chapid = chapters!.indexWhere((c) => c.id == item.chapter!.id);
          final thischap = item.chapter!;
          final chapbtn = ChapterButtonWidget(
            key: ValueKey(thischap.id),
            chapter: thischap,
            manga: manga,
          );

          if (chapid > 0) {
            final lastchap = chapters[chapid - 1];
            lastChapIsSame =
                lastchap.attributes.chapter == thischap.attributes.chapter &&
                lastchap.attributes.volume == thischap.attributes.volume;
          }

          if (chapid < chapters.length - 1) {
            final nextchap = chapters[chapid + 1];
            nextChapIsSame =
                nextchap.attributes.chapter == thischap.attributes.chapter &&
                nextchap.attributes.volume == thischap.attributes.volume;
          }

          if (lastChapIsSame || nextChapIsSame) {
            return Row(
              key: ValueKey(thischap.id),
              children: [
                const Icon(Icons.subdirectory_arrow_right, size: 15.0),
                Flexible(child: chapbtn),
              ],
            );
          }

          return chapbtn;
        },
      ),
    );
  }
}

class _ChapterListHeader extends HookWidget {
  final String text;
  final bool bold;

  const _ChapterListHeader({super.key, required this.text, required this.bold});

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive();
    return Padding(
      key: ValueKey(key),
      padding: const EdgeInsets.all(6.0),
      child: Text(
        text,
        style: TextStyle(fontWeight: bold ? FontWeight.bold : null),
      ),
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
    final tr = context.t;
    useAutomaticKeepAlive();
    final aniController = useAnimationController(
      duration: const Duration(milliseconds: 100),
    );
    final gradient = useAnimation(
      aniController.drive(Styles.coverArtGradientTween),
    );
    final url = manga.getUrlFromCover(cover);

    final image = GridAlbumImage(
      gradient: gradient,
      child: CachedNetworkImage(
        imageUrl: url.quality(quality: CoverArtQuality.medium),
        cacheManager: gagakuImageCache,
        width: 256.0,
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            const Center(child: CircularProgressIndicator()),
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
                    text: tr.mangaView.volume(n: cover.attributes!.volume!),
                  )
                : null,
            child: image,
          ),
        ),
      ),
    );
  }
}

class _FollowingStatusButton extends ConsumerWidget {
  const _FollowingStatusButton({super.key, required this.manga});

  final Manga manga;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tr = context.t;
    final theme = Theme.of(context);

    final followProvider = ref.watch(followingStatusProvider(manga));
    final following = followProvider.value;
    final setFollowing = ref.watch(followStatusMutation(manga));
    final statusProvider = ref.watch(readingStatusProvider(manga));
    final reading = statusProvider.value;

    if (following == null ||
        statusProvider.isLoading ||
        setFollowing is MutationPending) {
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
            },
          );

          if (result != null) {
            readingStatusMutation(manga).run(ref, (ref) async {
              return await ref
                  .get(readingStatusProvider(manga).notifier)
                  .set(result.$1);
            });

            followStatusMutation(manga).run(ref, (ref) async {
              return await ref
                  .get(followingStatusProvider(manga).notifier)
                  .set(result.$2);
            });
          }
        },
        child: Text(tr.mangaActions.addToLibrary),
      );
    }

    if (reading == null) {
      return const SizedBox.shrink();
    }

    return IconButton(
      padding: EdgeInsets.zero,
      tooltip: following ? tr.mangaActions.unfollow : tr.mangaActions.follow,
      style: Styles.squareIconButtonStyle(
        backgroundColor: theme.colorScheme.surface.withAlpha(200),
      ),
      color: theme.colorScheme.primary,
      onPressed: () async {
        bool set = !following;
        followStatusMutation(manga).run(ref, (ref) async {
          return await ref
              .get(followingStatusProvider(manga).notifier)
              .set(set);
        });
      },
      icon: Icon(
        following
            ? Icons.notifications_active
            : Icons.notifications_off_outlined,
      ),
    );
  }
}

class _ReadingStatusDropdown extends ConsumerWidget {
  const _ReadingStatusDropdown({super.key, required this.manga});

  final Manga manga;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tr = context.t;
    final theme = Theme.of(context);

    final readProvider = ref.watch(readingStatusProvider(manga));
    final reading = readProvider.value;
    final setReadingStatus = ref.watch(readingStatusMutation(manga));

    if (readProvider.isLoading || setReadingStatus is MutationPending) {
      return _loadingAction;
    }

    if (reading == null) {
      return const SizedBox.shrink();
    }

    return DropdownMenu<MangaReadingStatus>(
      initialSelection: reading,
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
        readingStatusMutation(manga).run(ref, (ref) async {
          return await ref
              .get(readingStatusProvider(manga).notifier)
              .set(status);
        });

        if (status == null || status == MangaReadingStatus.remove) {
          followStatusMutation(manga).run(ref, (ref) async {
            return await ref
                .get(followingStatusProvider(manga).notifier)
                .set(false);
          });
        }
      },
      dropdownMenuEntries: List<DropdownMenuEntry<MangaReadingStatus>>.generate(
        MangaReadingStatus.values.length,
        (int index) => DropdownMenuEntry<MangaReadingStatus>(
          value: MangaReadingStatus.values[index],
          label: tr[MangaReadingStatus.values[index].label],
        ),
      ),
    );
  }
}

class _RatingMenu extends HookConsumerWidget {
  const _RatingMenu({super.key, required this.manga});

  final Manga manga;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tr = context.t;
    final theme = Theme.of(context);
    final ratingProv = ref.watch(ratingsProvider(manga));
    final rating = ratingProv.value;
    final ratingsMut = ref.watch(ratingsMutation);
    final hasRating = rating != null;
    final isLoading = ratingsMut is MutationPending || ratingProv.isLoading;

    return MenuAnchor(
      builder: (context, controller, child) {
        return Material(
          color: hasRating
              ? theme.colorScheme.primaryContainer
              : theme.colorScheme.surface.withAlpha(200),
          borderRadius: const BorderRadius.all(Radius.circular(6.0)),
          child: isLoading
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
            onPressed: () => ratingsMutation.run(ref, (ref) async {
              await ref.get(ratingsProvider(manga).notifier).set(index + 1);
            }),
            child: Text(tr.mangadex.ratings[index + 1]),
          ),
        ).reversed,
        if (hasRating)
          MenuItemButton(
            onPressed: () => ratingsMutation.run(ref, (ref) async {
              await ref.get(ratingsProvider(manga).notifier).set(null);
            }),
            child: Text(tr.mangadex.ratings[0]),
          ),
      ],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
                '${rating.rating}',
                style: TextStyle(color: theme.colorScheme.onPrimaryContainer),
              ),
          ],
        ),
      ),
    );
  }
}

class _UserListsMenu extends ConsumerWidget {
  const _UserListsMenu({super.key, required this.manga});

  final Manga manga;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tr = context.t;
    final theme = Theme.of(context);
    final me = ref.watch(loggedUserProvider).value;
    final userListsProv = ref.watch(userListsProvider(me?.id));
    final updateList = ref.watch(userListModifyMutation(me?.id));
    final userLists = userListsProv.value;
    final isLoading =
        updateList is MutationPending ||
        userListsProv.isLoading ||
        userLists == null;

    return MenuAnchor(
      builder: (context, controller, child) {
        return Material(
          color: theme.colorScheme.surface.withAlpha(200),
          borderRadius: const BorderRadius.all(Radius.circular(6.0)),
          child: isLoading
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
          for (final list in userLists)
            CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              title: Text(list.attributes.name),
              value: list.set.contains(manga.id),
              onChanged: (bool? value) async {
                userListModifyMutation(me?.id).run(ref, (ref) async {
                  return await ref
                      .get(userListsProvider(me?.id).notifier)
                      .updateList(list, manga, value == true);
                });
              },
            ),
        MenuItemButton(
          child: Text(tr.mangadex.createNewListBtn),
          onPressed: () async {
            final result = await showDialog<(String, CustomListVisibility)>(
              context: context,
              builder: (BuildContext context) {
                return HookBuilder(
                  builder: (context) {
                    final nav = Navigator.of(context);
                    final nameController = useTextEditingController();
                    final nprivate = useValueNotifier(
                      CustomListVisibility.private,
                    );

                    return AlertDialog(
                      title: Text(tr.mangadex.createNewList),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            controller: nameController,
                            decoration: InputDecoration(
                              filled: true,
                              labelText: tr.mangadex.listName,
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (String? value) {
                              return (value == null || value.isEmpty)
                                  ? tr.mangadex.listNameEmptyWarning
                                  : null;
                            },
                          ),
                          HookBuilder(
                            builder: (_) {
                              final private = useValueListenable(nprivate);
                              return CheckboxListTile(
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                title: Text(tr.mangadex.privateList),
                                value: private == CustomListVisibility.private,
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
                          child: Text(tr.ui.cancel),
                          onPressed: () {
                            nav.pop(null);
                          },
                        ),
                        HookBuilder(
                          builder: (_) {
                            final nameIsEmpty = useListenableSelector(
                              nameController,
                              () => nameController.text.isEmpty,
                            );
                            return ElevatedButton(
                              onPressed: nameIsEmpty
                                  ? null
                                  : () {
                                      if (nameController.text.isNotEmpty) {
                                        nav.pop((
                                          nameController.text,
                                          nprivate.value,
                                        ));
                                      }
                                    },
                              child: Text(tr.ui.create),
                            );
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            );

            if (result != null) {
              userListNewMutation(me?.id).run(ref, (ref) async {
                return await ref
                    .get(userListsProvider(me?.id).notifier)
                    .newList(result.$1, result.$2, []);
              });
            }
          },
        ),
      ],
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Icon(Icons.playlist_add),
      ),
    );
  }
}

class _AddToLibraryDialog extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final tr = context.t;
    final theme = Theme.of(context);
    final nav = Navigator.of(context);
    final nreading = useValueNotifier(MangaReadingStatus.plan_to_read);
    final nfollowing = useValueNotifier(true);

    return AlertDialog(
      title: Text(tr.mangaActions.addToLibrary),
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
                dropdownMenuEntries:
                    List<DropdownMenuEntry<MangaReadingStatus>>.generate(
                      MangaReadingStatus.values.length - 1,
                      (int index) => DropdownMenuEntry<MangaReadingStatus>(
                        value: MangaReadingStatus.values[index + 1],
                        label: tr[MangaReadingStatus.values[index + 1].label],
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
                child: Icon(
                  following
                      ? Icons.notification_add
                      : Icons.notifications_off_outlined,
                ),
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
