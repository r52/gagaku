import 'package:flutter_test/flutter_test.dart';
import 'package:gagaku/web/model/tracking_types.dart';
import 'package:gagaku/web/model/types.dart';

void main() {
  group('TrackedSeriesRef', () {
    const uuid = '9a4ec8a0-0000-4000-8000-000000000001';
    const extensionSeries = TrackedSeriesRef.web(
      WebSeriesRef.extension(sourceId: 'mangadex', mangaId: uuid),
    );
    const nativeSeries = TrackedSeriesRef.nativeMangaDex(uuid);

    test('round-trips every variant through the versioned codec', () {
      const proxySeries = TrackedSeriesRef.web(
        WebSeriesRef.proxy(proxyId: 'gist', seriesId: 'fictional-gist'),
      );

      for (final ref in [extensionSeries, nativeSeries, proxySeries]) {
        final encoded = TrackedSeriesRefCodec.encode(ref);
        expect(encoded['version'], TrackedSeriesRefCodec.version);
        expect(TrackedSeriesRefCodec.decode(encoded), ref);
      }
    });

    test('keeps a mangadex extension title distinct from a native title', () {
      expect(extensionSeries.key, 'web:mangadex/$uuid');
      expect(nativeSeries.key, 'native-mangadex:$uuid');
      expect(extensionSeries.key, isNot(nativeSeries.key));

      expect(extensionSeries.chapterSourceId, 'mangadex');
      expect(nativeSeries.chapterSourceId, nativeMangaDexSourceId);
      expect(extensionSeries.chapterMangaId, nativeSeries.chapterMangaId);
      expect(extensionSeries, isNot(nativeSeries));
    });

    test('reserves a source id that cannot be a JS identifier', () {
      final identifier = RegExp(r'^[A-Za-z_$][A-Za-z0-9_$]*$');
      expect(identifier.hasMatch(nativeMangaDexSourceId), isFalse);
    });

    test('rejects unknown versions, kinds, and malformed payloads', () {
      expect(
        () => TrackedSeriesRefCodec.decode({
          'version': 99,
          'kind': 'native-mangadex',
          'mangaId': uuid,
        }),
        throwsFormatException,
      );
      expect(
        () => TrackedSeriesRefCodec.decode({'version': 1, 'kind': 'other'}),
        throwsFormatException,
      );
      expect(
        () => TrackedSeriesRefCodec.decode({
          'version': 1,
          'kind': 'native-mangadex',
          'mangaId': '',
        }),
        throwsFormatException,
      );
      expect(
        () => TrackedSeriesRefCodec.decode({'version': 1, 'kind': 'web'}),
        throwsFormatException,
      );
      expect(() => TrackedSeriesRefCodec.decode('web'), throwsFormatException);
    });
  });
}
