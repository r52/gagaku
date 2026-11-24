import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:gagaku/util/directory_picker.dart';
import 'package:integration_test/integration_test.dart';

Uri _tree(String encodedDocumentId) => Uri.parse(
  'content://${ExternalStorageTree.authority}/tree/$encodedDocumentId',
);

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  test('resolves primary storage trees through StorageManager', () {
    expect(Platform.isAndroid, isTrue);

    // The standard emulator mounts primary shared storage here. A device with
    // a different mount point is exactly what the StorageManager lookup is
    // for, so this expectation is specific to the emulator.
    expect(
      resolveExternalStorageTreePath(_tree('primary%3A')),
      '/storage/emulated/0',
    );
    expect(
      resolveExternalStorageTreePath(_tree('primary%3ADownload%2FManga')),
      '/storage/emulated/0/Download/Manga',
    );
  });

  // The Pixel emulator images ship an emulated SD card with this UUID
  // (`adb shell sm list-volumes all`).
  const emulatorSdCard = '0000-0000';

  test(
    'resolves removable volume trees through StorageManager',
    () {
      expect(
        resolveExternalStorageTreePath(_tree('$emulatorSdCard%3AManga')),
        '/storage/$emulatorSdCard/Manga',
      );
    },
    skip: Directory('/storage/$emulatorSdCard').existsSync()
        ? false
        : 'This emulator has no SD card volume $emulatorSdCard',
  );

  test('returns null for unknown volumes and other providers', () {
    expect(resolveExternalStorageTreePath(_tree('FFFF-FFFE%3AManga')), isNull);
    expect(
      resolveExternalStorageTreePath(
        Uri.parse(
          'content://com.android.providers.downloads.documents/tree/downloads',
        ),
      ),
      isNull,
    );
  });
}
