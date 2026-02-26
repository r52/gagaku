import 'dart:io';

import 'package:cronet_http/cronet_http.dart';
import 'package:dio/dio.dart';
import 'package:gagaku/model/model.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:http/retry.dart';
import 'package:pool/pool.dart';

const baseUserAgent =
    'Mozilla/5.0 (Linux; Android 16) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.7559.110 Mobile Safari/537.36';

const _maxConcurrentRequests = 5;
const _minRequestInterval = Duration(milliseconds: 200);
final _nextRequestTimes = <String, int>{};
final _pools = <String, Pool>{};

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

Future<void> _staggerRequest(String host) async {
  final now = DateTime.now().millisecondsSinceEpoch;
  var targetTime = _nextRequestTimes[host] ?? now;

  if (targetTime < now) {
    targetTime = now;
  }

  _nextRequestTimes[host] = targetTime + _minRequestInterval.inMilliseconds;

  final waitTime = targetTime - now;

  if (waitTime > 0) {
    await Future.delayed(Duration(milliseconds: waitTime));
  }
}

class RateLimitedClient extends http.BaseClient {
  final http.Client _baseClient;

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
    await _staggerRequest(host);

    final pool = _pools.putIfAbsent(host, () => Pool(_maxConcurrentRequests));
    return pool.withResource(() async {
      return await _baseClient.send(request);
    });
  }

  @override
  void close() {
    _baseClient.close();
  }
}

class RateLimitingInterceptor extends Interceptor {
  final _heldResources = <RequestOptions, PoolResource>{};

  RateLimitingInterceptor();

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final host = options.uri.host;
    await _staggerRequest(host);

    final pool = _pools.putIfAbsent(host, () => Pool(_maxConcurrentRequests));
    final resource = await pool.request();
    _heldResources[options] = resource;

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _releaseResource(response.requestOptions);
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _releaseResource(err.requestOptions);
    handler.next(err);
  }

  void _releaseResource(RequestOptions options) {
    final resource = _heldResources.remove(options);
    resource?.release();
  }
}
