import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  debugPrint(
    "Notification tapped in background: ${notificationResponse.payload}",
  );
}

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();

  factory NotificationService() => _instance;

  late FlutterLocalNotificationsPlugin plugin;

  NotificationService._internal() {
    plugin = FlutterLocalNotificationsPlugin();
    _initializeSettings();
  }

  Future<void> _initializeSettings() async {
    const initializationSettingsAndroid = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    final initializationSettingsDarwin = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    final initializationSettingsWindows = WindowsInitializationSettings(
      appName: 'Gagaku',
      appUserModelId: 'r52.gagaku',
      guid: '71269050-0a69-46f8-8551-f892a76074d9',
    );

    final initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      windows: initializationSettingsWindows,
    );

    await plugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (
        NotificationResponse notificationResponse,
      ) async {
        debugPrint('Notification received: ${notificationResponse.payload}');
      },
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );

    await _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    // For Android
    await plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();

    // For iOS
    await plugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >()
        ?.requestPermissions(alert: true, badge: true, sound: true);
  }

  Future<void> initialize() async {
    _instance._requestPermissions();
  }

  Future<void> updateProgressNotification({
    int? maxProgress,
    int? currentProgress,
    String? title,
    String? body,
  }) async {
    const channelName = 'Gagaku';

    final androidNotificationDetails = AndroidNotificationDetails(
      channelName,
      channelName,
      channelDescription: channelName,
      enableVibration: false,
      visibility: NotificationVisibility.public,
      ongoing: maxProgress != null && currentProgress != null,
      silent: true,
      showProgress: maxProgress != null && currentProgress != null,
      maxProgress: maxProgress ?? 0,
      progress: currentProgress ?? 0,
    );

    const darwinNotificationDetails = DarwinNotificationDetails();

    final notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    try {
      await plugin.show(0, title, body, notificationDetails);
    } catch (ex) {
      debugPrint('Error showing notification: $ex');
    }
  }
}
