part of 'model.dart';

@Riverpod(keepAlive: true)
class MangaChaptersListSort extends _$MangaChaptersListSort {
  @override
  ListSort build() => ListSort.descending;

  @override
  set state(ListSort newState) => super.state = newState;
  ListSort update(ListSort Function(ListSort state) cb) => state = cb(state);
}

@Riverpod(keepAlive: true)
class ReadChapters extends _$ReadChapters {
  Completer<ReadChaptersMap>? _batchCompleter;
  Timer? _batchTimer;
  final Set<Manga> _batchQueue = {};

  Future<ReadChaptersMap> _fetchReadChapters(Iterable<Manga> mangas) async {
    if (mangas.isEmpty) {
      return {};
    }

    final api = ref.watch(mangadexProvider);
    final map = await api.fetchReadChapters(mangas);

    // Ensure all requested mangas have an entry in the map
    for (final m in mangas) {
      map.putIfAbsent(m.id, () => ReadChapterSet(m.id, {}));
    }

    return map;
  }

  @override
  Future<ReadChaptersMap> build(String? userId) async {
    if (userId == null) {
      return {};
    }

    return _fetchReadChapters([]);
  }

  /// Fetch read chapters for the provided list of mangas
  Future<ReadChaptersMap> get(Iterable<Manga> mangas) async {
    if (userId == null) {
      return {};
    }

    final oldstate = await future;
    final mg = mangas.where(
      (m) => !oldstate.containsKey(m.id) || oldstate[m.id]?.isExpired == true,
    );

    if (mg.isEmpty) {
      // No change
      return oldstate;
    }

    _batchQueue.addAll(mg);

    if (_batchTimer == null) {
      _batchCompleter = Completer<ReadChaptersMap>();
      _batchTimer = Timer(const Duration(milliseconds: 50), () async {
        final currentBatch = _batchQueue.toList();
        final completer = _batchCompleter!;

        _batchQueue.clear();
        _batchCompleter = null;
        _batchTimer = null;

        try {
          final map = await _fetchReadChapters(currentBatch);
          final currentState = await future;
          state = AsyncData({...currentState, ...map});

          completer.complete(state.value!);
        } catch (e, st) {
          completer.completeError(e, st);
        }
      });
    }

    return _batchCompleter!.future;
  }

  /// Sets a list of chapters for a manga read or unread
  Future<ReadChaptersMap> set(
    Manga manga, {
    Iterable<Chapter>? read,
    Iterable<Chapter>? unread,
  }) async {
    if (userId == null) {
      throw StateError('User not logged in');
    }

    final api = ref.watch(mangadexProvider);
    final oldstate = await future;

    bool result = await api.setChaptersRead(manga, read: read, unread: unread);

    if (result) {
      final keyExists = oldstate.containsKey(manga.id);

      // Refresh
      if (keyExists) {
        if (read != null) {
          oldstate[manga.id]?.addAll(read.map((e) => e.id));
        }

        if (unread != null) {
          oldstate[manga.id]?.removeAll(unread.map((e) => e.id));
        }
      } else {
        if (read != null) {
          oldstate[manga.id] = ReadChapterSet(
            manga.id,
            read.map((e) => e.id).toSet(),
          );
        }

        if (unread != null) {
          oldstate[manga.id] = ReadChapterSet(manga.id, {});
        }
      }
    }

    state = AsyncData({...oldstate});

    return oldstate;
  }

  /// Invalidate the read chapters of a specific manga
  Future<void> invalidate(Manga manga) async {
    final oldstate = await future;

    if (oldstate.containsKey(manga.id)) {
      oldstate.remove(manga.id);
      state = AsyncData({...oldstate});
    }
  }
}

@riverpod
Future<ReadChapterSet?> mangaReadChapters(Ref ref, Manga manga) async {
  ref.disposeAfter(const Duration(minutes: 5));

  final me = await ref.watch(loggedUserProvider.future);
  if (me == null) return null;

  final globalCache = await ref.watch(readChaptersProvider(me.id).future);

  if (globalCache.containsKey(manga.id) &&
      globalCache[manga.id]?.isExpired != true) {
    return globalCache[manga.id];
  }

  final map = await ref.read(readChaptersProvider(me.id).notifier).get([manga]);
  return map[manga.id];
}
