import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/mangadex/model/config.dart';
import 'package:gagaku/mangadex/model/model.dart';
import 'package:gagaku/mangadex/model/types.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:gagaku/util/default_scroll_controller.dart';
import 'package:gagaku/util/riverpod.dart';
import 'package:gagaku/util/ui.dart';
import 'package:gagaku/util/util.dart';
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

  final info = MangaDexFeeds.popularTitles;

  final manga = await api.fetchMangaList(
    limit: info.limit,
    feedKey: info.key,
    offset: 0,
    order: FilterOrder.followedCount_desc,
    extraParams: extraParams,
  );

  ref.disposeAfter(const Duration(minutes: 60));

  return manga.data.cast<Manga>();
}

@Riverpod(retry: noRetry)
Future<List<Manga>> _recentlyAdded(Ref ref) async {
  final api = ref.watch(mangadexProvider);
  final settings = ref.watch(mdConfigProvider);

  final extraParams = {
    'hasAvailableChapters': 'true',
    'availableTranslatedLanguage[]':
        settings.translatedLanguages
            .map(const LanguageConverter().toJson)
            .toList(),
    'originalLanguage[]':
        settings.originalLanguage
            .map(const LanguageConverter().toJson)
            .toList(),
  };

  final info = MangaDexFeeds.recentlyAdded;

  final list = await api.fetchMangaList(
    limit: info.limit,
    feedKey: info.key,
    offset: 0,
    order: FilterOrder.createdAt_desc,
    extraParams: extraParams,
  );

  final newItems = list.data.cast<Manga>();

  ref.disposeAfter(const Duration(minutes: 10));

  return newItems.take(15).toList();
}

@Riverpod(retry: noRetry)
Future<List<Manga>> _latestUpdates(Ref ref) async {
  const info = MangaDexFeeds.globalFeed;
  final api = ref.watch(mangadexProvider);
  final chapterlist = await api.fetchFeed(
    path: info.path!,
    feedKey: info.key,
    limit: info.limit,
    offset: 0,
  );

  final chapters = chapterlist.data.cast<Chapter>();

  final mangaIds = chapters.map((e) => e.manga.id).toSet().take(15);
  final mangas = await api.fetchMangaById(
    ids: mangaIds,
    limit: MangaDexEndpoints.breakLimit,
  );

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

  final mangas = await api.fetchMangaById(
    ids: list.set.take(15),
    limit: MangaDexEndpoints.breakLimit,
  );

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

@RoutePage()
class MangaDexFrontPage extends StatelessWidget {
  const MangaDexFrontPage({super.key, this.controller});

  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    return DataProviderWhenWidget(
      provider: _fetchFrontPageDataProvider,
      errorBuilder:
          (context, child) => Consumer(
            child: child,
            builder:
                (context, ref, child) => RefreshIndicator(
                  onRefresh: () {
                    return ref.refresh(_fetchFrontPageDataProvider.future);
                  },
                  child: child!,
                ),
          ),
      builder:
          (context, data) => _FrontPageWidget(
            key: ValueKey('_FrontPageWidget'),
            data: data,
            controller: controller,
          ),
    );
  }
}

class _FrontPageWidget extends HookConsumerWidget {
  const _FrontPageWidget({super.key, required this.data, this.controller});

  final FrontPageData data;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final api = ref.watch(mangadexProvider);
    final router = AutoRouter.of(context);
    const style = TextStyle(fontSize: 24);

    final staffPicks = _fetchCustomListMangaProvider(data.staffPicks);
    final seasonal = _fetchCustomListMangaProvider(data.seasonal);

    final scrollController =
        DefaultScrollController.maybeOf(context, 'MangaDexFrontPage') ??
        controller ??
        useScrollController();

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
          router.pushPath('/titles/latest');
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
          router.pushPath('/list/${data.staffPicks}');
        },
        label: Text('mangadex.staffPicks'.tr(context: context), style: style),
        icon: const Icon(Icons.arrow_forward),
        iconAlignment: IconAlignment.end,
      ),
      MangaProviderCarousel(provider: staffPicks),
      TextButton.icon(
        onPressed: () {
          router.pushPath('/list/${data.seasonal}');
        },
        label: Text('mangadex.seasonal'.tr(context: context), style: style),
        icon: const Icon(Icons.arrow_forward),
        iconAlignment: IconAlignment.end,
      ),
      MangaProviderCarousel(provider: seasonal),
      TextButton.icon(
        onPressed: () {
          router.pushPath('/titles/recent');
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
      onRefresh: () async {
        await api.invalidateAll(MangaDexFeeds.popularTitles.key);
        await api.invalidateAll(MangaDexFeeds.recentlyAdded.key);
        await api.invalidateAll(MangaDexFeeds.globalFeed.key);
        ref.invalidate(staffPicks);
        ref.invalidate(seasonal);
        ref.invalidate(_recentlyAddedProvider);

        await (
          ref.refresh(_popularTitlesProvider.future),
          ref.refresh(_latestUpdatesProvider.future),
        ).wait;

        return;
      },
      child: ScrollConfiguration(
        behavior: const MouseTouchScrollBehavior(),
        child: CustomScrollView(
          scrollBehavior: const MouseTouchScrollBehavior(),
          controller: scrollController,
          slivers: [
            MangaDexSliverAppBar(controller: scrollController),
            SliverList.separated(
              itemCount: frontPageWidgets.length,
              itemBuilder: (context, index) {
                return frontPageWidgets.elementAt(index);
              },
              separatorBuilder:
                  (context, index) => const SizedBox(height: 10.0),
            ),
          ],
        ),
      ),
    );
  }
}
