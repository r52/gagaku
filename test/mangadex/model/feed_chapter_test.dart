import 'package:flutter_test/flutter_test.dart';
import 'package:gagaku/mangadex/model/types.dart';
import 'package:gagaku/util/infinite_scroll.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

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

  group('OffsetPagingManager', () {
    test('ends by offset even when pages hold fewer items than consumed', () {
      final manager = OffsetPagingManager<int>(limit: 10)..totalItems = 25;

      expect(manager.getNextPageKey(PagingState<int, int>()), 0);

      // Pages hold fewer items than the 10 API entries each consumed.
      final afterTwo = PagingState<int, int>(
        pages: const [
          [1, 2],
          [3],
        ],
        keys: const [0, 10],
      );
      expect(manager.getNextPageKey(afterTwo), 20);

      final afterThree = PagingState<int, int>(
        pages: const [
          [1, 2],
          [3],
          [4],
        ],
        keys: const [0, 10, 20],
      );
      expect(manager.getNextPageKey(afterThree), isNull);
    });

    test('continues while the total is unknown', () {
      final manager = OffsetPagingManager<int>(limit: 10);

      final state = PagingState<int, int>(
        pages: const [<int>[]],
        keys: const [0],
      );
      expect(manager.getNextPageKey(state), 10);
    });
  });
}
