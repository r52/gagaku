import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gagaku/util/freezed.dart';

part 'types.freezed.dart';
part 'types.g.dart';

class WebReaderData {
  const WebReaderData({
    required this.source,
    this.title,
    this.link,
    required this.handle,
    this.readKey,
    this.onLinkPressed,
  });

  final dynamic source;
  final String? title;
  final String? link;
  final SourceHandler handle;
  final String? readKey;
  final VoidCallback? onLinkPressed;
}

enum SourceType {
  proxy,
  source,
}

@freezed
class SourceHandler with _$SourceHandler {
  const SourceHandler._();

  const factory SourceHandler({
    required SourceType type,
    required String source,
    required String location,
    String? chapter,
    WebSourceInfo? parser,
  }) = _SourceHandler;

  String getURL() => type == SourceType.proxy ? 'https://cubari.moe/read/$source/$location/' : '$source/$location';
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

  factory HistoryLink.fromPartialSourceManga(String sourceId, PartialSourceManga manga) =>
      HistoryLink(title: manga.title, url: '$sourceId/${manga.mangaId}', cover: manga.image);

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

@freezed
class WebSourceInfo with _$WebSourceInfo {
  const factory WebSourceInfo({
    required String id,
    required String name,
    required String repo,
    String? icon,
  }) = _WebSourceInfo;

  factory WebSourceInfo.fromJson(Map<String, dynamic> json) => _$WebSourceInfoFromJson(json);
}

///////////////////////////////////////////////////////////////////// PB types

enum SourceIntents {
  mangaChapters(1 << 0),
  mangaTracking(1 << 1),
  homepageSections(1 << 2),
  collectionManagement(1 << 3),
  cloudflareBypassRequired(1 << 4),
  settingsUI(1 << 5);

  final int flag;
  const SourceIntents(this.flag);
}

// ignore: constant_identifier_names
enum ContentRating { EVERYONE, MATURE, ADULT }

@freezed
class Badge with _$Badge {
  const factory Badge({
    required String text,
    required BadgeColor type,
  }) = _Badge;

  factory Badge.fromJson(Map<String, dynamic> json) => _$BadgeFromJson(json);
}

enum BadgeColor {
  //default(Colors.blue),
  success(Colors.green),
  info(Colors.grey),
  warning(Color.fromARGB(255, 230, 162, 60)),
  danger(Color.fromARGB(255, 245, 108, 108));

  final Color color;
  const BadgeColor(this.color);
}

@freezed
class SourceVersion with _$SourceVersion {
  const factory SourceVersion({
    required String id,
    required String name,
    required String author,
    required String desc,
    String? website,
    required ContentRating contentRating,
    required String version,
    required String icon,
    List<Badge>? tags,
    required String websiteBaseURL,
    int? intents,
  }) = _SourceVersion;

  factory SourceVersion.fromJson(Map<String, dynamic> json) => _$SourceVersionFromJson(json);
}

@freezed
class SourceInfo with _$SourceInfo {
  const SourceInfo._();

  const factory SourceInfo({
    required String name,
    required String author,
    required String description,
    required ContentRating contentRating,
    required String version,
    required String icon,
    required String websiteBaseURL,
    String? authorWebsite,
    String? language,
    List<Badge>? sourceTags,
    int? intents,
  }) = _SourceInfo;

  bool hasIntent(SourceIntents intent) {
    if (intents != null && (intents! & intent.flag) == intent.flag) {
      return true;
    }

    return false;
  }

  factory SourceInfo.fromJson(Map<String, dynamic> json) => _$SourceInfoFromJson(json);
}

@freezed
class BuiltWith with _$BuiltWith {
  const factory BuiltWith({
    required String toolchain,
    required String types,
  }) = _BuiltWith;

  factory BuiltWith.fromJson(Map<String, dynamic> json) => _$BuiltWithFromJson(json);
}

@freezed
class Versioning with _$Versioning {
  const factory Versioning({
    required String buildTime,
    required List<SourceVersion> sources,
    required BuiltWith builtWith,
  }) = _Versioning;

  factory Versioning.fromJson(Map<String, dynamic> json) => _$VersioningFromJson(json);
}

@freezed
class RepoInfo with _$RepoInfo {
  const factory RepoInfo({
    required String name,
    required String url,
  }) = _RepoInfo;

  factory RepoInfo.fromJson(Map<String, dynamic> json) => _$RepoInfoFromJson(json);
}

@freezed
class PartialSourceManga with _$PartialSourceManga {
  const factory PartialSourceManga({
    required String mangaId,
    required String image,
    required String title,
    String? subtitle,
  }) = _PartialSourceManga;

  factory PartialSourceManga.fromJson(Map<String, dynamic> json) => _$PartialSourceMangaFromJson(json);
}

@freezed
class PagedResults with _$PagedResults {
  const factory PagedResults({
    List<PartialSourceManga>? results,
    dynamic metadata,
  }) = _PagedResults;

  factory PagedResults.fromJson(Map<String, dynamic> json) => _$PagedResultsFromJson(json);
}

@freezed
class MangaInfo with _$MangaInfo {
  const factory MangaInfo({
    required String image,
    String? artist,
    String? author,
    required String desc,
    required String status,
    bool? hentai,
    required List<String> titles,
    String? banner,
    num? rating,
    List<TagSection>? tags,
    List<String>? covers,
    // required num avgRating,
    // required num follows,
    // required String langFlag,
    // required String langName,
    // required num users,
    // required num views,
  }) = _MangaInfo;

  factory MangaInfo.fromJson(Map<String, dynamic> json) => _$MangaInfoFromJson(json);
}

@freezed
class Tag with _$Tag {
  const factory Tag({
    required String id,
    required String label,
  }) = _Tag;

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);
}

@freezed
class TagSection with _$TagSection {
  const factory TagSection({
    required String id,
    required String label,
    required List<Tag> tags,
  }) = _TagSection;

  factory TagSection.fromJson(Map<String, dynamic> json) => _$TagSectionFromJson(json);
}

@freezed
class SourceManga with _$SourceManga {
  const factory SourceManga({
    required String id,
    required MangaInfo mangaInfo,
  }) = _SourceManga;

  factory SourceManga.fromJson(Map<String, dynamic> json) => _$SourceMangaFromJson(json);
}

@freezed
class Chapter with _$Chapter {
  const factory Chapter({
    required String id,
    required num chapNum,
    String? langCode,
    String? name,
    num? volume,
    String? group,
    @TimestampSerializer() DateTime? time,
    num? sortingIndex,
  }) = _Chapter;

  factory Chapter.fromJson(Map<String, dynamic> json) => _$ChapterFromJson(json);
}

@freezed
class ChapterDetails with _$ChapterDetails {
  const factory ChapterDetails({
    required String id,
    required String mangaId,
    required List<String> pages,
  }) = _ChapterDetails;

  factory ChapterDetails.fromJson(Map<String, dynamic> json) => _$ChapterDetailsFromJson(json);
}

@freezed
class SearchRequest with _$SearchRequest {
  const factory SearchRequest({
    String? title,
    List<Tag>? includedTags,
    List<Tag>? excludedTags,
  }) = _SearchRequest;

  factory SearchRequest.fromJson(Map<String, dynamic> json) => _$SearchRequestFromJson(json);
}

@freezed
class HomeSection with _$HomeSection {
  const factory HomeSection({
    required String id,
    required String title,
    required List<PartialSourceManga> items,
    required bool containsMoreItems,
  }) = _HomeSection;

  factory HomeSection.fromJson(Map<String, dynamic> json) => _$HomeSectionFromJson(json);
}
