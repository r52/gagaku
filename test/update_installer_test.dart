import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/update_installer.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

void main() {
  setUpAll(() {
    logger = Logger(level: Level.off);
  });

  group('Android update download', () {
    test('streams, reports, verifies, and finalizes the APK', () async {
      final bytes = utf8.encode('fictional signed apk bytes');
      final client = _DownloadClient(bytes, chunks: 3);
      final cacheRoot = await Directory.systemTemp.createTemp('gagaku-update-');
      addTearDown(() => cacheRoot.delete(recursive: true));
      final progress = <int>[];
      var verifying = false;

      final file = await downloadAndroidUpdate(
        asset: _asset(bytes),
        client: client,
        cacheRoot: cacheRoot,
        onProgress: (received, total) => progress.add(received),
        onVerifying: () => verifying = true,
      );

      expect(await file.readAsBytes(), bytes);
      expect(file.path, endsWith('gagaku-updates/gagaku-update.apk'));
      expect(progress.last, bytes.length);
      expect(verifying, isTrue);
      expect(File('${file.path}.part').existsSync(), isFalse);
    });

    test('rejects a digest mismatch and removes partial files', () async {
      final bytes = utf8.encode('fictional signed apk bytes');
      final client = _DownloadClient(bytes);
      final cacheRoot = await Directory.systemTemp.createTemp('gagaku-update-');
      addTearDown(() => cacheRoot.delete(recursive: true));
      final asset = AndroidUpdateAsset(
        downloadUrl: Uri.parse(
          'https://github.com/r52/gagaku/releases/download/test/app-release.apk',
        ),
        size: bytes.length,
        sha256Digest: '0' * 64,
      );

      await expectLater(
        downloadAndroidUpdate(
          asset: asset,
          client: client,
          cacheRoot: cacheRoot,
          onProgress: (_, _) {},
          onVerifying: () {},
        ),
        throwsA(
          isA<UpdateInstallException>().having(
            (error) => error.failure,
            'failure',
            UpdateInstallFailure.verification,
          ),
        ),
      );

      final updateDirectory = Directory('${cacheRoot.path}/gagaku-updates');
      expect(await updateDirectory.list().toList(), isEmpty);
    });

    test('removes cached APKs on the next startup', () async {
      final cacheRoot = await Directory.systemTemp.createTemp('gagaku-update-');
      addTearDown(() async {
        if (await cacheRoot.exists()) {
          await cacheRoot.delete(recursive: true);
        }
      });
      final updateDirectory = Directory('${cacheRoot.path}/gagaku-updates');
      await updateDirectory.create();
      await File(
        '${updateDirectory.path}/gagaku-update.apk',
      ).writeAsBytes([1, 2, 3]);

      await cleanupCachedUpdateFiles(temporaryDirectory: () async => cacheRoot);

      expect(await updateDirectory.exists(), isFalse);
    });
  });

  group('Android update installer dialog', () {
    testWidgets('cannot dismiss while active and recovers after cancellation', (
      tester,
    ) async {
      await LocaleSettings.setLocale(AppLocale.en);
      final bytes = utf8.encode('fictional signed apk bytes');
      final cacheRoot = await Directory.systemTemp.createTemp('gagaku-update-');
      addTearDown(() => cacheRoot.delete(recursive: true));

      await _pumpInstallerApp(
        tester,
        asset: _asset(bytes),
        cacheRoot: cacheRoot,
        client: _DownloadClient(bytes),
        permission: () async => true,
        launcher: (_) async => const UpdateApkLaunchResult.success(),
      );

      await tester.tap(find.text('Start update'));
      await _pumpUntilVisible(tester, find.text('Updating...'));

      await tester.binding.handlePopRoute();
      await tester.pump();
      expect(find.text('Gagaku Update'), findsOneWidget);

      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      await tester.pump();

      expect(
        find.text(
          'The update was not completed. You can retry or close this dialog.',
        ),
        findsOneWidget,
      );
      expect(find.text('Retry'), findsOneWidget);
      await tester.tap(find.text('Close'));
      await tester.pumpAndSettle();
      expect(find.text('Gagaku Update'), findsNothing);
    });

    testWidgets('permission denial becomes a dismissible error', (
      tester,
    ) async {
      await LocaleSettings.setLocale(AppLocale.en);
      final bytes = utf8.encode('fictional signed apk bytes');
      final cacheRoot = await Directory.systemTemp.createTemp('gagaku-update-');
      addTearDown(() => cacheRoot.delete(recursive: true));

      await _pumpInstallerApp(
        tester,
        asset: _asset(bytes),
        cacheRoot: cacheRoot,
        client: _DownloadClient(bytes),
        permission: () async => false,
        launcher: (_) async => const UpdateApkLaunchResult.success(),
      );

      await tester.tap(find.text('Start update'));
      await _pumpUntilVisible(
        tester,
        find.text('Permission to install updates was not granted.'),
      );

      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();
      expect(find.text('Gagaku Update'), findsNothing);
    });
  });
}

AndroidUpdateAsset _asset(List<int> bytes) {
  return AndroidUpdateAsset(
    downloadUrl: Uri.parse(
      'https://github.com/r52/gagaku/releases/download/test/app-release.apk',
    ),
    size: bytes.length,
    sha256Digest: sha256.convert(bytes).toString(),
  );
}

Future<void> _pumpInstallerApp(
  WidgetTester tester, {
  required AndroidUpdateAsset asset,
  required Directory cacheRoot,
  required http.Client client,
  required Future<bool> Function() permission,
  required Future<UpdateApkLaunchResult> Function(String) launcher,
}) {
  return tester.pumpWidget(
    ProviderScope(
      overrides: [
        updateInstallPermissionProvider.overrideWithValue(permission),
        updateTemporaryDirectoryProvider.overrideWithValue(
          () async => cacheRoot,
        ),
        updateDownloadClientFactoryProvider.overrideWithValue(() => client),
        updateApkLauncherProvider.overrideWithValue(launcher),
      ],
      child: TranslationProvider(
        child: MaterialApp(
          home: Builder(
            builder: (context) => TextButton(
              onPressed: () => showAndroidUpdateInstallerDialog(context, asset),
              child: const Text('Start update'),
            ),
          ),
        ),
      ),
    ),
  );
}

Future<void> _pumpUntilVisible(WidgetTester tester, Finder finder) async {
  for (var attempt = 0; attempt < 50; attempt++) {
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 10)),
    );
    await tester.pump();
    if (finder.evaluate().isNotEmpty) return;
  }
  fail('Timed out waiting for $finder');
}

class _DownloadClient extends http.BaseClient {
  _DownloadClient(this.bytes, {this.chunks = 1});

  final List<int> bytes;
  final int chunks;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final chunkSize = (bytes.length / chunks).ceil();
    final streamChunks = <List<int>>[];
    for (var offset = 0; offset < bytes.length; offset += chunkSize) {
      streamChunks.add(
        bytes.sublist(offset, (offset + chunkSize).clamp(0, bytes.length)),
      );
    }
    return http.StreamedResponse(
      Stream<List<int>>.fromIterable(streamChunks),
      HttpStatus.ok,
      contentLength: bytes.length,
      request: request,
    );
  }
}
