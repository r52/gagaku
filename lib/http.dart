import 'dart:io';

import 'package:cronet_http/cronet_http.dart';
import 'package:gagaku/model.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:http/retry.dart';

const _baseUserAgent = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:129.0) Gecko/20100101 Firefox/129.0';

http.Client _createHttpClient([bool useCustomUA = false]) {
  final userAgent = useCustomUA ? GagakuData().gagakuUserAgent : _baseUserAgent;

  if (Platform.isAndroid) {
    final engine = CronetEngine.build(cacheMode: CacheMode.memory, cacheMaxSize: 4 * 1024 * 1024, userAgent: userAgent);
    return CronetClient.fromCronetEngine(engine, closeEngine: true);
  }

  return IOClient(HttpClient()..userAgent = userAgent);
}

class RateLimitedClient extends CustomClient {
  static const _rateLimit = Duration(milliseconds: 200); // 5 per second
  final _pendingCalls = <int>[];

  RateLimitedClient({super.useCustomUA});

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final numPending = _pendingCalls.length;
    _pendingCalls.add(request.hashCode);

    final wait = _rateLimit * numPending;
    await Future.delayed(wait);

    return _baseClient.send(request).whenComplete(() {
      _pendingCalls.remove(request.hashCode);
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
          whenError: (error, stacktrace) => error is HttpException || error is http.ClientException,
        );

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    return _baseClient.send(request);
  }
}
