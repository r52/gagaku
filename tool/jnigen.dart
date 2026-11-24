// Regenerates lib/util/android/jni_bindings.dart.
//
// Run from the repository root after `flutter pub get` and at least one
// Android Gradle build (JNIgen resolves the compile classpath through the app's
// Gradle project):
//
//   dart run tool/jnigen.dart
//
// Only the members listed in [_members] are bound. Add entries there instead of
// binding whole Android classes.

import 'dart:io';

import 'package:jnigen/jnigen.dart';

const _members = <String, Set<String>>{
  'android.content.Context': {'getSystemService', 'STORAGE_SERVICE'},
  'android.os.storage.StorageManager': {'getStorageVolumes'},
  'android.os.storage.StorageVolume': {'isPrimary', 'getUuid', 'getDirectory'},
  'java.io.File': {'getAbsolutePath'},
};

void main(List<String> args) async {
  final root = Platform.script.resolve('../');
  String? currentClass;

  await JniGenerator(
    input: Input(
      classes: _members.keys.toList(),
      androidSdk: AndroidSdk(addGradleDeps: true, androidExample: root),
    ),
    output: Output(
      dart: DartOutput(
        path: root.resolve('lib/util/android/jni_bindings.dart'),
        structure: OutputStructure.singleFile,
      ),
    ),
    visitors: [
      Visitor(
        classDecl: (c) {
          currentClass = c.binaryName;
          c.isIncluded = _members.containsKey(c.binaryName);
        },
        method: (m) {
          m.isIncluded =
              !m.isConstructor &&
              (_members[currentClass]?.contains(m.originalName) ?? false);
        },
        field: (f) {
          f.isIncluded =
              _members[currentClass]?.contains(f.originalName) ?? false;
        },
      ),
    ],
  ).generate();
}
