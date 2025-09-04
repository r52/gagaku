import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/mangadex/model/model.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:gagaku/model/common.dart';
import 'package:gagaku/util/ui.dart';
import 'package:riverpod_annotation/experimental/scope.dart';

@Dependencies([readBorderTheme, chipTextStyle])
@RoutePage()
class MangaDexGlobalFeedPage extends HookWidget {
  const MangaDexGlobalFeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final controller = useScrollController();
    final info = MangaDexFeeds.globalFeed;

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: GestureDetector(
          onTap: () {
            controller.animateTo(
              0.0,
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeOutCirc,
            );
          },
          child: TitleFlexBar(title: t.chapterFeed.latestUpdates),
        ),
        leading: AutoLeadingButton(),
      ),
      body: InfiniteScrollChapterFeedWidget(
        feedKey: info.key,
        limit: info.limit,
        path: info.path!,
        scrollController: controller,
        restorationId: 'global_list_offset',
      ),
    );
  }
}
