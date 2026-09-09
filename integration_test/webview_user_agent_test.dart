import 'package:flutter/foundation.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gagaku/model/model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('default user agent matches the active Android WebView', () async {
    expect(defaultTargetPlatform, TargetPlatform.android);

    final webViewPackage =
        await InAppWebViewController.getCurrentWebViewPackage();
    expect(webViewPackage, isNotNull);
    expect(webViewPackage!.packageName, isNotEmpty);
    expect(webViewPackage.versionName, isNotEmpty);

    final userAgent = await InAppWebViewController.getDefaultUserAgent();
    final chromiumVersion = RegExp(
      r'(?:Chrome|Chromium)/(\d+)(?:\.\d+){0,3}',
    ).firstMatch(userAgent);
    final webViewMajorVersion = RegExp(
      r'^\d+',
    ).firstMatch(webViewPackage.versionName!);

    expect(userAgent, contains('Android'));
    expect(
      chromiumVersion,
      isNotNull,
      reason: 'Expected a Chromium version in "$userAgent"',
    );
    expect(
      webViewMajorVersion,
      isNotNull,
      reason:
          'Expected a leading version number in ${webViewPackage.versionName}',
    );
    expect(chromiumVersion!.group(1), webViewMajorVersion!.group(0));

    final headers = deriveBrowserUserAgentHeaders(
      userAgent,
      defaultTargetPlatform,
    );
    expect(headers, isNotNull);
    expect(headers!['user-agent'], userAgent);
    expect(headers['sec-ch-ua'], contains('v="${chromiumVersion.group(1)}"'));
    expect(headers['sec-ch-ua-mobile'], '?1');
    expect(headers['sec-ch-ua-platform'], '"Android"');

    debugPrint('Android WebView package: $webViewPackage');
    debugPrint('Android WebView user agent: $userAgent');
    debugPrint('Derived browser headers: $headers');
  });
}
