// ignore_for_file: depend_on_referenced_packages, implementation_imports

import 'dart:async';

import 'package:cached_network_image_ce/src/cache/default_cache_manager.dart';
import 'package:cached_network_image_platform_interface_ce/cached_network_image_platform_interface_ce.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:gagaku/model/model.dart';
import 'package:gagaku/util/http.dart';
import 'package:gagaku/util/riverpod.dart';
import 'package:gagaku/web/model/cloudflare.dart';
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
    http.BaseRequest request,
    Map<String, String> sourceHeaders,
    Map<String, String> clearanceHeaders,
  ) {
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
    for (final MapEntry(:key, :value) in sourceHeaders.entries) {
      if (key != 'cookie') {
        newRequest.headers.putIfAbsent(key, () => value);
      }
    }
    newRequest.headers.addAll(clearanceHeaders);

    final mergedCookies = _mergeCookieHeaders(
      _mergeCookieHeaders(requestCookies, sourceHeaders['cookie']),
      clearanceHeaders['cookie'],
    );
    if (mergedCookies != null) {
      newRequest.headers['cookie'] = mergedCookies;
    }

    for (final MapEntry(:key, :value) in _defaultImageHeaders.entries) {
      newRequest.headers.putIfAbsent(key, () => value);
    }

    if (request is http.Request) {
      newRequest.encoding = request.encoding;
      newRequest.bodyBytes = request.bodyBytes;
    }

    return newRequest;
  }

  Future<Map<String, String>> _sourceHeadersFor(
    Uri url,
    String? sourceId,
  ) async {
    if (sourceId == null || sourceId.isEmpty || sourceId == 'gist') {
      return GagakuData().resolveBrowserUserAgentHeaders();
    }

    final provider = extensionSourceProvider(sourceId);
    await _ref.readAsync(provider.future);
    final runtime = await _ref.read(provider.notifier).getRuntime();
    final cookies = runtime.getCookies();
    final cookieHeader = serializeBrowserCookies(
      selectBrowserCookiesForUrl(cookies ?? const [], url).cookies,
    );
    return {...runtime.browserUserAgentHeaders, 'cookie': ?cookieHeader};
  }

  /// Plain HTTP responses only expose the `cf-mitigated` header as a definite
  /// challenge signal. The broader status/content-type fallback also covers
  /// interstitials that do not send it; failed solves are rate-limited per host.
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
    var sourceHeaders = await _sourceHeadersFor(url, sourceId);

    await _cloudflareBypass.waitForActiveSolver(url);

    final response = await _inner.send(
      _buildRequest(request, sourceHeaders, _cloudflareBypass.headersFor(url)),
    );
    if (!_shouldAttemptBypass(response) ||
        _cloudflareBypass.isCoolingDown(url)) {
      return response;
    }

    // Listening and cancelling releases the blocked response connection.
    unawaited(response.stream.listen((_) {}).cancel().catchError((_) {}));

    await _cloudflareBypass.refresh(
      url,
      trigger: isCloudflareChallengeHeaders(response.headers)
          ? 'cf-mitigated'
          : 'fallback',
      statusCode: response.statusCode,
    );

    sourceHeaders = await _sourceHeadersFor(url, sourceId);
    return _inner.send(
      _buildRequest(request, sourceHeaders, _cloudflareBypass.headersFor(url)),
    );
  }

  @override
  void close() {
    _inner.close();
    super.close();
  }
}

class _CloudflareBypass {
  static const _timeout = Duration(seconds: 15);
  static const _failureCooldown = Duration(minutes: 2);
  static const _imageContentTypeScript = '''
    (function() {
      return document.contentType &&
        document.contentType.startsWith("image/");
    })();
  ''';

  final Map<String, Future<void>> _activeSolvers = {};
  final Map<String, Map<String, String>> _clearanceHeaders = {};
  final Map<String, DateTime> _failedSolves = {};

  String _domain(Uri url) => url.host.toLowerCase();

  Map<String, String> headersFor(Uri url) =>
      _clearanceHeaders[_domain(url)] ?? const {};

  Future<void> waitForActiveSolver(Uri url) async {
    final solver = _activeSolvers[_domain(url)];
    if (solver != null) {
      await solver;
    }
  }

  /// Whether a recent solve for this host failed. Solving again immediately
  /// would only repeat the full headless timeout for every image request.
  bool isCoolingDown(Uri url) {
    final failedAt = _failedSolves[_domain(url)];
    return failedAt != null &&
        DateTime.now().difference(failedAt) < _failureCooldown;
  }

  Future<void> refresh(
    Uri url, {
    required String trigger,
    required int statusCode,
  }) async {
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
      final solved = await solver;
      if (solved) {
        _failedSolves.remove(domain);
      } else {
        _failedSolves[domain] = DateTime.now();
      }
      debugPrint(
        'cloudflare[image] time=${cloudflareDiagnosticTimestamp()} '
        'host=$domain trigger=$trigger status=$statusCode solved=$solved',
      );
    } finally {
      if (identical(_activeSolvers[domain], solver)) {
        _activeSolvers.remove(domain);
      }
    }
  }

  Future<bool> _runSolver(Uri url) async {
    final completer = Completer<bool>();
    final targetUrl = WebUri.uri(url);
    final cookieManager = CookieManager.instance();
    Timer? timeout;
    HeadlessInAppWebView? webView;

    void complete(bool solved) {
      if (!completer.isCompleted) {
        completer.complete(solved);
      }
    }

    try {
      timeout = Timer(_timeout, () => complete(false));
      // A stale clearance may be what caused the failed request, so only a
      // clearance that differs from this one proves the challenge was solved.
      final initialClearance = findCloudflareClearance(
        await cookieManager.getCookies(url: targetUrl),
      )?.value;
      webView = HeadlessInAppWebView(
        initialUrlRequest: URLRequest(url: targetUrl),
        onLoadStop: (controller, loadedUrl) async {
          if (loadedUrl == null || completer.isCompleted) {
            return;
          }

          try {
            final isImage =
                await controller.evaluateJavascript(
                  source: _imageContentTypeScript,
                ) ==
                true;
            if (!isImage &&
                (isCloudflareChallengeUrl(loadedUrl) ||
                    isCloudflareChallengeTitle(await controller.getTitle()))) {
              return;
            }
            final cookies = selectBrowserCookiesForUrl(
              await cookieManager.getCookies(
                url: targetUrl,
                webViewController: controller,
              ),
              url,
            ).cookies;
            if (!isImage &&
                !hasNewCloudflareClearance(cookies, initialClearance)) {
              return;
            }

            final browserHeaders = await readBrowserUserAgentHeaders(
              controller,
            );
            if (completer.isCompleted) {
              return;
            }
            final cookieHeader = serializeBrowserCookies(cookies);
            _clearanceHeaders[_domain(url)] = {
              'cookie': ?cookieHeader,
              ...browserHeaders,
            };
            complete(true);
          } catch (_) {
            // A later load event may still finish the challenge successfully.
          }
        },
      );

      await webView.run();
      return await completer.future;
    } finally {
      timeout?.cancel();
      await webView?.dispose();
    }
  }
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
