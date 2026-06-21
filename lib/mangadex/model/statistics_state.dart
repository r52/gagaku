part of 'model.dart';

@Riverpod(keepAlive: true)
class Statistics extends _$Statistics {
  Future<Map<String, MangaStatistics>> _fetchStatistics(
    Iterable<Manga> mangas,
  ) async {
    if (mangas.isEmpty) {
      return {};
    }

    final api = ref.watch(mangadexProvider);
    final map = await api.fetchStatistics(mangas);

    return map;
  }

  @override
  Future<Map<String, MangaStatistics>> build() async {
    return {};
  }

  /// Fetch statistics for the provided list of mangas
  Future<Map<String, MangaStatistics>> get(Iterable<Manga> mangas) async {
    final oldstate = await future;

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final mg = mangas.where((m) => !oldstate.containsKey(m.id));

      if (mg.isEmpty) {
        // No change
        return oldstate;
      }

      final map = await _fetchStatistics(mg);
      return {...oldstate, ...map};
    });

    return state.value!;
  }
}

@riverpod
Future<MangaStatistics> mangaStatistics(Ref ref, Manga manga) async {
  // Makes the assumption that globalCache[manga.id] should never
  // be null after get(). And should be true unless the server is broken
  final globalCache = await ref.watch(statisticsProvider.future);

  if (globalCache.containsKey(manga.id)) {
    return globalCache[manga.id]!;
  }

  final map = await ref.read(statisticsProvider.notifier).get([manga]);
  return map[manga.id]!;
}

@Riverpod(keepAlive: true)
class ChapterStats extends _$ChapterStats {
  Future<Map<String, ChapterStatistics>> _fetchStatistics(
    Iterable<Chapter> chapters,
  ) async {
    if (chapters.isEmpty) {
      return {};
    }

    final api = ref.watch(mangadexProvider);
    final map = await api.fetchChapterStats(chapters);

    return map;
  }

  @override
  Future<Map<String, ChapterStatistics>> build() async {
    return {};
  }

  /// Fetch statistics for the provided list of mangas
  Future<Map<String, ChapterStatistics>> get(Iterable<Chapter> chapters) async {
    final oldstate = await future;
    final mg = chapters.where((c) => !oldstate.containsKey(c.id));

    if (mg.isEmpty) {
      // No change
      return oldstate;
    }

    final map = await _fetchStatistics(mg);
    state = AsyncData({...oldstate, ...map});

    return map;
  }
}

@riverpod
class Ratings extends _$Ratings with AutoDisposeExpiryMix {
  Future<Map<String, SelfRating>> _fetchRatings(Iterable<Manga> mangas) async {
    if (mangas.isEmpty) {
      return {};
    }

    final api = ref.watch(mangadexProvider);
    final map = await api.fetchRatings(mangas);
    return map;
  }

  @override
  Future<SelfRating?> build(Manga manga) async {
    disposeAfter(const Duration(minutes: 5));

    final result = await _fetchRatings([manga]);

    if (result.containsKey(manga.id)) {
      return result[manga.id];
    }

    return null;
  }

  /// Sets a self-rating for a manga
  Future<bool> set(int? rating) async {
    final api = ref.watch(mangadexProvider);
    SelfRating? updated = await future;

    bool result = await api.setMangaRating(manga, rating);

    if (result) {
      switch (rating) {
        case null:
          updated = null;
          break;
        case _:
          updated = SelfRating(rating: rating, createdAt: DateTime.now());
          break;
      }
    }

    state = AsyncData(updated);

    return result;
  }
}

final ratingsMutation = Mutation<void>();
