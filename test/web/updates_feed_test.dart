import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/util/exception.dart';
import 'package:gagaku/web/model/link_resolver.dart';
import 'package:gagaku/web/model/model.dart';
import 'package:gagaku/web/model/types.dart';
import 'package:gagaku/web/model/update_feed.dart';
import 'package:gagaku/web/model/update_feed_controller.dart';
import 'package:gagaku/web/updates_feed.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  setUpAll(() => LocaleSettings.setLocale(AppLocale.en));

  testWidgets('shows title, progress, and Cloudflare recovery guidance', (
    tester,
  ) async {
    final link = HistoryLink.fromSeries(
      title: 'Blocked title',
      series: const WebSeriesRef.extension(
        sourceId: 'blocked-source',
        mangaId: 'blocked-manga',
      ),
    );
    final failure = UpdateFeedFailure(
      items: const [],
      error: UpdateFeedItemFailure(
        link: link,
        stage: UpdateFeedItemFailureStage.fetchingManga,
        cause: const CloudflareBypassException(),
        causeStackTrace: StackTrace.empty,
      ),
      stackTrace: StackTrace.empty,
      completed: 2,
      total: 5,
    );

    await _pumpFailure(tester, failure);

    expect(
      find.text(t.chapterFeed.updateFailed(item: 'Blocked title')),
      findsOneWidget,
    );
    expect(find.text('2/5'), findsOneWidget);
    expect(
      find.text(t.webSources.source.cloudflareManualRequired),
      findsOneWidget,
    );
  });

  testWidgets('shows the underlying reason for other item failures', (
    tester,
  ) async {
    final cause = StateError('transport failed');
    final link = HistoryLink.fromSeries(
      title: 'Failed title',
      series: const WebSeriesRef.proxy(
        proxyId: 'proxy',
        seriesId: 'failed-manga',
      ),
    );
    final failure = UpdateFeedFailure(
      items: const [],
      error: UpdateFeedItemFailure(
        link: link,
        stage: UpdateFeedItemFailureStage.fetchingManga,
        cause: cause,
        causeStackTrace: StackTrace.empty,
      ),
      stackTrace: StackTrace.empty,
      completed: 0,
      total: 1,
    );

    await _pumpFailure(tester, failure);

    expect(
      find.text(t.chapterFeed.failureReason(reason: cause.toString())),
      findsOneWidget,
    );
  });
}

Future<void> _pumpFailure(
  WidgetTester tester,
  UpdateFeedFailure failure,
) async {
  final resolver = WebLinkResolver(
    extensionExists: (_) async => false,
    redirectTransport: const _NoopRedirectTransport(),
  );
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        webLinkResolverProvider.overrideWithValue(resolver),
        webUpdateFeedControllerProvider.overrideWith(
          () => _FailureController(failure),
        ),
      ],
      child: TranslationProvider(
        child: const MaterialApp(home: WebSourceUpdatesPage()),
      ),
    ),
  );
  await tester.pump();
}

final class _FailureController extends WebUpdateFeedController {
  _FailureController(this.failure);

  final UpdateFeedFailure failure;

  @override
  Future<UpdateFeedState> build() async => failure;
}

final class _NoopRedirectTransport implements WebLinkRedirectTransport {
  const _NoopRedirectTransport();

  @override
  Future<Uri?> resolveRedirect(Uri uri) async => null;
}
