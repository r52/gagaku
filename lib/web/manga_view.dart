import 'package:gagaku/util/riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/model/model.dart';
import 'package:gagaku/routes.dart';
import 'package:gagaku/util/exception.dart';
import 'package:gagaku/util/manga_detail.dart';
import 'package:gagaku/util/material_hooks.dart';
import 'package:gagaku/util/ui.dart';
import 'package:gagaku/util/util.dart';
import 'package:gagaku/web/model/config.dart';
import 'package:gagaku/web/model/model.dart';
import 'package:gagaku/web/model/types.dart';
import 'package:gagaku/web/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'manga_view.g.dart';

enum _ChapterDivider { none, divider }

enum _WebMangaTab { chapters, art }

@Riverpod(retry: noRetry)
Future<(WebManga, HistoryLink)> _fetchWebMangaInfo(
  Ref ref,
  WebSeriesRef series,
) async {
  final api = ref.watch(webSourceBrokerProvider);
  final manga = await api.getManga(series);

  if (manga != null) {
    final link = HistoryLink.fromSeries(
      title: manga.title,
      cover: manga.cover,
      series: series,
      lastAccessed: DateTime.now(),
    );

    link.resolveDb();

    return (manga, link);
  }

  throw InvalidDataException('Invalid WebManga link. Data not found.');
}

class WebMangaViewPage extends ConsumerWidget {
  static void _handleBack(BuildContext context) {
    final navigator = Navigator.of(context);
    if (navigator.canPop()) {
      navigator.pop();
    } else {
      const WebSourceFrontRoute().go(context);
    }
  }

  const WebMangaViewPage({
    super.key,
    required this.sourceId,
    required this.mangaId,
    this.series,
  });

  final String sourceId;
  final String mangaId;
  final WebSeriesRef? series;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final installed = GagakuData().store.box<WebSourceInfo>().getAll();

    final resolvedSeries =
        series ??
        ((installed.indexWhere((e) => e.id == sourceId) > -1)
            ? WebSeriesRef.extension(sourceId: sourceId, mangaId: mangaId)
            : WebSeriesRef.proxy(proxyId: sourceId, seriesId: mangaId));

    return DataProviderWhenWidget(
      provider: _fetchWebMangaInfoProvider(resolvedSeries),
      loadingBuilder: (context, progress) => Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () => WebMangaViewPage._handleBack(context),
          ),
        ),
        body: Center(
          child: CircularProgressIndicator(value: progress?.toDouble()),
        ),
      ),
      errorBuilder: (context, child, _, _) => Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () => WebMangaViewPage._handleBack(context),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () => _refreshWebManga(ref, resolvedSeries),
          child: child,
        ),
      ),
      builder: (context, data) => WebMangaViewWidget(
        manga: data.$1,
        series: resolvedSeries,
        link: data.$2,
      ),
    );
  }
}

class WebMangaViewWidget extends HookConsumerWidget {
  const WebMangaViewWidget({
    super.key,
    required this.manga,
    required this.series,
    required this.link,
  });

  final WebManga manga;
  final WebSeriesRef series;
  final HistoryLink link;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tr = context.t;
    final source = switch (series) {
      ExtensionSeriesRef(:final sourceId) => ref.watch(
        getExtensionFromIdProvider(sourceId).select(
          (value) => switch (value) {
            AsyncValue(value: final data?) => data,
            _ => null,
          },
        ),
      ),
      ProxySeriesRef() => null,
    };
    useEffect(() {
      Future.delayed(Duration.zero, () async {
        await WebHistoryManager().record(
          link,
          preserveHistory: ref.read(webConfigProvider).preserveHistory,
        );
      });
      return null;
    }, [link]);

    final headers = ref.watch(sourceHeadersProvider(series.sourceId));
    final chapterScrollController = useScrollController();
    final artworkUrls = manga.artworkUrls;
    final hasArtwork = artworkUrls.isNotEmpty;
    final tabController = useMaterialTabController(
      initialLength: hasArtwork ? _WebMangaTab.values.length : 1,
      keys: [hasArtwork],
    );

    return MangaDetailScaffold(
      title: manga.title,
      coverUrl: manga.cover,
      coverHeaders: headers,
      badge: _WebSourceBadge(sourceId: series.sourceId, source: source),
      actions: _WebActionBar(
        manga: manga,
        series: series,
        link: link,
        source: source,
      ),
      metadata: _WebMetadataList(manga: manga, series: series, source: source),
      tabController: tabController,
      tabs: [
        MangaDetailTab(
          label: tr.mangaView.chapters,
          scrollToTop: true,
          body: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            scrollBehavior: const MouseTouchScrollBehavior(),
            slivers: [
              PinnedHeaderSliver(
                child: _WebChapterHeader(manga: manga, series: series),
              ),
              _WebChapterList(manga: manga, series: series),
            ],
          ),
        ),
        if (hasArtwork)
          MangaDetailTab(
            label: tr.mangaView.art,
            body: _WebMangaCoversView(
              series: series,
              artworkUrls: artworkUrls,
              headers: headers,
            ),
          ),
      ],
      onRefresh: () => _refreshWebManga(ref, series),
      scrollController: chapterScrollController,
      onBack: () => WebMangaViewPage._handleBack(context),
    );
  }
}

Future<(WebManga, HistoryLink)> _refreshWebManga(
  WidgetRef ref,
  WebSeriesRef series,
) async {
  await ref.read(webSourceBrokerProvider).invalidateAll(series.key);
  return ref.refresh(_fetchWebMangaInfoProvider(series).future);
}

class _WebSourceBadge extends StatelessWidget {
  const _WebSourceBadge({required this.sourceId, required this.source});

  final String sourceId;
  final WebSourceInfo? source;

  @override
  Widget build(BuildContext context) {
    final icon = source?.icon;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(sourceId, style: CommonTextStyles.twelveBold),
        if (icon != null && icon.isNotEmpty) ...[
          const SizedBox(width: 6),
          Image.network(icon, width: 24, height: 24),
        ],
      ],
    );
  }
}

class _WebActionBar extends ConsumerWidget {
  const _WebActionBar({
    required this.manga,
    required this.series,
    required this.link,
    required this.source,
  });

  final WebManga manga;
  final WebSeriesRef series;
  final HistoryLink link;
  final WebSourceInfo? source;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tr = context.t;
    final theme = Theme.of(context);

    return OverflowBar(
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
                final key = series.key;
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
                      text: GagakuRoute.webMangaShareUri(
                        sourceId: series.sourceId,
                        mangaId: series.location,
                      ).toString(),
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
  }
}

class _WebMetadataList extends StatelessWidget {
  const _WebMetadataList({
    required this.manga,
    required this.series,
    required this.source,
  });

  final WebManga manga;
  final WebSeriesRef series;
  final WebSourceInfo? source;

  @override
  Widget build(BuildContext context) {
    final tr = context.t;
    final theme = Theme.of(context);

    final extdata = switch (manga) {
      WebMangaCubari() => null,
      WebMangaExtension(:final data) => data,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
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
                    onTap: () =>
                        Clipboard.setData(ClipboardData(text: alttitle))
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
                        backgroundColor: theme.colorScheme.surface.withAlpha(
                          200,
                        ),
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
                        // onPressed: () => ExtensionSearchRoute(
                        //   initialSource: source,
                        //   query: SearchQuery(
                        //     title: '',
                        //     metadata: [
                        //       {
                        //         "id": tagsec.id,
                        //         "value": {tag.id: "included"},
                        //       },
                        //     ],
                        //   ),
                        // ).push(context),
                      ),
                  ],
                ),
            MultiChildExpansionTile(
              title: tr.tracking.links,
              children: [
                if (series case ProxySeriesRef())
                  ButtonChip(
                    onPressed: () async {
                      await Styles.tryLaunchUrl(context, series.externalUrl);
                    },
                    text: tr.mangaView.openOn(arg: 'cubari.moe'),
                  ),
                if (extdata != null)
                  _WebShareChip(series: series, extdata: extdata),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _WebShareChip extends HookConsumerWidget {
  const _WebShareChip({required this.series, required this.extdata});

  final WebSeriesRef series;
  final SourceManga extdata;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tr = context.t;
    final shareUrlHint = extdata.mangaInfo.shareUrl;

    final (sourceId, mangaId) = switch (series) {
      ExtensionSeriesRef(:final sourceId, :final mangaId) => (
        sourceId,
        mangaId,
      ),
      ProxySeriesRef() => (null, null),
    };

    final shareUrlFuture = useMemoized(
      () =>
          sourceId == null ||
              mangaId == null ||
              shareUrlHint != null ||
              sourceId == 'gist'
          ? null
          : ref
                .read(extensionSourceProvider(sourceId).notifier)
                .getMangaURL(mangaId),
      [series, shareUrlHint],
    );
    final shareUrl = useFuture(shareUrlFuture);

    final url = sourceId == null ? null : shareUrlHint ?? shareUrl.data;

    if (url == null || sourceId == null) return const SizedBox.shrink();

    final label = sourceId;

    return ButtonChip(
      onPressed: () async {
        await Styles.tryLaunchUrl(context, url);
      },
      text: tr.mangaView.openOn(arg: label),
    );
  }
}

class _WebChapterHeader extends ConsumerWidget {
  const _WebChapterHeader({required this.manga, required this.series});

  final WebManga manga;
  final WebSeriesRef series;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tr = context.t;

    return Material(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                tr.mangaView.chapters,
                style: CommonTextStyles.twentyfour,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Consumer(
              builder: (context, ref, child) {
                final mangakey = series.key;
                final allRead = ref.watch(
                  webReadMarkersProvider.select(
                    (value) => switch (value) {
                      AsyncValue(value: final db?) => manga.hasAllReadMarkers(
                        db,
                        mangakey,
                      ),
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
                              read: !allRead ? manga.readMarkerKeys : null,
                              unread: allRead
                                  ? manga.removableReadMarkerKeys
                                  : null,
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
  }
}

class _WebChapterList extends HookWidget {
  const _WebChapterList({required this.manga, required this.series});

  final WebManga manga;
  final WebSeriesRef series;

  @override
  Widget build(BuildContext context) {
    final separators = useMemoized(() {
      final chapters = manga.chapters;
      String getName(WebChapterItem c) => c.groupingKey;

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
          if (isStandalone && !isBeforeNewGroup) return _ChapterDivider.none;
          return _ChapterDivider.divider;
        }

        return _ChapterDivider.none;
      });
    }, [manga]);

    return SliverList.separated(
      findItemIndexCallback: (key) {
        final valueKey = key as ValueKey<String>;
        final val = manga.chapters.indexWhere(
          (i) => i.readMarkerKey == valueKey.value,
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
          key: ValueKey(current.readMarkerKey),
          data: current,
          manga: manga,
          series: series,
        );
      },
      itemCount: manga.chapters.length,
    );
  }
}

class _WebMangaCoversView extends StatelessWidget {
  const _WebMangaCoversView({
    required this.series,
    required this.artworkUrls,
    required this.headers,
  });

  final WebSeriesRef series;
  final List<String> artworkUrls;
  final Map<String, String>? headers;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      scrollBehavior: const MouseTouchScrollBehavior(),
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(8.0),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 256,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 0.7,
            ),
            delegate: SliverChildBuilderDelegate((context, index) {
              final heroTag = _webArtworkHeroTag(
                series,
                index,
                artworkUrls[index],
              );
              return CoverArtGridItem(
                key: ValueKey(heroTag),
                url: artworkUrls[index],
                headers: headers,
                heroTag: heroTag,
                onTap: () => Navigator.push(
                  context,
                  TransparentOverlay(
                    builder: (context) => CoverArtPagedOverlay(
                      index: index,
                      headers: headers,
                      items: [
                        for (final (i, url) in artworkUrls.indexed)
                          (
                            url: url,
                            heroTag: _webArtworkHeroTag(series, i, url),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            }, childCount: artworkUrls.length),
          ),
        ),
      ],
    );
  }
}

String _webArtworkHeroTag(WebSeriesRef series, int index, String url) =>
    '${series.key}/artwork/$index/$url';

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
