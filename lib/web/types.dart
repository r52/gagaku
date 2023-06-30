import 'package:freezed_annotation/freezed_annotation.dart';

part 'types.freezed.dart';
part 'types.g.dart';

class ProxyInfo {
  ProxyInfo({required this.proxy, required this.code, this.chapter});

  String proxy;
  String code;
  String? chapter;
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

    return DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp) * 1000);
  }

  @override
  dynamic toJson(DateTime? date) {
    if (date == null) {
      return null;
    }

    return (date.millisecondsSinceEpoch / 1000).toString();
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
            other is _$_HistoryLink &&
            (identical(other.url, url) || other.url == url));
  }

  @override
  int get hashCode => Object.hash(runtimeType, url);
}

@freezed
class WebManga with _$WebManga {
  const factory WebManga({
    required String title,
    required String description,
    required String artist,
    required String author,
    required String cover,
    required Map<String, WebChapter> chapters,
  }) = _WebManga;

  factory WebManga.fromJson(Map<String, dynamic> json) =>
      _$WebMangaFromJson(json);
}

@freezed
class WebChapter with _$WebChapter {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory WebChapter({
    required String title,
    required String volume,
    @EpochTimestampSerializer() DateTime? lastUpdated,
    required Map<String, String> groups,
  }) = _WebChapter;

  factory WebChapter.fromJson(Map<String, dynamic> json) =>
      _$WebChapterFromJson(json);
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
