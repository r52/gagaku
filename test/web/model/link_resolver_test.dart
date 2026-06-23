import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/web/model/link_resolver.dart';
import 'package:gagaku/web/model/model.dart';
import 'package:gagaku/web/model/source_adapter.dart';
import 'package:gagaku/web/model/types.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

void main() {
  setUpAll(() {
    logger = Logger(level: Level.off);
  });

  late _FakeRedirectTransport redirects;
  late WebLinkResolver resolver;
  late List<String> extensionChecks;

  setUp(() {
    redirects = _FakeRedirectTransport();
    extensionChecks = [];
    resolver = WebLinkResolver(
      extensionExists: (sourceId) async {
        extensionChecks.add(sourceId);
        return sourceId == 'installed';
      },
      redirectTransport: redirects,
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
    expect(extensionChecks, ['installed']);
    expect(redirects.requests, isEmpty);
  });

  test('rejects missing, malformed, and external extension links', () async {
    expect(await resolver.resolve('missing/manga-1'), isNull);
    expect(await resolver.resolve('installed'), isNull);
    expect(await resolver.resolve('https://example.com/manga-1'), isNull);
    expect(extensionChecks, ['missing']);
    expect(redirects.requests, isEmpty);
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
    expect(redirects.requests, isEmpty);
  });

  test('resolves a Cubari redirect through the injected transport', () async {
    redirects.enqueue(Uri.parse('/read/gist/series-1/7/'));

    final resolved = await resolver.resolve('https://cubari.moe/legacy-link');

    expect(
      resolved,
      const ResolvedWebLink(
        series: WebSeriesRef.proxy(proxyId: 'gist', seriesId: 'series-1'),
        initialChapterId: '7',
      ),
    );
    expect(redirects.requests, [Uri.parse('https://cubari.moe/legacy-link')]);
  });

  test('production redirect adapter disables automatic redirects', () async {
    final transport = _RecordingWebSourceTransport(
      statusCode: 302,
      location: '/read/gist/series-1/7/',
    );
    final container = ProviderContainer(
      overrides: [webSourceTransportProvider.overrideWithValue(transport)],
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
    expect(transport.followRedirects, isFalse);
  });

  test('rejects redirects outside Cubari read paths', () async {
    redirects.enqueue(Uri.parse('https://example.com/not-supported'));
    expect(await resolver.resolve('https://cubari.moe/legacy-link'), isNull);

    redirects.enqueue(Uri.parse('/not-a-read-path'));
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
    expect(redirects.requests, isEmpty);
    expect(extensionChecks, isEmpty);
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
    expect(resolved.requireSeries.toLegacySourceHandler().chapter, isNull);
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

class _FakeRedirectTransport implements WebLinkRedirectTransport {
  final Queue<Uri?> _responses = Queue();
  final List<Uri> requests = [];

  void enqueue(Uri? uri) {
    _responses.add(uri);
  }

  @override
  Future<Uri?> resolveRedirect(Uri uri) async {
    requests.add(uri);
    return _responses.isEmpty ? null : _responses.removeFirst();
  }
}

class _RecordingWebSourceTransport implements WebSourceTransport {
  _RecordingWebSourceTransport({
    required this.statusCode,
    required this.location,
  });

  final int statusCode;
  final String location;
  bool? followRedirects;

  @override
  Future<Response<dynamic>> getUri(
    Uri uri, {
    bool followRedirects = true,
  }) async {
    this.followRedirects = followRedirects;
    return Response<dynamic>(
      requestOptions: RequestOptions(path: uri.toString()),
      statusCode: statusCode,
      headers: Headers.fromMap({
        'location': [location],
      }),
    );
  }
}
