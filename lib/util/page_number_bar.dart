import 'dart:math' as math;

import 'package:gagaku/i18n/strings.g.dart';
import 'package:material_ui/material_ui.dart';

/// The number of pages needed to show [itemCount] items, [pageSize] at a time.
///
/// Always at least 1, so callers can clamp a stored page index with
/// `page.clamp(0, pageCount - 1)` even when the list is empty.
int pageCountOf(int itemCount, int pageSize) =>
    math.max((itemCount / pageSize).ceil(), 1);

/// One position in a [PageNumberBar]: either a page button or an elision gap.
sealed class PageNumberSlot {
  const PageNumberSlot();
}

/// A button for the zero-based page [index].
final class PageNumberSlotPage extends PageNumberSlot {
  const PageNumberSlotPage(this.index);

  final int index;

  @override
  bool operator ==(Object other) =>
      other is PageNumberSlotPage && other.index == index;

  @override
  int get hashCode => index.hashCode;

  @override
  String toString() => 'PageNumberSlotPage($index)';
}

/// A gap standing in for two or more skipped pages.
final class PageNumberSlotGap extends PageNumberSlot {
  const PageNumberSlotGap();

  @override
  bool operator ==(Object other) => other is PageNumberSlotGap;

  @override
  int get hashCode => (PageNumberSlotGap).hashCode;

  @override
  String toString() => 'PageNumberSlotGap()';
}

/// Lays out [pageCount] pages into at most [slots] positions around
/// [currentPage].
///
/// Out-of-range inputs are clamped: [pageCount] to at least 1, [slots] to at
/// least 1, and [currentPage] into the valid page range. The result always
/// contains the current page and uses every available slot.
///
/// With five or more slots and more pages than slots, the first and last pages
/// stay visible and the current page is surrounded by a centered window. A gap
/// always hides at least two pages: where it would hide only one, that page is
/// shown instead. With fewer than five slots, a contiguous window around the
/// current page is shown without gaps.
List<PageNumberSlot> pageNumberSlots({
  required int pageCount,
  required int currentPage,
  required int slots,
}) {
  final count = math.max(pageCount, 1);
  final current = currentPage.clamp(0, count - 1);
  final available = math.max(slots, 1);

  List<PageNumberSlot> range(int start, int end) => [
    for (var i = start; i <= end; i++) PageNumberSlotPage(i),
  ];

  if (count <= available) {
    return range(0, count - 1);
  }

  if (available < 5) {
    final start = (current - (available - 1) ~/ 2).clamp(0, count - available);
    return range(start, start + available - 1);
  }

  // First page, gap, window, gap, last page.
  final window = available - 4;
  final start = current - (window - 1) ~/ 2;
  final end = start + window - 1;

  if (start <= 2) {
    return [
      ...range(0, available - 3),
      const PageNumberSlotGap(),
      PageNumberSlotPage(count - 1),
    ];
  }

  if (end >= count - 3) {
    return [
      const PageNumberSlotPage(0),
      const PageNumberSlotGap(),
      ...range(count - (available - 2), count - 1),
    ];
  }

  return [
    const PageNumberSlotPage(0),
    const PageNumberSlotGap(),
    ...range(start, end),
    const PageNumberSlotGap(),
    PageNumberSlotPage(count - 1),
  ];
}

/// A row of page-number buttons for switching between pages of a list.
///
/// The widget is controlled: the caller owns [currentPage] and updates it from
/// [onPageChanged]. [pageCount] values below 1 are treated as 1, and an
/// out-of-range [currentPage] is clamped for display only.
///
/// Material 3 has no pagination component, so the styling follows its
/// selection patterns. Each page is a 40dp button in a 48dp slot (icon-button
/// sizing). The selected page uses `secondaryContainer`/`onSecondaryContainer`
/// (as segmented buttons and navigation indicators do) and, like Material 3
/// Expressive toggle buttons, turns from round to square.
class PageNumberBar extends StatelessWidget {
  const PageNumberBar({
    super.key,
    required this.pageCount,
    required this.currentPage,
    required this.onPageChanged,
  });

  /// The width and height of each slot, matching the minimum touch target.
  static const double slotExtent = 48.0;

  final int pageCount;
  final int currentPage;

  /// Called with the zero-based index of a tapped page. Not called when the
  /// current page is tapped.
  final ValueChanged<int> onPageChanged;

  @override
  Widget build(BuildContext context) {
    final count = math.max(pageCount, 1);
    final current = currentPage.clamp(0, count - 1);

    return SizedBox(
      height: slotExtent,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final slots = constraints.maxWidth.isFinite
              ? (constraints.maxWidth / slotExtent).floor()
              : count;
          final items = pageNumberSlots(
            pageCount: count,
            currentPage: current,
            slots: slots,
          );

          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (final (position, slot) in items.indexed)
                switch (slot) {
                  PageNumberSlotPage(:final index) => _PageNumberButton(
                    key: ValueKey(index),
                    index: index,
                    pageCount: count,
                    selected: index == current,
                    onPageChanged: onPageChanged,
                  ),
                  PageNumberSlotGap() => _PageNumberGap(
                    key: ValueKey(('gap', position)),
                  ),
                },
            ],
          );
        },
      ),
    );
  }
}

class _PageNumberButton extends StatelessWidget {
  const _PageNumberButton({
    super.key,
    required this.index,
    required this.pageCount,
    required this.selected,
    required this.onPageChanged,
  });

  final int index;
  final int pageCount;
  final bool selected;
  final ValueChanged<int> onPageChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return SizedBox.square(
      dimension: PageNumberBar.slotExtent,
      child: Center(
        child: TextButton(
          onPressed: () {
            if (!selected) onPageChanged(index);
          },
          style: TextButton.styleFrom(
            fixedSize: const Size.square(40.0),
            minimumSize: Size.zero,
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            foregroundColor: selected
                ? colors.onSecondaryContainer
                : colors.onSurfaceVariant,
            backgroundColor: selected ? colors.secondaryContainer : null,
            textStyle: theme.textTheme.labelLarge,
            shape: selected
                ? const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  )
                : const CircleBorder(),
          ),
          child: Semantics(
            selected: selected,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                '${index + 1}',
                maxLines: 1,
                semanticsLabel: context.t.ui.pageOfTotal(
                  current: index + 1,
                  total: pageCount,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PageNumberGap extends StatelessWidget {
  const _PageNumberGap({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox.square(
      dimension: PageNumberBar.slotExtent,
      child: Center(
        child: ExcludeSemantics(
          child: Text(
            '…',
            style: theme.textTheme.labelLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }
}
