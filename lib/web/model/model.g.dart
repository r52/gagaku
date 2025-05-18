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
  const ProxyProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'proxyProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$proxyHash();

  @$internal
  @override
  $ProviderElement<ProxyHandler> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ProxyHandler create(Ref ref) {
    return proxy(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProxyHandler value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $ValueProvider<ProxyHandler>(value),
    );
  }
}

String _$proxyHash() => r'8a4e90bb9775641c76f0be18ce9750786e3b2a4b';

@ProviderFor(WebSourceFavorites)
const webSourceFavoritesProvider = WebSourceFavoritesProvider._();

final class WebSourceFavoritesProvider
    extends
        $AsyncNotifierProvider<
          WebSourceFavorites,
          Map<String, List<HistoryLink>>
        > {
  const WebSourceFavoritesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'webSourceFavoritesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$webSourceFavoritesHash();

  @$internal
  @override
  WebSourceFavorites create() => WebSourceFavorites();

  @$internal
  @override
  _$WebSourceFavoritesElement $createElement($ProviderPointer pointer) =>
      _$WebSourceFavoritesElement(pointer);

  ProviderListenable<WebSourceFavorites$Clear> get clear =>
      $LazyProxyListenable<
        WebSourceFavorites$Clear,
        AsyncValue<Map<String, List<HistoryLink>>>
      >(this, (element) {
        element as _$WebSourceFavoritesElement;

        return element._$clear;
      });

  ProviderListenable<WebSourceFavorites$Add> get add => $LazyProxyListenable<
    WebSourceFavorites$Add,
    AsyncValue<Map<String, List<HistoryLink>>>
  >(this, (element) {
    element as _$WebSourceFavoritesElement;

    return element._$add;
  });

  ProviderListenable<WebSourceFavorites$UpdateAll> get updateAll =>
      $LazyProxyListenable<
        WebSourceFavorites$UpdateAll,
        AsyncValue<Map<String, List<HistoryLink>>>
      >(this, (element) {
        element as _$WebSourceFavoritesElement;

        return element._$updateAll;
      });

  ProviderListenable<WebSourceFavorites$Remove> get remove =>
      $LazyProxyListenable<
        WebSourceFavorites$Remove,
        AsyncValue<Map<String, List<HistoryLink>>>
      >(this, (element) {
        element as _$WebSourceFavoritesElement;

        return element._$remove;
      });

  ProviderListenable<WebSourceFavorites$UpdateList> get updateList =>
      $LazyProxyListenable<
        WebSourceFavorites$UpdateList,
        AsyncValue<Map<String, List<HistoryLink>>>
      >(this, (element) {
        element as _$WebSourceFavoritesElement;

        return element._$updateList;
      });

  ProviderListenable<WebSourceFavorites$ReconfigureCategories>
  get reconfigureCategories => $LazyProxyListenable<
    WebSourceFavorites$ReconfigureCategories,
    AsyncValue<Map<String, List<HistoryLink>>>
  >(this, (element) {
    element as _$WebSourceFavoritesElement;

    return element._$reconfigureCategories;
  });
}

String _$webSourceFavoritesHash() =>
    r'8137b1e005f2e3136eba62b09dd9529beaa16f80';

abstract class _$WebSourceFavorites
    extends $AsyncNotifier<Map<String, List<HistoryLink>>> {
  FutureOr<Map<String, List<HistoryLink>>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<Map<String, List<HistoryLink>>>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Map<String, List<HistoryLink>>>>,
              AsyncValue<Map<String, List<HistoryLink>>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

class _$WebSourceFavoritesElement
    extends
        $AsyncNotifierProviderElement<
          WebSourceFavorites,
          Map<String, List<HistoryLink>>
        > {
  _$WebSourceFavoritesElement(super.pointer) {
    _$clear.result = $Result.data(_$WebSourceFavorites$Clear(this));
    _$add.result = $Result.data(_$WebSourceFavorites$Add(this));
    _$updateAll.result = $Result.data(_$WebSourceFavorites$UpdateAll(this));
    _$remove.result = $Result.data(_$WebSourceFavorites$Remove(this));
    _$updateList.result = $Result.data(_$WebSourceFavorites$UpdateList(this));
    _$reconfigureCategories.result = $Result.data(
      _$WebSourceFavorites$ReconfigureCategories(this),
    );
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
    _$clear.result!.value!.reset();
    _$add.result!.value!.reset();
    _$updateAll.result!.value!.reset();
    _$remove.result!.value!.reset();
    _$updateList.result!.value!.reset();
    _$reconfigureCategories.result!.value!.reset();
  }

  @override
  void visitListenables(
    void Function($ElementLense element) listenableVisitor,
  ) {
    super.visitListenables(listenableVisitor);

    listenableVisitor(_$clear);
    listenableVisitor(_$add);
    listenableVisitor(_$updateAll);
    listenableVisitor(_$remove);
    listenableVisitor(_$updateList);
    listenableVisitor(_$reconfigureCategories);
  }
}

sealed class WebSourceFavorites$Clear extends MutationBase<void> {
  /// Starts the mutation.
  ///
  /// This will first set the state to [PendingMutation], then
  /// will call [WebSourceFavorites.clear] with the provided parameters.
  ///
  /// After the method completes, the mutation state will be updated to either
  /// [SuccessMutation] or [ErrorMutation] based on if the method
  /// threw or not.
  ///
  /// **Note**:
  /// If the notifier threw in its constructor, the mutation won't start
  /// and [call] will throw.
  /// This should generally never happen though, as Notifiers are not supposed
  /// to have logic in their constructors.
  Future<void> call();
}

final class _$WebSourceFavorites$Clear
    extends
        $AsyncMutationBase<void, _$WebSourceFavorites$Clear, WebSourceFavorites>
    implements WebSourceFavorites$Clear {
  _$WebSourceFavorites$Clear(this.element, {super.state, super.key});

  @override
  final _$WebSourceFavoritesElement element;

  @override
  $ElementLense<_$WebSourceFavorites$Clear> get listenable => element._$clear;

  @override
  Future<void> call() {
    return mutate(
      Invocation.method(#clear, []),
      ($notifier) => $notifier.clear(),
    );
  }

  @override
  _$WebSourceFavorites$Clear copyWith(
    MutationState<void> state, {
    Object? key,
  }) => _$WebSourceFavorites$Clear(element, state: state, key: key);
}

sealed class WebSourceFavorites$Add
    extends MutationBase<Map<String, List<HistoryLink>>> {
  /// Starts the mutation.
  ///
  /// This will first set the state to [PendingMutation], then
  /// will call [WebSourceFavorites.add] with the provided parameters.
  ///
  /// After the method completes, the mutation state will be updated to either
  /// [SuccessMutation] or [ErrorMutation] based on if the method
  /// threw or not.
  ///
  /// **Note**:
  /// If the notifier threw in its constructor, the mutation won't start
  /// and [call] will throw.
  /// This should generally never happen though, as Notifiers are not supposed
  /// to have logic in their constructors.
  Future<Map<String, List<HistoryLink>>> call(
    String category,
    HistoryLink link,
  );
}

final class _$WebSourceFavorites$Add
    extends
        $AsyncMutationBase<
          Map<String, List<HistoryLink>>,
          _$WebSourceFavorites$Add,
          WebSourceFavorites
        >
    implements WebSourceFavorites$Add {
  _$WebSourceFavorites$Add(this.element, {super.state, super.key});

  @override
  final _$WebSourceFavoritesElement element;

  @override
  $ElementLense<_$WebSourceFavorites$Add> get listenable => element._$add;

  @override
  Future<Map<String, List<HistoryLink>>> call(
    String category,
    HistoryLink link,
  ) {
    return mutate(
      Invocation.method(#add, [category, link]),
      ($notifier) => $notifier.add(category, link),
    );
  }

  @override
  _$WebSourceFavorites$Add copyWith(
    MutationState<Map<String, List<HistoryLink>>> state, {
    Object? key,
  }) => _$WebSourceFavorites$Add(element, state: state, key: key);
}

sealed class WebSourceFavorites$UpdateAll
    extends MutationBase<Map<String, List<HistoryLink>>> {
  /// Starts the mutation.
  ///
  /// This will first set the state to [PendingMutation], then
  /// will call [WebSourceFavorites.updateAll] with the provided parameters.
  ///
  /// After the method completes, the mutation state will be updated to either
  /// [SuccessMutation] or [ErrorMutation] based on if the method
  /// threw or not.
  ///
  /// **Note**:
  /// If the notifier threw in its constructor, the mutation won't start
  /// and [call] will throw.
  /// This should generally never happen though, as Notifiers are not supposed
  /// to have logic in their constructors.
  Future<Map<String, List<HistoryLink>>> call(HistoryLink link);
}

final class _$WebSourceFavorites$UpdateAll
    extends
        $AsyncMutationBase<
          Map<String, List<HistoryLink>>,
          _$WebSourceFavorites$UpdateAll,
          WebSourceFavorites
        >
    implements WebSourceFavorites$UpdateAll {
  _$WebSourceFavorites$UpdateAll(this.element, {super.state, super.key});

  @override
  final _$WebSourceFavoritesElement element;

  @override
  $ElementLense<_$WebSourceFavorites$UpdateAll> get listenable =>
      element._$updateAll;

  @override
  Future<Map<String, List<HistoryLink>>> call(HistoryLink link) {
    return mutate(
      Invocation.method(#updateAll, [link]),
      ($notifier) => $notifier.updateAll(link),
    );
  }

  @override
  _$WebSourceFavorites$UpdateAll copyWith(
    MutationState<Map<String, List<HistoryLink>>> state, {
    Object? key,
  }) => _$WebSourceFavorites$UpdateAll(element, state: state, key: key);
}

sealed class WebSourceFavorites$Remove
    extends MutationBase<Map<String, List<HistoryLink>>> {
  /// Starts the mutation.
  ///
  /// This will first set the state to [PendingMutation], then
  /// will call [WebSourceFavorites.remove] with the provided parameters.
  ///
  /// After the method completes, the mutation state will be updated to either
  /// [SuccessMutation] or [ErrorMutation] based on if the method
  /// threw or not.
  ///
  /// **Note**:
  /// If the notifier threw in its constructor, the mutation won't start
  /// and [call] will throw.
  /// This should generally never happen though, as Notifiers are not supposed
  /// to have logic in their constructors.
  Future<Map<String, List<HistoryLink>>> call(
    String category,
    HistoryLink link,
  );
}

final class _$WebSourceFavorites$Remove
    extends
        $AsyncMutationBase<
          Map<String, List<HistoryLink>>,
          _$WebSourceFavorites$Remove,
          WebSourceFavorites
        >
    implements WebSourceFavorites$Remove {
  _$WebSourceFavorites$Remove(this.element, {super.state, super.key});

  @override
  final _$WebSourceFavoritesElement element;

  @override
  $ElementLense<_$WebSourceFavorites$Remove> get listenable => element._$remove;

  @override
  Future<Map<String, List<HistoryLink>>> call(
    String category,
    HistoryLink link,
  ) {
    return mutate(
      Invocation.method(#remove, [category, link]),
      ($notifier) => $notifier.remove(category, link),
    );
  }

  @override
  _$WebSourceFavorites$Remove copyWith(
    MutationState<Map<String, List<HistoryLink>>> state, {
    Object? key,
  }) => _$WebSourceFavorites$Remove(element, state: state, key: key);
}

sealed class WebSourceFavorites$UpdateList
    extends MutationBase<Map<String, List<HistoryLink>>> {
  /// Starts the mutation.
  ///
  /// This will first set the state to [PendingMutation], then
  /// will call [WebSourceFavorites.updateList] with the provided parameters.
  ///
  /// After the method completes, the mutation state will be updated to either
  /// [SuccessMutation] or [ErrorMutation] based on if the method
  /// threw or not.
  ///
  /// **Note**:
  /// If the notifier threw in its constructor, the mutation won't start
  /// and [call] will throw.
  /// This should generally never happen though, as Notifiers are not supposed
  /// to have logic in their constructors.
  Future<Map<String, List<HistoryLink>>> call(
    String category,
    int oldIndex,
    int newIndex,
  );
}

final class _$WebSourceFavorites$UpdateList
    extends
        $AsyncMutationBase<
          Map<String, List<HistoryLink>>,
          _$WebSourceFavorites$UpdateList,
          WebSourceFavorites
        >
    implements WebSourceFavorites$UpdateList {
  _$WebSourceFavorites$UpdateList(this.element, {super.state, super.key});

  @override
  final _$WebSourceFavoritesElement element;

  @override
  $ElementLense<_$WebSourceFavorites$UpdateList> get listenable =>
      element._$updateList;

  @override
  Future<Map<String, List<HistoryLink>>> call(
    String category,
    int oldIndex,
    int newIndex,
  ) {
    return mutate(
      Invocation.method(#updateList, [category, oldIndex, newIndex]),
      ($notifier) => $notifier.updateList(category, oldIndex, newIndex),
    );
  }

  @override
  _$WebSourceFavorites$UpdateList copyWith(
    MutationState<Map<String, List<HistoryLink>>> state, {
    Object? key,
  }) => _$WebSourceFavorites$UpdateList(element, state: state, key: key);
}

sealed class WebSourceFavorites$ReconfigureCategories
    extends MutationBase<Map<String, List<HistoryLink>>> {
  /// Starts the mutation.
  ///
  /// This will first set the state to [PendingMutation], then
  /// will call [WebSourceFavorites.reconfigureCategories] with the provided parameters.
  ///
  /// After the method completes, the mutation state will be updated to either
  /// [SuccessMutation] or [ErrorMutation] based on if the method
  /// threw or not.
  ///
  /// **Note**:
  /// If the notifier threw in its constructor, the mutation won't start
  /// and [call] will throw.
  /// This should generally never happen though, as Notifiers are not supposed
  /// to have logic in their constructors.
  Future<Map<String, List<HistoryLink>>> call(
    List<WebSourceCategory> categories,
    String defaultCategory,
  );
}

final class _$WebSourceFavorites$ReconfigureCategories
    extends
        $AsyncMutationBase<
          Map<String, List<HistoryLink>>,
          _$WebSourceFavorites$ReconfigureCategories,
          WebSourceFavorites
        >
    implements WebSourceFavorites$ReconfigureCategories {
  _$WebSourceFavorites$ReconfigureCategories(
    this.element, {
    super.state,
    super.key,
  });

  @override
  final _$WebSourceFavoritesElement element;

  @override
  $ElementLense<_$WebSourceFavorites$ReconfigureCategories> get listenable =>
      element._$reconfigureCategories;

  @override
  Future<Map<String, List<HistoryLink>>> call(
    List<WebSourceCategory> categories,
    String defaultCategory,
  ) {
    return mutate(
      Invocation.method(#reconfigureCategories, [categories, defaultCategory]),
      ($notifier) =>
          $notifier.reconfigureCategories(categories, defaultCategory),
    );
  }

  @override
  _$WebSourceFavorites$ReconfigureCategories copyWith(
    MutationState<Map<String, List<HistoryLink>>> state, {
    Object? key,
  }) => _$WebSourceFavorites$ReconfigureCategories(
    element,
    state: state,
    key: key,
  );
}

@ProviderFor(WebSourceHistory)
const webSourceHistoryProvider = WebSourceHistoryProvider._();

final class WebSourceHistoryProvider
    extends $AsyncNotifierProvider<WebSourceHistory, Queue<HistoryLink>> {
  const WebSourceHistoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'webSourceHistoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$webSourceHistoryHash();

  @$internal
  @override
  WebSourceHistory create() => WebSourceHistory();

  @$internal
  @override
  _$WebSourceHistoryElement $createElement($ProviderPointer pointer) =>
      _$WebSourceHistoryElement(pointer);

  ProviderListenable<WebSourceHistory$Clear> get clear => $LazyProxyListenable<
    WebSourceHistory$Clear,
    AsyncValue<Queue<HistoryLink>>
  >(this, (element) {
    element as _$WebSourceHistoryElement;

    return element._$clear;
  });

  ProviderListenable<WebSourceHistory$Add> get add => $LazyProxyListenable<
    WebSourceHistory$Add,
    AsyncValue<Queue<HistoryLink>>
  >(this, (element) {
    element as _$WebSourceHistoryElement;

    return element._$add;
  });

  ProviderListenable<WebSourceHistory$Remove> get remove =>
      $LazyProxyListenable<
        WebSourceHistory$Remove,
        AsyncValue<Queue<HistoryLink>>
      >(this, (element) {
        element as _$WebSourceHistoryElement;

        return element._$remove;
      });
}

String _$webSourceHistoryHash() => r'5ddf4af099a2b5c48cafa013afd2d0383ca85164';

abstract class _$WebSourceHistory extends $AsyncNotifier<Queue<HistoryLink>> {
  FutureOr<Queue<HistoryLink>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<Queue<HistoryLink>>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Queue<HistoryLink>>>,
              AsyncValue<Queue<HistoryLink>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

class _$WebSourceHistoryElement
    extends
        $AsyncNotifierProviderElement<WebSourceHistory, Queue<HistoryLink>> {
  _$WebSourceHistoryElement(super.pointer) {
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
    _$clear.result!.value!.reset();
    _$add.result!.value!.reset();
    _$remove.result!.value!.reset();
  }

  @override
  void visitListenables(
    void Function($ElementLense element) listenableVisitor,
  ) {
    super.visitListenables(listenableVisitor);

    listenableVisitor(_$clear);
    listenableVisitor(_$add);
    listenableVisitor(_$remove);
  }
}

sealed class WebSourceHistory$Clear extends MutationBase<Queue<HistoryLink>> {
  /// Starts the mutation.
  ///
  /// This will first set the state to [PendingMutation], then
  /// will call [WebSourceHistory.clear] with the provided parameters.
  ///
  /// After the method completes, the mutation state will be updated to either
  /// [SuccessMutation] or [ErrorMutation] based on if the method
  /// threw or not.
  ///
  /// **Note**:
  /// If the notifier threw in its constructor, the mutation won't start
  /// and [call] will throw.
  /// This should generally never happen though, as Notifiers are not supposed
  /// to have logic in their constructors.
  Future<Queue<HistoryLink>> call();
}

final class _$WebSourceHistory$Clear
    extends
        $AsyncMutationBase<
          Queue<HistoryLink>,
          _$WebSourceHistory$Clear,
          WebSourceHistory
        >
    implements WebSourceHistory$Clear {
  _$WebSourceHistory$Clear(this.element, {super.state, super.key});

  @override
  final _$WebSourceHistoryElement element;

  @override
  $ElementLense<_$WebSourceHistory$Clear> get listenable => element._$clear;

  @override
  Future<Queue<HistoryLink>> call() {
    return mutate(
      Invocation.method(#clear, []),
      ($notifier) => $notifier.clear(),
    );
  }

  @override
  _$WebSourceHistory$Clear copyWith(
    MutationState<Queue<HistoryLink>> state, {
    Object? key,
  }) => _$WebSourceHistory$Clear(element, state: state, key: key);
}

sealed class WebSourceHistory$Add extends MutationBase<Queue<HistoryLink>> {
  /// Starts the mutation.
  ///
  /// This will first set the state to [PendingMutation], then
  /// will call [WebSourceHistory.add] with the provided parameters.
  ///
  /// After the method completes, the mutation state will be updated to either
  /// [SuccessMutation] or [ErrorMutation] based on if the method
  /// threw or not.
  ///
  /// **Note**:
  /// If the notifier threw in its constructor, the mutation won't start
  /// and [call] will throw.
  /// This should generally never happen though, as Notifiers are not supposed
  /// to have logic in their constructors.
  Future<Queue<HistoryLink>> call(HistoryLink link);
}

final class _$WebSourceHistory$Add
    extends
        $AsyncMutationBase<
          Queue<HistoryLink>,
          _$WebSourceHistory$Add,
          WebSourceHistory
        >
    implements WebSourceHistory$Add {
  _$WebSourceHistory$Add(this.element, {super.state, super.key});

  @override
  final _$WebSourceHistoryElement element;

  @override
  $ElementLense<_$WebSourceHistory$Add> get listenable => element._$add;

  @override
  Future<Queue<HistoryLink>> call(HistoryLink link) {
    return mutate(
      Invocation.method(#add, [link]),
      ($notifier) => $notifier.add(link),
    );
  }

  @override
  _$WebSourceHistory$Add copyWith(
    MutationState<Queue<HistoryLink>> state, {
    Object? key,
  }) => _$WebSourceHistory$Add(element, state: state, key: key);
}

sealed class WebSourceHistory$Remove extends MutationBase<Queue<HistoryLink>> {
  /// Starts the mutation.
  ///
  /// This will first set the state to [PendingMutation], then
  /// will call [WebSourceHistory.remove] with the provided parameters.
  ///
  /// After the method completes, the mutation state will be updated to either
  /// [SuccessMutation] or [ErrorMutation] based on if the method
  /// threw or not.
  ///
  /// **Note**:
  /// If the notifier threw in its constructor, the mutation won't start
  /// and [call] will throw.
  /// This should generally never happen though, as Notifiers are not supposed
  /// to have logic in their constructors.
  Future<Queue<HistoryLink>> call(HistoryLink link);
}

final class _$WebSourceHistory$Remove
    extends
        $AsyncMutationBase<
          Queue<HistoryLink>,
          _$WebSourceHistory$Remove,
          WebSourceHistory
        >
    implements WebSourceHistory$Remove {
  _$WebSourceHistory$Remove(this.element, {super.state, super.key});

  @override
  final _$WebSourceHistoryElement element;

  @override
  $ElementLense<_$WebSourceHistory$Remove> get listenable => element._$remove;

  @override
  Future<Queue<HistoryLink>> call(HistoryLink link) {
    return mutate(
      Invocation.method(#remove, [link]),
      ($notifier) => $notifier.remove(link),
    );
  }

  @override
  _$WebSourceHistory$Remove copyWith(
    MutationState<Queue<HistoryLink>> state, {
    Object? key,
  }) => _$WebSourceHistory$Remove(element, state: state, key: key);
}

@ProviderFor(WebReadMarkers)
const webReadMarkersProvider = WebReadMarkersProvider._();

final class WebReadMarkersProvider
    extends $AsyncNotifierProvider<WebReadMarkers, Map<String, Set<String>>> {
  const WebReadMarkersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'webReadMarkersProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$webReadMarkersHash();

  @$internal
  @override
  WebReadMarkers create() => WebReadMarkers();

  @$internal
  @override
  _$WebReadMarkersElement $createElement($ProviderPointer pointer) =>
      _$WebReadMarkersElement(pointer);

  ProviderListenable<WebReadMarkers$Clear> get clear => $LazyProxyListenable<
    WebReadMarkers$Clear,
    AsyncValue<Map<String, Set<String>>>
  >(this, (element) {
    element as _$WebReadMarkersElement;

    return element._$clear;
  });

  ProviderListenable<WebReadMarkers$Set> get set => $LazyProxyListenable<
    WebReadMarkers$Set,
    AsyncValue<Map<String, Set<String>>>
  >(this, (element) {
    element as _$WebReadMarkersElement;

    return element._$set;
  });

  ProviderListenable<WebReadMarkers$SetBulk> get setBulk =>
      $LazyProxyListenable<
        WebReadMarkers$SetBulk,
        AsyncValue<Map<String, Set<String>>>
      >(this, (element) {
        element as _$WebReadMarkersElement;

        return element._$setBulk;
      });

  ProviderListenable<WebReadMarkers$DeleteKey> get deleteKey =>
      $LazyProxyListenable<
        WebReadMarkers$DeleteKey,
        AsyncValue<Map<String, Set<String>>>
      >(this, (element) {
        element as _$WebReadMarkersElement;

        return element._$deleteKey;
      });
}

String _$webReadMarkersHash() => r'79a9a04f4302d58638371c82fbc15f1aae75856f';

abstract class _$WebReadMarkers
    extends $AsyncNotifier<Map<String, Set<String>>> {
  FutureOr<Map<String, Set<String>>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<Map<String, Set<String>>>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Map<String, Set<String>>>>,
              AsyncValue<Map<String, Set<String>>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

class _$WebReadMarkersElement
    extends
        $AsyncNotifierProviderElement<
          WebReadMarkers,
          Map<String, Set<String>>
        > {
  _$WebReadMarkersElement(super.pointer) {
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
    _$clear.result!.value!.reset();
    _$set.result!.value!.reset();
    _$setBulk.result!.value!.reset();
    _$deleteKey.result!.value!.reset();
  }

  @override
  void visitListenables(
    void Function($ElementLense element) listenableVisitor,
  ) {
    super.visitListenables(listenableVisitor);

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
  /// This will first set the state to [PendingMutation], then
  /// will call [WebReadMarkers.clear] with the provided parameters.
  ///
  /// After the method completes, the mutation state will be updated to either
  /// [SuccessMutation] or [ErrorMutation] based on if the method
  /// threw or not.
  ///
  /// **Note**:
  /// If the notifier threw in its constructor, the mutation won't start
  /// and [call] will throw.
  /// This should generally never happen though, as Notifiers are not supposed
  /// to have logic in their constructors.
  Future<Map<String, Set<String>>> call();
}

final class _$WebReadMarkers$Clear
    extends
        $AsyncMutationBase<
          Map<String, Set<String>>,
          _$WebReadMarkers$Clear,
          WebReadMarkers
        >
    implements WebReadMarkers$Clear {
  _$WebReadMarkers$Clear(this.element, {super.state, super.key});

  @override
  final _$WebReadMarkersElement element;

  @override
  $ElementLense<_$WebReadMarkers$Clear> get listenable => element._$clear;

  @override
  Future<Map<String, Set<String>>> call() {
    return mutate(
      Invocation.method(#clear, []),
      ($notifier) => $notifier.clear(),
    );
  }

  @override
  _$WebReadMarkers$Clear copyWith(
    MutationState<Map<String, Set<String>>> state, {
    Object? key,
  }) => _$WebReadMarkers$Clear(element, state: state, key: key);
}

sealed class WebReadMarkers$Set extends MutationBase<Map<String, Set<String>>> {
  /// Starts the mutation.
  ///
  /// This will first set the state to [PendingMutation], then
  /// will call [WebReadMarkers.set] with the provided parameters.
  ///
  /// After the method completes, the mutation state will be updated to either
  /// [SuccessMutation] or [ErrorMutation] based on if the method
  /// threw or not.
  ///
  /// **Note**:
  /// If the notifier threw in its constructor, the mutation won't start
  /// and [call] will throw.
  /// This should generally never happen though, as Notifiers are not supposed
  /// to have logic in their constructors.
  Future<Map<String, Set<String>>> call(
    String manga,
    String chapter,
    bool setRead,
  );
}

final class _$WebReadMarkers$Set
    extends
        $AsyncMutationBase<
          Map<String, Set<String>>,
          _$WebReadMarkers$Set,
          WebReadMarkers
        >
    implements WebReadMarkers$Set {
  _$WebReadMarkers$Set(this.element, {super.state, super.key});

  @override
  final _$WebReadMarkersElement element;

  @override
  $ElementLense<_$WebReadMarkers$Set> get listenable => element._$set;

  @override
  Future<Map<String, Set<String>>> call(
    String manga,
    String chapter,
    bool setRead,
  ) {
    return mutate(
      Invocation.method(#set, [manga, chapter, setRead]),
      ($notifier) => $notifier.set(manga, chapter, setRead),
    );
  }

  @override
  _$WebReadMarkers$Set copyWith(
    MutationState<Map<String, Set<String>>> state, {
    Object? key,
  }) => _$WebReadMarkers$Set(element, state: state, key: key);
}

sealed class WebReadMarkers$SetBulk
    extends MutationBase<Map<String, Set<String>>> {
  /// Starts the mutation.
  ///
  /// This will first set the state to [PendingMutation], then
  /// will call [WebReadMarkers.setBulk] with the provided parameters.
  ///
  /// After the method completes, the mutation state will be updated to either
  /// [SuccessMutation] or [ErrorMutation] based on if the method
  /// threw or not.
  ///
  /// **Note**:
  /// If the notifier threw in its constructor, the mutation won't start
  /// and [call] will throw.
  /// This should generally never happen though, as Notifiers are not supposed
  /// to have logic in their constructors.
  Future<Map<String, Set<String>>> call(
    String manga, {
    Iterable<String>? read,
    Iterable<String>? unread,
  });
}

final class _$WebReadMarkers$SetBulk
    extends
        $AsyncMutationBase<
          Map<String, Set<String>>,
          _$WebReadMarkers$SetBulk,
          WebReadMarkers
        >
    implements WebReadMarkers$SetBulk {
  _$WebReadMarkers$SetBulk(this.element, {super.state, super.key});

  @override
  final _$WebReadMarkersElement element;

  @override
  $ElementLense<_$WebReadMarkers$SetBulk> get listenable => element._$setBulk;

  @override
  Future<Map<String, Set<String>>> call(
    String manga, {
    Iterable<String>? read,
    Iterable<String>? unread,
  }) {
    return mutate(
      Invocation.method(#setBulk, [manga], {#read: read, #unread: unread}),
      ($notifier) => $notifier.setBulk(manga, read: read, unread: unread),
    );
  }

  @override
  _$WebReadMarkers$SetBulk copyWith(
    MutationState<Map<String, Set<String>>> state, {
    Object? key,
  }) => _$WebReadMarkers$SetBulk(element, state: state, key: key);
}

sealed class WebReadMarkers$DeleteKey
    extends MutationBase<Map<String, Set<String>>> {
  /// Starts the mutation.
  ///
  /// This will first set the state to [PendingMutation], then
  /// will call [WebReadMarkers.deleteKey] with the provided parameters.
  ///
  /// After the method completes, the mutation state will be updated to either
  /// [SuccessMutation] or [ErrorMutation] based on if the method
  /// threw or not.
  ///
  /// **Note**:
  /// If the notifier threw in its constructor, the mutation won't start
  /// and [call] will throw.
  /// This should generally never happen though, as Notifiers are not supposed
  /// to have logic in their constructors.
  Future<Map<String, Set<String>>> call(String manga);
}

final class _$WebReadMarkers$DeleteKey
    extends
        $AsyncMutationBase<
          Map<String, Set<String>>,
          _$WebReadMarkers$DeleteKey,
          WebReadMarkers
        >
    implements WebReadMarkers$DeleteKey {
  _$WebReadMarkers$DeleteKey(this.element, {super.state, super.key});

  @override
  final _$WebReadMarkersElement element;

  @override
  $ElementLense<_$WebReadMarkers$DeleteKey> get listenable =>
      element._$deleteKey;

  @override
  Future<Map<String, Set<String>>> call(String manga) {
    return mutate(
      Invocation.method(#deleteKey, [manga]),
      ($notifier) => $notifier.deleteKey(manga),
    );
  }

  @override
  _$WebReadMarkers$DeleteKey copyWith(
    MutationState<Map<String, Set<String>>> state, {
    Object? key,
  }) => _$WebReadMarkers$DeleteKey(element, state: state, key: key);
}

@ProviderFor(ExtensionSource)
const extensionSourceProvider = ExtensionSourceFamily._();

final class ExtensionSourceProvider
    extends $AsyncNotifierProvider<ExtensionSource, WebSourceInfo> {
  const ExtensionSourceProvider._({
    required ExtensionSourceFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'extensionSourceProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$extensionSourceHash();

  @override
  String toString() {
    return r'extensionSourceProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ExtensionSource create() => ExtensionSource();

  @$internal
  @override
  $AsyncNotifierProviderElement<ExtensionSource, WebSourceInfo> $createElement(
    $ProviderPointer pointer,
  ) => $AsyncNotifierProviderElement(pointer);

  @override
  bool operator ==(Object other) {
    return other is ExtensionSourceProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$extensionSourceHash() => r'ef306a3ce0ee0f8c2ea182a94422c87ad10d5dce';

final class ExtensionSourceFamily extends $Family
    with
        $ClassFamilyOverride<
          ExtensionSource,
          AsyncValue<WebSourceInfo>,
          WebSourceInfo,
          FutureOr<WebSourceInfo>,
          String
        > {
  const ExtensionSourceFamily._()
    : super(
        retry: null,
        name: r'extensionSourceProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  ExtensionSourceProvider call(String sourceId) =>
      ExtensionSourceProvider._(argument: sourceId, from: this);

  @override
  String toString() => r'extensionSourceProvider';
}

abstract class _$ExtensionSource extends $AsyncNotifier<WebSourceInfo> {
  late final _$args = ref.$arg as String;
  String get sourceId => _$args;

  FutureOr<WebSourceInfo> build(String sourceId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<WebSourceInfo>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<WebSourceInfo>>,
              AsyncValue<WebSourceInfo>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(ExtensionInfoList)
const extensionInfoListProvider = ExtensionInfoListProvider._();

final class ExtensionInfoListProvider
    extends $AsyncNotifierProvider<ExtensionInfoList, List<WebSourceInfo>> {
  const ExtensionInfoListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'extensionInfoListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$extensionInfoListHash();

  @$internal
  @override
  ExtensionInfoList create() => ExtensionInfoList();

  @$internal
  @override
  $AsyncNotifierProviderElement<ExtensionInfoList, List<WebSourceInfo>>
  $createElement($ProviderPointer pointer) =>
      $AsyncNotifierProviderElement(pointer);
}

String _$extensionInfoListHash() => r'0665e8257c6673036644f3e598bf43e023b1bd12';

abstract class _$ExtensionInfoList extends $AsyncNotifier<List<WebSourceInfo>> {
  FutureOr<List<WebSourceInfo>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<WebSourceInfo>>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<WebSourceInfo>>>,
              AsyncValue<List<WebSourceInfo>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(getExtensionFromId)
const getExtensionFromIdProvider = GetExtensionFromIdFamily._();

final class GetExtensionFromIdProvider
    extends
        $FunctionalProvider<AsyncValue<WebSourceInfo>, FutureOr<WebSourceInfo>>
    with $FutureModifier<WebSourceInfo>, $FutureProvider<WebSourceInfo> {
  const GetExtensionFromIdProvider._({
    required GetExtensionFromIdFamily super.from,
    required String super.argument,
  }) : super(
         retry: noRetry,
         name: r'getExtensionFromIdProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$getExtensionFromIdHash();

  @override
  String toString() {
    return r'getExtensionFromIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<WebSourceInfo> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<WebSourceInfo> create(Ref ref) {
    final argument = this.argument as String;
    return getExtensionFromId(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is GetExtensionFromIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$getExtensionFromIdHash() =>
    r'b5bf3c8a25a75348d4400be94e8864bff3bafdea';

final class GetExtensionFromIdFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<WebSourceInfo>, String> {
  const GetExtensionFromIdFamily._()
    : super(
        retry: noRetry,
        name: r'getExtensionFromIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  GetExtensionFromIdProvider call(String sourceId) =>
      GetExtensionFromIdProvider._(argument: sourceId, from: this);

  @override
  String toString() => r'getExtensionFromIdProvider';
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
