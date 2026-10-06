import 'dart:math';

import 'package:flutter/rendering.dart';
import 'package:gagaku/util/riverpod.dart';
import 'package:collection/collection.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/mangadex/model/model.dart';
import 'package:gagaku/mangadex/model/types.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:gagaku/routes.dart';
import 'package:gagaku/util/infinite_scroll.dart';
import 'package:gagaku/util/manga_detail.dart';
import 'package:gagaku/util/material_hooks.dart';
import 'package:gagaku/util/ui.dart';
import 'package:gagaku/util/util.dart';
import 'package:gagaku/web/model/types.dart' show SearchQuery;
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'manga_view.g.dart';

enum _ViewType { chapters, art, related }

@Riverpod(retry: noRetry)
Future<Manga> _fetchMangaFromId(Ref ref, String mangaId) async {
  final me = await ref.watch(loggedUserProvider.future);
  final api = ref.watch(mangadexProvider);
  final manga = await api.fetchMangaById(
    ids: [mangaId],
    limit: MangaDexEndpoints.breakLimit,
  );

  await (
    ref.run((tsx) async {
      return await tsx.get(statisticsProvider.notifier).get(manga);
    }),
    ref.run((tsx) async {
      return await tsx.get(readChaptersProvider(me?.id).notifier).get(manga);
    }),
  ).wait;

  return manga.first;
}

class MangaDexMangaViewPage extends ConsumerWidget {
  const MangaDexMangaViewPage({super.key, required this.mangaId, this.manga});

  final String mangaId;

  final Manga? manga;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (manga != null) {
      return MangaDexMangaViewWidget(manga: manga!);
    }

    return DataProviderWhenWidget(
      provider: _fetchMangaFromIdProvider(mangaId),
      loadingBuilder: (context, progress) => Scaffold(
        appBar: AppBar(leading: const BackButton()),
        body: Center(
          child: CircularProgressIndicator(value: progress?.toDouble()),
        ),
      ),
      errorBuilder: (context, child, _, _) => Scaffold(
        appBar: AppBar(leading: const BackButton()),
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
  ConsumerState<MangaDexMangaViewWidget> createState() =>
      _MangaDexMangaViewWidgetState();
}

class _MangaDexMangaViewWidgetState
    extends ConsumerState<MangaDexMangaViewWidget> {
  static const chapterInfo = MangaDexFeeds.mangaChapters;
  static const coverInfo = MangaDexFeeds.mangaCovers;

  late final _chapterManager = OffsetPagingManager<Chapter>(
    limit: chapterInfo.limit,
  );

  late final _chapterController = PagingController<int, Chapter>(
    getNextPageKey: _chapterManager.getNextPageKey,
    fetchPage: (pageKey) async {
      final api = ref.read(mangadexProvider);
      final sort = ref.read(mangaChaptersListSortProvider);
      final chapterlist = await api.fetchChapterFeed(
        path: chapterInfo.path!.replaceFirst('{id}', widget.manga.id),
        feedKey: chapterInfo.key,
        limit: chapterInfo.limit,
        offset: pageKey,
        entity: widget.manga,
        order: sort == ListSort.ascending
            ? ChapterFilterOrder.chapter_asc
            : ChapterFilterOrder.chapter_desc,
        ignoreOriginalLanguage: true,
      );

      _chapterManager.totalItems = chapterlist.total;

      final chapters = chapterlist.data.cast<Chapter>();

      try {
        ref.run((tsx) async {
          return await tsx.get(chapterStatsProvider.notifier).get(chapters);
        });
      } catch (e) {
        logger.e(e, error: e);
      }

      return chapters;
    },
  );

  late final _coverManager = OffsetPagingManager<CoverArt>(
    limit: coverInfo.limit,
  );

  late final _coverController = PagingController<int, CoverArt>(
    getNextPageKey: _coverManager.getNextPageKey,
    fetchPage: (pageKey) async {
      final api = ref.read(mangadexProvider);
      final covers = await api.getCoverList(widget.manga, offset: pageKey);

      _coverManager.totalItems = covers.total;

      return covers.data.cast<CoverArt>();
    },
  );

  late final _relatedController = PagingController<int, Manga>(
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
        return [];
      }

      final me = await ref.readAsync(loggedUserProvider.future);
      final api = ref.read(mangadexProvider);
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
          ref.run((tsx) async {
            return await tsx.get(statisticsProvider.notifier).get(mangas);
          }),
          ref.run((tsx) async {
            return await tsx
                .get(readChaptersProvider(me?.id).notifier)
                .get(mangas);
          }),
        ).wait;
      } catch (e) {
        logger.e(e, error: e);
      }

      return mangas;
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
    final me = ref.watch(loggedUserProvider).value;

    final hasRelated = widget.manga.relatedMangas.isNotEmpty;
    final tabController = useMaterialTabController(
      initialLength: hasRelated
          ? _ViewType.values.length
          : _ViewType.values.length - 1,
    );
    ref.listen(userListNewMutation(me?.id), (_, next) {
      if (next is MutationError) {
        Styles.showSnackBar(
          messenger,
          content: tr.mangadex.newListError(
            error: (next as MutationError).error.toString(),
          ),
        );
      } else if (next is MutationSuccess) {
        Styles.showSnackBar(
          messenger,
          content: tr.mangadex.newListOk,
          color: Colors.green,
        );
      }
    });

    Future<void> doRefresh() async {
      if (ref.read(followingStatusProvider(widget.manga)).hasError) {
        ref.invalidate(followingStatusProvider(widget.manga));
      }

      if (ref.read(readingStatusProvider(widget.manga)).hasError) {
        ref.invalidate(readingStatusProvider(widget.manga));
      }

      final me = ref.read(loggedUserProvider).value;
      if (me != null) {
        await ref.run((tsx) async {
          await tsx
              .get(readChaptersProvider(me.id).notifier)
              .invalidate(widget.manga);
        });
      }

      switch (_ViewType.values[tabController.index]) {
        case _ViewType.chapters:
          _chapterManager.reset();
          await ref
              .read(mangadexProvider)
              .invalidateAll('${chapterInfo.key}(${widget.manga.id}');
          return _chapterController.refresh();
        case _ViewType.art:
          _coverManager.reset();
          await ref
              .read(mangadexProvider)
              .invalidateAll('${coverInfo.key}(${widget.manga.id}');
          return _coverController.refresh();
        case _ViewType.related:
          return _relatedController.refresh();
      }
    }

    final scrollController = useScrollController();

    return MangaDetailScaffold(
      title: widget.manga.attributes!.title.get(tr.$meta.locale.languageCode),
      coverUrl: widget.manga.getFirstCoverUrl(quality: CoverArtQuality.medium),
      badge: CountryFlag(
        flag: widget.manga.attributes!.originalLanguage.flag,
        size: 24,
      ),
      actions: _MangaDexActionBar(manga: widget.manga),
      metadata: _MangaMetadataColumn(manga: widget.manga),
      collapsedBannerHeight: 100.0,
      tabController: tabController,
      tabs: [
        MangaDetailTab(
          label: tr.mangaView.chapters,
          scrollToTop: true,
          body: _MangaChaptersView(
            manga: widget.manga,
            controller: _chapterController,
          ),
        ),
        MangaDetailTab(
          label: tr.mangaView.art,
          body: _MangaCoversView(
            manga: widget.manga,
            controller: _coverController,
          ),
        ),
        if (hasRelated)
          MangaDetailTab(
            label: tr.mangaView.related,
            body: _MangaRelatedView(
              manga: widget.manga,
              controller: _relatedController,
            ),
          ),
      ],
      onRefresh: doRefresh,
      scrollController: scrollController,
    );
  }
}

// Metadata section shown in the side pane (two-pane) or below the banner.
class _MangaMetadataColumn extends HookWidget {
  const _MangaMetadataColumn({required this.manga});

  final Manga manga;

  @override
  Widget build(BuildContext context) {
    final tr = context.t;
    final theme = Theme.of(context);

    String? lastvolchap = useMemoized(
      () {
        String? chapStr;

        if ((manga.attributes!.lastVolume != null &&
                manga.attributes!.lastVolume!.isNotEmpty) ||
            (manga.attributes!.lastChapter != null &&
                manga.attributes!.lastChapter!.isNotEmpty)) {
          chapStr = '';

          if (manga.attributes!.lastVolume != null &&
              manga.attributes!.lastVolume!.isNotEmpty) {
            chapStr += tr.mangaView.volume(n: manga.attributes!.lastVolume!);
          }

          if (manga.attributes!.lastChapter != null &&
              manga.attributes!.lastChapter!.isNotEmpty) {
            chapStr +=
                '${chapStr.isEmpty ? '' : ', '}${tr.mangaView.chapter(n: manga.attributes!.lastChapter!)}';
          }
        }

        return chapStr;
      },
      [
        manga.attributes!.lastChapter,
        manga.attributes!.lastVolume,
        tr.$meta.locale.languageCode,
      ],
    );

    final mangaTagChips = useMemoized<Map<TagGroup, List<Widget>>>(() {
      final map = manga.attributes!.tags.groupListsBy(
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
                      MangaDexTagViewRoute(tagId: e.id, tag: e).push(context),
                ),
              )
              .toList(),
        );
      });
    }, [manga, tr.$meta.locale.languageCode]);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
            title: Text(tr.mangaView.altTitles),
            children: [
              for (final Map(entries: entry) in manga.attributes!.altTitles)
                ExpansionTile(
                  title: Text(tr[Languages.get(entry.first.key).label]),
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ListTile(
                        tileColor: theme.colorScheme.surfaceContainerHighest,
                        title: Text(entry.first.value),
                        onTap: () =>
                            Clipboard.setData(
                              ClipboardData(text: entry.first.value),
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
                        trailing: IconButton(
                          tooltip: tr.webSources.searchWithExt,
                          style: Styles.squareIconButtonStyle(
                            backgroundColor: theme.colorScheme.surface
                                .withAlpha(200),
                          ),
                          onPressed: () => ExtensionSearchRoute(
                            query: SearchQuery(title: entry.first.value),
                          ).push(context),
                          icon: const Icon(Icons.search),
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        if (manga.attributes!.description.isNotEmpty)
          ExpansionTile(
            title: Text(tr.mangaView.synopsis),
            children: [
              for (final MapEntry(key: lang, value: desc)
                  in manga.attributes!.description.entries)
                ExpansionTile(
                  title: Text(tr[Languages.get(lang).label]),
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      color: theme.colorScheme.surfaceContainerHighest,
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
            if (manga.author.isNotEmpty)
              MultiChildExpansionTile(
                title: tr.mangaView.author,
                children: [
                  for (final author in manga.author)
                    ButtonChip(
                      text: author.attributes.name,
                      onPressed: () => context.push('/author/${author.id}'),
                    ),
                ],
              ),
            if (manga.artist.isNotEmpty)
              MultiChildExpansionTile(
                title: tr.mangaView.artist,
                children: [
                  for (final artist in manga.artist)
                    ButtonChip(
                      text: artist.attributes.name,
                      onPressed: () => context.push('/author/${artist.id}'),
                    ),
                ],
              ),
            if (manga.attributes!.publicationDemographic != null)
              ExpansionTile(
                title: Text(tr.mangaView.demographic),
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
                if (manga.attributes!.links?.raw != null)
                  ButtonChip(
                    onPressed: () async {
                      await Styles.tryLaunchUrl(
                        context,
                        manga.attributes!.links!.raw!,
                      );
                    },
                    text: tr.mangaView.officialRaw,
                  ),
                if (manga.attributes!.links?.mu != null)
                  ButtonChip(
                    onPressed: () async {
                      final seriesnum = int.tryParse(
                        manga.attributes!.links!.mu!,
                      );
                      var url =
                          'https://www.mangaupdates.com/series/${manga.attributes!.links!.mu!}';
                      if (seriesnum != null) {
                        url =
                            'https://www.mangaupdates.com/series.html?id=${manga.attributes!.links!.mu!}';
                      }
                      await Styles.tryLaunchUrl(context, url);
                    },
                    text: 'MangaUpdates',
                  ),
                if (manga.attributes!.links?.al != null)
                  ButtonChip(
                    onPressed: () async {
                      await Styles.tryLaunchUrl(
                        context,
                        'https://anilist.co/manga/${manga.attributes!.links!.al!}',
                      );
                    },
                    text: 'AniList',
                  ),
                if (manga.attributes!.links?.mal != null)
                  ButtonChip(
                    onPressed: () async {
                      await Styles.tryLaunchUrl(
                        context,
                        'https://myanimelist.net/manga/${manga.attributes!.links!.mal!}',
                      );
                    },
                    text: 'MyAnimeList',
                  ),
                ButtonChip(
                  onPressed: () async {
                    final route = GoRouterState.of(context).uri;
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
      ],
    );
  }
}

// Sort button + mark-all-visible row shown above the chapter list.
class _ChapterControlsBar extends ConsumerWidget {
  const _ChapterControlsBar({
    required this.manga,
    required this.chapterController,
    required this.onSortChanged,
  });

  final Manga manga;
  final PagingController<int, Chapter> chapterController;
  final VoidCallback onSortChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tr = context.t;
    final me = ref.watch(loggedUserProvider).value;

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Consumer(
            builder: (context, ref, child) {
              final sort = ref.watch(mangaChaptersListSortProvider);
              return ElevatedButton(
                style: Styles.buttonStyle(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                ),
                onPressed: () {
                  if (sort == ListSort.descending) {
                    ref.read(mangaChaptersListSortProvider.notifier).state =
                        ListSort.ascending;
                  } else {
                    ref.read(mangaChaptersListSortProvider.notifier).state =
                        ListSort.descending;
                  }
                  onSortChanged();
                },
                child: Text(sort.name.capitalize()),
              );
            },
          ),
          const Spacer(),
          if (me != null)
            PagingListener(
              controller: chapterController,
              builder: (context, state, fetchNextPage) {
                final chapters = state.items;

                final allRead = chapters != null
                    ? ref.watch(
                        mangaReadChaptersProvider(manga).select(
                          (value) => switch (value) {
                            AsyncValue(value: final data, hasValue: true) =>
                              data?.containsAll(chapters.map((e) => e.id)) ==
                                  true,
                            _ => false,
                          },
                        ),
                      )
                    : false;

                final opt = allRead ? tr.mangaView.unread : tr.mangaView.read;

                return ElevatedButton(
                  style: Styles.buttonStyle(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  ),
                  onPressed: () async {
                    final result = await showDialog<bool>(
                      context: context,
                      builder: (BuildContext context) {
                        final nav = Navigator.of(context);
                        return AlertDialog(
                          title: Text(tr.mangaView.markAllAs(arg: opt)),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(tr.mangaView.markAllWarning(arg: opt)),
                            ],
                          ),
                          actions: <Widget>[
                            ElevatedButton(
                              child: Text(tr.ui.no),
                              onPressed: () => nav.pop(false),
                            ),
                            TextButton(
                              onPressed: () => nav.pop(true),
                              child: Text(tr.ui.yes),
                            ),
                          ],
                        );
                      },
                    );

                    if (chapters != null && result == true) {
                      ref.run((tsx) async {
                        return await tsx
                            .get(readChaptersProvider(me.id).notifier)
                            .set(
                              manga,
                              read: !allRead ? chapters : null,
                              unread: allRead ? chapters : null,
                            );
                      });
                    }
                  },
                  child: Text(tr.mangaView.markAllVisibleAs(arg: opt)),
                );
              },
            ),
        ],
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
      scrollCacheExtent: const ScrollCacheExtent.viewport(1.0),
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        PinnedHeaderSliver(
          child: Material(
            elevation: 1,
            child: _ChapterControlsBar(
              manga: manga,
              chapterController: controller,
              onSortChanged: controller.refresh,
            ),
          ),
        ),
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

class _MangaCoversView extends HookWidget {
  const _MangaCoversView({required this.manga, required this.controller});

  final Manga manga;
  final PagingController<int, CoverArt> controller;

  @override
  Widget build(BuildContext context) {
    final tr = context.t;
    final state = useValueListenable(controller);

    final selectedLocales = useState<Set<String?>?>(null);

    final discoveredLocales = useMemoized(() {
      final items = state.items;
      if (items == null) return <String?>{};
      return items.map((e) => e.attributes?.locale).toSet();
    }, [state.items]);

    useEffect(() {
      if (selectedLocales.value == null &&
          state.items != null &&
          state.items!.isNotEmpty) {
        final originalLang = manga.attributes?.originalLanguage.code;
        if (discoveredLocales.contains(originalLang)) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            selectedLocales.value = {originalLang};
          });
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            selectedLocales.value = {};
          });
        }
      }
      return null;
    }, [state.items, discoveredLocales, manga]);

    final currentSelected = selectedLocales.value ?? {};

    final filteredState = useMemoized(() {
      if (currentSelected.isEmpty) return state;

      return state.filterItems(
        (item) => currentSelected.contains(item.attributes?.locale),
      );
    }, [state, currentSelected]);

    useEffect(() {
      if (filteredState.items != null &&
          filteredState.items!.length < 10 &&
          filteredState.hasNextPage &&
          !filteredState.isLoading) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          controller.fetchNextPage();
        });
      }
      return null;
    }, [filteredState]);

    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Row(
              children: [
                MenuAnchor(
                  menuChildren: discoveredLocales.map((loc) {
                    final isSelected = currentSelected.contains(loc);
                    final lang = Languages.get(loc ?? 'NULL');
                    final label = tr[lang.label]?.toString() ?? tr.ui.unknown;

                    return CheckboxMenuButton(
                      value: isSelected,
                      onChanged: (bool? checked) {
                        final newSet = Set<String?>.from(currentSelected);
                        if (checked == true) {
                          newSet.add(loc);
                        } else {
                          newSet.remove(loc);
                        }
                        selectedLocales.value = newSet;
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (loc != null && lang != Language.other) ...[
                            CountryFlag(flag: lang.flag),
                            const SizedBox(width: 8),
                          ],
                          Text(label),
                        ],
                      ),
                    );
                  }).toList(),
                  builder: (context, menu, child) {
                    return ActionChip(
                      avatar: const Icon(Icons.translate, size: 16),
                      onPressed: () {
                        if (menu.isOpen) {
                          menu.close();
                        } else {
                          menu.open();
                        }
                      },
                      label: Text(
                        currentSelected.isEmpty
                            ? tr.ui.allLocales
                            : tr.ui.selected(count: currentSelected.length),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        PagedSliverGrid(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 256,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 0.7,
          ),
          state: filteredState,
          fetchNextPage: controller.fetchNextPage,
          showNewPageErrorIndicatorAsGridChild: false,
          builderDelegate: ErrorReportingPagedChildBuilderDelegate<CoverArt>(
            error: filteredState.error,
            fetchNextPage: controller.fetchNextPage,
            animateTransitions: true,
            itemBuilder: (context, item, index) => CoverArtGridItem(
              key: ValueKey(item.id),
              url: manga
                  .getUrlFromCover(item)
                  .quality(quality: CoverArtQuality.medium),
              heroTag: item.id,
              footer: item.attributes?.volume != null
                  ? GridAlbumTextBar(
                      text: tr.mangaView.volume(n: item.attributes!.volume!),
                    )
                  : null,
              onTap: () => Navigator.push(
                context,
                TransparentOverlay(
                  builder: (context) => CoverArtPagedOverlay(
                    index: index,
                    items: [
                      for (final cover in filteredState.items!)
                        (url: manga.getUrlFromCover(cover), heroTag: cover.id),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ChapterListSliver extends HookWidget {
  const _ChapterListSliver({
    required this.state,
    required this.fetchNextPage,
    required this.manga,
  });

  final PagingState<int, Chapter> state;
  final NextPageCallback fetchNextPage;
  final Manga manga;

  @override
  Widget build(BuildContext context) {
    final tr = context.t;

    // final sort = ref.watch(mangaChaptersListSortProvider);
    // final sortfunc = sort == ListSort.ascending
    //     ? compareNatural
    //     : (a, b) {
    //         return compareNatural(b, a);
    //       };

    final chapters = state.items;

    final orderedChapters = useMemoized(() {
      if (chapters == null) {
        return null;
      }

      return chapters
          .groupListsBy((chapter) => chapter.attributes.volume)
          .values
          .expand((volumeChapters) => volumeChapters)
          .toList(growable: false);
    }, [state]);

    return PagedSliverList.separated(
      state: state,
      fetchNextPage: fetchNextPage,
      separatorBuilder: (_, index) => const SizedBox(height: 4.0),
      builderDelegate: ErrorReportingPagedChildBuilderDelegate<Chapter>(
        error: state.error,
        fetchNextPage: fetchNextPage,
        itemBuilder: (context, _, index) {
          final chapter = orderedChapters![index];
          final previousChapter = index > 0 ? orderedChapters[index - 1] : null;
          final nextChapter = index < orderedChapters.length - 1
              ? orderedChapters[index + 1]
              : null;
          final volume = chapter.attributes.volume;
          final chapterNumber = chapter.attributes.chapter;
          final startsVolume =
              previousChapter == null ||
              previousChapter.attributes.volume != volume;
          final previousIsDifferentChapter =
              startsVolume ||
              previousChapter.attributes.chapter != chapterNumber;
          final nextIsSameChapter =
              nextChapter != null &&
              nextChapter.attributes.volume == volume &&
              nextChapter.attributes.chapter == chapterNumber;
          final startsDuplicateChapterGroup =
              nextIsSameChapter && previousIsDifferentChapter;
          final isIndented = nextIsSameChapter || !previousIsDifferentChapter;

          final chapbtn = ChapterButtonWidget(chapter: chapter, manga: manga);

          final chapterWidget = isIndented
              ? Row(
                  children: [
                    const Icon(Icons.subdirectory_arrow_right, size: 15.0),
                    Flexible(child: chapbtn),
                  ],
                )
              : chapbtn;

          return Column(
            key: ValueKey(chapter.id),
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (startsVolume) ...[
                _ChapterListHeader(
                  text: volume == null
                      ? tr.mangaView.noVolume
                      : tr.mangaView.volume(n: volume),
                  bold: true,
                ),
                const SizedBox(height: 4.0),
              ],
              if (startsDuplicateChapterGroup) ...[
                _ChapterListHeader(
                  text: chapterNumber != null
                      ? tr.mangaView.chapter(n: chapterNumber)
                      : chapter.title,
                  bold: false,
                ),
                const SizedBox(height: 4.0),
              ],
              chapterWidget,
            ],
          );
        },
      ),
    );
  }
}

class _ChapterListHeader extends HookWidget {
  final String text;
  final bool bold;

  const _ChapterListHeader({required this.text, required this.bold});

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive();
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Text(
        text,
        style: TextStyle(fontWeight: bold ? FontWeight.bold : null),
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

    final isLoading =
        followProvider.isLoading ||
        statusProvider.isLoading ||
        setFollowing is MutationPending;

    if (following == null || (following == false && reading == null)) {
      return ElevatedButton(
        style: Styles.buttonStyle(),
        onPressed: isLoading
            ? null
            : () async {
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
      onPressed: isLoading
          ? null
          : () async {
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

    final isLoading =
        readProvider.isLoading || setReadingStatus is MutationPending;

    if (reading == null) {
      return const SizedBox.shrink();
    }

    return DropdownMenu<MangaReadingStatus>(
      initialSelection: reading,
      width: 175.0,
      enabled: !isLoading,
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
        return IconButton(
          style: Styles.squareIconButtonStyle(
            backgroundColor: hasRating
                ? theme.colorScheme.primaryContainer
                : theme.colorScheme.surface.withAlpha(200),
          ),
          onPressed: isLoading
              ? null
              : () {
                  if (controller.isOpen) {
                    controller.close();
                  } else {
                    controller.open();
                  }
                },
          icon: child!,
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
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
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
        return IconButton(
          style: Styles.squareIconButtonStyle(
            backgroundColor: theme.colorScheme.surface.withAlpha(200),
          ),
          onPressed: isLoading
              ? null
              : () {
                  if (controller.isOpen) {
                    controller.close();
                  } else {
                    controller.open();
                  }
                },
          icon: child!,
        );
      },
      menuChildren: [
        if (userLists != null)
          for (final list in userLists)
            CheckboxMenuButton(
              closeOnActivate: false,
              value: list.set.contains(manga.id),
              onChanged: (bool? value) async {
                userListModifyMutation(me?.id).run(ref, (tsx) async {
                  return await tsx
                      .get(customListCommandsProvider(me?.id))
                      .updateList(tsx, list, manga, value == true);
                });
              },
              child: Text(list.attributes.name),
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
              userListNewMutation(me?.id).run(ref, (tsx) async {
                return await tsx
                    .get(customListCommandsProvider(me?.id))
                    .newList(tsx, result.$1, result.$2, []);
              });
            }
          },
        ),
      ],
      child: const Icon(Icons.playlist_add),
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

class _MangaDexActionBar extends ConsumerWidget {
  const _MangaDexActionBar({required this.manga});

  final Manga manga;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final me = ref.watch(loggedUserProvider).value;

    return OverflowBar(
      spacing: 6.0,
      children: [
        if (me != null)
          _FollowingStatusButton(
            key: ValueKey('_FollowingStatusButton(${manga.id})'),
            manga: manga,
          ),
        if (me != null)
          _ReadingStatusDropdown(
            key: ValueKey('_ReadingStatusDropdown(${manga.id})'),
            manga: manga,
          ),
        if (me != null)
          _RatingMenu(key: ValueKey('_RatingMenu(${manga.id})'), manga: manga),
        if (me != null)
          _UserListsMenu(
            key: ValueKey('_UserListsMenu(${manga.id})'),
            manga: manga,
          ),
        _MangaDexMoreMenu(manga: manga),
        const SizedBox(width: 2),
      ],
    );
  }
}

class _MangaDexMoreMenu extends StatelessWidget {
  const _MangaDexMoreMenu({required this.manga});

  final Manga manga;

  @override
  Widget build(BuildContext context) {
    final tr = context.t;
    final theme = Theme.of(context);

    return MenuAnchor(
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
          onPressed: () => ExtensionSearchRoute(
            query: SearchQuery(
              title: manga.attributes!.title.get(tr.$meta.locale.languageCode),
            ),
          ).push(context),
          leadingIcon: const Icon(Icons.search),
          child: Text(tr.webSources.searchWithExt),
        ),
        MenuItemButton(
          onPressed: () =>
              Clipboard.setData(
                ClipboardData(
                  text: 'gagaku://open${GoRouterState.of(context).uri.path}',
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
  }
}

class _MangaRelatedView extends StatelessWidget {
  const _MangaRelatedView({required this.manga, required this.controller});

  final Manga manga;
  final PagingController<int, Manga> controller;

  @override
  Widget build(BuildContext context) {
    final tr = context.t;
    return MangaListWidget(
      physics: const AlwaysScrollableScrollPhysics(),
      title: Text(
        tr.mangaView.relatedTitles,
        style: CommonTextStyles.twentyfour,
      ),
      noController: true,
      children: [
        MangaListViewSliver(
          controller: controller,
          headers: {
            for (final related in manga.relatedMangas)
              related.id: tr[related.related!.label],
          },
        ),
      ],
    );
  }
}
