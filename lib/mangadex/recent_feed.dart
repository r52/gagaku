import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:flutter/material.dart';
import 'package:gagaku/util/riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/mangadex/model/config.dart';
import 'package:gagaku/mangadex/model/model.dart';
import 'package:gagaku/mangadex/model/types.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:gagaku/model/common.dart';
import 'package:gagaku/util/infinite_scroll.dart';
import 'package:gagaku/util/ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/experimental/scope.dart';

@Dependencies([chipTextStyle])
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

  late final _pagingManager = OffsetPagingManager<Manga>(limit: info.limit);

  late final _pagingController = PagingController<int, Manga>(
    getNextPageKey: _pagingManager.getNextPageKey,
    fetchPage: (pageKey) async {
      final api = ref.watch(mangadexProvider);
      final settings = ref.read(mdConfigProvider);

      final extraParams = {
        'hasAvailableChapters': 'true',
        'availableTranslatedLanguage[]': settings.translatedLanguages
            .map(const LanguageConverter().toJson)
            .toList(),
        'originalLanguage[]': settings.originalLanguage
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

      _pagingManager.totalItems = list.total;

      final newItems = list.data.cast<Manga>();

      try {
        ref.run((tsx) async {
          return await tsx.get(statisticsProvider.notifier).get(newItems);
        });
      } catch (e) {
        logger.e(e, error: e);
      }

      return newItems;
    },
  );

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tr = context.t;
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
          child: TitleFlexBar(title: tr.mangadex.recentlyAdded),
        ),
        leading: const BackButton(),
      ),
      body: Center(
        child: RefreshIndicator(
          onRefresh: () async {
            _pagingManager.reset();
            final api = ref.watch(mangadexProvider);
            await api.invalidateAll(info.key);
            return _pagingController.refresh();
          },
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
