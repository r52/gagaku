import 'package:flutter_test/flutter_test.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/web/model/update_feed.dart';
import 'package:gagaku/web/model/update_feed_foreground.dart';
import 'package:logger/logger.dart';

void main() {
  setUpAll(() => logger = Logger(level: Level.off));

  group('NativeUpdateFeedPlatform', () {
    test('starts Android execution and releases it once', () async {
      final client = _FakeExecutionClient();
      var initializationCount = 0;
      final notifications = <Map<String, Object?>>[];
      final platform = NativeUpdateFeedPlatform.test(
        executionClient: client,
        isAndroid: true,
        initializeNotifications: () async => initializationCount++,
        reportNotification:
            ({maxProgress, currentProgress, title, body}) async {
              notifications.add({
                'maxProgress': maxProgress,
                'currentProgress': currentProgress,
                'title': title,
                'body': body,
              });
            },
      );

      final lease = await platform.acquire(_messages);
      await platform.reportProgress(
        const UpdateFeedProgress(
          completed: 2,
          total: 5,
          currentTitle: 'Series',
        ),
        _messages,
      );
      await lease.release();
      await lease.release();

      expect(initializationCount, 1);
      expect(client.startedWith, ['Updating feed']);
      expect(client.stopCount, 1);
      expect(notifications, [
        {
          'maxProgress': 5,
          'currentProgress': 2,
          'title': 'Updating feed',
          'body': 'Updating Series',
        },
      ]);
    });

    test(
      'propagates a native start failure without returning a lease',
      () async {
        final error = StateError('start failed');
        final client = _FakeExecutionClient(startError: error);
        final platform = _platform(client: client, isAndroid: true);

        await expectLater(platform.acquire(_messages), throwsA(same(error)));

        expect(client.stopCount, 0);
      },
    );

    test(
      'treats native stop failure as best-effort and remains idempotent',
      () async {
        final client = _FakeExecutionClient(
          stopError: StateError('stop failed'),
        );
        final platform = _platform(client: client, isAndroid: true);
        final lease = await platform.acquire(_messages);

        await lease.release();
        await lease.release();

        expect(client.stopCount, 1);
      },
    );

    test('uses a no-op execution lease off Android', () async {
      final client = _FakeExecutionClient();
      var initializationCount = 0;
      final platform = _platform(
        client: client,
        isAndroid: false,
        onInitialize: () => initializationCount++,
      );

      final lease = await platform.acquire(_messages);
      await lease.release();

      expect(initializationCount, 1);
      expect(client.startedWith, isEmpty);
      expect(client.stopCount, 0);
    });
  });
}

NativeUpdateFeedPlatform _platform({
  required _FakeExecutionClient client,
  required bool isAndroid,
  void Function()? onInitialize,
}) {
  return NativeUpdateFeedPlatform.test(
    executionClient: client,
    isAndroid: isAndroid,
    initializeNotifications: () async => onInitialize?.call(),
    reportNotification: ({maxProgress, currentProgress, title, body}) async {},
  );
}

final class _FakeExecutionClient implements UpdateFeedExecutionClient {
  _FakeExecutionClient({this.startError, this.stopError});

  final Object? startError;
  final Object? stopError;
  final List<String> startedWith = [];
  int stopCount = 0;

  @override
  Future<void> start(String notificationText) async {
    startedWith.add(notificationText);
    if (startError case final error?) {
      throw error;
    }
  }

  @override
  Future<void> stop() async {
    stopCount++;
    if (stopError case final error?) {
      throw error;
    }
  }
}

final _messages = UpdateFeedMessages(
  updatingFeed: 'Updating feed',
  done: 'Done',
  updatingItem: (title) => 'Updating $title',
);
