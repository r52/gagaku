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
            '"Android WebView";v="149", "Chromium";v="149", '
            '"Not)A;Brand";v="24"',
        'sec-ch-ua-mobile': '?1',
        'sec-ch-ua-platform': '"Android"',
      });
    });

    test('uses the Edge product version rather than its Chromium version', () {
      const userAgent =
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 '
          '(KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36 Edg/150.0.0.0';

      expect(deriveBrowserUserAgentHeaders(userAgent, TargetPlatform.windows), {
        'user-agent': userAgent,
        'sec-ch-ua':
            '"Microsoft Edge";v="150", "Chromium";v="149", '
            '"Not)A;Brand";v="24"',
        'sec-ch-ua-mobile': '?0',
        'sec-ch-ua-platform': '"Windows"',
      });
    });

    test('matches Chromium 141 GREASE and destination ordering', () {
      const userAgent =
          'Mozilla/5.0 (Linux; Android 16; K; wv) AppleWebKit/537.36 '
          '(KHTML, like Gecko) Version/4.0 Chrome/141.0.0.0 '
          'Mobile Safari/537.36';

      expect(
        deriveBrowserUserAgentHeaders(
          userAgent,
          TargetPlatform.android,
        )!['sec-ch-ua'],
        '"Android WebView";v="141", "Not?A_Brand";v="8", '
        '"Chromium";v="141"',
      );
    });

    test('rejects Windows Chromium without an Edge identity', () {
      const userAgent =
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 '
          '(KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36';

      expect(
        deriveBrowserUserAgentHeaders(userAgent, TargetPlatform.windows),
        isNull,
      );
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
  });

  group('GagakuData browser identity', () {
    test('falls back to a complete identity derived from the default UA', () {
      expect(GagakuData().browserUserAgentHeaders, {
        'user-agent': defaultBrowserUserAgent,
        // Chromium 156 GREASE: Not:A-Brand v8, order [0, 1, 2].
        'sec-ch-ua':
            '"Not:A-Brand";v="8", "Chromium";v="156", '
            '"Android WebView";v="156"',
        'sec-ch-ua-mobile': '?1',
        'sec-ch-ua-platform': '"Android"',
      });
    });

    test('adopts only the first seeded identity', () {
      final gdat = GagakuData();
      final first = {'user-agent': 'first', 'sec-ch-ua': 'first-hints'};

      expect(gdat.seedBrowserUserAgentHeaders(first), isTrue);
      expect(
        gdat.seedBrowserUserAgentHeaders({'user-agent': 'second'}),
        isFalse,
      );
      expect(gdat.dynamicUserAgent, 'first');
      expect(gdat.browserUserAgentHeaders['sec-ch-ua'], 'first-hints');
      // Fallback hints the seed did not provide remain present.
      expect(gdat.browserUserAgentHeaders['sec-ch-ua-platform'], '"Android"');
    });
  });
}
