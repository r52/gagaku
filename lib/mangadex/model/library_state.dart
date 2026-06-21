part of 'model.dart';

@riverpod
class UserLibrary extends _$UserLibrary with AutoDisposeExpiryMix {
  @override
  Future<Map<String, MangaReadingStatus>> build(String? userId) async {
    if (userId == null) {
      return {};
    }

    final api = ref.watch(mangadexProvider);
    final library = await api.fetchUserLibrary(userId);

    disposeAfter(const Duration(minutes: 5));

    return library;
  }

  Future<Map<String, MangaReadingStatus>> set(
    Manga manga,
    MangaReadingStatus? status,
  ) async {
    final oldstate = await future;

    if (status == null) {
      oldstate.remove(manga.id);
    } else {
      oldstate[manga.id] = status;
    }

    state = AsyncData({...oldstate});

    return oldstate;
  }

  /// Clears the list and refetch from the beginning
  Future<void> clear() async {
    final api = ref.watch(mangadexProvider);
    await api.invalidateAll('UserLibrary');

    ref.invalidateSelf();
  }
}

@riverpod
class ReadingStatus extends _$ReadingStatus with AutoDisposeExpiryMix {
  @override
  Future<MangaReadingStatus?> build(Manga manga) async {
    final me = await ref.watch(loggedUserProvider.future);

    if (me == null) {
      return null;
    }

    final api = ref.watch(mangadexProvider);
    final status = await api.getMangaReadingStatus(manga);

    disposeAfter(const Duration(minutes: 5));

    return status;
  }

  Future<bool> set(MangaReadingStatus? status) async {
    final me = await ref.readAsync(loggedUserProvider.future);

    if (me == null) {
      throw StateError('User not logged in');
    }

    final api = ref.watch(mangadexProvider);

    MangaReadingStatus? resolved = status == MangaReadingStatus.remove
        ? null
        : status;
    bool success = await api.setMangaReadingStatus(manga, resolved);
    if (success) {
      if (ref.exists(userLibraryProvider(me.id))) {
        ref.run((tsx) async {
          return await tsx
              .get(userLibraryProvider(me.id).notifier)
              .set(manga, resolved);
        });
      }

      state = AsyncData(resolved);
    }

    return success;
  }
}

final readingStatusMutation = Mutation<bool>();

@riverpod
class FollowingStatus extends _$FollowingStatus with AutoDisposeExpiryMix {
  @override
  Future<bool> build(Manga manga) async {
    final me = await ref.watch(loggedUserProvider.future);

    if (me == null) {
      return false;
    }

    final api = ref.watch(mangadexProvider);
    final status = await api.getMangaFollowing(manga);

    disposeAfter(const Duration(minutes: 5));

    return status;
  }

  Future<bool> set(bool following) async {
    final me = await ref.readAsync(loggedUserProvider.future);

    if (me == null) {
      throw StateError('User not logged in');
    }

    final api = ref.watch(mangadexProvider);

    bool success = await api.setMangaFollowing(manga, following);
    if (success) {
      state = AsyncData(following);
    }

    return success;
  }
}

final followStatusMutation = Mutation<bool>();
