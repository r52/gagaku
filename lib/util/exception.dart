class ApiException implements Exception {
  final int? statusCode;
  final String? statusMessage;
  final String message;

  ApiException({required this.message, this.statusCode, this.statusMessage});

  @override
  String toString() {
    if (statusCode != null) {
      return "$message\nServer returned response code $statusCode: $statusMessage";
    }
    return message;
  }
}

class JavaScriptException implements Exception {
  final String? errorMessage;
  final String message;

  JavaScriptException({required this.message, this.errorMessage});

  @override
  String toString() {
    return "$message $errorMessage";
  }
}

class InvalidDataException implements Exception {
  final String message;

  InvalidDataException(this.message);

  @override
  String toString() {
    return message;
  }
}

class CloudflareBypassException implements Exception {
  const CloudflareBypassException();

  @override
  String toString() => 'Cloudflare challenge requires manual resolution';
}

bool isCloudflareBypassError(Object error) {
  if (error is CloudflareBypassException) {
    return true;
  }

  return error.toString().toLowerCase().contains(
    'cloudflare bypass is required',
  );
}

Future<T> retryCloudflareRead<T>(
  Future<T> Function() operation, {
  List<Duration> retryDelays = const [
    Duration(seconds: 2),
    Duration(seconds: 6),
    Duration(seconds: 15),
  ],
  void Function(int nextAttempt, Duration delay)? onRetry,
}) async {
  for (var attempt = 1; ; attempt++) {
    try {
      return await operation();
    } catch (error, stackTrace) {
      if (!isCloudflareBypassError(error)) {
        Error.throwWithStackTrace(error, stackTrace);
      }

      if (attempt > retryDelays.length) {
        Error.throwWithStackTrace(
          const CloudflareBypassException(),
          stackTrace,
        );
      }

      final delay = retryDelays[attempt - 1];
      onRetry?.call(attempt + 1, delay);
      if (delay > Duration.zero) {
        await Future<void>.delayed(delay);
      }
    }
  }
}

class UnknownSourceException implements Exception {
  final String? sourceId;
  final String message;

  UnknownSourceException({required this.message, this.sourceId});

  @override
  String toString() {
    return "$message. Source ID = $sourceId";
  }
}
