import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:super_sliver_list/super_sliver_list.dart';

/// A [SliverList] with pagination capabilities.
///
/// To include separators, use [PagedSliverList.separated].
///
/// Similar to [PagedListView] but needs to be wrapped by a
/// [CustomScrollView] when added to the screen.
/// Useful for combining multiple scrollable pieces in your UI or if you need
/// to add some widgets preceding or following your paged list.
class PagedSuperSliverList<PageKeyType, ItemType> extends StatelessWidget {
  const PagedSuperSliverList({
    required this.state,
    required this.fetchNextPage,
    required this.builderDelegate,
    this.findChildIndexCallback,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.itemExtent,
    this.prototypeItem,
    this.semanticIndexCallback,
    this.shrinkWrapFirstPageIndicators = false,
    super.key,
  }) : assert(
         itemExtent == null || prototypeItem == null,
         'You can only pass itemExtent or prototypeItem, not both',
       ),
       _separatorBuilder = null;

  const PagedSuperSliverList.separated({
    required this.state,
    required this.fetchNextPage,
    required this.builderDelegate,
    required IndexedWidgetBuilder separatorBuilder,
    this.findChildIndexCallback,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.itemExtent,
    this.semanticIndexCallback,
    this.shrinkWrapFirstPageIndicators = false,
    super.key,
  }) : prototypeItem = null,
       _separatorBuilder = separatorBuilder;

  /// Matches [PagedLayoutBuilder.state].
  final PagingState<PageKeyType, ItemType> state;

  /// Matches [PagedLayoutBuilder.fetchNextPage].
  final NextPageCallback fetchNextPage;

  /// Matches [PagedLayoutBuilder.builderDelegate].
  final PagedChildBuilderDelegate<ItemType> builderDelegate;

  /// The builder for list item separators, just like in [ListView.separated].
  final IndexedWidgetBuilder? _separatorBuilder;

  /// Matches [SliverChildBuilderDelegate.addAutomaticKeepAlives].
  final bool addAutomaticKeepAlives;

  /// Matches [SliverChildBuilderDelegate.addRepaintBoundaries].
  final bool addRepaintBoundaries;

  /// Matches [SliverChildBuilderDelegate.addSemanticIndexes].
  final bool addSemanticIndexes;

  /// Matches [SliverChildBuilderDelegate.semanticIndexCallback].
  final SemanticIndexCallback? semanticIndexCallback;

  /// Matches [SliverChildBuilderDelegate.findChildIndexCallback].
  final ChildIndexGetter? findChildIndexCallback;

  /// Matches [SliverFixedExtentList.itemExtent].
  ///
  /// If this is not null, [prototypeItem] must be null, and vice versa.
  final double? itemExtent;

  /// Matches [SliverPrototypeExtentList.prototypeItem].
  ///
  /// If this is not null, [itemExtent] must be null, and vice versa.
  final Widget? prototypeItem;

  /// Matches [PagedLayoutBuilder.shrinkWrapFirstPageIndicators].
  final bool shrinkWrapFirstPageIndicators;

  @override
  Widget build(BuildContext context) =>
      PagedLayoutBuilder<PageKeyType, ItemType>(
        layoutProtocol: PagedLayoutProtocol.sliver,
        state: state,
        fetchNextPage: fetchNextPage,
        builderDelegate: builderDelegate,
        completedListingBuilder:
            (context, itemBuilder, itemCount, noMoreItemsIndicatorBuilder) =>
                _buildSliverList(
                  itemBuilder,
                  itemCount,
                  noMoreItemsIndicatorBuilder,
                ),
        loadingListingBuilder:
            (context, itemBuilder, itemCount, progressIndicatorBuilder) =>
                _buildSliverList(
                  itemBuilder,
                  itemCount,
                  progressIndicatorBuilder,
                ),
        errorListingBuilder:
            (context, itemBuilder, itemCount, errorIndicatorBuilder) =>
                _buildSliverList(itemBuilder, itemCount, errorIndicatorBuilder),
        shrinkWrapFirstPageIndicators: shrinkWrapFirstPageIndicators,
      );

  SliverMultiBoxAdaptorWidget _buildSliverList(
    IndexedWidgetBuilder itemBuilder,
    int itemCount,
    WidgetBuilder? statusIndicatorBuilder,
  ) {
    final delegate = _buildSliverDelegate(
      itemBuilder,
      itemCount,
      statusIndicatorBuilder: statusIndicatorBuilder,
    );

    final itemExtent = this.itemExtent;

    return ((itemExtent == null && prototypeItem == null) ||
            _separatorBuilder != null)
        ? SuperSliverList(delegate: delegate)
        : (itemExtent != null)
        ? SliverFixedExtentList(delegate: delegate, itemExtent: itemExtent)
        : SliverPrototypeExtentList(
            delegate: delegate,
            prototypeItem: prototypeItem!,
          );
  }

  SliverChildBuilderDelegate _buildSliverDelegate(
    IndexedWidgetBuilder itemBuilder,
    int itemCount, {
    WidgetBuilder? statusIndicatorBuilder,
  }) {
    final separatorBuilder = _separatorBuilder;
    return separatorBuilder == null
        ? AppendedFindingSliverChildBuilderDelegate(
            builder: itemBuilder,
            childCount: itemCount,
            appendixBuilder: statusIndicatorBuilder,
            findChildIndexCallback: findChildIndexCallback,
            addAutomaticKeepAlives: addAutomaticKeepAlives,
            addRepaintBoundaries: addRepaintBoundaries,
            addSemanticIndexes: addSemanticIndexes,
            semanticIndexCallback: semanticIndexCallback,
          )
        : AppendedFindingSliverChildBuilderDelegate.separated(
            builder: itemBuilder,
            childCount: itemCount,
            appendixBuilder: statusIndicatorBuilder,
            separatorBuilder: separatorBuilder,
            findChildIndexCallback: findChildIndexCallback,
            addAutomaticKeepAlives: addAutomaticKeepAlives,
            addRepaintBoundaries: addRepaintBoundaries,
            addSemanticIndexes: addSemanticIndexes,
          );
  }
}

/// A [SliverChildBuilderDelegate] with an extra item (appendixBuilder) added
/// to the end.
///
/// To include list separators, use
/// [AppendedSliverChildBuilderDelegate.separated].
class AppendedFindingSliverChildBuilderDelegate
    extends SliverChildBuilderDelegate {
  AppendedFindingSliverChildBuilderDelegate({
    required IndexedWidgetBuilder builder,
    required int childCount,
    WidgetBuilder? appendixBuilder,
    ChildIndexGetter? findChildIndexCallback,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    SemanticIndexCallback? semanticIndexCallback,
  }) : super(
         appendixBuilder == null
             ? builder
             : (context, index) {
                 if (index == childCount) {
                   return appendixBuilder(context);
                 }
                 return builder(context, index);
               },
         findChildIndexCallback: findChildIndexCallback,
         childCount: appendixBuilder == null ? childCount : childCount + 1,
         addAutomaticKeepAlives: addAutomaticKeepAlives,
         addRepaintBoundaries: addRepaintBoundaries,
         addSemanticIndexes: addSemanticIndexes,
         semanticIndexCallback: semanticIndexCallback ?? (_, index) => index,
       );

  AppendedFindingSliverChildBuilderDelegate.separated({
    required IndexedWidgetBuilder builder,
    required int childCount,
    required IndexedWidgetBuilder separatorBuilder,
    WidgetBuilder? appendixBuilder,
    ChildIndexGetter? findChildIndexCallback,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
  }) : this(
         builder: (context, index) {
           final itemIndex = index ~/ 2;
           if (index.isEven) {
             return builder(context, itemIndex);
           }

           return separatorBuilder(context, itemIndex);
         },
         findChildIndexCallback: findChildIndexCallback,
         childCount: math.max(
           0,
           childCount * 2 - (appendixBuilder != null ? 0 : 1),
         ),
         appendixBuilder: appendixBuilder,
         addAutomaticKeepAlives: addAutomaticKeepAlives,
         addRepaintBoundaries: addRepaintBoundaries,
         addSemanticIndexes: addSemanticIndexes,
         semanticIndexCallback: (_, index) => index.isEven ? index ~/ 2 : null,
       );
}

class OffsetPagingManager<ItemType> {
  final int limit;
  int? totalItems;

  OffsetPagingManager({required this.limit});

  int? getNextPageKey(PagingState<int, ItemType> state) {
    if (state.keys == null || state.keys!.isEmpty) return 0;

    final currentCount = state.items?.length ?? 0;

    if (totalItems != null && currentCount >= totalItems!) {
      return null;
    }

    return state.keys!.last + limit;
  }

  void reset() {
    totalItems = null;
  }
}
