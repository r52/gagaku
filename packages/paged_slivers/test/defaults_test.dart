import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:paged_slivers/paged_slivers.dart';

import 'support.dart';

void main() {
  Future<void> pumpBuilt(
    WidgetTester tester,
    Widget Function(BuildContext context) build,
  ) => tester.pumpWidget(
    MaterialApp(
      home: Scaffold(body: Builder(builder: build)),
    ),
  );

  testWidgets('progress uses the material_ui indicator with padding', (
    tester,
  ) async {
    await pumpBuilt(tester, testStatusBuilders.buildFirstProgress);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(
      tester
          .widget<PagedProgressIndicator>(find.byType(PagedProgressIndicator))
          .padding,
      PagedProgressIndicator.firstPagePadding,
    );

    await pumpBuilt(tester, testStatusBuilders.buildNextProgress);
    expect(
      tester
          .widget<PagedProgressIndicator>(find.byType(PagedProgressIndicator))
          .padding,
      PagedProgressIndicator.nextPagePadding,
    );
  });

  testWidgets('empty shows the provided message as titleLarge', (tester) async {
    await pumpBuilt(tester, testStatusBuilders.buildEmpty);

    final text = tester.widget<Text>(find.text('Nothing here'));
    final context = tester.element(find.text('Nothing here'));
    expect(text.style, Theme.of(context).textTheme.titleLarge);
  });

  testWidgets('errors show the error verbatim and a labelled retry', (
    tester,
  ) async {
    var retries = 0;
    await pumpBuilt(
      tester,
      (context) =>
          testStatusBuilders.buildNextError(context, 'boom', () => retries++),
    );

    expect(find.text('boom'), findsOneWidget);
    expect(find.byType(SelectionArea), findsOneWidget);
    expect(find.widgetWithText(OutlinedButton, 'Try again'), findsOneWidget);
    expect(find.byIcon(Icons.refresh), findsOneWidget);

    await tester.tap(find.text('Try again'));
    expect(retries, 1);
  });

  testWidgets('custom builders override the defaults', (tester) async {
    final builders = testStatusBuilders.copyWith(
      emptyBuilder: (_) => const Text('custom empty'),
      firstErrorBuilder: (context, error, retry) => Text('custom $error'),
    );

    await pumpBuilt(tester, builders.buildEmpty);
    expect(find.text('custom empty'), findsOneWidget);
    expect(find.byType(PagedEmptyIndicator), findsNothing);

    await pumpBuilt(
      tester,
      (context) => builders.buildFirstError(context, 'x', () {}),
    );
    expect(find.text('custom x'), findsOneWidget);
  });
}
