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
    final result = await retryCloudflareRead(
      () async {
        attempts++;
        if (attempts == 1) {
          throw _RuntimeCloudflareError();
        }
        return 'ready';
      },
      retryDelay: Duration.zero,
      onRetry: (delay) => observedDelay = delay,
    );

    expect(result, 'ready');
    expect(attempts, 2);
    expect(observedDelay, Duration.zero);
  });

  test('retryCloudflareRead converts a persistent rejection', () async {
    var attempts = 0;

    await expectLater(
      retryCloudflareRead<void>(() async {
        attempts++;
        throw _RuntimeCloudflareError();
      }, retryDelay: Duration.zero),
      throwsA(isA<CloudflareBypassException>()),
    );

    expect(attempts, 2);
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
