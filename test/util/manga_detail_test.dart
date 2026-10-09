import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/util/manga_detail.dart';
import 'package:gagaku/util/material_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  setUpAll(() async {
    await LocaleSettings.setLocale(AppLocale.en);
  });

  Future<void> pumpHost(
    WidgetTester tester, {
    required Size size,
    RefreshCallback? onRefresh,
    double textScale = 1.0,
  }) async {
    tester.view.devicePixelRatio = 1.0;
    tester.view.physicalSize = size;
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(
      ProviderScope(
        child: TranslationProvider(
          child: MaterialApp(
            builder: (context, child) => MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: TextScaler.linear(textScale)),
              child: child!,
            ),
            home: _Host(onRefresh: onRefresh ?? () async {}),
          ),
        ),
      ),
    );
    await tester.pump();
  }

  double fabScale(WidgetTester tester) => tester
      .widget<AnimatedScale>(
        find.ancestor(
          of: find.byType(FloatingActionButton),
          matching: find.byType(AnimatedScale),
        ),
      )
      .scale;

  for (final testCase in [
    (name: 'portrait phone', size: const Size(400, 800), twoPane: false),
    (name: 'landscape phone', size: const Size(800, 360), twoPane: false),
    (name: 'tablet', size: const Size(1200, 800), twoPane: true),
  ]) {
    testWidgets('${testCase.name} uses the expected layout', (tester) async {
      await pumpHost(tester, size: testCase.size);

      expect(
        find.byType(NestedScrollView),
        testCase.twoPane ? findsNothing : findsOneWidget,
      );
      expect(
        find.byType(VerticalDivider),
        testCase.twoPane ? findsOneWidget : findsNothing,
      );
    });

    testWidgets('${testCase.name} layout can pull to refresh', (tester) async {
      var refreshes = 0;
      await pumpHost(
        tester,
        size: testCase.size,
        onRefresh: () async => refreshes++,
      );

      // The side pane is outside the refresh scope in the two-pane layout;
      // in the single-pane layout the chapter header can be off-screen.
      await tester.fling(
        find.text(testCase.twoPane ? 'Chapter header' : 'metadata'),
        const Offset(0, 300),
        1000,
      );
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));
      await tester.pump(const Duration(seconds: 1));

      expect(refreshes, 1);
    });
  }

  testWidgets('layout switch keeps the selected tab', (tester) async {
    await pumpHost(tester, size: const Size(400, 800));

    await tester.tap(find.text('Art'));
    await tester.pumpAndSettle();
    expect(find.text('Art 0'), findsOneWidget);

    tester.view.physicalSize = const Size(1200, 800);
    await tester.pumpAndSettle();

    expect(find.byType(VerticalDivider), findsOneWidget);
    expect(find.text('Art 0'), findsOneWidget);
    expect(find.text('Chapter header'), findsNothing);
  });

  testWidgets('chapter header stays pinned below the collapsed banner', (
    tester,
  ) async {
    await pumpHost(tester, size: const Size(400, 800));

    // Expanded: the tab body starts right below the tab bar, with no gap
    // beyond the header's own 8px padding.
    expect(
      tester.getTopLeft(find.text('Chapter header')).dy -
          tester.getBottomLeft(find.byType(TabBar)).dy,
      moreOrLessEquals(8.0),
    );

    await tester.drag(find.text('Chapter header'), const Offset(0, -3000));
    await tester.pumpAndSettle();

    final appBarBottom = tester.getBottomLeft(find.byType(AppBar)).dy;
    final headerTop = tester.getTopLeft(find.text('Chapter header')).dy;
    expect(headerTop - appBarBottom, moreOrLessEquals(8.0));
    expect(find.text('Chapter 0'), findsNothing);
  });

  for (final size in [const Size(400, 800), const Size(1200, 800)]) {
    testWidgets('pinned header grows with text scale at $size', (tester) async {
      await pumpHost(tester, size: size, textScale: 2.0);

      expect(tester.takeException(), isNull);
      expect(
        tester
            .getSize(
              find.descendant(
                of: find.byType(PinnedHeaderSliver),
                matching: find.byType(Material),
              ),
            )
            .height,
        greaterThan(48.0),
      );
    });
  }

  testWidgets('two-pane scroll-to-top follows only the scrollToTop tab', (
    tester,
  ) async {
    await pumpHost(tester, size: const Size(1200, 800));

    await tester.drag(find.text('Chapter 3'), const Offset(0, -500));
    await tester.pumpAndSettle();
    expect(fabScale(tester), 1.0);

    await tester.tap(find.text('Art'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    expect(fabScale(tester), 0.0);

    await tester.tap(find.text('Chapters'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    expect(fabScale(tester), 0.0);
  });
}

class _Host extends HookWidget {
  const _Host({required this.onRefresh});

  final RefreshCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    final tabController = useMaterialTabController(initialLength: 2);
    final scrollController = useScrollController();

    return MangaDetailScaffold(
      title: 'Test title',
      coverUrl: 'https://example.invalid/cover.jpg',
      badge: const Text('badge'),
      metadata: const SizedBox(height: 200, child: Text('metadata')),
      tabController: tabController,
      tabs: [
        MangaDetailTab(
          label: 'Chapters',
          scrollToTop: true,
          body: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              const PinnedHeaderSliver(
                child: Material(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Chapter header',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ),
              ),
              SliverList.builder(
                itemCount: 60,
                itemBuilder: (context, index) =>
                    ListTile(title: Text('Chapter $index')),
              ),
            ],
          ),
        ),
        MangaDetailTab(
          label: 'Art',
          body: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverList.builder(
                itemCount: 60,
                itemBuilder: (context, index) =>
                    ListTile(title: Text('Art $index')),
              ),
            ],
          ),
        ),
      ],
      onRefresh: onRefresh,
      scrollController: scrollController,
    );
  }
}
