import 'package:flutter_background/flutter_background.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/util/notification_service.dart';
import 'package:gagaku/util/util.dart';
import 'package:gagaku/web/model/update_feed.dart';

final class FlutterBackgroundUpdateFeedPlatform implements UpdateFeedPlatform {
  FlutterBackgroundUpdateFeedPlatform(this._notifications);

  final NotificationService _notifications;

  @override
  Future<bool> hasBackgroundPermissions() async {
    if (!DeviceContext.isMobile()) {
      return true;
    }
    return FlutterBackground.hasPermissions;
  }

  @override
  Future<UpdateFeedExecutionLease> acquire(UpdateFeedMessages messages) async {
    await _notifications.initialize();
    if (!DeviceContext.isMobile()) {
      return const _NoopUpdateFeedExecutionLease();
    }

    final initialized = await FlutterBackground.initialize(
      androidConfig: FlutterBackgroundAndroidConfig(
        notificationTitle: 'Gagaku',
        notificationText: messages.updatingFeed,
        notificationIcon: AndroidResource(name: 'background_icon'),
        notificationImportance: AndroidNotificationImportance.normal,
        enableWifiLock: true,
        showBadge: true,
      ),
    );
    if (!initialized) {
      throw StateError('Background execution permission was denied');
    }

    final enabled = await FlutterBackground.enableBackgroundExecution();
    if (!enabled) {
      throw StateError('Failed to enable background execution');
    }
    return const _FlutterBackgroundUpdateFeedExecutionLease();
  }

  @override
  Future<void> reportProgress(
    UpdateFeedProgress progress,
    UpdateFeedMessages messages,
  ) async {
    if (!DeviceContext.isMobile() || progress.currentTitle == null) {
      return;
    }
    await _notifications.updateProgressNotification(
      maxProgress: progress.total,
      currentProgress: progress.completed,
      title: messages.updatingFeed,
      body: messages.updatingItem(progress.currentTitle!),
    );
  }

  @override
  Future<void> reportCompleted(UpdateFeedMessages messages) {
    return _notifications.updateProgressNotification(
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

final class _FlutterBackgroundUpdateFeedExecutionLease
    implements UpdateFeedExecutionLease {
  const _FlutterBackgroundUpdateFeedExecutionLease();

  @override
  Future<void> release() async {
    try {
      await FlutterBackground.disableBackgroundExecution();
    } catch (error, stackTrace) {
      logger.w(
        'Failed to disable update-feed background execution',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
}
