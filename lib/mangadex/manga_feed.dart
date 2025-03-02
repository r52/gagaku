import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gagaku/mangadex/model/model.dart';
import 'package:gagaku/mangadex/model/types.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:gagaku/util/ui.dart';
import 'package:gagaku/util/util.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'manga_feed.g.dart';

@Riverpod(retry: noRetry)
Future<List<Manga>> _fetchMangaFeed(Ref ref) async {
  final me = await ref.watch(loggedUserProvider.future);
  final api = ref.watch(mangadexProvider);
  final chapters = await ref.watch(latestChaptersFeedProvider(me?.id).future);

  final mangaids = chapters.map((e) => e.manga.id).toSet();

  final mangas = await api.fetchManga(
    ids: mangaids,
    limit: MangaDexEndpoints.breakLimit,
  );

  await ref.read(statisticsProvider.get)(mangas);

  ref.disposeAfter(const Duration(minutes: 5));

  return mangas;
}

class MangaDexMangaFeed extends ConsumerWidget {
  const MangaDexMangaFeed({
    super.key,
    this.controller,
    this.leading = const [],
  });

  final ScrollController? controller;
  final List<Widget> leading;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final me = ref.watch(loggedUserProvider).value;
    final feedProvider = ref.watch(_fetchMangaFeedProvider);
    final getNextPage = ref.watch(
      latestChaptersFeedProvider(me?.id).getNextPage,
    );
    final isLoading =
        getNextPage.state is PendingMutationState ||
        (feedProvider.isLoading && !feedProvider.isRefreshing);

    return Center(
      child: RefreshIndicator(
        key: ValueKey('MangaDexMangaFeed_L1(${me?.id})'),
        onRefresh: () async {
          ref.invalidate(latestChaptersFeedProvider(me?.id));
          return ref.refresh(_fetchMangaFeedProvider.future);
        },
        child: DataProviderWhenWidget(
          provider: _fetchMangaFeedProvider,
          initialData: feedProvider,
          builder:
              (context, mangas) => MangaListWidget(
                key: ValueKey('MangaDexMangaFeed_L2(${me?.id})'),
                physics: const AlwaysScrollableScrollPhysics(),
                controller: controller,
                onAtEdge: () {
                  if (getNextPage.state is! PendingMutationState) {
                    getNextPage();
                  }
                },
                leading: leading,
                isLoading: isLoading,
                children: [
                  if (mangas.isEmpty)
                    SliverToBoxAdapter(
                      child: Center(
                        child: Text(
                          'mangadex.noFollowsMsg'.tr(context: context),
                        ),
                      ),
                    ),
                  MangaListViewSliver(items: mangas),
                ],
              ),
          loadingWidget: const LoadingOverlayStack(),
        ),
      ),
    );
  }
}
