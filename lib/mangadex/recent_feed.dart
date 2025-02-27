import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/mangadex/model/model.dart';
import 'package:gagaku/mangadex/model/types.dart';
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

  await ref.read(statisticsProvider.get)(mangas);

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
          child: TitleFlexBar(title: 'mangadex.recentlyAdded'.tr(context: context)),
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
          child: DataProviderWhenWidget(
            provider: _fetchMangaFeedProvider,
            data: feedProvider,
            builder: (context, mangas) => MangaListWidget(
              physics: const AlwaysScrollableScrollPhysics(),
              controller: ctrler,
              onAtEdge: () => ref.read(recentlyAddedProvider.notifier).getMore(),
              isLoading: isLoading,
              children: [
                if (mangas.isEmpty)
                  SliverToBoxAdapter(
                    child: Center(
                      child: Text('errors.noresults'.tr(context: context)),
                    ),
                  ),
                MangaListViewSliver(items: mangas),
              ],
            ),
            loadingWidget: const LoadingOverlayStack(),
          ),
        ),
      ),
    );
  }
}
