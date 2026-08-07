import 'package:async/async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gagaku/model/config.dart';
import 'package:gagaku/objectbox.g.dart';
import 'package:gagaku/web/model/config.dart';

void main() {
  group('ObjectBox store-wide change observation', () {
    late Store store;
    late StreamQueue<List<Type>> changes;

    setUp(() {
      store = Store(
        getObjectBoxModel(),
        directory: 'memory:gagaku_sync_observation_test_db',
      );
      changes = StreamQueue(store.entityChanges);
    });

    tearDown(() async {
      await changes.cancel(immediate: true);
      store.close();
    });

    test('reports direct writes and deletes', () async {
      final box = store.box<GagakuConfig>();
      final id = box.put(GagakuConfig(updateChannel: 'synthetic'));

      expect(await _nextChange(changes), contains(GagakuConfig));

      box.remove(id);

      expect(await _nextChange(changes), contains(GagakuConfig));
    });

    test('reports every entity type changed by one transaction', () async {
      store.runInTransaction(TxMode.write, () {
        store.box<GagakuConfig>().put(GagakuConfig(updateChannel: 'synthetic'));
        store.box<ExtensionStateDB>().put(
          ExtensionStateDB(
            state: {
              'synthetic-extension': {'synthetic-key': 'synthetic-value'},
            },
          ),
        );
      });

      expect(
        await _nextChange(changes),
        containsAll(<Type>[GagakuConfig, ExtensionStateDB]),
      );
    });

    test('reports writes from an asynchronous transaction', () async {
      await store.runInTransactionAsync(TxMode.write, (transactionStore, _) {
        transactionStore.box<GagakuConfig>().put(
          GagakuConfig(updateChannel: 'synthetic'),
        );
      }, null);

      expect(await _nextChange(changes), contains(GagakuConfig));
    });

    test('exposes extension-state-style write bursts for debouncing', () async {
      final box = store.box<ExtensionStateDB>();
      final state = ExtensionStateDB();

      for (var index = 0; index < 10; index++) {
        state.state['synthetic-extension'] = {'operation-step': index};
        box.put(state);
      }

      final observed = <List<Type>>[];
      for (var index = 0; index < 10; index++) {
        observed.add(await _nextChange(changes));
      }

      expect(observed, hasLength(10));
      expect(observed, everyElement(contains(ExtensionStateDB)));
    });
  });
}

Future<List<Type>> _nextChange(StreamQueue<List<Type>> changes) =>
    changes.next.timeout(const Duration(seconds: 5));
