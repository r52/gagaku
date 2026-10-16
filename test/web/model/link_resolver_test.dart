import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/web/model/link_resolver.dart';
import 'package:gagaku/web/model/model.dart';
import 'package:gagaku/web/model/types.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

void main() {
  setUpAll(() {
    logger = Logger(level: Level.off);
  });

  late Dio dio;
  late Queue<({int statusCode, String? location})> responses;
  late List<RequestOptions> requests;
  late WebLinkResolver resolver;

  setUp(() {
    responses = Queue();
    requests = [];
    dio = Dio(BaseOptions(validateStatus: (_) => true));
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          requests.add(options);
          final response = responses.isEmpty
              ? (statusCode: 404, location: null)
              : responses.removeFirst();
          handler.resolve(
            Response<dynamic>(
              requestOptions: options,
              statusCode: response.statusCode,
              headers: Headers.fromMap({
                if (response.location case final location?)
                  'location': [location],
              }),
            ),
          );
        },
      ),
    );
    addTearDown(dio.close);
    resolver = WebLinkResolver(
      extensionExists: (sourceId) async => sourceId == 'installed',
      dio: dio,
    );
  });

  test('resolves an installed extension series without a redirect', () async {
    final resolved = await resolver.resolve('installed/manga-1');

    expect(
      resolved,
      const ResolvedWebLink(
        series: WebSeriesRef.extension(
          sourceId: 'installed',
          mangaId: 'manga-1',
        ),
      ),
    );
    expect(requests, isEmpty);
  });

  test('rejects missing, malformed, and external extension links', () async {
    expect(await resolver.resolve('missing/manga-1'), isNull);
    expect(await resolver.resolve('installed'), isNull);
    expect(await resolver.resolve('https://example.com/manga-1'), isNull);
    expect(requests, isEmpty);
  });

  test('resolves Cubari series and direct chapter links', () async {
    final series = await resolver.resolve(
      'https://cubari.moe/read/imgur/album/',
    );
    final chapter = await resolver.resolve(
      'https://cubari.moe/read/imgur/album/4/',
    );

    expect(
      series,
      const ResolvedWebLink(
        series: WebSeriesRef.proxy(proxyId: 'imgur', seriesId: 'album'),
      ),
    );
    expect(
      chapter,
      const ResolvedWebLink(
        series: WebSeriesRef.proxy(proxyId: 'imgur', seriesId: 'album'),
        initialChapterId: '4',
      ),
    );
    expect(requests, isEmpty);
  });

  test(
    'resolves Cubari redirects without automatically following them',
    () async {
      responses.add((statusCode: 302, location: '/read/gist/series-1/7/'));
      final container = ProviderContainer(
        overrides: [webSourceDioProvider.overrideWithValue(dio)],
      );
      addTearDown(container.dispose);

      final resolved = await container
          .read(webLinkResolverProvider)
          .resolve('https://cubari.moe/legacy-link');

      expect(
        resolved,
        const ResolvedWebLink(
          series: WebSeriesRef.proxy(proxyId: 'gist', seriesId: 'series-1'),
          initialChapterId: '7',
        ),
      );
      expect(requests.single.uri, Uri.parse('https://cubari.moe/legacy-link'));
      expect(requests.single.followRedirects, isFalse);
    },
  );

  test('ignores Location headers on non-redirect responses', () async {
    responses.add((statusCode: 200, location: '/read/gist/series-1/7/'));
    expect(await resolver.resolve('https://cubari.moe/legacy-link'), isNull);
  });

  test('rejects redirects outside Cubari read paths', () async {
    responses.add((
      statusCode: 302,
      location: 'https://example.com/not-supported',
    ));
    expect(await resolver.resolve('https://cubari.moe/legacy-link'), isNull);

    responses.add((statusCode: 302, location: '/not-a-read-path'));
    expect(await resolver.resolve('https://cubari.moe/another-link'), isNull);
  });

  test('normalizes Imgur as a one-chapter proxy ingress', () async {
    final resolved = await resolver.resolve('https://imgur.com/a/album-1');

    expect(
      resolved,
      const ResolvedWebLink(
        series: WebSeriesRef.proxy(proxyId: 'imgur', seriesId: 'album-1'),
        initialChapterId: '1',
      ),
    );
    expect(requests, isEmpty);
  });

  test('rejects malformed Imgur and Cubari links', () async {
    expect(await resolver.resolve('https://imgur.com/album-1'), isNull);
    expect(await resolver.resolve('https://imgur.com/a/'), isNull);
    expect(await resolver.resolve('https://cubari.moe/read/gist/'), isNull);
  });

  test('aggregate link resolution persists only the series', () async {
    final link = HistoryLink(
      title: 'Series',
      url: 'https://cubari.moe/read/gist/series-1/7/',
    );

    final resolved = await resolver.resolveHistoryLink(link);

    expect(
      resolved.series,
      const WebSeriesRef.proxy(proxyId: 'gist', seriesId: 'series-1'),
    );
    expect(resolved.dbHandle, isNot(contains('chapter')));
  });

  test(
    'aggregate link resolution leaves known and unsupported links alone',
    () async {
      final known = HistoryLink.fromSeries(
        title: 'Known',
        series: const WebSeriesRef.extension(
          sourceId: 'installed',
          mangaId: 'manga-1',
        ),
      );
      final unsupported = HistoryLink(
        title: 'Unsupported',
        url: 'https://example.com/nope',
      );

      expect(await resolver.resolveHistoryLink(known), same(known));
      expect(await resolver.resolveHistoryLink(unsupported), unsupported);
    },
  );
}
