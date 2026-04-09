import 'package:cached_network_image_ce/cached_network_image.dart';
import 'package:gagaku/util/riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/model/common.dart';
import 'package:gagaku/model/model.dart';
import 'package:gagaku/routes.dart';
import 'package:gagaku/util/exception.dart';
import 'package:gagaku/util/cached_network_image.dart';
import 'package:gagaku/util/ui.dart';
import 'package:gagaku/util/util.dart';
import 'package:gagaku/web/model/model.dart';
import 'package:gagaku/web/model/types.dart';
import 'package:gagaku/web/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/experimental/scope.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'manga_view.g.dart';

enum _ChapterDivider { none, divider }

@Riverpod(retry: noRetry)
Future<(WebManga, HistoryLink)> _fetchWebMangaInfo(
  Ref ref,
  SourceHandler handle,
) async {
  final api = ref.watch(webSourceBrokerProvider);
  final manga = await api.getMangaFromSource(handle);

  if (manga != null) {
    final link = HistoryLink(
      title: manga.title,
      url: handle.getURL(),
      cover: manga.cover,
      handle: handle,
      lastAccessed: DateTime.now(),
    );

    link.resolveDb();

    return (manga, link);
  }

  throw InvalidDataException('Invalid WebManga link. Data not found.');
}

@Dependencies([chipTextStyle])
class WebMangaViewPage extends ConsumerWidget {
  const WebMangaViewPage({
    super.key,
    required this.sourceId,
    required this.mangaId,
    this.handle,
  });

  final String sourceId;
  final String mangaId;
  final SourceHandler? handle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final installed = GagakuData().store.box<WebSourceInfo>().getAll();

    final hndl =
        handle ??
        SourceHandler(
          type: (installed.indexWhere((e) => e.id == sourceId) > -1)
              ? SourceType.source
              : SourceType.proxy,
          sourceId: sourceId,
          location: mangaId,
        );

    return DataProviderWhenWidget(
      provider: _fetchWebMangaInfoProvider(hndl),
      loadingBuilder: (context, progress) => Scaffold(
        appBar: AppBar(leading: const BackButton()),
        body: Center(
          child: CircularProgressIndicator(value: progress?.toDouble()),
        ),
      ),
      errorBuilder: (context, child, _, _) => Scaffold(
        appBar: AppBar(leading: const BackButton()),
        body: Consumer(
          child: child,
          builder: (context, ref, child) {
            final api = ref.watch(webSourceBrokerProvider);
            return RefreshIndicator(
              onRefresh: () async {
                await api.invalidateAll(hndl.getKey());
                return ref.refresh(_fetchWebMangaInfoProvider(hndl).future);
              },
              child: child!,
            );
          },
        ),
      ),
      builder: (context, data) =>
          WebMangaViewWidget(manga: data.$1, handle: hndl, link: data.$2),
    );
  }
}

@Dependencies([chipTextStyle])
class WebMangaViewWidget extends HookConsumerWidget {
  const WebMangaViewWidget({
    super.key,
    required this.manga,
    required this.handle,
    required this.link,
  });

  final WebManga manga;
  final SourceHandler handle;
  final HistoryLink link;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tr = context.t;
    final source = ref.watch(
      getExtensionFromIdProvider(handle.sourceId).select(
        (value) => switch (value) {
          AsyncValue(value: final data?) => data,
          _ => null,
        },
      ),
    );
    final headers = ref.watch(sourceHeadersProvider(handle.sourceId));
    final imageCache = ref.watch(extensionImageCacheProvider);
    final api = ref.watch(webSourceBrokerProvider);
    final theme = Theme.of(context);

    // handle legacy share url
    final shareUrlFuture = useMemoized(
      () => ref
          .read(extensionSourceProvider(handle.sourceId).notifier)
          .getMangaURL(handle.location),
      [handle],
    );
    final shareUrl = useFuture(shareUrlFuture);

    final extdata = switch (manga) {
      WebMangaCubari() => null,
      WebMangaExtension(:final data) => data,
    };

    useEffect(() {
      Future.delayed(Duration.zero, () async {
        api.syncAndLogHistory(link);
      });
      return null;
    }, []);

    final separators = useMemoized(() {
      final chapters = manga.chapters;
      String getName(WebChapterItem c) => switch (c) {
        WebChapterItemCubari(:final entry) => entry.name,
        WebChapterItemExtension(:final chapter) => chapter.chapNum.toString(),
      };

      return List.generate(chapters.length, (index) {
        final currentName = getName(chapters[index]);

        final prevName = (index > 0) ? getName(chapters[index - 1]) : null;
        final nextName = (index < chapters.length - 1)
            ? getName(chapters[index + 1])
            : null;
        final afterNextName = (index < chapters.length - 2)
            ? getName(chapters[index + 2])
            : null;

        final followsGroup = currentName == prevName;
        final continuesGroup = currentName == nextName;
        final isBeforeNewGroup =
            nextName != null &&
            afterNextName != null &&
            nextName == afterNextName &&
            currentName != nextName;

        if (!continuesGroup || isBeforeNewGroup) {
          final isStandalone = !followsGroup && !continuesGroup;
          if (isStandalone && !isBeforeNewGroup) {
            return _ChapterDivider.none;
          }

          return _ChapterDivider.divider;
        }

        return _ChapterDivider.none;
      });
    }, [manga]);

    final isPhoneLandscape =
        !DeviceContext.isPortraitMode(context) &&
        DeviceContext.screenWidthSmall(context);
    final bannerExpandedHeight = isPhoneLandscape ? 120.0 : 250.0;
    final bannerTitleScale = isPhoneLandscape ? 1.5 : 2.0;
    final useWideLayout = DeviceContext.useNavigationRail(context);
    final leftWidth = (MediaQuery.sizeOf(context).width * 0.35).clamp(
      240.0,
      360.0,
    );
    // Declared unconditionally (hooks rule).
    final chapterScrollController = useScrollController();

    // Chapter list sliver — reused by both layouts.
    final chapterSliver = SliverList.separated(
      findItemIndexCallback: (key) {
        final valueKey = key as ValueKey<int>;
        final val = manga.chapters.indexWhere(
          (i) => i.hashCode == valueKey.value,
        );
        return val >= 0 ? val : null;
      },
      separatorBuilder: (_, index) {
        if (separators[index] == _ChapterDivider.divider) {
          return const Divider(height: 12.0);
        }
        return const SizedBox(height: 4.0);
      },
      itemBuilder: (BuildContext context, int index) {
        final current = manga.chapters[index];
        return ChapterButtonWidget(
          key: ValueKey(current.hashCode),
          data: current,
          manga: manga,
          handle: handle,
        );
      },
      itemCount: manga.chapters.length,
    );

    // The action buttons reused in both AppBar variants.
    final actionBar = OverflowBar(
      spacing: 6.0,
      children: [
        FavoritesButton(
          link: link,
          borderRadius: const BorderRadius.all(Radius.circular(6.0)),
        ),
        IconButton(
          tooltip: tr.webSources.searchWithExt,
          style: Styles.squareIconButtonStyle(
            backgroundColor: theme.colorScheme.surface.withAlpha(200),
          ),
          onPressed: () => ExtensionSearchRoute(
            initialSource: source,
            query: SearchQuery(title: manga.title),
          ).push(context),
          icon: const Icon(Icons.search),
        ),
        MenuAnchor(
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
              onPressed: () async {
                final key = handle.getKey();
                final result = await showDialog<bool>(
                  context: context,
                  builder: (BuildContext context) {
                    final nav = Navigator.of(context);
                    return AlertDialog(
                      title: Text(tr.webSources.resetRead),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [Text(tr.webSources.resetReadWarning)],
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
                if (result == true) {
                  ref.run((tsx) async {
                    return await tsx
                        .get(webReadMarkersProvider.notifier)
                        .deleteKey(key);
                  });
                }
              },
              leadingIcon: const Icon(Icons.restore),
              child: Text(tr.webSources.resetRead),
            ),
            MenuItemButton(
              onPressed: () =>
                  Clipboard.setData(
                    ClipboardData(
                      text:
                          'gagaku://open${GoRouterState.of(context).uri.path}',
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
        ),
        const SizedBox(width: 2),
      ],
    );

    // Metadata column — reused in both layouts.
    final metadataChildren = [
      if (extdata != null)
        Padding(
          padding: const EdgeInsets.all(8),
          child: MangaStatisticsRow(manga: extdata),
        ),
      if (extdata != null && extdata.mangaInfo.secondaryTitles.isNotEmpty)
        ExpansionTile(
          title: Text(tr.mangaView.altTitles),
          children: [
            for (final alttitle in extdata.mangaInfo.secondaryTitles)
              SizedBox(
                width: double.infinity,
                child: ListTile(
                  tileColor: theme.colorScheme.surfaceContainerHighest,
                  title: Text(alttitle),
                  onTap: () => Clipboard.setData(ClipboardData(text: alttitle))
                      .then((_) {
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
                      backgroundColor: theme.colorScheme.surface.withAlpha(200),
                    ),
                    onPressed: () => ExtensionSearchRoute(
                      initialSource: source,
                      query: SearchQuery(title: alttitle),
                    ).push(context),
                    icon: const Icon(Icons.search),
                  ),
                ),
              ),
          ],
        ),
      if (manga.description.isNotEmpty)
        ExpansionTile(
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          title: Text(tr.mangaView.synopsis),
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              color: theme.colorScheme.surfaceContainerHighest,
              child: MarkdownBody(
                data: manga.description,
                onTapLink: (text, url, title) async {
                  if (url != null) await Styles.tryLaunchUrl(context, url);
                },
              ),
            ),
          ],
        ),
      ExpansionTile(
        title: Text(tr.mangaView.info),
        children: [
          MultiChildExpansionTile(
            title: tr.mangaView.author,
            children: [IconTextChip(text: manga.author)],
          ),
          MultiChildExpansionTile(
            title: tr.mangaView.artist,
            children: [IconTextChip(text: manga.artist)],
          ),
          if (extdata != null)
            for (final tagsec
                in (extdata.mangaInfo.tagGroups ?? <TagSection>[]))
              MultiChildExpansionTile(
                title: tagsec.title.capitalize(),
                children: [
                  for (final tag in tagsec.tags)
                    IconTextChip(
                      text: tag.title,
                      onPressed: () => ExtensionSearchRoute(
                        initialSource: source,
                        query: SearchQuery(
                          title: '',
                          filters: [
                            SearchFilterValue(
                              id: tagsec.id,
                              value: {tag.id: 'included'},
                            ),
                          ],
                        ),
                      ).push(context),
                    ),
                ],
              ),
          MultiChildExpansionTile(
            title: tr.tracking.links,
            children: [
              if (handle.type == SourceType.proxy)
                ButtonChip(
                  onPressed: () async {
                    final route = GoRouterState.of(context).uri;
                    await Styles.tryLaunchUrl(
                      context,
                      'http://cubari.moe${route.path}',
                    );
                  },
                  text: tr.mangaView.openOn(arg: 'cubari.moe'),
                ),
              if (handle.type == SourceType.source &&
                  extdata != null &&
                  (extdata.mangaInfo.shareUrl != null || shareUrl.data != null))
                ButtonChip(
                  onPressed: () async {
                    final url = extdata.mangaInfo.shareUrl ?? shareUrl.data!;
                    await Styles.tryLaunchUrl(context, url);
                  },
                  text: tr.mangaView.openOn(arg: handle.sourceId),
                ),
            ],
          ),
        ],
      ),
    ];

    // Chapters heading + bulk mark-all — collapsed into a single pinned row.
    final chapterControlsWidget = Material(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Row(
          children: [
            Text(tr.mangaView.chapters, style: CommonTextStyles.twentyfour),
            const Spacer(),
            Consumer(
              builder: (context, ref, child) {
                final mangakey = handle.getKey();
                final chapterkeys = manga.chapters.map(
                  (e) => switch (e) {
                    WebChapterItemCubari(:final entry) => entry.name,
                    WebChapterItemExtension(:final chapter) =>
                      chapter.chapNum.toString(),
                  },
                );
                final allRead = ref.watch(
                  webReadMarkersProvider.select(
                    (value) => switch (value) {
                      AsyncValue(value: final db?) =>
                        db.markers[mangakey]?.containsAll(chapterkeys) ?? false,
                      _ => false,
                    },
                  ),
                );
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
                    if (result == true) {
                      ref.run((tsx) async {
                        return await tsx
                            .get(webReadMarkersProvider.notifier)
                            .setBulk(
                              mangakey,
                              read: !allRead ? chapterkeys : null,
                              unread: allRead ? chapterkeys : null,
                            );
                      });
                    }
                  },
                  child: Text(tr.mangaView.markAllAs(arg: opt)),
                );
              },
            ),
          ],
        ),
      ),
    );

    final scrollToTopFab = ListenableBuilder(
      listenable: chapterScrollController,
      builder: (context, _) {
        final visible =
            chapterScrollController.hasClients &&
            chapterScrollController.offset > 0;
        return AnimatedScale(
          scale: visible ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          child: IgnorePointer(
            ignoring: !visible,
            child: FloatingActionButton.small(
              heroTag: null,
              tooltip: tr.ui.scrollToTop,
              onPressed: () => chapterScrollController.animateTo(
                0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              ),
              child: const Icon(Icons.vertical_align_top),
            ),
          ),
        );
      },
    );

    // ── Wide layout (two-column) ──────────────────────────────────────────────
    if (useWideLayout) {
      final coverWidget = Padding(
        padding: const EdgeInsets.all(12.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: AspectRatio(
            aspectRatio: 2 / 3,
            child: CachedNetworkImage(
              imageUrl: manga.cover,
              httpHeaders: headers,
              cacheManager: imageCache,
              memCacheWidth: 256,
              maxWidthDiskCache: 256,
              colorBlendMode: BlendMode.modulate,
              color: Colors.grey,
              fit: BoxFit.cover,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  const Center(child: CircularProgressIndicator()),
              errorBuilder: (context, error, stacktrace) => Tooltip(
                message: error.toString(),
                child: const Icon(Icons.error),
              ),
            ),
          ),
        ),
      );

      return Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
          title: Text(manga.title),
          actions: [actionBar],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await api.invalidateAll(handle.getKey());
            return ref.refresh(_fetchWebMangaInfoProvider(handle).future);
          },
          notificationPredicate: (notification) {
            return notification.depth == 0;
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: leftWidth,
                child: NotificationListener<ScrollNotification>(
                  onNotification: (_) => true,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        coverWidget,
                        if (source != null && source.icon.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                              vertical: 4.0,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  handle.sourceId,
                                  style: CommonTextStyles.twelveBold,
                                ),
                                const SizedBox(width: 6),
                                Image.network(
                                  source.icon,
                                  width: 24,
                                  height: 24,
                                ),
                              ],
                            ),
                          )
                        else
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                              vertical: 4.0,
                            ),
                            child: Text(
                              handle.sourceId,
                              style: CommonTextStyles.twelveBold,
                            ),
                          ),
                        ...metadataChildren,
                      ],
                    ),
                  ),
                ),
              ),
              const VerticalDivider(thickness: 1, width: 1),
              Expanded(
                child: Column(
                  children: [
                    chapterControlsWidget,
                    Expanded(
                      child: CustomScrollView(
                        controller: chapterScrollController,
                        scrollBehavior: const MouseTouchScrollBehavior(),
                        slivers: [chapterSliver],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: scrollToTopFab,
      );
    }

    // ── Narrow layout ───────────────────────────────────────────────────────────────
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await api.invalidateAll(handle.getKey());
          return ref.refresh(_fetchWebMangaInfoProvider(handle).future);
        },
        child: NestedScrollView(
          controller: chapterScrollController,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              pinned: true,
              snap: false,
              floating: false,
              expandedHeight: bannerExpandedHeight,
              forceElevated: innerBoxIsScrolled,
              leading: const BackButton(),
              flexibleSpace: FlexibleSpaceBar(
                expandedTitleScale: bannerTitleScale,
                title: Text(
                  manga.title,
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
                      imageUrl: manga.cover,
                      httpHeaders: headers,
                      cacheManager: imageCache,
                      memCacheWidth: 256,
                      maxWidthDiskCache: 256,
                      colorBlendMode: BlendMode.modulate,
                      color: Colors.grey,
                      fit: BoxFit.cover,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              const Center(child: CircularProgressIndicator()),
                      errorBuilder: (context, error, stacktrace) {
                        return Tooltip(
                          message: error.toString(),
                          child: const Icon(Icons.error),
                        );
                      },
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 20.0, bottom: 10.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              handle.sourceId,
                              style: CommonTextStyles.twelveBold,
                            ),
                            if (source != null && source.icon.isNotEmpty)
                              Image.network(source.icon, width: 24, height: 24),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [actionBar],
            ),
            SliverList.list(children: metadataChildren),
            SliverPersistentHeader(
              pinned: true,
              delegate: _PinnedHeaderDelegate(
                child: chapterControlsWidget,
                height: 56.0,
              ),
            ),
          ],
          body: SafeArea(
            top: false,
            bottom: true,
            child: CustomScrollView(
              scrollBehavior: const MouseTouchScrollBehavior(),
              slivers: [chapterSliver],
            ),
          ),
        ),
      ),
      floatingActionButton: scrollToTopFab,
    );
  }
}

class _PinnedHeaderDelegate extends SliverPersistentHeaderDelegate {
  const _PinnedHeaderDelegate({required this.child, required this.height});
  final Widget child;
  final double height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) => child;
  @override
  double get maxExtent => height;
  @override
  double get minExtent => height;
  @override
  bool shouldRebuild(_PinnedHeaderDelegate old) =>
      child != old.child || height != old.height;
}

@Dependencies([chipTextStyle])
class MangaStatisticsRow extends StatelessWidget {
  const MangaStatisticsRow({super.key, required this.manga});

  final SourceManga manga;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 4.0,
      spacing: 5.0,
      children: [
        ContentChip(content: manga.mangaInfo.contentRating),
        if (manga.mangaInfo.rating != null)
          IconTextChip(
            icon: const Icon(
              Icons.star_border,
              color: Colors.amber,
              size: 18,
              shadows: [Shadow(offset: Offset(1.0, 1.0))],
            ),
            text: (manga.mangaInfo.rating! * 10).toStringAsFixed(2),
            style: const TextStyle(
              color: Colors.amber,
              shadows: [Shadow(offset: Offset(1.0, 1.0))],
            ),
          ),
        const SizedBox.shrink(),
        if (manga.mangaInfo.status != null)
          IconTextChip(text: manga.mangaInfo.status!),
      ],
    );
  }
}

@Dependencies([chipTextStyle])
class ContentChip extends StatelessWidget {
  const ContentChip({super.key, required this.content});

  final ContentRating content;

  @override
  Widget build(BuildContext context) {
    final label = content.name.toLowerCase().capitalize();
    return IconTextChip(
      color: switch (content) {
        ContentRating.ADULT => Colors.red,
        ContentRating.MATURE => Colors.orange,
        _ => Colors.green,
      },
      text: label,
    );
  }
}
