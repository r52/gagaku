import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/model/model.dart';
import 'package:gagaku/web/model/cloudflare.dart';
import 'package:gagaku/web/model/types.dart';

class ExtensionBrowserPage extends StatefulWidget {
  ExtensionBrowserPage({
    super.key,
    required this.source,
    this.cloudflareResolution = false,
  }) : assert(source.baseUrl != null && source.baseUrl!.isNotEmpty);

  final WebSourceInfo source;
  final bool cloudflareResolution;

  @override
  State<ExtensionBrowserPage> createState() => _ExtensionBrowserPageState();
}

class _ExtensionBrowserPageState extends State<ExtensionBrowserPage> {
  InAppWebViewController? _controller;
  double _progress = 0;
  bool _completing = false;
  late String _currentUrl;
  late final InAppWebViewSettings _webViewSettings;

  @override
  void initState() {
    super.initState();
    _currentUrl = widget.source.baseUrl!;
    _webViewSettings = _createSettings();
  }

  InAppWebViewSettings _createSettings() {
    final contentBlockers = <ContentBlocker>[];
    if (defaultTargetPlatform == TargetPlatform.android) {
      for (final filter in GagakuData().blockers) {
        contentBlockers.add(
          ContentBlocker(
            trigger: ContentBlockerTrigger(urlFilter: filter),
            action: ContentBlockerAction(type: ContentBlockerActionType.BLOCK),
          ),
        );
      }
    }

    return InAppWebViewSettings(
      contentBlockers: contentBlockers.isEmpty ? null : contentBlockers,
      browserAcceleratorKeysEnabled: false,
      isInspectable: false,
    );
  }

  void _updateUrl(WebUri? url) {
    if (url == null || !mounted) {
      return;
    }

    setState(() {
      _currentUrl = url.toString();
    });
  }

  String _cookieSignature(List<Cookie> cookies) {
    final values = [
      for (final cookie in cookies)
        '${cookie.name}\u0000${cookie.value}\u0000${cookie.domain}\u0000'
            '${cookie.path}\u0000${cookie.expiresDate}\u0000${cookie.isSecure}',
    ]..sort();
    return values.join('\u0001');
  }

  Future<List<Cookie>> _readStableCookies(
    InAppWebViewController controller,
  ) async {
    final cookieManager = CookieManager.instance();
    final baseUrl = WebUri(widget.source.baseUrl!);
    List<Cookie> cookies = const [];
    String? previousSignature;

    for (var attempt = 0; attempt < 3; attempt++) {
      cookies = await cookieManager.getCookies(
        url: baseUrl,
        webViewController: controller,
      );
      final signature = _cookieSignature(cookies);
      if (signature == previousSignature) {
        break;
      }
      previousSignature = signature;
      if (attempt < 2) {
        await Future<void>.delayed(const Duration(milliseconds: 250));
      }
    }

    return cookies;
  }

  Future<Map<String, String>> _readLocalStorage(
    InAppWebViewController controller,
  ) async {
    final encoded = await controller.evaluateJavascript(
      source:
          'JSON.stringify(Object.fromEntries(Object.entries(localStorage)))',
    );
    if (encoded is! String) {
      return const {};
    }

    final values = jsonDecode(encoded);
    if (values is! Map) {
      return const {};
    }

    return {
      for (final MapEntry(:key, :value) in values.entries)
        key.toString(): value.toString(),
    };
  }

  Future<void> _completeCloudflareResolution() async {
    final controller = _controller;
    if (controller == null || _completing) {
      return;
    }

    setState(() => _completing = true);
    try {
      final rawCookies = await _readStableCookies(controller);
      final cookieSelection = selectBrowserCookiesForUrl(
        rawCookies,
        Uri.parse(widget.source.baseUrl!),
      );
      debugPrint(
        'cloudflare[${widget.source.id}] '
        'time=${cloudflareDiagnosticTimestamp()} manual cookie selection '
        'input=${cookieSelection.inputCount} '
        'selected=${cookieSelection.cookies.length} '
        'discarded=${cookieSelection.discardedCount} '
        'duplicateNames=${cookieSelection.duplicateNames}',
      );
      final localStorage = await _readLocalStorage(controller);
      final userAgentHeaders = await readBrowserUserAgentHeaders(controller);
      final userAgent = userAgentHeaders['user-agent'];
      debugPrint(
        'cloudflare[${widget.source.id}] '
        'time=${cloudflareDiagnosticTimestamp()} manual browser state '
        'clearanceFingerprint='
        '${cloudflareClearanceFingerprint(cookieSelection.cookies)} '
        'userAgentFingerprint='
        '${userAgent == null ? null : diagnosticUserAgentFingerprint(userAgent)}',
      );
      if (!mounted) {
        return;
      }

      Navigator.of(context).pop(
        CloudflareBrowserState(
          cookies: cookieSelection.cookies,
          localStorage: localStorage,
          userAgentHeaders: userAgentHeaders,
        ),
      );
    } catch (_) {
      if (!mounted) {
        return;
      }
      setState(() => _completing = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.t.webSources.source.cloudflareCaptureFailed),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final tr = context.t;

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => Navigator.of(context).pop()),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.source.name, overflow: TextOverflow.ellipsis),
            Text(
              _currentUrl,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        actions: [
          if (widget.cloudflareResolution)
            if (_completing)
              const Padding(
                padding: EdgeInsets.all(14),
                child: SizedBox.square(
                  dimension: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              )
            else
              IconButton(
                icon: const Icon(Icons.check),
                tooltip: tr.webSources.source.cloudflareComplete,
                onPressed: _controller == null
                    ? null
                    : _completeCloudflareResolution,
              ),
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: tr.webSources.source.reloadWebsite,
            onPressed: () => _controller?.reload(),
          ),
        ],
      ),
      body: Column(
        children: [
          if (widget.cloudflareResolution)
            Material(
              color: Theme.of(context).colorScheme.secondaryContainer,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    const Icon(Icons.security),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(tr.webSources.source.cloudflareInstructions),
                    ),
                  ],
                ),
              ),
            ),
          Expanded(
            child: Stack(
              children: [
                InAppWebView(
                  initialUrlRequest: URLRequest(
                    url: WebUri(widget.source.baseUrl!),
                  ),
                  initialSettings: _webViewSettings,
                  onWebViewCreated: (controller) {
                    _controller = controller;
                  },
                  onLoadStart: (controller, url) => _updateUrl(url),
                  onLoadStop: (controller, url) => _updateUrl(url),
                  onUpdateVisitedHistory: (controller, url, isReload) {
                    _updateUrl(url);
                  },
                  onProgressChanged: (controller, progress) {
                    if (!mounted) {
                      return;
                    }
                    setState(() {
                      _progress = progress / 100;
                    });
                  },
                ),
                if (_progress < 1)
                  Align(
                    alignment: Alignment.topCenter,
                    child: LinearProgressIndicator(
                      value: _progress == 0 ? null : _progress,
                      minHeight: 2,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
