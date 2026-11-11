import 'package:animations/animations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:paged_slivers/paged_slivers.dart';

import 'support.dart';

void main() {
  late ScriptedFetcher<int, int> fetcher;
  late PagedController<int, int> controller;

  setUp(() {
    fetcher = ScriptedFetcher();
    controller = PagedController(firstKey: 0, fetchPage: fetcher.call);
  });

  tearDown(() => controller.dispose());

  Widget app({bool animate = true}) => sliverApp([
    PagedSliverList<int>(
      view: controller,
      statusBuilders: testStatusBuilders,
      animateTransitions: animate,
      itemBuilder: (context, item, index) => Text('item $item'),
    ),
  ]);

  testWidgets('first-page status changes fade through without a fill', (
    tester,
  ) async {
    await tester.pumpWidget(app());
    fetcher.fail('boom');
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 150));

    // Outgoing progress and incoming error are both mid-transition.
    expect(find.byType(PagedProgressIndicator), findsOneWidget);
    expect(find.byType(PagedErrorIndicator), findsOneWidget);
    final transitions = tester.widgetList<FadeThroughTransition>(
      find.byType(FadeThroughTransition),
    );
    expect(transitions, isNotEmpty);
    for (final transition in transitions) {
      expect(transition.fillColor, Colors.transparent);
    }
    final boxes = tester.widgetList<ColoredBox>(
      find.descendant(
        of: find.byType(PageTransitionSwitcher),
        matching: find.byType(ColoredBox),
      ),
    );
    for (final box in boxes) {
      expect(box.color.a, 0, reason: 'transition must not paint a fill');
    }

    await tester.pump(const Duration(milliseconds: 300));
    expect(find.byType(PagedProgressIndicator), findsNothing);
    expect(find.text('boom'), findsOneWidget);
  });

  testWidgets('footer status changes animate rather than remount', (
    tester,
  ) async {
    await tester.pumpWidget(app());
    fetcher.complete(const PageResult.more([1], nextKey: 1));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    expect(fetcher.keys, [0, 1]);

    final switcher = find.byType(PageTransitionSwitcher);
    expect(switcher, findsOneWidget);
    final before = tester.state(switcher);

    fetcher.fail('next failed');
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 150));

    expect(identical(tester.state(switcher), before), isTrue);
    expect(find.byType(PagedProgressIndicator), findsOneWidget);
    expect(find.byType(PagedErrorIndicator), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 300));
    expect(find.byType(PagedProgressIndicator), findsNothing);
    expect(find.text('next failed'), findsOneWidget);
  });

  testWidgets('the item list fades in', (tester) async {
    await tester.pumpWidget(app());
    fetcher.complete(const PageResult.last([1]));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    final fade = tester.widget<SliverFadeTransition>(
      find.byType(SliverFadeTransition),
    );
    expect(fade.opacity.value, inExclusiveRange(0, 1));

    await tester.pump(const Duration(milliseconds: 300));
    expect(fade.opacity.value, 1);
    expect(find.text('item 1'), findsOneWidget);
  });

  testWidgets('animateTransitions: false switches instantly', (tester) async {
    await tester.pumpWidget(app(animate: false));
    expect(find.byType(PageTransitionSwitcher), findsNothing);
    expect(find.byType(SliverFadeTransition), findsNothing);

    fetcher.fail('boom');
    await tester.pump();
    expect(find.byType(PagedProgressIndicator), findsNothing);
    expect(find.text('boom'), findsOneWidget);

    await tester.tap(find.text('Try again'));
    await tester.pump();
    await tester.pump();
    fetcher.complete(const PageResult.more([1], nextKey: 1));
    await tester.pump();
    expect(find.text('item 1'), findsOneWidget);
    expect(find.byType(PageTransitionSwitcher), findsNothing);

    fetcher.fail('next');
    await tester.pump();
    expect(find.byType(PagedProgressIndicator), findsNothing);
    expect(find.text('next'), findsOneWidget);
  });
}
