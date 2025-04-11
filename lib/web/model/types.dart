// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gagaku/reader/main.dart' show CtxCallback;
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
  final CtxCallback? onLinkPressed;
}

enum SourceType { proxy, source }

@freezed
abstract class SourceHandler with _$SourceHandler {
  const SourceHandler._();

  const factory SourceHandler({
    required SourceType type,
    required String sourceId,
    required String location,
    String? chapter,
    WebSourceInfo? parser,
  }) = _SourceHandler;

  String getURL() =>
      type == SourceType.proxy
          ? 'https://cubari.moe/read/$sourceId/$location/'
          : '$sourceId/$location';
  String getKey() => '$sourceId/$location';
}

@freezed
abstract class HistoryLink with _$HistoryLink {
  const HistoryLink._();

  const factory HistoryLink({
    required String title,
    required String url,
    String? cover,
  }) = _HistoryLink;

  factory HistoryLink.fromJson(Map<String, dynamic> json) =>
      _$HistoryLinkFromJson(json);

  factory HistoryLink.fromPartialSourceManga(
    String sourceId,
    PartialSourceManga manga,
  ) => HistoryLink(
    title: manga.title,
    url: '$sourceId/${manga.mangaId}',
    cover: manga.image,
  );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is HistoryLink &&
            (identical(other.url, url) || other.url == url));
  }

  @override
  int get hashCode => Object.hash(runtimeType, url);
}

@freezed
abstract class WebManga with _$WebManga {
  const WebManga._();

  const factory WebManga({
    required String title,
    required String description,
    required String artist,
    required String author,
    required String cover,
    Map<String, String>? groups,
    required Map<String, WebChapter> chapters,
    dynamic data,
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
abstract class WebChapter with _$WebChapter {
  const WebChapter._();

  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory WebChapter({
    String? title,
    String? volume,
    @EpochTimestampSerializer() DateTime? lastUpdated,
    @MappedEpochTimestampSerializer() DateTime? releaseDate,
    required Map<String, dynamic> groups,
    dynamic data,
  }) = _WebChapter;

  factory WebChapter.fromJson(Map<String, dynamic> json) =>
      _$WebChapterFromJson(json);

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
abstract class ImgurPage with _$ImgurPage {
  const factory ImgurPage({required String description, required String src}) =
      _ImgurPage;

  factory ImgurPage.fromJson(Map<String, dynamic> json) =>
      _$ImgurPageFromJson(json);
}

@freezed
abstract class WebSourceInfo with _$WebSourceInfo {
  const WebSourceInfo._();

  const factory WebSourceInfo({
    required String id,
    required String name,
    required String repo,
    required String baseUrl,
    @Default(SupportedVersion.v0_8) SupportedVersion version,
    required String icon,
    @Default([SourceIntents.mangaChapters])
    @SourceIntentParser()
    List<SourceIntents> capabilities,
  }) = _WebSourceInfo;

  factory WebSourceInfo.fromJson(Map<String, dynamic> json) =>
      _$WebSourceInfoFromJson(json);

  bool hasCapability(SourceIntents intent) {
    return capabilities.contains(intent);
  }
}

enum SupportedVersion {
  v0_8('0.8');

  final String version;
  const SupportedVersion(this.version);
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

class SourceIntentParser implements JsonConverter<SourceIntents, dynamic> {
  const SourceIntentParser();

  @override
  SourceIntents fromJson(dynamic intent) =>
      SourceIntents.values.firstWhere((e) => e.flag == intent);

  @override
  dynamic toJson(SourceIntents intent) => intent.flag;
}

class SourceIntentOrListParser
    implements JsonConverter<List<SourceIntents>, dynamic> {
  const SourceIntentOrListParser();

  @override
  List<SourceIntents> fromJson(dynamic intents) {
    if (intents is List) {
      return intents
          .map((e) => SourceIntents.values.firstWhere((s) => s.flag == e))
          .toList();
    }
    if (intents is int) {
      return SourceIntents.values.fold([], (list, intent) {
        if ((intents & intent.flag) == intent.flag) {
          list.add(intent);
        }
        return list;
      });
    }

    throw UnsupportedError('Unsupported intent type');
  }

  @override
  dynamic toJson(List<SourceIntents> intents) =>
      intents.map((e) => e.flag).toList();
}

class BadgeColorParser implements JsonConverter<BadgeColor, dynamic> {
  const BadgeColorParser();

  @override
  BadgeColor fromJson(dynamic type) =>
      type == 'default' ? BadgeColor.def : BadgeColor.values.byName(type);

  @override
  dynamic toJson(BadgeColor color) =>
      color == BadgeColor.def ? 'default' : color.name;
}

@freezed
abstract class Badge with _$Badge {
  const factory Badge({
    required String text,
    @BadgeColorParser() required BadgeColor type,
  }) = _Badge;

  factory Badge.fromJson(Map<String, dynamic> json) => _$BadgeFromJson(json);
}

enum BadgeColor {
  def(Colors.blue),
  success(Colors.green),
  info(Colors.grey),
  warning(Color.fromARGB(255, 230, 162, 60)),
  danger(Color.fromARGB(255, 245, 108, 108));

  final Color color;
  const BadgeColor(this.color);
}

@freezed
abstract class SourceVersion with _$SourceVersion {
  const SourceVersion._();

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

  factory SourceVersion.fromJson(Map<String, dynamic> json) =>
      _$SourceVersionFromJson(json);

  List<SourceIntents> getCapabilities() {
    return intents == null
        ? []
        : SourceIntents.values.fold([], (list, intent) {
          if ((intents! & intent.flag) == intent.flag) {
            list.add(intent);
          }
          return list;
        });
  }
}

@freezed
abstract class BuiltWith with _$BuiltWith {
  const factory BuiltWith({required String toolchain, required String types}) =
      _BuiltWith;

  factory BuiltWith.fromJson(Map<String, dynamic> json) =>
      _$BuiltWithFromJson(json);
}

@freezed
abstract class Versioning with _$Versioning {
  const factory Versioning({
    required String buildTime,
    required List<SourceVersion> sources,
    required BuiltWith builtWith,
  }) = _Versioning;

  factory Versioning.fromJson(Map<String, dynamic> json) =>
      _$VersioningFromJson(json);
}

@freezed
@JsonSerializable()
class RepoInfo with _$RepoInfo {
  const RepoInfo({required this.name, required this.url});

  @override
  final String name;
  @override
  final String url;

  factory RepoInfo.fromJson(Map<String, dynamic> json) =>
      _$RepoInfoFromJson(json);

  Map<String, dynamic> toJson() => _$RepoInfoToJson(this);
}

@freezed
@JsonSerializable()
class RepoData with _$RepoData implements RepoInfo {
  const RepoData({
    required this.name,
    required this.url,
    required this.version,
  });

  @override
  final String name;
  @override
  final String url;
  @override
  final SupportedVersion version;

  factory RepoData.fromInfo(RepoInfo info, SupportedVersion version) =>
      RepoData(name: info.name, url: info.url, version: version);

  factory RepoData.fromJson(Map<String, dynamic> json) =>
      _$RepoDataFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RepoDataToJson(this);
}

// ignore: constant_identifier_names
enum ContentRating { EVERYONE, MATURE, ADULT }

@freezed
abstract class PartialSourceManga with _$PartialSourceManga {
  const factory PartialSourceManga({
    required String mangaId,
    required String image,
    required String title,
    String? subtitle,
  }) = _PartialSourceManga;

  factory PartialSourceManga.fromJson(Map<String, dynamic> json) =>
      _$PartialSourceMangaFromJson(json);
}

@freezed
abstract class PagedResults with _$PagedResults {
  const factory PagedResults({
    List<PartialSourceManga>? results,
    dynamic metadata,
  }) = _PagedResults;

  factory PagedResults.fromJson(Map<String, dynamic> json) =>
      _$PagedResultsFromJson(json);
}

@freezed
abstract class MangaInfo with _$MangaInfo {
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

  factory MangaInfo.fromJson(Map<String, dynamic> json) =>
      _$MangaInfoFromJson(json);
}

@freezed
abstract class Tag with _$Tag {
  const factory Tag({required String id, required String label}) = _Tag;

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);
}

@freezed
abstract class TagSection with _$TagSection {
  const factory TagSection({
    required String id,
    required String label,
    required List<Tag> tags,
  }) = _TagSection;

  factory TagSection.fromJson(Map<String, dynamic> json) =>
      _$TagSectionFromJson(json);
}

@freezed
abstract class SourceManga with _$SourceManga {
  const factory SourceManga({
    required String id,
    required MangaInfo mangaInfo,
  }) = _SourceManga;

  factory SourceManga.fromJson(Map<String, dynamic> json) =>
      _$SourceMangaFromJson(json);
}

@freezed
abstract class Chapter with _$Chapter {
  const factory Chapter({
    required String id,
    required num chapNum,
    String? langCode,
    String? name,
    num? volume,
    String? group,
    @NullableTimestampSerializer() DateTime? time,
    num? sortingIndex,
  }) = _Chapter;

  factory Chapter.fromJson(Map<String, dynamic> json) =>
      _$ChapterFromJson(json);
}

@freezed
abstract class ChapterDetails with _$ChapterDetails {
  const factory ChapterDetails({
    required String id,
    required String mangaId,
    required List<String> pages,
  }) = _ChapterDetails;

  factory ChapterDetails.fromJson(Map<String, dynamic> json) =>
      _$ChapterDetailsFromJson(json);
}

@freezed
abstract class SearchRequest with _$SearchRequest {
  const SearchRequest._();

  const factory SearchRequest({
    String? title,
    @Default([]) List<Tag> includedTags,
    @Default([]) List<Tag> excludedTags,
  }) = _SearchRequest;

  factory SearchRequest.fromJson(Map<String, dynamic> json) =>
      _$SearchRequestFromJson(json);

  bool get isEmpty =>
      (title == null || title!.isEmpty) &&
      includedTags.isEmpty &&
      excludedTags.isEmpty;

  bool get isFiltersEmpty => includedTags.isEmpty && excludedTags.isEmpty;
}

@freezed
abstract class HomeSection with _$HomeSection {
  const factory HomeSection({
    required String id,
    required String title,
    required List<PartialSourceManga> items,
    required bool containsMoreItems,
  }) = _HomeSection;

  factory HomeSection.fromJson(Map<String, dynamic> json) =>
      _$HomeSectionFromJson(json);
}

abstract class DUIFormRow {
  String get id;
}

abstract class DUIInputType extends DUIFormRow {
  String get label;
}

abstract class DUILabelType extends DUIFormRow {
  String get label;
}

@Freezed(unionKey: 'type')
abstract class DUIOAuthResponseType with _$DUIOAuthResponseType {
  const factory DUIOAuthResponseType.token() = DUIOAuthTokenResponse;

  const factory DUIOAuthResponseType.code({required String tokenEndpoint}) =
      DUIOAuthCodeResponse;

  const factory DUIOAuthResponseType.pkce({
    required String tokenEndpoint,
    required num pkceCodeLength,
    required String pkceCodeMethod,
    required bool formEncodeGrant,
  }) = DUIOAuthPKCEResponse;

  factory DUIOAuthResponseType.fromJson(Map<String, dynamic> json) =>
      _$DUIOAuthResponseTypeFromJson(json);
}

@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.none)
sealed class DUIType with _$DUIType {
  @Implements<DUIFormRow>()
  const factory DUIType.DUISection({
    required String id,
    String? header,
    String? footer,
    required bool isHidden,
    required List<DUIType> rows,
  }) = DUISection;

  @Implements<DUIFormRow>()
  const factory DUIType.DUISelect({
    required String id,
    required String label,
    required List<String> options,
    required bool allowsMultiselect,
    required Map<String, String> labels,
  }) = DUISelect;

  @Implements<DUIInputType>()
  const factory DUIType.DUIInputField({
    required String id,
    required String label,
  }) = DUIInputField;

  @Implements<DUIInputType>()
  const factory DUIType.DUISecureInputField({
    required String id,
    required String label,
  }) = DUISecureInputField;

  @Implements<DUIFormRow>()
  const factory DUIType.DUIStepper({
    required String id,
    required String label,
    num? min,
    num? max,
    num? step,
  }) = DUIStepper;

  @Implements<DUILabelType>()
  const factory DUIType.DUILabel({
    required String id,
    required String label,
    String? value,
  }) = DUILabel;

  @Implements<DUILabelType>()
  const factory DUIType.DUIMultilineLabel({
    required String id,
    required String label,
    required String value,
  }) = DUIMultilineLabel;

  @Implements<DUIFormRow>()
  const factory DUIType.DUIHeader({
    required String id,
    required String imageUrl,
    required String title,
    String? subtitle,
  }) = DUIHeader;

  @Implements<DUIFormRow>()
  const factory DUIType.DUIButton({required String id, required String label}) =
      DUIButton;

  @Implements<DUIFormRow>()
  const factory DUIType.DUINavigationButton({
    required String id,
    required String label,
    required DUIForm form,
  }) = DUINavigationButton;

  @Implements<DUIFormRow>()
  const factory DUIType.DUISwitch({required String id, required String label}) =
      DUISwitch;

  @Implements<DUIFormRow>()
  const factory DUIType.DUIOAuthButton({
    required String id,
    required String label,
    required String authorizeEndpoint,
    required String clientId,
    required DUIOAuthResponseType responseType,
    String? redirectUri,
    List<String>? scopes,
  }) = DUIOAuthButton;

  const factory DUIType.DUIForm({
    required List<DUISection> sections,
    required bool hasSubmit,
  }) = DUIForm;

  factory DUIType.fromJson(Map<String, dynamic> json) =>
      _$DUITypeFromJson(json);
}
