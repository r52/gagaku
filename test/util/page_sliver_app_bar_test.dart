import 'package:flutter_test/flutter_test.dart';
import 'package:gagaku/util/ui.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  Future<ScrollController> pumpPage(
    WidgetTester tester, {
    bool withController = true,
    Widget? leading = const BackButton(),
  }) async {
    final controller = ScrollController();
    addTearDown(controller.dispose);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomScrollView(
            controller: controller,
            slivers: [
              PageSliverAppBar(
                title: 'Page title',
                controller: withController ? controller : null,
                leading: leading,
              ),
              SliverList.builder(
                itemCount: 60,
                itemBuilder: (context, index) =>
                    ListTile(title: Text('Item $index')),
              ),
            ],
          ),
        ),
      ),
    );
    return controller;
  }

  testWidgets('tapping the title scrolls to the top', (tester) async {
    final controller = await pumpPage(tester);

    controller.jumpTo(1000.0);
    await tester.pumpAndSettle();

    // The collapsed bar keeps the title pinned; the large title is offstage.
    await tester.tap(find.text('Page title').hitTestable());
    await tester.pumpAndSettle();

    expect(controller.offset, 0.0);
  });

  testWidgets('tapping the title without a controller does nothing', (
    tester,
  ) async {
    final controller = await pumpPage(tester, withController: false);

    controller.jumpTo(1000.0);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Page title').hitTestable());
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(controller.offset, 1000.0);
  });

  testWidgets('shows a back button by default and none when null', (
    tester,
  ) async {
    await pumpPage(tester);
    expect(find.byType(BackButton), findsOneWidget);

    await pumpPage(tester, leading: null);
    expect(find.byType(BackButton), findsNothing);
  });
}
