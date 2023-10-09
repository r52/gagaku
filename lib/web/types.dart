import 'package:freezed_annotation/freezed_annotation.dart';

part 'types.freezed.dart';
part 'types.g.dart';

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

    final epoch = timestamp is int ? timestamp : int.parse(timestamp);

    return DateTime.fromMillisecondsSinceEpoch(epoch * 1000);
  }

  @override
  dynamic toJson(DateTime? date) {
    if (date == null) {
      return null;
    }

    return (date.millisecondsSinceEpoch / 1000).toString();
  }
}

class MappedEpochTimestampSerializer
    implements JsonConverter<DateTime?, dynamic> {
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
    final epoch = date is int ? date : int.parse(date);

    return DateTime.fromMillisecondsSinceEpoch(epoch * 1000);
  }

  @override
  dynamic toJson(DateTime? date) {
    if (date == null) {
      return null;
    }

    return {'0': (date.millisecondsSinceEpoch / 1000).toString()};
  }
}

@freezed
class HistoryLink with _$HistoryLink {
  const HistoryLink._();

  const factory HistoryLink({required String title, required String url}) =
      _HistoryLink;

  factory HistoryLink.fromJson(Map<String, dynamic> json) =>
      _$HistoryLinkFromJson(json);

  @override
  bool operator ==(dynamic other) {
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

  factory WebManga.fromJson(Map<String, dynamic> json) =>
      _$WebMangaFromJson(json);

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
    required String title,
    required String volume,
    @EpochTimestampSerializer() DateTime? lastUpdated,
    @MappedEpochTimestampSerializer() DateTime? releaseDate,
    required Map<String, dynamic> groups,
  }) = _WebChapter;

  factory WebChapter.fromJson(Map<String, dynamic> json) =>
      _$WebChapterFromJson(json);

  String getTitle(String index) {
    String output = index;

    if (title.isNotEmpty) {
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

  factory ImgurPage.fromJson(Map<String, dynamic> json) =>
      _$ImgurPageFromJson(json);
}
