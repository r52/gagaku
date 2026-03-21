import 'dart:async';

import 'package:cached_network_image_ce/cached_network_image.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:gagaku/model/model.dart';
import 'package:gagaku/util/http.dart';
import 'package:gagaku/web/model/model.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cached_network_image.g.dart';

class ExtensionHttpClient extends http.BaseClient {
  ExtensionHttpClient(this._inner, this._ref);

  final http.Client _inner;
  final Ref _ref;

  static final Map<String, Future<void>> _activeSolvers = {};
  static final Map<String, Map<String, String>> _domainClearances = {};

  http.Request _copyRequest(
    http.BaseRequest request, [
    Map<String, String>? extraHeaders,
  ]) {
    final newRequest = http.Request(request.method, request.url);
    newRequest.headers.addAll(request.headers);
    if (extraHeaders != null) {
      newRequest.headers.addAll(extraHeaders);
    }

    final gdat = GagakuData();

    // Use dynamically extracted User Agent data natively or fall back to Mar 2026 chrome strings
    newRequest.headers.putIfAbsent(
      'accept',
      () => 'image/avif,image/webp,image/apng,image/svg+xml,image/*,*/*;q=0.8',
    );
    newRequest.headers.putIfAbsent('accept-language', () => 'en-US,en;q=0.9');
    newRequest.headers.putIfAbsent(
      'sec-ch-ua',
      () =>
          gdat.dynamicSecChUa ??
          '"Google Chrome";v="146", "Chromium";v="146", "Not_A Brand";v="24"',
    );
    newRequest.headers.putIfAbsent(
      'sec-ch-ua-mobile',
      () => gdat.dynamicSecChUaMobile ?? '?1',
    );
    newRequest.headers.putIfAbsent(
      'sec-ch-ua-platform',
      () => gdat.dynamicSecChUaPlatform ?? '"Android"',
    );
    newRequest.headers.putIfAbsent('sec-fetch-dest', () => 'image');
    newRequest.headers.putIfAbsent('sec-fetch-mode', () => 'no-cors');
    newRequest.headers.putIfAbsent('sec-fetch-site', () => 'cross-site');

    if (request is http.Request) {
      newRequest.encoding = request.encoding;
      newRequest.bodyBytes = request.bodyBytes;
    }

    return newRequest;
  }

  Future<void> _solveCloudflare(Uri url) async {
    final domain = url.host;

    // Prevent late-arriving failed requests from spawning redundant webviews
    // if the clearance was already magically acquired by an earlier request.
    if (_domainClearances.containsKey(domain)) {
      return;
    }

    if (_activeSolvers.containsKey(domain)) {
      await _activeSolvers[domain];
      return;
    }

    final completer = Completer<void>();
    _activeSolvers[domain] = completer.future;

    HeadlessInAppWebView? headlessWebView;

    // Timeout loop to prevent infinite hangs on unsolvable captchas
    Timer(const Duration(seconds: 15), () {
      if (!completer.isCompleted) {
        headlessWebView?.dispose();
        completer.complete();
      }
    });

    headlessWebView = HeadlessInAppWebView(
      initialUrlRequest: URLRequest(url: WebUri.uri(url)),
      onLoadStop: (controller, url) async {
        if (url == null) return;

        // Check if the current page has cleanly bypassed Cloudflare:
        final script = '''
          (function() {
            return document.contentType && document.contentType.startsWith("image/");
          })();
        ''';

        final result = await controller.evaluateJavascript(source: script);
        final hasPassed = result is bool ? result : false;

        final cookies = await CookieManager.instance().getCookies(
          url: url,
          webViewController: controller,
        );

        final hasClearance = cookies.any(
          (c) => c.name.contains('cf_clearance'),
        );

        // If clearance isn't acquired yet, return early and wait for next redirect
        if (!hasPassed && !hasClearance) {
          return;
        }

        final ua = await controller.evaluateJavascript(
          source: 'navigator.userAgent',
        );

        final cookieString = cookies
            .map((c) => '${c.name}=${c.value}')
            .join('; ');

        _domainClearances[domain] = {
          if (cookieString.isNotEmpty) 'cookie': cookieString,
          if (ua is String) 'user-agent': ua,
        };

        headlessWebView?.dispose();
        if (!completer.isCompleted) completer.complete();
      },
    );

    await headlessWebView.run();
    await completer.future;
    _activeSolvers.remove(domain);
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final domain = request.url.host;

    // Await any actively running solver to politely prevent massive
    // batches of doomed native HTTP requests from firing prematurely.
    if (_activeSolvers.containsKey(domain)) {
      await _activeSolvers[domain];
    }

    final headers = Map<String, String>.from(request.headers);
    final sourceId = headers.remove('x-source-id');

    Map<String, String> extraHeaders = {};

    Future<void> populateHeaders() async {
      if (_domainClearances.containsKey(domain)) {
        extraHeaders.addAll(_domainClearances[domain]!);
      }

      if (sourceId != null && sourceId.isNotEmpty && sourceId != 'gist') {
        final cookies = await _ref
            .read(extensionSourceProvider(sourceId).notifier)
            .getCookies();

        if (cookies != null && cookies.isNotEmpty) {
          final targetHost = request.url.host.toLowerCase();
          final validCookies = cookies.where((c) {
            var d = c.domain?.toLowerCase() ?? '';
            if (d.startsWith('.')) {
              d = d.substring(1);
            }
            return targetHost == d || targetHost.endsWith('.$d');
          }).toList();

          if (validCookies.isNotEmpty) {
            final cookieMap = <String, String>{};

            final existingCookieStr = extraHeaders['cookie'] ?? '';
            if (existingCookieStr.isNotEmpty) {
              for (final pair in existingCookieStr.split(';')) {
                final parts = pair.trim().split('=');
                if (parts.length >= 2) {
                  cookieMap[parts[0]] = parts.sublist(1).join('=');
                }
              }
            }

            for (final c in validCookies) {
              cookieMap[c.name] = c.value.toString();
            }

            extraHeaders['cookie'] = cookieMap.entries
                .map((e) => '${e.key}=${e.value}')
                .join('; ');
          }
        }
      }
    }

    // Initial domain clearance check
    await populateHeaders();

    // Mutate the original request instance's headers so they are properly
    // forwarded to any retries or copy operations.
    request.headers.clear();
    request.headers.addAll(headers);

    final initialRequest = _copyRequest(request, extraHeaders);
    final response = await _inner.send(initialRequest);

    final isHtml =
        response.headers['content-type']?.contains('text/html') == true;
    final isBlocked =
        response.statusCode == 503 || response.statusCode == 403 || isHtml;

    if (isBlocked) {
      // Drain the initial response stream so we don't leak resources
      response.stream.listen((_) {}).cancel();

      await _solveCloudflare(request.url);

      // Add newly solved clearances and ambient cookies
      await populateHeaders();

      final retryRequest = _copyRequest(request, extraHeaders);
      return await _inner.send(retryRequest);
    }

    return response;
  }

  @override
  void close() {
    _inner.close();
    super.close();
  }
}

@Riverpod(keepAlive: true)
BaseCacheManager extensionImageCache(Ref ref) {
  return DefaultCacheManager(
    // ignore: undefined_named_parameter
    httpClientFactory: () => ExtensionHttpClient(RateLimitedClient(), ref),
  );
}
