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
  static const extensionTrackers = '/extensions/trackers';

  static const config = '/config';

  static const shareHost = 'r52.github.io';
  static const shareWebManga = '/gagaku/open.html';
  static const shareVersion = '1';
  static const shareMangaType = 'manga';

  static Uri webMangaShareUri({
    required String sourceId,
    required String mangaId,
  }) {
    return Uri.https(shareHost, shareWebManga, {
      'v': shareVersion,
      'type': shareMangaType,
      'source': sourceId,
      'manga': mangaId,
    });
  }

  static ({String sourceId, String mangaId})? parseWebMangaShareUri(Uri uri) {
    final query = uri.queryParameters;
    final sourceId = query['source'];
    final mangaId = query['manga'];

    if (uri.path != shareWebManga ||
        query['v'] != shareVersion ||
        query['type'] != shareMangaType ||
        sourceId == null ||
        sourceId.isEmpty ||
        mangaId == null ||
        mangaId.isEmpty) {
      return null;
    }

    return (sourceId: sourceId, mangaId: mangaId);
  }
}

const gagakuLocalBox =
    'gagaku_box'; // local, device specific, or secure sensitive data
const gagakuCache = 'gagaku_cache'; // disk cache
const trackerQueueBox =
    'gagaku_tracker_queue'; // device-local tracker read actions

const _blockers =
    'https://raw.githubusercontent.com/r52/gagaku/refs/heads/data/blockers.txt';
const _knownHosts =
    'https://raw.githubusercontent.com/r52/gagaku/refs/heads/data/known_hosts.json';

const defaultBrowserUserAgent =
    'Mozilla/5.0 (Linux; Android 17; K; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/156.0.8078.39 Mobile Safari/537.36';

/// Used until the device's own WebView identity is known.
final _fallbackBrowserUserAgentHeaders = Map<String, String>.unmodifiable(
  deriveBrowserUserAgentHeaders(
    defaultBrowserUserAgent,
    TargetPlatform.android,
  )!,
);

/// Synthesizes low-entropy hints for Android WebView and Windows WebView2.
/// This follows Chromium's current GREASE algorithm, not authoritative metadata.
Map<String, String>? deriveBrowserUserAgentHeaders(
  String userAgent,
  TargetPlatform platform,
) {
  if (!userAgent.startsWith('Mozilla/5.0 ') ||
      !userAgent.contains('AppleWebKit/')) {
    return null;
  }

  final chromiumVersion = RegExp(r'(?:Chrome|Chromium)/(\d+)(?:\.\d+){0,3}')
      .firstMatch(userAgent);
  if (chromiumVersion == null) {
    return null;
  }

  final majorVersion = int.tryParse(chromiumVersion.group(1)!);
  if (majorVersion == null) {
    return null;
  }

  final (String, String, String) identity;
  switch (platform) {
    case TargetPlatform.android when userAgent.contains('; wv)'):
      identity = ('Android WebView', '$majorVersion', 'Android');
    case TargetPlatform.windows:
      final edgeVersion = RegExp(r'Edg/(\d+)(?:\.\d+){0,3}')
          .firstMatch(userAgent);
      if (edgeVersion == null) {
        return null;
      }
      identity = ('Microsoft Edge', edgeVersion.group(1)!, 'Windows');
    default:
      return null;
  }
  final (browserBrand, browserVersion, platformName) = identity;

  return {
    'user-agent': userAgent,
    'sec-ch-ua': _buildSecChUa(majorVersion, browserBrand, browserVersion),
    'sec-ch-ua-mobile': userAgent.contains(' Mobile ') ? '?1' : '?0',
    'sec-ch-ua-platform': '"$platformName"',
  };
}

String _buildSecChUa(
  int chromiumMajor,
  String browserBrand,
  String browserVersion,
) {
  // Chromium 156: GetGreasedUserAgentBrandVersion and ShuffleBrandList.
  // Update if Chromium changes its algorithm; the major alone handles releases.
  // https://github.com/chromium/chromium/blob/156.0.8078.39/components/embedder_support/user_agent_utils.cc
  const greaseChars = [' ', '(', ':', '-', '.', '/', ')', ';', '=', '?', '_'];
  const greaseVersions = ['8', '99', '24'];
  const orders = [
    [0, 1, 2],
    [0, 2, 1],
    [1, 0, 2],
    [1, 2, 0],
    [2, 0, 1],
    [2, 1, 0],
  ];
  final greaseBrand =
      'Not${greaseChars[chromiumMajor % greaseChars.length]}'
      'A${greaseChars[(chromiumMajor + 1) % greaseChars.length]}Brand';
  final greaseVersion = greaseVersions[chromiumMajor % greaseVersions.length];
  final brands = [
    '"$greaseBrand";v="$greaseVersion"',
    '"Chromium";v="$chromiumMajor"',
    '"$browserBrand";v="$browserVersion"',
  ];
  final order = orders[chromiumMajor % orders.length];
  final shuffled = List<String>.filled(3, '');
  for (var i = 0; i < brands.length; i++) {
    shuffled[order[i]] = brands[i];
  }
  return shuffled.join(', ');
}

class GagakuData {
  GagakuData._internal();

  static final GagakuData _instance = GagakuData._internal();

  late final Store store;

  late final String extensionHost;

  // Default user agent
  final String gagakuUserAgent = '$kPackageName/$kPackageVersion';

  /// The device's WebView identity, seeded once by whichever reports first:
  /// the native default-UA query at startup, or the first complete identity
  /// captured from a live WebView (Windows has no native getter).
  Map<String, String> _dynamicUserAgentHeaders = const {};
  Future<void>? _dynamicUserAgentFuture;

  List<String> blockers = [];
  Map<String, dynamic> knownHosts = {};

  factory GagakuData() {
    return _instance;
  }

  String? get dynamicUserAgent => _dynamicUserAgentHeaders['user-agent'];

  @visibleForTesting
  Map<String, String> get dynamicUserAgentHeaders => _dynamicUserAgentHeaders;

  /// Replaces the identity outright; production code seeds it instead.
  @visibleForTesting
  set dynamicUserAgentHeaders(Map<String, String> headers) {
    _dynamicUserAgentHeaders = Map.unmodifiable(headers);
  }

  Map<String, String> get browserUserAgentHeaders {
    return {..._fallbackBrowserUserAgentHeaders, ..._dynamicUserAgentHeaders};
  }

  Future<Map<String, String>> resolveBrowserUserAgentHeaders() async {
    final future = _dynamicUserAgentFuture;
    if (future != null && dynamicUserAgent == null) {
      try {
        await future.timeout(const Duration(seconds: 2));
      } catch (_) {}
      // Wait at most once; later callers use whichever identity is known.
      _dynamicUserAgentFuture = null;
    }

    return browserUserAgentHeaders;
  }

  /// Sets the device identity unless one is already established. Returns
  /// whether [headers] were adopted.
  bool seedBrowserUserAgentHeaders(Map<String, String> headers) {
    if (dynamicUserAgent != null) {
      return false;
    }
    _dynamicUserAgentHeaders = Map.unmodifiable(headers);
    return true;
  }

  Future<void> _fetchDynamicUserAgent() async {
    final userAgent = await InAppWebViewController.getDefaultUserAgent();
    final headers = deriveBrowserUserAgentHeaders(
      userAgent,
      defaultTargetPlatform,
    );
    if (headers == null) {
      logger.w("Could not derive browser headers from user agent: $userAgent");
      return;
    }

    if (seedBrowserUserAgentHeaders(headers)) {
      logger.d("Fetched dynamic browser headers: $headers");
    }
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
    await Hive.openBox<String>(trackerQueueBox);

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
