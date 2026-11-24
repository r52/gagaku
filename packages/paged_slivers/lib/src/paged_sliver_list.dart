import 'package:flutter/widgets.dart';
import 'package:super_sliver_list/super_sliver_list.dart';

import 'paged_sliver_core.dart';
import 'paged_view.dart';
import 'status_builders.dart';

export 'paged_sliver_core.dart' show PagedItemWidgetBuilder;

/// A paged sliver list backed by [SliverList] or [SuperSliverList].
///
/// The footer (next-page progress, next-page error, or end indicator) is the
/// list's last child.
class PagedSliverList<V> extends StatelessWidget {
  const PagedSliverList({
    super.key,
    required this.view,
    required this.itemBuilder,
    required this.statusBuilders,
    this.useSuperSliverList = false,
    this.findChildIndexCallback,
    this.invisibleItemsThreshold = 3,
    this.shrinkWrapFirstPageIndicators = false,
    this.animateTransitions = true,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
  }) : separatorBuilder = null;

  /// A list with [separatorBuilder] between items, like `ListView.separated`.
  const PagedSliverList.separated({
    super.key,
    required this.view,
    required this.itemBuilder,
    required this.statusBuilders,
    required IndexedWidgetBuilder this.separatorBuilder,
    this.useSuperSliverList = false,
    this.findChildIndexCallback,
    this.invisibleItemsThreshold = 3,
    this.shrinkWrapFirstPageIndicators = false,
    this.animateTransitions = true,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
  });

  /// The items to show.
  final PagedView<V> view;

  /// Builds each item.
  final PagedItemWidgetBuilder<V> itemBuilder;

  /// Status indicators.
  final PagedStatusBuilders statusBuilders;

  /// Builds the separator after the item at the given index.
  final IndexedWidgetBuilder? separatorBuilder;

  /// Whether to use [SuperSliverList] instead of [SliverList].
  final bool useSuperSliverList;

  /// Maps an item key to its item index (not child index).
  final ChildIndexGetter? findChildIndexCallback;

  /// How many items before the last one building an item requests the next
  /// page.
  final int invisibleItemsThreshold;

  /// Whether first-page indicators size to their content rather than filling
  /// the remaining viewport.
  final bool shrinkWrapFirstPageIndicators;

  /// Whether status changes animate.
  final bool animateTransitions;

  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;

  @override
  Widget build(BuildContext context) {
    return PagedSliverScaffold<V>(
      view: view,
      itemBuilder: itemBuilder,
      statusBuilders: statusBuilders,
      invisibleItemsThreshold: invisibleItemsThreshold,
      shrinkWrapFirstPageIndicators: shrinkWrapFirstPageIndicators,
      animateTransitions: animateTransitions,
      listingBuilder: (context, itemCount, itemBuilder, footer) {
        final delegate = pagedChildDelegate(
          itemCount: itemCount,
          itemBuilder: itemBuilder,
          separatorBuilder: separatorBuilder,
          footer: footer,
          findChildIndexCallback: findChildIndexCallback,
          addAutomaticKeepAlives: addAutomaticKeepAlives,
          addRepaintBoundaries: addRepaintBoundaries,
          addSemanticIndexes: addSemanticIndexes,
        );
        return useSuperSliverList
            ? SuperSliverList(delegate: delegate)
            : SliverList(delegate: delegate);
      },
    );
  }
}
