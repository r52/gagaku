// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(proxy)
const proxyProvider = ProxyProvider._();

final class ProxyProvider
    extends $FunctionalProvider<ProxyHandler, ProxyHandler>
    with $Provider<ProxyHandler> {
  const ProxyProvider._(
      {ProxyHandler Function(
        Ref ref,
      )? create})
      : _createCb = create,
        super(
          from: null,
          argument: null,
          retry: null,
          name: r'proxyProvider',
          isAutoDispose: false,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final ProxyHandler Function(
    Ref ref,
  )? _createCb;

  @override
  String debugGetCreateSourceHash() => _$proxyHash();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProxyHandler value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $ValueProvider<ProxyHandler>(value),
    );
  }

  @$internal
  @override
  $ProviderElement<ProxyHandler> $createElement($ProviderPointer pointer) =>
      $ProviderElement(this, pointer);

  @override
  ProxyProvider $copyWithCreate(
    ProxyHandler Function(
      Ref ref,
    ) create,
  ) {
    return ProxyProvider._(create: create);
  }

  @override
  ProxyHandler create(Ref ref) {
    final _$cb = _createCb ?? proxy;
    return _$cb(ref);
  }
}

String _$proxyHash() => r'8a4e90bb9775641c76f0be18ce9750786e3b2a4b';

@ProviderFor(WebSourceFavorites)
const webSourceFavoritesProvider = WebSourceFavoritesProvider._();

final class WebSourceFavoritesProvider extends $AsyncNotifierProvider<
    WebSourceFavorites, Map<String, List<HistoryLink>>> {
  const WebSourceFavoritesProvider._(
      {super.runNotifierBuildOverride, WebSourceFavorites Function()? create})
      : _createCb = create,
        super(
          from: null,
          argument: null,
          retry: null,
          name: r'webSourceFavoritesProvider',
          isAutoDispose: false,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final WebSourceFavorites Function()? _createCb;

  @override
  String debugGetCreateSourceHash() => _$webSourceFavoritesHash();

  @$internal
  @override
  WebSourceFavorites create() => _createCb?.call() ?? WebSourceFavorites();

  @$internal
  @override
  WebSourceFavoritesProvider $copyWithCreate(
    WebSourceFavorites Function() create,
  ) {
    return WebSourceFavoritesProvider._(create: create);
  }

  @$internal
  @override
  WebSourceFavoritesProvider $copyWithBuild(
    FutureOr<Map<String, List<HistoryLink>>> Function(
      Ref,
      WebSourceFavorites,
    ) build,
  ) {
    return WebSourceFavoritesProvider._(runNotifierBuildOverride: build);
  }

  @$internal
  @override
  _$WebSourceFavoritesElement $createElement($ProviderPointer pointer) =>
      _$WebSourceFavoritesElement(this, pointer);

  ProviderListenable<WebSourceFavorites$Clear> get clear =>
      $LazyProxyListenable<WebSourceFavorites$Clear,
          AsyncValue<Map<String, List<HistoryLink>>>>(
        this,
        (element) {
          element as _$WebSourceFavoritesElement;

          return element._$clear;
        },
      );

  ProviderListenable<WebSourceFavorites$Add> get add => $LazyProxyListenable<
          WebSourceFavorites$Add, AsyncValue<Map<String, List<HistoryLink>>>>(
        this,
        (element) {
          element as _$WebSourceFavoritesElement;

          return element._$add;
        },
      );

  ProviderListenable<WebSourceFavorites$UpdateAll> get updateAll =>
      $LazyProxyListenable<WebSourceFavorites$UpdateAll,
          AsyncValue<Map<String, List<HistoryLink>>>>(
        this,
        (element) {
          element as _$WebSourceFavoritesElement;

          return element._$updateAll;
        },
      );

  ProviderListenable<WebSourceFavorites$Remove> get remove =>
      $LazyProxyListenable<WebSourceFavorites$Remove,
          AsyncValue<Map<String, List<HistoryLink>>>>(
        this,
        (element) {
          element as _$WebSourceFavoritesElement;

          return element._$remove;
        },
      );

  ProviderListenable<WebSourceFavorites$UpdateList> get updateList =>
      $LazyProxyListenable<WebSourceFavorites$UpdateList,
          AsyncValue<Map<String, List<HistoryLink>>>>(
        this,
        (element) {
          element as _$WebSourceFavoritesElement;

          return element._$updateList;
        },
      );

  ProviderListenable<WebSourceFavorites$ReconfigureCategories>
      get reconfigureCategories => $LazyProxyListenable<
              WebSourceFavorites$ReconfigureCategories,
              AsyncValue<Map<String, List<HistoryLink>>>>(
            this,
            (element) {
              element as _$WebSourceFavoritesElement;

              return element._$reconfigureCategories;
            },
          );
}

String _$webSourceFavoritesHash() =>
    r'57e0afb1025e5fe404107a9dd2e947afd881d469';

abstract class _$WebSourceFavorites
    extends $AsyncNotifier<Map<String, List<HistoryLink>>> {
  FutureOr<Map<String, List<HistoryLink>>> build();
  @$internal
  @override
  FutureOr<Map<String, List<HistoryLink>>> runBuild() => build();
}

class _$WebSourceFavoritesElement extends $AsyncNotifierProviderElement<
    WebSourceFavorites, Map<String, List<HistoryLink>>> {
  _$WebSourceFavoritesElement(super.provider, super.pointer) {
    _$clear.result = $Result.data(_$WebSourceFavorites$Clear(this));
    _$add.result = $Result.data(_$WebSourceFavorites$Add(this));
    _$updateAll.result = $Result.data(_$WebSourceFavorites$UpdateAll(this));
    _$remove.result = $Result.data(_$WebSourceFavorites$Remove(this));
    _$updateList.result = $Result.data(_$WebSourceFavorites$UpdateList(this));
    _$reconfigureCategories.result =
        $Result.data(_$WebSourceFavorites$ReconfigureCategories(this));
  }
  final _$clear = $ElementLense<_$WebSourceFavorites$Clear>();
  final _$add = $ElementLense<_$WebSourceFavorites$Add>();
  final _$updateAll = $ElementLense<_$WebSourceFavorites$UpdateAll>();
  final _$remove = $ElementLense<_$WebSourceFavorites$Remove>();
  final _$updateList = $ElementLense<_$WebSourceFavorites$UpdateList>();
  final _$reconfigureCategories =
      $ElementLense<_$WebSourceFavorites$ReconfigureCategories>();
  @override
  void mount() {
    super.mount();
    _$clear.result!.stateOrNull!.reset();
    _$add.result!.stateOrNull!.reset();
    _$updateAll.result!.stateOrNull!.reset();
    _$remove.result!.stateOrNull!.reset();
    _$updateList.result!.stateOrNull!.reset();
    _$reconfigureCategories.result!.stateOrNull!.reset();
  }

  @override
  void visitChildren({
    required void Function(ProviderElement element) elementVisitor,
    required void Function($ElementLense element) listenableVisitor,
  }) {
    super.visitChildren(
      elementVisitor: elementVisitor,
      listenableVisitor: listenableVisitor,
    );

    listenableVisitor(_$clear);
    listenableVisitor(_$add);
    listenableVisitor(_$updateAll);
    listenableVisitor(_$remove);
    listenableVisitor(_$updateList);
    listenableVisitor(_$reconfigureCategories);
  }
}

sealed class WebSourceFavorites$Clear
    extends MutationBase<Map<String, List<HistoryLink>>> {
  /// Starts the mutation.
  ///
  /// This will first set the state to [PendingMutationState], then
  /// will call [WebSourceFavorites.clear] with the provided parameters.
  ///
  /// After the method completes, the mutation state will be updated to either
  /// [SuccessMutationState] or [ErrorMutationState] based on if the method
  /// threw or not.
  ///
  /// Lastly, if the method completes without throwing, the Notifier's state
  /// will be updated with the new value.
  ///
  /// **Note**:
  /// If the notifier threw in its constructor, the mutation won't start
  /// and [call] will throw.
  /// This should generally never happen though, as Notifiers are not supposed
  /// to have logic in their constructors.
  Future<Map<String, List<HistoryLink>>> call();
}

final class _$WebSourceFavorites$Clear extends $AsyncMutationBase<
    Map<String, List<HistoryLink>>,
    _$WebSourceFavorites$Clear,
    WebSourceFavorites> implements WebSourceFavorites$Clear {
  _$WebSourceFavorites$Clear(this.element, {super.state, super.key});

  @override
  final _$WebSourceFavoritesElement element;

  @override
  $ElementLense<_$WebSourceFavorites$Clear> get listenable => element._$clear;

  @override
  Future<Map<String, List<HistoryLink>>> call() {
    return mutateAsync(
      Invocation.method(
        #clear,
        [],
      ),
      ($notifier) => $notifier.clear(),
    );
  }

  @override
  _$WebSourceFavorites$Clear copyWith(
          MutationState<Map<String, List<HistoryLink>>> state,
          {Object? key}) =>
      _$WebSourceFavorites$Clear(element, state: state, key: key);
}

sealed class WebSourceFavorites$Add
    extends MutationBase<Map<String, List<HistoryLink>>> {
  /// Starts the mutation.
  ///
  /// This will first set the state to [PendingMutationState], then
  /// will call [WebSourceFavorites.add] with the provided parameters.
  ///
  /// After the method completes, the mutation state will be updated to either
  /// [SuccessMutationState] or [ErrorMutationState] based on if the method
  /// threw or not.
  ///
  /// Lastly, if the method completes without throwing, the Notifier's state
  /// will be updated with the new value.
  ///
  /// **Note**:
  /// If the notifier threw in its constructor, the mutation won't start
  /// and [call] will throw.
  /// This should generally never happen though, as Notifiers are not supposed
  /// to have logic in their constructors.
  Future<Map<String, List<HistoryLink>>> call(
      String category, HistoryLink link);
}

final class _$WebSourceFavorites$Add extends $AsyncMutationBase<
    Map<String, List<HistoryLink>>,
    _$WebSourceFavorites$Add,
    WebSourceFavorites> implements WebSourceFavorites$Add {
  _$WebSourceFavorites$Add(this.element, {super.state, super.key});

  @override
  final _$WebSourceFavoritesElement element;

  @override
  $ElementLense<_$WebSourceFavorites$Add> get listenable => element._$add;

  @override
  Future<Map<String, List<HistoryLink>>> call(
      String category, HistoryLink link) {
    return mutateAsync(
      Invocation.method(
        #add,
        [category, link],
      ),
      ($notifier) => $notifier.add(
        category,
        link,
      ),
    );
  }

  @override
  _$WebSourceFavorites$Add copyWith(
          MutationState<Map<String, List<HistoryLink>>> state,
          {Object? key}) =>
      _$WebSourceFavorites$Add(element, state: state, key: key);
}

sealed class WebSourceFavorites$UpdateAll
    extends MutationBase<Map<String, List<HistoryLink>>> {
  /// Starts the mutation.
  ///
  /// This will first set the state to [PendingMutationState], then
  /// will call [WebSourceFavorites.updateAll] with the provided parameters.
  ///
  /// After the method completes, the mutation state will be updated to either
  /// [SuccessMutationState] or [ErrorMutationState] based on if the method
  /// threw or not.
  ///
  /// Lastly, if the method completes without throwing, the Notifier's state
  /// will be updated with the new value.
  ///
  /// **Note**:
  /// If the notifier threw in its constructor, the mutation won't start
  /// and [call] will throw.
  /// This should generally never happen though, as Notifiers are not supposed
  /// to have logic in their constructors.
  Future<Map<String, List<HistoryLink>>> call(HistoryLink link);
}

final class _$WebSourceFavorites$UpdateAll extends $AsyncMutationBase<
    Map<String, List<HistoryLink>>,
    _$WebSourceFavorites$UpdateAll,
    WebSourceFavorites> implements WebSourceFavorites$UpdateAll {
  _$WebSourceFavorites$UpdateAll(this.element, {super.state, super.key});

  @override
  final _$WebSourceFavoritesElement element;

  @override
  $ElementLense<_$WebSourceFavorites$UpdateAll> get listenable =>
      element._$updateAll;

  @override
  Future<Map<String, List<HistoryLink>>> call(HistoryLink link) {
    return mutateAsync(
      Invocation.method(
        #updateAll,
        [link],
      ),
      ($notifier) => $notifier.updateAll(
        link,
      ),
    );
  }

  @override
  _$WebSourceFavorites$UpdateAll copyWith(
          MutationState<Map<String, List<HistoryLink>>> state,
          {Object? key}) =>
      _$WebSourceFavorites$UpdateAll(element, state: state, key: key);
}

sealed class WebSourceFavorites$Remove
    extends MutationBase<Map<String, List<HistoryLink>>> {
  /// Starts the mutation.
  ///
  /// This will first set the state to [PendingMutationState], then
  /// will call [WebSourceFavorites.remove] with the provided parameters.
  ///
  /// After the method completes, the mutation state will be updated to either
  /// [SuccessMutationState] or [ErrorMutationState] based on if the method
  /// threw or not.
  ///
  /// Lastly, if the method completes without throwing, the Notifier's state
  /// will be updated with the new value.
  ///
  /// **Note**:
  /// If the notifier threw in its constructor, the mutation won't start
  /// and [call] will throw.
  /// This should generally never happen though, as Notifiers are not supposed
  /// to have logic in their constructors.
  Future<Map<String, List<HistoryLink>>> call(
      String category, HistoryLink link);
}

final class _$WebSourceFavorites$Remove extends $AsyncMutationBase<
    Map<String, List<HistoryLink>>,
    _$WebSourceFavorites$Remove,
    WebSourceFavorites> implements WebSourceFavorites$Remove {
  _$WebSourceFavorites$Remove(this.element, {super.state, super.key});

  @override
  final _$WebSourceFavoritesElement element;

  @override
  $ElementLense<_$WebSourceFavorites$Remove> get listenable => element._$remove;

  @override
  Future<Map<String, List<HistoryLink>>> call(
      String category, HistoryLink link) {
    return mutateAsync(
      Invocation.method(
        #remove,
        [category, link],
      ),
      ($notifier) => $notifier.remove(
        category,
        link,
      ),
    );
  }

  @override
  _$WebSourceFavorites$Remove copyWith(
          MutationState<Map<String, List<HistoryLink>>> state,
          {Object? key}) =>
      _$WebSourceFavorites$Remove(element, state: state, key: key);
}

sealed class WebSourceFavorites$UpdateList
    extends MutationBase<Map<String, List<HistoryLink>>> {
  /// Starts the mutation.
  ///
  /// This will first set the state to [PendingMutationState], then
  /// will call [WebSourceFavorites.updateList] with the provided parameters.
  ///
  /// After the method completes, the mutation state will be updated to either
  /// [SuccessMutationState] or [ErrorMutationState] based on if the method
  /// threw or not.
  ///
  /// Lastly, if the method completes without throwing, the Notifier's state
  /// will be updated with the new value.
  ///
  /// **Note**:
  /// If the notifier threw in its constructor, the mutation won't start
  /// and [call] will throw.
  /// This should generally never happen though, as Notifiers are not supposed
  /// to have logic in their constructors.
  Future<Map<String, List<HistoryLink>>> call(
      String category, int oldIndex, int newIndex);
}

final class _$WebSourceFavorites$UpdateList extends $AsyncMutationBase<
    Map<String, List<HistoryLink>>,
    _$WebSourceFavorites$UpdateList,
    WebSourceFavorites> implements WebSourceFavorites$UpdateList {
  _$WebSourceFavorites$UpdateList(this.element, {super.state, super.key});

  @override
  final _$WebSourceFavoritesElement element;

  @override
  $ElementLense<_$WebSourceFavorites$UpdateList> get listenable =>
      element._$updateList;

  @override
  Future<Map<String, List<HistoryLink>>> call(
      String category, int oldIndex, int newIndex) {
    return mutateAsync(
      Invocation.method(
        #updateList,
        [category, oldIndex, newIndex],
      ),
      ($notifier) => $notifier.updateList(
        category,
        oldIndex,
        newIndex,
      ),
    );
  }

  @override
  _$WebSourceFavorites$UpdateList copyWith(
          MutationState<Map<String, List<HistoryLink>>> state,
          {Object? key}) =>
      _$WebSourceFavorites$UpdateList(element, state: state, key: key);
}

sealed class WebSourceFavorites$ReconfigureCategories
    extends MutationBase<Map<String, List<HistoryLink>>> {
  /// Starts the mutation.
  ///
  /// This will first set the state to [PendingMutationState], then
  /// will call [WebSourceFavorites.reconfigureCategories] with the provided parameters.
  ///
  /// After the method completes, the mutation state will be updated to either
  /// [SuccessMutationState] or [ErrorMutationState] based on if the method
  /// threw or not.
  ///
  /// Lastly, if the method completes without throwing, the Notifier's state
  /// will be updated with the new value.
  ///
  /// **Note**:
  /// If the notifier threw in its constructor, the mutation won't start
  /// and [call] will throw.
  /// This should generally never happen though, as Notifiers are not supposed
  /// to have logic in their constructors.
  Future<Map<String, List<HistoryLink>>> call(
      List<WebSourceCategory> categories, String defaultCategory);
}

final class _$WebSourceFavorites$ReconfigureCategories
    extends $AsyncMutationBase<Map<String, List<HistoryLink>>,
        _$WebSourceFavorites$ReconfigureCategories, WebSourceFavorites>
    implements WebSourceFavorites$ReconfigureCategories {
  _$WebSourceFavorites$ReconfigureCategories(this.element,
      {super.state, super.key});

  @override
  final _$WebSourceFavoritesElement element;

  @override
  $ElementLense<_$WebSourceFavorites$ReconfigureCategories> get listenable =>
      element._$reconfigureCategories;

  @override
  Future<Map<String, List<HistoryLink>>> call(
      List<WebSourceCategory> categories, String defaultCategory) {
    return mutateAsync(
      Invocation.method(
        #reconfigureCategories,
        [categories, defaultCategory],
      ),
      ($notifier) => $notifier.reconfigureCategories(
        categories,
        defaultCategory,
      ),
    );
  }

  @override
  _$WebSourceFavorites$ReconfigureCategories copyWith(
          MutationState<Map<String, List<HistoryLink>>> state,
          {Object? key}) =>
      _$WebSourceFavorites$ReconfigureCategories(element,
          state: state, key: key);
}

@ProviderFor(WebSourceHistory)
const webSourceHistoryProvider = WebSourceHistoryProvider._();

final class WebSourceHistoryProvider
    extends $AsyncNotifierProvider<WebSourceHistory, Queue<HistoryLink>> {
  const WebSourceHistoryProvider._(
      {super.runNotifierBuildOverride, WebSourceHistory Function()? create})
      : _createCb = create,
        super(
          from: null,
          argument: null,
          retry: null,
          name: r'webSourceHistoryProvider',
          isAutoDispose: false,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final WebSourceHistory Function()? _createCb;

  @override
  String debugGetCreateSourceHash() => _$webSourceHistoryHash();

  @$internal
  @override
  WebSourceHistory create() => _createCb?.call() ?? WebSourceHistory();

  @$internal
  @override
  WebSourceHistoryProvider $copyWithCreate(
    WebSourceHistory Function() create,
  ) {
    return WebSourceHistoryProvider._(create: create);
  }

  @$internal
  @override
  WebSourceHistoryProvider $copyWithBuild(
    FutureOr<Queue<HistoryLink>> Function(
      Ref,
      WebSourceHistory,
    ) build,
  ) {
    return WebSourceHistoryProvider._(runNotifierBuildOverride: build);
  }

  @$internal
  @override
  _$WebSourceHistoryElement $createElement($ProviderPointer pointer) =>
      _$WebSourceHistoryElement(this, pointer);

  ProviderListenable<WebSourceHistory$Clear> get clear => $LazyProxyListenable<
          WebSourceHistory$Clear, AsyncValue<Queue<HistoryLink>>>(
        this,
        (element) {
          element as _$WebSourceHistoryElement;

          return element._$clear;
        },
      );

  ProviderListenable<WebSourceHistory$Add> get add => $LazyProxyListenable<
          WebSourceHistory$Add, AsyncValue<Queue<HistoryLink>>>(
        this,
        (element) {
          element as _$WebSourceHistoryElement;

          return element._$add;
        },
      );

  ProviderListenable<WebSourceHistory$Remove> get remove =>
      $LazyProxyListenable<WebSourceHistory$Remove,
          AsyncValue<Queue<HistoryLink>>>(
        this,
        (element) {
          element as _$WebSourceHistoryElement;

          return element._$remove;
        },
      );
}

String _$webSourceHistoryHash() => r'aa0bafe0916acfa2bb4983818dcda81b42b35fbc';

abstract class _$WebSourceHistory extends $AsyncNotifier<Queue<HistoryLink>> {
  FutureOr<Queue<HistoryLink>> build();
  @$internal
  @override
  FutureOr<Queue<HistoryLink>> runBuild() => build();
}

class _$WebSourceHistoryElement extends $AsyncNotifierProviderElement<
    WebSourceHistory, Queue<HistoryLink>> {
  _$WebSourceHistoryElement(super.provider, super.pointer) {
    _$clear.result = $Result.data(_$WebSourceHistory$Clear(this));
    _$add.result = $Result.data(_$WebSourceHistory$Add(this));
    _$remove.result = $Result.data(_$WebSourceHistory$Remove(this));
  }
  final _$clear = $ElementLense<_$WebSourceHistory$Clear>();
  final _$add = $ElementLense<_$WebSourceHistory$Add>();
  final _$remove = $ElementLense<_$WebSourceHistory$Remove>();
  @override
  void mount() {
    super.mount();
    _$clear.result!.stateOrNull!.reset();
    _$add.result!.stateOrNull!.reset();
    _$remove.result!.stateOrNull!.reset();
  }

  @override
  void visitChildren({
    required void Function(ProviderElement element) elementVisitor,
    required void Function($ElementLense element) listenableVisitor,
  }) {
    super.visitChildren(
      elementVisitor: elementVisitor,
      listenableVisitor: listenableVisitor,
    );

    listenableVisitor(_$clear);
    listenableVisitor(_$add);
    listenableVisitor(_$remove);
  }
}

sealed class WebSourceHistory$Clear extends MutationBase<Queue<HistoryLink>> {
  /// Starts the mutation.
  ///
  /// This will first set the state to [PendingMutationState], then
  /// will call [WebSourceHistory.clear] with the provided parameters.
  ///
  /// After the method completes, the mutation state will be updated to either
  /// [SuccessMutationState] or [ErrorMutationState] based on if the method
  /// threw or not.
  ///
  /// Lastly, if the method completes without throwing, the Notifier's state
  /// will be updated with the new value.
  ///
  /// **Note**:
  /// If the notifier threw in its constructor, the mutation won't start
  /// and [call] will throw.
  /// This should generally never happen though, as Notifiers are not supposed
  /// to have logic in their constructors.
  Future<Queue<HistoryLink>> call();
}

final class _$WebSourceHistory$Clear extends $AsyncMutationBase<
    Queue<HistoryLink>,
    _$WebSourceHistory$Clear,
    WebSourceHistory> implements WebSourceHistory$Clear {
  _$WebSourceHistory$Clear(this.element, {super.state, super.key});

  @override
  final _$WebSourceHistoryElement element;

  @override
  $ElementLense<_$WebSourceHistory$Clear> get listenable => element._$clear;

  @override
  Future<Queue<HistoryLink>> call() {
    return mutateAsync(
      Invocation.method(
        #clear,
        [],
      ),
      ($notifier) => $notifier.clear(),
    );
  }

  @override
  _$WebSourceHistory$Clear copyWith(MutationState<Queue<HistoryLink>> state,
          {Object? key}) =>
      _$WebSourceHistory$Clear(element, state: state, key: key);
}

sealed class WebSourceHistory$Add extends MutationBase<Queue<HistoryLink>> {
  /// Starts the mutation.
  ///
  /// This will first set the state to [PendingMutationState], then
  /// will call [WebSourceHistory.add] with the provided parameters.
  ///
  /// After the method completes, the mutation state will be updated to either
  /// [SuccessMutationState] or [ErrorMutationState] based on if the method
  /// threw or not.
  ///
  /// Lastly, if the method completes without throwing, the Notifier's state
  /// will be updated with the new value.
  ///
  /// **Note**:
  /// If the notifier threw in its constructor, the mutation won't start
  /// and [call] will throw.
  /// This should generally never happen though, as Notifiers are not supposed
  /// to have logic in their constructors.
  Future<Queue<HistoryLink>> call(HistoryLink link);
}

final class _$WebSourceHistory$Add extends $AsyncMutationBase<
    Queue<HistoryLink>,
    _$WebSourceHistory$Add,
    WebSourceHistory> implements WebSourceHistory$Add {
  _$WebSourceHistory$Add(this.element, {super.state, super.key});

  @override
  final _$WebSourceHistoryElement element;

  @override
  $ElementLense<_$WebSourceHistory$Add> get listenable => element._$add;

  @override
  Future<Queue<HistoryLink>> call(HistoryLink link) {
    return mutateAsync(
      Invocation.method(
        #add,
        [link],
      ),
      ($notifier) => $notifier.add(
        link,
      ),
    );
  }

  @override
  _$WebSourceHistory$Add copyWith(MutationState<Queue<HistoryLink>> state,
          {Object? key}) =>
      _$WebSourceHistory$Add(element, state: state, key: key);
}

sealed class WebSourceHistory$Remove extends MutationBase<Queue<HistoryLink>> {
  /// Starts the mutation.
  ///
  /// This will first set the state to [PendingMutationState], then
  /// will call [WebSourceHistory.remove] with the provided parameters.
  ///
  /// After the method completes, the mutation state will be updated to either
  /// [SuccessMutationState] or [ErrorMutationState] based on if the method
  /// threw or not.
  ///
  /// Lastly, if the method completes without throwing, the Notifier's state
  /// will be updated with the new value.
  ///
  /// **Note**:
  /// If the notifier threw in its constructor, the mutation won't start
  /// and [call] will throw.
  /// This should generally never happen though, as Notifiers are not supposed
  /// to have logic in their constructors.
  Future<Queue<HistoryLink>> call(HistoryLink link);
}

final class _$WebSourceHistory$Remove extends $AsyncMutationBase<
    Queue<HistoryLink>,
    _$WebSourceHistory$Remove,
    WebSourceHistory> implements WebSourceHistory$Remove {
  _$WebSourceHistory$Remove(this.element, {super.state, super.key});

  @override
  final _$WebSourceHistoryElement element;

  @override
  $ElementLense<_$WebSourceHistory$Remove> get listenable => element._$remove;

  @override
  Future<Queue<HistoryLink>> call(HistoryLink link) {
    return mutateAsync(
      Invocation.method(
        #remove,
        [link],
      ),
      ($notifier) => $notifier.remove(
        link,
      ),
    );
  }

  @override
  _$WebSourceHistory$Remove copyWith(MutationState<Queue<HistoryLink>> state,
          {Object? key}) =>
      _$WebSourceHistory$Remove(element, state: state, key: key);
}

@ProviderFor(WebReadMarkers)
const webReadMarkersProvider = WebReadMarkersProvider._();

final class WebReadMarkersProvider
    extends $AsyncNotifierProvider<WebReadMarkers, Map<String, Set<String>>> {
  const WebReadMarkersProvider._(
      {super.runNotifierBuildOverride, WebReadMarkers Function()? create})
      : _createCb = create,
        super(
          from: null,
          argument: null,
          retry: null,
          name: r'webReadMarkersProvider',
          isAutoDispose: false,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final WebReadMarkers Function()? _createCb;

  @override
  String debugGetCreateSourceHash() => _$webReadMarkersHash();

  @$internal
  @override
  WebReadMarkers create() => _createCb?.call() ?? WebReadMarkers();

  @$internal
  @override
  WebReadMarkersProvider $copyWithCreate(
    WebReadMarkers Function() create,
  ) {
    return WebReadMarkersProvider._(create: create);
  }

  @$internal
  @override
  WebReadMarkersProvider $copyWithBuild(
    FutureOr<Map<String, Set<String>>> Function(
      Ref,
      WebReadMarkers,
    ) build,
  ) {
    return WebReadMarkersProvider._(runNotifierBuildOverride: build);
  }

  @$internal
  @override
  _$WebReadMarkersElement $createElement($ProviderPointer pointer) =>
      _$WebReadMarkersElement(this, pointer);

  ProviderListenable<WebReadMarkers$Clear> get clear => $LazyProxyListenable<
          WebReadMarkers$Clear, AsyncValue<Map<String, Set<String>>>>(
        this,
        (element) {
          element as _$WebReadMarkersElement;

          return element._$clear;
        },
      );

  ProviderListenable<WebReadMarkers$Set> get set => $LazyProxyListenable<
          WebReadMarkers$Set, AsyncValue<Map<String, Set<String>>>>(
        this,
        (element) {
          element as _$WebReadMarkersElement;

          return element._$set;
        },
      );

  ProviderListenable<WebReadMarkers$SetBulk> get setBulk =>
      $LazyProxyListenable<WebReadMarkers$SetBulk,
          AsyncValue<Map<String, Set<String>>>>(
        this,
        (element) {
          element as _$WebReadMarkersElement;

          return element._$setBulk;
        },
      );

  ProviderListenable<WebReadMarkers$DeleteKey> get deleteKey =>
      $LazyProxyListenable<WebReadMarkers$DeleteKey,
          AsyncValue<Map<String, Set<String>>>>(
        this,
        (element) {
          element as _$WebReadMarkersElement;

          return element._$deleteKey;
        },
      );
}

String _$webReadMarkersHash() => r'9119a7b9453a07c05a184ff46966ab530728ad92';

abstract class _$WebReadMarkers
    extends $AsyncNotifier<Map<String, Set<String>>> {
  FutureOr<Map<String, Set<String>>> build();
  @$internal
  @override
  FutureOr<Map<String, Set<String>>> runBuild() => build();
}

class _$WebReadMarkersElement extends $AsyncNotifierProviderElement<
    WebReadMarkers, Map<String, Set<String>>> {
  _$WebReadMarkersElement(super.provider, super.pointer) {
    _$clear.result = $Result.data(_$WebReadMarkers$Clear(this));
    _$set.result = $Result.data(_$WebReadMarkers$Set(this));
    _$setBulk.result = $Result.data(_$WebReadMarkers$SetBulk(this));
    _$deleteKey.result = $Result.data(_$WebReadMarkers$DeleteKey(this));
  }
  final _$clear = $ElementLense<_$WebReadMarkers$Clear>();
  final _$set = $ElementLense<_$WebReadMarkers$Set>();
  final _$setBulk = $ElementLense<_$WebReadMarkers$SetBulk>();
  final _$deleteKey = $ElementLense<_$WebReadMarkers$DeleteKey>();
  @override
  void mount() {
    super.mount();
    _$clear.result!.stateOrNull!.reset();
    _$set.result!.stateOrNull!.reset();
    _$setBulk.result!.stateOrNull!.reset();
    _$deleteKey.result!.stateOrNull!.reset();
  }

  @override
  void visitChildren({
    required void Function(ProviderElement element) elementVisitor,
    required void Function($ElementLense element) listenableVisitor,
  }) {
    super.visitChildren(
      elementVisitor: elementVisitor,
      listenableVisitor: listenableVisitor,
    );

    listenableVisitor(_$clear);
    listenableVisitor(_$set);
    listenableVisitor(_$setBulk);
    listenableVisitor(_$deleteKey);
  }
}

sealed class WebReadMarkers$Clear
    extends MutationBase<Map<String, Set<String>>> {
  /// Starts the mutation.
  ///
  /// This will first set the state to [PendingMutationState], then
  /// will call [WebReadMarkers.clear] with the provided parameters.
  ///
  /// After the method completes, the mutation state will be updated to either
  /// [SuccessMutationState] or [ErrorMutationState] based on if the method
  /// threw or not.
  ///
  /// Lastly, if the method completes without throwing, the Notifier's state
  /// will be updated with the new value.
  ///
  /// **Note**:
  /// If the notifier threw in its constructor, the mutation won't start
  /// and [call] will throw.
  /// This should generally never happen though, as Notifiers are not supposed
  /// to have logic in their constructors.
  Future<Map<String, Set<String>>> call();
}

final class _$WebReadMarkers$Clear extends $AsyncMutationBase<
    Map<String, Set<String>>,
    _$WebReadMarkers$Clear,
    WebReadMarkers> implements WebReadMarkers$Clear {
  _$WebReadMarkers$Clear(this.element, {super.state, super.key});

  @override
  final _$WebReadMarkersElement element;

  @override
  $ElementLense<_$WebReadMarkers$Clear> get listenable => element._$clear;

  @override
  Future<Map<String, Set<String>>> call() {
    return mutateAsync(
      Invocation.method(
        #clear,
        [],
      ),
      ($notifier) => $notifier.clear(),
    );
  }

  @override
  _$WebReadMarkers$Clear copyWith(MutationState<Map<String, Set<String>>> state,
          {Object? key}) =>
      _$WebReadMarkers$Clear(element, state: state, key: key);
}

sealed class WebReadMarkers$Set extends MutationBase<Map<String, Set<String>>> {
  /// Starts the mutation.
  ///
  /// This will first set the state to [PendingMutationState], then
  /// will call [WebReadMarkers.set] with the provided parameters.
  ///
  /// After the method completes, the mutation state will be updated to either
  /// [SuccessMutationState] or [ErrorMutationState] based on if the method
  /// threw or not.
  ///
  /// Lastly, if the method completes without throwing, the Notifier's state
  /// will be updated with the new value.
  ///
  /// **Note**:
  /// If the notifier threw in its constructor, the mutation won't start
  /// and [call] will throw.
  /// This should generally never happen though, as Notifiers are not supposed
  /// to have logic in their constructors.
  Future<Map<String, Set<String>>> call(
      String manga, String chapter, bool setRead);
}

final class _$WebReadMarkers$Set extends $AsyncMutationBase<
    Map<String, Set<String>>,
    _$WebReadMarkers$Set,
    WebReadMarkers> implements WebReadMarkers$Set {
  _$WebReadMarkers$Set(this.element, {super.state, super.key});

  @override
  final _$WebReadMarkersElement element;

  @override
  $ElementLense<_$WebReadMarkers$Set> get listenable => element._$set;

  @override
  Future<Map<String, Set<String>>> call(
      String manga, String chapter, bool setRead) {
    return mutateAsync(
      Invocation.method(
        #set,
        [manga, chapter, setRead],
      ),
      ($notifier) => $notifier.set(
        manga,
        chapter,
        setRead,
      ),
    );
  }

  @override
  _$WebReadMarkers$Set copyWith(MutationState<Map<String, Set<String>>> state,
          {Object? key}) =>
      _$WebReadMarkers$Set(element, state: state, key: key);
}

sealed class WebReadMarkers$SetBulk
    extends MutationBase<Map<String, Set<String>>> {
  /// Starts the mutation.
  ///
  /// This will first set the state to [PendingMutationState], then
  /// will call [WebReadMarkers.setBulk] with the provided parameters.
  ///
  /// After the method completes, the mutation state will be updated to either
  /// [SuccessMutationState] or [ErrorMutationState] based on if the method
  /// threw or not.
  ///
  /// Lastly, if the method completes without throwing, the Notifier's state
  /// will be updated with the new value.
  ///
  /// **Note**:
  /// If the notifier threw in its constructor, the mutation won't start
  /// and [call] will throw.
  /// This should generally never happen though, as Notifiers are not supposed
  /// to have logic in their constructors.
  Future<Map<String, Set<String>>> call(String manga,
      {Iterable<String>? read, Iterable<String>? unread});
}

final class _$WebReadMarkers$SetBulk extends $AsyncMutationBase<
    Map<String, Set<String>>,
    _$WebReadMarkers$SetBulk,
    WebReadMarkers> implements WebReadMarkers$SetBulk {
  _$WebReadMarkers$SetBulk(this.element, {super.state, super.key});

  @override
  final _$WebReadMarkersElement element;

  @override
  $ElementLense<_$WebReadMarkers$SetBulk> get listenable => element._$setBulk;

  @override
  Future<Map<String, Set<String>>> call(String manga,
      {Iterable<String>? read, Iterable<String>? unread}) {
    return mutateAsync(
      Invocation.method(#setBulk, [manga], {#read: read, #unread: unread}),
      ($notifier) => $notifier.setBulk(
        manga,
        read: read,
        unread: unread,
      ),
    );
  }

  @override
  _$WebReadMarkers$SetBulk copyWith(
          MutationState<Map<String, Set<String>>> state,
          {Object? key}) =>
      _$WebReadMarkers$SetBulk(element, state: state, key: key);
}

sealed class WebReadMarkers$DeleteKey
    extends MutationBase<Map<String, Set<String>>> {
  /// Starts the mutation.
  ///
  /// This will first set the state to [PendingMutationState], then
  /// will call [WebReadMarkers.deleteKey] with the provided parameters.
  ///
  /// After the method completes, the mutation state will be updated to either
  /// [SuccessMutationState] or [ErrorMutationState] based on if the method
  /// threw or not.
  ///
  /// Lastly, if the method completes without throwing, the Notifier's state
  /// will be updated with the new value.
  ///
  /// **Note**:
  /// If the notifier threw in its constructor, the mutation won't start
  /// and [call] will throw.
  /// This should generally never happen though, as Notifiers are not supposed
  /// to have logic in their constructors.
  Future<Map<String, Set<String>>> call(String manga);
}

final class _$WebReadMarkers$DeleteKey extends $AsyncMutationBase<
    Map<String, Set<String>>,
    _$WebReadMarkers$DeleteKey,
    WebReadMarkers> implements WebReadMarkers$DeleteKey {
  _$WebReadMarkers$DeleteKey(this.element, {super.state, super.key});

  @override
  final _$WebReadMarkersElement element;

  @override
  $ElementLense<_$WebReadMarkers$DeleteKey> get listenable =>
      element._$deleteKey;

  @override
  Future<Map<String, Set<String>>> call(String manga) {
    return mutateAsync(
      Invocation.method(
        #deleteKey,
        [manga],
      ),
      ($notifier) => $notifier.deleteKey(
        manga,
      ),
    );
  }

  @override
  _$WebReadMarkers$DeleteKey copyWith(
          MutationState<Map<String, Set<String>>> state,
          {Object? key}) =>
      _$WebReadMarkers$DeleteKey(element, state: state, key: key);
}

@ProviderFor(WebSourceManager)
const webSourceManagerProvider = WebSourceManagerProvider._();

final class WebSourceManagerProvider
    extends $AsyncNotifierProvider<WebSourceManager, WebSource?> {
  const WebSourceManagerProvider._(
      {super.runNotifierBuildOverride, WebSourceManager Function()? create})
      : _createCb = create,
        super(
          from: null,
          argument: null,
          retry: null,
          name: r'webSourceManagerProvider',
          isAutoDispose: false,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final WebSourceManager Function()? _createCb;

  @override
  String debugGetCreateSourceHash() => _$webSourceManagerHash();

  @$internal
  @override
  WebSourceManager create() => _createCb?.call() ?? WebSourceManager();

  @$internal
  @override
  WebSourceManagerProvider $copyWithCreate(
    WebSourceManager Function() create,
  ) {
    return WebSourceManagerProvider._(create: create);
  }

  @$internal
  @override
  WebSourceManagerProvider $copyWithBuild(
    FutureOr<WebSource?> Function(
      Ref,
      WebSourceManager,
    ) build,
  ) {
    return WebSourceManagerProvider._(runNotifierBuildOverride: build);
  }

  @$internal
  @override
  $AsyncNotifierProviderElement<WebSourceManager, WebSource?> $createElement(
          $ProviderPointer pointer) =>
      $AsyncNotifierProviderElement(this, pointer);
}

String _$webSourceManagerHash() => r'e323b9fdc5ff416f2c734bd52a39d1bc512fa80d';

abstract class _$WebSourceManager extends $AsyncNotifier<WebSource?> {
  FutureOr<WebSource?> build();
  @$internal
  @override
  FutureOr<WebSource?> runBuild() => build();
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
