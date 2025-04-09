import 'dart:io';

import 'package:gagaku/model/model.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:rhttp/rhttp.dart';

const _baseUserAgent =
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:137.0) Gecko/20100101 Firefox/137.0';

// global base shared client with no custom UA
final baseGagakuClient = RateLimitedClient();

String getUserAgent([bool useCustomUA = false]) {
  return useCustomUA ? GagakuData().gagakuUserAgent : _baseUserAgent;
}

http.Client _createHttpClient([bool useCustomUA = false]) {
  final userAgent = getUserAgent(useCustomUA);

  return RhttpCompatibleClient.createSync(
    settings: ClientSettings(
      timeoutSettings: TimeoutSettings(connectTimeout: Duration(seconds: 5)),
      userAgent: userAgent,
    ),
  );
}

class RateLimitedClient extends CustomClient {
  static const _maxConcurrentRequests = 5;
  static const _buffer = Duration(milliseconds: 500);
  static const _rateLimit = Duration(milliseconds: 250);
  final _pendingCalls = <String, List<String>>{};

  RateLimitedClient({super.useCustomUA});

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final host = request.url.host;

    if (!_pendingCalls.containsKey(host)) {
      _pendingCalls[host] = [];
    }

    if (_pendingCalls[host]!.length >= _maxConcurrentRequests) {
      // logger.d(
      //   'RateLimit: Max concurrent requests reached for host: $host. Waiting...',
      // );
      while (_pendingCalls[host]!.length >= _maxConcurrentRequests) {
        await Future.delayed(_buffer);
      }
    }

    final numPending = _pendingCalls[host]!.length;
    _pendingCalls[host]!.add(request.toString());
    // logger.d('RateLimit: PendingCalls[$host] = ${_pendingCalls[host]!.length}');

    final wait = _rateLimit * numPending;
    await Future.delayed(wait);

    return _baseClient
        .send(request)
        .timeout(const Duration(seconds: 10))
        .whenComplete(() {
          _pendingCalls[host]!.remove(request.toString());
          // logger.d(
          //   'RateLimit: PendingCalls[$host] = ${_pendingCalls[host]!.length}',
          // );
        });
  }
}

class CustomClient extends http.BaseClient {
  final http.Client _baseClient;

  CustomClient({bool useCustomUA = false})
    : _baseClient = RetryClient(
        _createHttpClient(useCustomUA),
        retries: 2,
        when: (response) => false,
        whenError:
            (error, stacktrace) =>
                error is HttpException || error is http.ClientException,
      );

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    return _baseClient.send(request);
  }
}
