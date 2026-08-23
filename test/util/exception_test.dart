import 'package:flutter_test/flutter_test.dart';
import 'package:gagaku/util/exception.dart';

class _RuntimeCloudflareError implements Exception {
  @override
  String toString() =>
      'Runtime error: Error: Cloudflare bypass is required\ninterceptResponse';
}

void main() {
  test('retryCloudflareRead retries a transient extension rejection', () async {
    var attempts = 0;

    Duration? observedDelay;
    int? observedAttempt;
    final result = await retryCloudflareRead(
      () async {
        attempts++;
        if (attempts == 1) {
          throw _RuntimeCloudflareError();
        }
        return 'ready';
      },
      retryDelays: const [Duration.zero],
      onRetry: (attempt, delay) {
        observedAttempt = attempt;
        observedDelay = delay;
      },
    );

    expect(result, 'ready');
    expect(attempts, 2);
    expect(observedAttempt, 2);
    expect(observedDelay, Duration.zero);
  });

  test('retryCloudflareRead follows the bounded retry schedule', () async {
    var attempts = 0;
    final retries = <(int, Duration)>[];

    await expectLater(
      retryCloudflareRead<void>(
        () async {
          attempts++;
          throw _RuntimeCloudflareError();
        },
        retryDelays: const [Duration.zero, Duration.zero],
        onRetry: (attempt, delay) {
          retries.add((attempt, delay));
        },
      ),
      throwsA(isA<CloudflareBypassException>()),
    );

    expect(attempts, 3);
    expect(retries, [(2, Duration.zero), (3, Duration.zero)]);
  });

  test('retryCloudflareRead does not retry unrelated errors', () async {
    var attempts = 0;

    await expectLater(
      retryCloudflareRead<void>(() async {
        attempts++;
        throw StateError('unrelated');
      }),
      throwsStateError,
    );

    expect(attempts, 1);
  });
}
