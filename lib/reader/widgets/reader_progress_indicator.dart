import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/i18n/strings.g.dart';

class ReaderProgressIndicator extends HookWidget {
  const ReaderProgressIndicator({
    super.key,
    required this.currentPage,
    required this.itemCount,
    required this.onPageSelected,
    this.reverse = false,
    this.color,
  });

  final ValueNotifier<int> currentPage;
  final int itemCount;
  final ValueChanged<int> onPageSelected;
  final Color? color;
  final bool reverse;

  static const double _barHeight = 8.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tr = context.t;
    final progressColor = color ?? theme.colorScheme.primary;

    final sections = useMemoized(
      () => List<Widget>.generate(
        itemCount,
        (index) => _ProgressBarSection(
          key: ValueKey('progress_bar_section_$index'),
          index: index,
          currentPage: currentPage,
          color: progressColor,
          height: _barHeight,
        ),
      ),
      [itemCount, progressColor],
    );

    final children = useMemoized(
      () => reverse ? sections.reversed.toList() : sections,
      [sections, reverse],
    );

    void handleTapOrDrag(Offset localPosition, double totalWidth) {
      if (totalWidth <= 0) return;
      double dx = localPosition.dx;
      if (reverse) dx = totalWidth - dx;
      final index = ((dx / totalWidth) * itemCount)
          .clamp(0, itemCount - 1)
          .floor();
      onPageSelected(index);
    }

    final page = useValueListenable(currentPage);

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          stops: [0.0, 1.0],
          colors: [Color.fromARGB(200, 0, 0, 0), Colors.transparent],
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface.withAlpha(217),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      enableDrag: false,
                      backgroundColor: theme.colorScheme.surface,
                      builder: (context) {
                        return SizedBox(
                          height: 250,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  tr.reader.gotoPage,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ScrollConfiguration(
                                  behavior: ScrollConfiguration.of(context)
                                      .copyWith(
                                        dragDevices: {
                                          PointerDeviceKind.mouse,
                                          PointerDeviceKind.touch,
                                          PointerDeviceKind.trackpad,
                                        },
                                      ),
                                  child: CupertinoPicker(
                                    scrollController:
                                        FixedExtentScrollController(
                                          initialItem: page,
                                        ),
                                    itemExtent: 40,
                                    changeReportingBehavior:
                                        ChangeReportingBehavior.onScrollEnd,
                                    onSelectedItemChanged: onPageSelected,
                                    children: List.generate(itemCount, (index) {
                                      return Center(
                                        child: Text('${index + 1}'),
                                      );
                                    }),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Text(
                    tr.reader.pageCount(current: page + 1, total: itemCount),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LayoutBuilder(
            builder: (context, constraints) {
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTapDown: (details) => handleTapOrDrag(
                  details.localPosition,
                  constraints.maxWidth,
                ),
                onHorizontalDragUpdate: (details) => handleTapOrDrag(
                  details.localPosition,
                  constraints.maxWidth,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints.loose(const Size.fromHeight(30)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: children,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ProgressBarSection extends HookWidget {
  const _ProgressBarSection({
    super.key,
    required this.index,
    required this.currentPage,
    required this.color,
    required this.height,
  });

  final int index;
  final ValueNotifier<int> currentPage;
  final Color color;
  final double height;

  @override
  Widget build(BuildContext context) {
    final isFilled =
        index == 0 ||
        useListenableSelector(currentPage, () => currentPage.value >= index);

    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          height: height,
          width: double.infinity,
          child: ColoredBox(color: isFilled ? color : Colors.transparent),
        ),
      ),
    );
  }
}
