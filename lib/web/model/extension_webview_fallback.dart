import 'dart:async';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:gagaku/util/exception.dart';
import 'package:gagaku/web/model/types.dart';

Future<WebViewExecutionResult> executeInTemporaryWebView(
  ExecuteInWebViewContext context,
) async {
  HeadlessInAppWebView? executionView;

  try {
    final executionReadyCompleter = Completer<void>();

    executionView = HeadlessInAppWebView(
      initialData: InAppWebViewInitialData(
        data: context.source.html,
        baseUrl: WebUri(context.source.baseUrl),
      ),
      initialSettings: InAppWebViewSettings(
        loadsImagesAutomatically: context.source.loadImages,
        browserAcceleratorKeysEnabled: false,
        isInspectable: false,
      ),
      onLoadStop: (controller, url) async {
        if (!executionReadyCompleter.isCompleted) {
          executionReadyCompleter.complete();
        }
      },
    );

    await executionView.run();
    await executionReadyCompleter.future.timeout(
      const Duration(seconds: 15),
      onTimeout: () {
        throw TimeoutException('Temporary WebView load timed out');
      },
    );

    final url = WebUri(context.source.baseUrl);
    final cookieManager = CookieManager.instance();

    for (final cookie in context.storage.cookies) {
      await cookieManager.setCookie(
        url: url,
        name: cookie.name,
        value: cookie.value,
        domain: cookie.domain,
        path: cookie.path ?? '/',
        expiresDate: cookie.expires?.millisecondsSinceEpoch,
      );
    }

    final controller = executionView.webViewController!;
    final results = await controller
        .callAsyncJavaScript(functionBody: context.inject)
        .timeout(const Duration(seconds: 30));

    if (results == null || results.error != null) {
      throw JavaScriptException(
        message: 'JavaScript error in executeInWebView:',
        errorMessage: '${context.source.baseUrl} - ${results?.error}',
      );
    }

    final outCookies = await cookieManager.getCookies(
      url: url,
      webViewController: controller,
    );

    final pbCookies = outCookies
        .map(
          (cookie) => PaperbackCookie(
            name: cookie.name,
            value: cookie.value,
            domain: cookie.domain ?? url.host,
            path: cookie.path,
            expires: cookie.expiresDate != null
                ? DateTime.fromMillisecondsSinceEpoch(cookie.expiresDate!)
                : null,
          ),
        )
        .toList();

    return WebViewExecutionResult(
      result: results.value,
      storage: WebViewStorage(cookies: pbCookies),
    );
  } finally {
    executionView?.dispose();
  }
}
