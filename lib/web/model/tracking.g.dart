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

/// Installed extensions that can receive progress, kept current.

@ProviderFor(installedTrackers)
final installedTrackersProvider = InstalledTrackersProvider._();

/// Installed extensions that can receive progress, kept current.

final class InstalledTrackersProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<WebSourceInfo>>,
          List<WebSourceInfo>,
          Stream<List<WebSourceInfo>>
        >
    with
        $FutureModifier<List<WebSourceInfo>>,
        $StreamProvider<List<WebSourceInfo>> {
  /// Installed extensions that can receive progress, kept current.
  InstalledTrackersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'installedTrackersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$installedTrackersHash();

  @$internal
  @override
  $StreamProviderElement<List<WebSourceInfo>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<WebSourceInfo>> create(Ref ref) {
    return installedTrackers(ref);
  }
}

String _$installedTrackersHash() => r'ec33cefa8eccef48d7f642ab86747b335efbb415';

/// The tracker's current progress for a link, fetched when first watched.
/// Auto-disposed so each view of it asks the tracker afresh.

@ProviderFor(trackerProgress)
final trackerProgressProvider = TrackerProgressFamily._();

/// The tracker's current progress for a link, fetched when first watched.
/// Auto-disposed so each view of it asks the tracker afresh.

final class TrackerProgressProvider
    extends
        $FunctionalProvider<
          AsyncValue<MangaProgress?>,
          MangaProgress?,
          FutureOr<MangaProgress?>
        >
    with $FutureModifier<MangaProgress?>, $FutureProvider<MangaProgress?> {
  /// The tracker's current progress for a link, fetched when first watched.
  /// Auto-disposed so each view of it asks the tracker afresh.
  TrackerProgressProvider._({
    required TrackerProgressFamily super.from,
    required (String, String) super.argument,
  }) : super(
         retry: null,
         name: r'trackerProgressProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$trackerProgressHash();

  @override
  String toString() {
    return r'trackerProgressProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<MangaProgress?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<MangaProgress?> create(Ref ref) {
    final argument = this.argument as (String, String);
    return trackerProgress(ref, argument.$1, argument.$2);
  }

  @override
  bool operator ==(Object other) {
    return other is TrackerProgressProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$trackerProgressHash() => r'3dc9ff446e467c6213b538445bd128c697694b9b';

/// The tracker's current progress for a link, fetched when first watched.
/// Auto-disposed so each view of it asks the tracker afresh.

final class TrackerProgressFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<MangaProgress?>, (String, String)> {
  TrackerProgressFamily._()
    : super(
        retry: null,
        name: r'trackerProgressProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// The tracker's current progress for a link, fetched when first watched.
  /// Auto-disposed so each view of it asks the tracker afresh.

  TrackerProgressProvider call(String trackerId, String linkKey) =>
      TrackerProgressProvider._(argument: (trackerId, linkKey), from: this);

  @override
  String toString() => r'trackerProgressProvider';
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
    r'd5ae0fa6c30796a73d0edef85369215733f2e664';

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
