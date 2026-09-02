import 'package:flutter_test/flutter_test.dart';
import 'package:gagaku/web/model/update_feed_foreground.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('starts and stops the native update-feed foreground service', (
    tester,
  ) async {
    const client = MethodChannelUpdateFeedExecutionClient();
    addTearDown(() async {
      await client.stop();
    });

    await client.start('Updating feed');
    await Future<void>.delayed(
      const bool.fromEnvironment('FOREGROUND_SERVICE_PROBE')
          ? const Duration(seconds: 45)
          : const Duration(seconds: 1),
    );
    await client.stop();
  });
}
