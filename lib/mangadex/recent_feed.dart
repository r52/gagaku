import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/mangadex/model.dart';
import 'package:gagaku/mangadex/types.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:gagaku/ui.dart';
import 'package:gagaku/util.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'recent_feed.g.dart';

Page<dynamic> buildRecentFeedPage(BuildContext context, GoRouterState state) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: const MangaDexRecentFeed(),
    transitionsBuilder: Styles.scaledSharedAxisTransitionBuilder,
  );
}

@riverpod
Future<List<Manga>> _fetchMangaFeed(_FetchMangaFeedRef ref) async {
  final mangas = await ref.watch(recentlyAddedProvider.future);

  await ref.read(statisticsProvider.notifier).get(mangas);

  ref.disposeAfter(const Duration(minutes: 10));

  return mangas;
}

class MangaDexRecentFeed extends HookConsumerWidget {
  const MangaDexRecentFeed({
    super.key,
    this.controller,
  });

  final ScrollController? controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ctrler = controller ?? useScrollController();
    final feedProvider = ref.watch(_fetchMangaFeedProvider);
    final isLoading = feedProvider.isLoading && !feedProvider.isRefreshing;

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: GestureDetector(
          onTap: () {
            ctrler.animateTo(0.0, duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
          },
          child: const TitleFlexBar(title: 'Recently Added'),
        ),
        leading: BackButton(
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/');
            }
          },
        ),
      ),
      body: Center(
        child: Stack(
          children: [
            switch (feedProvider) {
              AsyncValue(:final error?, :final stackTrace?) => RefreshIndicator(
                  onRefresh: () async {
                    ref.read(recentlyAddedProvider.notifier).clear();
                    return ref.refresh(_fetchMangaFeedProvider.future);
                  },
                  child: ErrorList(
                    error: error,
                    stackTrace: stackTrace,
                    message: "_fetchMangaFeedProvider failed",
                  ),
                ),
              AsyncValue(value: final mangas?) => RefreshIndicator(
                  onRefresh: () async {
                    ref.read(recentlyAddedProvider.notifier).clear();
                    return ref.refresh(_fetchMangaFeedProvider.future);
                  },
                  child: mangas.isEmpty
                      ? const Text('No results')
                      : MangaListWidget(
                          physics: const AlwaysScrollableScrollPhysics(),
                          controller: ctrler,
                          onAtEdge: () => ref.read(recentlyAddedProvider.notifier).getMore(),
                          children: [
                            MangaListViewSliver(items: mangas),
                          ],
                        ),
                ),
              _ => const SizedBox.shrink(),
            },
            if (isLoading) ...Styles.loadingOverlay,
          ],
        ),
      ),
    );
  }
}
