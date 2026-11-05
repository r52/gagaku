import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/util/page_number_bar.dart';
import 'package:material_ui/material_ui.dart';

/// Renders slots one-based, with `…` for gaps, e.g. `1 … 4 5 6 … 10`.
String describe(List<PageNumberSlot> slots) => slots
    .map(
      (slot) => switch (slot) {
        PageNumberSlotPage(:final index) => '${index + 1}',
        PageNumberSlotGap() => '…',
      },
    )
    .join(' ');

String layout(int pageCount, int currentPage, int slots) => describe(
  pageNumberSlots(pageCount: pageCount, currentPage: currentPage, slots: slots),
);

void main() {
  test('pageCountOf rounds up and never returns less than one page', () {
    expect(pageCountOf(0, 32), 1);
    expect(pageCountOf(1, 32), 1);
    expect(pageCountOf(32, 32), 1);
    expect(pageCountOf(33, 32), 2);
    expect(pageCountOf(64, 32), 2);
  });

  group('pageNumberSlots', () {
    test('treats empty and single-page lists as one page', () {
      expect(layout(0, 0, 10), '1');
      expect(layout(-3, 2, 10), '1');
      expect(layout(1, 0, 10), '1');
    });

    test('shows every page when they fit', () {
      expect(layout(2, 1, 7), '1 2');
      expect(layout(7, 3, 7), '1 2 3 4 5 6 7');
    });

    test('elides around a centered window', () {
      expect(layout(10, 0, 7), '1 2 3 4 5 … 10');
      expect(layout(10, 3, 7), '1 2 3 4 5 … 10');
      expect(layout(10, 4, 7), '1 … 4 5 6 … 10');
      expect(layout(10, 5, 7), '1 … 5 6 7 … 10');
      expect(layout(10, 6, 7), '1 … 6 7 8 9 10');
      expect(layout(10, 9, 7), '1 … 6 7 8 9 10');
    });

    test('shows a page instead of a gap that would hide only that page', () {
      expect(layout(6, 2, 5), '1 2 3 … 6');
      expect(layout(6, 3, 5), '1 … 4 5 6');
      expect(layout(8, 3, 5), '1 … 4 … 8');
    });

    test('uses a contiguous window below five slots', () {
      expect(layout(10, 0, 3), '1 2 3');
      expect(layout(10, 5, 3), '5 6 7');
      expect(layout(10, 9, 3), '8 9 10');
      expect(layout(10, 5, 4), '5 6 7 8');
      expect(layout(10, 4, 1), '5');
      expect(layout(10, 4, 0), '5');
    });

    test('clamps an out-of-range current page', () {
      expect(layout(10, 20, 7), '1 … 6 7 8 9 10');
      expect(layout(10, -1, 7), '1 2 3 4 5 … 10');
    });

    test('holds its invariants across inputs', () {
      for (var count = 1; count <= 40; count++) {
        for (var slots = 0; slots <= 15; slots++) {
          for (var current = 0; current < count; current++) {
            final result = pageNumberSlots(
              pageCount: count,
              currentPage: current,
              slots: slots,
            );
            final reason = 'count=$count slots=$slots current=$current';
            final available = slots < 1 ? 1 : slots;
            final pages = [
              for (final slot in result)
                if (slot case PageNumberSlotPage(:final index)) index,
            ];

            expect(
              result.length,
              count < available ? count : available,
              reason: reason,
            );
            expect(pages, contains(current), reason: reason);
            for (var i = 1; i < pages.length; i++) {
              expect(pages[i], greaterThan(pages[i - 1]), reason: reason);
            }

            for (var i = 0; i < result.length; i++) {
              if (result[i] is! PageNumberSlotGap) continue;
              final before = result[i - 1] as PageNumberSlotPage;
              final after = result[i + 1] as PageNumberSlotPage;
              expect(
                after.index - before.index - 1,
                greaterThan(1),
                reason: reason,
              );
            }

            if (count > available && available >= 5) {
              expect(pages.first, 0, reason: reason);
              expect(pages.last, count - 1, reason: reason);
            }
          }
        }
      }
    });
  });

  group('PageNumberBar', () {
    setUpAll(() async {
      await LocaleSettings.setLocale(AppLocale.en);
    });

    final colorScheme = ColorScheme.fromSeed(seedColor: Colors.teal);

    Future<List<int>> pumpBar(
      WidgetTester tester, {
      required int pageCount,
      required int currentPage,
      double width = PageNumberBar.slotExtent * 7,
    }) async {
      final changes = <int>[];
      await tester.pumpWidget(
        TranslationProvider(
          child: MaterialApp(
            theme: ThemeData(colorScheme: colorScheme),
            home: Scaffold(
              body: Center(
                child: SizedBox(
                  width: width,
                  child: PageNumberBar(
                    pageCount: pageCount,
                    currentPage: currentPage,
                    onPageChanged: changes.add,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      return changes;
    }

    Finder pageButton(String label) => find.widgetWithText(TextButton, label);

    testWidgets('fits the number of slots to the width', (tester) async {
      await pumpBar(tester, pageCount: 10, currentPage: 4);

      expect(find.byType(TextButton), findsNWidgets(5));
      expect(find.text('…'), findsNWidgets(2));
      for (final label in ['1', '4', '5', '6', '10']) {
        expect(pageButton(label), findsOneWidget);
      }

      await pumpBar(
        tester,
        pageCount: 10,
        currentPage: 4,
        width: PageNumberBar.slotExtent * 3,
      );
      expect(find.byType(TextButton), findsNWidgets(3));
      expect(find.text('…'), findsNothing);
    });

    testWidgets('reports taps on other pages only', (tester) async {
      final changes = await pumpBar(tester, pageCount: 10, currentPage: 4);

      await tester.tap(pageButton('6'));
      await tester.tap(pageButton('5'));
      await tester.tap(pageButton('10'));

      expect(changes, [5, 9]);
    });

    testWidgets('styles the selected page from the material_ui theme', (
      tester,
    ) async {
      await pumpBar(tester, pageCount: 10, currentPage: 4);

      Material surface(String label) => tester.widget<Material>(
        find.descendant(of: pageButton(label), matching: find.byType(Material)),
      );

      final selected = surface('5');
      expect(selected.color, colorScheme.secondaryContainer);
      expect(selected.textStyle?.color, colorScheme.onSecondaryContainer);
      expect(selected.shape, isA<RoundedRectangleBorder>());

      final other = surface('6');
      expect(other.textStyle?.color, colorScheme.onSurfaceVariant);
      expect(other.shape, isA<CircleBorder>());
    });

    testWidgets('announces pages and the selection', (tester) async {
      final handle = tester.ensureSemantics();
      await pumpBar(tester, pageCount: 10, currentPage: 4);

      expect(
        tester.getSemantics(pageButton('5')),
        isSemantics(label: 'Page 5 of 10', isButton: true, isSelected: true),
      );
      expect(
        tester.getSemantics(pageButton('6')),
        isSemantics(label: 'Page 6 of 10', isButton: true, isSelected: false),
      );
      handle.dispose();
    });

    testWidgets('clamps an out-of-range page without asserting', (
      tester,
    ) async {
      await pumpBar(tester, pageCount: 3, currentPage: 7);

      expect(find.byType(TextButton), findsNWidgets(3));
      expect(
        tester
            .widget<Material>(
              find.descendant(
                of: pageButton('3'),
                matching: find.byType(Material),
              ),
            )
            .color,
        colorScheme.secondaryContainer,
      );
      expect(tester.takeException(), isNull);
    });
  });

  test('does not import SDK Material or Cupertino', () {
    final source = File('lib/util/page_number_bar.dart').readAsStringSync();

    expect(source, isNot(contains('package:flutter/material.dart')));
    expect(source, isNot(contains('package:flutter/cupertino.dart')));
  });
}
