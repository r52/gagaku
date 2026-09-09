import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gagaku/app_navigation.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/model/config.dart';
import 'package:gagaku/model/startup_section.dart';
import 'package:gagaku/update_checker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class _Settings extends GagakuSettings {
  @override
  GagakuConfig build() => GagakuConfig(checkForUpdates: false);
}

class _Updates extends UpdateChecker {
  @override
  Future<UpdateResult> build() async => const UpdateResultUpToDate();
}

void main() {
  testWidgets('a nested shell Navigator does not hide rail accessibility', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    try {
      tester.view.physicalSize = const Size(1600, 1600);
      tester.view.devicePixelRatio = 2;
      addTearDown(tester.view.resetPhysicalSize);
      final container = ProviderContainer.test(
        overrides: [
          gagakuSettingsProvider.overrideWith(_Settings.new),
          updateCheckerProvider.overrideWith(_Updates.new),
        ],
      );
      addTearDown(tester.view.resetDevicePixelRatio);
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
}
