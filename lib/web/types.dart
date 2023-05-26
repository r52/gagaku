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
