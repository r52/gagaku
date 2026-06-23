import 'package:flutter_test/flutter_test.dart';
import 'package:gagaku/web/model/types.dart';

void main() {
  group('WebSeriesRef', () {
    test('proxy references expose stable series identity', () {
      const reference = WebSeriesRef.proxy(
        proxyId: 'imgur',
        seriesId: 'album-1',
      );

      expect(reference.key, 'imgur/album-1');
      expect(reference.sourceId, 'imgur');
      expect(reference.location, 'album-1');
      expect(reference.externalUrl, 'https://cubari.moe/read/imgur/album-1/');
      expect(reference.toJson(), {
        'type': 'proxy',
        'proxyId': 'imgur',
        'seriesId': 'album-1',
      });
      expect(WebSeriesRef.fromJson(reference.toJson()), reference);
    });

    test('extension references expose stable series identity', () {
      const reference = WebSeriesRef.extension(
        sourceId: 'source-1',
        mangaId: 'manga-1',
      );

      expect(reference.key, 'source-1/manga-1');
      expect(reference.sourceId, 'source-1');
      expect(reference.location, 'manga-1');
      expect(reference.externalUrl, 'source-1/manga-1');
      expect(reference.toJson(), {
        'type': 'extension',
        'sourceId': 'source-1',
        'mangaId': 'manga-1',
      });
      expect(WebSeriesRef.fromJson(reference.toJson()), reference);
    });

    test('legacy handle JSON is not part of the public model', () {
      const reference = WebSeriesRef.proxy(
        proxyId: 'gist',
        seriesId: 'series-1',
      );

      expect(reference.toJson(), isNot(containsPair('sourceId', 'gist')));
      expect(reference.toJson(), isNot(containsPair('location', 'series-1')));
    });
  });

  group('WebChapterRef', () {
    test('separates transient chapter identity from the series', () {
      const reference = WebChapterRef(
        series: WebSeriesRef.extension(
          sourceId: 'source-1',
          mangaId: 'manga-1',
        ),
        chapterId: 'chapter-1',
      );

      expect(reference.series.key, 'source-1/manga-1');
      expect(reference.chapterId, 'chapter-1');
      expect(reference.toJson(), {
        'series': {
          'type': 'extension',
          'sourceId': 'source-1',
          'mangaId': 'manga-1',
        },
        'chapterId': 'chapter-1',
      });
      expect(WebChapterRef.fromJson(reference.toJson()), reference);
    });

    test('does not expose legacy handle conversion', () {
      const reference = WebChapterRef(
        series: WebSeriesRef.proxy(proxyId: 'gist', seriesId: 'series-1'),
        chapterId: '7',
      );

      expect(reference.toJson(), {
        'series': {'type': 'proxy', 'proxyId': 'gist', 'seriesId': 'series-1'},
        'chapterId': '7',
      });
    });
  });

  group('ResolvedWebLink', () {
    test('preserves a direct chapter only as initial navigation state', () {
      const resolved = ResolvedWebLink(
        series: WebSeriesRef.proxy(proxyId: 'imgur', seriesId: 'album-1'),
        initialChapterId: '1',
      );

      expect(
        resolved.series,
        const WebSeriesRef.proxy(proxyId: 'imgur', seriesId: 'album-1'),
      );
      expect(resolved.initialChapterId, '1');
      expect(
        resolved.initialChapter,
        const WebChapterRef(
          series: WebSeriesRef.proxy(proxyId: 'imgur', seriesId: 'album-1'),
          chapterId: '1',
        ),
      );
      expect(ResolvedWebLink.fromJson(resolved.toJson()), resolved);
    });

    test('series links do not synthesize a chapter request', () {
      const resolved = ResolvedWebLink(
        series: WebSeriesRef.extension(
          sourceId: 'source-1',
          mangaId: 'manga-1',
        ),
      );

      expect(resolved.initialChapterId, isNull);
      expect(resolved.initialChapter, isNull);
      expect(resolved.toJson(), {
        'series': {
          'type': 'extension',
          'sourceId': 'source-1',
          'mangaId': 'manga-1',
        },
        'initialChapterId': null,
      });
    });
  });
}
