import 'dart:async';
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

typedef PostGetLastPageCallback<PageKeyType, ItemType> =
    bool Function(PagingState<PageKeyType, ItemType>, List<ItemType>);

class GagakuPagingController<PageKeyType, ItemType>
    extends PagingController<PageKeyType, ItemType> {
  GagakuPagingController({
    super.value,
    required super.getNextPageKey,
    required super.fetchPage,
    RefreshCallback? refresh,
    PostGetLastPageCallback<PageKeyType, ItemType>? getIsLastPage,
  }) : _getNextPageKey = getNextPageKey,
       _fetchPage = fetchPage,
       _refresh = refresh,
       _getIsLastPage = getIsLastPage;

  /// The function to get the next page key.
  /// If this function returns `null`, it indicates that there are no more pages to load.
  final NextPageKeyCallback<PageKeyType, ItemType> _getNextPageKey;

  /// The function to fetch a page.
  final FetchPageCallback<PageKeyType, ItemType> _fetchPage;

  final RefreshCallback? _refresh;
  final PostGetLastPageCallback<PageKeyType, ItemType>? _getIsLastPage;

  @override
  void fetchNextPage() async {
    // We are already loading a new page.
    if (this.operation != null) return;

    final operation = this.operation = Object();

    value = value.copyWith(isLoading: true, error: null);

    // we use a local copy of value,
    // so that we only send one notification now and at the end of the method.
    PagingState<PageKeyType, ItemType> state = value;

    try {
      // There are no more pages to load.
      if (!state.hasNextPage) return;

      final nextPageKey = _getNextPageKey(state);

      // We are at the end of the list.
      if (nextPageKey == null) {
        state = state.copyWith(hasNextPage: false);
        return;
      }

      final fetchResult = _fetchPage(nextPageKey);
      List<ItemType> newItems;

      // If the result is synchronous, we can directly assign it in the same tick.
      if (fetchResult is Future) {
        newItems = await fetchResult;
      } else {
        newItems = fetchResult;
      }

      final isLastPage =
          _getIsLastPage != null
              ? _getIsLastPage(state, newItems)
              : newItems.isEmpty;

      // Update our state in case it was modified during the fetch operation.
      // This beaks atomicity, but is necessary to allow users to modify the state during a fetch.
      state = value;

      state = state.copyWith(
        pages: [...?state.pages, newItems],
        keys: [...?state.keys, nextPageKey],
        hasNextPage: !isLastPage,
      );
    } catch (error) {
      state = state.copyWith(error: error);

      if (error is! Exception) {
        // Errors which are not exceptions indicate that something
        // went unexpectedly wrong. These errors are rethrown
        // so they can be logged and investigated.
        rethrow;
      }
    } finally {
      if (operation == this.operation) {
        value = state.copyWith(isLoading: false);
        this.operation = null;
      }
    }
  }

  @override
  Future<void> refresh() async {
    operation = null;

    if (_refresh != null) {
      await _refresh();
    }

    value = value.reset();
  }
}
