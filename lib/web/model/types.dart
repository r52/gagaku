import 'package:dart_eval/dart_eval_bridge.dart';
import 'package:dart_eval/stdlib/core.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gagaku/web/eval/http.dart';
import 'package:gagaku/web/eval/util.dart';
import 'package:http/http.dart' as http;

part 'types.freezed.dart';
part 'types.g.dart';

class WebReaderData {
  const WebReaderData({
    required this.source,
    this.title,
    this.link,
    required this.info,
    this.readKey,
    this.onLinkPressed,
  });

  final dynamic source;
  final String? title;
  final Widget? link;
  final SourceInfo info;
  final String? readKey;
  final VoidCallback? onLinkPressed;
}

enum SourceType {
  proxy,
  source,
}

@freezed
class SourceInfo with _$SourceInfo {
  const SourceInfo._();

  const factory SourceInfo({
    required SourceType type,
    required String source,
    required String location,
    String? chapter,
    String? parser,
  }) = _SourceInfo;

  String getURL() => type == SourceType.proxy ? 'https://cubari.moe/read/$source/$location/' : location;
  String getKey() => '$source/$location';
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
    if (index == title) {
      return index;
    }

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

class WebSource {
  WebSource({
    required this.runtime,
  });

  final Runtime runtime;
  final Map<String, WebSourceInfo> sources = {};

  Future<List<HistoryLink>> searchManga(String key, String searchTerm, http.Client client) async {
    if (!sources.containsKey(key)) {
      throw Exception('Source $key not found');
    }

    if (searchTerm.isEmpty) {
      return [];
    }

    final info = sources[key]!;

    final fut = (runtime.executeLib(
                '${GagakuWebSources.getPackagePath}/$key', info.search, [$String(searchTerm), $Client.wrap(client)])
            as $Future)
        .$reified;
    final vlist = (await fut) as List<$Value>;
    final list = vlist.map((e) => e.$value as HistoryLink).toList();

    return list;
  }

  Future<WebManga?> parseManga(String key, Uri url, http.Client client) async {
    if (!sources.containsKey(key)) {
      throw Exception('Source $key not found');
    }

    final info = sources[key]!;

    final fut = (runtime.executeLib(
            '${GagakuWebSources.getPackagePath}/$key', info.manga, [$Uri.wrap(url), $Client.wrap(client)]) as $Future)
        .$reified;
    final manga = (await fut) as WebManga?;

    return manga;
  }

  Future<List<String>> parsePages(String key, Uri url, http.Client client) async {
    if (!sources.containsKey(key)) {
      throw Exception('Source $key not found');
    }

    final info = sources[key]!;

    final fut = (runtime.executeLib(
            '${GagakuWebSources.getPackagePath}/$key', info.pages, [$Uri.wrap(url), $Client.wrap(client)]) as $Future)
        .$reified;
    final data = await fut;

    if (data is! List) {
      throw Exception('Data returned by ${GagakuWebSources.getPackagePath}/$key: ${info.pages} is not a List');
    }

    final list = data.map((e) => e is $Value ? e.$value as String : e.toString()).toList();

    return list;
  }
}

@freezed
class WebSourceInfo with _$WebSourceInfo {
  const factory WebSourceInfo({
    required String name,
    required String version,
    required String baseUrl,
    required String mangaPath,
    required String search,
    required String manga,
    required String pages,
  }) = _WebSourceInfo;

  factory WebSourceInfo.fromJson(Map<String, dynamic> json) => _$WebSourceInfoFromJson(json);
}

@freezed
class RepoInfo with _$RepoInfo {
  const factory RepoInfo({
    required String name,
    required String version,
    required String url,
  }) = _RepoInfo;

  factory RepoInfo.fromJson(Map<String, dynamic> json) => _$RepoInfoFromJson(json);
}
