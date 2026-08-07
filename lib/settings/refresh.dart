import 'package:riverpod/riverpod.dart';

import 'package:gagaku/mangadex/model/config.dart';
import 'package:gagaku/mangadex/model/model.dart';
import 'package:gagaku/model/config.dart';
import 'package:gagaku/reader/model/config.dart';
import 'package:gagaku/web/model/config.dart';
import 'package:gagaku/web/model/model.dart';

/// Invalidates cached state after a transactional logical-data import.
void refreshImportedGagakuData(ProviderContainer container) {
  container
    ..invalidate(gagakuSettingsProvider)
    ..invalidate(readerSettingsProvider)
    ..invalidate(mdConfigProvider)
    ..invalidate(webConfigProvider)
    ..invalidate(extensionStateProvider)
    ..invalidate(extensionSecureStateProvider)
    ..invalidate(mangaDexHistoryProvider)
    ..invalidate(webReadMarkersProvider)
    ..invalidate(installedSourcesProvider)
    ..invalidate(extensionSourceProvider, asReload: true);
}
