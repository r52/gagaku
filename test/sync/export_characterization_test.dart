import 'package:flutter_test/flutter_test.dart';
import 'package:gagaku/model/config.dart';
import 'package:gagaku/model/model.dart';
import 'package:gagaku/objectbox.g.dart';
import 'package:gagaku/settings/convert.dart';
import 'package:gagaku/sync/protocol.dart';
import 'package:gagaku/web/model/config.dart';
import 'package:gagaku/web/model/model.dart' show historyListUUID;
import 'package:gagaku/web/model/types.dart';

void main() {
  test('characterizes a generated representative-size export', () async {
    final store = Store(
      getObjectBoxModel(),
      directory: 'memory:gagaku_sync_export_characterization_db',
    );
    addTearDown(store.close);
    GagakuData().store = store;

    store.box<GagakuConfig>().put(GagakuConfig(updateChannel: 'synthetic'));

    final padding = List.filled(290, 'x').join();
    final links = List.generate(
      301,
      (index) => HistoryLink(
        title: 'Synthetic series $index $padding',
        url: 'https://example.invalid/series/$index',
        cover: 'https://example.invalid/cover/$index.jpg',
        lastAccessed: DateTime.utc(2026, 1, 1).add(Duration(minutes: index)),
      ),
    );
    store.box<HistoryLink>().putMany(links);

    final history = WebFavoritesList(
      id: historyListUUID,
      name: 'Synthetic history',
    )..list.addAll(links.take(50));
    final favorites = List.generate(
      5,
      (index) => WebFavoritesList(
        id: 'synthetic-list-$index',
        name: 'Synthetic list $index',
      )..list.addAll(links.skip(index * 10).take(10)),
    );
    store.box<WebFavoritesList>().putMany([history, ...favorites]);

    final extensionState = ExtensionStateDB(
      state: {
        for (var extension = 0; extension < 38; extension++)
          'synthetic-extension-$extension': {
            for (var key = 0; key < 5; key++)
              'synthetic-key-$key': 'synthetic-value-$extension-$key',
          },
      },
    );
    store.box<ExtensionStateDB>().put(extensionState);

    final codec = GagakuDataCodec(store: store);
    for (var run = 1; run <= 3; run++) {
      final exportStopwatch = Stopwatch()..start();
      final payload = await codec.export();
      exportStopwatch.stop();

      final prepareStopwatch = Stopwatch()..start();
      final prepared = await SyncSnapshotCodec.preparePayload(payload);
      prepareStopwatch.stop();

      // Characterization output only; timing is deliberately not asserted.
      // ignore: avoid_print
      print(
        'PHASE9_EXPORT run=$run bytes=${prepared.payloadLength} '
        'exportMicroseconds=${exportStopwatch.elapsedMicroseconds} '
        'backgroundPrepareMicroseconds='
        '${prepareStopwatch.elapsedMicroseconds}',
      );
      expect(payload, isA<Map<String, dynamic>>());
      expect(prepared.payloadHash, startsWith('sha256:'));
      expect(prepared.payloadLength, greaterThan(100000));
    }
  });
}
