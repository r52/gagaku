import 'package:flutter_test/flutter_test.dart';
import 'package:gagaku/util/directory_picker.dart';

Uri _tree(String encodedDocumentId) => Uri.parse(
  'content://${ExternalStorageTree.authority}/tree/$encodedDocumentId',
);

void main() {
  group('ExternalStorageTree.parse', () {
    test('parses a primary storage tree with encoded separators', () {
      final tree = ExternalStorageTree.parse(_tree('primary%3AManga%2FSeries'));

      expect(tree, isNotNull);
      expect(tree!.volumeId, 'primary');
      expect(tree.isPrimary, isTrue);
      expect(tree.relativePath, 'Manga/Series');
    });

    test('parses a removable volume tree', () {
      final tree = ExternalStorageTree.parse(_tree('1234-ABCD%3AComics'));

      expect(tree!.volumeId, '1234-ABCD');
      expect(tree.isPrimary, isFalse);
      expect(tree.relativePath, 'Comics');
    });

    test('parses a volume root', () {
      final tree = ExternalStorageTree.parse(_tree('primary%3A'));

      expect(tree!.relativePath, isEmpty);
    });

    test('normalizes redundant separators', () {
      final tree = ExternalStorageTree.parse(_tree('primary%3A%2FManga%2F%2F'));

      expect(tree!.relativePath, 'Manga');
    });

    test('rejects other document providers', () {
      expect(
        ExternalStorageTree.parse(
          Uri.parse(
            'content://com.android.providers.downloads.documents/tree/downloads',
          ),
        ),
        isNull,
      );
      expect(
        ExternalStorageTree.parse(
          Uri.parse(
            'content://com.google.android.apps.docs.storage/tree/acc%3D1%3Bdoc%3D2',
          ),
        ),
        isNull,
      );
    });

    test('rejects non-tree and malformed URIs', () {
      expect(
        ExternalStorageTree.parse(Uri.file('/storage/emulated/0')),
        isNull,
      );
      expect(
        ExternalStorageTree.parse(
          Uri.parse(
            'content://${ExternalStorageTree.authority}/document/primary%3AManga',
          ),
        ),
        isNull,
      );
      expect(
        ExternalStorageTree.parse(
          Uri.parse(
            'content://${ExternalStorageTree.authority}/tree/primary%3AManga/document/primary%3AManga',
          ),
        ),
        isNull,
      );
      expect(ExternalStorageTree.parse(_tree('Manga')), isNull);
      expect(ExternalStorageTree.parse(_tree('%3AManga')), isNull);
    });

    test('rejects dot segments', () {
      expect(ExternalStorageTree.parse(_tree('primary%3A..%2Fdata')), isNull);
      expect(ExternalStorageTree.parse(_tree('primary%3AManga%2F.')), isNull);
    });
  });

  group('ExternalStorageTree.matchesVolume', () {
    const primary = ExternalStorageTree(volumeId: 'primary', relativePath: '');
    const removable = ExternalStorageTree(
      volumeId: '1234-ABCD',
      relativePath: '',
    );

    test('matches the primary volume by flag, not UUID', () {
      expect(primary.matchesVolume(isPrimary: true, uuid: null), isTrue);
      expect(primary.matchesVolume(isPrimary: false, uuid: 'primary'), isFalse);
    });

    test('matches removable volumes by UUID, ignoring case', () {
      expect(
        removable.matchesVolume(isPrimary: false, uuid: '1234-abcd'),
        isTrue,
      );
      expect(
        removable.matchesVolume(isPrimary: false, uuid: '5678-EF01'),
        isFalse,
      );
      expect(removable.matchesVolume(isPrimary: true, uuid: null), isFalse);
    });
  });

  group('ExternalStorageTree.resolve', () {
    test('joins the relative path onto the volume directory', () {
      const tree = ExternalStorageTree(
        volumeId: 'primary',
        relativePath: 'Manga/Series',
      );

      expect(
        tree.resolve('/storage/emulated/0'),
        '/storage/emulated/0/Manga/Series',
      );
      expect(tree.resolve('/mnt/sdcard/'), '/mnt/sdcard/Manga/Series');
    });

    test('returns the volume directory for a volume root', () {
      const tree = ExternalStorageTree(volumeId: 'primary', relativePath: '');

      expect(tree.resolve('/storage/emulated/0'), '/storage/emulated/0');
    });
  });
}
