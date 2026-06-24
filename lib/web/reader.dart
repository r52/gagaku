import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/reader/main.dart';
import 'package:gagaku/reader/model/types.dart';
import 'package:gagaku/util/exception.dart';
import 'package:gagaku/util/riverpod.dart';
import 'package:gagaku/util/ui.dart';
import 'package:gagaku/util/util.dart';
import 'package:gagaku/web/model/config.dart';
import 'package:gagaku/web/model/extension_image.dart';
import 'package:gagaku/web/model/model.dart';
import 'package:gagaku/web/model/types.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'reader.g.dart';

WebChapterRef proxyReaderRouteRef({
  required String proxy,
  required String code,
  required String chapter,
}) {
  return WebChapterRef(
    series: WebSeriesRef.proxy(proxyId: proxy, seriesId: code),
    chapterId: chapter.replaceFirst('-', '.'),
  );
}

WebChapterRef extensionReaderRouteRef({
  required String sourceId,
  required String mangaId,
  required String chapterId,
}) {
  return WebChapterRef(
    series: WebSeriesRef.extension(sourceId: sourceId, mangaId: mangaId),
    chapterId: chapterId,
  );
}

class ResolvedWebChapter {
  const ResolvedWebChapter({
    required this.chapter,
    required this.title,
    required this.seriesTitle,
    required this.readMarkerKey,
    required this.pages,
  });

  final WebChapterRef chapter;
  final String title;
  final String? seriesTitle;
  final String readMarkerKey;
  final List<ReaderPage> pages;
}

@Riverpod(retry: noRetry)
Future<ResolvedWebChapter> resolveWebChapter(
  Ref ref,
  WebChapterRef chapterRef,
) async {
  final api = ref.watch(webSourceBrokerProvider);
  final series = chapterRef.series;

  if (series case ProxySeriesRef(proxyId: 'imgur', :final seriesId)) {
    final data = await api.getProxyAPI('/read/api/imgur/chapter/$seriesId');
    return ResolvedWebChapter(
      chapter: chapterRef,
      title: seriesId,
      seriesTitle: null,
      readMarkerKey: chapterRef.chapterId,
      pages: await _networkReaderPages(ref, data),
    );
  }

  final manga = await api.getManga(series);
  if (manga == null) {
    throw InvalidDataException('Invalid WebManga link. Data not found.');
  }

  await WebHistoryManager().record(
    HistoryLink.fromSeries(
      title: manga.title,
      cover: manga.cover,
      series: series,
      lastAccessed: DateTime.now(),
    ),
    preserveHistory: ref.read(webConfigProvider).preserveHistory,
  );

  final chapter = manga.getChapter(chapterRef.chapterId);
  if (chapter == null) {
    throw InvalidDataException('Invalid WebChapter link. Data not found.');
  }

  final (readMarkerKey, pages) = switch (chapter) {
    WebChapterItemCubari(:final entry) => (
      entry.name,
      await _networkReaderPages(ref, entry.chapter.groups.entries.first.value),
    ),
    WebChapterItemExtension(chapter: final extensionChapter) => (
      extensionChapter.chapNum.toString(),
      await _extensionReaderPages(
        ref,
        series as ExtensionSeriesRef,
        extensionChapter,
      ),
    ),
  };

  return ResolvedWebChapter(
    chapter: chapterRef,
    title: chapter.title,
    seriesTitle: manga.title,
    readMarkerKey: readMarkerKey,
    pages: pages,
  );
}

Future<List<ReaderPage>> _networkReaderPages(Ref ref, Object? source) async {
  if (source is String &&
      (source.startsWith('/read/') || source.startsWith('/proxy/'))) {
    source = await ref.watch(webSourceBrokerProvider).getProxyAPI(source);
  }

  if (source is! List) {
    throw InvalidDataException('Unknown page data type ($source)');
  }

  final links = source.isEmpty
      ? <String>[]
      : source.first is String
      ? List<String>.from(source)
      : source
            .map((page) => ImgurPage.fromJson(Map<String, dynamic>.from(page)))
            .map((page) => page.src)
            .toList();
  final pages = [
    for (final link in links) ReaderPage(provider: NetworkImage(link)),
  ];

  ref.onDispose(pages.clear);
  return pages;
}

Future<List<ReaderPage>> _extensionReaderPages(
  Ref ref,
  ExtensionSeriesRef series,
  Chapter chapter,
) async {
  final result = await ref
      .watch(webSourceBrokerProvider)
      .getExtensionChapterPages(series, chapter);
  final pages = [
    for (final link in result.links)
      ReaderPage(provider: ExtensionImage(link, result.runtime)),
  ];

  ref.onDispose(pages.clear);
  return pages;
}

class WebSourceReaderPage extends StatelessWidget {
  const WebSourceReaderPage({super.key, required this.chapter});

  final WebChapterRef chapter;

  @override
  Widget build(BuildContext context) {
    return DataProviderWhenWidget(
      provider: resolveWebChapterProvider(chapter),
      loadingBuilder: (context, progress) => Scaffold(
        appBar: AppBar(leading: const BackButton()),
        body: Center(
          child: CircularProgressIndicator(value: progress?.toDouble()),
        ),
      ),
      errorBuilder: (context, child, _, _) => Scaffold(
        appBar: AppBar(leading: const BackButton()),
        body: child,
      ),
      builder: (context, data) => WebSourceReaderWidget(data: data),
    );
  }
}

class WebSourceReaderWidget extends HookConsumerWidget {
  const WebSourceReaderWidget({super.key, required this.data});

  final ResolvedWebChapter data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timer = useRef<Timer?>(null);

    useEffect(() {
      timer.value?.cancel();
      timer.value = Timer(const Duration(milliseconds: 2000), () {
        ref.run((tsx) async {
          return tsx
              .get(webReadMarkersProvider.notifier)
              .set(data.chapter.series.key, data.readMarkerKey, true);
        });
      });

      return () => timer.value?.cancel();
    }, [data.chapter, data.readMarkerKey]);

    return ReaderWidget(
      pages: data.pages,
      title: data.title,
      longstrip: false,
      drawerHeader: data.seriesTitle,
    );
  }
}
