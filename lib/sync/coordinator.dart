import 'dart:async';

import 'package:gagaku/sync/metadata.dart';
import 'package:gagaku/sync/protocol.dart';
import 'package:gagaku/sync/repository.dart';

typedef SyncExportData = Future<Map<String, dynamic>> Function();
typedef SyncImportData = Future<void> Function(Map<String, dynamic> payload);
typedef SyncCoordinatorNow = DateTime Function();
typedef SyncProfileValidator = Future<bool> Function();

enum SyncCoordinatorPhase {
  disabled,
  initializing,
  clean,
  pending,
  publishing,
  pulling,
  offline,
  incompatible,
  noValidSnapshot,
  profileMissing,
  forked,
  cleanupWarning,
  disposed,
}

final class SyncCoordinatorStatus {
  const SyncCoordinatorStatus(
    this.phase, {
    this.message,
    this.forkHeads = const [],
    this.cleanupFailures = const [],
  });

  final SyncCoordinatorPhase phase;
  final String? message;
  final List<SyncSnapshot> forkHeads;
  final List<String> cleanupFailures;
}

final class SyncCoordinator {
  SyncCoordinator({
    required this.repository,
    required this.metadataStore,
    required this.exportData,
    required this.importData,
    required this.entityChanges,
    this.validateProfile,
    this.debounceDuration = const Duration(milliseconds: 1500),
    this.foregroundCooldown = const Duration(seconds: 30),
    this.operationTimeout = const Duration(seconds: 5),
    SyncCoordinatorNow? now,
  }) : _now = now ?? DateTime.now;

  final SyncRepository repository;
  final SyncMetadataStore metadataStore;
  final SyncExportData exportData;
  final SyncImportData importData;
  final Stream<Object?> entityChanges;
  final SyncProfileValidator? validateProfile;
  final Duration debounceDuration;
  final Duration foregroundCooldown;
  final Duration operationTimeout;
  final SyncCoordinatorNow _now;

  final StreamController<SyncCoordinatorStatus> _statuses =
      StreamController.broadcast();
  SyncCoordinatorStatus _status = const SyncCoordinatorStatus(
    SyncCoordinatorPhase.disabled,
  );
  SyncLocalState? _state;
  StreamSubscription<Object?>? _changesSubscription;
  Timer? _debounce;
  Timer? _cooldown;
  Future<void> _generationTail = Future.value();
  bool _passRequested = false;
  bool _forceRequested = false;
  bool _running = false;
  bool _disposed = false;
  Completer<void>? _idleCompleter;
  SyncSnapshot? _requestedResolution;
  final Stopwatch _foregroundPublicationClock = Stopwatch();

  Stream<SyncCoordinatorStatus> get statuses => _statuses.stream;
  SyncCoordinatorStatus get status => _status;
  SyncLocalState? get localState => _state?.copy();
  bool get isRunning => _running;

  Future<void> start() async {
    if (_disposed) throw StateError('Sync coordinator is disposed');
    if (_state != null) return;
    _state = await metadataStore.read();
    if (!_state!.enabled) {
      _emit(const SyncCoordinatorStatus(SyncCoordinatorPhase.disabled));
      return;
    }
    _emit(const SyncCoordinatorStatus(SyncCoordinatorPhase.initializing));
    _changesSubscription = entityChanges.listen((_) => markLocalChange());
    await requestSync();
  }

  void markLocalChange() {
    if (_disposed || _state?.enabled != true) return;
    _generationTail = _generationTail.then((_) async {
      final state = _state!;
      final wasDirty = _isDirty(state);
      state.dirtyGeneration++;
      if (!wasDirty) await metadataStore.write(state);
      _debounce?.cancel();
      _cooldown?.cancel();
      _cooldown = null;
      _emit(const SyncCoordinatorStatus(SyncCoordinatorPhase.pending));
      _debounce = Timer(debounceDuration, () {
        _debounce = null;
        unawaited(_requestSync(bypassCooldown: false));
      });
    });
  }

  Future<void> onPause() async {
    if (_state?.enabled != true || _disposed) return;
    await _generationTail;
    _debounce?.cancel();
    _debounce = null;
    _cooldown?.cancel();
    _cooldown = null;
    if (_isDirty(_state!)) await requestSync();
  }

  Future<void> onResume() async {
    if (_state?.enabled == true && !_disposed) await requestSync();
  }

  Future<void> resolveFork(SyncSnapshot selected) async {
    _requestedResolution = selected;
    await requestSync();
  }

  Future<void> renameDevice(String name) async {
    final state = _state;
    if (state == null || !state.enabled || _disposed) {
      throw StateError('Sync coordinator is not active');
    }
    final trimmed = name.trim();
    if (trimmed.isEmpty) {
      throw ArgumentError.value(name, 'name', 'must not be empty');
    }
    await _generationTail;
    state.deviceName = trimmed;
    repository.deviceName = trimmed;
    await metadataStore.write(state);
    await requestSync();
  }

  Future<void> requestSync() {
    _debounce?.cancel();
    _debounce = null;
    _cooldown?.cancel();
    _cooldown = null;
    return _requestSync(bypassCooldown: true);
  }

  Future<void> _requestSync({required bool bypassCooldown}) {
    if (_disposed || _state?.enabled != true) return Future.value();
    _passRequested = true;
    if (bypassCooldown) _forceRequested = true;
    if (_running) return _idleCompleter!.future;

    _running = true;
    final completer = Completer<void>();
    _idleCompleter = completer;
    unawaited(_drain(completer));
    return completer.future;
  }

  Future<void> _drain(Completer<void> completer) async {
    try {
      while (_passRequested && !_disposed) {
        final bypassCooldown = _forceRequested;
        _passRequested = false;
        _forceRequested = false;
        if (!bypassCooldown && _deferForForegroundCooldown()) continue;
        await _generationTail;
        await _runPass();
        if (_passRequested && bypassCooldown) _forceRequested = true;
      }
    } finally {
      _running = false;
      _idleCompleter = null;
      if (!completer.isCompleted) completer.complete();
      if (_passRequested && !_disposed) {
        unawaited(_requestSync(bypassCooldown: _forceRequested));
      }
    }
  }

  bool _deferForForegroundCooldown() {
    if (foregroundCooldown <= Duration.zero ||
        !_foregroundPublicationClock.isRunning) {
      return false;
    }
    final remaining = foregroundCooldown - _foregroundPublicationClock.elapsed;
    if (remaining <= Duration.zero) return false;
    _cooldown?.cancel();
    _cooldown = Timer(remaining, () {
      _cooldown = null;
      unawaited(_requestSync(bypassCooldown: false));
    });
    _emit(const SyncCoordinatorStatus(SyncCoordinatorPhase.pending));
    return true;
  }

  Future<void> _runPass() async {
    Future<void>? timeoutFailure;
    final timeout = Timer(operationTimeout, () {
      timeoutFailure = _recordFailure(
        TimeoutException('Sync operation exceeded $operationTimeout'),
        SyncCoordinatorPhase.offline,
      );
    });
    try {
      await _synchronize();
      timeout.cancel();
      await timeoutFailure;
      final state = _state!;
      state.retryPending = false;
      state.lastError = null;
      await metadataStore.write(state);
    } on SyncValidationException catch (error) {
      await _recordFailure(error, SyncCoordinatorPhase.incompatible);
    } on TimeoutException catch (error) {
      await _recordFailure(error, SyncCoordinatorPhase.offline);
    } catch (error) {
      await _recordFailure(error, SyncCoordinatorPhase.offline);
    } finally {
      timeout.cancel();
    }
  }

  Future<void> _synchronize() async {
    final state = _state!;
    final validator = validateProfile;
    if (validator != null && !await validator()) {
      await _suspendForMissingProfile();
      return;
    }
    final startGeneration = state.dirtyGeneration;
    final payload = await exportData();
    final prepared = await SyncSnapshotCodec.preparePayload(payload);
    final payloadHash = prepared.payloadHash;
    await _generationTail;
    if (state.dirtyGeneration != startGeneration) {
      _passRequested = true;
      _emit(const SyncCoordinatorStatus(SyncCoordinatorPhase.pending));
      return;
    }

    final discovery = await repository.discover();
    final identityOutdated = _identityOutdated(discovery);
    final localDirty =
        _isDirty(state) ||
        (state.lastBaselinePayloadHash != null &&
            state.lastBaselinePayloadHash != payloadHash);

    switch (discovery.selection) {
      case NoSyncHeads():
        if (discovery.invalidObjects.isNotEmpty) {
          _emit(
            const SyncCoordinatorStatus(SyncCoordinatorPhase.noValidSnapshot),
          );
          return;
        }
        if (state.lastBaselinePayloadHash != null) {
          await _suspendForMissingProfile();
          return;
        }
        await _publish(
          prepared,
          state.lastSeen,
          discovery,
          startGeneration,
          branch: false,
        );
      case CanonicalSyncHead(:final head):
        if (head.payloadHash == payloadHash) {
          if (identityOutdated) {
            await _publish(
              prepared,
              SyncClock.join([state.lastSeen, head.seen]),
              discovery,
              startGeneration,
              branch: false,
            );
            return;
          }
          await _recordCanonical(
            head,
            startGeneration,
            applied: false,
            published: false,
          );
          return;
        }
        if (!localDirty) {
          await _apply(head, startGeneration);
          if (identityOutdated) _passRequested = true;
          return;
        }
        final remoteAdvanced = _remoteAdvanced(state, head.seen);
        await _publish(
          prepared,
          remoteAdvanced
              ? state.lastSeen
              : SyncClock.join([state.lastSeen, head.seen]),
          discovery,
          startGeneration,
          branch: remoteAdvanced,
        );
      case EquivalentSyncHeads(:final heads, :final joinedClock):
        final common = heads.first;
        if (localDirty && common.payloadHash != payloadHash) {
          await _publish(
            prepared,
            state.lastSeen,
            discovery,
            startGeneration,
            branch: true,
          );
          return;
        }
        if (common.payloadHash != payloadHash) {
          await _apply(common, startGeneration, emitClean: false);
        }
        _emit(const SyncCoordinatorStatus(SyncCoordinatorPhase.publishing));
        final publication = await repository.normalizeEquivalentHeads();
        await _recordPublication(publication, startGeneration);
        state.lastSeen = Map.of(joinedClock)
          ..update(
            repository.deviceId,
            (_) => publication.snapshot.deviceSequence,
            ifAbsent: () => publication.snapshot.deviceSequence,
          );
        await metadataStore.write(state);
      case ForkedSyncHeads(:final heads):
        final requested = _requestedResolution;
        if (requested == null) {
          _emit(
            SyncCoordinatorStatus(
              SyncCoordinatorPhase.forked,
              forkHeads: heads,
            ),
          );
          return;
        }
        _requestedResolution = null;
        await _resolveFork(requested, heads, payloadHash, startGeneration);
    }
  }

  Future<void> _suspendForMissingProfile() async {
    _debounce?.cancel();
    _debounce = null;
    await _changesSubscription?.cancel();
    _changesSubscription = null;
    final state = _state!;
    state
      ..enabled = false
      ..profileMissing = true
      ..retryPending = false
      ..lastError = null;
    await metadataStore.write(state);
    _emit(const SyncCoordinatorStatus(SyncCoordinatorPhase.profileMissing));
  }

  bool _identityOutdated(SyncDiscovery discovery) {
    final name = repository.deviceName.trim();
    if (name.isEmpty) return false;
    final published =
        discovery.deviceHeads[repository.deviceId]?.extra['deviceName'];
    return published is! String || published.trim() != name;
  }

  Future<void> _publish(
    SyncPreparedPayload prepared,
    Map<String, int> baseClock,
    SyncDiscovery discovery,
    int startGeneration, {
    required bool branch,
  }) async {
    _emit(const SyncCoordinatorStatus(SyncCoordinatorPhase.publishing));
    final publication = await repository.publishFromClock(
      prepared,
      baseClock,
      discovery,
    );
    await _recordPublication(publication, startGeneration);
    if (branch) {
      final updated = await repository.discover(
        previouslyValidated: [
          ...discovery.validSnapshots,
          publication.snapshot,
        ],
      );
      final heads = switch (updated.selection) {
        ForkedSyncHeads(:final heads) => heads,
        _ => <SyncSnapshot>[],
      };
      _emit(
        SyncCoordinatorStatus(SyncCoordinatorPhase.forked, forkHeads: heads),
      );
    }
  }

  Future<void> _apply(
    SyncSnapshot head,
    int startGeneration, {
    bool emitClean = true,
  }) async {
    _emit(const SyncCoordinatorStatus(SyncCoordinatorPhase.pulling));
    await importData(head.payload);
    await _generationTail;
    await _recordCanonical(
      head,
      stateGenerationAtMost(startGeneration),
      applied: true,
      published: false,
      emitClean: emitClean,
    );
  }

  int stateGenerationAtMost(int minimum) {
    final generation = _state!.dirtyGeneration;
    return generation > minimum ? generation : minimum;
  }

  Future<void> _resolveFork(
    SyncSnapshot selected,
    List<SyncSnapshot> heads,
    String localPayloadHash,
    int startGeneration,
  ) async {
    if (!heads.any((head) => head.key == selected.key)) {
      throw ArgumentError.value(selected.key, 'selected', 'not a fork head');
    }
    if (localPayloadHash != selected.payloadHash) {
      _emit(const SyncCoordinatorStatus(SyncCoordinatorPhase.pulling));
      await importData(selected.payload);
      await _generationTail;
    }
    _emit(const SyncCoordinatorStatus(SyncCoordinatorPhase.publishing));
    final publication = await repository.resolveFork(selected);
    await _recordPublication(
      publication,
      stateGenerationAtMost(startGeneration),
      appliedRevision: selected.revisionId,
      appliedHash: selected.payloadHash,
    );
  }

  Future<void> _recordCanonical(
    SyncSnapshot head,
    int generation, {
    required bool applied,
    required bool published,
    bool emitClean = true,
  }) async {
    final state = _state!;
    state
      ..lastSeen = Map.of(head.seen)
      ..lastBaselinePayloadHash = head.payloadHash
      ..lastPublishedGeneration = generation;
    if (applied) {
      state
        ..lastAppliedRevision = head.revisionId
        ..lastAppliedPayloadHash = head.payloadHash
        ..lastAppliedAt = _now().toUtc();
    }
    if (published) {
      state
        ..lastPublishedRevision = head.revisionId
        ..lastPublishedPayloadHash = head.payloadHash
        ..lastPublishedAt = _now().toUtc();
    }
    await metadataStore.write(state);
    if (state.dirtyGeneration > generation) _passRequested = true;
    if (emitClean) {
      _emit(const SyncCoordinatorStatus(SyncCoordinatorPhase.clean));
    }
  }

  Future<void> _recordPublication(
    SyncPublication publication,
    int generation, {
    String? appliedRevision,
    String? appliedHash,
  }) async {
    final state = _state!;
    final snapshot = publication.snapshot;
    state
      ..lastSeen = Map.of(snapshot.seen)
      ..lastBaselinePayloadHash = snapshot.payloadHash
      ..lastPublishedRevision = snapshot.revisionId
      ..lastPublishedPayloadHash = snapshot.payloadHash
      ..lastPublishedAt = _now().toUtc()
      ..lastPublishedGeneration = generation;
    _foregroundPublicationClock
      ..reset()
      ..start();
    if (appliedRevision != null) {
      state
        ..lastAppliedRevision = appliedRevision
        ..lastAppliedAt = _now().toUtc();
    }
    if (appliedHash != null) state.lastAppliedPayloadHash = appliedHash;
    await metadataStore.write(state);
    if (state.dirtyGeneration > generation) _passRequested = true;
    if (publication.cleanupFailures.isEmpty) {
      _emit(const SyncCoordinatorStatus(SyncCoordinatorPhase.clean));
    } else {
      _emit(
        SyncCoordinatorStatus(
          SyncCoordinatorPhase.cleanupWarning,
          cleanupFailures: publication.cleanupFailures,
        ),
      );
    }
  }

  Future<void> _recordFailure(Object error, SyncCoordinatorPhase phase) async {
    final state = _state!;
    state
      ..retryPending = true
      ..lastError = error.toString();
    await metadataStore.write(state);
    _emit(SyncCoordinatorStatus(phase, message: state.lastError));
  }

  static bool _isDirty(SyncLocalState state) =>
      state.dirtyGeneration > state.lastPublishedGeneration;

  static bool _remoteAdvanced(
    SyncLocalState state,
    Map<String, int> remoteClock,
  ) {
    if (state.lastSeen.isEmpty) return true;
    return switch (SyncClock.compare(remoteClock, state.lastSeen)) {
      SyncClockRelation.equal || SyncClockRelation.dominated => false,
      SyncClockRelation.dominates || SyncClockRelation.concurrent => true,
    };
  }

  void _emit(SyncCoordinatorStatus status) {
    if (_disposed) return;
    _status = status;
    _statuses.add(status);
  }

  Future<void> dispose() async {
    if (_disposed) return;
    _disposed = true;
    _debounce?.cancel();
    _cooldown?.cancel();
    await _changesSubscription?.cancel();
    _status = const SyncCoordinatorStatus(SyncCoordinatorPhase.disposed);
    await _statuses.close();
  }
}
