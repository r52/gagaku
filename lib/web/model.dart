import 'dart:convert';

import 'package:gagaku/web/types.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

final proxyProvider = Provider(ProxyHandler.new);

class ProxyHandler {
  ProxyHandler(this.ref);

  final Ref ref;
  final http.Client _client = http.Client();

  Future<ProxyInfo?> parseUrl(String url) async {
    var src = url.substring(24);
    var proxy = src.split('/');
    proxy.removeWhere((element) => element.isEmpty);

    if (proxy.length < 2) {
      return null;
    }

    final p = ProxyInfo(proxy: proxy[0], code: proxy[1]);
    if (proxy.length >= 3) {
      p.chapter = proxy[2];
    }

    return p;
  }

  Future<ProxyData> handleProxy(ProxyInfo info) async {
    ProxyData p = ProxyData();

    if (info.proxy == 'gist') {
      final manga = await _getMangaFromGist(info.code);
      p.manga = manga;
    } else if (info.proxy == 'imgur') {
      final code = '/read/api/imgur/chapter/${info.code}';
      p.code = code;
    } else {
      // Generic proxy
      final manga = await _getMangaFromProxy(info);
      p.manga = manga;
    }

    return p;
  }

  Future<WebManga> _getMangaFromProxy(ProxyInfo info) async {
    final url =
        "https://cubari.moe/read/api/${info.proxy}/series/${info.code}/";

    final response = await _client.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      final manga = WebManga.fromJson(body);

      return manga;
    }

    throw Exception("Failed to download manga data");
  }

  Future<WebManga> _getMangaFromGist(String code) async {
    var url = '';

    if (code.length > 5) {
      // Pretty bad way of determining whether its an old git.io link but w/e
      Codec<String, String> b64 = utf8.fuse(base64Url);
      String link = b64.decode('$code==');
      final schema = link.split('/');
      var baseUrl = 'https://raw.githubusercontent.com/';

      if (schema.isEmpty || schema.length < 3) {
        throw Exception("Bad url/gist code $code");
      }

      if (schema[0] == 'raw') {
        baseUrl = 'https://raw.githubusercontent.com/';
      } else if (schema[0] == 'gist') {
        baseUrl = 'https://gist.githubusercontent.com/';
      } else {
        throw Exception("Unknown schema ${schema[0]}");
      }

      url = '$baseUrl${link.substring(link.indexOf('/') + 1)}';
    } else {
      url = 'https://git.io/$code';
    }

    if (url.isNotEmpty) {
      final response = await _client.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        final manga = WebManga.fromJson(body);

        return manga;
      }
    }

    // Throw if failure
    throw Exception("Failed to download manga data");
  }

  Future<List<String>> getChapter(String code) async {
    final url = "https://cubari.moe$code";

    final response = await _client.get(Uri.parse(url));

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

    throw Exception("Failed to chapter data");
  }
}
