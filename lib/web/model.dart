import 'dart:convert';

import 'package:gagaku/web/types.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'model.g.dart';

@riverpod
Future<WebManga> getMangaFromGist(GetMangaFromGistRef ref, String code) async {
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

    url = '$baseUrl${link.substring(link.indexOf('/'))}';
  } else {
    url = 'https://git.io/$code';
  }

  if (url.isNotEmpty) {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var body = json.decode(response.body);

      var manga = WebManga.fromJson(body);

      ref.keepAlive();

      return manga;
    }
  }

  // Throw if failure
  throw Exception("Failed to download manga data");
}

@riverpod
Future<List<ImgurPage>> getImgurPages(GetImgurPagesRef ref, String code) async {
  final response = await http
      .get(Uri.parse('https://cubari.moe/read/api/imgur/chapter/$code/'));

  if (response.statusCode == 200) {
    var body = json.decode(response.body);

    if (body is List) {
      var pageList = body.map((e) => ImgurPage.fromJson(e)).toList();

      ref.keepAlive();

      return pageList;
    }
  }

  // Throw if failure
  throw Exception("Failed to download chapter data");
}
