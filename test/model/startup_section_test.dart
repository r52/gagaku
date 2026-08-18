import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:gagaku/model/model.dart';
import 'package:gagaku/model/startup_section.dart';
import 'package:gagaku/settings.dart';
import 'package:hive_ce/hive.dart';

void main() {
  late Directory tempDir;

  setUpAll(() async {
    tempDir = await Directory.systemTemp.createTemp('gagaku_startup_test');
    Hive.init(tempDir.path);
    await Hive.openBox(gagakuLocalBox);
  });

  setUp(() => Hive.box(gagakuLocalBox).clear());

  tearDownAll(() async {
    await Hive.box(gagakuLocalBox).close();
    await tempDir.delete(recursive: true);
  });

  test('defaults missing and unknown values to MangaDex', () async {
    expect(StartupSection.load(), StartupSection.mangaDex);

    await Hive.box(gagakuLocalBox).put(startupSectionHiveKey, 'future-section');

    expect(StartupSection.load(), StartupSection.mangaDex);
  });

  test('persists each startup section by enum name', () async {
    for (final section in StartupSection.values) {
      await section.save();

      expect(Hive.box(gagakuLocalBox).get(startupSectionHiveKey), section.name);
      expect(StartupSection.load(), section);
    }
  });

  test('maps startup sections to their shell locations', () {
    expect(StartupSection.mangaDex.location, '/');
    expect(StartupSection.webSources.location, '/extensions');
    expect(StartupSection.localLibrary.location, '/local');
  });

  test('startup section remains excluded from manual backups', () {
    expect(gagakuBackupExcludedLocalKeys, contains(startupSectionHiveKey));
  });
}
