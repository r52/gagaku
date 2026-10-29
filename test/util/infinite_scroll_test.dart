import 'package:flutter_test/flutter_test.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/util/infinite_scroll.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  setUpAll(() async {
    await LocaleSettings.setLocale(AppLocale.en);
  });

  Future<void> pumpList(
    WidgetTester tester,
    PagingState<int, int> state,
  ) async {
    await tester.pumpWidget(
      TranslationProvider(
        child: MaterialApp(
          home: Scaffold(
            body: CustomScrollView(
              slivers: [
                PagedSliverList<int, int>(
                  state: state,
                  fetchNextPage: () {},
                  builderDelegate: ErrorReportingPagedChildBuilderDelegate(
                    error: state.error,
                    fetchNextPage: () {},
                    itemBuilder: (context, item, index) => Text('item $item'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // The package's own defaults build SDK `material.dart` widgets, which are
  // distinct types from the `material_ui` ones matched here.
  testWidgets('first page loading uses the material_ui indicator', (
    tester,
  ) async {
    await pumpList(tester, PagingState<int, int>());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('next page loading uses the material_ui indicator', (
    tester,
  ) async {
    await pumpList(
      tester,
      PagingState<int, int>(
        pages: const [
          [1, 2],
        ],
        keys: const [0],
        isLoading: true,
      ),
    );

    expect(find.text('item 2'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('an empty listing shows the translated empty indicator', (
    tester,
  ) async {
    await pumpList(
      tester,
      PagingState<int, int>(
        pages: const [<int>[]],
        keys: const [0],
        hasNextPage: false,
      ),
    );

    expect(find.text(t.errors.noitems), findsOneWidget);
    expect(find.text('No items found'), findsNothing);
  });

  testWidgets('errors are reported with a retry action', (tester) async {
    await pumpList(tester, PagingState<int, int>(error: 'boom'));

    expect(find.text('boom'), findsOneWidget);
    expect(find.byType(OutlinedButton), findsOneWidget);
  });
}
