import 'package:flutter/widgets.dart';

import 'paged_sliver_core.dart';
import 'paged_view.dart';
import 'status_builders.dart';

/// A paged sliver grid whose footer (next-page progress, next-page error, or
/// end indicator) spans the full cross axis below the grid.
class PagedSliverGrid<V> extends StatelessWidget {
  const PagedSliverGrid({
    super.key,
    required this.view,
    required this.itemBuilder,
    required this.gridDelegate,
    required this.statusBuilders,
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

  /// Lays out the grid tiles.
  final SliverGridDelegate gridDelegate;

  /// Status indicators.
  final PagedStatusBuilders statusBuilders;

  /// Maps an item key to its item index.
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
      listingBuilder: (context, itemCount, itemBuilder, footer) =>
          SliverMainAxisGroup(
            slivers: [
              SliverGrid(
                gridDelegate: gridDelegate,
                delegate: pagedChildDelegate(
                  itemCount: itemCount,
                  itemBuilder: itemBuilder,
                  findChildIndexCallback: findChildIndexCallback,
                  addAutomaticKeepAlives: addAutomaticKeepAlives,
                  addRepaintBoundaries: addRepaintBoundaries,
                  addSemanticIndexes: addSemanticIndexes,
                ),
              ),
              if (footer != null) SliverToBoxAdapter(child: footer),
            ],
          ),
    );
  }
}
