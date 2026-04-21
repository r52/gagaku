import 'package:flutter_test/flutter_test.dart';
import 'package:gagaku/objectbox.g.dart';
import 'package:gagaku/model/model.dart';
import 'package:gagaku/web/model/config.dart';
import 'package:gagaku/web/model/model.dart';
import 'package:gagaku/web/model/types.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  group('Extension Pruning Tests', () {
    late Store store;
    late ProviderContainer container;

    setUpAll(() {
      store = Store(
        getObjectBoxModel(),
        directory: 'memory:gagaku_prune_test_db',
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

    test('ExtensionState pruning logic filters properly', () {
      final notifier = container.read(extensionStateProvider.notifier);

      notifier.setExtensionState('installed_ext', {'val': 1});
      notifier.setExtensionState('uninstalled_ext', {'val': 2});

      // Simulate checking installed extensions
      final installedIds = {'installed_ext'};
      final staleKeys = notifier.getStaleKeys(installedIds);

      expect(staleKeys, contains('uninstalled_ext'));
      expect(staleKeys.contains('installed_ext'), isFalse);

      // Prune
      notifier.pruneKeys(staleKeys);

      expect(notifier.getExtensionState('installed_ext'), {'val': 1});
      expect(notifier.getExtensionState('uninstalled_ext'), isNull);

      // Check Objectbox directly
      final query = store
          .box<ExtensionStateDB>()
          .query(ExtensionStateDB_.secure.equals(false))
          .build();
      final db = query.findUnique();
      query.close();
      expect(db?.state.containsKey('uninstalled_ext'), isFalse);
    });

    test('Test ExtensionSecureState pruning clears orphaned secure tokens', () {
      final notifier = container.read(extensionSecureStateProvider.notifier);

      notifier.setExtensionState('ext1', {'tok': 'secureA'});
      notifier.setExtensionState('ext2', {'tok': 'secureB'});

      final staleKeys = notifier.getStaleKeys({
        'ext2',
      }); // Assume only ext2 is still installed
      expect(staleKeys.single, 'ext1');

      notifier.pruneKeys(staleKeys);
      expect(notifier.getExtensionState('ext1'), isNull);
    });

    test(
      'WebReadMarkers pruning validates against HistoryStore keys properly',
      () async {
        final notifier = container.read(webReadMarkersProvider.notifier);

        await notifier.set('ext/manga_1', 'ch1', true);
        await notifier.set('ext/manga_2', 'ch2', true);

        await notifier.future; // wait for completion

        final validUrls = {'ext/manga_1'};

        final staleKeys = await notifier.getStaleKeys(validUrls);
        expect(staleKeys, contains('ext/manga_2'));
        expect(staleKeys.contains('ext/manga_1'), isFalse);

        await notifier.pruneKeys(staleKeys);

        final db = await notifier.future;
        expect(db.markers.containsKey('ext/manga_2'), isFalse);
        expect(db.markers.containsKey('ext/manga_1'), isTrue);
      },
    );
  });
}
