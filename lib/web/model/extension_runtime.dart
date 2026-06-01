import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:gagaku/web/model/types.dart';

abstract interface class ExtensionRuntime {
  bool get hasAdvancedSearchForm;
  bool get hasSortOps;

  Future<void> init(WebSourceInfo source, String extensionBody);

  FutureOr<void> dispose();

  Future<dynamic> callBinding(String bindingId, [List<dynamic> args]);

  Future<ExtensionForm> getSettingsForm(WebSourceInfo source);

  Future<ExtensionForm> getForm(WebSourceInfo source, FormID id);

  Future<void> uninitializeForms(WebSourceInfo source);

  Future<List<DiscoverSection>> getDiscoverSections(WebSourceInfo source);

  Future<PagedResults<DiscoverSectionItem>> getDiscoverSectionItems(
    WebSourceInfo source,
    DiscoverSection section,
    dynamic metadata,
  );

  Future<PagedResults<SearchResultItem>> searchManga(
    SearchQuery query,
    dynamic metadata, {
    SortingOption? sortOp,
  });

  Future<WebManga?> getManga(String mangaId);

  Future<List<String>> getChapterPages(Chapter chapter);

  Future<String?> getMangaURL(String mangaId);

  Future<List<SortingOption>?> getSortingOptions(SearchQuery query);

  Future<ExtensionForm?> getAdvancedSearchForm(SearchQuery query);

  Future<Uint8List> processImageRequest(String url);

  List<Cookie>? getCookies();
}

abstract class ExtensionForm extends ChangeNotifier {
  FormID get id;

  Future<List<FormSectionElement>> get sections;

  bool get requiresExplicitSubmission;

  Future<void> call(String method);

  Future<void> reloadForm();

  Future<void> uninitialize();

  Future<void> formDidSubmit();

  Future<void> formDidCancel();

  Future<dynamic> getSearchQueryMetadata();
}
