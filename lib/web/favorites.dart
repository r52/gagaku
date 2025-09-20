import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/model/model.dart';
import 'package:gagaku/objectbox.g.dart';
import 'package:gagaku/util/default_scroll_controller.dart';
import 'package:gagaku/util/number_paginator_controller_hook.dart';
import 'package:gagaku/util/ui.dart';
import 'package:gagaku/util/util.dart';
import 'package:gagaku/web/model/model.dart';
import 'package:gagaku/web/model/types.dart';
import 'package:gagaku/web/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:number_paginator/number_paginator.dart';

@RoutePage()
class WebSourceFavoritesPage extends HookConsumerWidget {
  const WebSourceFavoritesPage({super.key, this.controller});

  final ScrollController? controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tr = context.t;
    final scrollController =
        DefaultScrollController.maybeOf(context, 'WebSourceFavoritesPage') ??
        controller ??
        useScrollController();

    final manager = useListenable(WebFavoritesManager());
    final categories = manager.state;

    final tabController = useTabController(
      initialLength: categories.length,
      keys: [categories.length],
    );
    final filterController = useTextEditingController();

    // Pre-initialize sources
    final _ = ref.watch(extensionInfoListProvider);

    return NestedScrollView(
      scrollBehavior: const MouseTouchScrollBehavior(),
      controller: scrollController,
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: SliverAppBar(
              forceElevated: innerBoxIsScrolled,
              automaticallyImplyLeading: false,
              primary: false,
              pinned: false,
              title: TextField(
                controller: filterController,
                onTapOutside: (event) => unfocusSearchBar(),
                decoration: InputDecoration(
                  hintText: tr.ui.filterItems,
                  suffixIcon: IconButton(
                    onPressed: filterController.clear,
                    icon: Icon(Icons.clear),
                  ),
                ),
              ),
              bottom: TabBar(
                tabAlignment: TabAlignment.center,
                isScrollable: true,
                controller: tabController,
                tabs: [for (final cat in categories) Tab(text: cat.name)],
              ),
            ),
          ),
        ];
      },
      body: TabBarView(
        controller: tabController,
        children: [
          for (final cat in categories)
            WebSourceFavoriteTab(
              category: cat,
              filterController: filterController,
              scrollController: scrollController,
            ),
        ],
      ),
    );
  }
}

class WebSourceFavoriteTab extends HookWidget {
  const WebSourceFavoriteTab({
    super.key,
    required this.category,
    required this.filterController,
    this.scrollController,
  });

  final WebFavoritesList category;
  final TextEditingController filterController;
  final ScrollController? scrollController;

  static const _displayLimit = 32;

  @override
  Widget build(BuildContext context) {
    final tr = context.t;
    final pageController = useNumberPaginatorController();
    final currentPage = useValueListenable(pageController);
    final filterText = useValueListenable(filterController);
    final debouncedFilterText = useDebounced(
      filterText.text,
      const Duration(milliseconds: 300),
    );

    final query = useMemoized(() {
      final builder = GagakuData().store.box<HistoryLink>().query(
        debouncedFilterText == null || debouncedFilterText.isEmpty
            ? null
            : HistoryLink_.title.contains(
                debouncedFilterText,
                caseSensitive: false,
              ),
      );
      builder.backlinkMany(
        WebFavoritesList_.list,
        WebFavoritesList_.id.equals(category.id),
      );
      return builder
          .watch(triggerImmediately: true)
          .map((query) => query.find());
    }, [debouncedFilterText, category.id]);
    final stream = useStream(query);
    final items = stream.data ?? [];

    final pagedItems = useMemoized(() {
      int start = pageController.currentPage * _displayLimit;
      if (start > items.length) {
        start = 0;
        pageController.currentPage = 0;
      }

      final end = min(start + _displayLimit, items.length);
      return items.getRange(start, end).toList();
    }, [items, currentPage]);

    return Column(
      children: [
        Expanded(
          child: WebMangaListWidget(
            noController: true,
            physics: const AlwaysScrollableScrollPhysics(),
            scrollBehavior: MouseTouchScrollBehavior().copyWith(
              scrollbars: false,
            ),
            title: Text(
              tr.num_titles(n: items.length),
              style: CommonTextStyles.twentyfour,
            ),
            leading: [
              SliverOverlapInjector(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                  context,
                ),
              ),
            ],
            children: [
              if (stream.hasError)
                SliverFillRemaining(
                  child: ErrorList(
                    error: stream.error!,
                    stackTrace: stream.stackTrace!,
                  ),
                ),
              if (!stream.hasError && items.isEmpty)
                SliverFillRemaining(
                  child: Center(child: Text(tr.errors.noitems)),
                ),
              WebMangaListViewSliver(
                items: pagedItems,
                favoritesKey: category.id,
                showFavoriteButton: true,
                showRemoveButton: false,
                showSearchButton: true,
              ),
            ],
          ),
        ),
        NumberPaginator(
          controller: pageController,
          numberPages: max((items.length / _displayLimit).ceil(), 1),
          onPageChange: (int index) {
            scrollController?.jumpTo(0.0);
          },
        ),
      ],
    );
  }
}
