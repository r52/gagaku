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
  Duration retryDelay = const Duration(seconds: 1),
  void Function(Duration delay)? onRetry,
}) async {
  try {
    return await operation();
  } catch (error, stackTrace) {
    if (!isCloudflareBypassError(error)) {
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  onRetry?.call(retryDelay);
  if (retryDelay > Duration.zero) {
    await Future<void>.delayed(retryDelay);
  }

  try {
    return await operation();
  } catch (error, stackTrace) {
    if (isCloudflareBypassError(error)) {
      Error.throwWithStackTrace(const CloudflareBypassException(), stackTrace);
    }
    Error.throwWithStackTrace(error, stackTrace);
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
