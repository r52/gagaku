import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/model/model.dart';
import 'package:gagaku/objectbox.g.dart';
import 'package:gagaku/util/default_scroll_controller.dart';
import 'package:gagaku/util/ui.dart';
import 'package:gagaku/util/util.dart';
import 'package:gagaku/web/model/model.dart';
import 'package:gagaku/web/model/types.dart';
import 'package:gagaku/web/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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

    final categories = ref.watch(
      webSourceFavoritesProvider.select(
        (value) => switch (value) {
          AsyncValue(value: final data?) => data,
          _ => <WebFavoritesList>[],
        },
      ),
    );
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
                tabs: List<Tab>.generate(
                  categories.length,
                  (int index) => Tab(text: categories.elementAt(index).name),
                ),
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
  });

  final WebFavoritesList category;
  final TextEditingController filterController;

  @override
  Widget build(BuildContext context) {
    final tr = context.t;

    final query = useMemoized(() {
      final builder = GagakuData().store.box<HistoryLink>().query();
      builder.backlinkMany(
        WebFavoritesList_.list,
        WebFavoritesList_.id.equals(category.id),
      );
      return builder
          .watch(triggerImmediately: true)
          .map((query) => query.find());
    }, []);
    final stream = useStream(query);
    final items = stream.data ?? [];
    final filterText = useValueListenable(filterController);
    final fileredItems = useMemoized(
      () => items
          .where((i) => i.title.toLowerCase().contains(filterText.text))
          .toList(),
      [filterText.text, items, stream.data],
    );

    return WebMangaListWidget(
      noController: true,
      physics: const AlwaysScrollableScrollPhysics(),
      scrollBehavior: MouseTouchScrollBehavior().copyWith(scrollbars: false),
      title: Text(
        tr.num_titles(n: fileredItems.length),
        style: const TextStyle(fontSize: 24),
      ),
      leading: [
        SliverOverlapInjector(
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
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
        if (!stream.hasError && fileredItems.isEmpty)
          SliverFillRemaining(child: Center(child: Text(tr.errors.noitems))),
        WebMangaListViewSliver(
          items: fileredItems,
          favoritesKey: category.id,
          showRemoveButton: false,
        ),
      ],
    );
  }
}
