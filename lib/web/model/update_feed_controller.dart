import 'dart:async';
import 'dart:convert';

import 'package:gagaku/log.dart';
import 'package:gagaku/model/cache.dart';
import 'package:gagaku/model/model.dart';
import 'package:gagaku/objectbox.g.dart';
import 'package:gagaku/util/notification_service.dart';
import 'package:gagaku/web/model/config.dart';
import 'package:gagaku/web/model/model.dart';
import 'package:gagaku/web/model/types.dart';
import 'package:gagaku/web/model/update_feed.dart';
import 'package:gagaku/web/model/update_feed_foreground.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'update_feed_controller.g.dart';

final class PersistentUpdateFeedRepository implements UpdateFeedRepository {
  PersistentUpdateFeedRepository(this._cache);

  final CacheManager _cache;

  @override
  Future<List<UpdateFeedItem>?> readCached() async {
    if (!await _cache.exists(updateFeedCacheKey)) {
      return null;
    }

    logger.d('CacheManager: retrieving entry $updateFeedCacheKey');
    final cached = _cache.get<List<dynamic>>(updateFeedCacheKey);
    return List.unmodifiable(
      cached.map(
        (item) => switch (item) {
          UpdateFeedItem() => item,
          final Map<dynamic, dynamic> json => UpdateFeedItem.fromJson(
            Map<String, dynamic>.from(json),
          ),
          _ => throw FormatException(
            'Unsupported update-feed cache item: ${item.runtimeType}',
          ),
        },
      ),
    );
  }

  @override
  Future<List<HistoryLink>> loadCandidates(List<String> categoryIds) async {
    if (categoryIds.isEmpty) {
      return const [];
    }

    final builder = GagakuData().store.box<HistoryLink>().query();
    builder.backlinkMany(
      WebFavoritesList_.list,
      WebFavoritesList_.id.oneOf(categoryIds),
    );
    final query = builder.build();
    try {
      return query.find();
    } finally {
      query.close();
    }
  }

  @override
  Future<void> invalidateSeries(WebSeriesRef series) async {
    logger.d(
      'CacheManager: invalidating failed update-feed item ${series.key}',
    );
    await _cache.invalidateAll(series.key);
  }

  @override
  Future<void> publish(List<UpdateFeedItem> items) async {
    logger.d(
      'CacheManager: caching entry $updateFeedCacheKey for '
      '${updateFeedCacheExpiry.toString()}',
    );
    await _cache.put(
      updateFeedCacheKey,
      json.encode(items),
      List<UpdateFeedItem>.unmodifiable(items),
      expiry: updateFeedCacheExpiry,
    );
  }
}

@Riverpod(keepAlive: true)
UpdateFeedRepository updateFeedRepository(Ref ref) {
  return PersistentUpdateFeedRepository(ref.watch(cacheProvider));
}

@Riverpod(keepAlive: true)
UpdateFeedPlatform updateFeedPlatform(Ref ref) {
  return NativeUpdateFeedPlatform(NotificationService());
}

@Riverpod(keepAlive: true)
UpdateFeedRunner updateFeedRunner(Ref ref) {
  final resolver = ref.watch(webLinkResolverProvider);
  final broker = ref.watch(webSourceBrokerProvider);
  return UpdateFeedRunner(
    repository: ref.watch(updateFeedRepositoryProvider),
    platform: ref.watch(updateFeedPlatformProvider),
    resolveLink: resolver.resolveHistoryLink,
    fetchManga: broker.getManga,
  );
}

@Riverpod(keepAlive: true)
List<String> updateFeedCategories(Ref ref) {
  return ref.watch(webConfigProvider).categoriesToUpdate;
}

@Riverpod(keepAlive: true)
class WebUpdateFeedController extends _$WebUpdateFeedController {
  Future<void>? _activeRun;
  UpdateFeedCancellationToken? _cancellation;

  @override
  Future<UpdateFeedState> build() async {
    ref.onDispose(() => _cancellation?.cancel());
    try {
      final cached = await ref.watch(updateFeedRepositoryProvider).readCached();
      return UpdateFeedIdle(items: cached);
    } catch (error, stackTrace) {
      logger.e(
        'Failed to load cached web update feed',
        error: error,
        stackTrace: stackTrace,
      );
      return UpdateFeedFailure(
        items: null,
        error: error,
        stackTrace: stackTrace,
        completed: 0,
        total: 0,
      );
    }
  }

  Future<void> start(UpdateFeedMessages messages) async {
    await future;
    final activeRun = _activeRun;
    if (activeRun != null) {
      return activeRun;
    }

    late final Future<void> run;
    run = _run(messages).whenComplete(() {
      if (identical(_activeRun, run)) {
        _activeRun = null;
      }
    });
    _activeRun = run;
    return run;
  }

  void cancel() {
    final cancellation = _cancellation;
    if (cancellation == null) {
      return;
    }
    cancellation.cancel();

    final current = state.asData?.value;
    if (current is UpdateFeedRunning && !current.cancelling) {
      state = AsyncData(current.copyWith(cancelling: true));
    }
  }

  Future<void> _run(UpdateFeedMessages messages) async {
    final previousState = state.asData?.value;
    final previousItems = previousState?.items;
    final cancellation = UpdateFeedCancellationToken();
    var completed = 0;
    var total = 0;
    _cancellation = cancellation;
    state = AsyncData(
      UpdateFeedRunning(
        items: previousItems,
        completed: 0,
        total: 0,
        currentTitle: null,
      ),
    );

    try {
      if (previousState case UpdateFeedFailure(
        error: UpdateFeedItemFailure(
          stage: UpdateFeedItemFailureStage.fetchingManga,
          link: final failedLink,
        ),
      )) {
        await ref
            .read(updateFeedRepositoryProvider)
            .invalidateSeries(failedLink.requireSeries);
        cancellation.throwIfCancelled();
      }

      final items = await ref
          .read(updateFeedRunnerProvider)
          .run(
            categoryIds: ref.read(updateFeedCategoriesProvider),
            messages: messages,
            cancellation: cancellation,
            onProgress: (progress) {
              completed = progress.completed;
              total = progress.total;
              if (!identical(_cancellation, cancellation)) {
                return;
              }
              state = AsyncData(
                UpdateFeedRunning(
                  items: previousItems,
                  completed: progress.completed,
                  total: progress.total,
                  currentTitle: progress.currentTitle,
                  cancelling: cancellation.isCancelled,
                ),
              );
            },
          );
      if (identical(_cancellation, cancellation)) {
        state = AsyncData(UpdateFeedIdle(items: items));
      }
    } on UpdateFeedCancelled {
      if (identical(_cancellation, cancellation)) {
        logger.d('Web update feed cancelled');
        state = AsyncData(UpdateFeedIdle(items: previousItems));
      }
    } catch (error, stackTrace) {
      if (identical(_cancellation, cancellation)) {
        _logFailure(error, stackTrace);
        state = AsyncData(
          UpdateFeedFailure(
            items: previousItems,
            error: error,
            stackTrace: stackTrace,
            completed: completed,
            total: total,
          ),
        );
      }
    } finally {
      if (identical(_cancellation, cancellation)) {
        _cancellation = null;
      }
    }
  }

  void _logFailure(Object error, StackTrace stackTrace) {
    switch (error) {
      case UpdateFeedItemFailure(
        :final link,
        :final stage,
        :final cause,
        :final causeStackTrace,
      ):
        final series = switch (link.series) {
          ExtensionSeriesRef(:final sourceId, :final mangaId) =>
            'sourceId=$sourceId, mangaId=$mangaId',
          ProxySeriesRef(:final proxyId, :final seriesId) =>
            'proxyId=$proxyId, seriesId=$seriesId',
          null => 'series=unresolved',
        };
        logger.e(
          'Web update feed failed during ${stage.name} for '
          'title="${link.title}", $series',
          error: cause,
          stackTrace: causeStackTrace,
        );
      default:
        logger.e(
          'Web update feed failed',
          error: error,
          stackTrace: stackTrace,
        );
    }
  }
}
