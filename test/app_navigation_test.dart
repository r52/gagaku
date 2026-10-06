import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gagaku/app_navigation.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/model/config.dart';
import 'package:gagaku/model/startup_section.dart';
import 'package:gagaku/routes.dart';
import 'package:gagaku/update_checker.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

class _Settings extends GagakuSettings {
  @override
  GagakuConfig build() => GagakuConfig(checkForUpdates: false);
}

class _Updates extends UpdateChecker {
  @override
  Future<UpdateResult> build() async => const UpdateResultUpToDate();
}

class _UpdateSettings extends GagakuSettings {
  @override
  GagakuConfig build() => GagakuConfig(checkForUpdates: true);
}

class _AvailableUpdates extends UpdateChecker {
  @override
  Future<UpdateResult> build() async => UpdateResultAvailable(
    UpdateInfo(
      version: '99.0.0',
      releaseUrl: 'https://example.invalid/release',
      publishedAt: DateTime.utc(2026),
    ),
  );
}

Future<void> _setWindow(
  WidgetTester tester,
  Size size, {
  FakeViewPadding padding = const FakeViewPadding(),
}) async {
  tester.view
    ..devicePixelRatio = 1
    ..physicalSize = size
    ..padding = padding
    ..viewPadding = padding;
  // Live Android tests need the render surface and MediaQuery to agree.
  await tester.binding.setSurfaceSize(size);
  addTearDown(() => tester.binding.setSurfaceSize(null));
  addTearDown(tester.view.resetDevicePixelRatio);
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetPadding);
  addTearDown(tester.view.resetViewPadding);
}

Future<void> _resizeWindow(WidgetTester tester, Size size) async {
  tester.view.physicalSize = size;
  await tester.binding.setSurfaceSize(size);
}

Future<void> _pumpApp(
  WidgetTester tester,
  Widget app, {
  bool updateAvailable = false,
}) async {
  final container = ProviderContainer.test(
    overrides: [
      gagakuSettingsProvider.overrideWith(
        updateAvailable ? _UpdateSettings.new : _Settings.new,
      ),
      updateCheckerProvider.overrideWith(
        updateAvailable ? _AvailableUpdates.new : _Updates.new,
      ),
    ],
  );
  await tester.pumpWidget(
    TranslationProvider(
      child: UncontrolledProviderScope(container: container, child: app),
    ),
  );
  await tester.pumpAndSettle();
}

const _destinations = [
  NavigationRailDestination(icon: Icon(Icons.home), label: Text('Browse')),
  NavigationRailDestination(icon: Icon(Icons.favorite), label: Text('Saved')),
];

class _PersistentContent extends StatefulWidget {
  const _PersistentContent();

  @override
  State<_PersistentContent> createState() => _PersistentContentState();
}

class _PersistentContentState extends State<_PersistentContent> {
  int _count = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
    key: const ValueKey('content'),
    body: Center(
      child: TextButton(
        onPressed: () => setState(() => _count++),
        child: Text('Content count: $_count'),
      ),
    ),
  );
}

void main() {
  testWidgets('a nested shell Navigator does not hide rail accessibility', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    try {
      await _setWindow(tester, const Size(800, 800));
      final container = ProviderContainer.test(
        overrides: [
          gagakuSettingsProvider.overrideWith(_Settings.new),
          updateCheckerProvider.overrideWith(_Updates.new),
        ],
      );
      await tester.pumpWidget(
        TranslationProvider(
          child: UncontrolledProviderScope(
            container: container,
            child: MaterialApp(
              home: AppNavigationScaffold(
                section: StartupSection.localLibrary,
                child: Navigator(
                  onGenerateRoute: (_) => MaterialPageRoute<void>(
                    builder: (_) =>
                        const Scaffold(body: Text('Library content')),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final settings = find.bySemanticsLabel(t.navigation.globalSettings);
      expect(settings, findsOneWidget);
      expect(
        tester
            .getSemantics(settings)
            .getSemanticsData()
            .hasAction(SemanticsAction.tap),
        isTrue,
      );
      expect(find.bySemanticsLabel(t.localLibrary.text), findsOneWidget);
      expect(find.bySemanticsLabel('Library content'), findsOneWidget);

      await tester.tap(find.byTooltip(t.navigation.expand));
      await tester.pumpAndSettle();
      expect(find.bySemanticsLabel(t.navigation.read), findsOneWidget);
      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();
      expect(find.bySemanticsLabel(t.navigation.read), findsNothing);
      expect(settings, findsOneWidget);
      expect(find.bySemanticsLabel('Library content'), findsOneWidget);
    } finally {
      semantics.dispose();
    }
  });

  testWidgets('GoRouter modal Back closes the rail before shell navigation', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    try {
      await _setWindow(tester, const Size(800, 800));
      final router = GoRouter(
        routes: [
          ShellRoute(
            builder: (context, state, child) => AppNavigationScaffold(
              section: StartupSection.webSources,
              destinations: _destinations,
              selectedIndex: 0,
              child: child,
            ),
            routes: [
              GoRoute(
                path: '/',
                builder: (_, _) => const Scaffold(body: Text('Shell home')),
              ),
              GoRoute(
                path: '/detail',
                builder: (_, _) => const Scaffold(body: Text('Detail')),
              ),
            ],
          ),
          GoRoute(
            path: const AppSettingsRoute().location,
            builder: (_, _) => const Scaffold(body: Text('Global settings')),
          ),
        ],
      );
      addTearDown(router.dispose);
      await _pumpApp(tester, MaterialApp.router(routerConfig: router));

      await tester.tap(find.byTooltip(t.navigation.expand));
      await tester.pumpAndSettle();
      expect(find.byTooltip(t.navigation.collapse), findsOneWidget);
      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();
      expect(find.byTooltip(t.navigation.collapse), findsNothing);
      expect(find.text('Shell home'), findsOneWidget);
      expect(router.routeInformationProvider.value.uri.path, '/');

      router.push<void>('/detail');
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip(t.navigation.expand));
      await tester.pumpAndSettle();
      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();
      expect(find.text('Detail'), findsOneWidget);
      expect(find.byTooltip(t.navigation.collapse), findsNothing);
      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();
      expect(find.text('Shell home'), findsOneWidget);

      await tester.tap(find.byTooltip(t.navigation.expand));
      await tester.pumpAndSettle();
      await tester.tap(find.bySemanticsLabel(t.navigation.globalSettings).last);
      await tester.pumpAndSettle();
      expect(find.text('Global settings'), findsOneWidget);
      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();
      expect(find.text('Shell home'), findsOneWidget);
      expect(find.byTooltip(t.navigation.collapse), findsNothing);
    } finally {
      semantics.dispose();
    }
  });

  testWidgets(
    'short notched rails keep utilities and update feedback reachable',
    (tester) async {
      await _setWindow(
        tester,
        const Size(914, 411),
        padding: const FakeViewPadding(left: 52, top: 28, bottom: 24),
      );
      final semantics = tester.ensureSemantics();
      try {
        var selectedIndex = 0;
        await _pumpApp(
          tester,
          MaterialApp(
            home: StatefulBuilder(
              builder: (context, setState) => AppNavigationScaffold(
                section: StartupSection.mangaDex,
                destinations: [
                  for (var index = 0; index < 5; index++)
                    NavigationRailDestination(
                      icon: Icon(Icons.book, key: ValueKey('landscape-$index')),
                      label: Text('Destination $index'),
                    ),
                ],
                selectedIndex: selectedIndex,
                onDestinationSelected: (index) =>
                    setState(() => selectedIndex = index),
                child: const Scaffold(body: Text('Landscape content')),
              ),
            ),
          ),
          updateAvailable: true,
        );

        final menu = find.byTooltip(t.navigation.expand);
        expect(tester.getRect(menu).left, greaterThanOrEqualTo(52));
        expect(tester.getSize(menu).width, greaterThanOrEqualTo(48));
        expect(find.bySemanticsLabel(t.navigation.mangaDex), findsNothing);
        expect(find.bySemanticsLabel(t.localLibrary.text), findsNothing);
        expect(find.bySemanticsLabel(t.webSources.text), findsNothing);

        final settings = find.bySemanticsLabel(t.navigation.globalSettings);
        final aboutText = MaterialLocalizations.of(
          tester.element(find.byType(AppNavigationScaffold)),
        ).aboutListTileTitle('Gagaku');
        final updateLabel = '$aboutText: ${t.updates.updateAvailableTitle}';
        final about = find.bySemanticsLabel(updateLabel);
        final before = tester.getRect(about);
        expect(before.left, greaterThanOrEqualTo(52));
        expect(before.width, greaterThanOrEqualTo(48));
        expect(before.bottom, lessThanOrEqualTo(411 - 24));
        expect(
          tester.getSemantics(about).getSemanticsData().label,
          updateLabel,
        );
        expect(
          tester
              .getSemantics(about)
              .getSemanticsData()
              .hasAction(SemanticsAction.tap),
          isTrue,
        );
        expect(tester.getRect(settings).left, greaterThanOrEqualTo(52));
        expect(tester.getRect(settings).width, greaterThanOrEqualTo(48));
        expect(tester.getRect(settings).bottom, lessThanOrEqualTo(411 - 24));
        final lastDestination = find.byKey(const ValueKey('landscape-4'));
        await tester.timedDrag(
          find.byType(Scrollable),
          const Offset(0, -180),
          const Duration(milliseconds: 500),
        );
        await tester.pumpAndSettle();
        await tester.tap(lastDestination);
        await tester.pumpAndSettle();
        expect(
          tester
              .getSemantics(lastDestination)
              .getSemanticsData()
              .flagsCollection
              .isSelected
              .toBoolOrNull(),
          isTrue,
        );
        expect(tester.getRect(about), before);

        await tester.tap(menu);
        await tester.pumpAndSettle();
        expect(find.byTooltip(t.navigation.collapse), findsOneWidget);
        await tester.binding.handlePopRoute();
        await tester.pumpAndSettle();
        expect(find.byTooltip(t.navigation.collapse), findsNothing);
        expect(find.text('Landscape content'), findsOneWidget);
      } finally {
        semantics.dispose();
      }
    },
  );

  testWidgets('local collapsed navigation retains its three contexts', (
    tester,
  ) async {
    await _setWindow(tester, const Size(800, 800));
    final semantics = tester.ensureSemantics();
    try {
      await _pumpApp(
        tester,
        const MaterialApp(
          home: AppNavigationScaffold(
            section: StartupSection.localLibrary,
            child: Scaffold(body: Text('Local content')),
          ),
        ),
      );
      expect(find.bySemanticsLabel(t.navigation.mangaDex), findsOneWidget);
      expect(find.bySemanticsLabel(t.localLibrary.text), findsOneWidget);
      expect(find.bySemanticsLabel(t.webSources.text), findsOneWidget);
      expect(
        tester
            .getSemantics(find.bySemanticsLabel(t.localLibrary.text))
            .getSemanticsData()
            .flagsCollection
            .isSelected
            .toBoolOrNull(),
        isTrue,
      );
    } finally {
      semantics.dispose();
    }
  });

  for (final width in [411.0, 800.0]) {
    testWidgets('selection and disabled destinations work at ${width}dp', (
      tester,
    ) async {
      await _setWindow(tester, Size(width, 800));
      final semantics = tester.ensureSemantics();
      try {
        var selectedIndex = 0;
        await _pumpApp(
          tester,
          MaterialApp(
            home: StatefulBuilder(
              builder: (context, setState) => AppNavigationScaffold(
                section: StartupSection.webSources,
                selectedIndex: selectedIndex,
                onDestinationSelected: (index) =>
                    setState(() => selectedIndex = index),
                destinations: [
                  const NavigationRailDestination(
                    icon: Icon(Icons.home),
                    label: Text('Browse'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.favorite, key: ValueKey('saved-icon')),
                    padding: EdgeInsetsDirectional.only(start: 12),
                    indicatorColor: Colors.blue,
                    indicatorShape: RoundedRectangleBorder(),
                    label: width <= 600
                        ? const Text.rich(TextSpan(text: 'Saved'))
                        : const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.star, size: 12),
                              Text.rich(TextSpan(text: 'Saved')),
                            ],
                          ),
                  ),
                  const NavigationRailDestination(
                    icon: Icon(Icons.block, key: ValueKey('blocked-icon')),
                    label: Text.rich(TextSpan(text: 'Unavailable')),
                    disabled: true,
                  ),
                ],
                child: const Scaffold(body: Text('Destination content')),
              ),
            ),
          ),
        );
        final saved = find.bySemanticsLabel(RegExp(r'\bSaved\b')).first;
        expect(
          tester
              .getSemantics(saved)
              .getSemanticsData()
              .flagsCollection
              .isSelected
              .toBoolOrNull(),
          isFalse,
        );
        if (width <= 600) {
          await tester.tap(saved);
        } else {
          final savedBounds = tester.getRect(saved);
          await tester.tapAt(
            Offset(savedBounds.left + 1, savedBounds.center.dy),
          );
        }
        await tester.pumpAndSettle();
        expect(
          tester
              .getSemantics(saved)
              .getSemanticsData()
              .flagsCollection
              .isSelected
              .toBoolOrNull(),
          isTrue,
        );
        final disabled = find
            .bySemanticsLabel(RegExp(r'\bUnavailable\b'))
            .first;
        expect(
          tester
              .getSemantics(disabled)
              .getSemanticsData()
              .hasAction(SemanticsAction.tap),
          isFalse,
        );
        await tester.tap(find.byKey(const ValueKey('blocked-icon')));
        await tester.pumpAndSettle();
        expect(
          tester
              .getSemantics(saved)
              .getSemanticsData()
              .flagsCollection
              .isSelected
              .toBoolOrNull(),
          isTrue,
        );
        expect(
          tester
              .getSemantics(disabled)
              .getSemanticsData()
              .flagsCollection
              .isSelected
              .toBoolOrNull(),
          isFalse,
        );
      } finally {
        semantics.dispose();
      }
    });
  }

  testWidgets(
    'inline animation and breakpoint changes preserve content and choice',
    (tester) async {
      await _setWindow(tester, const Size(1300, 800));
      await _pumpApp(
        tester,
        const MaterialApp(
          home: AppNavigationScaffold(
            section: StartupSection.webSources,
            destinations: _destinations,
            selectedIndex: 0,
            child: _PersistentContent(),
          ),
        ),
      );
      await tester.tap(find.text('Content count: 0'));
      await tester.pump();
      await tester.tap(find.byTooltip(t.navigation.collapse));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 125));
      final during = tester.getRect(find.byKey(const ValueKey('content'))).left;
      expect(during, greaterThan(96 + 1));
      expect(during, lessThan(320 + 1));
      await tester.pumpAndSettle();
      expect(find.text('Content count: 1'), findsOneWidget);

      await _resizeWindow(tester, const Size(800, 800));
      await tester.pumpAndSettle();
      await _resizeWindow(tester, const Size(1300, 800));
      await tester.pumpAndSettle();
      expect(find.byTooltip(t.navigation.expand), findsOneWidget);
      expect(find.text('Content count: 1'), findsOneWidget);

      await tester.tap(find.byTooltip(t.navigation.expand));
      await tester.pumpAndSettle();
      await _resizeWindow(tester, const Size(411, 800));
      await tester.pumpAndSettle();
      await _resizeWindow(tester, const Size(1300, 800));
      await tester.pumpAndSettle();
      expect(find.byTooltip(t.navigation.collapse), findsOneWidget);
      expect(find.text('Content count: 1'), findsOneWidget);
    },
  );

  testWidgets('navigation uses its parent width rather than the full display', (
    tester,
  ) async {
    await _setWindow(tester, const Size(1300, 800));
    await _pumpApp(
      tester,
      MaterialApp(
        home: Center(
          child: SizedBox(
            width: 560,
            child: AppNavigationScaffold(
              section: StartupSection.webSources,
              destinations: _destinations,
              selectedIndex: 0,
              child: Scaffold(
                appBar: AppBar(leading: const AppNavigationButton()),
                body: const Text('Constrained content'),
              ),
            ),
          ),
        ),
      ),
    );
    expect(find.byTooltip(t.navigation.expand), findsNothing);
    await tester.tap(find.byTooltip(t.navigation.openMenu));
    await tester.pumpAndSettle();
    expect(find.byTooltip(t.navigation.collapse), findsOneWidget);
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(find.byTooltip(t.navigation.collapse), findsNothing);
    expect(find.text('Constrained content'), findsOneWidget);
  });

  testWidgets('collapsed labels are visible and icons keep their position', (
    tester,
  ) async {
    await _setWindow(tester, const Size(1300, 800));
    await _pumpApp(
      tester,
      const MaterialApp(
        home: AppNavigationScaffold(
          section: StartupSection.webSources,
          destinations: _destinations,
          selectedIndex: 0,
          child: Scaffold(body: Text('Wide content')),
        ),
      ),
    );
    final browseIcon = find.byIcon(Icons.home);
    final expandedCenter = tester.getCenter(browseIcon).dx;
    final expandedLabel = tester.getCenter(find.text('Browse')).dx;
    expect(expandedLabel, greaterThan(expandedCenter));

    await tester.tap(find.byTooltip(t.navigation.collapse));
    await tester.pumpAndSettle();
    expect(tester.getCenter(browseIcon).dx, expandedCenter);
    final label = tester.getRect(find.text('Browse'));
    expect(label.top, greaterThan(tester.getRect(browseIcon).bottom));
    expect(label.center.dx, closeTo(expandedCenter, 0.5));
    expect(find.text('Browse').hitTestable(), findsOneWidget);
  });

  testWidgets('medium modal rail overlays content and closes on Escape', (
    tester,
  ) async {
    await _setWindow(tester, const Size(800, 800));
    await _pumpApp(
      tester,
      const MaterialApp(
        home: AppNavigationScaffold(
          section: StartupSection.webSources,
          destinations: _destinations,
          selectedIndex: 0,
          child: _PersistentContent(),
        ),
      ),
    );
    final content = find.byKey(const ValueKey('content'));
    final panel = find.byType(ListView);
    expect(tester.getRect(content).left, 96);
    expect(tester.getSize(panel).width, 96);

    await tester.tap(find.byTooltip(t.navigation.expand));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 125));
    expect(tester.getSize(panel).width, inExclusiveRange(96, 320));
    expect(tester.getRect(content).left, 96);
    await tester.pumpAndSettle();
    expect(tester.getSize(panel).width, 320);
    expect(tester.getRect(content).left, 96);
    expect(find.text(t.navigation.read), findsOneWidget);

    await tester.sendKeyEvent(LogicalKeyboardKey.escape);
    await tester.pumpAndSettle();
    expect(find.byTooltip(t.navigation.expand), findsOneWidget);
    expect(tester.getSize(panel).width, 96);
    expect(find.text('Content count: 0'), findsOneWidget);
  });

  testWidgets('disabled destinations ignore themed icon and label colors', (
    tester,
  ) async {
    await _setWindow(tester, const Size(800, 800));
    final theme = ThemeData(
      navigationRailTheme: const NavigationRailThemeData(
        unselectedIconTheme: IconThemeData(color: Colors.red),
        unselectedLabelTextStyle: TextStyle(color: Colors.red),
      ),
    );
    await _pumpApp(
      tester,
      MaterialApp(
        theme: theme,
        home: const AppNavigationScaffold(
          section: StartupSection.webSources,
          selectedIndex: 0,
          destinations: [
            NavigationRailDestination(
              icon: Icon(Icons.home),
              label: Text('Browse'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.block, key: ValueKey('blocked-icon')),
              label: Text('Unavailable'),
              disabled: true,
            ),
            NavigationRailDestination(
              icon: Icon(Icons.favorite, key: ValueKey('saved-icon')),
              label: Text('Saved'),
            ),
          ],
          child: Scaffold(body: Text('Themed content')),
        ),
      ),
    );
    final disabled = theme.colorScheme.onSurface.withValues(alpha: 0.38);
    Color? iconColor(String key) =>
        IconTheme.of(tester.element(find.byKey(ValueKey(key)))).color;
    Color? labelColor(String text) =>
        DefaultTextStyle.of(tester.element(find.text(text))).style.color;

    expect(iconColor('blocked-icon'), disabled);
    expect(labelColor('Unavailable'), disabled);
    expect(iconColor('saved-icon'), Colors.red);
    expect(labelColor('Saved'), Colors.red);
  });

  testWidgets('wide expansion choice is shared across app contexts', (
    tester,
  ) async {
    await _setWindow(tester, const Size(1300, 800));
    final section = ValueNotifier(StartupSection.webSources);
    addTearDown(section.dispose);
    await _pumpApp(
      tester,
      MaterialApp(
        home: ValueListenableBuilder(
          valueListenable: section,
          builder: (context, value, _) => AppNavigationScaffold(
            // Separate contexts mount separate scaffolds.
            key: ValueKey(value),
            section: value,
            child: const Scaffold(body: Text('Context content')),
          ),
        ),
      ),
    );
    await tester.tap(find.byTooltip(t.navigation.collapse));
    await tester.pumpAndSettle();
    section.value = StartupSection.mangaDex;
    await tester.pumpAndSettle();
    expect(find.byTooltip(t.navigation.expand), findsOneWidget);
    expect(find.byTooltip(t.navigation.collapse), findsNothing);
  });

  for (final (width, expected) in [(411.0, true), (800.0, false)]) {
    testWidgets('usesMenuButton is $expected at ${width}dp', (tester) async {
      await _setWindow(tester, Size(width, 800));
      bool? usesMenuButton;
      await _pumpApp(
        tester,
        MaterialApp(
          home: AppNavigationScaffold(
            section: StartupSection.localLibrary,
            child: Builder(
              builder: (context) {
                usesMenuButton = AppNavigationScaffold.usesMenuButton(context);
                return const Scaffold(body: Text('Menu content'));
              },
            ),
          ),
        ),
      );
      expect(usesMenuButton, expected);
    });
  }

  testWidgets('compact modal rail follows edge and panel drags', (
    tester,
  ) async {
    await _setWindow(tester, const Size(411, 800));
    await _pumpApp(
      tester,
      const MaterialApp(
        home: AppNavigationScaffold(
          section: StartupSection.webSources,
          destinations: _destinations,
          selectedIndex: 0,
          child: _PersistentContent(),
        ),
      ),
    );
    expect(find.byTooltip(t.navigation.collapse), findsNothing);
    await tester.dragFrom(const Offset(5, 400), const Offset(300, 0));
    await tester.pumpAndSettle();
    expect(find.byTooltip(t.navigation.collapse), findsOneWidget);
    expect(tester.getRect(find.byType(ListView)).left, 0);

    await tester.dragFrom(const Offset(200, 400), const Offset(-300, 0));
    await tester.pumpAndSettle();
    expect(find.byTooltip(t.navigation.collapse), findsNothing);
    await tester.tap(find.text('Content count: 0'));
    await tester.pump();
    expect(find.text('Content count: 1'), findsOneWidget);
  });

  testWidgets('compact modal rail covers and blocks the NavigationBar', (
    tester,
  ) async {
    await _setWindow(tester, const Size(411, 800));
    var selectedIndex = 0;
    await _pumpApp(
      tester,
      MaterialApp(
        home: StatefulBuilder(
          builder: (context, setState) => AppNavigationScaffold(
            section: StartupSection.webSources,
            destinations: _destinations,
            selectedIndex: selectedIndex,
            onDestinationSelected: (index) =>
                setState(() => selectedIndex = index),
            child: Scaffold(
              appBar: AppBar(leading: const AppNavigationButton()),
              body: const Text('Bar content'),
            ),
          ),
        ),
      ),
    );
    final saved = find.descendant(
      of: find.byType(NavigationBar),
      matching: find.byIcon(Icons.favorite),
    );
    // A point in the Saved slot that the 320dp panel does not cover.
    final savedSlot = Offset(405, tester.getCenter(saved).dy);
    await tester.tap(find.byTooltip(t.navigation.openMenu));
    await tester.pumpAndSettle();
    final panel = tester.getRect(find.byType(ListView));
    expect(savedSlot.dx, greaterThan(panel.right));

    // The scrim, not the bar, receives the tap.
    await tester.tapAt(savedSlot);
    await tester.pumpAndSettle();
    expect(selectedIndex, 0);
    expect(find.byTooltip(t.navigation.collapse), findsNothing);

    await tester.tapAt(savedSlot);
    await tester.pumpAndSettle();
    expect(selectedIndex, 1);
  });
}
