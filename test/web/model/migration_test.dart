import 'package:flutter_test/flutter_test.dart';
import 'package:gagaku/objectbox.g.dart';
import 'package:gagaku/model/model.dart';
import 'package:gagaku/web/model/config.dart';
import 'package:gagaku/web/model/model.dart';
import 'package:gagaku/web/model/types.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  group('Extension Migration Tests', () {
    late Store store;
    late ProviderContainer container;

    setUpAll(() {
      store = Store(
        getObjectBoxModel(),
        directory: 'memory:gagaku_migration_test_db',
      );
      GagakuData().store = store;
    });

    setUp(() {
      store.box<ExtensionStateDB>().removeAll();
      store.box<ReadMarkersDB>().removeAll();
      store.box<HistoryLink>().removeAll();
      store.box<WebFavoritesList>().removeAll();
      store.box<WebSourceInfo>().removeAll();

      container = ProviderContainer();
    });

    tearDownAll(() {
      store.close();
    });

    test('ExtensionState migration', () {
      final notifier = container.read(extensionStateProvider.notifier);

      // Setup initial state
      notifier.setExtensionState('old_ext', {'some_key': 'some_value'});

      expect(notifier.getExtensionState('old_ext'), {'some_key': 'some_value'});
      expect(notifier.getExtensionState('new_ext'), isNull);

      // Perform migration
      notifier.migrate('old_ext', 'new_ext');

      // Verify state was mapped in riverpod state
      expect(notifier.getExtensionState('old_ext'), isNull);
      expect(notifier.getExtensionState('new_ext'), {'some_key': 'some_value'});

      // Verify state persisted accurately to objectbox DB
      final query = store
          .box<ExtensionStateDB>()
          .query(ExtensionStateDB_.secure.equals(false))
          .build();
      final db = query.findUnique();
      query.close();

      expect(db?.state['new_ext'], {'some_key': 'some_value'});
      expect(db?.state.containsKey('old_ext'), isFalse);
    });

    test('ExtensionSecureState migration', () {
      final notifier = container.read(extensionSecureStateProvider.notifier);

      // Setup initial state
      notifier.setExtensionState('old_secure_ext', {'token': 'secretdummy'});

      // Perform migration
      notifier.migrate('old_secure_ext', 'new_secure_ext');

      // Verify correct state transfer
      expect(notifier.getExtensionState('old_secure_ext'), isNull);
      expect(notifier.getExtensionState('new_secure_ext'), {
        'token': 'secretdummy',
      });

      // Verify persistence
      final query = store
          .box<ExtensionStateDB>()
          .query(ExtensionStateDB_.secure.equals(true))
          .build();
      final db = query.findUnique();
      query.close();

      expect(db?.state['new_secure_ext'], {'token': 'secretdummy'});
      expect(db?.state.containsKey('old_secure_ext'), isFalse);
    });

    test('WebReadMarkers migration', () async {
      final notifier = container.read(webReadMarkersProvider.notifier);

      // Seed data asynchronously
      await notifier.set('old_ext/manga_1', 'chapter_1', true);
      await notifier.set('old_ext/manga_1', 'chapter_2', true);
      await notifier.set('unrelated_ext/manga_1', 'chapter_1', true);

      // Ensure records are set properly
      var readMarkers = await notifier.future;
      expect(readMarkers.markers.containsKey('old_ext/manga_1'), isTrue);
      expect(
        readMarkers.markers['old_ext/manga_1']?.contains('chapter_1'),
        isTrue,
      );

      // Perform migration
      await notifier.migrate('old_ext', 'new_ext');

      readMarkers = await notifier.future;

      // Verify migration details
      expect(
        readMarkers.markers.containsKey('unrelated_ext/manga_1'),
        isTrue,
        reason: 'Unrelated extension data should not be touched',
      );
      expect(
        readMarkers.markers.containsKey('old_ext/manga_1'),
        isFalse,
        reason: 'Old extension markers should have been removed',
      );
      expect(
        readMarkers.markers.containsKey('new_ext/manga_1'),
        isTrue,
        reason: 'Markers should be moved to the new extension',
      );
      expect(
        readMarkers.markers['new_ext/manga_1']?.contains('chapter_1'),
        isTrue,
      );
      expect(
        readMarkers.markers['new_ext/manga_1']?.contains('chapter_2'),
        isTrue,
      );

      // Verify persistence in DB
      final query = store.box<ReadMarkersDB>().query().build();
      final db = query.findUnique();
      query.close();
      expect(db?.markers.containsKey('new_ext/manga_1'), isTrue);
    });

    test('HistoryLink direct DB migration replicates UI behavior', () {
      final historyBox = store.box<HistoryLink>();

      // Seed history links for old and unrelated extensions
      final oldHandle = SourceHandler(
        type: SourceType.source,
        sourceId: 'old_ext',
        location: 'item_1',
      );
      final link1 = HistoryLink(
        title: 'Manga 1',
        url: 'old_ext/item_1',
        cover: 'cover.jpg',
        handle: oldHandle,
      );
      final link2 = HistoryLink(
        title: 'Unrelated',
        url: 'unrelated/item_2',
        cover: 'cover.jpg',
        handle: SourceHandler(
          type: SourceType.source,
          sourceId: 'unrelated',
          location: 'item_2',
        ),
      );

      historyBox.putMany([link1, link2]);

      // Replicate the migration logic written in the UI component
      final String oldId = 'old_ext';
      final String newId = 'new_ext';

      final query = historyBox.query().build();
      final links = query
          .find()
          .where((link) => link.handle?.sourceId == oldId)
          .toList();
      query.close();

      for (final link in links) {
        if (link.url.startsWith('$oldId/')) {
          link.url = link.url.replaceFirst('$oldId/', '$newId/');
        }
        if (link.handle != null) {
          link.handle = link.handle!.copyWith(sourceId: newId);
        }
      }
      historyBox.putMany(links);

      // Verify the changes
      final migratedQuery = historyBox
          .query(HistoryLink_.url.equals('new_ext/item_1'))
          .build();
      final migratedLink = migratedQuery.findUnique();
      migratedQuery.close();

      expect(migratedLink, isNotNull);
      expect(migratedLink?.url, 'new_ext/item_1');
      expect(migratedLink?.handle?.sourceId, 'new_ext');

      final unrelatedQuery = historyBox
          .query(HistoryLink_.url.equals('unrelated/item_2'))
          .build();
      final unrelatedLink = unrelatedQuery.findUnique();
      unrelatedQuery.close();

      expect(unrelatedLink, isNotNull);
      expect(unrelatedLink?.url, 'unrelated/item_2');
      expect(unrelatedLink?.handle?.sourceId, 'unrelated');
    });
  });
}
