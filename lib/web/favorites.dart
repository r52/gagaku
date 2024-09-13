import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/ui.dart';
import 'package:gagaku/web/model/config.dart';
import 'package:gagaku/web/model/model.dart';
import 'package:gagaku/web/model/types.dart';
import 'package:gagaku/web/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WebSourceFavoritesWidget extends HookConsumerWidget {
  const WebSourceFavoritesWidget({
    super.key,
    this.controller,
  });

  final ScrollController? controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cfg = ref.watch(webConfigProvider);
    final tabController = useTabController(initialLength: cfg.categories.length, keys: [cfg]);

    return Material(
      child: Column(
        children: [
          ScrollConfiguration(
            behavior: const MouseTouchScrollBehavior(),
            child: TabBar(
              tabAlignment: TabAlignment.center,
              isScrollable: true,
              controller: tabController,
              tabs: List<Tab>.generate(
                cfg.categories.length,
                (int index) => Tab(
                  text: cfg.categories.elementAt(index).name,
                ),
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                for (final cat in cfg.categories)
                  Consumer(
                    builder: (context, ref, child) {
                      final items = ref.watch(webSourceFavoritesProvider.select(
                        (value) => switch (value) {
                          AsyncValue(value: final data?) => data.containsKey(cat.id) ? data[cat.id]! : <HistoryLink>[],
                          _ => <HistoryLink>[],
                        },
                      ));

                      if (items.isEmpty) {
                        return const Center(
                          child: Text('No items'),
                        );
                      }

                      return WebMangaListWidget(
                        physics: const AlwaysScrollableScrollPhysics(),
                        controller: controller,
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
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
