import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/mangadex/model.dart';
import 'package:gagaku/mangadex/types.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:gagaku/util/ui.dart';
import 'package:gagaku/util/util.dart';
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

@Riverpod(retry: noRetry)
Future<List<Manga>> _fetchMangaFeed(Ref ref) async {
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
        child: RefreshIndicator(
          onRefresh: () async {
            ref.read(recentlyAddedProvider.notifier).clear();
            return ref.refresh(_fetchMangaFeedProvider.future);
          },
          child: switch (feedProvider) {
            AsyncValue(:final error?, :final stackTrace?) => ErrorList(
                error: error,
                stackTrace: stackTrace,
                message: "_fetchMangaFeedProvider failed",
              ),
            AsyncValue(value: final mangas?) => MangaListWidget(
                physics: const AlwaysScrollableScrollPhysics(),
                controller: ctrler,
                onAtEdge: () => ref.read(recentlyAddedProvider.notifier).getMore(),
                isLoading: isLoading,
                children: [
                  if (mangas.isEmpty)
                    const SliverToBoxAdapter(
                      child: Center(
                        child: Text('No results'),
                      ),
                    ),
                  MangaListViewSliver(items: mangas),
                ],
              ),
            _ => const LoadingOverlayStack(),
          },
        ),
      ),
    );
  }
}
