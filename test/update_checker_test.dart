import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/model/config.dart';
import 'package:gagaku/update_checker.dart';
import 'package:gagaku/version.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

void main() {
  setUpAll(() {
    logger = Logger(level: Level.off);
  });

  group('UpdateChecker', () {
    test('stays quiet and does not fetch when update checks are disabled', () {
      final client = _RecordingClient();
      final container = _container(
        settings: GagakuConfig(checkForUpdates: false),
        client: client,
      );
      addTearDown(container.dispose);

      expect(
        container.read(updateCheckerProvider.future),
        completion(isA<UpdateResultUpToDate>()),
      );
      expect(client.requests, isEmpty);
    });

    test('stays quiet and does not fetch outside release builds', () async {
      final client = _RecordingClient((_) => _stableRelease(version: 'v1.0.1'));
      final container = _container(client: client, isReleaseBuild: false);
      addTearDown(container.dispose);

      final result = await container.read(updateCheckerProvider.future);

      expect(result, isA<UpdateResultUpToDate>());
      expect((result as UpdateResultUpToDate).checked, isFalse);
      expect(client.requests, isEmpty);
    });

    test('stays quiet and does not fetch during the cooldown window', () async {
      final now = DateTime(2026, 7, 5, 12);
      final client = _RecordingClient();
      final container = _container(
        now: now,
        settings: GagakuConfig(
          lastUpdateCheck: now.subtract(const Duration(hours: 23)),
          updateCheckCooldownHours: 24,
        ),
        client: client,
      );
      addTearDown(container.dispose);

      final result = await container.read(updateCheckerProvider.future);

      expect(result, isA<UpdateResultUpToDate>());
      expect((result as UpdateResultUpToDate).checked, isFalse);
      expect(client.requests, isEmpty);
    });

    test(
      'stable channel returns checked up-to-date for the current version',
      () async {
        final client = _RecordingClient(
          (_) => _stableRelease(version: kPackageVersion),
        );
        final container = _container(client: client);
        addTearDown(container.dispose);

        final result = await container.read(updateCheckerProvider.future);

        expect(result, isA<UpdateResultUpToDate>());
        expect((result as UpdateResultUpToDate).checked, isTrue);
        expect(
          client.requests.single.url.path,
          '/repos/r52/gagaku/releases/latest',
        );
        expect(client.closed, isTrue);
      },
    );

    test('stable channel surfaces a newer release', () async {
      final client = _RecordingClient((_) => _stableRelease(version: 'v1.0.1'));
      final container = _container(client: client);
      addTearDown(container.dispose);

      final result = await container.read(updateCheckerProvider.future);

      expect(result, isA<UpdateResultAvailable>());
      expect((result as UpdateResultAvailable).info.version, '1.0.1');
    });

    test('stable channel recognizes an ignored newer release', () async {
      final client = _RecordingClient((_) => _stableRelease(version: 'v1.0.1'));
      final container = _container(
        settings: GagakuConfig(ignoredUpdates: ['1.0.1']),
        client: client,
      );
      addTearDown(container.dispose);

      final result = await container.read(updateCheckerProvider.future);

      expect(result, isA<UpdateResultIgnored>());
      expect((result as UpdateResultIgnored).info.version, '1.0.1');
    });

    test(
      'stable channel treats fetch failures as a quiet unchecked result',
      () async {
        final client = _RecordingClient((_) => http.Response('nope', 500));
        final container = _container(client: client);
        addTearDown(container.dispose);

        final result = await container.read(updateCheckerProvider.future);

        expect(result, isA<UpdateResultUpToDate>());
        expect((result as UpdateResultUpToDate).checked, isFalse);
      },
    );

    test('stable channel rejects malformed remote versions quietly', () async {
      final client = _RecordingClient(
        (_) => _stableRelease(version: '1.nope.1'),
      );
      final container = _container(client: client);
      addTearDown(container.dispose);

      final result = await container.read(updateCheckerProvider.future);

      expect(result, isA<UpdateResultUpToDate>());
      expect((result as UpdateResultUpToDate).checked, isFalse);
    });

    test(
      'beta channel returns checked up-to-date for the current commit',
      () async {
        final client = _RecordingClient(
          (_) => _betaReleases(commitSha: kCommitSha),
        );
        final container = _container(
          settings: GagakuConfig(updateChannel: 'beta'),
          client: client,
        );
        addTearDown(container.dispose);

        final result = await container.read(updateCheckerProvider.future);

        expect(result, isA<UpdateResultUpToDate>());
        expect((result as UpdateResultUpToDate).checked, isTrue);
        expect(client.requests.single.url.path, '/repos/r52/gagaku/releases');
      },
    );

    test('beta channel surfaces a different dev-preview commit', () async {
      final remoteSha = 'f' * 40;
      final client = _RecordingClient(
        (_) => _betaReleases(commitSha: remoteSha),
      );
      final container = _container(
        settings: GagakuConfig(updateChannel: 'beta'),
        client: client,
      );
      addTearDown(container.dispose);

      final result = await container.read(updateCheckerProvider.future);

      expect(result, isA<UpdateResultAvailable>());
      final info = (result as UpdateResultAvailable).info;
      expect(info.commitSha, remoteSha);
      expect(info.version, 'Dev Preview Build');
    });

    test('beta channel recognizes an ignored dev-preview commit', () async {
      final remoteSha = 'f' * 40;
      final client = _RecordingClient(
        (_) => _betaReleases(commitSha: remoteSha),
      );
      final container = _container(
        settings: GagakuConfig(
          updateChannel: 'beta',
          ignoredUpdates: [remoteSha],
        ),
        client: client,
      );
      addTearDown(container.dispose);

      final result = await container.read(updateCheckerProvider.future);

      expect(result, isA<UpdateResultIgnored>());
      expect((result as UpdateResultIgnored).info.commitSha, remoteSha);
    });

    test(
      'beta channel ignores dev-preview releases without commit metadata',
      () async {
        final client = _RecordingClient(
          (_) => _jsonResponse([
            _release(tagName: 'dev-preview', body: 'No commit here'),
          ]),
        );
        final container = _container(
          settings: GagakuConfig(updateChannel: 'beta'),
          client: client,
        );
        addTearDown(container.dispose);

        final result = await container.read(updateCheckerProvider.future);

        expect(result, isA<UpdateResultUpToDate>());
        expect((result as UpdateResultUpToDate).checked, isFalse);
      },
    );
  });

  group('stable version comparison', () {
    test('uses semver precedence for prerelease and build metadata', () {
      expect(
        isStableUpdateAvailable(
          currentVersion: '1.0.1-dev.1',
          remoteVersion: '1.0.1',
        ),
        isTrue,
      );
      expect(
        isStableUpdateAvailable(
          currentVersion: '1.0.0+1',
          remoteVersion: '1.0.0+2',
        ),
        isFalse,
      );
      expect(
        isStableUpdateAvailable(
          currentVersion: '1.0.1',
          remoteVersion: '1.0.1-dev.1',
        ),
        isFalse,
      );
    });

    test('normalizes only a leading release tag v', () {
      expect(normalizeStableVersion('v1.2.3'), '1.2.3');
      expect(normalizeStableVersion('V1.2.3'), '1.2.3');
      expect(normalizeStableVersion('1.2.3+preview'), '1.2.3+preview');
    });
  });

  group('main update UX predicate', () {
    test('records only successful no-update and ignored checks', () {
      final info = UpdateInfo(
        version: '1.0.1',
        releaseUrl: 'https://example.com/release',
        publishedAt: DateTime(2026, 7, 5),
      );

      expect(shouldRecordUpdateCheck(const UpdateResultUpToDate()), isFalse);
      expect(
        shouldRecordUpdateCheck(const UpdateResultUpToDate(checked: true)),
        isTrue,
      );
      expect(shouldRecordUpdateCheck(UpdateResultIgnored(info)), isTrue);
      expect(shouldRecordUpdateCheck(UpdateResultAvailable(info)), isFalse);
    });
  });

  group('update dialog UX', () {
    testWidgets('snackbar View opens the update dialog', (tester) async {
      await LocaleSettings.setLocale(AppLocale.en);
      var dismissed = 0;
      var snoozed = 0;

      await tester.pumpWidget(
        ProviderScope(
          child: TranslationProvider(
            child: MaterialApp(
              home: Scaffold(
                body: Builder(
                  builder: (context) {
                    return TextButton(
                      onPressed: () {
                        showUpdateSnackBar(
                          context,
                          UpdateInfo(
                            version: '1.0.1',
                            releaseUrl: 'https://example.com/release',
                            publishedAt: DateTime(2026, 7, 5),
                          ),
                          onDismissed: () {
                            dismissed++;
                          },
                          onNotNow: () {
                            snoozed++;
                          },
                        );
                      },
                      child: const Text('Show update snackbar'),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show update snackbar'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('View'));
      await tester.pumpAndSettle();

      expect(dismissed, 0);
      expect(find.text('Update Available'), findsOneWidget);

      await tester.tap(find.text('Not Now'));
      await tester.pumpAndSettle();

      expect(snoozed, 1);
      expect(find.text('Update Available'), findsNothing);
    });

    testWidgets('dismissed snackbar snoozes the available update', (
      tester,
    ) async {
      await LocaleSettings.setLocale(AppLocale.en);
      var dismissed = 0;

      await tester.pumpWidget(
        ProviderScope(
          child: TranslationProvider(
            child: MaterialApp(
              home: Scaffold(
                body: Builder(
                  builder: (context) {
                    return TextButton(
                      onPressed: () {
                        showUpdateSnackBar(
                          context,
                          UpdateInfo(
                            version: '1.0.1',
                            releaseUrl: 'https://example.com/release',
                            publishedAt: DateTime(2026, 7, 5),
                          ),
                          onDismissed: () {
                            dismissed++;
                          },
                        );
                      },
                      child: const Text('Show update snackbar'),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show update snackbar'));
      await tester.pump();
      ScaffoldMessenger.of(
        tester.element(find.text('Show update snackbar')),
      ).hideCurrentSnackBar();
      await tester.pumpAndSettle();

      expect(dismissed, 1);
    });

    testWidgets('Not Now snoozes the available update dialog', (tester) async {
      await LocaleSettings.setLocale(AppLocale.en);
      var snoozed = 0;

      await tester.pumpWidget(
        ProviderScope(
          child: TranslationProvider(
            child: MaterialApp(
              home: Builder(
                builder: (context) {
                  return TextButton(
                    onPressed: () {
                      showUpdateDialog(
                        context,
                        UpdateInfo(
                          version: '1.0.1',
                          releaseUrl: 'https://example.com/release',
                          publishedAt: DateTime(2026, 7, 5),
                        ),
                        onNotNow: () {
                          snoozed++;
                        },
                      );
                    },
                    child: const Text('Open update dialog'),
                  );
                },
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open update dialog'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Not Now'));
      await tester.pumpAndSettle();

      expect(snoozed, 1);
      expect(find.text('Update Available'), findsNothing);
    });
  });
}

ProviderContainer _container({
  GagakuConfig? settings,
  _RecordingClient? client,
  DateTime? now,
  bool isReleaseBuild = true,
}) {
  final updateClient = client ?? _RecordingClient();
  return ProviderContainer(
    overrides: [
      gagakuSettingsProvider.overrideWithValue(settings ?? GagakuConfig()),
      updateCheckerHttpClientFactoryProvider.overrideWithValue(
        () => updateClient,
      ),
      updateCheckerNowProvider.overrideWithValue(() => now ?? DateTime.now()),
      updateCheckerIsReleaseBuildProvider.overrideWithValue(isReleaseBuild),
    ],
  );
}

http.Response _stableRelease({required String version}) {
  return _jsonResponse(_release(tagName: version, name: version, body: ''));
}

http.Response _betaReleases({required String commitSha}) {
  return _jsonResponse([
    _release(tagName: 'v1.0.1', name: 'Stable', body: ''),
    _release(
      tagName: 'dev-preview',
      name: 'Dev Preview Build',
      body: 'Built from commit $commitSha',
    ),
  ]);
}

Map<String, Object?> _release({
  required String tagName,
  String? name,
  String? body,
}) {
  return {
    'tag_name': tagName,
    'name': name,
    'body': body,
    'html_url': 'https://github.com/r52/gagaku/releases/tag/$tagName',
    'published_at': '2026-07-05T12:00:00Z',
  };
}

http.Response _jsonResponse(Object? body) {
  return http.Response(
    jsonEncode(body),
    200,
    headers: {'content-type': 'application/json'},
  );
}

class _RecordingClient extends http.BaseClient {
  _RecordingClient([this._handler]);

  final FutureOr<http.Response> Function(http.BaseRequest request)? _handler;
  final List<http.BaseRequest> requests = [];
  bool closed = false;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    requests.add(request);
    final response =
        await (_handler?.call(request) ??
            Future<http.Response>.error(
              StateError('Unexpected request: $request'),
            ));
    return http.StreamedResponse(
      Stream.value(response.bodyBytes),
      response.statusCode,
      contentLength: response.contentLength,
      request: request,
      headers: response.headers,
      isRedirect: response.isRedirect,
      persistentConnection: response.persistentConnection,
      reasonPhrase: response.reasonPhrase,
    );
  }

  @override
  void close() {
    closed = true;
    super.close();
  }
}
