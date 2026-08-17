import 'dart:async';

import 'package:gagaku/web/model/types.dart';

const updateFeedCacheKey = 'ExtUpdateFeed';
const updateFeedCacheExpiry = Duration(days: 1);

sealed class UpdateFeedState {
  const UpdateFeedState({required this.items});

  final List<UpdateFeedItem>? items;
}

final class UpdateFeedIdle extends UpdateFeedState {
  UpdateFeedIdle({List<UpdateFeedItem>? items})
    : super(items: items == null ? null : List.unmodifiable(items));
}

final class UpdateFeedRunning extends UpdateFeedState {
  UpdateFeedRunning({
    required super.items,
    required this.completed,
    required this.total,
    required this.currentTitle,
    this.cancelling = false,
  });

  final int completed;
  final int total;
  final String? currentTitle;
  final bool cancelling;

  UpdateFeedRunning copyWith({bool? cancelling}) => UpdateFeedRunning(
    items: items,
    completed: completed,
    total: total,
    currentTitle: currentTitle,
    cancelling: cancelling ?? this.cancelling,
  );
}

final class UpdateFeedFailure extends UpdateFeedState {
  UpdateFeedFailure({
    required super.items,
    required this.error,
    required this.stackTrace,
  });

  final Object error;
  final StackTrace stackTrace;
}

final class UpdateFeedProgress {
  const UpdateFeedProgress({
    required this.completed,
    required this.total,
    required this.currentTitle,
  });

  final int completed;
  final int total;
  final String? currentTitle;
}

final class UpdateFeedMessages {
  const UpdateFeedMessages({
    required this.updatingFeed,
    required this.done,
    required this.updatingItem,
  });

  final String updatingFeed;
  final String done;
  final String Function(String title) updatingItem;
}

abstract interface class UpdateFeedRepository {
  Future<List<UpdateFeedItem>?> readCached();

  Future<List<HistoryLink>> loadCandidates(List<String> categoryIds);

  Future<void> publish(List<UpdateFeedItem> items);
}

abstract interface class UpdateFeedExecutionLease {
  Future<void> release();
}

abstract interface class UpdateFeedPlatform {
  Future<bool> hasBackgroundPermissions();

  Future<UpdateFeedExecutionLease> acquire(UpdateFeedMessages messages);

  Future<void> reportProgress(
    UpdateFeedProgress progress,
    UpdateFeedMessages messages,
  );

  Future<void> reportCompleted(UpdateFeedMessages messages);
}

final class UpdateFeedCancelled implements Exception {
  const UpdateFeedCancelled();
}

final class UpdateFeedCancellationToken {
  final Completer<void> _cancelled = Completer<void>();

  bool get isCancelled => _cancelled.isCompleted;

  void cancel() {
    if (!_cancelled.isCompleted) {
      _cancelled.complete();
    }
  }

  void throwIfCancelled() {
    if (isCancelled) {
      throw const UpdateFeedCancelled();
    }
  }

  Future<void> wait(Duration duration) async {
    if (duration <= Duration.zero) {
      throwIfCancelled();
      return;
    }

    await Future.any<void>([Future<void>.delayed(duration), _cancelled.future]);
    throwIfCancelled();
  }
}

typedef UpdateFeedLinkResolver = Future<HistoryLink> Function(HistoryLink link);
typedef UpdateFeedMangaFetcher =
    Future<WebManga?> Function(WebSeriesRef series);
typedef UpdateFeedProgressCallback = void Function(UpdateFeedProgress progress);
typedef UpdateFeedPacer =
    Future<void> Function(
      int processedCount,
      UpdateFeedCancellationToken cancellation,
    );

final class UpdateFeedRunner {
  UpdateFeedRunner({
    required this.repository,
    required this.platform,
    required this.resolveLink,
    required this.fetchManga,
    UpdateFeedPacer? pace,
  }) : _pace = pace ?? _defaultPace;

  final UpdateFeedRepository repository;
  final UpdateFeedPlatform platform;
  final UpdateFeedLinkResolver resolveLink;
  final UpdateFeedMangaFetcher fetchManga;
  final UpdateFeedPacer _pace;

  Future<List<UpdateFeedItem>> run({
    required List<String> categoryIds,
    required UpdateFeedMessages messages,
    required UpdateFeedCancellationToken cancellation,
    required UpdateFeedProgressCallback onProgress,
  }) async {
    final lease = await platform.acquire(messages);
    try {
      cancellation.throwIfCancelled();
      final candidates = await repository.loadCandidates(categoryIds);
      cancellation.throwIfCancelled();

      final links = <HistoryLink>[];
      for (final candidate in candidates) {
        cancellation.throwIfCancelled();
        final resolved = await resolveLink(candidate);
        cancellation.throwIfCancelled();
        if (resolved.series != null) {
          links.add(resolved);
        }
      }

      final items = <UpdateFeedItem>[];
      var processedCount = 0;
      for (final link in links) {
        cancellation.throwIfCancelled();
        final progress = UpdateFeedProgress(
          completed: processedCount,
          total: links.length,
          currentTitle: link.title,
        );
        onProgress(progress);
        await platform.reportProgress(progress, messages);
        cancellation.throwIfCancelled();

        final manga = await fetchManga(link.requireSeries);
        cancellation.throwIfCancelled();
        processedCount++;
        if (manga != null) {
          items.add(UpdateFeedItem(link: link, manga: manga));
        }

        onProgress(
          UpdateFeedProgress(
            completed: processedCount,
            total: links.length,
            currentTitle: link.title,
          ),
        );
        if (processedCount < links.length) {
          await _pace(processedCount, cancellation);
        }
      }

      cancellation.throwIfCancelled();
      items.sort(_compareLatestChapterDescending);
      cancellation.throwIfCancelled();
      await repository.publish(items);
      await platform.reportCompleted(messages);
      return List.unmodifiable(items);
    } finally {
      await lease.release();
    }
  }

  static Future<void> _defaultPace(
    int processedCount,
    UpdateFeedCancellationToken cancellation,
  ) {
    final delay = switch (processedCount) {
      final count when count % 25 == 0 => const Duration(seconds: 5),
      final count when count % 5 == 0 => const Duration(seconds: 1),
      _ => const Duration(milliseconds: 500),
    };
    return cancellation.wait(delay);
  }

  static int _compareLatestChapterDescending(
    UpdateFeedItem left,
    UpdateFeedItem right,
  ) {
    final leftChapters = left.manga.chapters;
    final rightChapters = right.manga.chapters;
    final leftDate = leftChapters.isEmpty ? null : leftChapters.first.date;
    final rightDate = rightChapters.isEmpty ? null : rightChapters.first.date;

    return switch ((leftDate, rightDate)) {
      (final DateTime left, final DateTime right) => right.compareTo(left),
      (final DateTime _, null) => -1,
      (null, final DateTime _) => 1,
      _ => 0,
    };
  }
}
