// ignore_for_file: depend_on_referenced_packages, implementation_imports

import 'dart:async';

import 'package:cached_network_image_ce/src/cache/default_cache_manager.dart';
import 'package:cached_network_image_platform_interface_ce/cached_network_image_platform_interface_ce.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:gagaku/model/model.dart';
import 'package:gagaku/util/http.dart';
import 'package:gagaku/util/riverpod.dart';
import 'package:gagaku/web/model/model.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cached_network_image.g.dart';

class ExtensionHttpClient extends http.BaseClient {
  ExtensionHttpClient(this._inner, this._ref);

  static const _sourceIdHeader = 'x-source-id';
  static const _defaultImageHeaders = {
    'accept':
        'image/avif,image/webp,image/apng,image/svg+xml,image/*,*/*;q=0.8',
    'accept-language': 'en-US,en;q=0.9',
    'sec-fetch-dest': 'image',
    'sec-fetch-mode': 'no-cors',
    'sec-fetch-site': 'cross-site',
  };
  static final _cloudflareBypass = _CloudflareBypass();

  final http.Client _inner;
  final Ref _ref;

  http.Request _buildRequest(
    http.BaseRequest request, [
    Map<String, String> extraHeaders = const {},
  ]) {
    final newRequest = http.Request(request.method, request.url);

    newRequest
      ..followRedirects = request.followRedirects
      ..maxRedirects = request.maxRedirects
      ..persistentConnection = request.persistentConnection;

    for (final MapEntry(:key, :value) in request.headers.entries) {
      if (key.toLowerCase() != _sourceIdHeader) {
        newRequest.headers[key] = value;
      }
    }

    final requestCookies = newRequest.headers['cookie'];
    final extraCookies = extraHeaders['cookie'];
    newRequest.headers.addAll(extraHeaders);

    final mergedCookies = _mergeCookieHeaders(requestCookies, extraCookies);
    if (mergedCookies != null) {
      newRequest.headers['cookie'] = mergedCookies;
    }

    final browserHeaders = GagakuData().browserUserAgentHeaders;
    for (final MapEntry(:key, :value) in _defaultImageHeaders.entries) {
      newRequest.headers.putIfAbsent(key, () => value);
    }
    for (final key in const [
      'sec-ch-ua',
      'sec-ch-ua-mobile',
      'sec-ch-ua-platform',
    ]) {
      newRequest.headers.putIfAbsent(key, () => browserHeaders[key]!);
    }

    if (request is http.Request) {
      newRequest.encoding = request.encoding;
      newRequest.bodyBytes = request.bodyBytes;
    }

    return newRequest;
  }

  Future<Map<String, String>> _extraHeadersFor(
    Uri url,
    String? sourceId,
  ) async {
    final clearanceHeaders = _cloudflareBypass.headersFor(url);
    final extensionCookies = await _extensionCookieHeader(url, sourceId);
    final cookies = _mergeCookieHeaders(
      extensionCookies,
      clearanceHeaders['cookie'],
    );

    return {
      for (final MapEntry(:key, :value) in clearanceHeaders.entries)
        if (key != 'cookie') key: value,
      'cookie': ?cookies,
    };
  }

  Future<String?> _extensionCookieHeader(Uri url, String? sourceId) async {
    if (sourceId == null || sourceId.isEmpty || sourceId == 'gist') {
      return null;
    }

    final provider = extensionSourceProvider(sourceId);
    await _ref.readAsync(provider.future);
    final cookies = await _ref.read(provider.notifier).getCookies();

    final applicableCookies = cookies?.where(
      (cookie) => _cookieAppliesTo(cookie, url),
    );
    return _serializeCookies(applicableCookies ?? const []);
  }

  static bool _shouldAttemptBypass(http.StreamedResponse response) {
    final contentType = response.headers['content-type']?.toLowerCase();
    return response.statusCode == 403 ||
        response.statusCode == 503 ||
        contentType?.contains('text/html') == true;
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final url = request.url;
    final sourceId = request.headers[_sourceIdHeader];

    await _cloudflareBypass.waitForActiveSolver(url);

    var extraHeaders = await _extraHeadersFor(url, sourceId);
    final response = await _inner.send(_buildRequest(request, extraHeaders));
    if (!_shouldAttemptBypass(response)) {
      return response;
    }

    // Listening and cancelling releases the blocked response connection.
    unawaited(response.stream.listen((_) {}).cancel().catchError((_) {}));

    await _cloudflareBypass.refresh(url);

    extraHeaders = await _extraHeadersFor(url, sourceId);
    return _inner.send(_buildRequest(request, extraHeaders));
  }

  @override
  void close() {
    _inner.close();
    super.close();
  }
}

class _CloudflareBypass {
  static const _timeout = Duration(seconds: 15);
  static const _imageContentTypeScript = '''
    (function() {
      return document.contentType &&
        document.contentType.startsWith("image/");
    })();
  ''';

  final Map<String, Future<void>> _activeSolvers = {};
  final Map<String, Map<String, String>> _clearanceHeaders = {};

  String _domain(Uri url) => url.host.toLowerCase();

  Map<String, String> headersFor(Uri url) =>
      _clearanceHeaders[_domain(url)] ?? const {};

  Future<void> waitForActiveSolver(Uri url) async {
    final solver = _activeSolvers[_domain(url)];
    if (solver != null) {
      await solver;
    }
  }

  Future<void> refresh(Uri url) async {
    final domain = _domain(url);
    final activeSolver = _activeSolvers[domain];
    if (activeSolver != null) {
      await activeSolver;
      return;
    }

    _clearanceHeaders.remove(domain);

    final solver = _runSolver(url);
    _activeSolvers[domain] = solver;
    try {
      await solver;
    } finally {
      if (identical(_activeSolvers[domain], solver)) {
        _activeSolvers.remove(domain);
      }
    }
  }

  Future<void> _runSolver(Uri url) async {
    final completer = Completer<void>();
    final targetUrl = WebUri.uri(url);
    Timer? timeout;
    HeadlessInAppWebView? webView;

    void complete() {
      if (!completer.isCompleted) {
        completer.complete();
      }
    }

    try {
      timeout = Timer(_timeout, complete);
      webView = HeadlessInAppWebView(
        initialUrlRequest: URLRequest(url: targetUrl),
        onLoadStop: (controller, loadedUrl) async {
          if (loadedUrl == null || completer.isCompleted) {
            return;
          }

          try {
            final result = await controller.evaluateJavascript(
              source: _imageContentTypeScript,
            );
            final cookies = await CookieManager.instance().getCookies(
              url: targetUrl,
              webViewController: controller,
            );
            final hasClearance = cookies.any(
              (cookie) => cookie.name == 'cf_clearance',
            );

            if (result != true && !hasClearance) {
              return;
            }

            final userAgent = await controller.evaluateJavascript(
              source: 'navigator.userAgent',
            );
            final cookieHeader = _serializeCookies(cookies);
            _clearanceHeaders[_domain(url)] = {
              'cookie': ?cookieHeader,
              if (userAgent is String) 'user-agent': userAgent,
            };
            complete();
          } catch (_) {
            // A later load event may still finish the challenge successfully.
          }
        },
      );

      await webView.run();
      await completer.future;
    } finally {
      timeout?.cancel();
      await webView?.dispose();
    }
  }
}

bool _cookieAppliesTo(Cookie cookie, Uri url) {
  final value = cookie.value;
  if (value == null) {
    return false;
  }

  final expiresDate = cookie.expiresDate;
  if (expiresDate != null &&
      expiresDate <= DateTime.now().millisecondsSinceEpoch) {
    return false;
  }

  if (cookie.isSecure == true && url.scheme.toLowerCase() != 'https') {
    return false;
  }

  var domain = cookie.domain?.toLowerCase() ?? '';
  if (domain.startsWith('.')) {
    domain = domain.substring(1);
  }
  if (domain.isEmpty) {
    return false;
  }

  final host = url.host.toLowerCase();
  if (host != domain && !host.endsWith('.$domain')) {
    return false;
  }

  final cookiePath = cookie.path;
  if (cookiePath == null || cookiePath.isEmpty || cookiePath == '/') {
    return true;
  }

  final requestPath = url.path.isEmpty ? '/' : url.path;
  if (requestPath == cookiePath) {
    return true;
  }
  if (!requestPath.startsWith(cookiePath)) {
    return false;
  }
  return cookiePath.endsWith('/') ||
      requestPath.substring(cookiePath.length).startsWith('/');
}

String? _serializeCookies(Iterable<Cookie> cookies) {
  final values = [
    for (final cookie in cookies)
      if (cookie.value != null) '${cookie.name}=${cookie.value}',
  ];
  return values.isEmpty ? null : values.join('; ');
}

String? _mergeCookieHeaders(String? base, String? overlay) {
  final cookies = <String, String>{};

  void addCookies(String? header) {
    if (header == null || header.isEmpty) {
      return;
    }

    for (final segment in header.split(';')) {
      final pair = segment.trim();
      final separator = pair.indexOf('=');
      if (separator <= 0) {
        continue;
      }
      cookies[pair.substring(0, separator)] = pair.substring(separator + 1);
    }
  }

  addCookies(base);
  addCookies(overlay);

  if (cookies.isEmpty) {
    return null;
  }
  return cookies.entries
      .map((entry) => '${entry.key}=${entry.value}')
      .join('; ');
}

@Riverpod(keepAlive: true)
BaseCacheManager extensionImageCache(Ref ref) {
  return DefaultCacheManager(
    httpClientFactory: () => ExtensionHttpClient(RateLimitedClient(), ref),
  );
}
