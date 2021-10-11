import 'dart:convert';

import 'package:gagaku/src/web/types.dart';
import 'package:http/http.dart' as http;

class WebGalleryAPI {
  static Future<WebManga> getGist(String gist) async {
    final response = await http.get(Uri.parse('https://git.io/$gist'));

    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);

      if (body.containsKey('title')) {
        var manga = WebManga.fromJson(body);
        return manga;
      }
    }

    // Throw if failure
    throw Exception("Failed to download manga data");
  }

  static Future<List<String>> getImgurPages(String src) async {
    final response = await http
        .get(Uri.parse('https://cubari.moe/read/api/imgur/chapter/$src/'));

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);

      if (body is List) {
        var pageList = body.map((e) => e['src'] as String).toList();

        return pageList;
      }
    }

    // Throw if failure
    throw Exception("Failed to download chapter data");
  }
}
