import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:dart_eval/dart_eval.dart';
import 'package:dart_eval/dart_eval_security.dart';
import 'package:dart_eval/stdlib/core.dart';
import 'package:flutter/material.dart';
import 'package:gagaku/cache.dart';
import 'package:gagaku/http.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/model.dart';
import 'package:gagaku/util.dart';
import 'package:gagaku/web/eval/plugin.dart';
import 'package:gagaku/web/eval/util.dart';
import 'package:gagaku/web/model/config.dart';
import 'package:gagaku/web/model/types.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'model.g.dart';

@Riverpod(keepAlive: true)
ProxyHandler proxy(ProxyRef ref) {
  return ProxyHandler(ref);
}

class ProxyHandler {
  ProxyHandler(this.ref) {
    _cache = ref.watch(cacheProvider);
  }

  final Ref ref;
  final http.Client client = CustomClient();
  late final CacheManager _cache;

  Future<void> invalidateCacheItem(String item) async {
    if (await _cache.exists(item)) {
      await _cache.remove(item);
    }
  }

  Future<void> invalidateAll(String startsWith) async {
    await _cache.invalidateAll(startsWith);
  }

  Future<bool> handleUrl({required String url, required BuildContext context}) async {
    if (url.startsWith('https://imgur.com/a/')) {
      final src = url.substring(20);
      final code = '/read/api/imgur/chapter/$src';
      GoRouter.of(context).push('/read/imgur/$src/1/1/',
          extra: WebReaderData(source: code, info: SourceInfo(type: SourceType.proxy, source: 'imgur', location: src)));
      ref.read(webSourceHistoryProvider.notifier).add(HistoryLink(title: url, url: url));
      return true;
    }

    if (url.startsWith('https://cubari.moe/')) {
      final info = await parseUrl(url);

      if (info == null) {
        return false;
      }

      if (!context.mounted) return false;
      if (info.chapter != null) {
        GoRouter.of(context).push('/read/${info.source}/${info.location}/${info.chapter}/1/');
      } else {
        GoRouter.of(context).push('/read/${info.source}/${info.location}');
      }

      return true;
    }

    final sourceMgr = await ref.watch(webSourceManagerProvider.future);
    if (sourceMgr != null) {
      for (final MapEntry(key: key, value: src) in sourceMgr.sources.entries) {
        if (url.startsWith('${src.baseUrl}${src.mangaPath}')) {
          if (!context.mounted) return false;
          GoRouter.of(context).push('/read/${src.name}/$url',
              extra: SourceInfo(type: SourceType.source, source: src.name, location: url, parser: key));
          return true;
        }
      }
    }

    return false;
  }

  Future<SourceInfo?> parseUrl(String url) async {
    var src = cleanBaseDomains(url);

    if (!src.startsWith('/')) {
      return null;
    }

    var proxy = src.split('/');
    proxy.removeWhere((element) => element.isEmpty);

    if (proxy.length < 2) {
      return null;
    }

    switch (proxy[0]) {
      case 'read':
        if (proxy.length >= 4) {
          return SourceInfo(
            type: SourceType.proxy,
            source: proxy[1],
            location: proxy[2],
            chapter: proxy[3],
          );
        }

        return SourceInfo(
          type: SourceType.proxy,
          source: proxy[1],
          location: proxy[2],
        );
      default:
        logger.d('ProxyHandler: retrieving url $url');
        final response = await client.send((http.Request('GET', Uri.parse(url))..followRedirects = false));

        if (response.statusCode != 302 || !response.headers.containsKey('location')) {
          return null;
        }

        final location = response.headers['location']!;

        if (!location.startsWith('/read/')) {
          return null;
        }

        logger.d('ProxyHandler: location $location');

        return parseUrl(location);
    }
  }

  Future<ProxyData> handleSource(SourceInfo info) async {
    ProxyData p = ProxyData();

    switch (info.type) {
      case SourceType.source:
        final srcMgr = await ref.watch(webSourceManagerProvider.future);
        WebManga? manga;

        if (srcMgr != null) {
          if (info.parser != null) {
            manga = await srcMgr.parseManga(info.parser!, Uri.parse(info.location), client);
          } else {
            for (final MapEntry(key: key, value: src) in srcMgr.sources.entries) {
              if (info.source == src.name) {
                manga = await srcMgr.parseManga(key, Uri.parse(info.location), client);
                break;
              }
            }
          }
        }

        p.manga = manga;
        break;
      case SourceType.proxy:
      default:
        switch (info.source) {
          case 'imgur':
            final code = '/read/api/imgur/chapter/${info.location}';
            p.code = code;
            break;
          default:
            // Generic proxy
            final manga = await _getMangaFromProxy(info);
            p.manga = manga;
            break;
        }
        break;
    }

    return p;
  }

  Future<WebManga> _getMangaFromProxy(SourceInfo info) async {
    final key = info.getKey();
    final url = "https://cubari.moe/read/api/${info.source}/series/${info.location}/";

    if (await _cache.exists(key)) {
      logger.d('CacheManager: retrieving entry $key');
      return _cache.get(key, WebManga.fromJson).get<WebManga>();
    }

    final response = await client.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      final manga = WebManga.fromJson(body);

      const expiry = Duration(days: 1);

      logger.d('CacheManager: caching entry $key for ${expiry.toString()}');
      _cache.put(key, json.encode(manga.toJson()), manga, true, expiry: expiry);

      return manga;
    }

    throw Exception(
        "Failed to download manga data.\nServer returned response code ${response.statusCode}: ${response.reasonPhrase}");
  }

  Future<List<String>> getChapterFromProxy(String code) async {
    final url = "https://cubari.moe$code";

    final response = await client.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = json.decode(response.body);

      if (body is List) {
        if (code.contains('imgur')) {
          final imgurlist = body.map((e) => ImgurPage.fromJson(e)).toList();
          final pageList = imgurlist.map((e) => e.src).toList();

          return pageList;
        }

        final pageList = body.map((e) => e as String).toList();
        return pageList;
      }
    }

    throw Exception(
        "Failed to download chapter data.\nServer returned response code ${response.statusCode}: ${response.reasonPhrase}");
  }
}

@Riverpod(keepAlive: true)
class WebSourceFavorites extends _$WebSourceFavorites {
  Future<List<HistoryLink>> _fetch() async {
    final box = Hive.box(gagakuBox);
    final str = box.get('web_favorites');

    if (str == null || (str as String).isEmpty) {
      return <HistoryLink>[];
    }

    final content = json.decode(str) as List<dynamic>;
    final links = content.map((e) => HistoryLink.fromJson(e));

    return links.toList();
  }

  @override
  FutureOr<List<HistoryLink>> build() async {
    return _fetch();
  }

  Future<void> clear() async {
    await future;

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final empty = <HistoryLink>[];

      final box = Hive.box(gagakuBox);
      await box.put('web_favorites', json.encode(empty));

      return empty;
    });
  }

  Future<void> add(HistoryLink link) async {
    final oldstate = await future;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      while (oldstate.contains(link)) {
        oldstate.remove(link);
      }

      final udp = [link, ...oldstate];

      final links = udp.map((e) => e.toJson()).toList();

      final box = Hive.box(gagakuBox);
      await box.put('web_favorites', json.encode(links));

      return udp;
    });
  }

  Future<void> replace(HistoryLink link) async {
    final oldstate = await future;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final idx = oldstate.indexOf(link);

      if (idx != -1) {
        oldstate[idx] = link;
      }

      final udp = [...oldstate];

      final links = udp.map((e) => e.toJson()).toList();

      final box = Hive.box(gagakuBox);
      await box.put('web_favorites', json.encode(links));

      return udp;
    });
  }

  Future<void> remove(HistoryLink link) async {
    final oldstate = await future;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final udp = [...oldstate];

      while (udp.contains(link)) {
        udp.remove(link);
      }

      final links = udp.map((e) => e.toJson()).toList();

      final box = Hive.box(gagakuBox);
      await box.put('web_favorites', json.encode(links));

      return udp;
    });
  }

  Future<void> updateList(int oldIndex, int newIndex) async {
    final oldstate = await future;
    state = await AsyncValue.guard(() async {
      if (oldIndex < newIndex) {
        // removing the item at oldIndex will shorten the list by 1.
        newIndex -= 1;
      }

      final element = oldstate.removeAt(oldIndex);
      oldstate.insert(newIndex, element);

      final udp = [...oldstate];
      final map = udp.map((e) => e.toJson()).toList();

      final box = Hive.box(gagakuBox);
      await box.put('web_favorites', json.encode(map));

      return udp;
    });
  }
}

@Riverpod(keepAlive: true)
class WebSourceHistory extends _$WebSourceHistory {
  static const _numItems = 250;

  Future<Queue<HistoryLink>> _fetch() async {
    final box = Hive.box(gagakuBox);
    final str = box.get('web_history');

    if (str == null || (str as String).isEmpty) {
      return Queue<HistoryLink>();
    }

    final content = json.decode(str) as List<dynamic>;
    final links = content.map((e) => HistoryLink.fromJson(e));

    return Queue.of(links);
  }

  @override
  FutureOr<Queue<HistoryLink>> build() async {
    return _fetch();
  }

  Future<void> clear() async {
    await future;

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final empty = Queue<HistoryLink>();
      final links = empty.toList();

      final box = Hive.box(gagakuBox);
      await box.put('web_history', json.encode(links));

      return empty;
    });
  }

  Future<void> add(HistoryLink link) async {
    final oldstate = await future;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final cpy = Queue.of(oldstate);

      while (cpy.contains(link)) {
        cpy.remove(link);
      }

      cpy.addFirst(link);

      while (cpy.length > _numItems) {
        cpy.removeLast();
      }

      final links = cpy.map((e) => e.toJson()).toList();

      final box = Hive.box(gagakuBox);
      await box.put('web_history', json.encode(links));

      return cpy;
    });
  }

  Future<void> remove(HistoryLink link) async {
    final oldstate = await future;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final cpy = Queue.of(oldstate);

      while (cpy.contains(link)) {
        cpy.remove(link);
      }

      while (cpy.length > _numItems) {
        cpy.removeLast();
      }

      final links = cpy.map((e) => e.toJson()).toList();

      final box = Hive.box(gagakuBox);
      await box.put('web_history', json.encode(links));

      return cpy;
    });
  }
}

@Riverpod(keepAlive: true)
class WebReadMarkers extends _$WebReadMarkers {
  Future<Map<String, Set<String>>> _fetch() async {
    final box = Hive.box(gagakuBox);
    final str = box.get('web_read_history');

    if (str == null || (str as String).isEmpty) {
      return <String, Set<String>>{};
    }

    Map<String, dynamic> content = json.decode(str);
    final markers = content.map((m, s) => MapEntry(m, Set<String>.from(s)));

    return markers;
  }

  @override
  FutureOr<Map<String, Set<String>>> build() async {
    return _fetch();
  }

  Future<void> clear() async {
    await future;

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final empty = <String, Set<String>>{};

      final box = Hive.box(gagakuBox);
      await box.put('web_read_history', json.encode({}));

      return empty;
    });
  }

  Future<void> set(String manga, String chapter, bool setRead) async {
    final oldstate = await future;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final keyExists = oldstate.containsKey(manga);

      // Refresh
      if (keyExists) {
        switch (setRead) {
          case true:
            oldstate[manga]?.add(chapter);
            break;
          case false:
            oldstate[manga]?.remove(chapter);
            break;
        }

        if (oldstate[manga]!.isEmpty) {
          oldstate.remove(manga);
        }
      } else {
        if (setRead) {
          oldstate[manga] = {chapter};
        }
      }

      final converted = oldstate.map((key, value) => MapEntry(key, value.toList()));

      final box = Hive.box(gagakuBox);
      await box.put('web_read_history', json.encode(converted));

      return {...oldstate};
    });
  }

  Future<void> setBulk(
    String manga, {
    Iterable<String>? read,
    Iterable<String>? unread,
  }) async {
    final oldstate = await future;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final keyExists = oldstate.containsKey(manga);

      // Refresh
      if (keyExists) {
        if (read != null) {
          oldstate[manga]?.addAll(read);
        }

        if (unread != null) {
          oldstate[manga]?.removeAll(unread);
        }

        if (oldstate[manga]!.isEmpty) {
          oldstate.remove(manga);
        }
      } else {
        if (read != null) {
          oldstate[manga] = {...read};
        }

        if (unread != null) {
          oldstate[manga] = {};
        }
      }

      final converted = oldstate.map((key, value) => MapEntry(key, value.toList()));

      final box = Hive.box(gagakuBox);
      await box.put('web_read_history', json.encode(converted));

      return {...oldstate};
    });
  }

  Future<void> deleteKey(String manga) async {
    final oldstate = await future;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final keyExists = oldstate.containsKey(manga);

      // Refresh
      if (keyExists) {
        oldstate.remove(manga);
      }

      final converted = oldstate.map((key, value) => MapEntry(key, value.toList()));

      final box = Hive.box(gagakuBox);
      await box.put('web_read_history', json.encode(converted));

      return {...oldstate};
    });
  }
}

@Riverpod(keepAlive: true)
class WebSourceManager extends _$WebSourceManager {
  Future<WebSource?> fetchData() async {
    final path = ref.watch(webConfigProvider.select((c) => c.sourceDirectory));
    final dir = Directory(path);

    if (path.isNotEmpty && dir.existsSync()) {
      final plugin = WebSourcePlugin();
      final compiler = Compiler();
      compiler.addPlugin(plugin);

      final entities = await dir.list().toList();
      final sourcefiles = <String, String>{};

      for (final e in entities) {
        if (e is File && e.path.endsWith('.dart')) {
          final filename = e.uri.pathSegments.last;
          String dat = await e.readAsString();

          sourcefiles.putIfAbsent(filename, () => dat);
          compiler.entrypoints.add('${GagakuWebSources.getPackagePath}/$filename');
        }
      }

      final program = compiler.compile({GagakuWebSources.packageName: sourcefiles});
      final runtime = Runtime.ofProgram(program);
      runtime.addPlugin(plugin);

      final source = WebSource(runtime: runtime);

      for (final key in sourcefiles.keys) {
        final result =
            (runtime.executeLib('${GagakuWebSources.getPackagePath}/$key', 'getSourceInfo') as $String).$value;

        final Map<String, dynamic> dat = json.decode(result);
        final info = WebSourceInfo.fromJson(dat);

        source.sources.putIfAbsent(key, () => info);
        runtime.grant(NetworkPermission.url(info.baseUrl));
      }

      return source;
    }

    return null;
  }

  @override
  FutureOr<WebSource?> build() async {
    return fetchData();
  }

  Future<void> addSource(String key, RepoInfo value) async {
    final path = ref.watch(webConfigProvider.select((c) => c.sourceDirectory));
    final dir = Directory(path);

    if (path.isNotEmpty && dir.existsSync()) {
      final api = ref.watch(proxyProvider);
      final url = Uri.parse(value.url);

      final response = await api.client.get(url);
      await File('${dir.path}${Platform.pathSeparator}$key').writeAsBytes(response.bodyBytes, flush: true);
    }

    ref.invalidateSelf();
  }

  Future<void> removeSource(String key) async {
    final path = ref.watch(webConfigProvider.select((c) => c.sourceDirectory));
    final dir = Directory(path);

    if (path.isNotEmpty && dir.existsSync()) {
      final file = File('${dir.path}${Platform.pathSeparator}$key');
      if (file.existsSync()) {
        await file.delete();
      }
    }

    ref.invalidateSelf();
  }

  Future<void> updateSource(String key, RepoInfo value) async {
    final path = ref.watch(webConfigProvider.select((c) => c.sourceDirectory));
    final dir = Directory(path);

    if (path.isNotEmpty && dir.existsSync()) {
      final api = ref.watch(proxyProvider);
      final url = Uri.parse(value.url);

      final response = await api.client.get(url);
      await File('${dir.path}${Platform.pathSeparator}$key').writeAsBytes(response.bodyBytes, flush: true);
    }

    ref.invalidateSelf();
  }
}
