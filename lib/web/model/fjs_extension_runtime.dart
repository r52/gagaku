import 'dart:async';
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:fjs/fjs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:gagaku/model/model.dart';
import 'package:gagaku/util/exception.dart';
import 'package:gagaku/web/model/extension_runtime.dart';
import 'package:gagaku/web/model/extension_webview_fallback.dart';
import 'package:gagaku/web/model/types.dart';

class FjsExtensionRuntime implements ExtensionRuntime {
  FjsExtensionRuntime({
    required this.sourceId,
    required this.extensionHost,
    required this.onResetAllState,
    required this.onSetExtensionState,
    required this.onSetExtensionSecureState,
    required this.getExtensionState,
    required this.getExtensionSecureState,
  });

  final String sourceId;
  final String extensionHost;
  final void Function(String) onResetAllState;
  final void Function(String, dynamic) onSetExtensionState;
  final void Function(String, dynamic) onSetExtensionSecureState;
  final dynamic Function(String) getExtensionState;
  final dynamic Function(String) getExtensionSecureState;

  static Future<void>? _libInit;
  static final Set<FjsExtensionRuntime> _activeRuntimes = {};
  static const _consoleModuleName = 'gagaku/console';
  static const _consoleModuleScript = r'''
const formatValue = (value) => {
  if (typeof value === "string") {
    return value;
  }
  if (value instanceof Error) {
    return value.stack ?? `${value.name}: ${value.message}`;
  }
  try {
    const encoded = JSON.stringify(value);
    return encoded === undefined ? String(value) : encoded;
  } catch {
    return String(value);
  }
};

globalThis.console = Object.fromEntries(
  ["debug", "info", "log", "warn", "error"].map((level) => [
    level,
    (...args) => {
      void fjs.bridge_call(
        JSON.stringify({
          channel: "console",
          level,
          values: args.map(formatValue)
        })
      );
    }
  ])
);
''';

  JsEngine? _engine;
  bool _hasAdvancedSearchForm = false;
  bool _hasSortOps = false;
  List<Cookie>? _cookies;
  final Map<String, FjsExtensionForm> _forms = {};

  @override
  bool get hasAdvancedSearchForm => _hasAdvancedSearchForm;

  @override
  bool get hasSortOps => _hasSortOps;

  static Future<void> _ensureLibInit() {
    return _libInit ??= LibFjs.init();
  }

  static int get activeRuntimeCount => _activeRuntimes.length;

  static Future<void> disposeAll() async {
    final runtimes = _activeRuntimes.toList();
    if (runtimes.isEmpty) {
      return;
    }

    debugPrint('fjs: closing ${runtimes.length} active extension runtime(s)');
    await Future.wait(runtimes.map((runtime) => runtime.dispose()));
  }

  Future<JsValue> _evalGlobal(
    String source, {
    String label = 'unlabelled eval',
  }) async {
    final engine = _engine;
    if (engine == null || engine.closed) {
      throw StateError('fjs extension runtime is not initialized');
    }

    try {
      return await engine.eval(
        source: JsCode.code(source),
        options: JsEvalOptions.withPromise(),
      );
    } catch (error, stackTrace) {
      debugPrint('fjs[$sourceId] eval failed: $label\n$error\n$stackTrace');
      rethrow;
    }
  }

  Future<JsValue> _evalScoped(
    String source, {
    String label = 'unlabelled scoped eval',
  }) {
    return _evalGlobal('''
await (async () => {
$source
})()
''', label: label);
  }

  Future<dynamic> _evalJsonScoped(
    String source, {
    String label = 'unlabelled JSON scoped eval',
  }) async {
    final result = await _evalScoped('''
const value = await (async () => {
$source
})();
return JSON.stringify(value);
''', label: label);
    final encoded = result.value;
    if (encoded is! String) {
      throw StateError(
        'Expected $label to return JSON text, got ${encoded.runtimeType}',
      );
    }
    return jsonDecode(encoded);
  }

  String _json(Object? value) => jsonEncode(value);

  dynamic _normalizeBridgeJson(dynamic value) {
    return switch (value) {
      DateTime date => date.toUtc().toIso8601String(),
      Map values => <String, dynamic>{
        for (final MapEntry(:key, :value) in values.entries)
          key.toString(): _normalizeBridgeJson(value),
      },
      List values => values.map(_normalizeBridgeJson).toList(),
      _ => value,
    };
  }

  Map<String, dynamic> _normalizeBridgeJsonMap(dynamic value, String label) {
    final normalized = _normalizeBridgeJson(value);
    if (normalized is! Map<String, dynamic>) {
      throw StateError(
        'Expected $label to return an object, got ${normalized.runtimeType}',
      );
    }
    return normalized;
  }

  Future<JsValue> evalForForm(
    String source, {
    String label = 'unlabelled form eval',
  }) => _evalScoped(source, label: label);

  @visibleForTesting
  Future<dynamic> evalForTesting(String source) async =>
      (await _evalGlobal(source)).value;

  @override
  Future<void> init(WebSourceInfo source, String extensionBody) async {
    try {
      await _runInitStep('initialize fjs library', _ensureLibInit);

      final engine = await _runInitStep(
        'create engine',
        () => JsEngine.create(
          builtins: JsBuiltinOptions.all().copyWith(json: false),
        ),
      );
      _engine = engine;
      _activeRuntimes.add(this);

      await _runInitStep(
        'initialize Dart bridge',
        () => engine.init(bridge: _handleBridgeCall),
      );
      await _runInitStep(
        'install console module',
        () => engine.evaluateModule(
          module: JsModule.code(
            module: _consoleModuleName,
            code: _consoleModuleScript,
          ),
        ),
      );
      await _runInitStep(
        'install host bridge',
        () => _evalGlobal(_bootstrapScript(), label: 'install host bridge'),
      );
      await _runInitStep('set proxy port', _setProxyPort);
      final startupCookies = await _runInitStep(
        'load startup cookies',
        () => _loadStartupCookies(source),
      );
      await _runInitStep(
        'evaluate extension host',
        () => _evalGlobal(extensionHost, label: 'evaluate extension host'),
      );
      await _runInitStep(
        'evaluate extension body',
        () => _evalGlobal(extensionBody, label: 'evaluate extension body'),
      );
      await _runInitStep(
        'assign source global',
        () => _evalGlobal(
          _sourceInitScript(source),
          label: 'assign source global',
        ),
      );
      await _runInitStep(
        'hydrate extension state',
        () => _hydrateExtensionState(source.id),
      );
      await _runInitStep(
        'save startup cookies',
        () => _saveCloudflareBypassCookies(source, startupCookies),
      );
      await _runInitStep(
        'initialise source',
        () => _evalScoped(
          'await globalThis.${source.id}.initialise();',
          label: 'initialise source',
        ),
      );
      await _runInitStep(
        'read source capabilities',
        () => _readCapabilities(source.id),
      );
    } catch (_) {
      await dispose();
      rethrow;
    }
  }

  Future<T> _runInitStep<T>(String label, Future<T> Function() action) async {
    debugPrint('fjs[$sourceId] init: $label');
    try {
      return await action();
    } catch (error, stackTrace) {
      debugPrint('fjs[$sourceId] init failed: $label\n$error\n$stackTrace');
      rethrow;
    }
  }

  String _bootstrapScript() {
    return r'''
globalThis.window = globalThis;
globalThis.self = globalThis;
globalThis.global = globalThis;
globalThis.source ??= {};
globalThis.__gagaku_use_native_fetch = true;

globalThis.gagaku = {
  callHandler: async (handlerName, ...args) => {
    return await fjs.bridge_call(
      JSON.stringify({ handlerName, args })
    );
  }
};
''';
  }

  Future<void> _setProxyPort() async {
    final proxyPort = GagakuData().proxyServer?.port;
    if (proxyPort != null) {
      await _evalGlobal('globalThis.__gagaku_proxy_port = $proxyPort;');
    }
  }

  Future<List<Cookie>> _loadStartupCookies(WebSourceInfo source) async {
    final baseUrl = source.baseUrl;
    if (baseUrl == null || baseUrl.isEmpty) {
      _cookies = null;
      return const [];
    }

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

    final completer = Completer<List<Cookie>>();
    final requiresCloudflare = source.hasCapability(
      SourceIntents.cloudflareBypassRequired,
    );
    var latestCookies = <Cookie>[];
    Timer? timeout;
    HeadlessInAppWebView? startupView;

    void complete(List<Cookie> cookies) {
      if (!completer.isCompleted) {
        completer.complete(cookies);
      }
    }

    timeout = Timer(const Duration(seconds: 15), () {
      complete(latestCookies);
    });

    startupView = HeadlessInAppWebView(
      initialUrlRequest: URLRequest(url: WebUri(baseUrl)),
      initialSettings: InAppWebViewSettings(
        contentBlockers: contentBlockers.isEmpty ? null : contentBlockers,
        browserAcceleratorKeysEnabled: false,
        isInspectable: false,
      ),
      onLoadStop: (controller, url) async {
        if (url == null) {
          return;
        }

        final cookies = await CookieManager.instance().getCookies(
          url: WebUri.uri(url),
          webViewController: controller,
        );
        latestCookies = cookies;

        final hasClearance = cookies.any(
          (cookie) => cookie.name == 'cf_clearance',
        );
        if (!requiresCloudflare || hasClearance) {
          complete(cookies);
        }
      },
    );

    try {
      await startupView.run();
      final cookies = await completer.future;
      _cookies = cookies;
      return cookies;
    } finally {
      timeout.cancel();
      startupView.dispose();
    }
  }

  Future<void> _saveCloudflareBypassCookies(
    WebSourceInfo source,
    List<Cookie> cookies,
  ) async {
    if (!source.hasCapability(SourceIntents.cloudflareBypassRequired) ||
        !cookies.any((cookie) => cookie.name == 'cf_clearance')) {
      return;
    }

    final expectedDomain = Uri.parse(source.baseUrl!).host;
    final pbCookies = cookies
        .map(
          (cookie) => PBDocumentCookie(
            name: cookie.name,
            value: cookie.value,
            domain: cookie.domain ?? expectedDomain,
            path: cookie.path,
            expires: cookie.expiresDate != null
                ? DateTime.fromMillisecondsSinceEpoch(cookie.expiresDate!)
                : null,
          ),
        )
        .toList();

    await _evalScoped("""
const cookies = ${jsonEncode(pbCookies.map((cookie) => cookie.toJson()).toList())}.map((cookie) => {
  return {
    ...cookie,
    created: cookie.created ? new Date(cookie.created) : undefined,
    expires: cookie.expires ? new Date(cookie.expires) : undefined
  };
});
if (typeof globalThis.${source.id}.saveCloudflareBypassCookies === "function") {
  await globalThis.${source.id}.saveCloudflareBypassCookies(cookies);
}
""");
  }

  String _sourceInitScript(WebSourceInfo source) {
    return switch (source.version) {
      SupportedVersion.v0_9 =>
        'var ${source.id} = globalThis.source.${source.id};',
    };
  }

  Future<void> _hydrateExtensionState(String sourceId) async {
    final state = jsonEncode(getExtensionState(sourceId));
    await _evalScoped('globalThis.Application.createExtensionState($state);');

    final secureState = jsonEncode(getExtensionSecureState(sourceId));
    await _evalScoped(
      'globalThis.Application.createExtensionSecureState($secureState);',
    );
  }

  Future<void> _readCapabilities(String sourceId) async {
    final advancedSearchCheck = await _evalScoped(
      'return typeof globalThis.$sourceId.getAdvancedSearchForm === "function";',
    );
    _hasAdvancedSearchForm = advancedSearchCheck.value == true;

    final sortOptionsCheck = await _evalScoped(
      'return typeof globalThis.$sourceId.getSortingOptions === "function";',
    );
    _hasSortOps = sortOptionsCheck.value == true;
  }

  FutureOr<JsResult> _handleBridgeCall(JsValue value) {
    final bridgeValue = value.value;
    final payload = switch (bridgeValue) {
      String encoded => jsonDecode(encoded),
      _ => bridgeValue,
    };
    if (payload is! Map) {
      return const JsResult.err(
        JsError.bridge('Invalid gagaku bridge payload'),
      );
    }

    if (payload['channel'] == 'console') {
      final level = payload['level'] ?? 'log';
      final values = payload['values'];
      debugPrint(
        'fjs[$sourceId] console.$level: '
        '${values is List ? values.join(' ') : values}',
      );
      return JsResult.ok(const JsValue.none());
    }

    final handlerName = payload['handlerName'] as String?;
    final args = payload['args'] as List? ?? const [];
    debugPrint('fjs[$sourceId] bridge: $handlerName(${jsonEncode(args)})');

    switch (handlerName) {
      case 'resetAllState':
        onResetAllState(sourceId);
        return JsResult.ok(const JsValue.none());
      case 'setExtensionState':
        onSetExtensionState(
          sourceId,
          _normalizeBridgeJson(args.isEmpty ? null : args.first),
        );
        return JsResult.ok(const JsValue.none());
      case 'setExtensionSecureState':
        onSetExtensionSecureState(
          sourceId,
          _normalizeBridgeJson(args.isEmpty ? null : args.first),
        );
        return JsResult.ok(const JsValue.none());
      case 'formDidChange':
        final formId = args.isEmpty ? null : args.first;
        if (formId is String) {
          unawaited(_forms[formId]?.reloadForm());
        }
        return JsResult.ok(const JsValue.none());
      case 'initializeForm':
        final formId = args.isEmpty ? null : args.first;
        if (formId is String) {
          _forms.putIfAbsent(
            formId,
            () => FjsExtensionForm(id: formId, runtime: this),
          );
        }
        return JsResult.ok(const JsValue.none());
      case 'uninitializeForms':
        _forms.clear();
        return JsResult.ok(const JsValue.none());
      case 'executeInWebView':
        return _handleExecuteInWebView(args.isEmpty ? null : args.first);
      default:
        return JsResult.err(
          JsError.bridge('Unsupported gagaku bridge handler: $handlerName'),
        );
    }
  }

  Future<JsResult> _handleExecuteInWebView(dynamic payload) async {
    if (payload is! Map) {
      return const JsResult.err(
        JsError.bridge('Invalid executeInWebView payload'),
      );
    }

    try {
      final context = ExecuteInWebViewContext.fromJson(
        Map<String, dynamic>.from(payload),
      );
      return JsResult.ok(
        JsValue.from((await executeInTemporaryWebView(context)).toJson()),
      );
    } catch (error) {
      return JsResult.err(JsError.bridge(error.toString()));
    }
  }

  @override
  Future<dynamic> callBinding(
    String bindingId, [
    List<dynamic> args = const [],
  ]) async {
    final jsArgs = args.map(_json).join(',');
    final result = await _evalScoped(
      'return await globalThis.Application.callBinding(${_json(bindingId)}'
      '${jsArgs.isEmpty ? '' : ',$jsArgs'});',
    );

    final value = result.value;
    if (value is Map && value['__isFormConfirmationError'] == true) {
      throw FormConfirmationException(
        message: value['message'] as String,
        onConfirmation: value['onConfirmation'] as String,
      );
    }

    return value;
  }

  @override
  Future<ExtensionForm?> getAdvancedSearchForm(SearchQuery query) async {
    if (!_hasAdvancedSearchForm) {
      return null;
    }

    final result = await _evalScoped("""
const query = ${_json(query.toJson())};
if (query.metadata === null) delete query.metadata;
const form = await globalThis.$sourceId.getAdvancedSearchForm(query);
form.formWillAppear?.();
const id = await globalThis.Application.initializeForm("advancedSearch", form);
return id;
""");

    final formId = result.value as FormID;
    return _forms[formId] ??
        (throw StateError('Failed to create form $formId'));
  }

  @override
  Future<List<String>> getChapterPages(Chapter chapter) async {
    final detailsJson = await _evalJsonScoped('''
const chapter = ${_json(chapter.toJson())};
return await globalThis.$sourceId.getChapterDetails(chapter);
''', label: 'get chapter pages');

    final details = ChapterDetails.fromJson(
      _normalizeBridgeJsonMap(detailsJson, 'getChapterDetails'),
    );
    return details.pages;
  }

  @override
  List<Cookie>? getCookies() {
    return _cookies;
  }

  @override
  Future<List<DiscoverSection>> getDiscoverSections(WebSourceInfo source) {
    throw UnimplementedError('fjs discover sections are not implemented yet');
  }

  @override
  Future<PagedResults<DiscoverSectionItem>> getDiscoverSectionItems(
    WebSourceInfo source,
    DiscoverSection section,
    dynamic metadata,
  ) {
    throw UnimplementedError('fjs discover sections are not implemented yet');
  }

  @override
  Future<ExtensionForm> getForm(WebSourceInfo source, FormID id) async {
    if (!source.hasCapability(SourceIntents.settingsUI)) {
      throw UnsupportedError("Source does not support settings");
    }

    final result = await _evalScoped("""
const formid = ${_json(id)};
const form = globalThis.Application.getForm(formid);
if (typeof form === "undefined") {
  return null;
}
form.formWillAppear?.();
return formid;
""");

    final formId = result.value as FormID?;
    if (formId == null) {
      throw JavaScriptException(message: 'Invalid FormID', errorMessage: id);
    }

    return _forms[formId] ??
        (throw StateError('Failed to create form $formId'));
  }

  @override
  Future<WebManga?> getManga(String mangaId) async {
    if (mangaId.isEmpty) {
      return null;
    }

    final mangaDetails = await _evalJsonScoped(
      'return await globalThis.$sourceId.getMangaDetails(${_json(mangaId)});',
      label: 'get manga details',
    );
    final sourceManga = SourceManga.fromJson(
      _normalizeBridgeJsonMap(mangaDetails, 'getMangaDetails'),
    );

    final chapterList = await _evalJsonScoped('''
const manga = ${_json(sourceManga.toJson())};
return await globalThis.$sourceId.getChapters(manga);
''', label: 'get manga chapters');
    final normalizedChapters = _normalizeBridgeJson(chapterList);
    if (normalizedChapters is! List) {
      throw StateError(
        'Expected getChapters to return a list, got '
        '${normalizedChapters.runtimeType}',
      );
    }

    final chapters = normalizedChapters
        .map(
          (chapter) => Chapter.fromJson(
            _normalizeBridgeJsonMap(chapter, 'getChapters item'),
          ),
        )
        .toList();
    chapters.sort(
      (a, b) => compareNatural(b.chapNum.toString(), a.chapNum.toString()),
    );

    return WebManga.extension(data: sourceManga, chaptersList: chapters);
  }

  @override
  Future<String?> getMangaURL(String mangaId) {
    throw UnimplementedError('fjs manga share URLs are not implemented yet');
  }

  @override
  Future<ExtensionForm> getSettingsForm(WebSourceInfo source) async {
    if (!source.hasCapability(SourceIntents.settingsUI)) {
      throw UnsupportedError("Source does not support settings");
    }

    final result = await _evalScoped("""
const form = await globalThis.${source.id}.getSettingsForm();
form.formWillAppear?.();
const id = await globalThis.Application.initializeForm("main", form);
return id;
""");

    final formId = result.value as FormID;
    return _forms[formId] ??
        (throw StateError('Failed to create form $formId'));
  }

  @override
  Future<List<SortingOption>?> getSortingOptions(SearchQuery query) {
    throw UnimplementedError('fjs sorting options are not implemented yet');
  }

  @override
  Future<Uint8List> processImageRequest(String url) async {
    final result = await _evalScoped("""
const [, body] = await globalThis.Application.scheduleRequest({
  url: ${_json(url)},
  method: "GET"
});
return new Uint8Array(body);
""");

    final value = result.value;
    return switch (value) {
      Uint8List bytes => bytes,
      List bytes => Uint8List.fromList(bytes.cast<int>()),
      _ => throw StateError(
        'Expected fjs image request to return bytes, got ${value.runtimeType}',
      ),
    };
  }

  @override
  Future<PagedResults<SearchResultItem>> searchManga(
    SearchQuery query,
    dynamic metadata, {
    SortingOption? sortOp,
  }) {
    throw UnimplementedError('fjs search is not implemented yet');
  }

  @override
  Future<void> uninitializeForms(WebSourceInfo source) async {
    if (!source.hasCapability(SourceIntents.settingsUI)) {
      throw UnsupportedError("Source does not support settings");
    }

    await _evalScoped('globalThis.Application.uninitializeForms();');
  }

  @override
  Future<void> dispose() async {
    _activeRuntimes.remove(this);

    final engine = _engine;
    _engine = null;
    _hasAdvancedSearchForm = false;
    _hasSortOps = false;
    _cookies = null;
    _forms.clear();

    if (engine != null && !engine.closed) {
      debugPrint('fjs[$sourceId]: closing engine');
      await engine.close();
    }
  }
}

class FjsExtensionForm extends ExtensionForm {
  FjsExtensionForm({required this.id, required this.runtime}) {
    _sections = _getSections();
  }

  @override
  final FormID id;

  final FjsExtensionRuntime runtime;

  late Future<List<FormSectionElement>> _sections;

  @override
  Future<List<FormSectionElement>> get sections => _sections;

  bool _requiresExplicitSubmission = false;

  @override
  bool get requiresExplicitSubmission => _requiresExplicitSubmission;

  Future<List<FormSectionElement>> _getSections() async {
    final result = await runtime.evalForForm("""
const form = globalThis.Application.getForm(${jsonEncode(id)});
if (typeof form === "undefined") {
  return [];
}

const sections = form.getSections().map((e) => {
  return {
    id: e.id,
    header: e.header,
    footer: e.footer,
    items: e.items
  };
});

for (const section of sections) {
  for (const item of section.items) {
    if ("form" in item) {
      await globalThis.Application.initializeForm(item.id, item.form);
      item.form = item.id;
    }
  }
}

return sections;
""", label: 'form[$id] get sections');

    final sections = (result.value as List<dynamic>)
        .map((e) => FormSectionElement.fromJson(e as dynamic))
        .toList();

    final hasSubmit = await runtime.evalForForm("""
const form = globalThis.Application.getForm(${jsonEncode(id)});
if (typeof form === "undefined") {
  return false;
}
return form.requiresExplicitSubmission;
""", label: 'form[$id] read submission requirement');

    _requiresExplicitSubmission = hasSubmit.value == true;

    return sections;
  }

  @override
  Future<void> call(String method) async {
    await runtime.evalForForm("""
const form = globalThis.Application.getForm(${jsonEncode(id)});
if (typeof form !== "undefined") {
  await form.$method?.();
}
""", label: 'form[$id] call $method');
  }

  @override
  Future<void> reloadForm() async {
    await runtime.evalForForm("""
const form = globalThis.Application.getForm(${jsonEncode(id)});
if (typeof form !== "undefined") {
  form.formWillAppear?.();
}
""", label: 'form[$id] reload');

    _sections = _getSections();

    notifyListeners();
  }

  @override
  void uninitialize() {
    unawaited(
      runtime.evalForForm(
        'globalThis.Application.uninitializeForms();',
        label: 'form[$id] uninitialize all forms',
      ),
    );
  }

  @override
  Future<void> formDidSubmit() async {
    await runtime.evalForForm("""
const form = globalThis.Application.getForm(${jsonEncode(id)});
if (typeof form !== "undefined") {
  await form.formDidSubmit?.();
}
""", label: 'form[$id] submit');
  }

  @override
  Future<void> formDidCancel() async {
    await runtime.evalForForm("""
const form = globalThis.Application.getForm(${jsonEncode(id)});
if (typeof form !== "undefined") {
  await form.formDidCancel?.();
}
""", label: 'form[$id] cancel');
  }

  @override
  Future<dynamic> getSearchQueryMetadata() async {
    final result = await runtime.evalForForm("""
const form = globalThis.Application.getForm(${jsonEncode(id)});
if (typeof form === "undefined") {
  return null;
}
return await form.getSearchQueryMetadata?.();
""", label: 'form[$id] get search metadata');

    return result.value;
  }
}
