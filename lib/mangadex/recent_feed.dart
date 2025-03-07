import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/mangadex/model/config.dart';
import 'package:gagaku/mangadex/model/model.dart';
import 'package:gagaku/mangadex/model/types.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:gagaku/util/infinite_scroll.dart';
import 'package:gagaku/util/ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class MangaDexRecentFeedPage extends StatefulHookConsumerWidget {
  const MangaDexRecentFeedPage({super.key, this.controller});

  final ScrollController? controller;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MangaDexRecentFeedPageState();
}

class _MangaDexRecentFeedPageState
    extends ConsumerState<MangaDexRecentFeedPage> {
  static const info = MangaDexFeeds.recentlyAdded;

  late final _pagingController = GagakuPagingController<int, Manga>(
    getNextPageKey:
        (state) => state.keys?.last != null ? state.keys!.last + info.limit : 0,
    fetchPage: (pageKey) async {
      final api = ref.watch(mangadexProvider);
      final settings = ref.read(mdConfigProvider);

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

      final list = await api.fetchMangaList(
        limit: info.limit,
        feedKey: info.key,
        offset: pageKey,
        order: FilterOrder.createdAt_desc,
        extraParams: extraParams,
      );

      final newItems = list.data.cast<Manga>();

      await ref.read(statisticsProvider.get)(newItems);

      return PageResultsMetaData(newItems, list.total);
    },
    refresh: () async {
      final api = ref.watch(mangadexProvider);
      await api.invalidateAll(info.key);
    },
  );

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ctrler = widget.controller ?? useScrollController();

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: GestureDetector(
          onTap: () {
            ctrler.animateTo(
              0.0,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
            );
          },
          child: TitleFlexBar(
            title: 'mangadex.recentlyAdded'.tr(context: context),
          ),
        ),
        leading: AutoLeadingButton(),
      ),
      body: Center(
        child: RefreshIndicator(
          onRefresh: () async => _pagingController.refresh(),
          child: MangaListWidget(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: ctrler,
            children: [MangaListViewSliver(controller: _pagingController)],
          ),
        ),
      ),
    );
  }
}
