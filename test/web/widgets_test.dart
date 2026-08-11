import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/model/model.dart';
import 'package:gagaku/objectbox.g.dart';
import 'package:gagaku/web/model/model.dart';
import 'package:gagaku/web/model/types.dart';
import 'package:gagaku/web/settings.dart';
import 'package:gagaku/web/widgets.dart';

void main() {
  late Store store;

  setUpAll(() async {
    await LocaleSettings.setLocale(AppLocale.en);
    store = Store(
      getObjectBoxModel(),
      directory: 'memory:gagaku_web_widgets_test_db',
    );
    GagakuData().store = store;
  });

  setUp(() {
    store.box<WebFavoritesList>().removeAll();
    store.box<HistoryLink>().removeAll();
    store.box<WebFavoritesList>().put(
      WebFavoritesList(id: historyListUUID, name: 'extension_history'),
    );
  });

  tearDownAll(() {
    store.close();
  });

  testWidgets('renaming a category updates and marks its tile', (tester) async {
    final category = WebFavoritesList(id: 'reading', name: 'Reading');

    await tester.pumpWidget(
      TranslationProvider(
        child: MaterialApp(home: CategoryManager(categories: [category])),
      ),
    );

    await tester.tap(find.byTooltip(t.ui.rename));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField), 'Favorites');
    await tester.pump();
    await tester.tap(find.widgetWithText(ElevatedButton, t.ui.rename));
    await tester.pumpAndSettle();

    expect(find.text('Reading'), findsNothing);
    expect(find.text('Favorites'), findsOneWidget);
    expect(find.text(t.ui.edited), findsOneWidget);
  });

  testWidgets('allows deleting the final category', (tester) async {
    final category = WebFavoritesList(id: 'reading', name: 'Reading');

    await tester.pumpWidget(
      TranslationProvider(
        child: MaterialApp(home: CategoryManager(categories: [category])),
      ),
    );

    await tester.tap(find.byTooltip(t.ui.delete));
    await tester.pumpAndSettle();
    expect(find.text(t.webSources.settings.categoryDelete), findsOneWidget);
    await tester.tap(find.text(t.ui.yes));
    await tester.pumpAndSettle();

    expect(find.text('Reading'), findsNothing);
  });

  testWidgets('creates a first category and favorites the title', (
    tester,
  ) async {
    final link = HistoryLink.fromSeries(
      title: 'Test title',
      series: const WebSeriesRef.extension(
        sourceId: 'source-1',
        mangaId: 'manga-1',
      ),
    );

    await tester.pumpWidget(
      TranslationProvider(
        child: MaterialApp(
          home: Scaffold(
            body: Center(child: FavoritesButton(link: link)),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.favorite_border));
    await tester.pumpAndSettle();

    expect(find.text(t.webSources.settings.newCategory), findsOneWidget);
    await tester.tap(find.text(t.webSources.settings.newCategory));
    await tester.pumpAndSettle();

    expect(find.byType(NewCategoryDialog), findsOneWidget);
    await tester.enterText(find.byType(TextFormField), 'Reading');
    await tester.pump();
    await tester.tap(find.widgetWithText(ElevatedButton, t.ui.add));
    await tester.pumpAndSettle();

    final query = store
        .box<WebFavoritesList>()
        .query(WebFavoritesList_.id.notEquals(historyListUUID))
        .build();
    addTearDown(query.close);
    final categories = query.find();

    expect(categories, hasLength(1));
    expect(categories.single.name, 'Reading');
    expect(categories.single.list.map((item) => item.url), [link.url]);

    for (var attempt = 0; attempt < 100; attempt++) {
      if (WebFavoritesManager().getFavoritedListIdsOfLink(link).isNotEmpty) {
        break;
      }
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 10)),
      );
      await tester.pump();
    }

    expect(WebFavoritesManager().getFavoritedListIdsOfLink(link), isNotEmpty);
    await tester.pump();
    expect(find.byIcon(Icons.favorite), findsOneWidget);
  });
}
