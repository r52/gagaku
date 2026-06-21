import 'package:flutter_test/flutter_test.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/mangadex/model/model.dart';
import 'package:gagaku/mangadex/model/types.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

void main() {
  setUpAll(() {
    logger = Logger();
  });

  group('MangaDex provider caches', () {
    late _FakeMangaDexModel api;
    late ProviderContainer container;

    setUp(() {
      api = _FakeMangaDexModel();
      container = ProviderContainer(
        overrides: [mangadexProvider.overrideWithValue(api)],
      );
    });

    tearDown(() {
      container.dispose();
    });

    test(
      'statistics fetches only missing manga and merges the cache',
      () async {
        final first = Manga(id: 'manga-1');
        final second = Manga(id: 'manga-2');
        final third = Manga(id: 'manga-3');

        api.mangaStatistics.addAll({
          first.id: _mangaStatistics(1),
          second.id: _mangaStatistics(2),
          third.id: _mangaStatistics(3),
        });

        final notifier = container.read(statisticsProvider.notifier);

        await notifier.get([first, second]);
        await notifier.get([first, third]);

        expect(api.statisticsRequests, [
          [first.id, second.id],
          [third.id],
        ]);
        expect(
          await container.read(statisticsProvider.future),
          containsPair(third.id, api.mangaStatistics[third.id]),
        );
      },
    );

    test('chapter statistics fetches only missing chapters', () async {
      final first = _chapter('chapter-1');
      final second = _chapter('chapter-2');
      final third = _chapter('chapter-3');

      api.chapterStatistics.addAll({
        first.id: const ChapterStatistics(),
        second.id: const ChapterStatistics(),
        third.id: const ChapterStatistics(),
      });

      final notifier = container.read(chapterStatsProvider.notifier);

      await notifier.get([first, second]);
      await notifier.get([second, third]);

      expect(api.chapterStatisticsRequests, [
        [first.id, second.id],
        [third.id],
      ]);
      expect(
        await container.read(chapterStatsProvider.future),
        containsPair(third.id, api.chapterStatistics[third.id]),
      );
    });

    test(
      'read chapter requests in the same batch window are coalesced',
      () async {
        final first = Manga(id: 'manga-1');
        final second = Manga(id: 'manga-2');
        api.readChapters.addAll({
          first.id: ReadChapterSet(first.id, {'chapter-1'}),
          second.id: ReadChapterSet(second.id, {'chapter-2'}),
        });

        final notifier = container.read(
          readChaptersProvider('user-1').notifier,
        );
        final results = await Future.wait([
          notifier.get([first]),
          notifier.get([second]),
        ]);

        expect(api.readChapterRequests, [
          [first.id, second.id],
        ]);
        expect(results[0][first.id], same(api.readChapters[first.id]));
        expect(results[1][second.id], same(api.readChapters[second.id]));
      },
    );

    test(
      'user library updates are published without another API fetch',
      () async {
        final manga = Manga(id: 'manga-1');
        api.userLibrary[manga.id] = MangaReadingStatus.reading;

        final provider = userLibraryProvider('user-1');
        final subscription = container.listen(provider, (_, _) {});
        addTearDown(subscription.close);

        expect(
          await container.read(provider.future),
          containsPair(manga.id, MangaReadingStatus.reading),
        );
        final oldState = await container.read(provider.future);

        await container
            .read(provider.notifier)
            .set(manga, MangaReadingStatus.completed);

        expect(oldState[manga.id], MangaReadingStatus.reading);
        expect(
          await container.read(provider.future),
          containsPair(manga.id, MangaReadingStatus.completed),
        );
        expect(api.userLibraryRequests, 1);
      },
    );

    test('reading status updates the active user library cache', () async {
      final manga = Manga(id: 'manga-1');
      api.userLibrary[manga.id] = MangaReadingStatus.reading;

      final libraryProvider = userLibraryProvider(api.user.id);
      final librarySubscription = container.listen(libraryProvider, (_, _) {});
      final statusProvider = readingStatusProvider(manga);
      final statusSubscription = container.listen(statusProvider, (_, _) {});
      addTearDown(librarySubscription.close);
      addTearDown(statusSubscription.close);

      await container.read(libraryProvider.future);
      await container.read(statusProvider.future);

      final result = await container
          .read(statusProvider.notifier)
          .set(MangaReadingStatus.completed);

      expect(result, isTrue);
      await Future<void>.delayed(Duration.zero);
      expect(
        await container.read(libraryProvider.future),
        containsPair(manga.id, MangaReadingStatus.completed),
      );
    });

    test('read chapter updates do not mutate the previous snapshot', () async {
      final manga = Manga(id: 'manga-1');
      final firstChapter = _chapter('chapter-1');
      final secondChapter = _chapter('chapter-2');
      api.readChapters[manga.id] = ReadChapterSet(manga.id, {firstChapter.id});

      final provider = readChaptersProvider(api.user.id);
      final notifier = container.read(provider.notifier);
      await notifier.get([manga]);
      final oldState = await container.read(provider.future);
      final oldReadChapters = oldState[manga.id]!;

      await notifier.set(manga, read: [secondChapter]);

      expect(oldReadChapters.contains(firstChapter.id), isTrue);
      expect(oldReadChapters.contains(secondChapter.id), isFalse);
      final newReadChapters = (await container.read(
        provider.future,
      ))[manga.id]!;
      expect(
        newReadChapters.containsAll([firstChapter.id, secondChapter.id]),
        isTrue,
      );
      expect(newReadChapters, isNot(same(oldReadChapters)));
    });

    test('custom list replacement does not mutate the previous list', () async {
      final original = _customList('list-1', name: 'Original');
      final replacement = _customList('list-1', name: 'Replacement');
      api.userLists = [original];

      final provider = userListsProvider(api.user.id);
      final subscription = container.listen(provider, (_, _) {});
      addTearDown(subscription.close);
      final oldState = await container.read(provider.future);

      await container.read(provider.notifier).replaceList(replacement);

      expect(oldState, [original]);
      expect(await container.read(provider.future), [replacement]);
    });
  });
}

MangaStatistics _mangaStatistics(int follows) => MangaStatistics(
  rating: const StatisticsDetailsRating(bayesian: 0),
  follows: follows,
);

Chapter _chapter(String id) {
  final now = DateTime.utc(2026);
  return Chapter(
    id: id,
    attributes: ChapterAttributes(
      translatedLanguage: Language.en,
      version: 1,
      createdAt: now,
      updatedAt: now,
      publishAt: now,
    ),
    relationships: const [],
  );
}

CustomList _customList(String id, {required String name}) => CustomList(
  id: id,
  attributes: CustomListAttributes(
    name: name,
    visibility: CustomListVisibility.private,
    version: 1,
  ),
  relationships: [],
);

class _FakeMangaDexModel implements MangaDexModel {
  final User user = User(id: 'user-1');
  final Map<String, MangaStatistics> mangaStatistics = {};
  final Map<String, ChapterStatistics> chapterStatistics = {};
  final ReadChaptersMap readChapters = {};
  final Map<String, MangaReadingStatus> userLibrary = {};
  List<CustomList> userLists = [];

  final List<List<String>> statisticsRequests = [];
  final List<List<String>> chapterStatisticsRequests = [];
  final List<List<String>> readChapterRequests = [];
  int userLibraryRequests = 0;

  @override
  Stream<AuthenticationStatus> get authenticationStatus =>
      Stream.value(AuthenticationStatus.authenticated);

  @override
  Future<User> getLoggedUser() async => user;

  @override
  Future<Map<String, MangaStatistics>> fetchStatistics(
    Iterable<Manga> mangas,
  ) async {
    final ids = mangas.map((manga) => manga.id).toList();
    statisticsRequests.add(ids);
    return {for (final id in ids) id: mangaStatistics[id]!};
  }

  @override
  Future<Map<String, ChapterStatistics>> fetchChapterStats(
    Iterable<Chapter> chapters,
  ) async {
    final ids = chapters.map((chapter) => chapter.id).toList();
    chapterStatisticsRequests.add(ids);
    return {for (final id in ids) id: chapterStatistics[id]!};
  }

  @override
  Future<ReadChaptersMap> fetchReadChapters(Iterable<Manga> mangas) async {
    final ids = mangas.map((manga) => manga.id).toList();
    readChapterRequests.add(ids);
    return {for (final id in ids) id: readChapters[id]!};
  }

  @override
  Future<bool> setChaptersRead(
    Manga manga, {
    Iterable<Chapter>? read,
    Iterable<Chapter>? unread,
  }) async => true;

  @override
  Future<Map<String, MangaReadingStatus>> fetchUserLibrary(
    String userId,
  ) async {
    userLibraryRequests += 1;
    return Map.of(userLibrary);
  }

  @override
  Future<MangaReadingStatus?> getMangaReadingStatus(Manga manga) async =>
      userLibrary[manga.id];

  @override
  Future<bool> setMangaReadingStatus(
    Manga manga,
    MangaReadingStatus? status,
  ) async => true;

  @override
  Future<List<CustomList>> fetchUserList({
    required FeedInfo feed,
    int offset = 0,
  }) async => [...userLists];

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
