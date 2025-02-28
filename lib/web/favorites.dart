import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/util/default_scroll_controller.dart';
import 'package:gagaku/util/ui.dart';
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
    final scrollController = DefaultScrollController.maybeOf(context) ?? controller ?? useScrollController();
    final categories = ref.watch(webConfigProvider.select((cfg) => cfg.categories));
    final tabController = useTabController(initialLength: categories.length, keys: [categories]);

    // Pre-initialize sources
    final _ = ref.watch(extensionInfoListProvider);

    return Material(
      child: Column(
        children: [
          ScrollConfiguration(
            behavior: const MouseTouchScrollBehavior(),
            child: TabBar(
              tabAlignment: TabAlignment.center,
              isScrollable: true,
              controller: tabController,
              tabs: List<Tab>.generate(categories.length, (int index) => Tab(text: categories.elementAt(index).name)),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                for (final cat in categories)
                  Consumer(
                    builder: (context, ref, child) {
                      final items = ref.watch(
                        webSourceFavoritesProvider.select(
                          (value) => switch (value) {
                            AsyncValue(value: final data?) =>
                              data.containsKey(cat.id) ? data[cat.id]! : <HistoryLink>[],
                            _ => <HistoryLink>[],
                          },
                        ),
                      );

                      if (items.isEmpty) {
                        return Center(child: Text('errors.noitems'.tr(context: context)));
                      }

                      return WebMangaListWidget(
                        physics: const AlwaysScrollableScrollPhysics(),
                        controller: scrollController,
                        children: [
                          WebMangaListViewSliver(
                            items: items,
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
          ),
        ],
      ),
    );
  }
}
