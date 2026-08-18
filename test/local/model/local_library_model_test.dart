import 'package:flutter_test/flutter_test.dart';
import 'package:gagaku/local/model/config.dart';
import 'package:gagaku/local/model/document_session.dart';
import 'package:gagaku/local/model/model.dart';

void main() {
  group('LocalLibConfig EPUB preferences', () {
    test('uses backward-compatible defaults for legacy JSON', () {
      final config = LocalLibConfig.fromJson({'libraryDirectory': '/library'});

      expect(config.libraryDirectory, '/library');
      expect(config.epubFontSize, 1.0);
      expect(config.epubScroll, isFalse);
    });

    test('round-trips persisted EPUB preferences', () {
      final config = LocalLibConfig(
        libraryDirectory: '/library',
        epubFontSize: 1.4,
        epubScroll: true,
      );

      expect(LocalLibConfig.fromJson(config.toJson()), config);
    });
  });

  group('isSupportedLocalImagePath', () {
    test('matches common image formats case-insensitively', () {
      const formats = FormatInfo(avif: false);

      expect(isSupportedLocalImagePath('page.JPG', formats), isTrue);
      expect(isSupportedLocalImagePath('page.jpeg', formats), isTrue);
      expect(isSupportedLocalImagePath('page.PNG', formats), isTrue);
      expect(isSupportedLocalImagePath('page.WebP', formats), isTrue);
    });

    test('gates AVIF support through FormatInfo', () {
      expect(
        isSupportedLocalImagePath('page.avif', const FormatInfo(avif: false)),
        isFalse,
      );
      expect(
        isSupportedLocalImagePath('page.avif', const FormatInfo(avif: true)),
        isTrue,
      );
    });
  });

  group('localLibraryFileTypeFromPath', () {
    test('recognizes archives regardless of document support', () {
      expect(
        localLibraryFileTypeFromPath(
          '/library/Chapter.CBZ',
          documentsEnabled: false,
        ),
        LibraryItemType.archive,
      );
    });

    test('recognizes PDF and EPUB only when documents are enabled', () {
      expect(
        localLibraryFileTypeFromPath(
          '/library/Novel.PDF',
          documentsEnabled: true,
        ),
        LibraryItemType.pdf,
      );
      expect(
        localLibraryFileTypeFromPath(
          '/library/Novel.ePuB',
          documentsEnabled: true,
        ),
        LibraryItemType.epub,
      );
      expect(
        localLibraryFileTypeFromPath(
          '/library/Novel.pdf',
          documentsEnabled: false,
        ),
        isNull,
      );
      expect(
        localLibraryFileTypeFromPath(
          '/library/Novel.epub.zip',
          documentsEnabled: true,
        ),
        LibraryItemType.archive,
      );
    });

    test('maps document leaves to production reader descriptors', () {
      final pdf = LocalLibraryItem(
        path: '/library/Novel.pdf',
        name: 'Novel.pdf',
        type: LibraryItemType.pdf,
        modified: DateTime(2026),
        isReadable: true,
      );
      final epub = LocalLibraryItem(
        path: '/library/Novel.epub',
        type: LibraryItemType.epub,
        modified: DateTime(2026),
        isReadable: true,
      );

      expect(pdf.documentDescriptor?.path, pdf.path);
      expect(pdf.documentDescriptor?.title, pdf.name);
      expect(pdf.documentDescriptor?.format, LocalDocumentFormat.pdf);
      expect(epub.documentDescriptor?.format, LocalDocumentFormat.epub);
      expect(epub.documentDescriptor?.title, epub.path);
      expect(
        LocalLibraryItem(
          path: '/library/folder',
          type: LibraryItemType.directory,
          modified: DateTime(2026),
        ).documentDescriptor,
        isNull,
      );
    });
  });

  group('LocalLibraryItem.sortedChildren', () {
    test('returns sorted children without mutating the scanned tree', () {
      final parent = LocalLibraryItem(
        path: '/library',
        type: LibraryItemType.directory,
        modified: DateTime(2026),
      );
      final zeta = LocalLibraryItem(
        path: '/library/zeta',
        name: 'zeta',
        type: LibraryItemType.directory,
        modified: DateTime(2026),
      );
      final alpha = LocalLibraryItem(
        path: '/library/alpha',
        name: 'alpha',
        type: LibraryItemType.directory,
        modified: DateTime(2026),
      );

      parent.children = [zeta, alpha];

      final sorted = parent.sortedChildren(LibrarySort.name_desc);

      expect(sorted, [alpha, zeta]);
      expect(parent.children, [zeta, alpha]);
    });
  });
}
