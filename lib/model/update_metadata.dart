import 'package:gagaku/model/model.dart';
import 'package:hive_ce/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const updateLastCheckHiveKey = 'update_last_check';
const updateIgnoredVersionsHiveKey = 'update_ignored_versions';

abstract interface class UpdateMetadataStore {
  DateTime? get lastUpdateCheck;

  Set<String> get ignoredUpdates;

  Future<void> recordUpdateCheck(DateTime checkedAt);

  Future<void> ignoreUpdate(String update, DateTime checkedAt);
}

final updateMetadataStoreProvider = Provider<UpdateMetadataStore>(
  (ref) => const HiveUpdateMetadataStore(),
);

final class HiveUpdateMetadataStore implements UpdateMetadataStore {
  const HiveUpdateMetadataStore();

  Box<dynamic> get _box => Hive.box(gagakuLocalBox);

  @override
  DateTime? get lastUpdateCheck {
    return switch (_box.get(updateLastCheckHiveKey)) {
      final DateTime value => value,
      final String value => DateTime.tryParse(value),
      _ => null,
    };
  }

  @override
  Set<String> get ignoredUpdates {
    return switch (_box.get(updateIgnoredVersionsHiveKey)) {
      final Iterable<dynamic> values => values.whereType<String>().toSet(),
      _ => const <String>{},
    };
  }

  @override
  Future<void> recordUpdateCheck(DateTime checkedAt) {
    return _box.put(updateLastCheckHiveKey, checkedAt);
  }

  @override
  Future<void> ignoreUpdate(String update, DateTime checkedAt) {
    final updates = {...ignoredUpdates, update};
    return _box.putAll({
      updateIgnoredVersionsHiveKey: updates.toList(),
      updateLastCheckHiveKey: checkedAt,
    });
  }
}
