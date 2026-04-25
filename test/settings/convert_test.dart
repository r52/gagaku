import 'dart:convert';

import 'package:gagaku/model/types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gagaku/objectbox.g.dart';

import 'package:gagaku/web/model/model.dart';
import 'package:gagaku/model/model.dart';
import 'package:gagaku/web/model/config.dart';
import 'package:gagaku/web/model/types.dart';

import 'package:gagaku/model/config.dart';
import 'package:gagaku/mangadex/model/config.dart';
import 'package:gagaku/web/model/model.dart' show historyListUUID;
import 'package:gagaku/reader/model/config.dart';
import 'package:gagaku/settings/convert.dart';

void main() {
  group('GagakuBackupData Converter Tests', () {
    late Store store;

    setUpAll(() {
      store = Store(getObjectBoxModel(), directory: 'memory:gagaku_test_db');
      GagakuData().store = store;
    });

    setUp(() {
      store.box<GagakuConfig>().removeAll();
      store.box<ReaderConfig>().removeAll();
      store.box<MangaDexConfig>().removeAll();
      store.box<ExtensionStateDB>().removeAll();
      store.box<HistoryLink>().removeAll();
      store.box<WebFavoritesList>().removeAll();
      store.box<WebFavoritesList>().put(
        WebFavoritesList(id: historyListUUID, name: 'History'),
      );
    });

    tearDownAll(() {
      store.close();
    });

    test('V2 Backup write/read handles GagakuConfig', () async {
      final originalConfig = GagakuConfig(
        theme: GagakuTheme.lime,
        themeMode: ThemeMode.dark,
      );
      store.box<GagakuConfig>().put(originalConfig);

      final converter = const GagakuBackupDataV2();
      final backupJsonString = await converter.write({});
      final backupData = json.decode(backupJsonString) as Map<String, dynamic>;

      expect(backupData['version'], 2);
      expect(backupData.containsKey('gagaku'), isTrue);

      store.box<GagakuConfig>().removeAll();

      await converter.read(backupData);

      final restoredConfig = store
          .box<GagakuConfig>()
          .query()
          .build()
          .findUnique();
      expect(restoredConfig, isNotNull);
      expect(restoredConfig!.theme, GagakuTheme.lime);
      expect(restoredConfig.themeMode, ThemeMode.dark);
    });

    test('V2 Backup write/read handles ReaderConfig', () async {
      final cfg = ReaderConfig(showProgressBar: false);
      store.box<ReaderConfig>().put(cfg);

      final converter = const GagakuBackupDataV2();
      final backupJsonString = await converter.write({});
      final backupData = json.decode(backupJsonString) as Map<String, dynamic>;
      store.box<ReaderConfig>().removeAll();

      await converter.read(backupData);

      final restored = store.box<ReaderConfig>().query().build().findUnique();
      expect(restored, isNotNull);
      expect(restored!.showProgressBar, isFalse);
    });

    test('V2 Backup integration with realistic payload', () async {
      final payload = {
        'version': 2,
        'gagaku': {
          "themeMode": "system",
          "theme": "grey",
          "gridAlbumExtent": "small",
        },
        'reader': {
          "format": "single",
          "direction": "rightToLeft",
          "showProgressBar": true,
          "clickToTurn": true,
          "swipeGestures": true,
          "precacheCount": 3,
        },
        'mangadex': {
          "translatedLanguages": ["en", "ja"],
          "originalLanguage": ["ja"],
          "contentRating": ["safe", "suggestive", "erotica", "pornographic"],
          "dataSaver": false,
          "groupBlacklist": [],
        },
        'link-cache': [
          {
            "title": "Fake Manga Title 1",
            "url": "FakeExtension/fake_location_1",
            "cover": "cover.jpg",
            "handle": {
              "type": "source",
              "sourceId": "FakeExtension",
              "location": "fake_location_1",
              "chapter": null,
            },
            "lastAccessed": "2025-09-16T16:46:33.030",
          },
          {
            "title": "Fake Manga Title 2",
            "url": "FakeExtension/fake_location_2",
            "cover": "cover.jpg",
            "handle": {
              "type": "source",
              "sourceId": "FakeExtension",
              "location": "fake_location_2",
              "chapter": null,
            },
            "lastAccessed": "2025-09-16T16:46:33.030",
          },
        ],
        'web_history': ["FakeExtension/fake_location_1"],
        'web_favorites': [
          {
            "id": "eaa2874c-bea6-430e-bf7e-85fac65e30ce",
            "name": "Reading",
            "sortOrder": 0,
            "list": ["FakeExtension/fake_location_2"],
          },
        ],
      };

      final converter = const GagakuBackupDataV2();
      await converter.read(payload);

      // Verify restored content
      final restoredGagaku = store
          .box<GagakuConfig>()
          .query()
          .build()
          .findUnique();
      expect(restoredGagaku, isNotNull);
      expect(restoredGagaku!.theme, GagakuTheme.grey);
      expect(restoredGagaku.themeMode, ThemeMode.system);

      final restoredReader = store
          .box<ReaderConfig>()
          .query()
          .build()
          .findUnique();
      expect(restoredReader, isNotNull);
      expect(restoredReader!.showProgressBar, isTrue);

      final restoredMangadex = store
          .box<MangaDexConfig>()
          .query()
          .build()
          .findUnique();
      expect(restoredMangadex, isNotNull);
      expect(
        restoredMangadex!.translatedLanguages.join(','),
        'Language.en,Language.ja',
      );

      final historybox = store.box<WebFavoritesList>();
      final lists = historybox.getAll();

      final historylist = lists.firstWhere((e) => e.id == historyListUUID);
      expect(historylist.list.length, 1);
      expect(historylist.list.first.url, "FakeExtension/fake_location_1");

      final favlists = lists.where((e) => e.id != historyListUUID).toList();
      expect(favlists.length, 1);
      expect(favlists.first.name, "Reading");
    });
  });
}
