part of 'model.dart';

@Riverpod(keepAlive: true)
class LoggedUser extends _$LoggedUser {
  @override
  Future<User?> build() async {
    final status = await ref.watch(authControlProvider.future);

    if (status != AuthenticationStatus.authenticated) {
      return null;
    }

    final api = ref.watch(mangadexProvider);
    final user = await api.getLoggedUser();

    return user;
  }
}

@Riverpod(keepAlive: true)
class AuthControl extends _$AuthControl {
  @override
  Stream<AuthenticationStatus> build() async* {
    final api = ref.watch(mangadexProvider);

    await for (final status in api.authenticationStatus) {
      yield status;
    }
  }

  Future<bool> login(
    String user,
    String pass,
    String clientId,
    String clientSecret,
  ) async {
    final api = ref.watch(mangadexProvider);
    final result = await api.authenticate(user, pass, clientId, clientSecret);

    return result;
  }

  Future<void> logout() async {
    final api = ref.watch(mangadexProvider);

    // Invalidate stuff
    await api.invalidateAll(MangaDexFeeds.library.key);
    ref.invalidate(userLibraryProvider);
    ref.invalidate(readChaptersProvider);
    ref.invalidate(ratingsProvider);
    ref.invalidate(userListsProvider);
    ref.invalidate(followedListsProvider);
    ref.invalidate(readingStatusProvider);
    ref.invalidate(followingStatusProvider);
    await api.invalidateAll(MangaDexFeeds.latestChapters.key);

    await api.logout();
  }
}

final authControlLoginMutation = Mutation<bool>();
