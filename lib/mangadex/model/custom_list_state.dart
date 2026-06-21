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

  Future<CustomList?> updateList(CustomList list, Manga manga, bool add) async {
    final api = ref.watch(mangadexProvider);

    final oldstate = await future;
    final result = await api.updateMangaInCustomList(list, manga, add);
    var newState = [...oldstate];

    if (result != null) {
      final idx = oldstate.indexWhere((e) => e.id == result.id);
      if (idx >= 0) {
        newState = _replaceListAt(oldstate, idx, result);
        ref.invalidate(listSourceProvider(result.id));
      }
    }

    state = AsyncData(newState);

    return result;
  }

  Future<CustomList> editList(
    CustomList list,
    String name,
    CustomListVisibility visibility,
    Iterable<String> mangaIds,
  ) async {
    final api = ref.watch(mangadexProvider);

    final oldstate = await future;
    final result = await api.editList(list, name, visibility, mangaIds);
    final idx = oldstate.indexWhere((e) => e.id == result.id);
    var newState = [...oldstate];
    if (idx >= 0) {
      newState = _replaceListAt(oldstate, idx, result);
      ref.invalidate(listSourceProvider(result.id));
    }

    state = AsyncData(newState);

    return result;
  }

  Future<CustomList> deleteList(CustomList list) async {
    final api = ref.watch(mangadexProvider);

    final oldstate = await future;
    final result = await api.deleteList(list);
    var newState = [...oldstate];

    if (result) {
      newState = _removeListById(oldstate, list.id);
      ref.invalidate(listSourceProvider(list.id));
    }

    state = AsyncData(newState);

    return list;
  }

  Future<CustomList> newList(
    String name,
    CustomListVisibility visibility,
    Iterable<String> mangaIds,
  ) async {
    final api = ref.watch(mangadexProvider);

    final oldstate = await future;
    final result = await api.createNewList(name, visibility, mangaIds);

    state = AsyncData([...oldstate, result]);

    return result;
  }

  Future<void> replaceList(CustomList list) async {
    final oldstate = await future;
    final idx = oldstate.indexWhere((e) => e.id == list.id);
    state = AsyncData(
      idx >= 0 ? _replaceListAt(oldstate, idx, list) : [...oldstate],
    );
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

  Future<bool> setFollow(CustomList list, bool follow) async {
    final api = ref.watch(mangadexProvider);

    final oldstate = await future;
    final result = await api.setFollowList(list, follow);
    var newState = [...oldstate];

    if (result) {
      if (follow) {
        final idx = oldstate.indexWhere((e) => e.id == list.id);
        if (idx == -1) {
          newState = [...oldstate, list];
        }
      } else {
        newState = _removeListById(oldstate, list.id);
      }
    }

    state = AsyncData(newState);

    return result;
  }

  Future<void> replaceList(CustomList list) async {
    final oldstate = await future;
    final idx = oldstate.indexWhere((e) => e.id == list.id);
    state = AsyncData(
      idx >= 0 ? _replaceListAt(oldstate, idx, list) : [...oldstate],
    );
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
          if (ref.exists(userListsProvider(me.id))) {
            await tsx.get(userListsProvider(me.id).notifier).replaceList(list);
          }

          if (ref.exists(followedListsProvider(me.id))) {
            await tsx
                .get(followedListsProvider(me.id).notifier)
                .replaceList(list);
          }
        });
      }
    }

    return list;
  }
}
