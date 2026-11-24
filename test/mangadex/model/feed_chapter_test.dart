import 'package:flutter_test/flutter_test.dart';
import 'package:gagaku/mangadex/model/types.dart';
import 'package:paged_slivers/paged_slivers.dart';

Chapter _chapter(String id, String mangaId) {
  final time = DateTime.utc(2026);
  return Chapter(
    id: id,
    attributes: ChapterAttributes(
      translatedLanguage: Language.en,
      version: 1,
      createdAt: time,
      updatedAt: time,
      publishAt: time,
    ),
    relationships: [Manga(id: mangaId)],
  );
}

void main() {
  group('pairFeedChapters', () {
    test('pairs chapters with fetched mangas and drops unresolved ones', () {
      final first = Manga(id: 'manga-1');
      final second = Manga(id: 'manga-2');

      final paired = pairFeedChapters(
        [
          _chapter('c1', 'manga-1'),
          _chapter('c2', 'missing'),
          _chapter('c3', 'manga-2'),
        ],
        [second, first],
      );

      expect(paired.map((e) => e.chapter.id), ['c1', 'c3']);
      expect(paired[0].manga, same(first));
      expect(paired[1].manga, same(second));
    });
  });

  group('uniqueFeedChapters', () {
    test('keeps the first occurrence of chapters repeated across pages', () {
      final manga = Manga(id: 'manga-1');
      // Page two shifted by one: c2 ends page one and starts page two.
      final page1 = pairFeedChapters(
        [_chapter('c1', 'manga-1'), _chapter('c2', 'manga-1')],
        [manga],
      );
      final page2 = pairFeedChapters(
        [_chapter('c2', 'manga-1'), _chapter('c3', 'manga-1')],
        [manga],
      );

      final unique = uniqueFeedChapters([...page1, ...page2]);
      expect(unique.map((e) => e.chapter.id), ['c1', 'c2', 'c3']);
      expect(unique[1], same(page1[1]));

      final items = ChapterFeedItemData.toData(unique);
      expect(items.single.chapters.map((e) => e.id), ['c1', 'c2', 'c3']);
    });
  });

  group('ChapterFeedItemData.toData', () {
    test('groups consecutive chapters across page boundaries', () {
      final first = Manga(id: 'manga-1');
      final second = Manga(id: 'manga-2');

      // Two pages concatenated: manga-1's run continues into page two.
      final page1 = pairFeedChapters(
        [_chapter('c1', 'manga-1'), _chapter('c2', 'manga-1')],
        [first],
      );
      final page2 = pairFeedChapters(
        [
          _chapter('c3', 'manga-1'),
          _chapter('c4', 'manga-2'),
          _chapter('c5', 'manga-1'),
        ],
        [first, second],
      );

      final items = ChapterFeedItemData.toData([...page1, ...page2]);

      expect(items.map((e) => e.mangaId), ['manga-1', 'manga-2', 'manga-1']);
      expect(items[0].chapters.map((e) => e.id), ['c1', 'c2', 'c3']);
      expect(items[1].chapters.map((e) => e.id), ['c4']);
      expect(items[2].chapters.map((e) => e.id), ['c5']);
    });
  });

  group('chapter feed projection', () {
    test('groups across pages and ends by offset with short pages', () async {
      final first = Manga(id: 'manga-1');
      final second = Manga(id: 'manga-2');

      // Each page consumed 10 API entries but kept fewer after pairing.
      final pages = {
        0: pairFeedChapters(
          [_chapter('c1', 'manga-1'), _chapter('c2', 'missing')],
          [first],
        ),
        10: pairFeedChapters(
          [_chapter('c3', 'manga-1'), _chapter('c4', 'manga-2')],
          [first, second],
        ),
      };
      final controller = PagedController<int, FeedChapter>(
        firstKey: 0,
        fetchPage: (offset) async => PageResult.offset(
          pages[offset]!,
          offset: offset,
          limit: 10,
          total: 20,
        ),
        scheduler: (callback) => callback(),
      );
      addTearDown(controller.dispose);
      final feed = controller.project(ChapterFeedItemData.toData);
      feed.addListener(() {});

      controller.fetchNext();
      await Future<void>.delayed(Duration.zero);
      expect(feed.snapshot.items.single.chapters.map((e) => e.id), ['c1']);

      controller.fetchNext();
      await Future<void>.delayed(Duration.zero);

      final items = feed.snapshot.items;
      expect(items.map((e) => e.mangaId), ['manga-1', 'manga-2']);
      expect(items[0].chapters.map((e) => e.id), ['c1', 'c3']);
      expect(controller.state.keys, [0, 10]);
      expect(controller.state.hasMore, isFalse);
      expect(feed.snapshot.status, PagedStatus.complete);
    });
  });
}
