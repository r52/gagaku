import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/util/default_scroll_controller.dart';
import 'package:gagaku/util/notification_service.dart';
import 'package:gagaku/util/ui.dart';
import 'package:gagaku/util/util.dart';
import 'package:gagaku/web/model/config.dart';
import 'package:gagaku/web/model/model.dart';
import 'package:gagaku/web/model/types.dart';
import 'package:gagaku/web/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:super_sliver_list/super_sliver_list.dart';

enum _UpdateState { stopped, run, running, stopping }

@RoutePage()
class WebSourceUpdatesPage extends StatefulHookConsumerWidget {
  const WebSourceUpdatesPage({super.key, this.controller});

  final ScrollController? controller;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _WebSourceUpdatesPageState();
}

class _WebSourceUpdatesPageState extends ConsumerState<WebSourceUpdatesPage> {
  static const feedKey = 'ExtUpdateFeed';
  _UpdateState runState = _UpdateState.stopped;
  String progress = '';
  String currentItem = '';

  Future<void> _stopFeedUpdate() async {
    setState(() {
      runState = _UpdateState.stopped;
    });

    if (DeviceContext.isMobile()) {
      await FlutterBackground.disableBackgroundExecution();
    }
  }

  Future<List<UpdateFeedItem>?> _getFeedUpdates() async {
    final isMobile = DeviceContext.isMobile();
    final tr = context.t;
    final api = ref.watch(proxyProvider);

    if (await api.cacheExists(feedKey)) {
      logger.d('CacheManager: retrieving entry $feedKey');
      List<dynamic> list = api.cacheGet<List<dynamic>>(feedKey);
      if (list.first is! UpdateFeedItem) {
        list = list.map((e) => UpdateFeedItem.fromJson(e)).toList();
      }

      return list as List<UpdateFeedItem>;
    }

    if (runState != _UpdateState.run) {
      return null;
    }

    logger.d('Starting feed update');

    setState(() {
      runState = _UpdateState.running;
      progress = '';
      currentItem = '';
    });

    // 0. Setup permissions/background execution
    await NotificationService().initialize();

    final config = FlutterBackgroundAndroidConfig(
      notificationTitle: 'Gagaku',
      notificationText: tr.chapterFeed.updatingFeed,
      notificationIcon: AndroidResource(name: 'background_icon'),
      notificationImportance: AndroidNotificationImportance.normal,
      enableWifiLock: true,
      showBadge: true,
    );

    if (isMobile) {
      var hasPermissions = await FlutterBackground.hasPermissions;
      if (!hasPermissions && context.mounted) {
        await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(tr.permissions.needed),
              content: Text(tr.permissions.request),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(tr.ui.ok),
                ),
              ],
            );
          },
        );
      }

      hasPermissions = await FlutterBackground.initialize(
        androidConfig: config,
      );

      if (!hasPermissions) {
        logger.w('Permissions denied');
        await _stopFeedUpdate();
        return null;
      }

      logger.d('Permission setup completed');

      final backgroundExecution =
          await FlutterBackground.enableBackgroundExecution();

      if (!backgroundExecution) {
        logger.w('Failed to enable background execution');
        await _stopFeedUpdate();
        return null;
      }

      logger.d('Background execution setup done');
    }

    // 1. Collect titles from categories tagged for update

    final categoriesToUpdate = ref.read(
      webConfigProvider.select((cfg) => cfg.categoriesToUpdate),
    );

    final favorites = await ref.read(webSourceFavoritesProvider.future);

    Set<HistoryLink> linksToUpdate = {};

    for (final c in categoriesToUpdate) {
      if (favorites.containsKey(c)) {
        linksToUpdate.addAll(favorites[c]!);
      }
    }

    logger.d('Links to update: ${linksToUpdate.length}');

    // 2. Generate source handle for each link

    List<HistoryLink> links = [];
    for (final link in linksToUpdate) {
      final handledLink = await api.handleLink(link);

      if (handledLink.handle != null) {
        // Add links that didn't fail
        links.add(handledLink);
      }
    }

    // 3. Retrieve manga data for each source handle
    List<UpdateFeedItem> mangas = [];

    int processedCount = 0;
    for (final link in links) {
      final updatingTitle = tr.chapterFeed.updatingItem(item: link.title);
      if (isMobile) {
        await NotificationService().updateProgressNotification(
          maxProgress: links.length,
          currentProgress: processedCount,
          title: tr.chapterFeed.updatingFeed,
          body: updatingTitle,
        );
      }

      setState(() {
        progress = '$processedCount/${links.length}';
        currentItem = updatingTitle;
      });

      logger.d('Update progress: $processedCount/${links.length}');

      final manga = await api.getMangaFromSource(link.handle!);
      processedCount++;

      if (manga != null) {
        mangas.add(UpdateFeedItem(link: link, manga: manga));
      }

      if (processedCount % 5 == 0) {
        await Future.delayed(const Duration(seconds: 1));
      }

      // Exit if stopped
      if (runState == _UpdateState.stopping) {
        logger.w('Feed update stopped');
        await _stopFeedUpdate();
        return null;
      }
    }

    if (runState == _UpdateState.stopping) {
      logger.w('Feed update stopped');
      await _stopFeedUpdate();
      return null;
    }

    logger.d('Sorting updates');

    // 4. Sort manga list by latest chapter
    mangas.sort((a, b) {
      final aLatestChapterTime = a.manga.chapters.first.chapter.releaseDate;
      final bLatestChapterTime = b.manga.chapters.first.chapter.releaseDate;

      if (aLatestChapterTime == null) {
        return 1;
      }

      if (bLatestChapterTime == null) {
        return -1;
      }

      return bLatestChapterTime.compareTo(aLatestChapterTime);
    });

    const expiry = Duration(days: 1);

    logger.d('CacheManager: caching entry $feedKey for ${expiry.toString()}');
    api.cachePut(feedKey, json.encode(mangas), mangas, true, expiry: expiry);

    await NotificationService().updateProgressNotification(
      title: tr.chapterFeed.updatingFeed,
      body: tr.chapterFeed.done,
    );

    await _stopFeedUpdate();

    return mangas;
  }

  @override
  Widget build(BuildContext context) {
    final messenger = ScaffoldMessenger.of(context);
    final api = ref.watch(proxyProvider);
    final t = context.t;
    final scrollController =
        DefaultScrollController.maybeOf(context, 'WebSourceUpdatesPage') ??
        widget.controller ??
        useScrollController();

    final refresh = useState(UniqueKey());
    final results = useMemoized(() => _getFeedUpdates(), [refresh.value]);
    final future = useFuture(results);
    final slivers = <Widget>[];

    if (future.hasError) {
      final error = future.error!;
      final stackTrace = future.stackTrace!;
      final msg = "_WebSourceUpdatesPageState._getFeedUpdates() failed";

      Styles.showErrorSnackBar(messenger, '$error');
      logger.e(msg, error: error, stackTrace: stackTrace);

      slivers.add(
        SliverList.list(
          children: [Text('$error'), Text(stackTrace.toString())],
        ),
      );
    }

    if (future.connectionState == ConnectionState.waiting &&
        (runState == _UpdateState.running ||
            runState == _UpdateState.stopping)) {
      slivers.add(
        SliverFillRemaining(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10.0,
            children: [
              const CircularProgressIndicator(),
              Text(
                runState == _UpdateState.running
                    ? t.chapterFeed.updatingFeed
                    : t.chapterFeed.stopping,
              ),
              Text(progress),
              Text(currentItem),
              if (runState == _UpdateState.running)
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      runState = _UpdateState.stopping;
                    });
                  },
                  label: Text(t.chapterFeed.stop),
                  icon: Icon(Icons.stop),
                ),
            ],
          ),
        ),
      );
    }

    if (!future.hasData && runState == _UpdateState.stopped) {
      slivers.add(
        SliverFillRemaining(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10.0,
            children: [
              Text(t.chapterFeed.updateRequired),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    runState = _UpdateState.run;
                    refresh.value = UniqueKey();
                  });
                },
                label: Text(t.chapterFeed.updatingFeed),
                icon: Icon(Icons.refresh),
              ),
            ],
          ),
        ),
      );
    }

    if (future.data != null) {
      final data = future.data!;

      slivers.add(
        SuperSliverList.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final item = data.elementAt(index);
            return ChapterFeedItem(state: item);
          },
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        runState = _UpdateState.run;
        await api.invalidateCacheItem(feedKey);
        refresh.value = UniqueKey();
        return;
      },
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
