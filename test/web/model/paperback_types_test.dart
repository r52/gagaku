import 'package:flutter_test/flutter_test.dart';
import 'package:gagaku/web/model/types.dart';

void main() {
  group('Paperback alpha 91 types', () {
    test('parses image chapter details without an explicit type', () {
      final details = ChapterDetails.fromJson({
        'id': 'chapter-1',
        'mangaId': 'manga-1',
        'pages': ['https://example.com/1.jpg'],
      });

      expect(details, isA<ImageChapterDetails>());
      expect(
        switch (details) {
          ImageChapterDetails(:final pages) => pages,
          HtmlChapterDetails() ||
          FileChapterDetails() => fail('Expected image chapter details'),
        },
        ['https://example.com/1.jpg'],
      );
    });

    test('parses html and file chapter details', () {
      final htmlDetails = ChapterDetails.fromJson({
        'type': 'html',
        'id': 'chapter-2',
        'mangaId': 'manga-1',
        'html': '<p>Chapter text</p>',
      });
      final fileDetails = ChapterDetails.fromJson({
        'type': 'file',
        'id': 'chapter-3',
        'mangaId': 'manga-1',
        'format': 'epub',
        'request': {
          'url': 'https://example.com/chapter.epub',
          'method': 'GET',
          'headers': {'accept': 'application/epub+zip'},
          'cookies': {'session': 'abc'},
        },
      });

      expect(htmlDetails, isA<HtmlChapterDetails>());
      expect(switch (htmlDetails) {
        HtmlChapterDetails(:final html) => html,
        ImageChapterDetails() ||
        FileChapterDetails() => fail('Expected html chapter details'),
      }, '<p>Chapter text</p>');
      expect(fileDetails, isA<FileChapterDetails>());
      final fileRequest = switch (fileDetails) {
        FileChapterDetails(:final format, :final request) => (
          format: format,
          request: request,
        ),
        ImageChapterDetails() ||
        HtmlChapterDetails() => fail('Expected file chapter details'),
      };
      expect(fileRequest.format, ChapterFileFormat.epub);
      expect(fileRequest.request.url, 'https://example.com/chapter.epub');
      expect(fileRequest.request.headers, {'accept': 'application/epub+zip'});
      expect(fileRequest.request.cookies, {'session': 'abc'});
    });

    test('parses novel content type and featured info items', () {
      final mangaInfo = MangaInfo.fromJson({
        'thumbnailUrl': 'https://example.com/cover.jpg',
        'synopsis': 'Synopsis',
        'primaryTitle': 'Title',
        'secondaryTitles': <String>[],
        'contentRating': 'EVERYONE',
        'contentType': 'novel',
        'artworkUrls': [
          'https://example.com/cover-1.webp',
          'https://example.com/cover-2.webp',
        ],
      });
      final manga = WebManga.extension(
        data: SourceManga(mangaId: 'manga-1', mangaInfo: mangaInfo),
        chaptersList: const [],
      );
      final featured = DiscoverSectionItem.fromJson({
        'type': 'featuredCarouselItem',
        'mangaId': 'manga-1',
        'imageUrl': 'https://example.com/cover.jpg',
        'title': 'Title',
        'summary': 'Featured summary',
        'infoItems': [
          {'symbol': 'book', 'text': 'Novel'},
        ],
      });

      expect(mangaInfo.contentType, MangaContentType.novel);
      expect(mangaInfo.artworkUrls, [
        'https://example.com/cover-1.webp',
        'https://example.com/cover-2.webp',
      ]);
      expect(manga.artworkUrls, [
        'https://example.com/cover-1.webp',
        'https://example.com/cover-2.webp',
      ]);
      expect(featured, isA<FeaturedCarouselItem>());
      expect(
        switch (featured) {
          FeaturedCarouselItem(:final summary, :final infoItems) => (
            summary,
            infoItems?.single.symbol,
            infoItems?.single.text,
          ),
          GenresCarouselItem() ||
          ChapterUpdatesCarouselItem() ||
          ProminentCarouselItem() ||
          SimpleCarouselItem() => fail('Expected featured carousel item'),
        },
        ('Featured summary', 'book', 'Novel'),
      );
    });

    test('extension chapter read keys preserve unique chapNum aliases', () {
      const sourceManga = SourceManga(
        mangaId: 'manga-1',
        mangaInfo: MangaInfo(
          thumbnailUrl: 'https://example.com/cover.jpg',
          synopsis: 'Synopsis',
          primaryTitle: 'Title',
          secondaryTitles: [],
          contentRating: ContentRating.EVERYONE,
          contentType: MangaContentType.comic,
        ),
      );
      const chapter = Chapter(
        chapterId: 'chapter-2',
        sourceManga: sourceManga,
        langCode: 'en',
        chapNum: 2,
        title: 'Start',
      );
      const manga = WebManga.extension(
        data: sourceManga,
        chaptersList: [chapter],
      );
      final item = manga.chapters.single;
      final legacyDb = ReadMarkersDB(
        markers: {
          'source-1/manga-1': {'2'},
        },
      );

      expect(item.title, '2: Start');
      expect(item.readMarkerKey, 'chapter-2');
      expect(manga.readMarkerKeysFor(item), ['chapter-2', '2']);
      expect(manga.hasReadMarker(legacyDb, 'source-1/manga-1', item), isTrue);
    });

    test('novel chapters use chapterId keys when chapNum is duplicated', () {
      const sourceManga = SourceManga(
        mangaId: 'novel-1',
        mangaInfo: MangaInfo(
          thumbnailUrl: 'https://example.com/cover.jpg',
          synopsis: 'Synopsis',
          primaryTitle: 'Novel',
          secondaryTitles: [],
          contentRating: ContentRating.EVERYONE,
          contentType: MangaContentType.novel,
        ),
      );
      const volume25 = Chapter(
        chapterId: '/book/25',
        sourceManga: sourceManga,
        langCode: 'en',
        chapNum: 1,
        title: 'Volume 25',
        volume: 25,
        sortingIndex: 24,
      );
      const volume26 = Chapter(
        chapterId: '/book/26',
        sourceManga: sourceManga,
        langCode: 'en',
        chapNum: 1,
        title: 'Volume 26',
        volume: 26,
        sortingIndex: 25,
      );
      const manga = WebManga.extension(
        data: sourceManga,
        chaptersList: [volume25, volume26],
      );
      final first = manga.chapters.first;
      final second = manga.chapters.last;
      final ambiguousLegacyDb = ReadMarkersDB(
        markers: {
          'source-1/novel-1': {'1'},
        },
      );
      final canonicalDb = ReadMarkersDB(
        markers: {
          'source-1/novel-1': {'/book/25'},
        },
      );

      expect(first.title, 'Volume 25');
      expect(first.groupingKey, '25');
      expect(first.readMarkerKey, '/book/25');
      expect(manga.readMarkerKeysFor(first), ['/book/25']);
      expect(manga.readMarkerKeysFor(second), ['/book/26']);
      expect(
        manga.hasReadMarker(ambiguousLegacyDb, 'source-1/novel-1', first),
        isFalse,
      );
      expect(
        manga.hasReadMarker(ambiguousLegacyDb, 'source-1/novel-1', second),
        isFalse,
      );
      expect(
        manga.hasReadMarker(canonicalDb, 'source-1/novel-1', first),
        isTrue,
      );
      expect(
        manga.hasReadMarker(canonicalDb, 'source-1/novel-1', second),
        isFalse,
      );
    });

    test('extension chapters sort by sorting index before chapNum', () {
      const sourceManga = SourceManga(
        mangaId: 'novel-1',
        mangaInfo: MangaInfo(
          thumbnailUrl: 'https://example.com/cover.jpg',
          synopsis: 'Synopsis',
          primaryTitle: 'Novel',
          secondaryTitles: [],
          contentRating: ContentRating.EVERYONE,
          contentType: MangaContentType.novel,
        ),
      );
      final chapters = [
        const Chapter(
          chapterId: '/book/25',
          sourceManga: sourceManga,
          langCode: 'en',
          chapNum: 1,
          volume: 25,
          sortingIndex: 24,
        ),
        const Chapter(
          chapterId: '/book/26',
          sourceManga: sourceManga,
          langCode: 'en',
          chapNum: 1,
          volume: 26,
          sortingIndex: 25,
        ),
        const Chapter(
          chapterId: '/book/24',
          sourceManga: sourceManga,
          langCode: 'en',
          chapNum: 24,
          volume: 24,
        ),
      ]..sort(WebManga.compareExtensionChaptersDescending);

      expect(chapters.map((chapter) => chapter.chapterId), [
        '/book/26',
        '/book/25',
        '/book/24',
      ]);
    });

    test('parses Paperback API cookies', () {
      final cookie = PaperbackCookie.fromJson({
        'name': 'session',
        'value': 'abc',
        'domain': 'example.com',
        'path': '/',
        'created': '2026-06-04T12:00:00.000Z',
        'expires': '2026-06-05T12:00:00.000Z',
      });

      expect(cookie.name, 'session');
      expect(cookie.value, 'abc');
      expect(cookie.domain, 'example.com');
      expect(cookie.path, '/');
      expect(cookie.created, DateTime.parse('2026-06-04T12:00:00.000Z'));
      expect(cookie.expires, DateTime.parse('2026-06-05T12:00:00.000Z'));
    });

    test('parses the optional execute in WebView user agent', () {
      final context = ExecuteInWebViewContext.fromJson({
        'source': {
          'html': '<html></html>',
          'baseUrl': 'https://example.com',
          'loadCSS': false,
          'loadImages': false,
          'userAgent': 'Paperback/1.0',
        },
        'inject': 'return true',
        'storage': {'cookies': <dynamic>[]},
      });

      expect(context.source.userAgent, 'Paperback/1.0');
      expect(
        context.toJson()['source'],
        containsPair('userAgent', 'Paperback/1.0'),
      );
    });
  });
}
