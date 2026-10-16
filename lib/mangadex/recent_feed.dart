import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:material_ui/material_ui.dart';
import 'package:gagaku/util/riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/mangadex/model/config.dart';
import 'package:gagaku/mangadex/model/model.dart';
import 'package:gagaku/mangadex/model/types.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:gagaku/util/ui.dart';
import 'package:gagaku/util/infinite_scroll.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
      final api = ref.read(mangadexProvider);
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
        order: MangaFilterOrder.createdAt_desc,
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
      body: Center(
        child: RefreshIndicator(
          onRefresh: () async {
            _pagingManager.reset();
            final api = ref.read(mangadexProvider);
            await api.invalidateAll(info.key);
            return _pagingController.refresh();
          },
          child: MangaListWidget(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: ctrler,
            leading: [
              PageSliverAppBar(
                title: tr.mangadex.recentlyAdded,
                controller: ctrler,
              ),
            ],
            children: [MangaListViewSliver(controller: _pagingController)],
          ),
        ),
      ),
    );
  }
}
