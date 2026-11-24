import 'dart:math' as math;

import 'package:animations/animations.dart';
import 'package:flutter/widgets.dart';

import 'paged_state.dart';
import 'paged_view.dart';
import 'status_builders.dart';

/// Builds the widget for [item] at [index].
typedef PagedItemWidgetBuilder<V> = Widget Function(
  BuildContext context,
  V item,
  int index,
);

/// Builds the sliver that shows [itemCount] items followed by an optional
/// [footer] (next-page progress, next-page error, or end indicator).
typedef PagedListingBuilder = Widget Function(
  BuildContext context,
  int itemCount,
  IndexedWidgetBuilder itemBuilder,
  Widget? footer,
);

/// Key of the appended footer, so it keeps its element (and its running
/// transition) when the item count changes.
const Key pagedFooterKey = _PagedFooterKey();

final class _PagedFooterKey extends LocalKey {
  const _PagedFooterKey();

  @override
  String toString() => '[paged_slivers footer]';
}

/// Status slivers, the fetch trigger, and transitions shared by the layouts.
class PagedSliverScaffold<V> extends StatefulWidget {
  const PagedSliverScaffold({
    super.key,
    required this.view,
    required this.itemBuilder,
    required this.statusBuilders,
    required this.listingBuilder,
    required this.invisibleItemsThreshold,
    required this.shrinkWrapFirstPageIndicators,
    required this.animateTransitions,
  });

  final PagedView<V> view;
  final PagedItemWidgetBuilder<V> itemBuilder;
  final PagedStatusBuilders statusBuilders;
  final PagedListingBuilder listingBuilder;
  final int invisibleItemsThreshold;
  final bool shrinkWrapFirstPageIndicators;
  final bool animateTransitions;

  @override
  State<PagedSliverScaffold<V>> createState() => _PagedSliverScaffoldState<V>();
}

class _PagedSliverScaffoldState<V> extends State<PagedSliverScaffold<V>>
    with SingleTickerProviderStateMixin {
  late final AnimationController _entry = AnimationController(
    vsync: this,
    duration: widget.statusBuilders.transitionDuration,
    value: 1,
  );

  late bool _showsItems;

  @override
  void initState() {
    super.initState();
    widget.view.addListener(_onViewChanged);
    _showsItems = widget.view.snapshot.status.showsItems;
  }

  @override
  void didUpdateWidget(PagedSliverScaffold<V> oldWidget) {
    super.didUpdateWidget(oldWidget);
    _entry.duration = widget.statusBuilders.transitionDuration;
    if (!identical(oldWidget.view, widget.view)) {
      oldWidget.view.removeListener(_onViewChanged);
      widget.view.addListener(_onViewChanged);
      _showsItems = widget.view.snapshot.status.showsItems;
      _entry.value = 1;
    }
    if (!widget.animateTransitions) _entry.value = 1;
  }

  @override
  void dispose() {
    widget.view.removeListener(_onViewChanged);
    _entry.dispose();
    super.dispose();
  }

  void _onViewChanged() {
    if (!mounted) return;
    final showsItems = widget.view.snapshot.status.showsItems;
    if (showsItems != _showsItems) {
      _showsItems = showsItems;
      if (widget.animateTransitions) _entry.forward(from: 0);
    }
    setState(() {});
  }

  Widget _switcher(Widget child) {
    if (!widget.animateTransitions) return child;
    final builders = widget.statusBuilders;
    return PageTransitionSwitcher(
      duration: builders.transitionDuration,
      transitionBuilder: builders.transitionBuilder,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final view = widget.view;
    final builders = widget.statusBuilders;
    final snapshot = view.snapshot;
    final status = snapshot.status;

    final Widget sliver;
    if (!status.showsItems) {
      if (status == PagedStatus.loadingFirst) view.fetchNext();
      final indicator = KeyedSubtree(
        key: ValueKey(status),
        child: switch (status) {
          PagedStatus.firstError => builders.buildFirstError(
            context,
            snapshot.error!,
            view.retry,
          ),
          PagedStatus.empty => builders.buildEmpty(context),
          _ => builders.buildFirstProgress(context),
        },
      );
      sliver = widget.shrinkWrapFirstPageIndicators
          ? SliverToBoxAdapter(child: _switcher(indicator))
          : SliverFillRemaining(
              hasScrollBody: false,
              child: _switcher(indicator),
            );
    } else {
      final items = snapshot.items;
      final hasMore = snapshot.hasMore;
      final triggerIndex = math.max(
        0,
        items.length - 1 - widget.invisibleItemsThreshold,
      );

      Widget buildItem(BuildContext context, int index) {
        if (hasMore && index >= triggerIndex) view.fetchNext();
        return widget.itemBuilder(context, items[index], index);
      }

      final Widget? footerChild = switch (status) {
        PagedStatus.nextError => builders.buildNextError(
          context,
          snapshot.error!,
          view.retry,
        ),
        PagedStatus.complete => builders.endBuilder?.call(context),
        _ => builders.buildNextProgress(context),
      };

      final footer = footerChild == null
          ? null
          : KeyedSubtree(
              key: pagedFooterKey,
              child: _switcher(
                KeyedSubtree(
                  key: ValueKey(
                    status == PagedStatus.loadingMore
                        ? PagedStatus.idle
                        : status,
                  ),
                  child: footerChild,
                ),
              ),
            );

      sliver = widget.listingBuilder(context, items.length, buildItem, footer);
    }

    if (!widget.animateTransitions) return sliver;
    return SliverFadeTransition(opacity: _entry, sliver: sliver);
  }
}

/// A [SliverChildBuilderDelegate] for [itemCount] items, optional separators,
/// and an optional trailing [footer].
///
/// [findChildIndexCallback] receives item keys and returns item indexes; the
/// delegate maps them to child indexes and resolves the footer's key itself.
SliverChildBuilderDelegate pagedChildDelegate({
  required int itemCount,
  required IndexedWidgetBuilder itemBuilder,
  IndexedWidgetBuilder? separatorBuilder,
  Widget? footer,
  ChildIndexGetter? findChildIndexCallback,
  bool addAutomaticKeepAlives = true,
  bool addRepaintBoundaries = true,
  bool addSemanticIndexes = true,
}) {
  final separated = separatorBuilder != null;
  // Separated lists keep a separator between the last item and the footer.
  final bodyCount = !separated
      ? itemCount
      : footer != null
      ? itemCount * 2
      : math.max(0, itemCount * 2 - 1);
  final childCount = bodyCount + (footer != null ? 1 : 0);

  return SliverChildBuilderDelegate(
    (context, index) {
      if (index == bodyCount) return footer;
      if (!separated) return itemBuilder(context, index);
      final itemIndex = index ~/ 2;
      return index.isEven
          ? itemBuilder(context, itemIndex)
          : separatorBuilder(context, itemIndex);
    },
    childCount: childCount,
    findChildIndexCallback: (key) {
      if (key == pagedFooterKey) return footer != null ? bodyCount : null;
      final itemIndex = findChildIndexCallback?.call(key);
      if (itemIndex == null || itemIndex < 0 || itemIndex >= itemCount) {
        return null;
      }
      return separated ? itemIndex * 2 : itemIndex;
    },
    addAutomaticKeepAlives: addAutomaticKeepAlives,
    addRepaintBoundaries: addRepaintBoundaries,
    addSemanticIndexes: addSemanticIndexes,
    semanticIndexCallback: (_, index) {
      if (index >= bodyCount) return null;
      if (!separated) return index;
      return index.isEven ? index ~/ 2 : null;
    },
  );
}
