import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/util/default_scroll_controller.dart';
import 'package:gagaku/util/ui.dart';
import 'package:gagaku/web/model/types.dart';
import 'package:gagaku/web/model/update_feed.dart';
import 'package:gagaku/web/model/update_feed_controller.dart';
import 'package:gagaku/web/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:super_sliver_list/super_sliver_list.dart';

class WebSourceUpdatesPage extends HookConsumerWidget {
  const WebSourceUpdatesPage({super.key, this.controller});

  final ScrollController? controller;

  Future<void> _startUpdate(BuildContext context, WidgetRef ref) async {
    final platform = ref.read(updateFeedPlatformProvider);
    if (!await platform.hasBackgroundPermissions()) {
      if (!context.mounted) {
        return;
      }
      final tr = context.t;
      await showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(tr.permissions.needed),
          content: Text(tr.permissions.request),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(tr.ui.ok),
            ),
          ],
        ),
      );
    }

    if (!context.mounted) {
      return;
    }
    final tr = context.t;
    await ref
        .read(webUpdateFeedControllerProvider.notifier)
        .start(
          UpdateFeedMessages(
            updatingFeed: tr.chapterFeed.updatingFeed,
            done: tr.chapterFeed.done,
            updatingItem: (title) => tr.chapterFeed.updatingItem(item: title),
          ),
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tr = context.t;
    final scrollController =
        DefaultScrollController.maybeOf(context) ??
        controller ??
        useScrollController();
    final feed = ref.watch(webUpdateFeedControllerProvider);
    final slivers = <Widget>[
      WebSourceSliverAppBar(
        title: tr.chapterFeed.latestUpdates,
        controller: scrollController,
      ),
    ];

    void addItems(List<UpdateFeedItem> items) {
      slivers.add(
        SuperSliverList.builder(
          itemCount: items.length,
          itemBuilder: (context, index) => ChapterFeedItem(state: items[index]),
        ),
      );
    }

    void addStartPrompt() {
      slivers.add(
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10.0,
            children: [
              Text(tr.chapterFeed.updateRequired),
              ElevatedButton.icon(
                onPressed: () => _startUpdate(context, ref),
                label: Text(tr.chapterFeed.updatingFeed),
                icon: const Icon(Icons.refresh),
              ),
            ],
          ),
        ),
      );
    }

    void addFailure(List<UpdateFeedItem>? items) {
      final errorWidget = Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 10.0,
        children: [
          Text(tr.errors.generic),
          ElevatedButton.icon(
            onPressed: () => _startUpdate(context, ref),
            label: Text(tr.ui.retry),
            icon: const Icon(Icons.refresh),
          ),
        ],
      );
      if (items == null) {
        slivers.add(
          SliverFillRemaining(
            hasScrollBody: false,
            child: Center(child: errorWidget),
          ),
        );
      } else {
        slivers.add(
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: errorWidget,
            ),
          ),
        );
        addItems(items);
      }
    }

    switch (feed) {
      case AsyncLoading():
        slivers.add(
          const SliverFillRemaining(
            hasScrollBody: false,
            child: Center(child: CircularProgressIndicator()),
          ),
        );
      case AsyncError():
        addFailure(null);
      case AsyncData(:final value):
        switch (value) {
          case UpdateFeedRunning(
            :final completed,
            :final total,
            :final currentTitle,
            :final cancelling,
          ):
            slivers.add(
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 10.0,
                  children: [
                    const CircularProgressIndicator(),
                    Text(
                      cancelling
                          ? tr.chapterFeed.stopping
                          : tr.chapterFeed.updatingFeed,
                    ),
                    Text('$completed/$total'),
                    if (currentTitle != null)
                      Text(tr.chapterFeed.updatingItem(item: currentTitle)),
                    if (!cancelling)
                      ElevatedButton.icon(
                        onPressed: () => ref
                            .read(webUpdateFeedControllerProvider.notifier)
                            .cancel(),
                        label: Text(tr.chapterFeed.stop),
                        icon: const Icon(Icons.stop),
                      ),
                  ],
                ),
              ),
            );
          case UpdateFeedFailure(:final items):
            addFailure(items);
          case UpdateFeedIdle(:final items):
            if (items == null) {
              addStartPrompt();
            } else {
              addItems(items);
            }
        }
    }

    return RefreshIndicator(
      onRefresh: () => _startUpdate(context, ref),
      child: ScrollConfiguration(
        behavior: const MouseTouchScrollBehavior(),
        child: CustomScrollView(
          scrollBehavior: const MouseTouchScrollBehavior(),
          physics: const AlwaysScrollableScrollPhysics(),
          controller: scrollController,
          slivers: slivers,
        ),
      ),
    );
  }
}
