import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/util/default_scroll_controller.dart';
import 'package:gagaku/util/ui.dart';
import 'package:gagaku/util/util.dart';
import 'package:gagaku/web/model/config.dart';
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
      webConfigProvider.select((cfg) => cfg.categories),
    );
    final tabController = useTabController(
      initialLength: categories.length,
      keys: [categories],
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
            HookConsumer(
              builder: (context, ref, child) {
                final filterText = useValueListenable(filterController);
                final items = ref.watch(
                  webSourceFavoritesProvider.select(
                    (value) => switch (value) {
                      AsyncValue(value: final data?) =>
                        data.containsKey(cat.id)
                            ? data[cat.id]!
                            : <HistoryLink>[],
                      _ => <HistoryLink>[],
                    },
                  ),
                );
                final fileredItems = useMemoized(
                  () => items.where(
                    (i) => i.title.toLowerCase().contains(filterText.text),
                  ),
                  [filterText, items],
                );

                return WebMangaListWidget(
                  noController: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  title: Text(
                    tr.num_titles(n: fileredItems.length),
                    style: const TextStyle(fontSize: 24),
                  ),
                  leading: [
                    SliverOverlapInjector(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context,
                      ),
                    ),
                  ],
                  children: [
                    if (fileredItems.isEmpty)
                      SliverFillRemaining(
                        child: Center(child: Text(tr.errors.noitems)),
                      ),
                    WebMangaListViewSliver(
                      items: fileredItems.toList(),
                      favoritesKey: cat.id,
                      reorderable: true,
                      showRemoveButton: false,
                    ),
                  ],
                );
              },
            ),
        ],
      ),
    );
  }
}
