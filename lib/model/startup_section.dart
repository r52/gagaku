import 'package:gagaku/model/model.dart';
import 'package:hive_ce/hive.dart';

const startupSectionHiveKey = 'startup_section';

enum StartupSection {
  mangaDex('/'),
  webSources(GagakuRoute.extension),
  localLibrary(GagakuRoute.local);

  const StartupSection(this.location);

  final String location;

  static StartupSection fromStorage(Object? value) {
    for (final section in values) {
      if (section.name == value) return section;
    }

    return mangaDex;
  }

  static StartupSection load() {
    return fromStorage(Hive.box(gagakuLocalBox).get(startupSectionHiveKey));
  }

  Future<void> save() {
    return Hive.box(gagakuLocalBox).put(startupSectionHiveKey, name);
  }
}
