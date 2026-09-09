import 'dart:io';

import 'package:flutter/services.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/util/notification_service.dart';
import 'package:gagaku/web/model/update_feed.dart';

typedef UpdateFeedNotificationReporter =
    Future<void> Function({
      int? maxProgress,
      int? currentProgress,
      String? title,
      String? body,
    });

abstract interface class UpdateFeedExecutionClient {
  Future<void> start(String notificationText);

  Future<void> stop();
}

final class MethodChannelUpdateFeedExecutionClient
    implements UpdateFeedExecutionClient {
  const MethodChannelUpdateFeedExecutionClient();

  static const _channel = MethodChannel('r52.gagaku/update_feed_execution');

  @override
  Future<void> start(String notificationText) {
    return _channel.invokeMethod<void>('start', {
      'notificationText': notificationText,
    });
  }

  @override
  Future<void> stop() {
    return _channel.invokeMethod<void>('stop');
  }
}

final class NativeUpdateFeedPlatform implements UpdateFeedPlatform {
  NativeUpdateFeedPlatform(NotificationService notifications)
    : this._(
        executionClient: const MethodChannelUpdateFeedExecutionClient(),
        isAndroid: Platform.isAndroid,
        initializeNotifications: notifications.initialize,
        reportNotification: notifications.updateProgressNotification,
      );

  NativeUpdateFeedPlatform.test({
    required UpdateFeedExecutionClient executionClient,
    required bool isAndroid,
    required Future<void> Function() initializeNotifications,
    required UpdateFeedNotificationReporter reportNotification,
  }) : this._(
         executionClient: executionClient,
         isAndroid: isAndroid,
         initializeNotifications: initializeNotifications,
         reportNotification: reportNotification,
       );

  NativeUpdateFeedPlatform._({
    required UpdateFeedExecutionClient executionClient,
    required bool isAndroid,
    required Future<void> Function() initializeNotifications,
    required UpdateFeedNotificationReporter reportNotification,
  }) : _executionClient = executionClient,
       _isAndroid = isAndroid,
       _initializeNotifications = initializeNotifications,
       _reportNotification = reportNotification;

  final UpdateFeedExecutionClient _executionClient;
  final bool _isAndroid;
  final Future<void> Function() _initializeNotifications;
  final UpdateFeedNotificationReporter _reportNotification;

  @override
  Future<UpdateFeedExecutionLease> acquire(UpdateFeedMessages messages) async {
    await _initializeNotifications();
    if (!_isAndroid) {
      return const _NoopUpdateFeedExecutionLease();
    }

    await _executionClient.start(messages.updatingFeed);
    return _NativeUpdateFeedExecutionLease(_executionClient);
  }

  @override
  Future<void> reportProgress(
    UpdateFeedProgress progress,
    UpdateFeedMessages messages,
  ) async {
    if (!_isAndroid || progress.currentTitle == null) {
      return;
    }
    await _reportNotification(
      maxProgress: progress.total,
      currentProgress: progress.completed,
      title: messages.updatingFeed,
      body: messages.updatingItem(progress.currentTitle!),
    );
  }

  @override
  Future<void> reportCompleted(UpdateFeedMessages messages) {
    return _reportNotification(
      title: messages.updatingFeed,
      body: messages.done,
    );
  }
}

final class _NoopUpdateFeedExecutionLease implements UpdateFeedExecutionLease {
  const _NoopUpdateFeedExecutionLease();

  @override
  Future<void> release() async {}
}

final class _NativeUpdateFeedExecutionLease
    implements UpdateFeedExecutionLease {
  _NativeUpdateFeedExecutionLease(this._executionClient);

  final UpdateFeedExecutionClient _executionClient;
  bool _released = false;

  @override
  Future<void> release() async {
    if (_released) {
      return;
    }
    _released = true;
    try {
      await _executionClient.stop();
    } catch (error, stackTrace) {
      logger.w(
        'Failed to disable update-feed background execution',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
}
