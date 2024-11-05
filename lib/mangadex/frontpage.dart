import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gagaku/mangadex/model.dart';
import 'package:gagaku/mangadex/types.dart';
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

class MangaDexFrontPage extends ConsumerWidget {
  const MangaDexFrontPage({super.key, this.controller});

  final ScrollController? controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const style = TextStyle(fontSize: 24);
    const staffPickId = '805ba886-dd99-4aa4-b460-4bd7c7b71352';
    const seasonalId = '54736a5c-eb7f-4844-971b-80ee171cdf29';
    final staffPicks = _fetchCustomListMangaProvider(staffPickId);
    final seasonal = _fetchCustomListMangaProvider(seasonalId);

    final scrollController = DefaultScrollController.maybeOf(context) ?? controller;

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
      child: CustomScrollView(
        scrollBehavior: const MouseTouchScrollBehavior(),
        controller: scrollController,
        slivers: [
          MangaDexSliverAppBar(
            controller: scrollController,
          ),
          SliverList.list(
            children: [
              Center(
                child: Text(
                  'mangadex.popularNewTitles'.tr(context: context),
                  style: style,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const MangaProviderCarousel(provider: _popularTitlesProvider),
              const SizedBox(
                height: 10,
              ),
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
              const SizedBox(
                height: 10,
              ),
              const MangaProviderCarousel(provider: _latestUpdatesProvider),
              const SizedBox(
                height: 10,
              ),
              TextButton.icon(
                onPressed: () {
                  context.push('/list/$staffPickId');
                },
                label: Text(
                  'mangadex.staffPicks'.tr(context: context),
                  style: style,
                ),
                icon: const Icon(Icons.arrow_forward),
                iconAlignment: IconAlignment.end,
              ),
              const SizedBox(
                height: 10,
              ),
              MangaProviderCarousel(provider: staffPicks),
              TextButton.icon(
                onPressed: () {
                  context.push('/list/$seasonalId');
                },
                label: Text(
                  'mangadex.seasonal'.tr(context: context),
                  style: style,
                ),
                icon: const Icon(Icons.arrow_forward),
                iconAlignment: IconAlignment.end,
              ),
              const SizedBox(
                height: 10,
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
              const SizedBox(
                height: 10,
              ),
              const MangaProviderCarousel(provider: _recentlyAddedProvider),
            ],
          )
        ],
      ),
    );
  }
}

class MangaProviderCarousel extends ConsumerWidget {
  const MangaProviderCarousel({
    super.key,
    required this.provider,
  });

  final ProviderBase<AsyncValue<List<Manga>>> provider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final results = ref.watch(provider);

    return Center(
      child: switch (results) {
        AsyncValue(:final error?, :final stackTrace?) => ErrorList(
            error: error,
            stackTrace: stackTrace,
            message: "${provider.toString()} failed",
          ),
        AsyncValue(value: final items?) => CarouselSlider.builder(
            options: CarouselOptions(
              height: 256,
              viewportFraction: 192 / MediaQuery.sizeOf(context).width,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              pageSnapping: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 10),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              enlargeFactor: 0.1,
              scrollDirection: Axis.horizontal,
            ),
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index, int pageViewIndex) {
              final manga = items.elementAt(index);
              return GridMangaItem(
                key: ValueKey(manga.id),
                manga: manga,
              );
            }),
        AsyncValue(:final progress) => ListSpinner(
            progress: progress?.toDouble(),
          ),
      },
    );
  }
}
