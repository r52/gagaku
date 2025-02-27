import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gagaku/mangadex/model/model.dart';
import 'package:gagaku/mangadex/model/types.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:gagaku/util/default_scroll_controller.dart';
import 'package:gagaku/util/ui.dart';
import 'package:gagaku/util/util.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'frontpage.g.dart';

@Riverpod(retry: noRetry)
Future<List<Manga>> _popularTitles(Ref ref) async {
  final api = ref.watch(mangadexProvider);

  final format = DateFormat('yyyy-MM-ddT07:00:00');
  final popularTime = DateTime.now().subtract(const Duration(days: 30));

  final extraParams = {
    'hasAvailableChapters': 'true',
    'createdAtSince': format.format(popularTime),
  };

  final manga = await api.fetchManga(
    limit: 15,
    offset: 0,
    order: FilterOrder.followedCount_desc,
    extraParams: extraParams,
  );

  ref.disposeAfter(const Duration(minutes: 60));

  return manga;
}

@Riverpod(retry: noRetry)
Future<List<Manga>> _recentlyAdded(Ref ref) async {
  final manga = await ref.watch(recentlyAddedProvider.future);

  ref.disposeAfter(const Duration(minutes: 10));

  return manga.take(15).toList();
}

@Riverpod(retry: noRetry)
Future<List<Manga>> _latestUpdates(Ref ref) async {
  final api = ref.watch(mangadexProvider);
  final chapters = await ref.watch(latestGlobalFeedProvider.future);

  final mangaIds = chapters.map((e) => e.manga.id).toSet().take(15);
  final mangas = await api.fetchManga(ids: mangaIds, limit: MangaDexEndpoints.breakLimit);

  ref.disposeAfter(const Duration(minutes: 10));

  return mangas;
}

@Riverpod(retry: noRetry)
Future<List<Manga>> _fetchCustomListManga(Ref ref, String listid) async {
  final api = ref.watch(mangadexProvider);

  final list = await ref.watch(listSourceProvider(listid).future);
  if (list == null) {
    return [];
  }

  final mangas = await api.fetchManga(ids: list.set.take(15), limit: MangaDexEndpoints.breakLimit);

  ref.disposeAfter(const Duration(minutes: 60));

  return mangas;
}

@Riverpod(retry: noRetry)
Future<FrontPageData> _fetchFrontPageData(Ref ref) async {
  final api = ref.watch(mangadexProvider);
  final data = await api.fetchFrontPageData();
  ref.disposeAfter(const Duration(minutes: 60));

  return data;
}

class MangaDexFrontPage extends StatelessWidget {
  const MangaDexFrontPage({super.key, this.controller});

  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    return DataProviderWhenWidget(
      provider: _fetchFrontPageDataProvider,
      errorBuilder: (context, child) => Consumer(
        child: child,
        builder: (context, ref, child) => RefreshIndicator(
          onRefresh: () {
            return ref.refresh(_fetchFrontPageDataProvider.future);
          },
          child: child!,
        ),
      ),
      builder: (context, data) => _FrontPageWidget(
        key: ValueKey('_FrontPageWidget'),
        data: data,
        controller: controller,
      ),
    );
  }
}

class _FrontPageWidget extends ConsumerWidget {
  const _FrontPageWidget({super.key, required this.data, this.controller});

  final FrontPageData data;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const style = TextStyle(fontSize: 24);

    final staffPicks = _fetchCustomListMangaProvider(data.staffPicks);
    final seasonal = _fetchCustomListMangaProvider(data.seasonal);

    final scrollController = DefaultScrollController.maybeOf(context) ?? controller;

    final frontPageWidgets = [
      Center(
        child: Text(
          'mangadex.popularNewTitles'.tr(context: context),
          style: style,
        ),
      ),
      const MangaProviderCarousel(provider: _popularTitlesProvider),
      TextButton.icon(
        onPressed: () {
          context.push('/titles/latest');
        },
        label: Text(
          'mangadex.latestUpdates'.tr(context: context),
          style: style,
        ),
        icon: const Icon(Icons.arrow_forward),
        iconAlignment: IconAlignment.end,
      ),
      const MangaProviderCarousel(provider: _latestUpdatesProvider),
      TextButton.icon(
        onPressed: () {
          context.push('/list/${data.staffPicks}');
        },
        label: Text(
          'mangadex.staffPicks'.tr(context: context),
          style: style,
        ),
        icon: const Icon(Icons.arrow_forward),
        iconAlignment: IconAlignment.end,
      ),
      MangaProviderCarousel(provider: staffPicks),
      TextButton.icon(
        onPressed: () {
          context.push('/list/${data.seasonal}');
        },
        label: Text(
          'mangadex.seasonal'.tr(context: context),
          style: style,
        ),
        icon: const Icon(Icons.arrow_forward),
        iconAlignment: IconAlignment.end,
      ),
      MangaProviderCarousel(provider: seasonal),
      TextButton.icon(
        onPressed: () {
          context.push('/titles/recent');
        },
        label: Text(
          'mangadex.recentlyAdded'.tr(context: context),
          style: style,
        ),
        icon: const Icon(Icons.arrow_forward),
        iconAlignment: IconAlignment.end,
      ),
      const MangaProviderCarousel(provider: _recentlyAddedProvider),
    ];

    return RefreshIndicator(
      onRefresh: () {
        ref.invalidate(staffPicks);
        ref.invalidate(seasonal);
        ref.invalidate(_recentlyAddedProvider);
        ref.invalidate(recentlyAddedProvider);
        ref.invalidate(_latestUpdatesProvider);
        ref.read(latestGlobalFeedProvider.notifier).clear();
        return ref.refresh(_popularTitlesProvider.future);
      },
      child: ScrollConfiguration(
        behavior: const MouseTouchScrollBehavior(),
        child: CustomScrollView(
          scrollBehavior: const MouseTouchScrollBehavior(),
          controller: scrollController,
          slivers: [
            MangaDexSliverAppBar(
              controller: scrollController,
            ),
            SliverList.separated(
              itemCount: frontPageWidgets.length,
              itemBuilder: (context, index) {
                return frontPageWidgets.elementAt(index);
              },
              separatorBuilder: (context, index) => const SizedBox(
                height: 10.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MangaProviderCarousel extends StatelessWidget {
  const MangaProviderCarousel({
    super.key,
    required this.provider,
  });

  final Refreshable<AsyncValue<List<Manga>>> provider;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DataProviderWhenWidget(
        provider: provider,
        builder: (context, items) => ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 256),
          child: CarouselView(
            itemExtent: 180,
            shrinkExtent: 180,
            enableSplash: false,
            children: items
                .map(
                  (e) => GridMangaItem(
                    key: ValueKey(e.id),
                    manga: e,
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
