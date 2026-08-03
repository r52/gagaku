import 'dart:collection';
import 'dart:convert';

import 'package:crypto/crypto.dart';

enum SyncClockRelation { equal, dominates, dominated, concurrent }

abstract final class SyncClock {
  static SyncClockRelation compare(
    Map<String, int> left,
    Map<String, int> right,
  ) {
    var leftGreater = false;
    var rightGreater = false;
    final devices = {...left.keys, ...right.keys};

    for (final device in devices) {
      final leftValue = left[device] ?? 0;
      final rightValue = right[device] ?? 0;
      if (leftValue > rightValue) leftGreater = true;
      if (rightValue > leftValue) rightGreater = true;
    }

    return switch ((leftGreater, rightGreater)) {
      (false, false) => SyncClockRelation.equal,
      (true, false) => SyncClockRelation.dominates,
      (false, true) => SyncClockRelation.dominated,
      (true, true) => SyncClockRelation.concurrent,
    };
  }

  static Map<String, int> join(Iterable<Map<String, int>> clocks) {
    final joined = <String, int>{};
    for (final clock in clocks) {
      for (final MapEntry(:key, :value) in clock.entries) {
        if (value > (joined[key] ?? 0)) joined[key] = value;
      }
    }
    return UnmodifiableMapView(_sortedClock(joined));
  }

  static Map<String, int> increment(Map<String, int> clock, String deviceId) {
    final incremented = Map<String, int>.of(clock);
    incremented[deviceId] = (incremented[deviceId] ?? 0) + 1;
    return UnmodifiableMapView(_sortedClock(incremented));
  }

  static Map<String, int> _sortedClock(Map<String, int> clock) {
    final keys = clock.keys.toList()..sort();
    return {for (final key in keys) key: clock[key]!};
  }
}

final class SyncValidationException implements Exception {
  const SyncValidationException(this.message, {this.key});

  final String message;
  final String? key;

  @override
  String toString() =>
      ['Invalid sync data', if (key != null) ' at $key', ': $message'].join();
}

final class SyncSnapshot {
  const SyncSnapshot({
    required this.key,
    required this.profileId,
    required this.deviceId,
    required this.deviceSequence,
    required this.revisionId,
    required this.createdAt,
    required this.seen,
    required this.payloadHash,
    required this.payloadLength,
    required this.payload,
    this.extra = const {},
  });

  final String key;
  final String profileId;
  final String deviceId;
  final int deviceSequence;
  final String revisionId;
  final DateTime createdAt;
  final Map<String, int> seen;
  final String payloadHash;
  final int payloadLength;
  final Map<String, dynamic> payload;
  final Map<String, dynamic> extra;

  Map<String, dynamic> toJson() => {
    ...extra,
    'format': SyncSnapshotCodec.snapshotFormat,
    'protocolVersion': SyncSnapshotCodec.protocolVersion,
    'profileId': profileId,
    'deviceId': deviceId,
    'deviceSequence': deviceSequence,
    'revisionId': revisionId,
    'createdAt': createdAt.toUtc().toIso8601String(),
    'seen': seen,
    'payloadFormat': SyncSnapshotCodec.payloadFormat,
    'encoding': SyncSnapshotCodec.encoding,
    'encryption': null,
    'payloadHash': payloadHash,
    'payloadLength': payloadLength,
    'payload': payload,
  };
}

abstract final class SyncSnapshotCodec {
  static const snapshotFormat = 'gagaku-sync-snapshot';
  static const protocolVersion = 1;
  static const payloadFormat = 'gagaku-backup-v2';
  static const encoding = 'json';
  static const hashAlgorithm = 'sha256';

  static const _knownFields = {
    'format',
    'protocolVersion',
    'profileId',
    'deviceId',
    'deviceSequence',
    'revisionId',
    'createdAt',
    'seen',
    'payloadFormat',
    'encoding',
    'encryption',
    'payloadHash',
    'payloadLength',
    'payload',
  };

  static String objectKey({
    required String deviceId,
    required int deviceSequence,
    required String revisionId,
  }) =>
      'devices/$deviceId/'
      '${deviceSequence.toString().padLeft(16, '0')}-$revisionId.snapshot';

  static SyncSnapshot create({
    required String profileId,
    required String deviceId,
    required int deviceSequence,
    required String revisionId,
    required DateTime createdAt,
    required Map<String, int> seen,
    required Map<String, dynamic> payload,
    Map<String, dynamic> extra = const {},
  }) {
    final payloadBytes = canonicalJsonBytes(payload);
    final key = objectKey(
      deviceId: deviceId,
      deviceSequence: deviceSequence,
      revisionId: revisionId,
    );
    final snapshot = SyncSnapshot(
      key: key,
      profileId: profileId,
      deviceId: deviceId,
      deviceSequence: deviceSequence,
      revisionId: revisionId,
      createdAt: createdAt.toUtc(),
      seen: UnmodifiableMapView(SyncClock._sortedClock(Map.of(seen))),
      payloadHash: '$hashAlgorithm:${sha256.convert(payloadBytes)}',
      payloadLength: payloadBytes.length,
      payload: UnmodifiableMapView(Map.of(payload)),
      extra: UnmodifiableMapView(Map.of(extra)),
    );
    _validate(snapshot, expectedProfileId: profileId);
    return snapshot;
  }

  static List<int> encode(SyncSnapshot snapshot) {
    _validate(snapshot, expectedProfileId: snapshot.profileId);
    return canonicalJsonBytes(snapshot.toJson());
  }

  static SyncSnapshot decode(
    String key,
    List<int> bytes, {
    required String expectedProfileId,
  }) {
    try {
      final decoded = jsonDecode(utf8.decode(bytes));
      if (decoded is! Map) {
        throw const SyncValidationException('snapshot root must be an object');
      }
      final json = Map<String, dynamic>.from(decoded);
      _expectEqual(json, 'format', snapshotFormat);
      _expectEqual(json, 'protocolVersion', protocolVersion);
      _expectEqual(json, 'payloadFormat', payloadFormat);
      _expectEqual(json, 'encoding', encoding);
      if (json['encryption'] != null) {
        throw const SyncValidationException(
          'encrypted snapshots are not supported by protocol version 1',
        );
      }

      final profileId = _string(json, 'profileId');
      final deviceId = _string(json, 'deviceId');
      final deviceSequence = _integer(json, 'deviceSequence');
      final revisionId = _string(json, 'revisionId');
      final createdAtText = _string(json, 'createdAt');
      final createdAt = DateTime.parse(createdAtText);
      if (!createdAt.isUtc) {
        throw const SyncValidationException('createdAt must be UTC');
      }
      final seenValue = json['seen'];
      if (seenValue is! Map) {
        throw const SyncValidationException('seen must be an object');
      }
      final seen = <String, int>{};
      for (final MapEntry(:key, :value) in seenValue.entries) {
        if (key is! String || key.isEmpty || value is! int || value <= 0) {
          throw const SyncValidationException(
            'seen entries require non-empty device IDs and positive integers',
          );
        }
        seen[key] = value;
      }
      final payloadValue = json['payload'];
      if (payloadValue is! Map) {
        throw const SyncValidationException('payload must be an object');
      }
      final payload = Map<String, dynamic>.from(payloadValue);
      final extra = <String, dynamic>{
        for (final MapEntry(:key, :value) in json.entries)
          if (!_knownFields.contains(key)) key: value,
      };

      final snapshot = SyncSnapshot(
        key: key,
        profileId: profileId,
        deviceId: deviceId,
        deviceSequence: deviceSequence,
        revisionId: revisionId,
        createdAt: createdAt,
        seen: UnmodifiableMapView(SyncClock._sortedClock(seen)),
        payloadHash: _string(json, 'payloadHash'),
        payloadLength: _integer(json, 'payloadLength'),
        payload: UnmodifiableMapView(payload),
        extra: UnmodifiableMapView(extra),
      );
      _validate(snapshot, expectedProfileId: expectedProfileId);
      return snapshot;
    } on SyncValidationException catch (error) {
      throw SyncValidationException(error.message, key: key);
    } catch (error) {
      throw SyncValidationException(error.toString(), key: key);
    }
  }

  static List<int> canonicalJsonBytes(Object? value) =>
      utf8.encode(_canonicalJson(value));

  static String _canonicalJson(Object? value) {
    return switch (value) {
      null || bool() || String() => jsonEncode(value),
      num number when number.isFinite => jsonEncode(number),
      num() => throw const SyncValidationException(
        'non-finite JSON numbers are not supported',
      ),
      List values => '[${values.map(_canonicalJson).join(',')}]',
      Map values => _canonicalJsonMap(values),
      _ => throw SyncValidationException(
        'unsupported JSON value ${value.runtimeType}',
      ),
    };
  }

  static String _canonicalJsonMap(Map values) {
    if (values.keys.any((key) => key is! String)) {
      throw const SyncValidationException('JSON object keys must be strings');
    }
    final keys = values.keys.cast<String>().toList()..sort();
    return '{${keys.map((key) => '${jsonEncode(key)}:'
        '${_canonicalJson(values[key])}').join(',')}}';
  }

  static void _validate(
    SyncSnapshot snapshot, {
    required String expectedProfileId,
  }) {
    if (snapshot.profileId != expectedProfileId) {
      throw const SyncValidationException('profile ID mismatch');
    }
    if (snapshot.profileId.isEmpty ||
        snapshot.deviceId.isEmpty ||
        snapshot.revisionId.isEmpty ||
        snapshot.deviceId.contains('/') ||
        snapshot.revisionId.contains('/')) {
      throw const SyncValidationException('invalid snapshot identity');
    }
    if (snapshot.deviceSequence <= 0) {
      throw const SyncValidationException('device sequence must be positive');
    }
    if (snapshot.seen[snapshot.deviceId] != snapshot.deviceSequence) {
      throw const SyncValidationException(
        'local seen counter must equal device sequence',
      );
    }
    if (snapshot.seen.entries.any(
      (entry) => entry.key.isEmpty || entry.value <= 0,
    )) {
      throw const SyncValidationException('invalid vector clock');
    }
    final expectedKey = objectKey(
      deviceId: snapshot.deviceId,
      deviceSequence: snapshot.deviceSequence,
      revisionId: snapshot.revisionId,
    );
    if (snapshot.key != expectedKey) {
      throw const SyncValidationException('filename/envelope mismatch');
    }
    final payloadBytes = canonicalJsonBytes(snapshot.payload);
    if (payloadBytes.length != snapshot.payloadLength) {
      throw const SyncValidationException('payload length mismatch');
    }
    final expectedHash = '$hashAlgorithm:${sha256.convert(payloadBytes)}';
    if (snapshot.payloadHash != expectedHash) {
      throw const SyncValidationException('payload hash mismatch');
    }
  }

  static void _expectEqual(
    Map<String, dynamic> json,
    String key,
    Object expected,
  ) {
    if (json[key] != expected) {
      throw SyncValidationException('unsupported $key');
    }
  }

  static String _string(Map<String, dynamic> json, String key) {
    final value = json[key];
    if (value is! String || value.isEmpty) {
      throw SyncValidationException('$key must be a non-empty string');
    }
    return value;
  }

  static int _integer(Map<String, dynamic> json, String key) {
    final value = json[key];
    if (value is! int) {
      throw SyncValidationException('$key must be an integer');
    }
    return value;
  }
}

sealed class SyncHeadSelection {
  const SyncHeadSelection();

  List<SyncSnapshot> get heads;
}

final class NoSyncHeads extends SyncHeadSelection {
  const NoSyncHeads();

  @override
  List<SyncSnapshot> get heads => const [];
}

final class CanonicalSyncHead extends SyncHeadSelection {
  const CanonicalSyncHead(this.head);

  final SyncSnapshot head;

  @override
  List<SyncSnapshot> get heads => [head];
}

final class EquivalentSyncHeads extends SyncHeadSelection {
  const EquivalentSyncHeads(this.heads, this.joinedClock);

  @override
  final List<SyncSnapshot> heads;
  final Map<String, int> joinedClock;
}

final class ForkedSyncHeads extends SyncHeadSelection {
  const ForkedSyncHeads(this.heads);

  @override
  final List<SyncSnapshot> heads;
}

abstract final class SyncHeadSelector {
  static SyncHeadSelection select(Iterable<SyncSnapshot> input) {
    final heads = input.toList()..sort((a, b) => a.key.compareTo(b.key));
    if (heads.isEmpty) return const NoSyncHeads();

    for (var left = 0; left < heads.length; left++) {
      for (var right = left + 1; right < heads.length; right++) {
        if (SyncClock.compare(heads[left].seen, heads[right].seen) ==
                SyncClockRelation.equal &&
            heads[left].payloadHash != heads[right].payloadHash) {
          throw const SyncValidationException(
            'equal vector clocks have different payload hashes',
          );
        }
      }
    }

    final undominated = [
      for (final candidate in heads)
        if (!heads.any(
          (other) =>
              !identical(candidate, other) &&
              SyncClock.compare(other.seen, candidate.seen) ==
                  SyncClockRelation.dominates,
        ))
          candidate,
    ];

    if (undominated.length == 1) {
      return CanonicalSyncHead(undominated.single);
    }
    final first = undominated.first;
    final allEqual = undominated.every(
      (head) =>
          SyncClock.compare(first.seen, head.seen) == SyncClockRelation.equal,
    );
    if (allEqual) return CanonicalSyncHead(first);

    final hashes = undominated.map((head) => head.payloadHash).toSet();
    if (hashes.length == 1) {
      return EquivalentSyncHeads(
        List.unmodifiable(undominated),
        SyncClock.join(undominated.map((head) => head.seen)),
      );
    }
    return ForkedSyncHeads(List.unmodifiable(undominated));
  }
}
