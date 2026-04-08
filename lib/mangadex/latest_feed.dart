import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/mangadex/model/model.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:gagaku/model/common.dart';
import 'package:riverpod_annotation/experimental/scope.dart';

@Dependencies([chipTextStyle])
class MangaDexGlobalFeedPage extends HookWidget {
  const MangaDexGlobalFeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final controller = useScrollController();
    final info = MangaDexFeeds.globalFeed;

    return Scaffold(
      body: InfiniteScrollChapterFeedWidget(
        feedKey: info.key,
        limit: info.limit,
        path: info.path!,
        scrollController: controller,
        restorationId: 'global_list_offset',
        leading: [
          SliverAppBar.medium(
            pinned: true,
            leading: const BackButton(),
            title: GestureDetector(
              onTap: () => controller.animateTo(
                0.0,
                duration: const Duration(milliseconds: 1000),
                curve: Curves.easeOutCirc,
              ),
              child: Text(t.chapterFeed.latestUpdates),
            ),
          ),
        ],
      ),
    );
  }
}
