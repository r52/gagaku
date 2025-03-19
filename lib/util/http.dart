import 'dart:io';

import 'package:cronet_http/cronet_http.dart';
import 'package:gagaku/model/model.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:http/retry.dart';

const _baseUserAgent =
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:136.0) Gecko/20100101 Firefox/136.0';

String getUserAgent([bool useCustomUA = false]) {
  return useCustomUA ? GagakuData().gagakuUserAgent : _baseUserAgent;
}

http.Client _createHttpClient([bool useCustomUA = false]) {
  final userAgent = getUserAgent(useCustomUA);

  if (Platform.isAndroid) {
    final engine = CronetEngine.build(
      cacheMode: CacheMode.memory,
      cacheMaxSize: 10 * 1024 * 1024,
      userAgent: userAgent,
    );
    return CronetClient.fromCronetEngine(engine, closeEngine: true);
  }

  return IOClient(HttpClient()..userAgent = userAgent);
}

class RateLimitedClient extends CustomClient {
  static const _rateLimit = Duration(milliseconds: 200); // 5 per second
  final _pendingCalls = <String, List<int>>{};

  RateLimitedClient({super.useCustomUA});

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final host = request.url.host;

    if (!_pendingCalls.containsKey(host)) {
      _pendingCalls[host] = [];
    }

    final numPending = _pendingCalls[host]!.length;
    _pendingCalls[host]!.add(request.hashCode);

    final wait = _rateLimit * numPending;
    await Future.delayed(wait);

    return _baseClient.send(request).whenComplete(() {
      _pendingCalls[host]!.remove(request.hashCode);
      if (_pendingCalls[host]!.isEmpty) {
        _pendingCalls.remove(host);
      }
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
