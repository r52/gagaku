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

class UnknownSourceException implements Exception {
  final String? sourceId;
  final String message;

  UnknownSourceException({required this.message, this.sourceId});

  @override
  String toString() {
    return "$message. Source ID = $sourceId";
  }
}
