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
