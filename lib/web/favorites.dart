import 'package:flutter/material.dart';
import 'package:gagaku/ui.dart';
import 'package:gagaku/web/model.dart';
import 'package:gagaku/web/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WebSourceFavorites extends HookConsumerWidget {
  const WebSourceFavorites({
    super.key,
    this.controller,
  });

  final ScrollController? controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favProvider = ref.watch(webSourceFavoritesProvider);

    return Material(
      child: switch (favProvider) {
        AsyncValue(value: final list?) when list.isEmpty => const Center(
            child: Text('Add some favorites!'),
          ),
        AsyncValue(value: final list?) => Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Favorites',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
              Expanded(
                child: WebMangaListWidget(
                  physics: const AlwaysScrollableScrollPhysics(),
                  controller: controller,
                  children: [
                    WebMangaListViewSliver(
                      items: list,
                      reorderable: true,
                      showRemoveButton: false,
                    ),
                  ],
                ),
              ),
            ],
          ),
        AsyncValue(:final error?, :final stackTrace?) => ErrorColumn(error: error, stackTrace: stackTrace),
        _ => const Center(
            child: CircularProgressIndicator(),
          ),
      },
    );
  }
}
