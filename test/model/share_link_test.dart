import 'package:flutter_test/flutter_test.dart';
import 'package:gagaku/model/model.dart';

void main() {
  test('web manga share links preserve source and manga identifiers', () {
    const sourceId = 'source/id ?';
    const mangaId = 'manga/日本語?chapter=1';

    final uri = GagakuRoute.webMangaShareUri(
      sourceId: sourceId,
      mangaId: mangaId,
    );

    expect(uri.scheme, 'https');
    expect(uri.host, 'r52.github.io');
    expect(uri.path, '/gagaku/open.html');
    expect(uri.queryParameters, {
      'v': '1',
      'type': 'manga',
      'source': sourceId,
      'manga': mangaId,
    });
    expect(GagakuRoute.parseWebMangaShareUri(uri), (
      sourceId: sourceId,
      mangaId: mangaId,
    ));
  });

  test('web manga share links reject unsupported or incomplete payloads', () {
    final valid = GagakuRoute.webMangaShareUri(
      sourceId: 'source',
      mangaId: 'manga',
    );

    expect(
      GagakuRoute.parseWebMangaShareUri(
        valid.replace(queryParameters: {...valid.queryParameters, 'v': '2'}),
      ),
      isNull,
    );
    expect(
      GagakuRoute.parseWebMangaShareUri(
        valid.replace(
          queryParameters: {...valid.queryParameters, 'type': 'chapter'},
        ),
      ),
      isNull,
    );
    expect(
      GagakuRoute.parseWebMangaShareUri(
        valid.replace(queryParameters: {'v': '1', 'type': 'manga'}),
      ),
      isNull,
    );
  });
}
