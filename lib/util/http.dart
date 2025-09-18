import 'dart:io';

import 'package:cronet_http/cronet_http.dart';
import 'package:dio/dio.dart';
import 'package:gagaku/model/model.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:http/retry.dart';

const baseUserAgent =
    'Mozilla/5.0 (Linux; Android 16) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.7339.52 Mobile Safari/537.36';

String getUserAgent([bool useCustomUA = false]) {
  return useCustomUA ? GagakuData().gagakuUserAgent : baseUserAgent;
}

CronetEngine createCronetEngine(String userAgent) => CronetEngine.build(
  cacheMode: CacheMode.memory,
  cacheMaxSize: 10 * 1024 * 1024,
  userAgent: userAgent,
);

http.Client _createHttpClient([bool useCustomUA = false]) {
  final userAgent = getUserAgent(useCustomUA);

  if (Platform.isAndroid) {
    final engine = createCronetEngine(userAgent);
    return CronetClient.fromCronetEngine(engine, closeEngine: true);
  }

  return IOClient(HttpClient()..userAgent = userAgent);
}

class RateLimitedClient extends http.BaseClient {
  static const _maxConcurrentRequests = 5;
  static const _buffer = Duration(milliseconds: 500);
  static const _rateLimit = Duration(milliseconds: 250);

  final http.Client _baseClient;

  final _pendingCalls = <String, List<String>>{};

  RateLimitedClient({bool useCustomUA = false})
    : _baseClient = RetryClient(
        _createHttpClient(useCustomUA),
        retries: 2,
        when: (response) => false,
        whenError: (error, stacktrace) =>
            error is HttpException || error is http.ClientException,
      );

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

    final response = await _baseClient.send(request);

    _pendingCalls[host]!.remove(request.toString());
    // logger.d(
    //   'RateLimit: PendingCalls[$host] = ${_pendingCalls[host]!.length}',
    // );

    return response;
  }
}

class RateLimitingInterceptor extends QueuedInterceptor {
  static const _maxConcurrentRequests = 5;
  static const _buffer = Duration(milliseconds: 500);
  static const _rateLimit = Duration(milliseconds: 250);

  final _pendingCalls = <String, List<String>>{};

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final host = options.uri.host;

    if (!_pendingCalls.containsKey(host)) {
      _pendingCalls[host] = [];
    }

    if (_pendingCalls[host]!.length >= _maxConcurrentRequests) {
      while (_pendingCalls[host]!.length >= _maxConcurrentRequests) {
        await Future.delayed(_buffer);
      }
    }

    final numPending = _pendingCalls[host]!.length;
    _pendingCalls[host]!.add(options.uri.toString());

    final wait = _rateLimit * numPending;
    await Future.delayed(wait);

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final host = response.requestOptions.uri.host;

    _pendingCalls[host]!.remove(response.requestOptions.uri.toString());

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final host = err.requestOptions.uri.host;

    _pendingCalls[host]!.remove(err.requestOptions.uri.toString());

    handler.next(err);
  }
}
