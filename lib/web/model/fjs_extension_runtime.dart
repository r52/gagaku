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

enum _RuntimeEvalExecutorState { accepting, closing, closed }

class _RuntimeEvalExecutor {
  var _state = _RuntimeEvalExecutorState.accepting;
  Future<void> _tail = Future<void>.value();
  Future<void>? _closeFuture;

  Future<T> run<T>(Future<T> Function() action) {
    if (_state != _RuntimeEvalExecutorState.accepting) {
      return Future<T>.error(StateError('fjs extension runtime is closing'));
    }

    final operation = _tail.then((_) => action());
    _tail = operation.then<void>((_) {}, onError: (_, _) {});
    return operation;
  }

  Future<void> close() {
    final closeFuture = _closeFuture;
    if (closeFuture != null) {
      return closeFuture;
    }

    _state = _RuntimeEvalExecutorState.closing;
    return _closeFuture = _tail.whenComplete(() {
      _state = _RuntimeEvalExecutorState.closed;
    });
  }
}

class FjsExtensionRuntime implements ExtensionRuntime {
  FjsExtensionRuntime({
    required this.sourceId,
    required this.extensionHost,
    required this.onResetAllState,
    required this.onSetExtensionState,
    required this.onSetExtensionSecureState,
    required this.getExtensionState,
    required this.getExtensionSecureState,
    this.startupBrowserTimeout = const Duration(seconds: 15),
  });

  final String sourceId;
  final String extensionHost;
  final void Function(String) onResetAllState;
  final void Function(String, dynamic) onSetExtensionState;
  final void Function(String, dynamic) onSetExtensionSecureState;
  final dynamic Function(String) getExtensionState;
  final dynamic Function(String) getExtensionSecureState;
  @visibleForTesting
  final Duration startupBrowserTimeout;

  static Future<void>? _libInit;
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
  final _evalExecutor = _RuntimeEvalExecutor();
  Future<void>? _disposeFuture;

  @override
  bool get hasAdvancedSearchForm => _hasAdvancedSearchForm;

  @override
  bool get hasSortOps => _hasSortOps;

  static Future<void> _ensureLibInit() {
    return _libInit ??= LibFjs.init();
  }

  Future<JsValue> _evalGlobal(
    String source, {
    String label = 'unlabelled eval',
  }) {
    return _evalExecutor.run(() async {
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
    });
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
      final defaultUserAgentHeaders = await _runInitStep(
        'resolve default user agent headers',
        () => GagakuData().resolveBrowserUserAgentHeaders(),
      );
      await _runInitStep(
        'install host bridge',
        () => _evalGlobal(
          _bootstrapScript(defaultUserAgentHeaders),
          label: 'install host bridge',
        ),
      );
      final startupBrowserState = await _runInitStep(
        'load startup browser state',
        () => _loadStartupBrowserState(source),
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
        'notify Cloudflare bypass completion',
        () => _notifyCloudflareBypassCompleted(source, startupBrowserState),
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

  String _bootstrapScript(Map<String, String> defaultUserAgentHeaders) {
    return '''
globalThis.window = globalThis;
globalThis.self = globalThis;
globalThis.global = globalThis;
globalThis.source ??= {};

globalThis.gagaku = Object.assign(globalThis.gagaku ?? {}, {
  defaultUserAgentHeaders: Object.freeze(${jsonEncode(defaultUserAgentHeaders)}),
  callHandler: async (handlerName, ...args) => {
    return await fjs.bridge_call(
      JSON.stringify({ handlerName, args })
    );
  }
});
''';
  }

  Future<({List<Cookie> cookies, Map<String, String> localStorage})>
  _loadStartupBrowserState(WebSourceInfo source) async {
    final baseUrl = source.baseUrl;
    if (baseUrl == null || baseUrl.isEmpty) {
      _cookies = null;
      return (
        cookies: const <Cookie>[],
        localStorage: const <String, String>{},
      );
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

    final completer =
        Completer<({List<Cookie> cookies, Map<String, String> localStorage})>();
    final requiresCloudflare = source.hasCapability(
      SourceIntents.cloudflareBypassRequired,
    );
    var latestCookies = <Cookie>[];
    var latestLocalStorage = <String, String>{};
    var challengeObserved = false;
    Timer? timeout;
    HeadlessInAppWebView? startupView;

    void complete() {
      if (!completer.isCompleted) {
        completer.complete((
          cookies: latestCookies,
          localStorage: latestLocalStorage,
        ));
      }
    }

    void completeError(Object error, StackTrace stackTrace) {
      if (!completer.isCompleted) {
        completer.completeError(error, stackTrace);
      }
    }

    timeout = Timer(startupBrowserTimeout, () {
      if (requiresCloudflare &&
          challengeObserved &&
          _cloudflareClearance(latestCookies) == null) {
        completeError(const CloudflareBypassException(), StackTrace.current);
      } else {
        complete();
      }
    });

    try {
      void markChallengeObserved() {
        if (!challengeObserved) {
          challengeObserved = true;
          debugPrint('fjs[$sourceId]: Cloudflare challenge observed');
        }
      }

      void observeUrl(WebUri? url) {
        if (_isCloudflareChallengeUrl(url)) {
          markChallengeObserved();
        }
      }

      startupView = HeadlessInAppWebView(
        initialUrlRequest: URLRequest(url: WebUri(baseUrl)),
        initialSettings: InAppWebViewSettings(
          contentBlockers: contentBlockers.isEmpty ? null : contentBlockers,
          browserAcceleratorKeysEnabled: false,
          isInspectable: false,
        ),
        onLoadStart: (controller, url) {
          observeUrl(url);
        },
        onUpdateVisitedHistory: (controller, url, isReload) {
          observeUrl(url);
        },
        onTitleChanged: (controller, title) {
          if (_isCloudflareChallengeTitle(title)) {
            markChallengeObserved();
          }
        },
        onReceivedHttpError: (controller, request, errorResponse) {
          observeUrl(request.url);
          if (request.isForMainFrame == true &&
              _isCloudflareChallengeResponse(errorResponse.headers)) {
            markChallengeObserved();
          }
        },
        onLoadStop: (controller, url) async {
          if (url == null) {
            return;
          }

          observeUrl(url);
          try {
            final cookies = await CookieManager.instance().getCookies(
              url: WebUri.uri(url),
              webViewController: controller,
            );
            latestCookies = cookies;
            if (requiresCloudflare) {
              latestLocalStorage = await _readLocalStorage(controller);
            }

            final hasClearance = _cloudflareClearance(cookies) != null;
            if (!requiresCloudflare || hasClearance || !challengeObserved) {
              complete();
              return;
            }
          } catch (error, stackTrace) {
            completeError(error, stackTrace);
          }
        },
      );

      await startupView.run();
      final result = await completer.future;
      _cookies = result.cookies;
      return result;
    } on CloudflareBypassException {
      _cookies = const [];
      rethrow;
    } catch (error, stackTrace) {
      debugPrint(
        'fjs[$sourceId]: failed to load startup cookies\n$error\n$stackTrace',
      );
      _cookies = const [];
      return (
        cookies: const <Cookie>[],
        localStorage: const <String, String>{},
      );
    } finally {
      timeout.cancel();
      startupView?.dispose();
    }
  }

  Cookie? _cloudflareClearance(List<Cookie> cookies) {
    return cookies.firstWhereOrNull((cookie) => cookie.name == 'cf_clearance');
  }

  bool _isCloudflareChallengeUrl(WebUri? url) {
    return url?.queryParameters.keys.any(
          (name) => name.startsWith('__cf_chl_'),
        ) ==
        true;
  }

  bool _isCloudflareChallengeResponse(Map<String, String>? headers) {
    return headers?.entries.any(
          (header) =>
              header.key.toLowerCase() == 'cf-mitigated' &&
              header.value.toLowerCase() == 'challenge',
        ) ==
        true;
  }

  bool _isCloudflareChallengeTitle(String? title) {
    return title?.toLowerCase().contains('just a moment') == true;
  }

  Future<Map<String, String>> _readLocalStorage(
    InAppWebViewController controller,
  ) async {
    try {
      final encoded = await controller.evaluateJavascript(
        source:
            'JSON.stringify(Object.fromEntries(Object.entries(localStorage)))',
      );
      if (encoded is! String) {
        return const {};
      }

      final values = jsonDecode(encoded);
      if (values is! Map) {
        return const {};
      }

      return {
        for (final MapEntry(:key, :value) in values.entries)
          key.toString(): value.toString(),
      };
    } catch (error, stackTrace) {
      debugPrint(
        'fjs[$sourceId]: failed to read Cloudflare local storage\n'
        '$error\n$stackTrace',
      );
      return const {};
    }
  }

  Future<void> _notifyCloudflareBypassCompleted(
    WebSourceInfo source,
    ({List<Cookie> cookies, Map<String, String> localStorage}) result,
  ) async {
    if (!source.hasCapability(SourceIntents.cloudflareBypassRequired) ||
        !result.cookies.any((cookie) => cookie.name == 'cf_clearance')) {
      return;
    }

    final expectedDomain = Uri.parse(source.baseUrl!).host;
    final pbCookies = result.cookies
        .map(
          (cookie) => PaperbackCookie(
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
const request = ${jsonEncode({'url': source.baseUrl, 'method': 'GET'})};
const cookies = ${jsonEncode(pbCookies.map((cookie) => cookie.toJson()).toList())}.map((cookie) => {
  return {
    ...cookie,
    created: cookie.created ? new Date(cookie.created) : undefined,
    expires: cookie.expires ? new Date(cookie.expires) : undefined
  };
});
const localStorage = ${jsonEncode(result.localStorage)};
if (typeof globalThis.${source.id}.cloudflareBypassCompleted === "function") {
  await globalThis.${source.id}.cloudflareBypassCompleted(request, cookies, localStorage);
} else if (typeof globalThis.${source.id}.saveCloudflareBypassCookies === "function") {
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
    final dynamic payload;
    try {
      payload = switch (bridgeValue) {
        String encoded => jsonDecode(encoded),
        _ => bridgeValue,
      };
    } catch (error) {
      return JsResult.err(
        JsError.bridge('Invalid gagaku bridge payload: $error'),
      );
    }
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
    final handlerName = payload['handlerName'];
    final rawArgs = payload['args'];
    if (handlerName is! String || (rawArgs != null && rawArgs is! List)) {
      return const JsResult.err(
        JsError.bridge('Invalid gagaku bridge handler payload'),
      );
    }
    final args = rawArgs as List? ?? const [];
    if (kDebugMode) {
      debugPrint('fjs[$sourceId] bridge: $handlerName(${jsonEncode(args)})');
    }

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
        final instanceId = args.length < 2 ? null : args[1];
        if (formId is String && instanceId is String) {
          _forms[formId] = FjsExtensionForm(
            id: formId,
            instanceId: instanceId,
            runtime: this,
          );
        }
        return JsResult.ok(const JsValue.none());
      case 'uninitializeForm':
        final formId = args.isEmpty ? null : args.first;
        final instanceId = args.length < 2 ? null : args[1];
        if (formId is String &&
            instanceId is String &&
            _forms[formId]?.instanceId == instanceId) {
          _forms.remove(formId);
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

    final value = _normalizeBridgeJson(result.value);
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
    return switch (details) {
      ImageChapterDetails(:final pages) => pages,
      HtmlChapterDetails() => throw UnsupportedError(
        'Text novel chapters are not supported',
      ),
      FileChapterDetails() => throw UnsupportedError(
        'File chapters are not supported',
      ),
    };
  }

  @override
  List<Cookie>? getCookies() {
    return _cookies;
  }

  @override
  Future<List<DiscoverSection>> getDiscoverSections(
    WebSourceInfo source,
  ) async {
    if (!source.hasCapability(SourceIntents.discoverSections)) {
      throw UnsupportedError("Source does not support discover sections");
    }

    final sectionsJson = await _evalJsonScoped(
      'return await globalThis.$sourceId.getDiscoverSections();',
      label: 'get discover sections',
    );
    final normalizedSections = _normalizeBridgeJson(sectionsJson);
    if (normalizedSections is! List) {
      throw StateError(
        'Expected getDiscoverSections to return a list, got '
        '${normalizedSections.runtimeType}',
      );
    }

    return normalizedSections
        .map(
          (section) => DiscoverSection.fromJson(
            _normalizeBridgeJsonMap(section, 'getDiscoverSections item'),
          ),
        )
        .toList();
  }

  @override
  Future<PagedResults<DiscoverSectionItem>> getDiscoverSectionItems(
    WebSourceInfo source,
    DiscoverSection section,
    dynamic metadata,
  ) async {
    if (!source.hasCapability(SourceIntents.discoverSections)) {
      throw UnsupportedError("Source does not support discover sections");
    }

    final resultsJson = await _evalJsonScoped('''
const section = ${_json(section.toJson())};
const metadata = ${_json(metadata)};
return await globalThis.$sourceId.getDiscoverSectionItems(
  section,
  metadata ?? undefined
);
''', label: 'get discover section items');

    return PagedResults.fromJson(
      _normalizeBridgeJsonMap(resultsJson, 'getDiscoverSectionItems'),
      (item) => DiscoverSectionItem.fromJson(
        _normalizeBridgeJsonMap(item, 'getDiscoverSectionItems item'),
      ),
    );
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
  Future<String?> getMangaURL(String mangaId) async {
    if (mangaId.isEmpty) {
      return null;
    }

    try {
      final result = await _evalScoped('''
try {
  return await globalThis.$sourceId.getMangaShareUrl?.(${_json(mangaId)}) ??
    null;
} catch {
  return null;
}
''', label: 'get manga share URL');
      return result.value as String?;
    } catch (_) {
      return null;
    }
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
  Future<List<SortingOption>?> getSortingOptions(SearchQuery query) async {
    if (!_hasSortOps) {
      return null;
    }

    final optionsJson = await _evalJsonScoped('''
const query = ${_json(query.toJson())};
if (query.metadata === null) delete query.metadata;
return await globalThis.$sourceId.getSortingOptions?.(query) ?? null;
''', label: 'get sorting options');
    final normalizedOptions = _normalizeBridgeJson(optionsJson);
    if (normalizedOptions == null) {
      return null;
    }
    if (normalizedOptions is! List) {
      throw StateError(
        'Expected getSortingOptions to return a list, got '
        '${normalizedOptions.runtimeType}',
      );
    }

    return normalizedOptions
        .map(
          (option) => SortingOption.fromJson(
            _normalizeBridgeJsonMap(option, 'getSortingOptions item'),
          ),
        )
        .toList();
  }

  @override
  Future<Uint8List> processImageRequest(String url) async {
    final result = await _evalScoped(
      kDebugMode
          ? """
const [response, body] = await globalThis.Application.scheduleRequest({
  url: ${_json(url)},
  method: "GET"
});
return [
  response.status ?? null,
  response.url ?? null,
  response.mimeType ?? null,
  response.headers ?? {},
  new Uint8Array(body)
];
"""
          : """
const [, body] = await globalThis.Application.scheduleRequest({
  url: ${_json(url)},
  method: "GET"
});
return new Uint8Array(body);
""",
    );

    final value = result.value;
    final rawBytes = kDebugMode ? _logImageRequest(url, value) : value;
    final bytes = switch (rawBytes) {
      Uint8List bytes => bytes,
      List bytes => Uint8List.fromList(bytes.cast<int>()),
      _ => throw StateError(
        'Expected fjs image request to return bytes, got '
        '${rawBytes.runtimeType}',
      ),
    };

    return bytes;
  }

  dynamic _logImageRequest(String url, dynamic value) {
    if (value is! List || value.length < 5) {
      throw StateError(
        'Expected fjs image request to return response metadata, got '
        '${value.runtimeType}',
      );
    }

    final statusCode = switch (value[0]) {
      int status => status,
      num status => status.toInt(),
      _ => null,
    };
    final responseUrl = value[1] as String?;
    final mimeType = value[2] as String?;
    final responseHeaders = switch (value[3]) {
      Map headers => <String, String>{
        for (final MapEntry(:key, :value) in headers.entries)
          key.toString(): value.toString(),
      },
      _ => const <String, String>{},
    };
    final rawBytes = value[4];
    final bytesLength = switch (rawBytes) {
      Uint8List bytes => bytes.lengthInBytes,
      List bytes => bytes.length,
      _ => null,
    };
    final failed = statusCode != null && statusCode >= 400;
    debugPrint(
      'fjs[$sourceId] image.request${failed ? ' failed' : ''} '
      'status=${statusCode ?? 'unknown'} '
      '${bytesLength ?? 'unknown'} bytes '
      'mime=${mimeType ?? 'unknown'} '
      'url=${responseUrl ?? url} '
      'headers=${jsonEncode(responseHeaders)}',
    );

    return rawBytes;
  }

  @override
  Future<PagedResults<SearchResultItem>> searchManga(
    SearchQuery query,
    dynamic metadata, {
    SortingOption? sortOp,
  }) async {
    if (query.isEmpty) {
      return PagedResults<SearchResultItem>(items: []);
    }

    final resultsJson = await _evalJsonScoped('''
const query = ${_json(query.toJson())};
if (query.metadata === null) delete query.metadata;
const metadata = ${_json(metadata)};
const sortOp = ${_json(sortOp?.toJson())};
return await globalThis.$sourceId.getSearchResults(
  query,
  metadata ?? undefined,
  sortOp ?? undefined
);
''', label: 'search manga');

    return PagedResults.fromJson(
      _normalizeBridgeJsonMap(resultsJson, 'getSearchResults'),
      (item) => SearchResultItem.fromJson(
        _normalizeBridgeJsonMap(item, 'getSearchResults item'),
      ),
    );
  }

  @override
  Future<void> uninitializeForms(WebSourceInfo source) async {
    if (!source.hasCapability(SourceIntents.settingsUI)) {
      throw UnsupportedError("Source does not support settings");
    }

    await _evalScoped('globalThis.Application.uninitializeForms();');
  }

  @override
  Future<void> dispose() => _disposeFuture ??= _dispose();

  Future<void> _dispose() async {
    await _evalExecutor.close();

    final engine = _engine;
    _engine = null;
    _hasAdvancedSearchForm = false;
    _hasSortOps = false;
    _cookies = null;
    _forms.clear();

    if (engine == null) {
      return;
    }

    try {
      debugPrint('fjs[$sourceId]: closing engine');
      await engine.close();
    } finally {
      engine.dispose();
    }
  }
}

class FjsExtensionForm extends ExtensionForm {
  FjsExtensionForm({
    required this.id,
    required this.instanceId,
    required this.runtime,
  }) {
    _sections = _getSections();
  }

  @override
  final FormID id;
  final String instanceId;

  final FjsExtensionRuntime runtime;

  late Future<List<FormSectionElement>> _sections;

  @override
  Future<List<FormSectionElement>> get sections => _sections;

  bool _requiresExplicitSubmission = false;

  @override
  bool get requiresExplicitSubmission => _requiresExplicitSubmission;

  Future<List<FormSectionElement>> _getSections() async {
    final result = await runtime.evalForForm("""
const form = globalThis.Application.getForm(
  ${jsonEncode(id)},
  ${jsonEncode(instanceId)}
);
if (typeof form === "undefined") {
  return [];
}

const sections = form.getSections().map((section) => ({
  ...section,
  items: section.items.map((item) => ({ ...item }))
}));

for (const section of sections) {
  for (const item of section.items) {
    if ("form" in item && typeof item.form === "object" && item.form !== null) {
      const formId = item.id;
      await globalThis.Application.initializeForm(formId, item.form);
      item.form = formId;
    }
  }
}

return sections;
""", label: 'form[$id] get sections');

    final normalized = runtime._normalizeBridgeJson(result.value);
    final sections = (normalized as List<dynamic>)
        .map(
          (e) => FormSectionElement.fromJson(
            runtime._normalizeBridgeJsonMap(e, 'form[$id] section'),
          ),
        )
        .toList();

    final hasSubmit = await runtime.evalForForm("""
const form = globalThis.Application.getForm(
  ${jsonEncode(id)},
  ${jsonEncode(instanceId)}
);
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
const form = globalThis.Application.getForm(
  ${jsonEncode(id)},
  ${jsonEncode(instanceId)}
);
if (typeof form !== "undefined") {
  await form.$method?.();
}
""", label: 'form[$id] call $method');
  }

  @override
  Future<void> reloadForm() async {
    await runtime.evalForForm("""
const form = globalThis.Application.getForm(
  ${jsonEncode(id)},
  ${jsonEncode(instanceId)}
);
if (typeof form !== "undefined") {
  form.formWillAppear?.();
}
""", label: 'form[$id] reload');

    _sections = _getSections();

    notifyListeners();
  }

  @override
  Future<void> uninitialize() async {
    await runtime.evalForForm(
      'globalThis.Application.uninitializeForm('
      '${jsonEncode(id)}, ${jsonEncode(instanceId)});',
      label: 'form[$id] uninitialize instance',
    );
  }

  @override
  Future<void> formDidSubmit() async {
    await runtime.evalForForm("""
const form = globalThis.Application.getForm(
  ${jsonEncode(id)},
  ${jsonEncode(instanceId)}
);
if (typeof form !== "undefined") {
  await form.formDidSubmit?.();
}
""", label: 'form[$id] submit');
  }

  @override
  Future<void> formDidCancel() async {
    await runtime.evalForForm("""
const form = globalThis.Application.getForm(
  ${jsonEncode(id)},
  ${jsonEncode(instanceId)}
);
if (typeof form !== "undefined") {
  await form.formDidCancel?.();
}
""", label: 'form[$id] cancel');
  }

  @override
  Future<dynamic> getSearchQueryMetadata() async {
    final result = await runtime.evalForForm("""
const form = globalThis.Application.getForm(
  ${jsonEncode(id)},
  ${jsonEncode(instanceId)}
);
if (typeof form === "undefined") {
  return null;
}
return await form.getSearchQueryMetadata?.();
""", label: 'form[$id] get search metadata');

    return result.value;
  }
}
