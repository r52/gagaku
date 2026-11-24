import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:paged_slivers/paged_slivers.dart';
import 'package:paged_slivers/src/paged_sliver_core.dart';

import 'support.dart';

void main() {
  late ScriptedFetcher<int, int> fetcher;
  late PagedController<int, int> controller;

  setUp(() {
    fetcher = ScriptedFetcher();
    controller = PagedController(firstKey: 0, fetchPage: fetcher.call);
  });

  tearDown(() => controller.dispose());

  Widget list({
    PagedView<int>? view,
    PagedStatusBuilders builders = testStatusBuilders,
    bool shrinkWrap = false,
    bool useSuperSliverList = false,
  }) => PagedSliverList<int>(
    view: view ?? controller,
    statusBuilders: builders,
    shrinkWrapFirstPageIndicators: shrinkWrap,
    useSuperSliverList: useSuperSliverList,
    itemBuilder: (context, item, index) =>
        SizedBox(height: 100, child: Text('item $item')),
  );

  /// Completes the pending fetch and lets the layout rebuild and finish its
  /// transitions.
  Future<void> resolve(WidgetTester tester, PageResult<int, int> result) async {
    fetcher.complete(result);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
  }

  Future<void> failWith(WidgetTester tester, Object error) async {
    fetcher.fail(error);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
  }

  group('status slivers', () {
    testWidgets('first load fetches on attach and fills the viewport', (
      tester,
    ) async {
      await tester.pumpWidget(sliverApp([list()]));

      expect(fetcher.keys, [0]);
      expect(find.byType(SliverFillRemaining), findsOneWidget);
      expect(find.byType(PagedProgressIndicator), findsOneWidget);
    });

    testWidgets('shrink-wrapped first indicators use a box adapter', (
      tester,
    ) async {
      await tester.pumpWidget(sliverApp([list(shrinkWrap: true)]));

      expect(find.byType(SliverFillRemaining), findsNothing);
      expect(
        find.ancestor(
          of: find.byType(PagedProgressIndicator),
          matching: find.byType(SliverToBoxAdapter),
        ),
        findsOneWidget,
      );
    });

    testWidgets('first error shows the error and retries', (tester) async {
      await tester.pumpWidget(sliverApp([list()]));
      await failWith(tester, 'boom');

      expect(find.text('boom'), findsOneWidget);
      expect(find.text('Try again'), findsOneWidget);

      await tester.tap(find.text('Try again'));
      await tester.pump();
      expect(fetcher.keys, [0, 0]);
      expect(find.byType(PagedProgressIndicator), findsOneWidget);
    });

    testWidgets('an empty result shows the empty message', (tester) async {
      await tester.pumpWidget(sliverApp([list()]));
      await resolve(tester, const PageResult.last([]));

      expect(find.text('Nothing here'), findsOneWidget);
      expect(find.byType(PagedProgressIndicator), findsNothing);
    });

    testWidgets('items with more pages show next-page progress', (
      tester,
    ) async {
      await tester.pumpWidget(sliverApp([list()]));
      await resolve(tester, const PageResult.more([1, 2], nextKey: 2));

      expect(find.text('item 1'), findsOneWidget);
      expect(find.text('item 2'), findsOneWidget);
      expect(find.byType(PagedProgressIndicator), findsOneWidget);
      // Two items are within the threshold, so the next page is requested.
      expect(fetcher.keys, [0, 2]);
    });

    testWidgets('next-page errors keep the items and retry', (tester) async {
      await tester.pumpWidget(sliverApp([list()]));
      await resolve(tester, const PageResult.more([1], nextKey: 1));
      await failWith(tester, 'later');

      expect(find.text('item 1'), findsOneWidget);
      expect(find.text('later'), findsOneWidget);
      expect(fetcher.keys, [0, 1]);

      await tester.tap(find.text('Try again'));
      await tester.pump();
      expect(fetcher.keys, [0, 1, 1]);
    });

    testWidgets('a complete list has no footer unless endBuilder is set', (
      tester,
    ) async {
      await tester.pumpWidget(sliverApp([list()]));
      await resolve(tester, const PageResult.last([1]));
      expect(find.text('item 1'), findsOneWidget);
      expect(find.byType(PagedProgressIndicator), findsNothing);

      await tester.pumpWidget(
        sliverApp([
          list(
            builders: testStatusBuilders.copyWith(
              endBuilder: (_) => const Text('The end'),
            ),
          ),
        ]),
      );
      expect(find.text('The end'), findsOneWidget);
    });

    testWidgets('SuperSliverList backing renders items and footer', (
      tester,
    ) async {
      await tester.pumpWidget(sliverApp([list(useSuperSliverList: true)]));
      await resolve(tester, const PageResult.more([1, 2], nextKey: 2));

      expect(find.byType(SliverList), findsNothing);
      expect(find.text('item 2'), findsOneWidget);
      expect(find.byType(PagedProgressIndicator), findsOneWidget);
    });
  });

  testWidgets('the trigger uses the projected count', (tester) async {
    final scroll = ScrollController();
    addTearDown(scroll.dispose);
    final evens = controller.project(
      (items) => [
        for (final i in items)
          if (i.isEven) i,
      ],
    );

    await tester.pumpWidget(
      sliverApp([list(view: evens)], controller: scroll, cacheExtent: 0),
    );
    // 20 fetched items project to 10; the 600px viewport shows items 0-5.
    await resolve(
      tester,
      PageResult.more(List.generate(20, (i) => i), nextKey: 20),
    );
    expect(find.text('item 10'), findsOneWidget);
    expect(find.text('item 12'), findsNothing);
    expect(fetcher.calls, 1);

    // Building projected index 6 (10 - 1 - threshold 3) requests the next
    // page. A trigger based on the 20 source items would not fire until 16.
    scroll.jumpTo(150);
    await tester.pump();
    expect(find.text('item 12'), findsOneWidget);
    expect(fetcher.keys, [0, 20]);
  });

  testWidgets('build does not fetch without the scheduler', (tester) async {
    final scheduler = ManualScheduler();
    final manual = PagedController<int, int>(
      firstKey: 0,
      fetchPage: fetcher.call,
      scheduler: scheduler.call,
    );
    addTearDown(manual.dispose);

    await tester.pumpWidget(sliverApp([list(view: manual)]));
    await tester.pumpWidget(sliverApp([list(view: manual)]));
    expect(fetcher.calls, 0);
    expect(scheduler.pending, 1);

    scheduler.flush();
    expect(fetcher.calls, 1);
    await tester.pump();
    expect(tester.takeException(), isNull);
  });

  group('separated lists', () {
    Widget separated(PagedStatusBuilders builders) =>
        PagedSliverList<int>.separated(
          view: controller,
          statusBuilders: builders,
          itemBuilder: (context, item, index) => Text('item $item'),
          separatorBuilder: (context, index) => Text('sep $index'),
        );

    testWidgets('without a footer there is no trailing separator', (
      tester,
    ) async {
      await tester.pumpWidget(sliverApp([separated(testStatusBuilders)]));
      await resolve(tester, const PageResult.last([1, 2, 3]));

      expect(find.textContaining('sep'), findsNWidgets(2));
      expect(find.text('sep 2'), findsNothing);
    });

    testWidgets('a footer follows a trailing separator', (tester) async {
      await tester.pumpWidget(
        sliverApp([
          separated(
            testStatusBuilders.copyWith(endBuilder: (_) => const Text('end')),
          ),
        ]),
      );
      await resolve(tester, const PageResult.last([1, 2, 3]));

      expect(find.textContaining('sep'), findsNWidgets(3));
      expect(find.text('end'), findsOneWidget);
      expect(
        tester.getTopLeft(find.text('end')).dy,
        greaterThan(tester.getTopLeft(find.text('sep 2')).dy),
      );
    });
  });

  group('pagedChildDelegate', () {
    const footer = KeyedSubtree(key: pagedFooterKey, child: SizedBox());
    Widget item(BuildContext context, int index) => const SizedBox();
    Widget sep(BuildContext context, int index) => const SizedBox();

    test('child counts', () {
      int count({required int items, bool separated = false, Widget? tail}) =>
          pagedChildDelegate(
            itemCount: items,
            itemBuilder: item,
            separatorBuilder: separated ? sep : null,
            footer: tail,
          ).childCount!;

      expect(count(items: 3), 3);
      expect(count(items: 3, tail: footer), 4);
      expect(count(items: 3, separated: true), 5);
      expect(count(items: 3, separated: true, tail: footer), 7);
      expect(count(items: 0, separated: true), 0);
      expect(count(items: 0, separated: true, tail: footer), 1);
    });

    test('findChildIndexCallback maps item keys and the footer key', () {
      int? find(ValueKey<int> key) => key.value < 5 ? key.value : null;

      final plain = pagedChildDelegate(
        itemCount: 5,
        itemBuilder: item,
        footer: footer,
        findChildIndexCallback: (key) => find(key as ValueKey<int>),
      );
      expect(plain.findIndexByKey(const ValueKey(3)), 3);
      expect(plain.findIndexByKey(const ValueKey(9)), isNull);
      expect(plain.findIndexByKey(pagedFooterKey), 5);

      final separated = pagedChildDelegate(
        itemCount: 5,
        itemBuilder: item,
        separatorBuilder: sep,
        footer: footer,
        findChildIndexCallback: (key) => find(key as ValueKey<int>),
      );
      expect(separated.findIndexByKey(const ValueKey(3)), 6);
      expect(separated.findIndexByKey(pagedFooterKey), 10);
    });

    test('the footer key never reaches the app callback', () {
      final delegate = pagedChildDelegate(
        itemCount: 2,
        itemBuilder: item,
        footer: footer,
        // Casts like the chapter feed's callback.
        findChildIndexCallback: (key) => (key as ValueKey<int>).value,
      );
      expect(delegate.findIndexByKey(pagedFooterKey), 2);

      final noFooter = pagedChildDelegate(itemCount: 2, itemBuilder: item);
      expect(noFooter.findIndexByKey(pagedFooterKey), isNull);
    });
  });

  group('grid', () {
    Widget grid() => PagedSliverGrid<int>(
      view: controller,
      statusBuilders: testStatusBuilders,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 100,
      ),
      itemBuilder: (context, item, index) => Text('tile $item'),
    );

    testWidgets('next-page progress spans the full width', (tester) async {
      await tester.pumpWidget(sliverApp([grid()]));
      await resolve(tester, const PageResult.more([1, 2], nextKey: 2));

      expect(find.text('tile 2'), findsOneWidget);
      expect(tester.getSize(find.byKey(pagedFooterKey)).width, 800);
      expect(tester.getCenter(find.byType(CircularProgressIndicator)).dx, 400);
      expect(
        tester.getTopLeft(find.byType(PagedProgressIndicator)).dy,
        greaterThanOrEqualTo(tester.getBottomLeft(find.text('tile 1')).dy),
      );
    });

    testWidgets('next-page errors span the full width', (tester) async {
      await tester.pumpWidget(sliverApp([grid()]));
      await resolve(tester, const PageResult.more([1], nextKey: 1));
      await failWith(tester, 'grid error');

      expect(find.text('grid error'), findsOneWidget);
      // The footer row spans the grid; the indicator is centered within it.
      expect(tester.getSize(find.byKey(pagedFooterKey)).width, 800);
      expect(tester.getCenter(find.byType(PagedErrorIndicator)).dx, 400);
    });
  });
}
