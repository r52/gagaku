// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tracking.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(trackerQueueStore)
final trackerQueueStoreProvider = TrackerQueueStoreProvider._();

final class TrackerQueueStoreProvider
    extends
        $FunctionalProvider<
          TrackerQueueStore,
          TrackerQueueStore,
          TrackerQueueStore
        >
    with $Provider<TrackerQueueStore> {
  TrackerQueueStoreProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'trackerQueueStoreProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$trackerQueueStoreHash();

  @$internal
  @override
  $ProviderElement<TrackerQueueStore> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  TrackerQueueStore create(Ref ref) {
    return trackerQueueStore(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TrackerQueueStore value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TrackerQueueStore>(value),
    );
  }
}

String _$trackerQueueStoreHash() => r'eadc0254ec02f87c754eb9a73c6a7911731119b4';

@ProviderFor(trackerLinkRepository)
final trackerLinkRepositoryProvider = TrackerLinkRepositoryProvider._();

final class TrackerLinkRepositoryProvider
    extends
        $FunctionalProvider<
          TrackerLinkRepository,
          TrackerLinkRepository,
          TrackerLinkRepository
        >
    with $Provider<TrackerLinkRepository> {
  TrackerLinkRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'trackerLinkRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$trackerLinkRepositoryHash();

  @$internal
  @override
  $ProviderElement<TrackerLinkRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  TrackerLinkRepository create(Ref ref) {
    return trackerLinkRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TrackerLinkRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TrackerLinkRepository>(value),
    );
  }
}

String _$trackerLinkRepositoryHash() =>
    r'66da94701f60587444efd04765ab67ce2a62892c';

/// Live links for one series; reflects backup restores and sync imports.

@ProviderFor(trackerLinksForSeries)
final trackerLinksForSeriesProvider = TrackerLinksForSeriesFamily._();

/// Live links for one series; reflects backup restores and sync imports.

final class TrackerLinksForSeriesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<TrackerLink>>,
          List<TrackerLink>,
          Stream<List<TrackerLink>>
        >
    with
        $FutureModifier<List<TrackerLink>>,
        $StreamProvider<List<TrackerLink>> {
  /// Live links for one series; reflects backup restores and sync imports.
  TrackerLinksForSeriesProvider._({
    required TrackerLinksForSeriesFamily super.from,
    required TrackedSeriesRef super.argument,
  }) : super(
         retry: null,
         name: r'trackerLinksForSeriesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$trackerLinksForSeriesHash();

  @override
  String toString() {
    return r'trackerLinksForSeriesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<TrackerLink>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<TrackerLink>> create(Ref ref) {
    final argument = this.argument as TrackedSeriesRef;
    return trackerLinksForSeries(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is TrackerLinksForSeriesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$trackerLinksForSeriesHash() =>
    r'771cc522f1a20d45cb09450a559d8034d8e1c493';

/// Live links for one series; reflects backup restores and sync imports.

final class TrackerLinksForSeriesFamily extends $Family
    with
        $FunctionalFamilyOverride<Stream<List<TrackerLink>>, TrackedSeriesRef> {
  TrackerLinksForSeriesFamily._()
    : super(
        retry: null,
        name: r'trackerLinksForSeriesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Live links for one series; reflects backup restores and sync imports.

  TrackerLinksForSeriesProvider call(TrackedSeriesRef series) =>
      TrackerLinksForSeriesProvider._(argument: series, from: this);

  @override
  String toString() => r'trackerLinksForSeriesProvider';
}

/// Sends a batch to the tracker's runtime. Overridden in tests.

@ProviderFor(trackerQueueProcessor)
final trackerQueueProcessorProvider = TrackerQueueProcessorProvider._();

/// Sends a batch to the tracker's runtime. Overridden in tests.

final class TrackerQueueProcessorProvider
    extends
        $FunctionalProvider<
          TrackerQueueProcessor,
          TrackerQueueProcessor,
          TrackerQueueProcessor
        >
    with $Provider<TrackerQueueProcessor> {
  /// Sends a batch to the tracker's runtime. Overridden in tests.
  TrackerQueueProcessorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'trackerQueueProcessorProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$trackerQueueProcessorHash();

  @$internal
  @override
  $ProviderElement<TrackerQueueProcessor> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  TrackerQueueProcessor create(Ref ref) {
    return trackerQueueProcessor(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TrackerQueueProcessor value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TrackerQueueProcessor>(value),
    );
  }
}

String _$trackerQueueProcessorHash() =>
    r'd895ca7584543057937a9f445392e776ee736f21';

/// Current time for queue scheduling. Overridden in tests.

@ProviderFor(trackerClock)
final trackerClockProvider = TrackerClockProvider._();

/// Current time for queue scheduling. Overridden in tests.

final class TrackerClockProvider
    extends
        $FunctionalProvider<
          DateTime Function(),
          DateTime Function(),
          DateTime Function()
        >
    with $Provider<DateTime Function()> {
  /// Current time for queue scheduling. Overridden in tests.
  TrackerClockProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'trackerClockProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$trackerClockHash();

  @$internal
  @override
  $ProviderElement<DateTime Function()> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DateTime Function() create(Ref ref) {
    return trackerClock(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DateTime Function() value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DateTime Function()>(value),
    );
  }
}

String _$trackerClockHash() => r'b251420874e5c9d7bf96bc54975915db2f0e0c2f';

@ProviderFor(trackerReadReporter)
final trackerReadReporterProvider = TrackerReadReporterProvider._();

final class TrackerReadReporterProvider
    extends
        $FunctionalProvider<
          TrackerReadReporter,
          TrackerReadReporter,
          TrackerReadReporter
        >
    with $Provider<TrackerReadReporter> {
  TrackerReadReporterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'trackerReadReporterProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$trackerReadReporterHash();

  @$internal
  @override
  $ProviderElement<TrackerReadReporter> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  TrackerReadReporter create(Ref ref) {
    return trackerReadReporter(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TrackerReadReporter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TrackerReadReporter>(value),
    );
  }
}

String _$trackerReadReporterHash() =>
    r'2bd823649c9666ffa15b82a87990fe8a65ec6989';

/// Sends queued reads to trackers and reports per-tracker status.

@ProviderFor(TrackerQueueCoordinator)
final trackerQueueCoordinatorProvider = TrackerQueueCoordinatorProvider._();

/// Sends queued reads to trackers and reports per-tracker status.
final class TrackerQueueCoordinatorProvider
    extends
        $NotifierProvider<
          TrackerQueueCoordinator,
          Map<String, TrackerSyncStatus>
        > {
  /// Sends queued reads to trackers and reports per-tracker status.
  TrackerQueueCoordinatorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'trackerQueueCoordinatorProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$trackerQueueCoordinatorHash();

  @$internal
  @override
  TrackerQueueCoordinator create() => TrackerQueueCoordinator();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, TrackerSyncStatus> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, TrackerSyncStatus>>(
        value,
      ),
    );
  }
}

String _$trackerQueueCoordinatorHash() =>
    r'ad41eff35b4ab08a901f59a195aa63e35d8c924e';

/// Sends queued reads to trackers and reports per-tracker status.

abstract class _$TrackerQueueCoordinator
    extends $Notifier<Map<String, TrackerSyncStatus>> {
  Map<String, TrackerSyncStatus> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              Map<String, TrackerSyncStatus>,
              Map<String, TrackerSyncStatus>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                Map<String, TrackerSyncStatus>,
                Map<String, TrackerSyncStatus>
              >,
              Map<String, TrackerSyncStatus>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
