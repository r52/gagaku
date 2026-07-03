import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/reader/main.dart';
import 'package:gagaku/reader/model/types.dart';
import 'package:gagaku/util/exception.dart';
import 'package:gagaku/util/riverpod.dart';
import 'package:gagaku/util/ui.dart';
import 'package:gagaku/util/util.dart';
import 'package:gagaku/web/html_reader.dart';
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
    required this.content,
  });

  final WebChapterRef chapter;
  final String title;
  final String? seriesTitle;
  final String readMarkerKey;
  final ResolvedWebChapterContent content;
}

sealed class ResolvedWebChapterContent {
  const ResolvedWebChapterContent();
}

final class ResolvedImageWebChapterContent extends ResolvedWebChapterContent {
  const ResolvedImageWebChapterContent(this.pages);

  final List<ReaderPage> pages;
}

final class ResolvedHtmlWebChapterContent extends ResolvedWebChapterContent {
  const ResolvedHtmlWebChapterContent({
    required this.html,
    required this.sourceBaseUrl,
  });

  final String html;
  final String? sourceBaseUrl;
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
      content: ResolvedImageWebChapterContent(
        await _networkReaderPages(ref, api, data),
      ),
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

  final (readMarkerKey, content) = switch (chapter) {
    WebChapterItemCubari(:final entry) => (
      entry.name,
      ResolvedImageWebChapterContent(
        await _networkReaderPages(
          ref,
          api,
          entry.chapter.groups.entries.first.value,
        ),
      ),
    ),
    WebChapterItemExtension(chapter: final extensionChapter) => (
      extensionChapter.chapNum.toString(),
      await _extensionReaderContent(
        ref,
        api,
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
    content: content,
  );
}

Future<List<ReaderPage>> _networkReaderPages(
  Ref ref,
  WebSourceBroker api,
  Object? source,
) async {
  if (source is String &&
      (source.startsWith('/read/') || source.startsWith('/proxy/'))) {
    source = await api.getProxyAPI(source);
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

Future<ResolvedWebChapterContent> _extensionReaderContent(
  Ref ref,
  WebSourceBroker api,
  ExtensionSeriesRef series,
  Chapter chapter,
) async {
  final result = await api.getExtensionChapterContent(series, chapter);
  return switch (result.details) {
    ImageChapterDetails(:final pages) => () {
      final readerPages = [
        for (final link in pages)
          ReaderPage(provider: ExtensionImage(link, result.runtime)),
      ];

      ref.onDispose(readerPages.clear);
      return ResolvedImageWebChapterContent(readerPages);
    }(),
    HtmlChapterDetails(:final html) => ResolvedHtmlWebChapterContent(
      html: html,
      sourceBaseUrl: result.sourceBaseUrl,
    ),
    FileChapterDetails() => throw UnsupportedError(
      'File chapters are not supported',
    ),
  };
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

    return switch (data.content) {
      ResolvedImageWebChapterContent(:final pages) => ReaderWidget(
        pages: pages,
        title: data.title,
        longstrip: false,
        drawerHeader: data.seriesTitle,
      ),
      ResolvedHtmlWebChapterContent(:final html, :final sourceBaseUrl) =>
        HtmlChapterReaderWidget(
          html: html,
          title: data.title,
          seriesTitle: data.seriesTitle,
          sourceBaseUrl: sourceBaseUrl,
        ),
    };
  }
}
