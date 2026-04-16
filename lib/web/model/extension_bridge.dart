import 'dart:async';
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/model/model.dart';
import 'package:gagaku/util/exception.dart';

import 'package:gagaku/web/model/types.dart';

class ExtensionWebViewBridge {
  ExtensionWebViewBridge({
    required this.sourceId,
    required this.onResetAllState,
    required this.onSetExtensionState,
    required this.onSetExtensionSecureState,
    required this.getExtensionState,
    required this.getExtensionSecureState,
  });

  final String sourceId;
  final void Function(String) onResetAllState;
  final void Function(String, dynamic) onSetExtensionState;
  final void Function(String, dynamic) onSetExtensionSecureState;
  final dynamic Function(String) getExtensionState;
  final dynamic Function(String) getExtensionSecureState;

  bool _initialized = false;
  HeadlessInAppWebView? _view;
  InAppWebViewController? get _controller =>
      (_view?.isRunning() ?? false) ? _view?.webViewController : null;

  List<SearchFilter>? _filters;
  final Map<String, SettingsForm> _forms = {};
  List<Cookie>? _cookies;

  bool _hasSortOps = false;
  bool get hasSortOps => _hasSortOps;

  Timer? _completeTimer;

  late final Completer<void> _initCompleter = Completer<void>();
  Future<void> get initialized => _initCompleter.future;

  Future<void> init(WebSourceInfo source, String extensionBody) async {
    final contentBlockers = <ContentBlocker>[];

    if (defaultTargetPlatform == TargetPlatform.android) {
      for (final filter in GagakuData().blockers) {
        contentBlockers.add(
          ContentBlocker(
            trigger: ContentBlockerTrigger(urlFilter: filter),
            action: ContentBlockerAction(type: ContentBlockerActionType.BLOCK),
          ),
        );
      }
    }

    _completeTimer = Timer(const Duration(seconds: 60), () {
      if (!_initCompleter.isCompleted) {
        _initCompleter.completeError(Exception('$sourceId load timeout'));
      }
    });

    try {
      _view = HeadlessInAppWebView(
        initialUrlRequest: URLRequest(
          url: WebUri(source.baseUrl ?? 'about:blank'),
        ),
        initialUserScripts: UnmodifiableListView<UserScript>([
          UserScript(
            source: GagakuData().extensionHost,
            injectionTime: UserScriptInjectionTime.AT_DOCUMENT_START,
            forMainFrameOnly: false,
          ),
          UserScript(
            source: extensionBody,
            injectionTime: UserScriptInjectionTime.AT_DOCUMENT_START,
            forMainFrameOnly: false,
          ),
        ]),
        initialSettings: InAppWebViewSettings(
          contentBlockers: defaultTargetPlatform == TargetPlatform.android
              ? contentBlockers
              : null,
          browserAcceleratorKeysEnabled: false,
          isInspectable: false,
        ),
        onLoadStart: (controller, url) {
          if (_initialized) {
            controller.stopLoading();
          }
        },
        onWebViewCreated: (controller) {
          _setupJavaScriptHandlers(controller, sourceId);
        },
        onReceivedError: (controller, request, error) {
          if (request.isForMainFrame == true) {
            controller.stopLoading();
            if (!_initCompleter.isCompleted) {
              final ex = Exception(
                "Source startup failed. Main frame encountered error: ${error.description}",
              );
              _initCompleter.completeError(ex);
            }
          }
        },
        onReceivedHttpError: (controller, request, response) {
          if (request.isForMainFrame == true) {
            final int code = response.statusCode ?? 0;
            if (code == 404 || (code >= 500 && code != 503)) {
              controller.stopLoading();
              if (!_initCompleter.isCompleted) {
                final ex = Exception(
                  "Source startup failed. Main frame received HTTP $code",
                );
                _initCompleter.completeError(ex);
              }
            }
          }
        },
        onLoadStop: (controller, url) =>
            _onWebViewLoadStop(controller, url, source, _initCompleter),
      );
    } catch (e) {
      logger.w('Error creating extension view', error: e);
      _initCompleter.completeError(e);
    }

    await _view?.run();
    await _initCompleter.future;

    _initialized = true;
    _completeTimer?.cancel();
    _completeTimer = null;
  }

  void dispose() {
    _view?.dispose();
    _completeTimer?.cancel();
    _completeTimer = null;
    _view = null;
    _initialized = false;
    _filters = null;
    _hasSortOps = false;
    _forms.clear();
  }

  void _setupJavaScriptHandlers(
    InAppWebViewController controller,
    String sourceId,
  ) {
    controller.addJavaScriptHandler(
      handlerName: 'resetAllState',
      callback: (JavaScriptHandlerFunctionData data) {
        onResetAllState(sourceId);
      },
    );

    controller.addJavaScriptHandler(
      handlerName: 'setExtensionState',
      callback: (JavaScriptHandlerFunctionData data) {
        onSetExtensionState(sourceId, data.args[0]);
      },
    );

    controller.addJavaScriptHandler(
      handlerName: 'setExtensionSecureState',
      callback: (JavaScriptHandlerFunctionData data) {
        onSetExtensionSecureState(sourceId, data.args[0]);
      },
    );

    controller.addJavaScriptHandler(
      handlerName: 'formDidChange',
      callback: (JavaScriptHandlerFunctionData data) {
        final formId = data.args[0] as String;

        if (!_forms.containsKey(formId)) {
          logger.w('Tried to refresh non-existent form $formId');
          return;
        }

        _forms[formId]!.reloadForm();
      },
    );

    controller.addJavaScriptHandler(
      handlerName: 'initializeForm',
      callback: (JavaScriptHandlerFunctionData data) {
        final formId = data.args[0] as String;

        _forms.putIfAbsent(
          formId,
          () => SettingsForm(id: formId, controller: controller),
        );
      },
    );

    controller.addJavaScriptHandler(
      handlerName: 'uninitializeForms',
      callback: (JavaScriptHandlerFunctionData data) {
        _forms.clear();
      },
    );

    controller.addJavaScriptHandler(
      handlerName: 'executeInWebView',
      callback: (JavaScriptHandlerFunctionData data) async {
        final context = ExecuteInWebViewContext.fromJson(data.args[0]);
        final completer = Completer<Map<String, dynamic>>();

        final temp = HeadlessInAppWebView(
          initialData: InAppWebViewInitialData(
            data: context.source.html,
            baseUrl: WebUri(context.source.baseUrl),
          ),
          initialSettings: InAppWebViewSettings(
            contentBlockers: defaultTargetPlatform == TargetPlatform.android
                ? [
                    if (!context.source.loadCSS)
                      ContentBlocker(
                        trigger: ContentBlockerTrigger(
                          urlFilter: ".*",
                          resourceType: [
                            ContentBlockerTriggerResourceType.STYLE_SHEET,
                          ],
                        ),
                        action: ContentBlockerAction(
                          type: ContentBlockerActionType.BLOCK,
                        ),
                      ),
                    if (!context.source.loadImages)
                      ContentBlocker(
                        trigger: ContentBlockerTrigger(
                          urlFilter: ".*",
                          resourceType: [
                            ContentBlockerTriggerResourceType.IMAGE,
                          ],
                        ),
                        action: ContentBlockerAction(
                          type: ContentBlockerActionType.BLOCK,
                        ),
                      ),
                  ]
                : null,
            loadsImagesAutomatically: context.source.loadImages,
            browserAcceleratorKeysEnabled: false,
            isInspectable: false,
          ),
          onLoadStop: (controller, url) async {
            final results = await controller.callAsyncJavaScript(
              functionBody: context.inject,
            );

            if (results == null || results.error != null) {
              completer.completeError(
                JavaScriptException(
                  message: 'JavaScript error in executeInWebView:',
                  errorMessage: '${context.source.baseUrl} - ${results?.error}',
                ),
              );
              return;
            }

            completer.complete({'result': results.value});
          },
        );

        try {
          await temp.run();
          final result = await completer.future.timeout(
            const Duration(seconds: 30),
          );
          return result;
        } finally {
          temp.dispose();
        }
      },
    );
  }

  Future<void> _onWebViewLoadStop(
    InAppWebViewController controller,
    Uri? url,
    WebSourceInfo source,
    Completer<void> completer,
  ) async {
    try {
      final sourceId = source.id;

      final initScript = switch (source.version) {
        SupportedVersion.v0_9 =>
          "var ${source.id} = window.source.${source.id};",
      };
      await controller.evaluateJavascript(source: initScript);

      final initRes = await controller.callAsyncJavaScript(
        functionBody: "return typeof ${source.id} !== 'undefined';",
      );

      if (initRes == null || initRes.error != null || initRes.value != true) {
        throw Exception("Source did not initialize correctly");
      }

      if (_initialized) {
        return;
      }

      // Set extension state
      final extstate = getExtensionState(sourceId);
      await controller.callAsyncJavaScript(
        arguments: {'extstate': extstate},
        functionBody: "window.Application.createExtensionState(extstate);",
      );

      final extsecstate = getExtensionSecureState(sourceId);
      await controller.callAsyncJavaScript(
        arguments: {'extstate': extsecstate},
        functionBody:
            "window.Application.createExtensionSecureState(extstate);",
      );

      // Init
      await controller.callAsyncJavaScript(
        functionBody: "return await ${source.id}.initialise();",
      );

      // Get tags
      final result = await controller.callAsyncJavaScript(
        functionBody: "return await ${source.id}.getSearchFilters();",
      );

      if (result != null && result.value != null) {
        final rsec = result.value as List<dynamic>;
        _filters = rsec.map((e) => SearchFilter.fromJson(e)).toList();
      }

      // Test sort options
      final params = SearchQuery(title: "").toJson();
      final sortopts = await controller.callAsyncJavaScript(
        arguments: {'query': params},
        functionBody: "return await ${source.id}.getSortingOptions?.(query);",
      );

      if (sortopts != null && sortopts.value != null) {
        _hasSortOps = true;
      }

      if (url != null) {
        CookieManager cookieManager = CookieManager.instance();
        List<Cookie> cookies = await cookieManager.getCookies(
          url: WebUri.uri(url),
          webViewController: controller,
        );
        logger.d("cookies for ${url.toString()}:");

        bool hasCf = false;
        for (final cookie in cookies) {
          logger.d("cookie: ${cookie.name} = ${cookie.value}");
          if (cookie.name == 'cf_clearance') {
            hasCf = true;
          }
        }

        _cookies = cookies;

        if (source.hasCapability(SourceIntents.cloudflareBypassRequired) &&
            hasCf) {
          logger.d("Setting Cloudflare bypass cookies for ${source.id}");
          final jscook = cookies.map((e) => e.toJson()).toList();
          await controller.callAsyncJavaScript(
            arguments: {'cookies': jscook},
            functionBody:
                """
var jc = cookies.map((e) => {
  return {
    name: e.name,
    value: e.value,
    domain: e.domain,
    path: e.path,
    expires: new Date(e.expiresDate * 1000)
  };
});
await ${source.id}.saveCloudflareBypassCookies(jc);
                """,
          );
        }
      }

      logger.d("Extension ${source.name} ready");
      if (!completer.isCompleted) {
        completer.complete();
      }
    } catch (e) {
      logger.e('(${source.id}) Error during WebView load stop', error: e);
      completer.completeError(e);
    }
  }

  Future<dynamic> callBinding(
    String bindingId, [
    List<dynamic> args = const [],
  ]) async {
    final arg = args.map((e) => json.encode(e)).toList().join(",");
    final result = await _controller?.callAsyncJavaScript(
      functionBody:
          "return await window.Application.callBinding('$bindingId', $arg)",
    );

    return result?.value;
  }

  Future<SettingsForm> getSettingsForm(WebSourceInfo source) async {
    if (!source.hasCapability(SourceIntents.settingsUI)) {
      throw UnsupportedError("Source does not support settings");
    }

    final result = await _controller?.callAsyncJavaScript(
      functionBody:
          """
var form = await ${source.id}.getSettingsForm();
form.formWillAppear?.();
var id = await window.Application.initializeForm("main", form);
return id;
""",
    );

    if (result == null || result.error != null) {
      throw JavaScriptException(
        message: 'JavaScript error:',
        errorMessage: result?.error,
      );
    }

    final formid = result.value as FormID;

    if (!_forms.containsKey(formid)) {
      throw JavaScriptException(
        message: 'Failed to create form',
        errorMessage: formid,
      );
    }

    return _forms[formid]!;
  }

  Future<SettingsForm> getForm(WebSourceInfo source, FormID id) async {
    if (!source.hasCapability(SourceIntents.settingsUI)) {
      throw UnsupportedError("Source does not support settings");
    }

    final result = await _controller?.callAsyncJavaScript(
      arguments: {'formid': id},
      functionBody: """
var form = window.Application.getForm(formid);
if (typeof form === "undefined") {
  return null;
}

form.formWillAppear?.();

return formid;
""",
    );

    if (result == null || result.error != null) {
      throw JavaScriptException(
        message: 'JavaScript error:',
        errorMessage: result?.error,
      );
    }

    final formid = result.value as FormID?;

    if (formid == null) {
      throw JavaScriptException(message: 'Invalid FormID', errorMessage: id);
    }

    if (!_forms.containsKey(formid)) {
      throw JavaScriptException(
        message: 'Failed to create form',
        errorMessage: formid,
      );
    }

    return _forms[formid]!;
  }

  Future<void> uninitializeForms(WebSourceInfo source) async {
    if (!source.hasCapability(SourceIntents.settingsUI)) {
      throw UnsupportedError("Source does not support settings");
    }

    await _controller?.evaluateJavascript(
      source: "window.Application.uninitializeForms();",
    );
  }

  Future<List<DiscoverSection>> getDiscoverSections(
    WebSourceInfo source,
  ) async {
    if (!source.hasCapability(SourceIntents.discoverSections)) {
      throw UnsupportedError("Source does not support discover sections");
    }

    final result = await _controller?.callAsyncJavaScript(
      functionBody: "return await $sourceId.getDiscoverSections();",
    );

    if (result == null || result.error != null) {
      throw JavaScriptException(
        message: 'JavaScript error:',
        errorMessage: result?.error,
      );
    }

    final rsec = result.value as List<dynamic>;
    final sections = rsec.map((e) => DiscoverSection.fromJson(e)).toList();

    return sections;
  }

  Future<PagedResults<DiscoverSectionItem>> getDiscoverSectionItems(
    WebSourceInfo source,
    DiscoverSection section,
    dynamic metadata,
  ) async {
    if (!source.hasCapability(SourceIntents.discoverSections)) {
      throw UnsupportedError("Source does not support discover sections");
    }

    final result = await _controller?.callAsyncJavaScript(
      arguments: {'section': section.toJson(), 'metadata': metadata},
      functionBody:
          """
var p = await $sourceId.getDiscoverSectionItems(section, metadata);
p.items.forEach((e) => {
  if ("publishDate" in e) {
    e.publishDate = e.publishDate?.toISOString();
  }
});
return p;
""",
    );

    if (result == null || result.error != null) {
      throw JavaScriptException(
        message: 'JavaScript error:',
        errorMessage: result?.error,
      );
    }

    final items = PagedResults.fromJson(
      result.value,
      (e) => DiscoverSectionItem.fromJson(e as dynamic),
    );

    return items;
  }

  Future<PagedResults<SearchResultItem>> searchManga(
    SearchQuery query,
    dynamic metadata, {
    SortingOption? sortOp,
  }) async {
    if (query.title.isEmpty && query.filters.isEmpty) {
      return PagedResults<SearchResultItem>(items: []);
    }

    final params = query.toJson();
    final sop = sortOp?.toJson();

    final result = await _controller?.callAsyncJavaScript(
      arguments: {'query': params, 'metadata': metadata, 'sortOp': sop},
      functionBody:
          """
return await $sourceId.getSearchResults(query, metadata, sortOp)
""",
    );

    if (result == null || result.error != null) {
      throw JavaScriptException(
        message: 'JavaScript error:',
        errorMessage: result?.error,
      );
    }

    final pmangas = PagedResults.fromJson(
      result.value,
      (e) => SearchResultItem.fromJson(e as dynamic),
    );

    return pmangas;
  }

  Future<WebManga?> getManga(String mangaId) async {
    if (mangaId.isEmpty) {
      return null;
    }

    final mdeets = await _controller?.callAsyncJavaScript(
      functionBody: "return await $sourceId.getMangaDetails('$mangaId')",
    );

    if (mdeets == null || mdeets.error != null) {
      throw JavaScriptException(
        message: 'JavaScript error:',
        errorMessage: mdeets?.error,
      );
    }

    final smanga = SourceManga.fromJson(mdeets.value);

    final chaps = await _controller?.callAsyncJavaScript(
      arguments: {'manga': smanga.toJson()},
      functionBody:
          """
var p = await $sourceId.getChapters(manga);
p.forEach((e) => {
  e.publishDate = e.publishDate?.toISOString();
  e.creationDate = e.creationDate?.toISOString();
});
return p;
""",
    );

    if (chaps == null || chaps.error != null) {
      throw JavaScriptException(
        message: 'JavaScript error:',
        errorMessage: chaps?.error,
      );
    }

    final clist = chaps.value as List<dynamic>;
    final chapters = clist.map((e) => Chapter.fromJson(e)).toList();
    chapters.sort(
      (a, b) => compareNatural(b.chapNum.toString(), a.chapNum.toString()),
    );

    final manga = WebManga.extension(data: smanga, chaptersList: chapters);

    return manga;
  }

  Future<List<String>> getChapterPages(Chapter chapter) async {
    final cdeets = await _controller?.callAsyncJavaScript(
      arguments: {'chapter': chapter.toJson()},
      functionBody: "return await $sourceId.getChapterDetails(chapter);",
    );

    if (cdeets == null || cdeets.error != null) {
      throw JavaScriptException(
        message: 'JavaScript error:',
        errorMessage: cdeets?.error,
      );
    }

    final chapterd = ChapterDetails.fromJson(cdeets.value);

    return chapterd.pages;
  }

  Future<String?> getMangaURL(String mangaId) async {
    if (mangaId.isEmpty) {
      return null;
    }

    dynamic result;

    try {
      result = await _controller?.evaluateJavascript(
        source: "$sourceId.getMangaShareUrl?.('$mangaId')",
      );
    } catch (e) {
      return null;
    }

    return result;
  }

  Future<List<SortingOption>?> getSortingOptions(SearchQuery query) async {
    if (!_hasSortOps) {
      return null;
    }

    final sortopts = await _controller?.callAsyncJavaScript(
      arguments: {'query': query.toJson()},
      functionBody: "return await $sourceId.getSortingOptions?.(query);",
    );

    if (sortopts != null && sortopts.value != null) {
      final ssec = sortopts.value as List<dynamic>;
      final options = ssec.map((e) => SortingOption.fromJson(e)).toList();
      return options;
    }

    return null;
  }

  List<SearchFilter>? getFilters() {
    return _filters?.map((e) => e.copyWith()).toList();
  }

  List<Cookie>? getCookies() {
    return _cookies;
  }
}

class SettingsForm with ChangeNotifier {
  SettingsForm({required this.id, required InAppWebViewController controller})
    : _controller = controller {
    _sections = _getSections();
  }

  final FormID id;
  final InAppWebViewController _controller;

  late Future<List<FormSectionElement>> _sections;
  Future<List<FormSectionElement>> get sections => _sections;

  Future<List<FormSectionElement>> _getSections() async {
    final result = await _controller.callAsyncJavaScript(
      functionBody:
          """
var form = window.Application.getForm("$id");
if (typeof form === "undefined") {
  return [];
}

var p = form.getSections();
var a = p.map((e) => {
  return {
    id: e.id,
    header: e.header,
    footer: e.footer,
    items: e.items
  };
});

a.forEach((e) => {
  e.items.forEach((i) => {
    if ("form" in i) {
      window.Application.initializeForm(i.id, i.form);
      i.form = i.id;
    }
  });
});

return a;
""",
    );

    if (result == null || result.error != null) {
      throw JavaScriptException(
        message: 'JavaScript error:',
        errorMessage: result?.error,
      );
    }

    final sections = (result.value as List<dynamic>)
        .map((e) => FormSectionElement.fromJson(e as dynamic))
        .toList();

    return sections;
  }

  Future<bool> requiresExplicitSubmission() async {
    final result = await _controller.callAsyncJavaScript(
      arguments: {'formid': id},
      functionBody: """
var form = window.Application.getForm(formid);
if (typeof form === "undefined") {
  return false;
}

return form.requiresExplicitSubmission();
""",
    );

    if (result == null || result.error != null) {
      throw JavaScriptException(
        message: 'JavaScript error:',
        errorMessage: result?.error,
      );
    }

    return result.value as bool;
  }

  Future<void> call(String method) async {
    await _controller.callAsyncJavaScript(
      arguments: {'formid': id},
      functionBody:
          """
var form = window.Application.getForm(formid);
if (typeof form === "undefined") {
  return;
}

return form.$method?.();
""",
    );
  }

  Future<void> reloadForm() async {
    await _controller.callAsyncJavaScript(
      arguments: {'formid': id},
      functionBody: """
var form = window.Application.getForm(formid);
if (typeof form === "undefined") {
  return;
}

form.formWillAppear?.();
""",
    );

    _sections = _getSections();

    notifyListeners();
  }

  void uninitialize() {
    _controller.evaluateJavascript(
      source: "window.Application.uninitializeForms();",
    );
  }
}
