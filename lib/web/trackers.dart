import 'dart:async';

import 'package:cached_network_image_ce/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/routes.dart';
import 'package:gagaku/util/cached_network_image.dart';
import 'package:gagaku/util/ui.dart';
import 'package:gagaku/web/extension_settings.dart';
import 'package:gagaku/web/model/config.dart';
import 'package:gagaku/web/model/model.dart';
import 'package:gagaku/web/model/tracker_queue.dart';
import 'package:gagaku/web/model/tracking.dart';
import 'package:gagaku/web/model/tracking_types.dart';
import 'package:gagaku/web/model/types.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:timeago/timeago.dart' as timeago;

/// Installed trackers, their queue status, and the pause setting.
class TrackersPage extends ConsumerWidget {
  const TrackersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tr = context.t;
    final trackers = ref.watch(installedTrackersProvider);
    final statuses = ref.watch(trackerQueueCoordinatorProvider);
    final paused = ref.watch(
      webConfigProvider.select((cfg) => cfg.pauseTrackerUpdates),
    );

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(tr.webSources.trackers.title),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          children: [
            SwitchListTile(
              title: Text(tr.webSources.trackers.pauseUpdates),
              subtitle: Text(tr.webSources.trackers.pauseUpdatesDesc),
              value: paused,
              onChanged: (value) => ref
                  .read(webConfigProvider.notifier)
                  .saveWith(pauseTrackerUpdates: value),
            ),
            const Divider(),
            switch (trackers) {
              AsyncValue(value: final list?) when list.isEmpty => Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(tr.webSources.trackers.noneInstalled),
              ),
              AsyncValue(value: final list?) => Column(
                children: [
                  for (final tracker in list)
                    _TrackerStatusCard(
                      tracker: tracker,
                      status: statuses[tracker.id] ?? const TrackerSyncStatus(),
                    ),
                ],
              ),
              AsyncValue(:final error?, :final stackTrace?) => ErrorList(
                error: error,
                stackTrace: stackTrace,
              ),
              _ => const Center(child: CircularProgressIndicator()),
            },
          ],
        ),
      ),
    );
  }
}

class _TrackerStatusCard extends ConsumerWidget {
  const _TrackerStatusCard({required this.tracker, required this.status});

  final WebSourceInfo tracker;
  final TrackerSyncStatus status;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tr = context.t.webSources.trackers;
    final locale = context.t.$meta.locale.languageCode;
    final theme = Theme.of(context);
    final coordinator = ref.read(trackerQueueCoordinatorProvider.notifier);

    final lines = [
      if (status.running) tr.syncing,
      tr.pendingCount(count: status.pending),
      if (status.dead > 0) tr.failedCount(count: status.dead),
      if (status.lastSuccess case final time?)
        tr.lastSync(time: timeago.format(time, locale: locale))
      else
        tr.notSynced,
      if (status.retryAfter case final time? when time.isAfter(DateTime.now()))
        tr.retryAt(
          time: timeago.format(time, locale: locale, allowFromNow: true),
        ),
    ];

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            leading: _TrackerIcon(tracker: tracker),
            title: Text(tracker.name),
            subtitle: Text(lines.join(' · ')),
            trailing: Tooltip(
              message: tr.account,
              child: const Icon(Icons.manage_accounts),
            ),
            onTap: () => Navigator.of(context).push(
              SlideTransitionRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    ExtensionSettingsPage(source: tracker),
              ),
            ),
          ),
          if (status.lastError case final error?)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                tr.lastError(error: error),
                style: TextStyle(color: theme.colorScheme.error),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
            child: OverflowBar(
              alignment: MainAxisAlignment.end,
              spacing: 8.0,
              children: [
                if (status.dead > 0)
                  TextButton(
                    onPressed: () async {
                      final confirmed = await showDialog<bool>(
                        context: context,
                        builder: (context) => _ConfirmDialog(
                          title: tr.discardFailed,
                          message: tr.discardFailedWarning(
                            count: status.dead,
                            tracker: tracker.name,
                          ),
                        ),
                      );
                      if (confirmed != true) return;
                      final queue = ref.read(trackerQueueStoreProvider);
                      await queue.discard(
                        queue
                            .itemsFor(tracker.id)
                            .where((e) => e.state == TrackerQueueState.dead)
                            .map((e) => e.id),
                      );
                    },
                    child: Text(tr.discardFailed),
                  ),
                if (status.dead > 0)
                  TextButton(
                    onPressed: () async {
                      await ref
                          .read(trackerQueueStoreProvider)
                          .retryDead(tracker.id);
                      await coordinator.flush(force: true);
                    },
                    child: Text(tr.retryFailed),
                  ),
                FilledButton.tonal(
                  onPressed: status.running
                      ? null
                      : () => coordinator.flush(force: true),
                  child: Text(tr.syncNow),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Opens the tracking sheet for a series. Hidden unless the series can be
/// tracked (pass 1: Paperback extension series) and a tracker is installed.
class TrackingButton extends ConsumerWidget {
  const TrackingButton({super.key, required this.series, required this.title});

  final WebSeriesRef series;
  final String title;

  /// Whether the button would show for [series]. Callers that lay buttons out
  /// with spacing (such as an `OverflowBar`) should omit the button when this
  /// is false rather than insert an empty child.
  static bool isAvailable(WidgetRef ref, WebSeriesRef series) =>
      series is ExtensionSeriesRef &&
      (ref.watch(installedTrackersProvider).value?.isNotEmpty ?? false);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!isAvailable(ref, series)) {
      return const SizedBox.shrink();
    }

    final trackers = ref.watch(installedTrackersProvider).value ?? const [];

    final tracked = TrackedSeriesRef.web(series);
    final trackerIds = trackers.map((e) => e.id).toSet();
    final linked =
        (ref.watch(trackerLinksForSeriesProvider(tracked)).value ?? const [])
            .where((link) => trackerIds.contains(link.trackerId))
            .length;
    final theme = Theme.of(context);

    return IconButton(
      tooltip: context.t.webSources.trackers.tracking,
      style: Styles.squareIconButtonStyle(
        backgroundColor: theme.colorScheme.surface.withAlpha(200),
      ),
      onPressed: () => showModalBottomSheet<void>(
        context: context,
        // The app theme makes bottom sheets transparent by default.
        backgroundColor: theme.colorScheme.surfaceContainerHigh,
        isScrollControlled: true,
        showDragHandle: true,
        builder: (context) => TrackingSheet(series: tracked, title: title),
      ),
      icon: Badge(
        isLabelVisible: linked > 0,
        // Keep the tooltip as the accessible label; the count is visual.
        label: ExcludeSemantics(child: Text('$linked')),
        child: Icon(linked > 0 ? Icons.bookmark_added : Icons.bookmark_add),
      ),
    );
  }
}

/// One row per installed tracker for a series: link, progress, edit, unlink.
class TrackingSheet extends ConsumerWidget {
  const TrackingSheet({super.key, required this.series, required this.title});

  final TrackedSeriesRef series;
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tr = context.t.webSources.trackers;
    final trackers = ref.watch(installedTrackersProvider).value ?? const [];
    final links =
        ref.watch(trackerLinksForSeriesProvider(series)).value ?? const [];

    return SafeArea(
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.only(bottom: 8.0),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(tr.tracking, style: CommonTextStyles.twentyBold),
          ),
          for (final tracker in trackers)
            _TrackerLinkTile(
              tracker: tracker,
              series: series,
              title: title,
              link: links.firstWhereOrNull((l) => l.trackerId == tracker.id),
            ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: () {
                Navigator.of(context).pop();
                const TrackersRoute().push(context);
              },
              icon: const Icon(Icons.tune),
              label: Text(tr.manageTrackers),
            ),
          ),
        ],
      ),
    );
  }
}

class _TrackerLinkTile extends ConsumerWidget {
  const _TrackerLinkTile({
    required this.tracker,
    required this.series,
    required this.title,
    required this.link,
  });

  final WebSourceInfo tracker;
  final TrackedSeriesRef series;
  final String title;
  final TrackerLink? link;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tr = context.t.webSources.trackers;
    final nav = Navigator.of(context);

    Future<void> openSearch() => nav.push(
      SlideTransitionRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            TrackerLinkSearchPage(
              tracker: tracker,
              series: series,
              initialQuery: title,
            ),
      ),
    );

    final current = link;
    if (current == null) {
      return ListTile(
        leading: _TrackerIcon(tracker: tracker),
        title: Text(tracker.name),
        subtitle: Text(tr.notLinked),
        trailing: FilledButton.tonal(
          onPressed: openSearch,
          child: Text(tr.link),
        ),
      );
    }

    final entry = current.trackedManga;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ListTile(
          leading: _TrackedCover(tracker: tracker, entry: entry),
          title: Text(entry.mangaInfo.primaryTitle),
          subtitle: _TrackerProgressSummary(tracker: tracker, link: current),
          trailing: _TrackerIcon(tracker: tracker, size: 24.0),
          onTap: openSearch,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
          child: OverflowBar(
            alignment: MainAxisAlignment.end,
            spacing: 8.0,
            children: [
              TextButton(
                onPressed: () async {
                  final confirmed = await showDialog<bool>(
                    context: context,
                    builder: (context) => _ConfirmDialog(
                      title: tr.unlink,
                      message: tr.unlinkWarning(tracker: tracker.name),
                    ),
                  );
                  if (confirmed == true) {
                    await ref
                        .read(trackerLinkRepositoryProvider)
                        .unlink(current);
                  }
                },
                child: Text(tr.unlink),
              ),
              TextButton(onPressed: openSearch, child: Text(tr.changeLink)),
              FilledButton.tonal(
                onPressed: () async {
                  await nav.push(
                    SlideTransitionRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          ExtensionSettingsPage(
                            source: tracker,
                            title: tr.editProgress,
                            loadForm: (extension) =>
                                extension.getMangaProgressManagementForm(entry),
                          ),
                    ),
                  );
                  ref.invalidate(
                    trackerProgressProvider(tracker.id, current.linkKey),
                  );
                },
                child: Text(tr.editProgress),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TrackerProgressSummary extends ConsumerWidget {
  const _TrackerProgressSummary({required this.tracker, required this.link});

  final WebSourceInfo tracker;
  final TrackerLink link;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tr = context.t;
    final progress = ref.watch(
      trackerProgressProvider(tracker.id, link.linkKey),
    );
    final theme = Theme.of(context);

    return switch (progress) {
      AsyncValue(hasValue: true, :final value) => Text(
        value == null
            ? tr.webSources.trackers.notOnList
            : [
                tr.webSources.trackers.chapterProgress(
                  chapter: value.lastReadChapter.chapNum,
                ),
                if (value.userRating case final rating? when rating > 0)
                  tr.webSources.trackers.rating(rating: rating),
              ].join(' · '),
      ),
      AsyncValue(:final error?) => Text(
        error.toString(),
        style: TextStyle(color: theme.colorScheme.error),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      _ => Text(tr.ui.loadingDot),
    };
  }
}

/// Searches a tracker's catalog and links the chosen entry.
class TrackerLinkSearchPage extends HookConsumerWidget {
  const TrackerLinkSearchPage({
    super.key,
    required this.tracker,
    required this.series,
    required this.initialQuery,
  });

  final WebSourceInfo tracker;
  final TrackedSeriesRef series;
  final String initialQuery;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tr = context.t.webSources.trackers;
    final controller = useTextEditingController(text: initialQuery);
    final query = useState(initialQuery);
    final linking = useState(false);
    final search = useMemoized(
      () => ref
          .read(extensionSourceProvider(tracker.id).notifier)
          .searchManga(SearchQuery(title: query.value), null),
      [query.value],
    );
    final results = useFuture(search);

    Future<void> select(SearchResultItem item) async {
      linking.value = true;
      final messenger = ScaffoldMessenger.of(context);
      final nav = Navigator.of(context);
      try {
        final entry = await ref
            .read(extensionSourceProvider(tracker.id).notifier)
            .getMangaDetails(item.mangaId);
        ref
            .read(trackerLinkRepositoryProvider)
            .link(trackerId: tracker.id, series: series, trackedManga: entry);
        messenger
          ..removeCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(tr.linked(title: entry.mangaInfo.primaryTitle)),
            ),
          );
        nav.pop();
      } catch (error) {
        linking.value = false;
        messenger
          ..removeCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(error.toString())));
      }
    }

    final items = results.data?.items ?? const <SearchResultItem>[];

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(tr.linkOn(tracker: tracker.name)),
        bottom: linking.value
            ? const PreferredSize(
                preferredSize: Size.fromHeight(4.0),
                child: LinearProgressIndicator(),
              )
            : null,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: controller,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: tr.searchHint(tracker: tracker.name),
                  border: const OutlineInputBorder(),
                ),
                onSubmitted: (value) => query.value = value.trim(),
              ),
            ),
            Expanded(
              child: switch (results) {
                AsyncSnapshot(:final error?, :final stackTrace?) => ErrorList(
                  error: error,
                  stackTrace: stackTrace,
                ),
                AsyncSnapshot(connectionState: ConnectionState.done)
                    when items.isEmpty =>
                  Center(child: Text(tr.noResults)),
                AsyncSnapshot(connectionState: ConnectionState.done) =>
                  ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) => _TrackerSearchResultTile(
                      tracker: tracker,
                      item: items[index],
                      enabled: !linking.value,
                      onSelect: select,
                    ),
                  ),
                _ => const Center(child: CircularProgressIndicator()),
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _TrackerSearchResultTile extends StatelessWidget {
  const _TrackerSearchResultTile({
    required this.tracker,
    required this.item,
    required this.enabled,
    required this.onSelect,
  });

  final WebSourceInfo tracker;
  final SearchResultItem item;
  final bool enabled;
  final Future<void> Function(SearchResultItem item) onSelect;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      enabled: enabled,
      leading: _TrackedCover(tracker: tracker, imageUrl: item.imageUrl),
      title: Text(item.title),
      subtitle: item.subtitle != null ? Text(item.subtitle!) : null,
      onTap: () => unawaited(onSelect(item)),
    );
  }
}

class _TrackerIcon extends StatelessWidget {
  const _TrackerIcon({required this.tracker, this.size = 40.0});

  final WebSourceInfo tracker;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6.0),
      child: Image.network(
        tracker.icon,
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) =>
            Icon(Icons.extension, size: size),
      ),
    );
  }
}

class _TrackedCover extends ConsumerWidget {
  const _TrackedCover({required this.tracker, this.entry, this.imageUrl});

  final WebSourceInfo tracker;
  final SourceManga? entry;
  final String? imageUrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final url = imageUrl ?? entry?.mangaInfo.thumbnailUrl ?? '';
    if (url.isEmpty) {
      return const SizedBox(width: 40.0, child: Icon(Icons.menu_book));
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(4.0),
      child: CachedNetworkImage(
        imageUrl: url,
        httpHeaders: ref.watch(sourceHeadersProvider(tracker.id)),
        cacheManager: ref.watch(extensionImageCacheProvider),
        memCacheWidth: 128,
        maxWidthDiskCache: 128,
        width: 40.0,
        height: 56.0,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) =>
            const SizedBox(width: 40.0, child: Icon(Icons.broken_image)),
      ),
    );
  }
}

class _ConfirmDialog extends StatelessWidget {
  const _ConfirmDialog({required this.title, required this.message});

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    final tr = context.t;
    final nav = Navigator.of(context);
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        ElevatedButton(onPressed: () => nav.pop(false), child: Text(tr.ui.no)),
        TextButton(onPressed: () => nav.pop(true), child: Text(tr.ui.yes)),
      ],
    );
  }
}
