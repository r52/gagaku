import 'package:flutter_test/flutter_test.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/util/paging.dart';
import 'package:material_ui/material_ui.dart';
import 'package:paged_slivers/paged_slivers.dart';

void main() {
  setUpAll(() async {
    await LocaleSettings.setLocale(AppLocale.en);
  });

  Future<PagedController<int, int>> pumpList(
    WidgetTester tester,
    Future<PageResult<int, int>> Function(int key) fetchPage,
  ) async {
    final controller = PagedController<int, int>(
      firstKey: 0,
      fetchPage: fetchPage,
    );
    addTearDown(controller.dispose);

    await tester.pumpWidget(
      TranslationProvider(
        child: MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => CustomScrollView(
                slivers: [
                  PagedSliverList<int>(
                    view: controller,
                    statusBuilders: pagedStatusBuilders(context),
                    itemBuilder: (context, item, index) => Text('item $item'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    return controller;
  }

  testWidgets('the empty indicator uses the translated message', (
    tester,
  ) async {
    await pumpList(tester, (_) async => const PageResult.last([]));

    expect(find.text(t.errors.noitems), findsOneWidget);
  });

  testWidgets('the retry button uses the translated label', (tester) async {
    await pumpList(tester, (_) async => throw StateError('boom'));

    expect(find.text('Bad state: boom'), findsOneWidget);
    expect(find.widgetWithText(OutlinedButton, t.ui.retry), findsOneWidget);
  });
}
