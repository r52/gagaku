import 'package:flutter_test/flutter_test.dart';
import 'package:gagaku/local/model/model.dart';

void main() {
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
