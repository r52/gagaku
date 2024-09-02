import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:package_info_plus/package_info_plus.dart';

const _baseUserAgent = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:129.0) Gecko/20100101 Firefox/129.0';

class RateLimitedClient extends http.BaseClient {
  final http.Client _baseClient = RetryClient(
    http.Client(),
    retries: 2,
    when: (response) => false,
    whenError: (error, stacktrace) => error is HttpException || error is http.ClientException,
  );
  final Future<String> _userAgent;

  static const _rateLimit = Duration(milliseconds: 200); // 5 per second
  final _pendingCalls = <int>[];

  RateLimitedClient({useCustomUA = false})
      : _userAgent = useCustomUA
            ? PackageInfo.fromPlatform().then((info) => '${info.appName}/${info.version}')
            : Future.value(_baseUserAgent);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final numPending = _pendingCalls.length;
    _pendingCalls.add(request.hashCode);

    final wait = _rateLimit * numPending;
    await Future.delayed(wait);

    request.headers[HttpHeaders.userAgentHeader] = await _userAgent;
    return _baseClient.send(request).whenComplete(() {
      _pendingCalls.remove(request.hashCode);
    });
  }
}

class CustomClient extends http.BaseClient {
  final http.Client _baseClient = RetryClient(
    http.Client(),
    retries: 2,
    when: (response) => false,
    whenError: (error, stacktrace) => error is HttpException || error is http.ClientException,
  );
  final Future<String> _userAgent;

  CustomClient({useCustomUA = false})
      : _userAgent = useCustomUA
            ? PackageInfo.fromPlatform().then((info) => '${info.appName}/${info.version}')
            : Future.value(_baseUserAgent);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    request.headers[HttpHeaders.userAgentHeader] = await _userAgent;
    return _baseClient.send(request);
  }
}
