import 'package:flutter_test/flutter_test.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/web/model/tracking.dart';
import 'package:gagaku/web/model/tracking_types.dart';
import 'package:gagaku/web/model/types.dart';
import 'package:gagaku/web/trackers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:material_ui/material_ui.dart';

const _series = WebSeriesRef.extension(
  sourceId: 'FictionalSource',
  mangaId: 'series-1',
);
const _tracked = TrackedSeriesRef.web(_series);

WebSourceInfo _tracker(String id) => WebSourceInfo(
  id: id,
  name: '$id Name',
  repo: 'tracker-fixture',
  icon: '',
  capabilities: const [SourceIntents.mangaProgress],
);

final _link = TrackerLink.create(
  trackerId: 'LinkedTracker',
  series: _tracked,
  trackedManga: const SourceManga(
    mangaId: 'entry-1',
    mangaInfo: MangaInfo(
      thumbnailUrl: '',
      synopsis: '',
      primaryTitle: 'Fictional Tracked Entry',
      secondaryTitles: [],
      contentRating: ContentRating.EVERYONE,
    ),
  ),
);

final _progress = MangaProgress(
  sourceManga: _link.trackedManga,
  lastReadChapter: Chapter(
    chapterId: '42',
    sourceManga: _link.trackedManga,
    langCode: 'unknown',
    chapNum: 42,
  ),
  userRating: 8.5,
);

Widget _app(
  WidgetTester tester, {
  required List<WebSourceInfo> trackers,
  required List<TrackerLink> links,
  WebSeriesRef series = _series,
}) {
  final container = ProviderContainer(
    overrides: [
      installedTrackersProvider.overrideWith((ref) => Stream.value(trackers)),
      trackerLinksForSeriesProvider(_tracked)
          .overrideWith((ref) => Stream.value(links)),
      trackerProgressProvider(
        'LinkedTracker',
        _link.linkKey,
      ).overrideWith((ref) async => _progress),
    ],
  );
  addTearDown(container.dispose);

  return UncontrolledProviderScope(
    container: container,
    child: TranslationProvider(
      child: MaterialApp(
        home: Scaffold(
          body: TrackingButton(series: series, title: 'Fictional Series'),
        ),
      ),
    ),
  );
}

void main() {
  setUpAll(() async {
    logger = Logger(level: Level.off);
    await LocaleSettings.setLocale(AppLocale.en);
  });

  testWidgets('the tracking button is hidden without installed trackers', (
    tester,
  ) async {
    await tester.pumpWidget(_app(tester, trackers: const [], links: const []));
    await tester.pumpAndSettle();

    expect(find.byType(IconButton), findsNothing);
  });

  testWidgets('the tracking button is hidden for non-extension series', (
    tester,
  ) async {
    await tester.pumpWidget(
      _app(
        tester,
        trackers: [_tracker('LinkedTracker')],
        links: const [],
        series: const WebSeriesRef.proxy(proxyId: 'gist', seriesId: 'x'),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(IconButton), findsNothing);
  });

  testWidgets('the sheet lists linked progress and unlinked trackers', (
    tester,
  ) async {
    await tester.pumpWidget(
      _app(
        tester,
        trackers: [_tracker('LinkedTracker'), _tracker('OtherTracker')],
        links: [_link],
      ),
    );
    await tester.pumpAndSettle();

    // Badge counts linked, installed trackers.
    expect(find.text('1'), findsOneWidget);

    await tester.tap(find.byType(IconButton));
    await tester.pumpAndSettle();

    expect(find.text('Fictional Tracked Entry'), findsOneWidget);
    expect(find.text('Ch. 42 · Rating: 8.5'), findsOneWidget);
    expect(find.text('Edit progress'), findsOneWidget);
    expect(find.text('Unlink'), findsOneWidget);

    expect(find.text('OtherTracker Name'), findsOneWidget);
    expect(find.text('Not linked'), findsOneWidget);
    expect(find.widgetWithText(FilledButton, 'Link'), findsOneWidget);
    expect(find.text('Manage trackers'), findsOneWidget);
  });
}
