// ignore_for_file: unused_element
import 'dart:async';

import 'package:animations/animations.dart';
import 'package:cached_network_image_ce/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/model/config.dart';
import 'package:gagaku/model/search_history.dart';
import 'package:gagaku/mangadex/model/model.dart';
import 'package:gagaku/mangadex/reader.dart';
import 'package:gagaku/mangadex/settings.dart';
import 'package:gagaku/reader/main.dart';
import 'package:gagaku/routes.dart';
import 'package:gagaku/util/cached_network_image.dart';
import 'package:gagaku/util/infinite_scroll.dart';
import 'package:gagaku/util/intl.dart';
import 'package:gagaku/util/riverpod.dart';
import 'package:gagaku/util/ui.dart';
import 'package:gagaku/util/util.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:riverpod/misc.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'model/types.dart';

part 'widgets.g.dart';

typedef MangaSelectCallback = void Function(Manga manga);
typedef MangaButtonBuilderCallback = Widget Function(Manga manga);

enum MangaListView { grid, list, detailed }

@Riverpod(keepAlive: true)
class _MangaListView extends _$MangaListView {
  @override
  MangaListView build() => MangaListView.grid;

  @override
  set state(MangaListView newState) => super.state = newState;
  MangaListView update(MangaListView Function(MangaListView state) cb) =>
      state = cb(state);
}

const _groupIconB = Icon(Icons.group, size: 20.0);
const _groupIconS = Icon(Icons.group, size: 15.0);
const _circleIconB = Icon(Icons.add_circle, size: 20.0);
const _circleIconS = Icon(Icons.add_circle, size: 15.0);
const _personIconB = Icon(Icons.person, size: 20.0);
const _personIconS = Icon(Icons.person, size: 15.0);
const _checkIconB = Icon(Icons.check, color: Colors.amber, size: 20.0);
const _checkIconS = Icon(Icons.check, color: Colors.amber, size: 15.0);
const _openIconB = Icon(Icons.open_in_new, size: 20.0);
const _openIconS = Icon(Icons.open_in_new, size: 15.0);
const _scheduleIconB = Icon(Icons.schedule, size: 20.0);
const _scheduleIconS = Icon(Icons.schedule, size: 15.0);

class _MangaDexSearchAnchor extends ConsumerStatefulWidget {
  const _MangaDexSearchAnchor();

  @override
  ConsumerState<_MangaDexSearchAnchor> createState() =>
      _MangaDexSearchAnchorState();
}

class _MangaDexSearchAnchorState extends ConsumerState<_MangaDexSearchAnchor> {
  Timer? _debounceTimer;
  String? _lastSearchQuery;
  Completer<Iterable<Widget>>? _completer;

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tr = context.t;
    final theme = Theme.of(context);

    return SearchAnchor(
      isFullScreen: false,
      viewHintText: tr.search.arg(arg: 'MangaDex'),
      viewConstraints: const BoxConstraints(
        minWidth: 360,
        maxWidth: 800,
        maxHeight: 600,
      ),
      builder: (BuildContext ctx, SearchController ctl) => IconButton(
        color: theme.colorScheme.onPrimaryContainer,
        icon: const Icon(Icons.search),
        tooltip: tr.search.arg(arg: 'MangaDex'),
        onPressed: ctl.openView,
      ),
      viewOnSubmitted: (value) {
        final term = value.trim();
        if (term.isEmpty) return;
        final history = ref.read(searchHistoryProvider);
        ref.read(searchHistoryProvider.notifier).state = {
          term,
          ...history,
        }.take(10).toList();
        MangaDexSearchRoute(
          $extra: MangaSearchParameters(
            query: term,
            filter: const MangaFilters(),
          ),
        ).push(context);
      },
      suggestionsBuilder: (BuildContext ctx, SearchController ctl) async {
        final term = ctl.text.trim();

        if (term.isEmpty) {
          _debounceTimer?.cancel();
          _lastSearchQuery = null;
          if (_completer != null && !_completer!.isCompleted) {
            _completer!.complete(const []);
          }
          _completer = null;
          final history = ref.read(searchHistoryProvider);
          return [
            ...history.map(
              (hterm) => ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                leading: const Icon(Icons.history),
                title: Text(hterm),
                onTap: () {
                  final h = ref.read(searchHistoryProvider);
                  ref.read(searchHistoryProvider.notifier).state = {
                    hterm,
                    ...h,
                  }.take(10).toList();
                  ctl.closeView(hterm);
                  MangaDexSearchRoute(
                    $extra: MangaSearchParameters(
                      query: hterm,
                      filter: const MangaFilters(),
                    ),
                  ).push(context);
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.search),
              title: Text(tr.search.advancedSearch),
              onTap: () {
                ctl.closeView('');
                MangaDexSearchRoute().push(context);
              },
            ),
          ];
        }

        if (term == _lastSearchQuery && _completer != null) {
          return _completer!.future;
        }

        _lastSearchQuery = term;
        _debounceTimer?.cancel();
        if (_completer != null && !_completer!.isCompleted) {
          _completer!.complete(const []);
        }
        final completer = Completer<Iterable<Widget>>();
        _completer = completer;

        _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
          if (!mounted) {
            if (!completer.isCompleted) completer.complete(const []);
            return;
          }
          try {
            final api = ref.read(mangadexProvider);
            final results = await api.searchManga(
              term,
              limit: 5,
              filter: const MangaFilters(),
            );

            // Abort if superseded or unmounted before stats fetch to prevent extra API calls
            if (term != _lastSearchQuery || !mounted) {
              if (!completer.isCompleted) completer.complete(const []);
              return;
            }

            final mangaList = results.data.cast<Manga>();
            if (mangaList.isNotEmpty && mounted) {
              try {
                await ref.run((tsx) async {
                  return await tsx
                      .get(statisticsProvider.notifier)
                      .get(mangaList);
                });
              } catch (e) {
                logger.e(e, error: e);
              }
            }

            // Re-verify after stats fetch
            if (term != _lastSearchQuery || !mounted) {
              if (!completer.isCompleted) completer.complete(const []);
              return;
            }

            final widgets = <Widget>[
              ...mangaList.map(
                (m) => _ListMangaItem(manga: m, showGenres: false),
              ),
              ListTile(
                leading: const Icon(Icons.search),
                title: Text(tr.search.advanced_for(arg: term)),
                onTap: () {
                  final h = ref.read(searchHistoryProvider);
                  ref.read(searchHistoryProvider.notifier).state = {
                    term,
                    ...h,
                  }.take(10).toList();
                  ctl.closeView(term);
                  MangaDexSearchRoute(
                    $extra: MangaSearchParameters(
                      query: term,
                      filter: const MangaFilters(),
                    ),
                  ).push(context);
                },
              ),
            ];
            if (!completer.isCompleted) completer.complete(widgets);
          } catch (e, stackTrace) {
            logger.e(
              'Error during quick search',
              error: e,
              stackTrace: stackTrace,
            );
            if (!completer.isCompleted) {
              completer.complete([
                ListTile(
                  leading: const Icon(Icons.search),
                  title: Text(tr.search.advanced_for(arg: term)),
                  onTap: () {
                    final h = ref.read(searchHistoryProvider);
                    ref.read(searchHistoryProvider.notifier).state = {
                      term,
                      ...h,
                    }.take(10).toList();
                    ctl.closeView(term);
                    MangaDexSearchRoute(
                      $extra: MangaSearchParameters(
                        query: term,
                        filter: const MangaFilters(),
                      ),
                    ).push(context);
                  },
                ),
              ]);
            }
          }
        });

        return completer.future;
      },
    );
  }
}

class MangaDexSliverAppBar extends StatelessWidget {
  const MangaDexSliverAppBar({super.key, this.controller, this.title});

  final ScrollController? controller;
  final String? title;

  @override
  Widget build(BuildContext context) {
    final tr = context.t;
    final theme = Theme.of(context);

    final actions = <Widget>[
      OverflowBar(
        spacing: 8.0,
        children: [
          const _MangaDexSearchAnchor(),
          Tooltip(
            message: tr.arg_settings(arg: 'MangaDex'),
            child: OpenContainer<bool>(
              closedColor: theme.colorScheme.primaryContainer,
              closedShape: const CircleBorder(),
              closedElevation: 0.0,
              closedBuilder: (context, openContainer) {
                return IconButton(
                  color: theme.colorScheme.onPrimaryContainer,
                  icon: const Icon(Icons.settings),
                  onPressed: () {
                    openContainer();
                  },
                );
              },
              openBuilder: (context, closedContainer) {
                return const MangaDexSettingsWidget();
              },
            ),
          ),
          HookConsumer(
            builder: (context, ref, child) {
              final auth = ref.watch(loggedUserProvider);
              final imageCache = ref.watch(extensionImageCacheProvider);
              final me = auth.value;
              final avatarUrl = me?.getUserAvatar(
                quality: CoverArtQuality.small,
              );
              final avatarImageProvider = useMemoized(
                () => avatarUrl != null
                    ? CachedNetworkImageProvider(
                        avatarUrl,
                        cacheManager: imageCache,
                      )
                    : null,
                [avatarUrl, imageCache],
              );

              return switch (auth) {
                AsyncValue(hasValue: true, value: final me) =>
                  // XXX: This changes when OAuth is released
                  me == null
                      ? IconButton(
                          color: theme.colorScheme.onPrimaryContainer,
                          tooltip: tr.auth.login,
                          icon: const Icon(Icons.login),
                          onPressed: () => MangaDexLoginRoute().push(context),
                        )
                      : MenuAnchor(
                          builder: (context, controller, child) => IconButton(
                            onPressed: () {
                              if (controller.isOpen) {
                                controller.close();
                              } else {
                                controller.open();
                              }
                            },
                            icon: CircleAvatar(
                              radius: 14,
                              foregroundImage: avatarImageProvider,
                              child: const Icon(Icons.person, size: 16),
                            ),
                          ),
                          menuChildren: [
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  spacing: 10.0,
                                  children: [
                                    CircleAvatar(
                                      foregroundImage: avatarImageProvider,
                                      child: const Icon(Icons.person),
                                    ),
                                    Text(
                                      tr.auth.loggedInAs(
                                        user: me.attributes?.username ?? 'null',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            MenuItemButton(
                              onPressed: () => ref
                                  .read(authControlProvider.notifier)
                                  .logout(),
                              leadingIcon: const Icon(Icons.logout),
                              child: Text(tr.auth.logout),
                            ),
                          ],
                        ),
                // ignore: unused_local_variable
                AsyncValue(:final error?, :final stackTrace?) => const Icon(
                  Icons.error,
                ),
                _ => const Center(child: CircularProgressIndicator()),
              };
            },
          ),
        ],
      ),
    ];

    return SliverAppBar.medium(
      pinned: true,
      title: GestureDetector(
        onTap: () {
          controller?.animateTo(
            0.0,
            duration: const Duration(milliseconds: 1000),
            curve: Curves.easeOutCirc,
          );
        },
        child: Text(title ?? 'MangaDex'),
      ),
      actions: actions,
    );
  }
}

class MangaProviderCarousel extends StatelessWidget {
  const MangaProviderCarousel({super.key, required this.provider});

  final Refreshable<AsyncValue<List<Manga>>> provider;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DataProviderWhenWidget(
        provider: provider,
        builder: (context, items) => ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 256),
          child: CarouselView(
            itemExtent: 180,
            shrinkExtent: 180,
            enableSplash: false,
            children: [
              for (final item in items)
                GridMangaItem(key: ValueKey(item.id), manga: item),
            ],
          ),
        ),
        errorBuilder: (context, defaultChild, error, stacktrace) {
          return Column(
            children: [Text('$error'), Text(stacktrace.toString())],
          );
        },
      ),
    );
  }
}

({String? id, bool? read}) _watchReadStatus(
  WidgetRef ref,
  Manga manga,
  String chapterId,
) {
  final me = ref.watch(loggedUserProvider.select((user) => user.value?.id));
  final readStatus = ref.watch(
    mangaReadChaptersProvider(manga).select((data) {
      if (!data.hasValue && data.isLoading) return null;
      return data.value?.contains(chapterId) ?? false;
    }),
  );
  return (id: me, read: readStatus);
}

class MarkReadButton extends ConsumerWidget {
  const MarkReadButton({super.key, required this.manga, required this.chapter});

  final Manga manga;
  final Chapter chapter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tr = context.t;
    final theme = Theme.of(context);
    final status = _watchReadStatus(ref, manga, chapter.id);

    if (status.id == null) {
      return const SizedBox.shrink();
    }

    if (status.read == null) {
      return SizedBox(
        width: 20,
        height: 20,
        child: Icon(
          Icons.visibility,
          color: theme.disabledColor.withValues(alpha: 0.1),
          size: 20,
        ),
      );
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          final setRead = !status.read!;
          ref.run((tsx) async {
            return await tsx
                .get(readChaptersProvider(status.id!).notifier)
                .set(
                  manga,
                  read: setRead ? [chapter] : null,
                  unread: !setRead ? [chapter] : null,
                );
          });
        },
        child: Tooltip(
          message: tr.mangaView.markAs(
            arg: status.read == true ? tr.mangaView.unread : tr.mangaView.read,
          ),
          child: SizedBox(
            width: 24,
            height: 24,
            child: Icon(
              status.read == true ? Icons.visibility_off : Icons.visibility,
              color: status.read == true
                  ? theme.disabledColor
                  : theme.primaryIconTheme.color,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}

class ChapterFeedWidget extends HookWidget {
  const ChapterFeedWidget({
    super.key,
    required this.controller,
    required this.mangaCache,
    required this.onRefresh,
    this.title,
    this.scrollController,
    this.restorationId,
    this.leading = const [],
  });

  final RefreshCallback onRefresh;
  final String? title;
  final ScrollController? scrollController;
  final String? restorationId;
  final List<Widget> leading;
  final Map<String, Manga> mangaCache;

  final PagingController<int, Chapter> controller;

  @override
  Widget build(BuildContext context) {
    final scroller = scrollController ?? useScrollController();

    return Center(
      child: RefreshIndicator(
        onRefresh: onRefresh,
        child: CustomScrollView(
          scrollBehavior: const MouseTouchScrollBehavior(),
          physics: const AlwaysScrollableScrollPhysics(),
          controller: scroller,
          restorationId: restorationId,
          cacheExtent: MediaQuery.sizeOf(context).height * 1.5,
          slivers: [
            ...leading,
            if (title != null)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 10.0,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(title!, style: CommonTextStyles.twentyfour),
                  ),
                ),
              ),
            PagingListener(
              controller: controller,
              builder: (context, state, fetchNextPage) => HookBuilder(
                builder: (context) {
                  final chapters = state.items;

                  // Because this is now 100% synchronous, using [state] is perfectly safe.
                  // It will instantly return the new state without ever unmounting the list.
                  final newState = useMemoized(() {
                    final items = chapters != null
                        ? ChapterFeedItemData.toData(chapters, mangaCache)
                        : <ChapterFeedItemData>[];

                    return PagingState<int, ChapterFeedItemData>(
                      error: state.error,
                      pages: state.keys == null
                          ? null
                          : List.generate(
                              state.keys!.length,
                              (i) => i == 0 ? items : [],
                            ),
                      keys: state.keys,
                      hasNextPage: state.hasNextPage,
                      isLoading: state.isLoading,
                    );
                  }, [state]);

                  return PagedSuperSliverList(
                    state: newState,
                    fetchNextPage: fetchNextPage,
                    findChildIndexCallback: (key) {
                      final valueKey = key as ValueKey<int>;
                      final val = newState.items!.indexWhere(
                        (i) => i.id == valueKey.value,
                      );
                      return val >= 0 ? val : null;
                    },
                    builderDelegate:
                        PagedChildBuilderDelegate<ChapterFeedItemData>(
                          animateTransitions: true,
                          itemBuilder: (context, item, index) =>
                              ChapterFeedItem(
                                key: ValueKey(item.id),
                                state: item,
                              ),
                        ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfiniteScrollChapterFeedWidget extends ConsumerStatefulWidget {
  const InfiniteScrollChapterFeedWidget({
    super.key,
    this.title,
    this.scrollController,
    this.restorationId,
    this.leading = const [],
    required this.feedKey,
    required this.limit,
    required this.path,
    this.entity,
    this.orderKey = 'publishAt',
    this.order = 'desc',
  });

  // List params
  final String? title;
  final ScrollController? scrollController;
  final String? restorationId;
  final List<Widget> leading;

  // Feed params
  final String feedKey;
  final int limit;
  final String path;
  final MangaDexEntity? entity;
  final String orderKey;
  final String order;

  @override
  ConsumerState<InfiniteScrollChapterFeedWidget> createState() =>
      _InfiniteScrollFeedState();
}

class _InfiniteScrollFeedState
    extends ConsumerState<InfiniteScrollChapterFeedWidget> {
  final Map<String, Manga> _mangaCache = {};

  late final _pagingManager = OffsetPagingManager<Chapter>(limit: widget.limit);

  late final _pagingController = PagingController<int, Chapter>(
    getNextPageKey: _pagingManager.getNextPageKey,
    fetchPage: (pageKey) async {
      final me = await ref.readAsync(loggedUserProvider.future);
      final api = ref.read(mangadexProvider);

      final chapterlist = await api.fetchFeed(
        path: widget.path,
        feedKey: widget.feedKey,
        limit: widget.limit,
        offset: pageKey,
        entity: widget.entity,
        orderKey: widget.orderKey,
        order: widget.order,
      );

      _pagingManager.totalItems = chapterlist.total;

      final chapters = chapterlist.data.cast<Chapter>();

      final mangaIds = chapters.map((e) => e.manga.id).toSet();
      final mangas = await api.fetchMangaById(
        ids: mangaIds,
        limit: MangaDexEndpoints.breakLimit,
      );

      for (final m in mangas) {
        _mangaCache[m.id] = m;
      }

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
          ref.run((tsx) async {
            return await tsx.get(chapterStatsProvider.notifier).get(chapters);
          }),
        ).wait;
      } catch (e) {
        logger.e(e, error: e);
      }

      return chapters;
    },
  );

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _pagingController.addListener(_showError);
  }

  Future<void> _showError() async {
    if (_pagingController.value.status == PagingStatus.subsequentPageError ||
        _pagingController.value.status == PagingStatus.firstPageError) {
      final tr = context.t;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(tr.errors.fetchFail),
          duration: const Duration(seconds: 5),
          action: SnackBarAction(
            label: tr.ui.retry,
            onPressed: () => _pagingController.fetchNextPage(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChapterFeedWidget(
      controller: _pagingController,
      mangaCache: _mangaCache,
      onRefresh: () async {
        _pagingManager.reset();
        _mangaCache.clear();
        final api = ref.watch(mangadexProvider);
        await api.invalidateAll(
          widget.entity == null
              ? widget.feedKey
              : '${widget.feedKey}(${widget.entity!.id}',
        );
        _pagingController.refresh();
      },
      title: widget.title,
      scrollController: widget.scrollController,
      restorationId: widget.restorationId,
      leading: widget.leading,
    );
  }
}

class _CoverButton extends ConsumerWidget {
  const _CoverButton({required this.manga});

  final Manga manga;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSizeSmall = DeviceContext.screenWidthSmall(context);
    final imageCache = ref.watch(extensionImageCacheProvider);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => MangaDexMangaViewRoute(
          mangaId: manga.id,
          manga: manga,
        ).push(context),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 1.0,
            bottom: 1.0,
            left: 0.0,
            right: 6.0,
          ),
          child: CachedNetworkImage(
            cacheManager: imageCache,
            imageUrl: manga.getFirstCoverUrl(quality: CoverArtQuality.small),
            imageBuilder: (context, imageProvider) => DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(image: imageProvider),
                borderRadius: const BorderRadius.all(Radius.circular(4.0)),
              ),
            ),
            width: screenSizeSmall ? 64.0 : 128.0,
            height: screenSizeSmall ? 91.0 : 182.0,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                const Center(child: CircularProgressIndicator()),
            errorBuilder: (context, error, stacktrace) {
              return Tooltip(
                message: error.toString(),
                child: const Icon(Icons.error),
              );
            },
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class MangaTitleButton extends StatelessWidget {
  final Manga manga;

  const MangaTitleButton({super.key, required this.manga});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => MangaDexMangaViewRoute(
          mangaId: manga.id,
          manga: manga,
        ).push(context),
        child: Text.rich(
          TextSpan(
            style: CommonTextStyles.sixteenBold.copyWith(
              color: theme.colorScheme.onSurface,
            ),
            children: [
              CountryFlagSpan(flag: manga.attributes!.originalLanguage.flag),
              const WidgetSpan(child: SizedBox(width: 8.0)),
              TextSpan(text: manga.attributes!.title.get('en')),
            ],
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ),
    );
  }
}

class _BackLinkedChapterButton extends StatelessWidget {
  const _BackLinkedChapterButton({
    super.key,
    required this.chapter,
    required this.manga,
  });

  final Chapter chapter;
  final Manga manga;

  @override
  Widget build(BuildContext context) {
    return ChapterButtonWidget(
      chapter: chapter,
      manga: manga,
      onLinkPressed: (context) =>
          MangaDexMangaViewRoute(mangaId: manga.id, manga: manga).push(context),
    );
  }
}

class ChapterFeedItem extends HookWidget {
  const ChapterFeedItem({super.key, required this.state});

  final ChapterFeedItemData state;

  @override
  Widget build(BuildContext context) {
    final screenSizeSmall = DeviceContext.screenWidthSmall(context);
    final visibleCount = useState(3);

    final titleBtn = MangaTitleButton(manga: state.manga);
    final coverBtn = _CoverButton(manga: state.manga);

    final chaptersCount = state.chapters.length;
    final visibleChapters = state.chapters.take(visibleCount.value);
    final remaining = chaptersCount - visibleCount.value;

    final chapterButtons = <Widget>[
      for (final chapter in visibleChapters)
        _BackLinkedChapterButton(
          key: ValueKey(chapter.id),
          chapter: chapter,
          manga: state.manga,
        ),
      if (remaining > 0)
        Center(
          child: TextButton.icon(
            onPressed: () => visibleCount.value += 10,
            icon: const Icon(Icons.expand_more),
            label: Text('$remaining'),
          ),
        ),
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: screenSizeSmall
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  titleBtn,
                  const Divider(height: 4.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      coverBtn,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 4.0,
                          children: chapterButtons,
                        ),
                      ),
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
                      spacing: 4.0,
                      children: [
                        titleBtn,
                        const Divider(height: 10.0),
                        ...chapterButtons,
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class _ChapterButtonCard extends HookConsumerWidget {
  final Chapter chapter;
  final Manga manga;
  final Widget child;

  const _ChapterButtonCard({
    required this.chapter,
    required this.manga,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool screenSizeSmall = DeviceContext.screenWidthSmall(context);
    final theme = Theme.of(context);
    final tileColor = theme.colorScheme.primaryContainer;
    final hoverColor = theme.hoverColor;

    final isHovered = useState(false);

    final status = _watchReadStatus(ref, manga, chapter.id);

    Border border;
    if (status.id == null) {
      border = Border(left: BorderSide(color: tileColor, width: 4.0));
    } else {
      border = Border(
        left: BorderSide(
          color: status.read == true ? tileColor : Colors.blue,
          width: 4.0,
        ),
      );
    }

    final decoration = BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(4)),
      color: isHovered.value
          ? Color.alphaBlend(hoverColor, tileColor)
          : tileColor,
      border: border,
    );

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => isHovered.value = true,
      onExit: (_) => isHovered.value = false,
      child: DecoratedBox(
        decoration: decoration,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: (screenSizeSmall ? 6.0 : 10.0),
            vertical: 4.0,
          ),
          child: child,
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
    this.onLinkPressed,
  });

  final Chapter chapter;
  final Manga manga;
  final CtxCallback? onLinkPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tr = context.t;

    final bool screenSizeSmall = DeviceContext.screenWidthSmall(context);

    final comments = ref.watch(
      chapterStatsProvider.select(
        (data) => switch (data) {
          AsyncData(value: final map) => map[chapter.id]?.comments,
          _ => null,
        },
      ),
    );

    final isEndChapter =
        manga.attributes!.lastChapter != null &&
        manga.attributes!.lastChapter?.isNotEmpty == true &&
        chapter.attributes.chapter == manga.attributes!.lastChapter;
    final isOfficialPub = chapter.attributes.externalUrl != null;

    final user = chapter.uploadUser;
    final userChip = IconTextChip(
      icon: isOfficialPub ? _checkIconB : null,
      text: !isOfficialPub
          ? (user?.attributes?.username.crop() ?? '')
          : tr.mangadex.officialPub,
    );

    final statsChip = CommentChip(comments: comments);
    final pubtime = _PubTime(time: chapter.attributes.publishAt);
    final markReadButton = MarkReadButton(manga: manga, chapter: chapter);

    final title = Row(
      spacing: 6.0,
      children: [
        // This gap is to deliberate leave space between
        // the markReadButton and the flag
        const SizedBox.shrink(),
        Expanded(
          child: ChapterTitle(chapter: chapter, manga: manga),
        ),
        if (isEndChapter) IconTextChip(color: Colors.blue, text: 'END'),
        if (screenSizeSmall) statsChip,
      ],
    );

    final groups = _GroupRow(chapter: chapter);

    final tile = screenSizeSmall
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  SizedBox(width: 24, child: markReadButton),
                  Expanded(child: title),
                ],
              ),
              Row(
                children: [
                  const SizedBox(width: 24, child: _groupIconB),
                  Expanded(child: groups),
                ],
              ),
              Row(
                children: [
                  const SizedBox(width: 24, child: _personIconB),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: userChip,
                          ),
                        ),
                        const SizedBox(width: 4.0),
                        _scheduleIconB,
                        const SizedBox(width: 4.0),
                        pubtime,
                      ],
                    ),
                  ),
                ],
              ),
            ],
          )
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  SizedBox(width: 24, child: markReadButton),
                  Expanded(child: title),
                  const SizedBox(width: 24, child: _scheduleIconB),
                  SizedBox(
                    width: 145,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: pubtime,
                    ),
                  ),
                  const SizedBox(width: 60),
                ],
              ),
              Row(
                children: [
                  const SizedBox(width: 24, child: _groupIconB),
                  Expanded(child: groups),
                  const SizedBox(width: 24, child: _personIconB),
                  SizedBox(
                    width: 145,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: userChip,
                    ),
                  ),
                  SizedBox(
                    width: 60,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: statsChip,
                    ),
                  ),
                ],
              ),
            ],
          );

    return GestureDetector(
      onTap: () {
        MangaDexReaderRoute(
          chapterId: chapter.id,
          $extra: ReaderData(
            title: chapter.title,
            chapter: chapter,
            manga: manga,
            link: manga.attributes!.title.get('en'),
            onLinkPressed: onLinkPressed,
          ),
        ).push(context);
      },
      child: _ChapterButtonCard(manga: manga, chapter: chapter, child: tile),
    );
  }
}

AsyncSnapshot<List<Manga>> useMangaListFetcher(
  WidgetRef ref,
  Iterable<String> list,
  int page, [
  List<Object?> keys = const <Object>[],
]) {
  return useFuture(
    useMemoized(() => getMangaListByPage(ref, list, page), [
      list,
      page,
      ...keys,
    ]),
  );
}

class MangaListWidget extends HookConsumerWidget {
  const MangaListWidget({
    super.key,
    this.title,
    required this.children,
    this.leading = const <Widget>[],
    this.physics,
    this.controller,
    this.scrollBehavior = const MouseTouchScrollBehavior(),
    this.future,
    this.noController = false,
    this.showToggle = true,
  });

  final Widget? title;
  final List<Widget> children;
  final List<Widget> leading;
  final ScrollPhysics? physics;
  final ScrollController? controller;
  final ScrollBehavior? scrollBehavior;
  final AsyncSnapshot? future;
  final bool noController;
  final bool showToggle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tr = context.t;
    final scrollController =
        controller ?? (noController ? null : useScrollController());
    final view = showToggle
        ? ref.watch(_mangaListViewProvider)
        : MangaListView.grid;

    final isLoading = future != null
        ? (future!.connectionState == ConnectionState.waiting ||
              !future!.hasData)
        : false;

    return Stack(
      children: [
        CustomScrollView(
          controller: scrollController,
          scrollBehavior: scrollBehavior,
          physics: physics,
          cacheExtent: MediaQuery.sizeOf(context).height,
          slivers: [
            ...leading,
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 10.0,
                ),
                child: Row(
                  children: [
                    ?title,
                    const Spacer(),
                    const GridExtentSlider(),
                    if (showToggle)
                      SegmentedButton<MangaListView>(
                        showSelectedIcon: false,
                        style: SegmentedButton.styleFrom(
                          shape: const RoundedRectangleBorder(),
                        ),
                        segments: <ButtonSegment<MangaListView>>[
                          ButtonSegment<MangaListView>(
                            value: MangaListView.grid,
                            icon: Icon(Icons.grid_view, size: 24),
                            tooltip: tr.ui.gridView,
                          ),
                          ButtonSegment<MangaListView>(
                            value: MangaListView.list,
                            icon: Icon(Icons.table_rows, size: 24),
                            tooltip: tr.ui.listView,
                          ),
                          ButtonSegment<MangaListView>(
                            value: MangaListView.detailed,
                            icon: Icon(Icons.view_list, size: 24),
                            tooltip: tr.ui.detailedView,
                          ),
                        ],
                        selected: <MangaListView>{view},
                        onSelectionChanged: (Set<MangaListView> newSelection) {
                          ref.read(_mangaListViewProvider.notifier).state =
                              newSelection.first;
                        },
                      ),
                  ],
                ),
              ),
            ),
            if (future != null && future!.hasError)
              SliverList.list(
                children: [
                  Text('${future!.error}'),
                  Text(future!.stackTrace.toString()),
                ],
              ),
            ...children,
          ],
        ),
        if (isLoading) ...Styles.loadingOverlay,
      ],
    );
  }
}

class MangaListViewSliver extends ConsumerWidget {
  const MangaListViewSliver({
    super.key,
    this.items,
    this.controller,
    this.selectMode = false,
    this.selectButton,
    this.onSelected,
    this.headers,
  }) : assert(items != null || controller != null);

  final List<Manga>? items;
  final bool selectMode;
  final MangaButtonBuilderCallback? selectButton;
  final MangaSelectCallback? onSelected;
  final Map<String, String>? headers;

  final PagingController<int, Manga>? controller;

  int? _findChildIndexCb(Key? key) {
    final valueKey = key as ValueKey<String>;
    final val = items!.indexWhere((i) => i.id == valueKey.value);
    return val >= 0 ? val : null;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gridExtent = ref.watch(
      gagakuSettingsProvider.select((c) => c.gridAlbumExtent),
    );
    final view = selectMode
        ? MangaListView.grid
        : ref.watch(_mangaListViewProvider);

    if (items != null) {
      switch (view) {
        case MangaListView.list:
          return SliverList.builder(
            findChildIndexCallback: _findChildIndexCb,
            itemBuilder: (BuildContext context, int index) {
              final manga = items![index];
              return _ListMangaItem(
                key: ValueKey(manga.id),
                manga: manga,
                header: headers?[manga.id],
              );
            },
            itemCount: items!.length,
          );

        case MangaListView.detailed:
          final delegate = SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: gridExtent.detailed,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: DeviceContext.screenWidthSmall(context)
                ? 1.0
                : 2.0,
          );

          return SliverGrid.builder(
            gridDelegate: delegate,
            findChildIndexCallback: _findChildIndexCb,
            itemBuilder: (context, index) {
              final manga = items![index];
              return GridMangaDetailedItem(
                key: ValueKey(manga.id),
                manga: manga,
                header: headers?[manga.id],
              );
            },
            itemCount: items!.length,
          );

        case MangaListView.grid:
          final delegate = SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: gridExtent.grid,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 0.7,
          );

          return SliverGrid.builder(
            gridDelegate: delegate,
            findChildIndexCallback: _findChildIndexCb,
            itemBuilder: (context, index) {
              final manga = items![index];
              return GridMangaItem(
                key: ValueKey(manga.id),
                manga: manga,
                selectMode: selectMode,
                selectButton: selectButton,
                onSelected: onSelected,
                header: headers?[manga.id],
              );
            },
            itemCount: items!.length,
          );
      }
    }

    return PagingListener(
      controller: controller!,
      builder: (context, state, fetchNextPage) {
        switch (view) {
          case MangaListView.list:
            return PagedSliverList(
              state: state,
              fetchNextPage: fetchNextPage,
              builderDelegate: PagedChildBuilderDelegate<Manga>(
                animateTransitions: true,
                itemBuilder: (context, item, index) => _ListMangaItem(
                  key: ValueKey(item.id),
                  manga: item,
                  header: headers?[item.id],
                ),
              ),
            );
          case MangaListView.detailed:
            final delegate = SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: gridExtent.detailed,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: DeviceContext.screenWidthSmall(context)
                  ? 1.0
                  : 2.0,
            );

            return PagedSliverGrid(
              gridDelegate: delegate,
              state: state,
              fetchNextPage: fetchNextPage,
              builderDelegate: PagedChildBuilderDelegate<Manga>(
                animateTransitions: true,
                itemBuilder: (context, item, index) => GridMangaDetailedItem(
                  key: ValueKey(item.id),
                  manga: item,
                  header: headers?[item.id],
                ),
              ),
            );
          case MangaListView.grid:
            final delegate = SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: gridExtent.grid,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 0.7,
            );

            return PagedSliverGrid(
              gridDelegate: delegate,
              state: state,
              fetchNextPage: fetchNextPage,
              builderDelegate: PagedChildBuilderDelegate<Manga>(
                animateTransitions: true,
                itemBuilder: (context, item, index) => GridMangaItem(
                  key: ValueKey(item.id),
                  manga: item,
                  selectMode: selectMode,
                  selectButton: selectButton,
                  onSelected: onSelected,
                  header: headers?[item.id],
                ),
              ),
            );
        }
      },
    );
  }
}

class GridMangaItem extends HookConsumerWidget {
  const GridMangaItem({
    super.key,
    required this.manga,
    this.selectMode = false,
    this.selectButton,
    this.onSelected,
    this.header,
  });

  final Manga manga;
  final bool selectMode;
  final MangaButtonBuilderCallback? selectButton;
  final MangaSelectCallback? onSelected;
  final String? header;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final aniController = useAnimationController(
      duration: const Duration(milliseconds: 100),
    );
    final imageCache = ref.watch(extensionImageCacheProvider);

    final networkImage = CachedNetworkImage(
      cacheManager: imageCache,
      imageUrl: manga.getFirstCoverUrl(quality: CoverArtQuality.medium),
      width: 256.0,
      fit: BoxFit.cover,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          const Center(child: CircularProgressIndicator()),
      errorBuilder: (context, error, stacktrace) {
        return Tooltip(
          message: error.toString(),
          child: const Icon(Icons.error),
        );
      },
    );

    final image = GridAlbumImage(
      animation: aniController.drive(Styles.coverArtGradientTween),
      child: networkImage,
    );

    return InkWell(
      onTap: () =>
          MangaDexMangaViewRoute(mangaId: manga.id, manga: manga).push(context),
      onHover: (hovering) {
        if (hovering) {
          aniController.forward();
        } else {
          aniController.reverse();
        }
      },
      child: GridTile(
        header: selectMode
            ? Align(
                alignment: Alignment.topRight,
                child: FloatingActionButton(
                  heroTag: manga.id,
                  mini: true,
                  shape: const CircleBorder(),
                  onPressed: () => onSelected!(manga),
                  child: selectButton!(manga),
                ),
              )
            : (header != null
                  ? GridAlbumTextBar(
                      backgroundColor: Colors.black87,
                      text: header!,
                    )
                  : null),
        footer: GridAlbumTextBar(
          leading: CountryFlag(flag: manga.attributes!.originalLanguage.flag),
          text: manga.attributes!.title.get('en'),
        ),
        child: image,
      ),
    );
  }
}

class GridMangaDetailedItem extends ConsumerWidget {
  const GridMangaDetailedItem({super.key, required this.manga, this.header});

  final Manga manga;
  final String? header;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool screenSizeSmall = DeviceContext.screenWidthSmall(context);
    final imageCache = ref.watch(extensionImageCacheProvider);

    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8.0,
          children: [
            MangaTitleButton(manga: manga),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.only(right: 8.0),
                    ),
                    onPressed: () => MangaDexMangaViewRoute(
                      mangaId: manga.id,
                      manga: manga,
                    ).push(context),
                    child: CachedNetworkImage(
                      cacheManager: imageCache,
                      imageUrl: manga.getFirstCoverUrl(
                        quality: CoverArtQuality.small,
                      ),
                      width: screenSizeSmall ? 80.0 : 128.0,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              const Center(child: CircularProgressIndicator()),
                      errorBuilder: (context, error, stacktrace) {
                        return Tooltip(
                          message: error.toString(),
                          child: const Icon(Icons.error),
                        );
                      },
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 4.0,
                      children: [
                        if (header != null) IconTextChip(text: header!),
                        MangaStatisticsRow(
                          key: ValueKey('MangaStatisticsRow(${manga.id})'),
                          manga: manga,
                        ),
                        MangaGenreRow(
                          key: ValueKey('MangaGenreRow(${manga.id})'),
                          manga: manga,
                        ),
                        if (manga.attributes!.description.isNotEmpty)
                          Expanded(
                            child: Text(
                              manga.attributes!.description.get('en'),
                              overflow: TextOverflow.clip,
                            ),
                          ),
                      ],
                    ),
                  ),
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
  const _ListMangaItem({
    super.key,
    required this.manga,
    this.header,
    this.showGenres = true,
  });

  final Manga manga;
  final String? header;
  final bool showGenres;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageCache = ref.watch(extensionImageCacheProvider);

    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 6.0, bottom: 6.0, right: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
              ),
              onPressed: () => MangaDexMangaViewRoute(
                mangaId: manga.id,
                manga: manga,
              ).push(context),
              child: CachedNetworkImage(
                cacheManager: imageCache,
                imageUrl: manga.getFirstCoverUrl(
                  quality: CoverArtQuality.small,
                ),
                width: 60.0,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    const Center(child: CircularProgressIndicator()),
                errorBuilder: (context, error, stacktrace) {
                  return Tooltip(
                    message: error.toString(),
                    child: const Icon(Icons.error),
                  );
                },
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8.0,
                children: [
                  MangaTitleButton(manga: manga),
                  if (header != null) IconTextChip(text: header!),
                  if (showGenres)
                    MangaGenreRow(
                      key: ValueKey('MangaGenreRow(${manga.id})'),
                      manga: manga,
                    ),
                  MangaStatisticsRow(
                    key: ValueKey('MangaStatisticsRow(${manga.id})'),
                    manga: manga,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChapterTitle extends ConsumerWidget {
  final Chapter chapter;
  final Manga manga;

  const ChapterTitle({super.key, required this.chapter, required this.manga});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final status = _watchReadStatus(ref, manga, chapter.id);

    TextStyle textstyle;

    if (status.id == null) {
      textstyle = TextStyle(color: theme.colorScheme.onPrimaryContainer);
    } else {
      textstyle = TextStyle(
        color: (status.read == true
            ? theme.disabledColor
            : theme.colorScheme.onPrimaryContainer),
      );
    }

    final isOfficialPub = chapter.attributes.externalUrl != null;

    return Text.rich(
      TextSpan(
        style: textstyle,
        children: [
          CountryFlagSpan(flag: chapter.attributes.translatedLanguage.flag),
          const WidgetSpan(child: SizedBox(width: 6.0)),
          if (isOfficialPub)
            const WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Padding(
                padding: EdgeInsets.only(right: 6.0),
                child: _openIconB,
              ),
            ),
          TextSpan(text: chapter.title),
        ],
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }
}

class MangaGenreRow extends StatelessWidget {
  const MangaGenreRow({super.key, required this.manga});

  final Manga manga;

  @override
  Widget build(BuildContext context) {
    final tr = context.t;
    final attributes = manga.attributes!;

    final contentTagChips = attributes.tags
        .where((tag) => tag.attributes.group == TagGroup.content)
        .map((e) => ContentChip(key: ValueKey(e.id), content: e));

    final genreTagChips = attributes.tags
        .where((tag) => tag.attributes.group != TagGroup.content)
        .map(
          (e) => IconTextChip(
            key: ValueKey(e.id),
            text: e.attributes.name.get(tr.$meta.locale.languageCode),
            onPressed: () =>
                MangaDexTagViewRoute(tagId: e.id, tag: e).push(context),
          ),
        );

    return Wrap(
      spacing: 4.0,
      runSpacing: 4.0,
      children: [
        if (attributes.contentRating != ContentRating.safe)
          ContentRatingChip(rating: attributes.contentRating),
        ...contentTagChips,
        ...genreTagChips,
      ],
    );
  }
}

class MangaStatisticsRow extends HookConsumerWidget {
  const MangaStatisticsRow({
    super.key,
    required this.manga,
    this.shortStatus = true,
  });

  final Manga manga;
  final bool shortStatus;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tr = context.t;
    final statsProvider = ref.watch(
      mangaStatisticsProvider(manga).select(
        (data) => switch (data) {
          AsyncValue<MangaStatistics>(value: final stats?) => stats,
          _ => null,
        },
      ),
    );

    final numFormatter = ref.watch(
      numberFormatterProvider(context.t.$meta.locale.flutterLocale.toString()),
    );

    return Wrap(
      runSpacing: 4.0,
      spacing: 5.0,
      children: [
        ...switch (statsProvider) {
          MangaStatistics(:final rating, :final follows, :final comments) => [
            IconTextChip(
              icon: const Icon(
                Icons.star_border,
                color: Colors.amber,
                size: 18,
                shadows: [Shadow(offset: Offset(1.0, 1.0))],
              ),
              text: rating.bayesian.toStringAsFixed(2),
              style: const TextStyle(
                color: Colors.amber,
                shadows: [Shadow(offset: Offset(1.0, 1.0))],
              ),
            ),
            IconTextChip(
              icon: const Icon(Icons.bookmark_outline, size: 18),
              text: numFormatter.format(follows),
            ),
            CommentChip(comments: comments),
          ],
          _ => [IconTextChip(text: tr.ui.loadingDot)],
        },
        const SizedBox.shrink(),
        MangaStatusChip(
          status: manga.attributes!.status,
          year: manga.attributes!.year,
          short: shortStatus,
        ),
      ],
    );
  }
}

class _GroupRow extends StatelessWidget {
  final Chapter chapter;

  const _GroupRow({required this.chapter});

  @override
  Widget build(BuildContext context) {
    final isOfficialPub = chapter.attributes.externalUrl != null;

    final chips = <Widget>[];

    for (final g in chapter.groups) {
      chips.add(
        Flexible(
          child: IconTextChip(
            icon: isOfficialPub ? _circleIconB : null,
            text: g.attributes.name,
            onPressed: () {
              MangaDexGroupViewRoute(groupId: g.id, $extra: g).push(context);
            },
          ),
        ),
      );
    }

    if (chips.isEmpty) {
      chips.add(Flexible(child: IconTextChip(text: 'No Group')));
    }

    return Row(mainAxisSize: MainAxisSize.min, spacing: 6.0, children: chips);
  }
}

class _PubTime extends HookWidget {
  final DateTime time;

  const _PubTime({required this.time});

  @override
  Widget build(BuildContext context) {
    final tr = context.t;
    final theme = Theme.of(context);
    //final bool screenSizeSmall = DeviceContext.screenWidthSmall(context);

    final lang = tr.$meta.locale.languageCode;
    //final locale = screenSizeSmall && timeagoLocaleList.contains('${lang}_short') ? '${lang}_short' : lang;

    final pubtime = useMemoized(() => timeago.format(time, locale: lang), [
      time,
      lang,
    ]);

    return Text(
      pubtime,
      style: TextStyle(color: theme.colorScheme.onPrimaryContainer),
    );
  }
}

final _commentCountCache = <String, Map<int, String>>{};

String _formatCommentCount(int count, NumberFormat formatter, String locale) {
  if (count < 1000) return count.toString();

  int bucket;
  if (count < 10000) {
    bucket = (count / 100).round() * 100;
  } else if (count < 100000) {
    bucket = (count / 1000).round() * 1000;
  } else {
    bucket = (count / 10000).round() * 10000;
  }

  final localeCache = _commentCountCache.putIfAbsent(locale, () => {});
  return localeCache.putIfAbsent(bucket, () => formatter.format(bucket));
}

class CommentChip extends ConsumerWidget {
  final StatisticsDetailsComments? comments;

  const CommentChip({super.key, this.comments});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = context.t.$meta.locale.flutterLocale.toString();
    final formatter = ref.watch(numberFormatterProvider(locale));

    return IconTextChip(
      icon: const Icon(Icons.chat_bubble_outline, size: 18),
      text: (comments != null)
          ? _formatCommentCount(comments!.repliesCount, formatter, locale)
          : 'N/A',
      onPressed: (comments != null)
          ? () async {
              final url =
                  'https://forums.mangadex.org/threads/${comments!.threadId}';

              await Styles.tryLaunchUrl(context, url);
            }
          : null,
    );
  }
}

class MangaStatusChip extends StatelessWidget {
  const MangaStatusChip({
    super.key,
    required this.status,
    this.year,
    this.short = true,
  });

  final MangaStatus status;
  final int? year;
  final bool short;

  @override
  Widget build(BuildContext context) {
    final tr = context.t;
    final label = tr[status.label];
    return IconTextChip(
      icon: Icon(
        Icons.circle,
        color: switch (status) {
          MangaStatus.completed => Colors.blue,
          MangaStatus.cancelled => Colors.red,
          MangaStatus.hiatus => Colors.orange,
          _ => Colors.green,
        },
        size: 10,
      ),
      text: (year != null && !short) ? "$year, $label" : label,
    );
  }
}

class ContentRatingChip extends StatelessWidget {
  const ContentRatingChip({super.key, required this.rating});

  final ContentRating rating;

  @override
  Widget build(BuildContext context) {
    final tr = context.t;
    return IconTextChip(
      color: switch (rating) {
        ContentRating.safe => Colors.green,
        ContentRating.suggestive => Colors.orange,
        ContentRating.erotica || ContentRating.pornographic => Colors.red,
      },
      text: tr[rating.label],
    );
  }
}

class ContentChip extends StatelessWidget {
  const ContentChip({super.key, required this.content});

  final Tag content;

  @override
  Widget build(BuildContext context) {
    final tr = context.t;
    final enlabel = content.attributes.name.get('en');
    final text = content.attributes.name.get(tr.$meta.locale.languageCode);
    return IconTextChip(
      color: switch (enlabel) {
        'Gore' || 'Sexual Violence' => Colors.red,
        _ => Colors.orange,
      },
      text: text,
    );
  }
}

Future<bool?> showDeleteListDialog(
  BuildContext context,
  String listName,
) async => await showDialog<bool>(
  context: context,
  builder: (BuildContext context) {
    final tr = context.t;
    final nav = Navigator.of(context);
    return AlertDialog(
      title: Text(tr.mangadex.deleteList),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(tr.mangadex.deleteListWarning(list: listName)),
          Text(tr.ui.irreversibleWarning),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          child: Text(tr.ui.no),
          onPressed: () {
            nav.pop(null);
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
