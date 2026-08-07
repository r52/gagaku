import 'dart:collection';
import 'dart:convert';

import 'package:uuid/uuid.dart';

import 'package:gagaku/sync/protocol.dart';
import 'package:gagaku/sync/store.dart';

typedef SyncReadRetryPredicate = bool Function(Object error);

final class SyncProfile {
  const SyncProfile({required this.profileId, required this.createdAt});

  final String profileId;
  final DateTime createdAt;

  Map<String, dynamic> toJson() => {
    'format': SyncProfileCodec.format,
    'protocolVersion': SyncProfileCodec.protocolVersion,
    'profileId': profileId,
    'createdAt': createdAt.toUtc().toIso8601String(),
  };
}

abstract final class SyncProfileCodec {
  static const key = 'profile.json';
  static const format = 'gagaku-sync-profile';
  static const protocolVersion = 1;

  static List<int> encode(SyncProfile profile) {
    _validate(profile);
    return SyncSnapshotCodec.canonicalJsonBytes(profile.toJson());
  }

  static SyncProfile decode(List<int> bytes) {
    try {
      final decoded = jsonDecode(utf8.decode(bytes));
      if (decoded is! Map) {
        throw const SyncValidationException('profile root must be an object');
      }
      final json = Map<String, dynamic>.from(decoded);
      if (json['format'] != format) {
        throw const SyncValidationException('unsupported profile format');
      }
      if (json['protocolVersion'] != protocolVersion) {
        throw const SyncValidationException('unsupported profile protocol');
      }
      final profileId = json['profileId'];
      final createdAtText = json['createdAt'];
      if (profileId is! String || profileId.isEmpty) {
        throw const SyncValidationException('invalid profile ID');
      }
      if (createdAtText is! String) {
        throw const SyncValidationException('invalid profile creation time');
      }
      final createdAt = DateTime.parse(createdAtText);
      if (!createdAt.isUtc) {
        throw const SyncValidationException(
          'profile creation time must be UTC',
        );
      }
      final profile = SyncProfile(profileId: profileId, createdAt: createdAt);
      _validate(profile);
      return profile;
    } on SyncValidationException {
      rethrow;
    } catch (_) {
      throw const SyncValidationException('invalid profile encoding', key: key);
    }
  }

  static void _validate(SyncProfile profile) {
    if (profile.profileId.isEmpty || !profile.createdAt.isUtc) {
      throw const SyncValidationException('invalid sync profile');
    }
  }
}

final class SyncRepairResult {
  const SyncRepairResult({required this.deleted, required this.failures});

  final List<String> deleted;
  final List<String> failures;
}

final class SyncResetResult {
  const SyncResetResult({required this.deleted, required this.failures});

  final List<String> deleted;
  final List<String> failures;
}

final class SyncProfileManager {
  SyncProfileManager({
    required this.store,
    String Function()? idFactory,
    DateTime Function()? now,
    this.readRetryTimeout = Duration.zero,
    this.readRetryDelay = const Duration(milliseconds: 500),
    SyncReadRetryPredicate? retryReadWhen,
  }) : _idFactory = idFactory ?? const Uuid().v4,
       _now = now ?? DateTime.now,
       _retryReadWhen =
           retryReadWhen ??
           ((Object error) => error is SyncObjectNotFoundException);

  final SyncStore store;
  final String Function() _idFactory;
  final DateTime Function() _now;
  final Duration readRetryTimeout;
  final Duration readRetryDelay;
  final SyncReadRetryPredicate _retryReadWhen;

  static const _permittedSyncthingEntries = {
    '.stfolder',
    '.stignore',
    '.stversion',
    '.stversions',
  };

  Future<SyncProfile> create() async {
    final existing = await store.list('');
    final incompatible = existing.where(
      (object) => !_isPermittedSyncthingEntry(object.key),
    );
    if (incompatible.isNotEmpty) {
      throw StateError('Selected sync profile directory is not empty');
    }
    await probe();
    final profile = SyncProfile(
      profileId: _idFactory(),
      createdAt: _now().toUtc(),
    );
    await store.create(SyncProfileCodec.key, SyncProfileCodec.encode(profile));
    final validated = await join();
    if (validated.profileId != profile.profileId) {
      throw const SyncValidationException('profile readback mismatch');
    }
    return validated;
  }

  static bool _isPermittedSyncthingEntry(String key) =>
      _permittedSyncthingEntries.any(
        (entry) => key == entry || key.startsWith('$entry/'),
      );

  Future<SyncProfile> join() async =>
      SyncProfileCodec.decode(await _read(SyncProfileCodec.key));

  Future<bool> hasExpectedProfile(String expectedProfileId) async {
    final objects = await store.list('');
    if (!objects.any((object) => object.key == SyncProfileCodec.key)) {
      return false;
    }
    final profile = await join();
    if (profile.profileId != expectedProfileId) {
      throw const SyncValidationException('profile ID mismatch');
    }
    return true;
  }

  Future<void> probe() async {
    final key = '.gagaku-sync-probe-${_idFactory()}';
    final bytes = utf8.encode('gagaku-sync-probe');
    await store.create(key, bytes);
    try {
      final readback = await _read(key);
      if (!_bytesEqual(bytes, readback)) {
        throw const SyncValidationException(
          'sync store probe readback mismatch',
        );
      }
    } finally {
      await store.delete(key);
    }
  }

  Future<SyncRepairResult> repair(String expectedProfileId) async {
    final profile = await join();
    if (profile.profileId != expectedProfileId) {
      throw const SyncValidationException('profile ID mismatch');
    }
    final objects = await store.list('devices/');
    final invalid = <String>[];
    final validByDevice = <String, List<SyncSnapshot>>{};
    for (final object in objects) {
      try {
        final snapshot = SyncSnapshotCodec.decode(
          object.key,
          await store.read(object.key),
          expectedProfileId: expectedProfileId,
        );
        validByDevice.putIfAbsent(snapshot.deviceId, () => []).add(snapshot);
      } on SyncValidationException {
        invalid.add(object.key);
      }
    }

    final candidates = <String>[...invalid];
    for (final snapshots in validByDevice.values) {
      snapshots.sort((left, right) {
        final sequence = right.deviceSequence.compareTo(left.deviceSequence);
        return sequence != 0 ? sequence : left.key.compareTo(right.key);
      });
      candidates.addAll(snapshots.skip(2).map((snapshot) => snapshot.key));
    }
    candidates.sort();
    return _deleteCandidates(candidates);
  }

  Future<SyncResetResult> reset(String expectedProfileId) async {
    final profile = await join();
    if (profile.profileId != expectedProfileId) {
      throw const SyncValidationException('profile ID mismatch');
    }
    final deviceResult = await _deleteCandidates([
      for (final object in await store.list('devices/')) object.key,
    ]);
    if (deviceResult.failures.isNotEmpty) {
      return SyncResetResult(
        deleted: deviceResult.deleted,
        failures: deviceResult.failures,
      );
    }
    try {
      await store.delete(SyncProfileCodec.key);
      return SyncResetResult(
        deleted: [...deviceResult.deleted, SyncProfileCodec.key],
        failures: const [],
      );
    } catch (_) {
      return SyncResetResult(
        deleted: deviceResult.deleted,
        failures: const [SyncProfileCodec.key],
      );
    }
  }

  Future<SyncRepairResult> _deleteCandidates(
    Iterable<String> candidates,
  ) async {
    final deleted = <String>[];
    final failures = <String>[];
    for (final key in LinkedHashSet<String>.of(candidates)) {
      if (key != SyncProfileCodec.key && !key.startsWith('devices/')) {
        failures.add(key);
        continue;
      }
      try {
        await store.delete(key);
        deleted.add(key);
      } catch (_) {
        failures.add(key);
      }
    }
    return SyncRepairResult(
      deleted: List.unmodifiable(deleted),
      failures: List.unmodifiable(failures),
    );
  }

  static bool _bytesEqual(List<int> left, List<int> right) {
    if (left.length != right.length) return false;
    for (var index = 0; index < left.length; index++) {
      if (left[index] != right[index]) return false;
    }
    return true;
  }

  Future<List<int>> _read(String key) async {
    if (readRetryTimeout <= Duration.zero) return store.read(key);
    final elapsed = Stopwatch()..start();
    while (true) {
      try {
        return await store.read(key);
      } catch (error) {
        final remaining = readRetryTimeout - elapsed.elapsed;
        if (!_retryReadWhen(error) || remaining <= Duration.zero) rethrow;
        final delay = readRetryDelay < remaining ? readRetryDelay : remaining;
        if (delay > Duration.zero) await Future<void>.delayed(delay);
      }
    }
  }
}
