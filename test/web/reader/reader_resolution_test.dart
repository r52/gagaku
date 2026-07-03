import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/model/cache.dart';
import 'package:gagaku/model/model.dart';
import 'package:gagaku/objectbox.g.dart';
import 'package:gagaku/web/model/extension_runtime.dart';
import 'package:gagaku/web/model/model.dart';
import 'package:gagaku/web/model/source_adapter.dart';
import 'package:gagaku/web/model/types.dart';
import 'package:gagaku/web/reader.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

void main() {
  late Store store;

  setUpAll(() {
    logger = Logger(level: Level.off);
    store = Store(
      getObjectBoxModel(),
      directory: 'memory:gagaku_reader_resolution_test_db',
    );
    GagakuData().store = store;
  });

  setUp(() {
    store.box<HistoryLink>().removeAll();
    store.box<WebFavoritesList>().removeAll();
    store.box<WebFavoritesList>().put(
      WebFavoritesList(id: historyListUUID, name: 'extension_history'),
    );
  });

  tearDownAll(() {
    store.close();
  });

  test('direct Imgur ingress resolves typed pages and releases them', () async {
    final transport = _StaticTransport([
      {'description': 'Page 1', 'src': 'https://example.com/1.jpg'},
      {'description': 'Page 2', 'src': 'https://example.com/2.jpg'},
    ]);
    final broker = WebSourceBroker(
      cache: _MemoryCacheManager(),
      proxyAdapter: ProxyWebSourceAdapter(transport: transport),
      extensionAdapter: ExtensionWebSourceAdapter(
        fetchManga: (_, _) => throw UnimplementedError(),
        fetchChapterContent: (_, _) => throw UnimplementedError(),
      ),
    );
    final container = ProviderContainer(
      overrides: [webSourceBrokerProvider.overrideWithValue(broker)],
    );
    final chapter = const WebChapterRef(
      series: WebSeriesRef.proxy(proxyId: 'imgur', seriesId: 'album-1'),
      chapterId: '1',
    );

    final resolved = await container.read(
      resolveWebChapterProvider(chapter).future,
    );

    expect(resolved.chapter, chapter);
    expect(resolved.title, 'album-1');
    expect(resolved.seriesTitle, isNull);
    expect(resolved.readMarkerKey, '1');
    final content = resolved.content;
    expect(content, isA<ResolvedImageWebChapterContent>());
    final pages = (content as ResolvedImageWebChapterContent).pages;
    expect(pages.map((page) => (page.provider as NetworkImage).url), [
      'https://example.com/1.jpg',
      'https://example.com/2.jpg',
    ]);
    expect(
      transport.requested,
      Uri.parse('https://cubari.moe/read/api/imgur/chapter/album-1'),
    );

    container.dispose();
    expect(pages, isEmpty);
  });

  test('extension HTML chapter resolves as HTML content', () async {
    const sourceManga = SourceManga(
      mangaId: 'novel-1',
      mangaInfo: MangaInfo(
        thumbnailUrl: 'https://example.com/cover.jpg',
        synopsis: 'Words.',
        primaryTitle: 'Novel Series',
        secondaryTitles: [],
        contentRating: ContentRating.EVERYONE,
        contentType: MangaContentType.novel,
      ),
    );
    const chapter = Chapter(
      chapterId: 'chapter-1',
      sourceManga: sourceManga,
      langCode: 'en',
      chapNum: 1,
      title: 'Chapter One',
    );
    const html = '<main><p>Chapter text</p><img src="/image.jpg"></main>';
    const sourceBaseUrl = 'https://example.com/novel/';
    final broker = WebSourceBroker(
      cache: _MemoryCacheManager(),
      proxyAdapter: ProxyWebSourceAdapter(transport: _StaticTransport([])),
      extensionAdapter: ExtensionWebSourceAdapter(
        fetchManga: (_, _) async => const WebManga.extension(
          data: sourceManga,
          chaptersList: [chapter],
        ),
        fetchChapterContent: (_, _) async => ExtensionChapterContent(
          runtime: _FakeExtensionRuntime(),
          details: const ChapterDetails.html(
            id: 'chapter-1',
            mangaId: 'novel-1',
            html: html,
          ),
          sourceBaseUrl: sourceBaseUrl,
        ),
      ),
    );
    final container = ProviderContainer(
      overrides: [webSourceBrokerProvider.overrideWithValue(broker)],
    );
    const chapterRef = WebChapterRef(
      series: WebSeriesRef.extension(sourceId: 'source-1', mangaId: 'novel-1'),
      chapterId: 'chapter-1',
    );

    final resolved = await container.read(
      resolveWebChapterProvider(chapterRef).future,
    );

    expect(resolved.chapter, chapterRef);
    expect(resolved.title, 'Chapter One');
    expect(resolved.seriesTitle, 'Novel Series');
    expect(resolved.readMarkerKey, 'chapter-1');
    final content = resolved.content;
    expect(content, isA<ResolvedHtmlWebChapterContent>());
    final htmlContent = content as ResolvedHtmlWebChapterContent;
    expect(htmlContent.html, html);
    expect(htmlContent.sourceBaseUrl, sourceBaseUrl);

    container.dispose();
  });
}

class _StaticTransport implements WebSourceTransport {
  _StaticTransport(this.data);

  final Object data;
  Uri? requested;

  @override
  Future<Response<dynamic>> getUri(
    Uri uri, {
    bool followRedirects = true,
  }) async {
    requested = uri;
    return Response<dynamic>(
      requestOptions: RequestOptions(path: uri.toString()),
      statusCode: 200,
      data: data,
    );
  }
}

class _MemoryCacheManager implements CacheManager {
  final Map<String, Object?> values = {};

  @override
  Future<bool> exists(String key) async => values.containsKey(key);

  @override
  T get<T>(String key, [UnserializeCallback? unserializer]) => values[key] as T;

  @override
  Future<T> put<T>(
    String key,
    String data,
    T reference, {
    Duration expiry = const Duration(minutes: 15),
    UnserializeCallback? unserializer,
  }) async {
    values[key] = reference;
    return reference;
  }

  @override
  Future<void> remove(String key) async {
    values.remove(key);
  }

  @override
  Future<void> invalidateAll(String startsWith) async {
    values.removeWhere((key, _) => key.startsWith(startsWith));
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeExtensionRuntime implements ExtensionRuntime {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
