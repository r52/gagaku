import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/model/cache.dart';
import 'package:gagaku/model/model.dart';
import 'package:gagaku/objectbox.g.dart';
import 'package:gagaku/web/model/extension_runtime.dart';
import 'package:gagaku/web/model/model.dart';
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
    Uri? requested;
    final dio = Dio();
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          requested = options.uri;
          handler.resolve(
            Response<dynamic>(
              requestOptions: options,
              statusCode: 200,
              data: [
                {'description': 'Page 1', 'src': 'https://example.com/1.jpg'},
                {'description': 'Page 2', 'src': 'https://example.com/2.jpg'},
              ],
            ),
          );
        },
      ),
    );
    addTearDown(dio.close);
    final container = ProviderContainer(
      overrides: [
        cacheProvider.overrideWithValue(_MemoryCacheManager()),
        webSourceDioProvider.overrideWithValue(dio),
      ],
    );
    final chapter = const WebChapterRef(
      series: WebSeriesRef.proxy(proxyId: 'imgur', seriesId: 'album-1'),
      chapterId: '1',
    );

    final subscription = container.listen(
      resolveWebChapterProvider(chapter).future,
      (_, _) {},
    );
    final resolved = await subscription.read();

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
      requested,
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
    final dio = Dio();
    addTearDown(dio.close);
    final container = ProviderContainer(
      overrides: [
        cacheProvider.overrideWithValue(_MemoryCacheManager()),
        webSourceDioProvider.overrideWithValue(dio),
        extensionSourceProvider('source-1').overrideWith(
          () => _HtmlExtensionSource(
            manga: const WebManga.extension(
              data: sourceManga,
              chaptersList: [chapter],
            ),
            details: const ChapterDetails.html(
              id: 'chapter-1',
              mangaId: 'novel-1',
              html: html,
            ),
            baseUrl: sourceBaseUrl,
          ),
        ),
      ],
    );
    const chapterRef = WebChapterRef(
      series: WebSeriesRef.extension(sourceId: 'source-1', mangaId: 'novel-1'),
      chapterId: 'chapter-1',
    );

    final subscription = container.listen(
      resolveWebChapterProvider(chapterRef).future,
      (_, _) {},
    );
    final resolved = await subscription.read();

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

class _HtmlExtensionSource extends ExtensionSource {
  _HtmlExtensionSource({
    required this.manga,
    required this.details,
    required this.baseUrl,
  });

  final WebManga manga;
  final ChapterDetails details;
  final String baseUrl;
  final ExtensionRuntime _runtime = _FakeExtensionRuntime();

  @override
  Future<WebSourceInfo> build(String sourceId) async => WebSourceInfo(
    id: sourceId,
    name: 'Test source',
    repo: 'test',
    icon: '',
    baseUrl: baseUrl,
  );

  @override
  Future<WebManga?> getManga(String mangaId) async => manga;

  @override
  Future<ChapterDetails> getChapterDetails(Chapter chapter) async => details;

  @override
  Future<ExtensionRuntime> getRuntime() async => _runtime;
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
