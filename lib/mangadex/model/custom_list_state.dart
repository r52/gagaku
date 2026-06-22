part of 'model.dart';

List<CustomList> _replaceListAt(
  List<CustomList> lists,
  int index,
  CustomList replacement,
) {
  final result = [...lists];
  result[index] = replacement;
  return result;
}

List<CustomList> _removeListById(List<CustomList> lists, String id) => [
  for (final list in lists)
    if (list.id != id) list,
];

@riverpod
CustomListCommands customListCommands(Ref ref, String? userId) =>
    CustomListCommands(ref, userId);

class CustomListCommands {
  CustomListCommands(this.ref, this.userId);

  final Ref ref;
  final String? userId;

  Future<CustomList?> updateList(
    MutationTransaction transaction,
    CustomList list,
    Manga manga,
    bool add,
  ) async {
    final api = transaction.get(mangadexProvider);
    final result = await api.updateMangaInCustomList(list, manga, add);

    if (result != null) {
      await _upsert(transaction, result);
    }

    return result;
  }

  Future<CustomList> editList(
    MutationTransaction transaction,
    CustomList list,
    String name,
    CustomListVisibility visibility,
    Iterable<String> mangaIds,
  ) async {
    final api = transaction.get(mangadexProvider);
    final result = await api.editList(list, name, visibility, mangaIds);
    await _upsert(transaction, result);
    return result;
  }

  Future<CustomList> deleteList(
    MutationTransaction transaction,
    CustomList list,
  ) async {
    final api = transaction.get(mangadexProvider);
    final result = await api.deleteList(list);

    if (result) {
      await _remove(transaction, list.id);
    }

    return list;
  }

  Future<CustomList> newList(
    MutationTransaction transaction,
    String name,
    CustomListVisibility visibility,
    Iterable<String> mangaIds,
  ) async {
    final api = transaction.get(mangadexProvider);
    final result = await api.createNewList(name, visibility, mangaIds);
    await _upsert(transaction, result, addToUserLists: true);
    return result;
  }

  Future<bool> setFollow(
    MutationTransaction transaction,
    CustomList list,
    bool follow,
  ) async {
    final api = transaction.get(mangadexProvider);
    final result = await api.setFollowList(list, follow);

    if (result) {
      await _setFollowed(transaction, list, follow);
    }

    return result;
  }

  Future<void> synchronizeFetched(
    MutationTransaction transaction,
    CustomList list,
  ) => _upsert(transaction, list, invalidateSource: false);

  Future<void> _upsert(
    MutationTransaction transaction,
    CustomList list, {
    bool addToUserLists = false,
    bool invalidateSource = true,
  }) async {
    final userId = this.userId;
    if (invalidateSource) {
      ref.invalidate(listSourceProvider(list.id));
    }
    if (userId == null) {
      return;
    }

    if (ref.exists(userListsProvider(userId))) {
      await transaction
          .get(userListsProvider(userId).notifier)
          ._upsert(list, addIfMissing: addToUserLists);
    }
    if (ref.exists(followedListsProvider(userId))) {
      await transaction
          .get(followedListsProvider(userId).notifier)
          ._upsert(list);
    }
  }

  Future<void> _remove(MutationTransaction transaction, String listId) async {
    ref.invalidate(listSourceProvider(listId));

    final userId = this.userId;
    if (userId == null) {
      return;
    }

    if (ref.exists(userListsProvider(userId))) {
      await transaction.get(userListsProvider(userId).notifier)._remove(listId);
    }
    if (ref.exists(followedListsProvider(userId))) {
      await transaction
          .get(followedListsProvider(userId).notifier)
          ._remove(listId);
    }
  }

  Future<void> _setFollowed(
    MutationTransaction transaction,
    CustomList list,
    bool follow,
  ) async {
    final userId = this.userId;
    if (userId == null || !ref.exists(followedListsProvider(userId))) {
      return;
    }

    final followedLists = transaction.get(
      followedListsProvider(userId).notifier,
    );
    if (follow) {
      await followedLists._upsert(list, addIfMissing: true);
    } else {
      await followedLists._remove(list.id);
    }
  }
}

@riverpod
class UserLists extends _$UserLists
    with AutoDisposeExpiryMix, ListBasedInfiniteScrollMix {
  static const info = MangaDexFeeds.userLists;

  @protected
  @override
  get limit => info.limit;

  @protected
  @override
  Future<List<CustomList>> fetchData(int offset) async {
    final api = ref.watch(mangadexProvider);
    final lists = await api.fetchUserList(
      feed: MangaDexFeeds.userLists,
      offset: offset,
    );

    disposeAfter(const Duration(minutes: 5));

    return lists;
  }

  @override
  Future<List<CustomList>> build(String? userId) async {
    if (userId == null) {
      return [];
    }

    return fetchData(0);
  }

  Future<void> _upsert(CustomList list, {bool addIfMissing = false}) async {
    final oldstate = await future;
    final idx = oldstate.indexWhere((e) => e.id == list.id);
    state = AsyncData(
      idx >= 0
          ? _replaceListAt(oldstate, idx, list)
          : addIfMissing
          ? [...oldstate, list]
          : [...oldstate],
    );
  }

  Future<void> _remove(String listId) async {
    final oldstate = await future;
    state = AsyncData(_removeListById(oldstate, listId));
  }
}

final userListNewMutation = Mutation<CustomList>();
final userListModifyMutation = Mutation<CustomList?>();
final userListDeleteMutation = Mutation<CustomList>();
final userListNextPageMutation = Mutation<List<CustomList>>();

@riverpod
class FollowedLists extends _$FollowedLists
    with AutoDisposeExpiryMix, ListBasedInfiniteScrollMix {
  static const info = MangaDexFeeds.followedLists;

  @protected
  @override
  get limit => info.limit;

  @protected
  @override
  Future<List<CustomList>> fetchData(int offset) async {
    final api = ref.watch(mangadexProvider);
    final lists = await api.fetchUserList(
      feed: MangaDexFeeds.followedLists,
      offset: offset,
    );

    disposeAfter(const Duration(minutes: 5));

    return lists;
  }

  @override
  Future<List<CustomList>> build(String? userId) async {
    if (userId == null) {
      return [];
    }

    return fetchData(0);
  }

  Future<void> _upsert(CustomList list, {bool addIfMissing = false}) async {
    final oldstate = await future;
    final idx = oldstate.indexWhere((e) => e.id == list.id);
    state = AsyncData(
      idx >= 0
          ? _replaceListAt(oldstate, idx, list)
          : addIfMissing
          ? [...oldstate, list]
          : [...oldstate],
    );
  }

  Future<void> _remove(String listId) async {
    final oldstate = await future;
    state = AsyncData(_removeListById(oldstate, listId));
  }
}

final followedListNextPageMutation = Mutation<List<CustomList>>();

Future<List<Manga>> getMangaListByPage(
  WidgetRef ref,
  Iterable<String> list,
  int page,
) async {
  final start = page * MangaDexEndpoints.searchLimit;
  final end = min((page + 1) * MangaDexEndpoints.searchLimit, list.length);

  final range = list.toList().getRange(start, end);

  final api = ref.watch(mangadexProvider);
  final mangas = await api.fetchMangaById(
    limit: MangaDexEndpoints.searchLimit,
    ids: range,
  );

  ref.run((tsx) async {
    return await tsx.get(statisticsProvider.notifier).get(mangas);
  });

  return mangas;
}

@Riverpod(retry: noRetry)
class ListSource extends _$ListSource {
  @override
  Future<CustomList?> build(String listId) async {
    final api = ref.watch(mangadexProvider);
    final list = await api.fetchListById(listId);

    if (list != null) {
      final me = await ref.watch(loggedUserProvider.future);
      if (me != null) {
        await ref.run((tsx) async {
          await tsx
              .get(customListCommandsProvider(me.id))
              .synchronizeFetched(tsx, list);
        });
      }
    }

    return list;
  }
}
