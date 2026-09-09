import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gagaku/mangadex/model/config.dart';
import 'package:gagaku/mangadex/model/model.dart';
import 'package:gagaku/model/config.dart';
import 'package:gagaku/model/model.dart';
import 'package:gagaku/model/types.dart';
import 'package:gagaku/objectbox.g.dart';
import 'package:gagaku/reader/model/config.dart';
import 'package:gagaku/settings/convert.dart';
import 'package:gagaku/web/model/config.dart';
import 'package:gagaku/web/model/model.dart';
import 'package:gagaku/web/model/types.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  group('GagakuDataCodec', () {
    late Store store;
    late GagakuDataCodec codec;

    setUpAll(() {
      store = Store(
        getObjectBoxModel(),
        directory: 'memory:gagaku_data_codec_test_db',
      );
      GagakuData().store = store;
      codec = GagakuDataCodec(store: store);
    });

    setUp(() {
      _clearAllEntities(store);
    });

    tearDownAll(() {
      store.close();
    });

    test('declares every entity in the generated ObjectBox model', () {
      final generatedTypes = getObjectBoxModel().bindings.keys.toSet();

      expect(GagakuDataCodec.objectBoxEntityTypes, generatedTypes);
    });

    test('round-trips all ObjectBox entities with fictional data', () async {
      _seedAllEntities(store);

      final exported = await codec.export();
      expect(exported, isNot(contains('version')));
      expect(
        exported['gagaku'],
        isNot(anyOf(contains('lastUpdateCheck'), contains('ignoredUpdates'))),
      );

      _clearAllEntities(store);
      await codec.import(exported);

      final gagaku = store.box<GagakuConfig>().getAll().single;
      expect(gagaku.themeMode, ThemeMode.dark);
      expect(gagaku.theme, GagakuTheme.blue);

      final reader = store.box<ReaderConfig>().getAll().single;
      expect(reader.showProgressBar, isTrue);
      expect(reader.precacheCount, 7);

      final mangadex = store.box<MangaDexConfig>().getAll().single;
      expect(mangadex.dataSaver, isTrue);
      expect(mangadex.groupBlacklist, {'synthetic-group'});
      expect(store.box<MangaDexHistoryDB>().getAll().single.queue, [
        '00000000-0000-0000-0000-000000000001',
      ]);

      final webConfig = store.box<ExtensionConfig>().getAll().single;
      expect(webConfig.preserveHistory, isFalse);
      expect(webConfig.categoriesToUpdate, ['synthetic-category']);

      final stateRows = store.box<ExtensionStateDB>().getAll();
      expect(stateRows, hasLength(2));
      expect(stateRows.singleWhere((row) => !row.secure).state, {
        'synthetic-extension': {'setting': 'fictional'},
      });
      expect(stateRows.singleWhere((row) => row.secure).state, {
        'synthetic-extension': {'credential': 'synthetic-secret'},
      });

      expect(store.box<ReadMarkersDB>().getAll().single.markers, {
        'synthetic-extension/synthetic-series': {'synthetic-chapter'},
      });

      final link = store.box<HistoryLink>().getAll().single;
      expect(link.title, 'Synthetic Series');
      expect(
        link.series,
        const WebSeriesRef.extension(
          sourceId: 'synthetic-extension',
          mangaId: 'synthetic-series',
        ),
      );

      final lists = store.box<WebFavoritesList>().getAll();
      expect(lists, hasLength(2));
      expect(
        lists.singleWhere((list) => list.id == historyListUUID).list.single.url,
        link.url,
      );
      expect(
        lists
            .singleWhere((list) => list.id == 'synthetic-favorites')
            .list
            .single
            .url,
        link.url,
      );

      final source = store.box<WebSourceInfo>().getAll().single;
      expect(source.id, 'synthetic-extension');
      expect(source.name, 'Synthetic Extension');

      final repo = store.box<RepoInfo>().getAll().single;
      expect(repo.name, 'Synthetic Repository');
      expect(repo.url, 'https://example.invalid/repository');
    });

    test('rolls back every entity change when import fails', () async {
      store.box<GagakuConfig>().put(GagakuConfig(theme: GagakuTheme.lime));
      store.box<WebSourceInfo>().put(
        WebSourceInfo(
          id: 'baseline-extension',
          name: 'Baseline Extension',
          repo: 'https://example.invalid/baseline-repository',
          icon: '',
        ),
      );
      store.box<RepoInfo>().put(
        RepoInfo(
          name: 'Baseline Repository',
          url: 'https://example.invalid/baseline-repository',
        ),
      );

      var refreshed = false;
      final malformed = <String, dynamic>{
        'gagaku': GagakuConfig(theme: GagakuTheme.blue).toJson(),
        'ext-installed-sources': <dynamic>[],
        'ext-repo-list': <dynamic>[],
        'link-cache': <dynamic>[42],
      };

      await expectLater(
        codec.import(malformed, refresh: () => refreshed = true),
        throwsA(anything),
      );

      expect(refreshed, isFalse);
      expect(store.box<GagakuConfig>().getAll().single.theme, GagakuTheme.lime);
      expect(
        store.box<WebSourceInfo>().getAll().single.id,
        'baseline-extension',
      );
      expect(store.box<RepoInfo>().getAll().single.name, 'Baseline Repository');
      expect(store.box<HistoryLink>().count(), 0);
      expect(store.box<WebFavoritesList>().count(), 0);
    });

    test('refresh callback makes cached provider state visible', () async {
      store.box<GagakuConfig>().put(GagakuConfig(theme: GagakuTheme.lime));
      store.box<ExtensionStateDB>().put(
        ExtensionStateDB(
          state: {
            'synthetic-extension': {'value': 'before'},
          },
        ),
      );
      final container = ProviderContainer();
      addTearDown(container.dispose);

      expect(container.read(gagakuSettingsProvider).theme, GagakuTheme.lime);
      expect(
        container
            .read(extensionStateProvider.notifier)
            .getExtensionState('synthetic-extension'),
        {'value': 'before'},
      );

      await codec.import(
        {
          'gagaku': GagakuConfig(theme: GagakuTheme.blue).toJson(),
          'extension-state': {
            'synthetic-extension': {'value': 'after'},
          },
        },
        refresh: () {
          container
            ..invalidate(gagakuSettingsProvider)
            ..invalidate(extensionStateProvider);
        },
      );

      expect(container.read(gagakuSettingsProvider).theme, GagakuTheme.blue);
      expect(
        container
            .read(extensionStateProvider.notifier)
            .getExtensionState('synthetic-extension'),
        {'value': 'after'},
      );
    });
  });
}

void _seedAllEntities(Store store) {
  store.box<GagakuConfig>().put(
    GagakuConfig(themeMode: ThemeMode.dark, theme: GagakuTheme.blue),
  );
  store.box<ReaderConfig>().put(
    ReaderConfig(showProgressBar: true, precacheCount: 7),
  );
  store.box<MangaDexConfig>().put(
    MangaDexConfig(dataSaver: true, groupBlacklist: {'synthetic-group'}),
  );
  store.box<MangaDexHistoryDB>().put(
    MangaDexHistoryDB(queue: const ['00000000-0000-0000-0000-000000000001']),
  );
  store.box<ExtensionConfig>().put(
    ExtensionConfig(
      categoriesToUpdate: ['synthetic-category'],
      preserveHistory: false,
    ),
  );
  store.box<ExtensionStateDB>().putMany([
    ExtensionStateDB(
      state: {
        'synthetic-extension': {'setting': 'fictional'},
      },
    ),
    ExtensionStateDB(
      secure: true,
      state: {
        'synthetic-extension': {'credential': 'synthetic-secret'},
      },
    ),
  ]);
  store.box<ReadMarkersDB>().put(
    ReadMarkersDB(
      markers: {
        'synthetic-extension/synthetic-series': {'synthetic-chapter'},
      },
    ),
  );

  final link = HistoryLink(
    title: 'Synthetic Series',
    url: 'synthetic-extension/synthetic-series',
    cover: 'https://example.invalid/cover.jpg',
    series: const WebSeriesRef.extension(
      sourceId: 'synthetic-extension',
      mangaId: 'synthetic-series',
    ),
    lastAccessed: DateTime.utc(2026, 1, 1),
  );
  store.box<HistoryLink>().put(link);

  final history = WebFavoritesList(
    id: historyListUUID,
    name: 'Synthetic History',
  )..list.add(link);
  final favorites = WebFavoritesList(
    id: 'synthetic-favorites',
    name: 'Synthetic Favorites',
    sortOrder: 1,
  )..list.add(link);
  store.box<WebFavoritesList>().putMany([history, favorites]);

  store.box<WebSourceInfo>().put(
    WebSourceInfo(
      id: 'synthetic-extension',
      name: 'Synthetic Extension',
      repo: 'https://example.invalid/repository',
      baseUrl: 'https://example.invalid',
      icon: 'https://example.invalid/icon.png',
    ),
  );
  store.box<RepoInfo>().put(
    RepoInfo(
      name: 'Synthetic Repository',
      url: 'https://example.invalid/repository',
    ),
  );
}

void _clearAllEntities(Store store) {
  store.box<WebFavoritesList>().removeAll();
  store.box<HistoryLink>().removeAll();
  store.box<GagakuConfig>().removeAll();
  store.box<ReaderConfig>().removeAll();
  store.box<MangaDexConfig>().removeAll();
  store.box<MangaDexHistoryDB>().removeAll();
  store.box<ExtensionConfig>().removeAll();
  store.box<ExtensionStateDB>().removeAll();
  store.box<ReadMarkersDB>().removeAll();
  store.box<WebSourceInfo>().removeAll();
  store.box<RepoInfo>().removeAll();
}
