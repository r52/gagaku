import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/mangadex/model/config.dart';
import 'package:gagaku/mangadex/model/model.dart';
import 'package:gagaku/mangadex/model/types.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:gagaku/model/common.dart';
import 'package:gagaku/routes.gr.dart';
import 'package:gagaku/util/riverpod.dart';
import 'package:gagaku/util/ui.dart';
import 'package:gagaku/util/util.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:riverpod_annotation/experimental/scope.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tag_view.g.dart';

const _trendingFeedKey = 'TagTrendingThisYear';
const _recentlyAddedFeedKey = 'TagRecentlyAdded';
const _popularFeedKey = 'TagPopular';

@Riverpod(retry: noRetry)
Future<Tag> _fetchTagFromId(Ref ref, String tagId) async {
  final taglist = await ref.watch(tagListProvider.future);
  final tag = taglist.firstWhere((e) => e.id == tagId);
  return tag;
}

@Riverpod(retry: noRetry)
Future<List<Manga>> _trendingThisYear(Ref ref, Tag tag) async {
  final api = ref.watch(mangadexProvider);
  final settings = ref.watch(mdConfigProvider);

  final format = DateFormat('yyyy-MM-ddT07:00:00');
  final popularTime = DateTime.now().subtract(const Duration(days: 365));

  final extraParams = {
    'hasAvailableChapters': 'true',
    'createdAtSince': format.format(popularTime),
    'originalLanguage[]': settings.originalLanguage
        .map(const LanguageConverter().toJson)
        .toList(),
  };

  final manga = await api.fetchMangaList(
    limit: 10,
    feedKey: _trendingFeedKey,
    entity: tag,
    offset: 0,
    order: FilterOrder.followedCount_desc,
    extraParams: extraParams,
  );

  ref.disposeAfter(const Duration(minutes: 60));

  return manga.data.cast<Manga>();
}

@Riverpod(retry: noRetry)
Future<List<Manga>> _recentlyAdded(Ref ref, Tag tag) async {
  final api = ref.watch(mangadexProvider);
  final settings = ref.watch(mdConfigProvider);

  final extraParams = {
    'originalLanguage[]': settings.originalLanguage
        .map(const LanguageConverter().toJson)
        .toList(),
  };

  final manga = await api.fetchMangaList(
    limit: 15,
    feedKey: _recentlyAddedFeedKey,
    entity: tag,
    offset: 0,
    order: FilterOrder.createdAt_desc,
    extraParams: extraParams,
  );

  ref.disposeAfter(const Duration(minutes: 60));

  return manga.data.cast<Manga>();
}

@Dependencies([chipTextStyle])
@RoutePage()
class MangaDexTagViewWithNamePage extends MangaDexTagViewPage {
  const MangaDexTagViewWithNamePage({
    super.key,
    @PathParam() required super.tagId,
    @PathParam() this.name,
  });

  final String? name;
}

@Dependencies([chipTextStyle])
@RoutePage()
class MangaDexTagViewPage extends StatelessWidget {
  const MangaDexTagViewPage({
    super.key,
    @PathParam() required this.tagId,
    this.tag,
  });

  final String tagId;

  final Tag? tag;

  @override
  Widget build(BuildContext context) {
    if (tag != null) {
      return MangaDexTagViewWidget(tag: tag!);
    }

    return DataProviderWhenWidget(
      provider: _fetchTagFromIdProvider(tagId),
      errorBuilder: (context, child, _, _) => Scaffold(body: child),
      builder: (context, data) {
        return MangaDexTagViewWidget(tag: data);
      },
    );
  }
}

@Dependencies([chipTextStyle])
class MangaDexTagViewWidget extends HookConsumerWidget {
  const MangaDexTagViewWidget({super.key, required this.tag});

  final Tag tag;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tr = context.t;
    final api = ref.watch(mangadexProvider);
    const style = CommonTextStyles.twentyfour;

    // popular list
    final popularPage = useState(0);
    final popularList = useMemoized(() async {
      final manga = await api.fetchMangaList(
        limit: 6,
        feedKey: _popularFeedKey,
        entity: tag,
        offset: popularPage.value * 6,
        order: FilterOrder.followedCount_desc,
      );

      return manga;
    }, [tag, popularPage.value]);
    final popularFuture = useFuture(popularList);

    final scrollController = useScrollController();

    final widgets = [
      Center(child: Text(tr.mangadex.trendingThisYear, style: style)),
      MangaProviderCarousel(provider: _trendingThisYearProvider(tag)),
      TextButton.icon(
        onPressed: () {
          context.router.push(
            MangaDexSearchRoute(
              parameters: MangaSearchParameters(
                query: '',
                filter: MangaFilters(includedTags: {tag}),
              ),
            ),
          );
        },
        label: Text(
          tr.mangadex.tagTitles(
            tag: tag.attributes.name.get(tr.$meta.locale.languageCode),
          ),
          style: style,
        ),
        icon: const Icon(Icons.arrow_forward),
        iconAlignment: IconAlignment.end,
      ),
      Center(child: Text(tr.mangadex.recentlyAdded, style: style)),
      MangaProviderCarousel(provider: _recentlyAddedProvider(tag)),
    ];

    return Scaffold(
      appBar: AppBar(
        leading: AutoLeadingButton(),
        flexibleSpace: GestureDetector(
          onTap: () {
            scrollController.animateTo(
              0.0,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
            );
          },
          child: TitleFlexBar(
            title: tag.attributes.name.get(tr.$meta.locale.languageCode),
          ),
        ),
      ),
      body: Center(
        child: RefreshIndicator(
          onRefresh: () async {
            await api.invalidateAll(_trendingFeedKey);
            await api.invalidateAll(_recentlyAddedFeedKey);
            await api.invalidateAll(_popularFeedKey);

            await (
              ref.refresh(_trendingThisYearProvider(tag).future),
              ref.refresh(_recentlyAddedProvider(tag).future),
            ).wait;

            return;
          },
          child: ScrollConfiguration(
            behavior: const MouseTouchScrollBehavior(),
            child: MangaListWidget(
              controller: scrollController,
              future: popularFuture,
              title: Text(tr.mangadex.byPopularity, style: style),
              leading: [
                SliverList.separated(
                  itemCount: widgets.length,
                  itemBuilder: (context, index) {
                    return widgets[index];
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10.0),
                ),
              ],
              children: [
                if (popularFuture.hasData && popularFuture.data != null)
                  MangaListViewSliver(
                    items: popularFuture.data?.data.cast<Manga>(),
                  ),
                if (popularFuture.hasData && popularFuture.data != null)
                  SliverToBoxAdapter(
                    child: NumberPaginator(
                      numberPages: max(
                        (popularFuture.data!.total / 6).ceil(),
                        1,
                      ),
                      onPageChange: (int index) {
                        popularPage.value = index;
                      },
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
