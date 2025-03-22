// ignore_for_file: unused_element
import 'package:animations/animations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/routes.gr.dart';
import 'package:gagaku/model/config.dart';
import 'package:gagaku/mangadex/model/model.dart';
import 'package:gagaku/mangadex/reader.dart';
import 'package:gagaku/mangadex/settings.dart';
import 'package:gagaku/reader/main.dart';
import 'package:gagaku/util/cached_network_image.dart';
import 'package:gagaku/util/infinite_scroll.dart';
import 'package:gagaku/util/ui.dart';
import 'package:gagaku/util/util.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';

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

const _endChip = IconTextChip(
  key: ValueKey('END'),
  color: Colors.blue,
  text: 'END',
);

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

class MangaDexSliverAppBar extends StatelessWidget {
  const MangaDexSliverAppBar({super.key, this.controller, this.title});

  final ScrollController? controller;
  final String? title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final flex = GestureDetector(
      onTap: () {
        controller?.animateTo(
          0.0,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeOutCirc,
        );
      },
      child: TitleFlexBar(title: title ?? 'MangaDex'),
    );

    final actions = <Widget>[
      OverflowBar(
        spacing: 8.0,
        children: [
          IconButton(
            color: theme.colorScheme.onPrimaryContainer,
            icon: const Icon(Icons.search),
            onPressed: () => context.router.push(MangaDexSearchRoute()),
            tooltip: 'search.arg'.tr(context: context, args: ['MangaDex']),
          ),
          Tooltip(
            message: 'arg_settings'.tr(context: context, args: ['MangaDex']),
            child: OpenContainer<bool>(
              closedColor: theme.colorScheme.primaryContainer,
              closedShape: const CircleBorder(),
              closedElevation: 0.0,
              closedBuilder: (context, openContainer) {
                return IconButton(
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
          Consumer(
            builder: (context, ref, child) {
              final auth = ref.watch(loggedUserProvider);

              return switch (auth) {
                AsyncValue(hasValue: true, value: final me) =>
                  // XXX: This changes when OAuth is released
                  me == null
                      ? IconButton(
                        color: theme.colorScheme.primary,
                        tooltip: 'auth.login'.tr(context: context),
                        icon: const Icon(Icons.login),
                        onPressed:
                            () => context.router.push(MangaDexLoginRoute()),
                      )
                      : MenuAnchor(
                        builder:
                            (context, controller, child) => IconButton(
                              color: theme.colorScheme.primary,
                              onPressed: () {
                                if (controller.isOpen) {
                                  controller.close();
                                } else {
                                  controller.open();
                                }
                              },
                              icon: const Icon(Icons.person),
                            ),
                        menuChildren: [
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                spacing: 10.0,
                                children: [
                                  CircleAvatar(child: const Icon(Icons.person)),
                                  Text(
                                    'auth.loggedInAs'.tr(
                                      context: context,
                                      args: [me.attributes?.username ?? 'null'],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          MenuItemButton(
                            onPressed:
                                () => ref.read(authControlProvider.logout)(),
                            leadingIcon: const Icon(Icons.logout),
                            child: Text('auth.logout'.tr(context: context)),
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

    return SliverAppBar(floating: true, flexibleSpace: flex, actions: actions);
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
        builder:
            (context, items) => ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 256),
              child: CarouselView(
                itemExtent: 180,
                shrinkExtent: 180,
                enableSplash: false,
                children:
                    items
                        .map(
                          (e) => GridMangaItem(key: ValueKey(e.id), manga: e),
                        )
                        .toList(),
              ),
            ),
      ),
    );
  }
}

class MarkReadButton extends ConsumerWidget {
  const MarkReadButton({super.key, required this.chapter, required this.manga});

  final Chapter chapter;
  final Manga manga;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final me = ref.watch(loggedUserProvider).value;

    if (me == null) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);

    bool? isRead = ref.watch(
      readChaptersProvider(me.id).select(
        (value) => switch (value) {
          AsyncValue(value: final data?) =>
            data[manga.id]?.contains(chapter.id) == true,
          _ => null,
        },
      ),
    );

    return switch (isRead) {
      null => const SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(),
      ),
      true || false => IconButton(
        onPressed: () async {
          bool set = !isRead;
          ref.read(readChaptersProvider(me.id).set)(
            manga,
            read: set ? [chapter] : null,
            unread: !set ? [chapter] : null,
          );
        },
        padding: EdgeInsets.zero,
        splashRadius: 15,
        iconSize: 20,
        tooltip: 'mangaView.markAs'.tr(
          context: context,
          args: [
            isRead == true
                ? 'mangaView.unread'.tr(context: context)
                : 'mangaView.read'.tr(context: context),
          ],
        ),
        icon:
            isRead == true
                ? Icon(Icons.visibility_off, color: theme.disabledColor)
                : Icon(Icons.visibility, color: theme.primaryIconTheme.color),
        constraints: const BoxConstraints(
          minWidth: 20.0,
          minHeight: 20.0,
          maxWidth: 24.0,
          maxHeight: 24.0,
        ),
        visualDensity: const VisualDensity(horizontal: -4.0, vertical: -4.0),
      ),
    };
  }
}

class ChapterFeedWidget extends HookWidget {
  const ChapterFeedWidget({
    super.key,
    required this.controller,
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
          cacheExtent: MediaQuery.sizeOf(context).height,
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
                    child: Text(title!, style: const TextStyle(fontSize: 24)),
                  ),
                ),
              ),
            PagingListener(
              controller: controller,
              builder:
                  (context, state, fetchNextPage) => HookConsumer(
                    builder: (context, ref, child) {
                      final api = ref.watch(mangadexProvider);
                      final chapters = state.items;

                      final builtItems = useMemoized(() async {
                        if (chapters == null) {
                          return null;
                        }

                        final mangaIds =
                            chapters.map((e) => e.manga.id).toSet();
                        final mangas = await api.fetchMangaById(
                          ids: mangaIds,
                          limit: MangaDexEndpoints.breakLimit,
                        );

                        final items = ChapterFeedItemData.toData(
                          chapters,
                          mangas,
                        );

                        return items;
                      }, [state]);

                      final future = useFuture(builtItems);

                      final newState = PagingState<int, ChapterFeedItemData>(
                        pages:
                            state.keys == null || !future.hasData
                                ? null
                                : List.generate(
                                  state.keys!.length,
                                  (i) => i == 0 ? future.data! : [],
                                ),
                        keys: future.hasData ? state.keys : null,
                        hasNextPage: state.hasNextPage,
                        isLoading:
                            future.connectionState == ConnectionState.waiting ||
                            !future.hasData ||
                            state.isLoading,
                      );

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
                              itemBuilder:
                                  (context, item, index) => ChapterFeedItem(
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
  late final _pagingController = GagakuPagingController<int, Chapter>(
    getNextPageKey:
        (state) =>
            state.keys?.last != null ? state.keys!.last + widget.limit : 0,
    fetchPage: (pageKey) async {
      final me = await ref.watch(loggedUserProvider.future);
      final api = ref.watch(mangadexProvider);

      final chapterlist = await api.fetchFeed(
        path: widget.path,
        feedKey: widget.feedKey,
        limit: widget.limit,
        offset: pageKey,
        entity: widget.entity,
        orderKey: widget.orderKey,
        order: widget.order,
      );

      final chapters = chapterlist.data.cast<Chapter>();

      final mangaIds = chapters.map((e) => e.manga.id).toSet();
      final mangas = await api.fetchMangaById(
        ids: mangaIds,
        limit: MangaDexEndpoints.breakLimit,
      );

      await ref.read(statisticsProvider.get)(mangas);
      await ref.read(readChaptersProvider(me?.id).get)(mangas);
      await ref.read(chapterStatsProvider.get)(chapters);

      return PageResultsMetaData(chapters, chapterlist.total);
    },
    refresh: () async {
      final api = ref.watch(mangadexProvider);
      await api.invalidateAll(
        widget.entity == null
            ? widget.feedKey
            : '${widget.feedKey}(${widget.entity!.id}',
      );
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
    if (_pagingController.value.status == PagingStatus.subsequentPageError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('errors.fetchFail'.tr(context: context)),
          action: SnackBarAction(
            label: 'ui.retry'.tr(context: context),
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
      onRefresh: () async => _pagingController.refresh(),
      title: widget.title,
      scrollController: widget.scrollController,
      restorationId: widget.restorationId,
      leading: widget.leading,
    );
  }
}

class _CoverButton extends ConsumerWidget {
  const _CoverButton({super.key, required this.manga});

  final Manga manga;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final me = ref.watch(loggedUserProvider).value;
    final screenSizeSmall = DeviceContext.screenWidthSmall(context);
    final getReadChapters = ref.watch(readChaptersProvider(me?.id).get);
    final getRatings = ref.watch(ratingsProvider(me?.id).get);
    final getStats = ref.watch(statisticsProvider.get);

    return TextButton(
      onPressed: () async {
        getReadChapters([manga]);
        getRatings([manga]);
        getStats([manga]);
        context.router.push(
          MangaDexMangaViewRoute(mangaId: manga.id, manga: manga),
        );
      },
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 6.0),
      ),
      child: CachedNetworkImage(
        imageUrl: manga.getFirstCoverUrl(quality: CoverArtQuality.small),
        cacheManager: gagakuImageCache,
        imageBuilder:
            (context, imageProvider) => DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(image: imageProvider),
                borderRadius: const BorderRadius.all(Radius.circular(4.0)),
              ),
            ),
        width: screenSizeSmall ? 64.0 : 128.0,
        height: screenSizeSmall ? 91.0 : 182.0,
        progressIndicatorBuilder:
            (context, url, downloadProgress) =>
                const Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        fit: BoxFit.cover,
      ),
    );
  }
}

class _MangaTitle extends ConsumerWidget {
  final Manga manga;

  const _MangaTitle({super.key, required this.manga});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final me = ref.watch(loggedUserProvider).value;
    final theme = Theme.of(context);
    final getReadChapters = ref.watch(readChaptersProvider(me?.id).get);
    final getRatings = ref.watch(ratingsProvider(me?.id).get);
    final getStats = ref.watch(statisticsProvider.get);

    return TextButton.icon(
      style: TextButton.styleFrom(
        alignment: Alignment.centerLeft,
        minimumSize: const Size(0.0, 24.0),
        shape: const RoundedRectangleBorder(),
        foregroundColor: theme.colorScheme.onSurface,
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        visualDensity: const VisualDensity(horizontal: -4.0, vertical: -4.0),
      ),
      onPressed: () async {
        getReadChapters([manga]);
        getRatings([manga]);
        getStats([manga]);
        context.router.push(
          MangaDexMangaViewRoute(mangaId: manga.id, manga: manga),
        );
      },
      icon: CountryFlag(
        key: ValueKey(
          'CountryFlag(${manga.attributes!.originalLanguage.code})',
        ),
        flag: manga.attributes!.originalLanguage.flag,
      ),
      label: Text(
        manga.attributes!.title.get('en'),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class _BackLinkedChapterButton extends ConsumerWidget {
  const _BackLinkedChapterButton({
    super.key,
    required this.chapter,
    required this.manga,
  });

  final Chapter chapter;
  final Manga manga;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final me = ref.watch(loggedUserProvider).value;
    final getReadChapters = ref.watch(readChaptersProvider(me?.id).get);
    final getRatings = ref.watch(ratingsProvider(me?.id).get);
    final getStats = ref.watch(statisticsProvider.get);

    return ChapterButtonWidget(
      chapter: chapter,
      manga: manga,
      onLinkPressed: (context) async {
        getReadChapters([manga]);
        getRatings([manga]);
        getStats([manga]);
        context.router.push(
          MangaDexMangaViewRoute(mangaId: manga.id, manga: manga),
        );
      },
    );
  }
}

class ChapterFeedItem extends HookWidget {
  const ChapterFeedItem({super.key, required this.state});

  final ChapterFeedItemData state;

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive();
    final screenSizeSmall = DeviceContext.screenWidthSmall(context);

    final titleBtn = _MangaTitle(
      key: ValueKey('_MangaTitle(${state.manga.id})'),
      manga: state.manga,
    );

    final coverBtn = _CoverButton(
      key: ValueKey('_CoverButton(${state.manga.id})'),
      manga: state.manga,
    );

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child:
            screenSizeSmall
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
                            children:
                                state.chapters
                                    .map(
                                      (e) => _BackLinkedChapterButton(
                                        key: ValueKey(e.id),
                                        chapter: e,
                                        manga: state.manga,
                                      ),
                                    )
                                    .toList(),
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
                          ...state.chapters.map(
                            (e) => _BackLinkedChapterButton(
                              key: ValueKey(e.id),
                              chapter: e,
                              manga: state.manga,
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

class _ChapterButtonCard extends ConsumerWidget {
  final Chapter chapter;
  final Manga manga;
  final Widget child;

  const _ChapterButtonCard({
    super.key,
    required this.chapter,
    required this.manga,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool screenSizeSmall = DeviceContext.screenWidthSmall(context);
    final theme = Theme.of(context);
    final tileColor = theme.colorScheme.primaryContainer;
    final me = ref.watch(loggedUserProvider).value;

    Border border;

    if (me == null) {
      border = Border(left: BorderSide(color: tileColor, width: 4.0));
    } else {
      bool? isRead = ref.watch(
        readChaptersProvider(me.id).select(
          (value) => switch (value) {
            AsyncValue(value: final data?) =>
              data[manga.id]?.contains(chapter.id) == true,
            _ => null,
          },
        ),
      );

      border = Border(
        left: BorderSide(
          color: isRead == true ? tileColor : Colors.blue,
          width: 4.0,
        ),
      );
    }

    return Ink(
      padding: EdgeInsets.symmetric(
        horizontal: (screenSizeSmall ? 6.0 : 10.0),
        vertical: 4.0,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        color: tileColor,
        border: border,
      ),
      child: child,
    );
  }
}

class ChapterButtonWidget extends HookWidget {
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
  Widget build(BuildContext context) {
    useAutomaticKeepAlive();
    final bool screenSizeSmall = DeviceContext.screenWidthSmall(context);

    final isEndChapter =
        manga.attributes!.lastChapter != null &&
        manga.attributes!.lastChapter?.isNotEmpty == true &&
        chapter.attributes.chapter == manga.attributes!.lastChapter;
    final isOfficialPub = chapter.attributes.externalUrl != null;

    final user = chapter.uploadUser;
    final userChip = IconTextChip(
      key: ValueKey(user?.id),
      icon: isOfficialPub ? _checkIconB : null,
      text:
          !isOfficialPub
              ? (user?.attributes?.username.crop() ?? '')
              : 'mangadex.officialPub'.tr(context: context),
    );

    final statsChip = Consumer(
      builder: (context, ref, child) {
        final comments = ref.watch(
          chapterStatsProvider.select(
            (value) => switch (value) {
              AsyncValue(value: final data?)
                  when data.containsKey(chapter.id) =>
                data[chapter.id]?.comments,
              _ => null,
            },
          ),
        );

        return CommentChip(
          key: ValueKey('CommentChip(${chapter.id})'),
          comments: comments,
        );
      },
    );

    final statsChipRow = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [Flexible(child: statsChip)],
    );

    final pubtime = _PubTime(
      key: ValueKey(chapter.attributes.publishAt.millisecondsSinceEpoch),
      time: chapter.attributes.publishAt,
    );

    final markReadButton = MarkReadButton(
      key: ValueKey('MarkReadButton(${chapter.id})'),
      chapter: chapter,
      manga: manga,
    );

    final title = Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 6.0,
      children: [
        const SizedBox.shrink(),
        CountryFlag(
          key: ValueKey(
            'CountryFlag(${chapter.attributes.translatedLanguage.code})',
          ),
          flag: chapter.attributes.translatedLanguage.flag,
        ),
        if (isOfficialPub) _openIconB,
        Expanded(
          child: Row(
            spacing: 6.0,
            children: [
              Flexible(
                child: ChapterTitle(
                  key: ValueKey('ChapterTitle(${chapter.id})'),
                  chapter: chapter,
                  manga: manga,
                ),
              ),
              if (isEndChapter) _endChip,
            ],
          ),
        ),
        if (screenSizeSmall) statsChipRow,
      ],
    );

    final groups = _GroupRow(
      key: ValueKey('_GroupRow(${chapter.id})'),
      chapter: chapter,
    );

    final tile =
        screenSizeSmall
            ? Table(
              columnWidths: const <int, TableColumnWidth>{
                0: FixedColumnWidth(24),
                1: FlexColumnWidth(),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: <TableRow>[
                TableRow(children: <Widget>[markReadButton, title]),
                TableRow(children: <Widget>[_groupIconB, groups]),
                TableRow(
                  children: [
                    _personIconB,
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Row(children: [Flexible(child: userChip)]),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          spacing: 4.0,
                          children: [_scheduleIconB, pubtime],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            )
            : Table(
              columnWidths: const <int, TableColumnWidth>{
                0: FixedColumnWidth(24),
                1: FlexColumnWidth(),
                2: FixedColumnWidth(24),
                3: FixedColumnWidth(145),
                4: FixedColumnWidth(60),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: <TableRow>[
                TableRow(
                  children: <Widget>[
                    markReadButton,
                    title,
                    _scheduleIconB,
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [const SizedBox(width: 2.0), pubtime],
                    ),
                    const SizedBox.shrink(),
                  ],
                ),
                TableRow(
                  children: <Widget>[
                    _groupIconB,
                    groups,
                    _personIconB,
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [Flexible(child: userChip)],
                    ),
                    statsChipRow,
                  ],
                ),
              ],
            );

    return InkWell(
      onTap: () {
        context.router.push(
          MangaDexReaderRoute(
            chapterId: chapter.id,
            readerData: ReaderData(
              title: chapter.title,
              chapter: chapter,
              manga: manga,
              link: manga.attributes!.title.get('en'),
              onLinkPressed: onLinkPressed,
            ),
          ),
        );
      },
      child: _ChapterButtonCard(
        key: ValueKey('_ChapterButtonCard(${chapter.id})'),
        manga: manga,
        chapter: chapter,
        child: tile,
      ),
    );
  }
}

class MangaListWidget extends HookConsumerWidget {
  const MangaListWidget({
    super.key,
    this.title,
    required this.children,
    this.leading = const <Widget>[],
    this.physics,
    this.controller,
    this.future,
    this.noController = false,
    this.showToggle = true,
  });

  final Widget? title;
  final List<Widget> children;
  final List<Widget> leading;
  final ScrollPhysics? physics;
  final ScrollController? controller;
  final AsyncSnapshot? future;
  final bool noController;
  final bool showToggle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController =
        controller ?? (noController ? null : useScrollController());
    final view =
        showToggle ? ref.watch(_mangaListViewProvider) : MangaListView.grid;

    final isLoading =
        future != null
            ? (future!.connectionState == ConnectionState.waiting ||
                !future!.hasData)
            : false;

    return Stack(
      children: [
        CustomScrollView(
          controller: scrollController,
          scrollBehavior: const MouseTouchScrollBehavior(),
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
                    if (title != null) title!,
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
                            tooltip: 'ui.gridView'.tr(context: context),
                          ),
                          ButtonSegment<MangaListView>(
                            value: MangaListView.list,
                            icon: Icon(Icons.table_rows, size: 24),
                            tooltip: 'ui.listView'.tr(context: context),
                          ),
                          ButtonSegment<MangaListView>(
                            value: MangaListView.detailed,
                            icon: Icon(Icons.view_list, size: 24),
                            tooltip: 'ui.detailedView'.tr(context: context),
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
    final view =
        selectMode ? MangaListView.grid : ref.watch(_mangaListViewProvider);

    if (items != null) {
      switch (view) {
        case MangaListView.list:
          return SliverList.builder(
            findChildIndexCallback: _findChildIndexCb,
            itemBuilder: (BuildContext context, int index) {
              final manga = items!.elementAt(index);
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
            childAspectRatio:
                DeviceContext.screenWidthSmall(context) ? 1.0 : 2.0,
          );

          return SliverGrid.builder(
            gridDelegate: delegate,
            findChildIndexCallback: _findChildIndexCb,
            itemBuilder: (context, index) {
              final manga = items!.elementAt(index);
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
              final manga = items!.elementAt(index);
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
                itemBuilder:
                    (context, item, index) => _ListMangaItem(
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
              childAspectRatio:
                  DeviceContext.screenWidthSmall(context) ? 1.0 : 2.0,
            );

            return PagedSliverGrid(
              gridDelegate: delegate,
              state: state,
              fetchNextPage: fetchNextPage,
              builderDelegate: PagedChildBuilderDelegate<Manga>(
                animateTransitions: true,
                itemBuilder:
                    (context, item, index) => GridMangaDetailedItem(
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
                itemBuilder:
                    (context, item, index) => GridMangaItem(
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
    useAutomaticKeepAlive();
    final me = ref.watch(loggedUserProvider).value;
    final aniController = useAnimationController(
      duration: const Duration(milliseconds: 100),
    );
    final gradient = useAnimation(
      aniController.drive(Styles.coverArtGradientTween),
    );
    final getReadChapters = ref.watch(readChaptersProvider(me?.id).get);
    final getRatings = ref.watch(ratingsProvider(me?.id).get);
    final getStats = ref.watch(statisticsProvider.get);

    final image = GridAlbumImage(
      gradient: gradient,
      child: CachedNetworkImage(
        imageUrl: manga.getFirstCoverUrl(quality: CoverArtQuality.medium),
        cacheManager: gagakuImageCache,
        width: 256.0,
        fit: BoxFit.cover,
        progressIndicatorBuilder:
            (context, url, downloadProgress) =>
                const Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );

    return InkWell(
      onTap: () async {
        getReadChapters([manga]);
        getRatings([manga]);
        getStats([manga]);
        context.router.push(
          MangaDexMangaViewRoute(mangaId: manga.id, manga: manga),
        );
      },
      onHover: (hovering) {
        if (hovering) {
          aniController.forward();
        } else {
          aniController.reverse();
        }
      },
      child: GridTile(
        header:
            selectMode
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
                      height: 40,
                      backgroundColor: Colors.black87,
                      text: header!,
                    )
                    : null),
        footer: GridAlbumTextBar(
          height: 80,
          leading: CountryFlag(
            flag: manga.attributes!.originalLanguage.flag,
            size: 18,
          ),
          text: manga.attributes!.title.get('en'),
        ),
        child: image,
      ),
    );
  }
}

class GridMangaDetailedItem extends HookConsumerWidget {
  const GridMangaDetailedItem({super.key, required this.manga, this.header});

  final Manga manga;
  final String? header;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();
    final me = ref.watch(loggedUserProvider).value;
    final bool screenSizeSmall = DeviceContext.screenWidthSmall(context);
    final theme = Theme.of(context);
    final getReadChapters = ref.watch(readChaptersProvider(me?.id).get);
    final getRatings = ref.watch(ratingsProvider(me?.id).get);
    final getStats = ref.watch(statisticsProvider.get);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8.0,
          children: [
            TextButton.icon(
              style: TextButton.styleFrom(
                foregroundColor: theme.colorScheme.onSurface,
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () async {
                getReadChapters([manga]);
                getRatings([manga]);
                getStats([manga]);
                context.router.push(
                  MangaDexMangaViewRoute(mangaId: manga.id, manga: manga),
                );
              },
              icon: CountryFlag(
                flag: manga.attributes!.originalLanguage.flag,
                size: 18,
              ),
              label: Text(
                manga.attributes!.title.get('en'),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () async {
                      getReadChapters([manga]);
                      getRatings([manga]);
                      getStats([manga]);
                      context.router.push(
                        MangaDexMangaViewRoute(mangaId: manga.id, manga: manga),
                      );
                    },
                    child: CachedNetworkImage(
                      imageUrl: manga.getFirstCoverUrl(
                        quality: CoverArtQuality.small,
                      ),
                      cacheManager: gagakuImageCache,
                      width: screenSizeSmall ? 80.0 : 128.0,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              const Center(child: CircularProgressIndicator()),
                      errorWidget:
                          (context, url, error) => const Icon(Icons.error),
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

class _ListMangaItem extends HookConsumerWidget {
  const _ListMangaItem({super.key, required this.manga, this.header});

  final Manga manga;
  final String? header;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();
    final me = ref.watch(loggedUserProvider).value;
    final theme = Theme.of(context);
    final getReadChapters = ref.watch(readChaptersProvider(me?.id).get);
    final getRatings = ref.watch(ratingsProvider(me?.id).get);
    final getStats = ref.watch(statisticsProvider.get);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
              onPressed: () async {
                getReadChapters([manga]);
                getRatings([manga]);
                getStats([manga]);
                context.router.push(
                  MangaDexMangaViewRoute(mangaId: manga.id, manga: manga),
                );
              },
              child: CachedNetworkImage(
                imageUrl: manga.getFirstCoverUrl(
                  quality: CoverArtQuality.small,
                ),
                cacheManager: gagakuImageCache,
                width: 80.0,
                progressIndicatorBuilder:
                    (context, url, downloadProgress) =>
                        const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10.0,
                children: [
                  TextButton.icon(
                    style: TextButton.styleFrom(
                      foregroundColor: theme.colorScheme.onSurface,
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () async {
                      getReadChapters([manga]);
                      getRatings([manga]);
                      getStats([manga]);
                      context.router.push(
                        MangaDexMangaViewRoute(mangaId: manga.id, manga: manga),
                      );
                    },
                    icon: CountryFlag(
                      flag: manga.attributes!.originalLanguage.flag,
                      size: 18,
                    ),
                    label: Text(manga.attributes!.title.get('en')),
                  ),
                  if (header != null) IconTextChip(text: header!),
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
    final me = ref.watch(loggedUserProvider).value;

    TextStyle textstyle;

    if (me == null) {
      textstyle = TextStyle(color: theme.colorScheme.onPrimaryContainer);
    } else {
      bool? isRead = ref.watch(
        readChaptersProvider(me.id).select(
          (value) => switch (value) {
            AsyncValue(value: final data?) =>
              data[manga.id]?.contains(chapter.id) == true,
            _ => null,
          },
        ),
      );

      textstyle = TextStyle(
        color:
            (isRead == true
                ? theme.disabledColor
                : theme.colorScheme.onPrimaryContainer),
      );
    }

    return Text(
      chapter.title,
      overflow: TextOverflow.ellipsis,
      style: textstyle,
    );
  }
}

class MangaGenreRow extends HookWidget {
  const MangaGenreRow({super.key, required this.manga});

  final Manga manga;

  @override
  Widget build(BuildContext context) {
    final contentTagChips = useMemoized(() {
      return manga.attributes!.tags
          .where((tag) => tag.attributes.group == TagGroup.content)
          .map(
            (e) => ContentChip(
              key: ValueKey(e.id),
              content: e.attributes.name.get(context.locale.languageCode),
            ),
          );
    }, [manga]);

    final genreTagChips = useMemoized(() {
      return manga.attributes!.tags
          .where((tag) => tag.attributes.group != TagGroup.content)
          .map(
            (e) => IconTextChip(
              key: ValueKey(e.id),
              text: e.attributes.name.get(context.locale.languageCode),
              onPressed:
                  () => context.router.push(
                    MangaDexTagViewRoute(tagId: e.id, tag: e),
                  ),
            ),
          );
    }, [manga]);

    return Wrap(
      spacing: 4.0,
      runSpacing: 4.0,
      children: [
        if (manga.attributes!.contentRating != ContentRating.safe)
          ContentRatingChip(rating: manga.attributes!.contentRating),
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
    final statsProvider = ref.watch(
      statisticsProvider.select(
        (map) => switch (map) {
          AsyncValue(value: final stats?) when stats.containsKey(manga.id) =>
            stats[manga.id],
          _ => null,
        },
      ),
    );

    // Redundancy
    useEffect(() {
      Future.delayed(Duration.zero, () async {
        await ref.read(statisticsProvider.get)([manga]);
      });
      return null;
    }, []);

    final numFormatter = useMemoized(() {
      return NumberFormat.compact(locale: context.locale.toString());
    }, [context.locale]);

    return Wrap(
      runSpacing: 4.0,
      spacing: 5.0,
      children: [
        ...switch (statsProvider) {
          MangaStatistics(:final rating, :final follows, :final comments) => [
            IconTextChip(
              key: ValueKey('_RatingChip(${manga.id})'),
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
              key: ValueKey('_FollowsChip(${manga.id})'),
              icon: const Icon(Icons.bookmark_outline, size: 18),
              text: numFormatter.format(follows),
            ),
            CommentChip(
              key: ValueKey('CommentChip(${manga.id})'),
              comments: comments,
            ),
          ],
          _ => [IconTextChip(text: 'ui.loadingDot'.tr(context: context))],
        },
        const SizedBox.shrink(),
        MangaStatusChip(
          key: ValueKey('MangaStatusChip(${manga.id})'),
          status: manga.attributes!.status,
          year: manga.attributes!.year,
          short: shortStatus,
        ),
      ],
    );
  }
}

class _GroupRow extends HookWidget {
  final Chapter chapter;

  const _GroupRow({super.key, required this.chapter});

  @override
  Widget build(BuildContext context) {
    final isOfficialPub = chapter.attributes.externalUrl != null;

    final chips = <Widget>[];

    for (final g in chapter.groups) {
      chips.add(
        Flexible(
          child: IconTextChip(
            key: ValueKey(g.id),
            icon: isOfficialPub ? _circleIconB : null,
            text: g.attributes.name,
            onPressed: () {
              context.router.push(
                MangaDexGroupViewRoute(groupId: g.id, group: g),
              );
            },
          ),
        ),
      );
    }

    if (chips.isEmpty) {
      chips.add(
        Flexible(
          child: IconTextChip(key: const ValueKey('nogroup'), text: 'No Group'),
        ),
      );
    }

    return Row(mainAxisSize: MainAxisSize.min, spacing: 6.0, children: chips);
  }
}

class _PubTime extends StatelessWidget {
  final DateTime time;

  const _PubTime({super.key, required this.time});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    //final bool screenSizeSmall = DeviceContext.screenWidthSmall(context);

    final lang = context.locale.languageCode;
    //final locale = screenSizeSmall && timeagoLocaleList.contains('${lang}_short') ? '${lang}_short' : lang;

    final pubtime = timeago.format(time, locale: lang);

    return Text(
      pubtime,
      style: TextStyle(color: theme.colorScheme.onPrimaryContainer),
    );
  }
}

class CommentChip extends HookWidget {
  final StatisticsDetailsComments? comments;

  const CommentChip({super.key, this.comments});

  @override
  Widget build(BuildContext context) {
    final numFormatter = useMemoized(() {
      return NumberFormat.compact(locale: context.locale.toString());
    }, [context.locale]);

    return IconTextChip(
      icon: const Icon(Icons.chat_bubble_outline, size: 18),
      text:
          (comments != null)
              ? numFormatter.format(comments!.repliesCount)
              : 'N/A',
      onPressed:
          (comments != null)
              ? () async {
                final url =
                    'https://forums.mangadex.org/threads/${comments!.threadId}';

                if (!await launchUrl(Uri.parse(url))) {
                  throw 'Could not launch $url';
                }
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
    final label = context.tr(status.label);
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
    return IconTextChip(
      color: switch (rating) {
        ContentRating.safe => Colors.green,
        ContentRating.suggestive => Colors.orange,
        ContentRating.erotica || ContentRating.pornographic => Colors.red,
      },
      text: context.tr(rating.label),
    );
  }
}

class ContentChip extends StatelessWidget {
  const ContentChip({super.key, required this.content});

  final String content;

  @override
  Widget build(BuildContext context) {
    return IconTextChip(
      color: switch (content) {
        'Gore' || 'Sexual Violence' => Colors.red,
        _ => Colors.orange,
      },
      text: content,
    );
  }
}

Future<bool?> showDeleteListDialog(
  BuildContext context,
  String listName,
) async => await showDialog<bool>(
  context: context,
  builder: (BuildContext context) {
    final nav = Navigator.of(context);
    return AlertDialog(
      title: Text('mangadex.deleteList'.tr(context: context)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'mangadex.deleteListWarning'.tr(context: context, args: [listName]),
          ),
          Text('ui.irreversibleWarning'.tr(context: context)),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          child: Text('ui.no'.tr(context: context)),
          onPressed: () {
            nav.pop(null);
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
