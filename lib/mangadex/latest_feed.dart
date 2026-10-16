import 'package:material_ui/material_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/mangadex/model/model.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:gagaku/util/ui.dart';

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
          PageSliverAppBar(
            title: t.chapterFeed.latestUpdates,
            controller: controller,
          ),
        ],
      ),
    );
  }
}
