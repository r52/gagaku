import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gagaku/util/material_hooks.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  testWidgets(
    'tabs preserve selection and recreate during an active animation',
    (tester) async {
      final length = ValueNotifier(3);
      final rebuild = ValueNotifier(0);
      addTearDown(length.dispose);
      addTearDown(rebuild.dispose);
      late TabController controller;

      await tester.pumpWidget(
        MaterialApp(
          home: HookBuilder(
            builder: (context) {
              useListenable(rebuild);
              final count = useValueListenable(length);
              controller = useMaterialTabController(
                initialLength: count,
                initialIndex: count == 3 ? 1 : 0,
                keys: [count],
              );
              return Scaffold(
                appBar: AppBar(
                  bottom: TabBar(
                    controller: controller,
                    tabs: [for (var i = 0; i < count; i++) Tab(text: 'Tab $i')],
                  ),
                ),
                body: TabBarView(
                  controller: controller,
                  children: [
                    for (var i = 0; i < count; i++)
                      Center(child: Text('Page $i')),
                  ],
                ),
              );
            },
          ),
        ),
      );
      expect(find.text('Page 1'), findsOneWidget);

      await tester.tap(find.text('Tab 2'));
      await tester.pumpAndSettle();
      expect(find.text('Page 2'), findsOneWidget);
      final original = controller;
      rebuild.value++;
      await tester.pump();
      expect(controller, same(original));
      expect(controller.index, 2);

      controller.animateTo(0);
      await tester.pump(const Duration(milliseconds: 30));
      expect(controller.indexIsChanging, isTrue);
      length.value = 2;
      await tester.pumpAndSettle();
      expect(controller, isNot(same(original)));
      expect(controller.length, 2);
      expect(find.text('Page 0'), findsOneWidget);
      expect(() => original.addListener(() {}), throwsFlutterError);

      // Favorites may briefly have no categories, then gain a new one.
      length.value = 0;
      await tester.pumpAndSettle();
      expect(controller.length, 0);
      length.value = 1;
      await tester.pumpAndSettle();
      expect(find.text('Page 0'), findsOneWidget);

      final last = controller;
      await tester.pumpWidget(const SizedBox.shrink());
      expect(() => last.addListener(() {}), throwsFlutterError);
      expect(tester.binding.transientCallbackCount, 0);
    },
  );

  testWidgets('search retains the selected query until its key changes', (
    tester,
  ) async {
    final generation = ValueNotifier(0);
    final rebuild = ValueNotifier(0);
    addTearDown(generation.dispose);
    addTearDown(rebuild.dispose);
    late SearchController controller;

    await tester.pumpWidget(
      MaterialApp(
        home: HookBuilder(
          builder: (context) {
            useListenable(rebuild);
            final key = useValueListenable(generation);
            controller = useMaterialSearchController(keys: [key]);
            return Scaffold(
              body: SearchAnchor(
                searchController: controller,
                builder: (context, controller) => SearchBar(
                  controller: controller,
                  onTap: controller.openView,
                ),
                suggestionsBuilder: (context, controller) => [
                  ListTile(
                    title: const Text('Selected result'),
                    onTap: () => controller.closeView('Selected result'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );

    await tester.tap(find.byType(SearchBar));
    await tester.pumpAndSettle();
    expect(controller.isOpen, isTrue);
    await tester.enterText(find.byType(TextField).last, 'query');
    await tester.pumpAndSettle();
    expect(controller.text, 'query');
    await tester.tap(find.text('Selected result'));
    await tester.pumpAndSettle();
    expect(controller.isOpen, isFalse);
    expect(controller.text, 'Selected result');

    final original = controller;
    rebuild.value++;
    await tester.pump();
    expect(controller, same(original));
    expect(find.text('Selected result'), findsOneWidget);

    generation.value++;
    await tester.pump();
    expect(controller, isNot(same(original)));
    expect(controller.text, isEmpty);
    expect(() => original.addListener(() {}), throwsFlutterError);

    final last = controller;
    await tester.pumpWidget(const SizedBox.shrink());
    expect(() => last.addListener(() {}), throwsFlutterError);
  });
}
