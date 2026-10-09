import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart' show Cookie;
import 'package:gagaku/web/model/cloudflare.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  test('diagnostic fingerprints are stable without exposing their input', () {
    const clearance = 'sensitive-clearance-value';

    final valueFingerprint = diagnosticValueFingerprint(clearance);
    final userAgentFingerprint = diagnosticUserAgentFingerprint('test-agent');

    expect(valueFingerprint, startsWith('sha256:'));
    expect(valueFingerprint, isNot(contains(clearance)));
    expect(valueFingerprint, diagnosticValueFingerprint(clearance));
    expect(userAgentFingerprint, 'fnv32:3d3eb8f9');
  });

  test('finds the selected Cloudflare clearance fingerprint', () {
    final cookies = [
      Cookie(name: 'session', value: 'session-value'),
      Cookie(name: 'cf_clearance', value: 'clearance-value'),
    ];

    expect(
      cloudflareClearanceFingerprint(cookies),
      diagnosticValueFingerprint('clearance-value'),
    );
    expect(cloudflareClearanceFingerprint(cookies.take(1)), isNull);
  });

  test('cookie selection prefers the current secure clearance', () {
    final now = DateTime.utc(2026, 8, 17);
    final selection = selectBrowserCookiesForUrl(
      [
        Cookie(
          name: 'cf_clearance',
          value: 'stale',
          domain: '.comix.to',
          path: '/',
          expiresDate: now.add(const Duration(hours: 1)).millisecondsSinceEpoch,
        ),
        Cookie(
          name: 'cf_clearance',
          value: 'current',
          domain: '.comix.to',
          path: '/',
          expiresDate: now.add(const Duration(hours: 2)).millisecondsSinceEpoch,
          isSecure: true,
        ),
        Cookie(
          name: 'expired',
          value: 'expired',
          domain: '.comix.to',
          path: '/',
          expiresDate: now
              .subtract(const Duration(hours: 1))
              .millisecondsSinceEpoch,
        ),
        Cookie(
          name: 'other-domain',
          value: 'other',
          domain: '.example.com',
          path: '/',
        ),
      ],
      Uri.parse('https://comix.to/'),
      now: now,
    );

    expect(selection.inputCount, 4);
    expect(selection.discardedCount, 3);
    expect(selection.duplicateNames, ['cf_clearance']);
    expect(selection.cookies, hasLength(1));
    expect(selection.cookies.single.value, 'current');
  });

  test('cookie selection prefers the most specific matching path', () {
    final selection = selectBrowserCookiesForUrl([
      Cookie(name: 'session', value: 'root', path: '/'),
      Cookie(name: 'session', value: 'reader', path: '/reader'),
    ], Uri.parse('https://example.com/reader/chapter'));

    expect(selection.cookies.single.value, 'reader');
  });

  test('manual browser state is handed to one runtime initialization', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    const browserState = CloudflareBrowserState(
      cookies: [],
      localStorage: {'token': 'ready'},
      userAgentHeaders: {'user-agent': 'test-agent'},
    );
    final notifier = container.read(cloudflareBrowserStatesProvider.notifier);

    notifier.stage('source', browserState);

    expect(notifier.take('source'), same(browserState));
    expect(notifier.take('source'), isNull);
  });

  test(
    'a failed initialization restores state without replacing a newer solve',
    () {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      const firstState = CloudflareBrowserState(
        cookies: [],
        localStorage: {'token': 'first'},
        userAgentHeaders: {'user-agent': 'test-agent'},
      );
      const newerState = CloudflareBrowserState(
        cookies: [],
        localStorage: {'token': 'newer'},
        userAgentHeaders: {'user-agent': 'test-agent'},
      );
      final notifier = container.read(cloudflareBrowserStatesProvider.notifier);

      notifier.restoreIfAbsent('source', firstState);
      notifier.stage('source', newerState);
      notifier.restoreIfAbsent('source', firstState);

      expect(notifier.take('source'), same(newerState));
    },
  );

  test('only a changed clearance counts as a new solve', () {
    final cookies = [
      Cookie(name: 'session', value: 'session-value'),
      Cookie(name: 'cf_clearance', value: 'fresh'),
    ];

    expect(findCloudflareClearance(cookies)?.value, 'fresh');
    expect(hasNewCloudflareClearance(cookies, null), isTrue);
    expect(hasNewCloudflareClearance(cookies, 'stale'), isTrue);
    expect(hasNewCloudflareClearance(cookies, 'fresh'), isFalse);
    expect(hasNewCloudflareClearance(cookies.take(1), null), isFalse);
  });

  test('challenge signals match browser and HTTP evidence', () {
    expect(
      isCloudflareChallengeUrl(
        Uri.parse('https://example.com/?__cf_chl_rt_tk=token'),
      ),
      isTrue,
    );
    expect(
      isCloudflareChallengeUrl(Uri.parse('https://example.com/?page=1')),
      isFalse,
    );
    expect(isCloudflareChallengeUrl(null), isFalse);

    expect(isCloudflareChallengeTitle('Just a moment...'), isTrue);
    expect(isCloudflareChallengeTitle('Example'), isFalse);
    expect(isCloudflareChallengeTitle(null), isFalse);

    expect(isCloudflareChallengeHeaders({'cf-mitigated': 'challenge'}), isTrue);
    expect(isCloudflareChallengeHeaders({'CF-Mitigated': 'Challenge'}), isTrue);
    expect(isCloudflareChallengeHeaders({'server': 'cloudflare'}), isFalse);
    expect(isCloudflareChallengeHeaders(null), isFalse);
  });

  test('serializes valued cookies into a request header', () {
    expect(
      serializeBrowserCookies([
        Cookie(name: 'a', value: '1'),
        Cookie(name: 'b', value: null),
        Cookie(name: 'cf_clearance', value: 'clearance'),
      ]),
      'a=1; cf_clearance=clearance',
    );
    expect(serializeBrowserCookies(const []), isNull);
  });

  test('cookie selection keeps host-only cookies without a domain', () {
    final selection = selectBrowserCookiesForUrl([
      Cookie(name: 'cf_clearance', value: 'clearance'),
      Cookie(name: 'other', value: 'x', domain: 'other.example'),
    ], Uri.parse('https://comix.to/series'));

    expect(selection.cookies.map((cookie) => cookie.name), ['cf_clearance']);
    expect(
      selection.diagnosticSummary,
      'input=2 selected=1 discarded=1 duplicateNames=[]',
    );
  });
}
