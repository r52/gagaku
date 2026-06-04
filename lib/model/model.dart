import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/objectbox.g.dart';
import 'package:gagaku/version.dart';
import 'package:hive_ce/hive.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart'
    show getApplicationDocumentsDirectory;

abstract class GagakuRoute {
  static const chapterfeed = '/titles/feed';
  static const library = '/titles/follows';
  static const history = '/my/history';
  static const lists = '/my/lists';

  static const latestfeed = '/titles/latest';
  static const recentfeed = '/titles/recent';
  static const login = '/login';
  static const manga = '/title/:mangaId';
  static const mangaAlt = '/title/:mangaId/:name';
  static const creator = '/author/:creatorId';
  static const creatorAlt = '/author/:creatorId/:name';
  static const chapter = '/chapter/:chapterId';
  static const group = '/group/:groupId';
  static const groupAlt = '/group/:groupId/:name';
  static const list = '/list/:listId';
  static const listAlt = '/list/:listId/:name';
  static const listEdit = '/list/edit/:listId';
  static const listCreate = '/create/list';
  static const search = '/titles';
  static const tag = '/tag/:tagId';
  static const tagAlt = '/tag/:tagId/:name';

  static const local = '/local';

  static const extension = '/extensions';
  static const extensionUpdates = '/extensions/updates';
  static const extensionSaved = '/extensions/saved';
  static const extensionHistory = '/extensions/history';
  static const extensionHomePage = '/extensions/:sourceId/home';
  static const extensionSearch = '/extensions/search';
  static const web = '/read';
  static const webManga = '/read/:sourceId/:mangaId';
  static const proxyChapter = '/read/:proxy/:code/:chapter/:page';
  static const extensionChapter = '/read-chapter/:sourceId/:mangaId/:chapterId';
  static const extensionAddRepo = '/extensions/addrepo';
  static const extensionInstall = '/extensions/install';

  static const config = '/config';
}

const gagakuLocalBox =
    'gagaku_box'; // local, device specific, or secure sensitive data
const gagakuCache = 'gagaku_cache'; // disk cache

const _blockers =
    'https://raw.githubusercontent.com/r52/gagaku/refs/heads/data/blockers.txt';
const _knownHosts =
    'https://raw.githubusercontent.com/r52/gagaku/refs/heads/data/known_hosts.json';

const defaultBrowserUserAgent =
    'Mozilla/5.0 (Linux; Android 16) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.7778.121 Mobile Safari/537.36';
const defaultSecChUa =
    '"Google Chrome";v="146", "Chromium";v="146", "Not_A Brand";v="24"';
const defaultSecChUaMobile = '?1';
const defaultSecChUaPlatform = '"Android"';

class GagakuData {
  GagakuData._internal();

  static final GagakuData _instance = GagakuData._internal();

  late final Store store;

  late final String extensionHost;

  // Default user agent
  final String gagakuUserAgent = '$kPackageName/$kPackageVersion';

  Map<String, String> dynamicUserAgentHeaders = {};
  Future<void>? _dynamicUserAgentFuture;

  List<String> blockers = [];
  Map<String, dynamic> knownHosts = {};

  factory GagakuData() {
    return _instance;
  }

  String? get dynamicUserAgent => dynamicUserAgentHeaders['user-agent'];
  String? get dynamicSecChUa => dynamicUserAgentHeaders['sec-ch-ua'];
  String? get dynamicSecChUaMobile =>
      dynamicUserAgentHeaders['sec-ch-ua-mobile'];
  String? get dynamicSecChUaPlatform =>
      dynamicUserAgentHeaders['sec-ch-ua-platform'];

  Map<String, String> get browserUserAgentHeaders {
    return {
      'user-agent': defaultBrowserUserAgent,
      'sec-ch-ua': defaultSecChUa,
      'sec-ch-ua-mobile': defaultSecChUaMobile,
      'sec-ch-ua-platform': defaultSecChUaPlatform,
      ...dynamicUserAgentHeaders,
    };
  }

  Future<Map<String, String>> resolveBrowserUserAgentHeaders() async {
    final future = _dynamicUserAgentFuture;
    if (future != null && dynamicUserAgent == null) {
      try {
        await future.timeout(const Duration(seconds: 2));
      } catch (_) {}
    }

    return browserUserAgentHeaders;
  }

  void _setDynamicUserAgentHeaders(Map<String, String> headers) {
    dynamicUserAgentHeaders = headers;
  }

  Map<String, String> _extractUserAgentHeaders(Map<String, String> headers) {
    return {
      for (final MapEntry(:key, :value) in headers.entries)
        if (key == 'user-agent' || key.startsWith('sec-ch-ua')) key: value,
    };
  }

  Future<void> _fetchDynamicUserAgent() async {
    HeadlessInAppWebView? headlessWebView;
    bool fetched = false;

    headlessWebView = HeadlessInAppWebView(
      initialUrlRequest: URLRequest(url: WebUri("https://localhost/")),
      initialSettings: InAppWebViewSettings(useShouldInterceptRequest: true),
      shouldInterceptRequest: (controller, request) async {
        if (request.url.toString() == "https://localhost/") {
          final headers =
              request.headers?.map(
                (key, value) => MapEntry(key.toLowerCase(), value),
              ) ??
              {};
          final ua = headers['user-agent'];

          if (ua != null && ua.isNotEmpty) {
            _setDynamicUserAgentHeaders(_extractUserAgentHeaders(headers));
            fetched = true;

            logger.d("Fast fetched dynamic user agent: $dynamicUserAgent");
            if (dynamicSecChUa != null) {
              logger.d(
                "Fast Client Hints - UA: $dynamicSecChUa, Mobile: $dynamicSecChUaMobile, Platform: $dynamicSecChUaPlatform",
              );
            }
          }

          return WebResourceResponse(
            contentType: "text/html",
            data: Uint8List.fromList([]),
            statusCode: 200,
            reasonPhrase: "OK",
            headers: {"Content-Type": "text/html; charset=utf-8"},
          );
        }
        return null;
      },
      onLoadStop: (controller, url) async {
        if (fetched) {
          headlessWebView?.dispose();
          return;
        }
        try {
          final jsSource = '''
            (function() {
              var result = {
                userAgent: navigator.userAgent
              };
              
              if (navigator.userAgentData) {
                result.secChUa = navigator.userAgentData.brands
                  .map(function(b) { return '"' + b.brand + '";v="' + b.version + '"'; })
                  .join(', ');
                result.secChUaMobile = navigator.userAgentData.mobile ? "?1" : "?0";
                result.secChUaPlatform = '"' + navigator.userAgentData.platform + '"';
              }
              
              return result;
            })();
          ''';

          final uaResult = await controller.evaluateJavascript(
            source: jsSource,
          );

          if (uaResult is Map) {
            _setDynamicUserAgentHeaders({
              if (uaResult['userAgent'] != null)
                'user-agent': uaResult['userAgent'].toString(),
              if (uaResult['secChUa'] != null)
                'sec-ch-ua': uaResult['secChUa'].toString(),
              if (uaResult['secChUaMobile'] != null)
                'sec-ch-ua-mobile': uaResult['secChUaMobile'].toString(),
              if (uaResult['secChUaPlatform'] != null)
                'sec-ch-ua-platform': uaResult['secChUaPlatform'].toString(),
            });

            logger.d("Fetched dynamic user agent: $dynamicUserAgent");
            if (dynamicSecChUa != null) {
              logger.d(
                "Client Hints - UA: $dynamicSecChUa, Mobile: $dynamicSecChUaMobile, Platform: $dynamicSecChUaPlatform",
              );
            }
          }
        } catch (e) {
          logger.e("Failed to evaluate user agent script", error: e);
        } finally {
          headlessWebView?.dispose();
        }
      },
      onReceivedError: (controller, request, error) {
        logger.e(
          'Failed to get dynamic user agent: ${error.description}',
          error: error,
        );
        headlessWebView?.dispose();
      },
      onReceivedHttpError: (controller, request, errorResponse) {
        logger.e(
          'Failed to get dynamic user agent with status: ${errorResponse.statusCode}',
        );
        headlessWebView?.dispose();
      },
    );

    await headlessWebView.run();
  }

  Future<void> initData() async {
    extensionHost = await rootBundle.loadString(
      'assets/extensionhost/bundle.js',
    );

    // Fire and forget finding the dynamic agent so we do not block runApp.
    _dynamicUserAgentFuture = _fetchDynamicUserAgent().catchError((
      Object error,
      StackTrace stackTrace,
    ) {
      logger.e(
        'Failed to start dynamic user agent fetch',
        error: error,
        stackTrace: stackTrace,
      );
    });

    final blockerUri = Uri.parse(_blockers);
    final hostsUri = Uri.parse(_knownHosts);

    try {
      final (blockerResp, hostsResp) = await (
        http.get(blockerUri),
        http.get(hostsUri),
      ).wait;

      if (blockerResp.statusCode != 200) {
        final err = "Failed to load $blockerUri";
        logger.e(err);
      } else {
        LineSplitter ls = LineSplitter();
        blockers = ls.convert(blockerResp.body);
      }

      if (hostsResp.statusCode != 200) {
        final err = "Failed to load $hostsUri";
        logger.e(err);
      } else {
        knownHosts = json.decode(hostsResp.body);
      }
    } catch (e) {
      logger.e(e);
    }
  }

  Future<void> initGagakuBoxes() async {
    final appDir = await getApplicationDocumentsDirectory();
    await Hive.openBox(gagakuLocalBox);

    final storage = Hive.box(gagakuLocalBox);
    // On Windows debug builds, always use the default appDir.path to avoid issues
    // with a previously set data location. In other cases, respect the stored 'data_location'.
    final dataLocation = (Platform.isWindows && kDebugMode)
        ? appDir.path
        : (storage.get('data_location') ?? appDir.path);

    // non-device specific, non-local, insecure data
    store = await openStore(directory: p.join(dataLocation, "gagaku"));
  }
}
