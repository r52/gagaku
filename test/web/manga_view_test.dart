import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/model/cache.dart';
import 'package:gagaku/model/model.dart';
import 'package:gagaku/objectbox.g.dart';
import 'package:gagaku/web/manga_view.dart';
import 'package:gagaku/web/model/config.dart';
import 'package:gagaku/web/model/model.dart';
import 'package:gagaku/web/model/source_adapter.dart';
import 'package:gagaku/web/model/types.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

void main() {
  late Store store;

  setUpAll(() async {
    logger = Logger(level: Level.off);
    await LocaleSettings.setLocale(AppLocale.en);
    store = Store(
      getObjectBoxModel(),
      directory: 'memory:gagaku_web_manga_view_test_db',
    );
    GagakuData().store = store;
  });

  setUp(() {
    store.box<ExtensionConfig>().removeAll();
    store.box<HistoryLink>().removeAll();
    store.box<WebFavoritesList>().removeAll();
    store.box<WebFavoritesList>().put(
      WebFavoritesList(id: historyListUUID, name: 'extension_history'),
    );
  });

  tearDownAll(() {
    store.close();
  });

  for (final testCase in [
    (name: 'narrow', size: const Size(600, 800)),
    (name: 'wide', size: const Size(1200, 800)),
  ]) {
    testWidgets('artwork-enabled ${testCase.name} layout can pull to refresh', (
      tester,
    ) async {
      tester.view.devicePixelRatio = 1.0;
      tester.view.physicalSize = testCase.size;
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.view.resetPhysicalSize);

      const series = WebSeriesRef.extension(
        sourceId: 'source-1',
        mangaId: 'manga-1',
      );
      const sourceManga = SourceManga(
        mangaId: 'manga-1',
        mangaInfo: MangaInfo(
          thumbnailUrl: 'https://example.invalid/cover.jpg',
          synopsis: 'Test synopsis',
          primaryTitle: 'Artwork title',
          secondaryTitles: [],
          contentRating: ContentRating.EVERYONE,
          artworkUrls: ['https://example.invalid/art.jpg'],
        ),
      );
      const manga = WebManga.extension(data: sourceManga, chaptersList: []);
      final cache = _RecordingCacheManager();
      final broker = WebSourceBroker(
        cache: cache,
        proxyAdapter: ProxyWebSourceAdapter(
          transport: _StaticTransport(const {}),
        ),
        extensionAdapter: ExtensionWebSourceAdapter(
          fetchManga: (_, _) async => manga,
          fetchChapterContent: (_, _) => throw UnimplementedError(),
        ),
      );
      final link = HistoryLink.fromSeries(title: manga.title, series: series);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [webSourceBrokerProvider.overrideWithValue(broker)],
          child: TranslationProvider(
            child: MaterialApp(
              home: WebMangaViewWidget(
                manga: manga,
                series: series,
                link: link,
              ),
            ),
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(TabBarView), findsNothing);
      expect(find.byType(CustomScrollView), findsOneWidget);

      await tester.fling(
        find.byType(CustomScrollView),
        const Offset(0, 300),
        1000,
      );
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));
      await tester.pump(const Duration(seconds: 1));
      await tester.pump(const Duration(seconds: 1));

      expect(cache.invalidations, 1);
    });
  }
}

class _StaticTransport implements WebSourceTransport {
  const _StaticTransport(this.data);

  final Object data;

  @override
  Future<Response<dynamic>> getUri(
    Uri uri, {
    bool followRedirects = true,
  }) async {
    return Response<dynamic>(
      requestOptions: RequestOptions(path: uri.toString()),
      statusCode: 200,
      data: data,
    );
  }
}

class _RecordingCacheManager implements CacheManager {
  final Map<String, Object?> values = {};
  int invalidations = 0;

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
    invalidations++;
    values.removeWhere((key, _) => key.startsWith(startsWith));
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
