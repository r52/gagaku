import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/mangadex/model/model.dart';
import 'package:gagaku/mangadex/model/types.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:gagaku/util/default_scroll_controller.dart';
import 'package:gagaku/util/infinite_scroll.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class MangaDexHistoryFeedPage extends StatefulHookConsumerWidget {
  const MangaDexHistoryFeedPage({super.key, this.controller});

  final ScrollController? controller;

  @override
  ConsumerState<MangaDexHistoryFeedPage> createState() =>
      _MangaDexHistoryFeedState();
}

class _MangaDexHistoryFeedState extends ConsumerState<MangaDexHistoryFeedPage> {
  late final _pagingController = GagakuPagingController<int, Chapter>(
    getNextPageKey: (state) => state.keys?.last ?? 0,
    fetchPage: (pageKey) async {
      final me = await ref.watch(loggedUserProvider.future);
      final api = ref.watch(mangadexProvider);

      final chapters = await ref.watch(mangaDexHistoryProvider.future);

      final mangaIds = chapters.map((e) => e.manga.id).toSet();
      final mangas = await api.fetchMangaById(
        ids: mangaIds,
        limit: MangaDexEndpoints.breakLimit,
      );

      await ref.read(statisticsProvider.get)(mangas);
      await ref.read(readChaptersProvider(me?.id).get)(mangas);
      await ref.read(chapterStatsProvider.get)(chapters);

      return PageResultsMetaData(chapters.toList());
    },
    refresh: () async {
      ref.invalidate(mangaDexHistoryProvider);
    },
    getIsLastPage: (_, __) => true,
  );

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scrollController =
        DefaultScrollController.maybeOf(context, 'MangaDexHistoryFeedPage') ??
        widget.controller ??
        useScrollController();

    return ChapterFeedWidget(
      controller: _pagingController,
      onRefresh: () async => _pagingController.refresh(),
      title: 'mangadex.localHistory'.tr(context: context),
      scrollController: scrollController,
      restorationId: 'history_list_offset',
      leading: [
        MangaDexSliverAppBar(
          title: 'history.text'.tr(context: context),
          controller: scrollController,
        ),
      ],
    );
  }
}
