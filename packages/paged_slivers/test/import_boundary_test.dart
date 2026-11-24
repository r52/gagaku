import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

final _forbidden = RegExp(
  r'''^\s*(?:import|export)\s+['"]package:(?:flutter/(?:material|cupertino)\.dart|gagaku/)''',
  multiLine: true,
);

void main() {
  test('lib does not import SDK Material/Cupertino or the app', () {
    final offenders = [
      for (final file in Directory('lib').listSync(recursive: true))
        if (file is File &&
            file.path.endsWith('.dart') &&
            _forbidden.hasMatch(file.readAsStringSync()))
          file.path,
    ];

    expect(offenders, isEmpty);
  });
}
