import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/mangadex/login_password.dart';
import 'package:gagaku/mangadex/manga_feed.dart';
import 'package:gagaku/mangadex/model/model.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:gagaku/util/default_scroll_controller.dart';

enum _FeedViewType { chapters, manga }

@RoutePage()
class MangaDexChapterFeedPage extends StatelessWidget {
  const MangaDexChapterFeedPage({super.key, this.controller});

  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    return MangaDexLoginWidget(
      builder: (context) => MangaDexChapterFeedWidget(),
    );
  }
}

class MangaDexChapterFeedWidget extends HookWidget {
  const MangaDexChapterFeedWidget({super.key, this.controller});
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    final scrollController =
        DefaultScrollController.maybeOf(context) ??
        controller ??
        useScrollController();
    final view = useState(_FeedViewType.chapters);

    final leading = <Widget>[
      MangaDexSliverAppBar(
        title: 'mangadex.myFeed'.tr(context: context),
        controller: scrollController,
      ),
      SliverAppBar(
        automaticallyImplyLeading: false,
        pinned: true,
        title: Text(
          'mangadex.updates'.tr(context: context),
          style: TextStyle(fontSize: 24),
        ),
        actions: [
          SegmentedButton<_FeedViewType>(
            style: SegmentedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
              ),
            ),
            showSelectedIcon: false,
            segments: <ButtonSegment<_FeedViewType>>[
              ButtonSegment<_FeedViewType>(
                value: _FeedViewType.chapters,
                label: Text('mangadex.byChapter'.tr(context: context)),
              ),
              ButtonSegment<_FeedViewType>(
                value: _FeedViewType.manga,
                label: Text('mangadex.byManga'.tr(context: context)),
              ),
            ],
            selected: <_FeedViewType>{view.value},
            onSelectionChanged: (Set<_FeedViewType> newSelection) {
              view.value = newSelection.first;
            },
          ),
        ],
      ),
    ];

    final info = MangaDexFeeds.latestChapters;

    return switch (view.value) {
      _FeedViewType.chapters => InfiniteScrollChapterFeedWidget(
        feedKey: info.key,
        limit: info.limit,
        path: info.path!,
        scrollController: scrollController,
        restorationId: 'chapter_list_offset',
        leading: leading,
      ),
      _FeedViewType.manga => MangaDexMangaFeed(
        controller: scrollController,
        leading: leading,
      ),
    };
  }
}
