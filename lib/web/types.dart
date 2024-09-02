import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gagaku/util.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:http/http.dart';
import 'package:intl/intl.dart';

part 'types.freezed.dart';
part 'types.g.dart';

class WebReaderData {
  const WebReaderData({
    required this.source,
    this.title,
    this.manga,
    this.link,
    this.info,
    this.readKey,
    this.onLinkPressed,
  });

  final dynamic source;
  final String? title;
  final WebManga? manga;
  final Widget? link;
  final ProxyInfo? info;
  final String? readKey;
  final VoidCallback? onLinkPressed;
}

@freezed
class ProxyInfo with _$ProxyInfo {
  const ProxyInfo._();

  const factory ProxyInfo({
    required String proxy,
    required String code,
    String? chapter,
  }) = _ProxyInfo;

  String getURL() => 'https://cubari.moe/read/$proxy/$code/';
  String getKey() => '$proxy/$code';
}

class ProxyData {
  ProxyData({this.manga, this.code});

  WebManga? manga;
  String? code;
}

class EpochTimestampSerializer implements JsonConverter<DateTime?, dynamic> {
  const EpochTimestampSerializer();

  @override
  DateTime? fromJson(dynamic timestamp) {
    if (timestamp == null) {
      return null;
    }

    final epoch = switch (timestamp) {
      int t => t,
      double d => d.round(),
      _ => int.parse(timestamp),
    };

    return DateTime.fromMillisecondsSinceEpoch(epoch * 1000);
  }

  @override
  dynamic toJson(DateTime? date) {
    if (date == null) {
      return null;
    }

    return (date.millisecondsSinceEpoch / 1000).round().toString();
  }
}

class MappedEpochTimestampSerializer implements JsonConverter<DateTime?, dynamic> {
  const MappedEpochTimestampSerializer();

  @override
  DateTime? fromJson(dynamic timestamp) {
    if (timestamp == null) {
      return null;
    }

    if (timestamp is! Map<String, dynamic>) {
      return null;
    }

    final date = timestamp.entries.first.value;

    final epoch = switch (date) {
      int t => t,
      double d => d.round(),
      _ => int.parse(date),
    };

    return DateTime.fromMillisecondsSinceEpoch(epoch * 1000);
  }

  @override
  dynamic toJson(DateTime? date) {
    if (date == null) {
      return null;
    }

    return {'0': (date.millisecondsSinceEpoch / 1000).round().toString()};
  }
}

@freezed
class HistoryLink with _$HistoryLink {
  const HistoryLink._();

  const factory HistoryLink({
    required String title,
    required String url,
    String? cover,
  }) = _HistoryLink;

  factory HistoryLink.fromJson(Map<String, dynamic> json) => _$HistoryLinkFromJson(json);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HistoryLinkImpl &&
            (identical(other.url, url) || other.url == url));
  }

  @override
  int get hashCode => Object.hash(runtimeType, url);
}

@freezed
class WebManga with _$WebManga {
  const WebManga._();

  const factory WebManga({
    required String title,
    required String description,
    required String artist,
    required String author,
    required String cover,
    Map<String, String>? groups,
    required Map<String, WebChapter> chapters,
  }) = _WebManga;

  factory WebManga.fromJson(Map<String, dynamic> json) => _$WebMangaFromJson(json);

  WebChapter? getChapter(String chapter) {
    if (chapters.containsKey(chapter)) {
      return chapters[chapter];
    }
    return null;
  }
}

@freezed
class WebChapter with _$WebChapter {
  const WebChapter._();

  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory WebChapter({
    String? title,
    String? volume,
    @EpochTimestampSerializer() DateTime? lastUpdated,
    @MappedEpochTimestampSerializer() DateTime? releaseDate,
    required Map<String, dynamic> groups,
  }) = _WebChapter;

  factory WebChapter.fromJson(Map<String, dynamic> json) => _$WebChapterFromJson(json);

  String getTitle(String index) {
    String output = index;

    if (title != null && title!.isNotEmpty) {
      output += ': $title';
    }

    return output;
  }
}

@freezed
class ImgurPage with _$ImgurPage {
  const factory ImgurPage({
    required String description,
    required String src,
  }) = _ImgurPage;

  factory ImgurPage.fromJson(Map<String, dynamic> json) => _$ImgurPageFromJson(json);
}

enum WebSourceParseType {
  html,
  regex,
}

@freezed
class TagParser with _$TagParser {
  const TagParser._();

  const factory TagParser({
    required String pattern,
    String? content,
    String? format,
  }) = _TagParser;

  factory TagParser.fromJson(Map<String, dynamic> json) => _$TagParserFromJson(json);

  String parseElement(dom.Element element, [String? defaultAttribute]) {
    if (content == null && defaultAttribute == null) {
      return '';
    }

    if (content == 'text') {
      return element.text.trim();
    }

    final data = content != null ? element.attributes[content] : element.attributes[defaultAttribute];

    if (data == null) {
      return element.text.trim();
    }

    return data;
  }

  DateTime parseTime(dom.Element element) {
    if (format == null || content == null) {
      throw Exception('No date format defined');
    }

    final str = parseElement(element);

    final tf = DateFormat(format);
    final dt = tf.parse(str);
    return dt;
  }
}

@freezed
class WebSource with _$WebSource {
  const WebSource._();

  const factory WebSource({
    required String name,
    required String version,
    required WebSourceParseType type,
    required String baseUrl,
    required WebSourceSearchParser search,
    WebSourceMangaParser? manga,
    required String slug,
  }) = _WebSource;

  factory WebSource.fromJson(Map<String, dynamic> json) => _$WebSourceFromJson(json);

  Future<List<HistoryLink>> searchManga(http.Client client, String searchTerm) async {
    if (searchTerm.isEmpty) {
      return [];
    }

    final list = <HistoryLink>[];

    switch (type) {
      case WebSourceParseType.regex:
        final url = '$baseUrl${search.searchPath}';
        final response = await client.get(Uri.parse(url));

        final exp = RegExp(search.items.pattern);

        final match = exp.firstMatch(response.body);
        if (match != null) {
          final data = match[1]!;
          List<dynamic> dataList = json.decode(data);
          final found = dataList.where((e) =>
              (((e[search.title.pattern] as String?)?.toLowerCase().contains(searchTerm) ?? false) ||
                  ((e[search.altTitles?.pattern] as List?)
                          ?.where((i) => (i as String).toLowerCase().contains(searchTerm))
                          .isNotEmpty ??
                      false)));

          for (final s in found) {
            final convert = Map<String, dynamic>.of(s);
            convert.removeWhere((key, val) {
              return val is! String;
            });
            final shorten = convert.cast<String, String>();
            final title = s[search.title.pattern] ?? (s[search.altTitles?.pattern] as List?)?.first;
            final slg = '$slug${s[search.url.pattern]}/';
            final cover = search.cover.pattern.formatWithMap(shorten);

            list.add(HistoryLink(
              title: title,
              url: slg,
              cover: cover,
            ));
          }
        }
        break;
      case WebSourceParseType.html:
      default:
        final url = '$baseUrl${search.searchPath}'.formatWithMap({'page': '1', 'search': searchTerm});

        final response = await client.send(http.Request('GET', Uri.parse(url)));
        final bytes = await http.Response.fromStream(response);

        if (response case BaseResponseWithUrl(:final url)) {
          if (manga != null && url.path.contains(manga!.mangaPath)) {
            final webmanga = await parseManga(body: bytes.body);
            final iurl = '$slug$url/';

            return [HistoryLink(title: webmanga.title, url: iurl, cover: webmanga.cover)];
          }
        }

        final html = dom.Document.html(bytes.body);

        final items = html.querySelectorAll(search.items.pattern);

        for (final i in items) {
          String iurl, title;
          String? cover;

          final urle = i.querySelector(search.url.pattern);
          if (urle == null) {
            throw Exception('Failed to parse url from ${i.toString()}');
          }

          iurl = search.url.parseElement(urle, 'href');
          iurl = '$slug$iurl/';

          final imge = i.querySelector(search.cover.pattern);
          if (imge != null) {
            cover = search.cover.parseElement(imge, 'src');
          }

          final titlee = i.querySelector(search.title.pattern);
          if (titlee == null) {
            throw Exception('Failed to parse title from ${i.toString()}');
          }

          title = search.title.parseElement(titlee);

          list.add(HistoryLink(title: title, url: iurl, cover: cover));
        }

        break;
    }

    return list;
  }

  Future<WebManga> parseManga({String? body, Uri? url, http.Client? client}) async {
    if (manga == null) {
      throw Exception('No manga parser defined for source $name');
    }

    String bytes;
    if (url != null && client != null) {
      final response = await client.get(url);
      bytes = response.body;
    } else if (body != null) {
      bytes = body;
    } else {
      throw Exception('parseManga() requires one of url or body');
    }

    final html = dom.Document.html(bytes);

    String title, description, cover, author;

    final titlee = html.querySelector(manga!.title.pattern);
    if (titlee == null) {
      throw Exception('Failed to parse manga title');
    }

    title = manga!.title.parseElement(titlee);

    final desce = html.querySelector(manga!.description.pattern);
    if (desce == null) {
      throw Exception('Failed to parse manga description');
    }

    description = manga!.description.parseElement(desce);

    final imge = html.querySelector(manga!.cover.pattern);
    if (imge == null) {
      throw Exception('Failed to parse manga cover');
    }

    cover = manga!.cover.parseElement(imge);

    final authe = html.querySelector(manga!.author.pattern);
    if (authe == null) {
      throw Exception('Failed to parse manga author');
    }

    author = manga!.author.parseElement(authe);

    final chapters = await parseChapters(html);

    return WebManga(
        title: title, description: description, artist: author, author: author, cover: cover, chapters: chapters);
  }

  Future<Map<String, WebChapter>> parseChapters(dom.Document html) async {
    if (manga == null) {
      throw Exception('No manga parser defined for source $name');
    }

    final list = <String, WebChapter>{};

    final items = html.querySelectorAll(manga!.chapters.items.pattern);

    for (final i in items) {
      String iurl, title;

      final urle = i.querySelector(manga!.chapters.url.pattern);
      if (urle == null) {
        throw Exception('Failed to parse url from ${i.toString()}');
      }

      iurl = manga!.chapters.url.parseElement(urle, 'href');
      iurl = '$slug$iurl/';

      final titlee = i.querySelector(manga!.chapters.title.pattern);
      if (titlee == null) {
        throw Exception('Failed to parse title from ${i.toString()}');
      }

      title = manga!.chapters.title.parseElement(titlee);

      final time = i.querySelector(manga!.chapters.lastUpdated.pattern);
      if (time == null) {
        throw Exception('Failed to parse time from ${i.toString()}');
      }

      final lastUpdated = manga!.chapters.lastUpdated.parseTime(time);
      list.addEntries([
        MapEntry(title, WebChapter(title: title, lastUpdated: lastUpdated, groups: {"1": name}))
      ]);
    }

    return list;
  }
}

@freezed
class WebSourceSearchParser with _$WebSourceSearchParser {
  const factory WebSourceSearchParser({
    required String searchPath,
    required TagParser items,
    required TagParser url,
    required TagParser cover,
    required TagParser title,
    TagParser? altTitles,
    TagParser? urlTrim,
  }) = _WebSourceSearchParser;

  factory WebSourceSearchParser.fromJson(Map<String, dynamic> json) => _$WebSourceSearchParserFromJson(json);
}

@freezed
class WebSourceMangaParser with _$WebSourceMangaParser {
  const factory WebSourceMangaParser({
    required String mangaPath,
    required TagParser title,
    required TagParser description,
    required TagParser artist,
    required TagParser author,
    required TagParser cover,
    required WebSourceChapterParser chapters,
  }) = _WebSourceMangaParser;

  factory WebSourceMangaParser.fromJson(Map<String, dynamic> json) => _$WebSourceMangaParserFromJson(json);
}

@freezed
class WebSourceChapterParser with _$WebSourceChapterParser {
  const factory WebSourceChapterParser({
    required TagParser items,
    required TagParser url,
    required TagParser title,
    required TagParser lastUpdated,
  }) = _WebSourceChapterParser;

  factory WebSourceChapterParser.fromJson(Map<String, dynamic> json) => _$WebSourceChapterParserFromJson(json);
}
