// ignore_for_file: no_leading_underscores_for_local_identifiers, avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:build/build.dart';
import 'package:yaml/yaml.dart';

bool wroteVersion = false;
String outputFilePath = 'lib/version.dart';

Builder versionBuilderFactory(BuilderOptions options) {
  if (!wroteVersion) {
    print('Generating "$outputFilePath" ...');

    final run = Process.runSync('flutter', [
      '--version',
      '--machine',
    ], runInShell: true);

    final result = Map<String, Object>.from(
      json.decode(run.stdout.toString()) as Map,
    );

    String outputContents = constantDeclarationsFromMap(result, 'kFlutter');
    outputContents +=
        '\nconst kBuildTimestamp = \'${DateTime.now().toIso8601String()}\';\n';

    final pubspec = File('pubspec.yaml');
    final pcont = pubspec.readAsStringSync();
    final data = loadYaml(pcont);

    outputContents += 'const kPackageName = \'${data['name']}\';\n';
    outputContents += 'const kPackageVersion = \'${data['version']}\';\n';

    File dartFile = File(outputFilePath);
    dartFile.writeAsStringSync(outputContents, flush: true);

    wroteVersion = true;
  }

  return VersionBuilder();
}

String constantDeclarationsFromMap(
  Map<String, Object> map, [
  String prefix = 'k',
]) {
  String _capitalize(String text) =>
      text.isEmpty ? text : "${text[0].toUpperCase()}${text.substring(1)}";

  String _constantName(String name, String prefix) =>
      prefix.isEmpty ? name : prefix + _capitalize(name);

  return map.entries
      .map(
        (e) =>
            'const ${_constantName(e.key, prefix)} = ${json.encode(e.value)};',
      )
      .join('\n');
}

class VersionBuilder extends Builder {
  @override
  Future<FutureOr<void>> build(BuildStep buildStep) async {}

  @override
  Map<String, List<String>> get buildExtensions {
    return const {
      '.dart': ['.dart_xxx'],
    };
  }
}
