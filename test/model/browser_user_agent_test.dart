import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gagaku/model/model.dart';

void main() {
  group('deriveBrowserUserAgentHeaders', () {
    test('derives Android WebView hints from its runtime user agent', () {
      const userAgent =
          'Mozilla/5.0 (Linux; Android 17; sdk_gphone16k_x86_64 '
          'Build/CP31.260623.012; wv) AppleWebKit/537.36 '
          '(KHTML, like Gecko) Version/4.0 Chrome/149.0.7827.5 '
          'Mobile Safari/537.36';

      expect(deriveBrowserUserAgentHeaders(userAgent, TargetPlatform.android), {
        'user-agent': userAgent,
        'sec-ch-ua':
            '"Chromium";v="149", "Android WebView";v="149", '
            '"Not_A Brand";v="99"',
        'sec-ch-ua-mobile': '?1',
        'sec-ch-ua-platform': '"Android"',
      });
    });

    test('derives desktop Chromium hints from platform information', () {
      const userAgent =
          'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 '
          '(KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36';

      expect(deriveBrowserUserAgentHeaders(userAgent, TargetPlatform.linux), {
        'user-agent': userAgent,
        'sec-ch-ua':
            '"Chromium";v="149", "Google Chrome";v="149", '
            '"Not_A Brand";v="99"',
        'sec-ch-ua-mobile': '?0',
        'sec-ch-ua-platform': '"Linux"',
      });
    });

    test('rejects user agents without a Chromium version', () {
      expect(
        deriveBrowserUserAgentHeaders(
          'Mozilla/5.0 AppleWebKit/537.36 Safari/537.36',
          TargetPlatform.android,
        ),
        isNull,
      );
    });

    test('keeps static fallback headers internally consistent', () {
      final headers = deriveBrowserUserAgentHeaders(
        defaultBrowserUserAgent,
        TargetPlatform.android,
      );

      expect(headers, isNotNull);
      expect(headers!['sec-ch-ua'], defaultSecChUa);
      expect(headers['sec-ch-ua-mobile'], defaultSecChUaMobile);
      expect(headers['sec-ch-ua-platform'], defaultSecChUaPlatform);
    });
  });
}
