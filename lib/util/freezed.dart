import 'package:freezed_annotation/freezed_annotation.dart' show JsonConverter;

class TimestampSerializer implements JsonConverter<DateTime, dynamic> {
  const TimestampSerializer();

  @override
  DateTime fromJson(dynamic timestamp) => DateTime.parse(timestamp);

  @override
  dynamic toJson(DateTime date) => date.toString();
}

class NullableTimestampSerializer implements JsonConverter<DateTime?, dynamic> {
  const NullableTimestampSerializer();

  @override
  DateTime? fromJson(dynamic timestamp) =>
      timestamp == null ? null : DateTime.parse(timestamp);

  @override
  dynamic toJson(DateTime? date) => date?.toString();
}

class EpochTimestampSerializer implements JsonConverter<DateTime?, dynamic> {
  const EpochTimestampSerializer();

  @override
  DateTime? fromJson(dynamic timestamp) {
    if (timestamp == null) {
      return null;
    }

    final epoch = switch (timestamp) {
      int t => t,
      double d => d.round(),
      _ => int.parse(timestamp),
    };

    return DateTime.fromMillisecondsSinceEpoch(epoch * 1000);
  }

  @override
  dynamic toJson(DateTime? date) {
    if (date == null) {
      return null;
    }

    return (date.millisecondsSinceEpoch / 1000).round().toString();
  }
}

/// Millisecond Unix epoch as an `int`; decodes to UTC.
///
/// Unlike [TimestampSerializer], the stored value is an absolute instant even
/// when the encoded `DateTime` is local, so it survives time zone and DST
/// changes between write and read.
class EpochMillisTimestampSerializer implements JsonConverter<DateTime, int> {
  const EpochMillisTimestampSerializer();

  @override
  DateTime fromJson(int timestamp) =>
      DateTime.fromMillisecondsSinceEpoch(timestamp, isUtc: true);

  @override
  int toJson(DateTime date) => date.millisecondsSinceEpoch;
}

class NullableEpochMillisTimestampSerializer
    implements JsonConverter<DateTime?, int?> {
  const NullableEpochMillisTimestampSerializer();

  @override
  DateTime? fromJson(int? timestamp) => timestamp == null
      ? null
      : DateTime.fromMillisecondsSinceEpoch(timestamp, isUtc: true);

  @override
  int? toJson(DateTime? date) => date?.millisecondsSinceEpoch;
}

class MappedEpochTimestampSerializer
    implements JsonConverter<DateTime?, dynamic> {
  const MappedEpochTimestampSerializer();

  @override
  DateTime? fromJson(dynamic timestamp) {
    if (timestamp == null) {
      return null;
    }

    if (timestamp is! Map<String, dynamic>) {
      return null;
    }

    final date = timestamp.entries.first.value;

    final epoch = switch (date) {
      int t => t,
      double d => d.round(),
      _ => int.parse(date),
    };

    return DateTime.fromMillisecondsSinceEpoch(epoch * 1000);
  }

  @override
  dynamic toJson(DateTime? date) {
    if (date == null) {
      return null;
    }

    return {'0': (date.millisecondsSinceEpoch / 1000).round().toString()};
  }
}
