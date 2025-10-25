import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/mangadex/login_password.dart';
import 'package:gagaku/mangadex/manga_feed.dart';
import 'package:gagaku/mangadex/model/model.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:gagaku/model/common.dart';
import 'package:gagaku/util/default_scroll_controller.dart';
import 'package:gagaku/util/ui.dart';
import 'package:riverpod_annotation/experimental/scope.dart';

enum _FeedViewType { chapters, manga }

@Dependencies([readBorderTheme, chipTextStyle])
class MangaDexChapterFeedPage extends StatelessWidget {
  const MangaDexChapterFeedPage({super.key, this.controller});

  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    return MangaDexLoginWidget(
      builder: (context) => MangaDexChapterFeedWidget(controller: controller),
    );
  }
}

@Dependencies([readBorderTheme, chipTextStyle])
class MangaDexChapterFeedWidget extends HookWidget {
  const MangaDexChapterFeedWidget({super.key, this.controller});
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    final tr = context.t;
    final scrollController =
        DefaultScrollController.maybeOf(context, 'MangaDexChapterFeedPage') ??
        controller ??
        useScrollController();
    final view = useState(_FeedViewType.chapters);

    final leading = <Widget>[
      MangaDexSliverAppBar(
        title: tr.mangadex.myFeed,
        controller: scrollController,
      ),
      SliverAppBar(
        automaticallyImplyLeading: false,
        pinned: true,
        title: Text(tr.chapterFeed.updates, style: CommonTextStyles.twentyfour),
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
                label: Text(tr.mangadex.byChapter),
              ),
              ButtonSegment<_FeedViewType>(
                value: _FeedViewType.manga,
                label: Text(tr.mangadex.byManga),
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
