// ignore_for_file: non_constant_identifier_names, invalid_annotation_target

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gagaku/reader/main.dart' show CtxCallback;
import 'package:gagaku/util/freezed.dart';
import 'package:gagaku/util/util.dart';

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

extension type ChapterEntry(MapEntry<String, WebChapter> e) {
  ChapterEntry.entry(String key, WebChapter value) : e = MapEntry(key, value);

  String get name => e.key;
  WebChapter get chapter => e.value;
}

enum SourceType { proxy, source }

@unfreezed
abstract class SourceHandler with _$SourceHandler {
  SourceHandler._();

  factory SourceHandler({
    required SourceType type,
    required String sourceId,
    required String location,
    String? chapter,
    @JsonKey(includeFromJson: false, includeToJson: false)
    WebSourceInfo? parser,
  }) = _SourceHandler;

  String getURL() =>
      type == SourceType.proxy
          ? 'https://cubari.moe/read/$sourceId/$location/'
          : '$sourceId/$location';
  String getKey() => '$sourceId/$location';

  factory SourceHandler.fromJson(Map<String, dynamic> json) =>
      _$SourceHandlerFromJson(json);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SourceHandler &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.sourceId, sourceId) ||
                other.sourceId == sourceId) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.chapter, chapter) || other.chapter == chapter));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, type, sourceId, location, chapter, parser);
}

@freezed
abstract class UpdateFeedItem with _$UpdateFeedItem {
  const factory UpdateFeedItem({
    required HistoryLink link,
    required WebManga manga,
  }) = _UpdateFeedItem;

  factory UpdateFeedItem.fromJson(Map<String, dynamic> json) =>
      _$UpdateFeedItemFromJson(json);
}

@freezed
abstract class HistoryLink with _$HistoryLink {
  const HistoryLink._();

  const factory HistoryLink({
    required String title,
    required String url,
    String? cover,
    SourceHandler? handle,
  }) = _HistoryLink;

  factory HistoryLink.fromJson(Map<String, dynamic> json) =>
      _$HistoryLinkFromJson(json);

  // factory HistoryLink.fromPartialSourceManga(
  //   WebSourceInfo source,
  //   PartialSourceManga manga,
  // ) => HistoryLink(
  //   title: manga.title,
  //   url: '${source.id}/${manga.mangaId}',
  //   cover: manga.image,
  //   handle: SourceHandler(
  //     type: SourceType.source,
  //     sourceId: source.id,
  //     location: manga.mangaId,
  //     parser: source,
  //   ),

  factory HistoryLink.fromSearchReultItem(
    WebSourceInfo source,
    SearchResultItem item,
  ) => HistoryLink(
    title: item.title,
    url: '${source.id}/${item.mangaId}',
    cover: item.imageUrl,
    handle: SourceHandler(
      type: SourceType.source,
      sourceId: source.id,
      location: item.mangaId,
      parser: source,
    ),
  );

  factory HistoryLink.fromDiscoverySectionItem(
    String sourceId,
    DiscoverSectionItem item,
  ) {
    return switch (item) {
      GenresCarouselItem() => throw UnsupportedError('Unsupported type'),
      ChapterUpdatesCarouselItem() => HistoryLink(
        title: item.title,
        url: '$sourceId/${item.mangaId}',
        cover: item.imageUrl,
      ),
      ProminentCarouselItem() => HistoryLink(
        title: item.title,
        url: '$sourceId/${item.mangaId}',
        cover: item.imageUrl,
      ),
      SimpleCarouselItem() => HistoryLink(
        title: item.title,
        url: '$sourceId/${item.mangaId}',
        cover: item.imageUrl,
      ),
      FeaturedCarouselItem() => HistoryLink(
        title: item.title,
        url: '$sourceId/${item.mangaId}',
        cover: item.imageUrl,
      ),
    };
  }

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

class WebChapterSerializer
    implements JsonConverter<List<ChapterEntry>, dynamic> {
  const WebChapterSerializer();

  @override
  List<ChapterEntry> fromJson(dynamic chapters) {
    final map = (chapters as Map<String, dynamic>).map(
      (k, e) => MapEntry(k, WebChapter.fromJson(e as Map<String, dynamic>)),
    );

    final chapterlist = map.entries.map((e) => ChapterEntry(e)).toList();
    chapterlist.sort((a, b) => compareNatural(b.name, a.name));

    return chapterlist;
  }

  @override
  dynamic toJson(List<ChapterEntry> chapters) {
    return Map.fromEntries(
      chapters.cast<MapEntry<String, WebChapter>>(),
    ).map((k, e) => MapEntry(k, e.toJson()));
  }
}

@unfreezed
abstract class WebManga with _$WebManga {
  WebManga._();

  factory WebManga({
    required String title,
    required String description,
    required String artist,
    required String author,
    required String cover,
    Map<String, String>? groups,
    @WebChapterSerializer() required List<ChapterEntry> chapters,
    SourceManga? data,
  }) = _WebManga;

  factory WebManga.fromJson(Map<String, dynamic> json) =>
      _$WebMangaFromJson(json);

  WebChapter? getChapter(String chapter) {
    return chapters.firstWhereOrNull((e) => chapter == e.name)?.chapter;
  }
}

class ChapterGroupSerializer
    implements JsonConverter<Map<String, dynamic>, dynamic> {
  const ChapterGroupSerializer();

  @override
  Map<String, dynamic> fromJson(dynamic groups) {
    final map = groups as Map<String, dynamic>;

    if (map.isNotEmpty) {
      final entry = map.entries.first;
      final content = entry.value;

      if (content is Map &&
          (content.containsKey('id') || content.containsKey('chapterId'))) {
        map.updateAll((g, element) {
          return Chapter.fromJson(element);
        });
      }
    }

    return map;
  }

  @override
  dynamic toJson(Map<String, dynamic> groups) {
    final map = {...groups};

    if (map.isNotEmpty) {
      final entry = map.entries.first;
      final content = entry.value;

      if (content is Chapter) {
        map.updateAll((g, element) {
          final processed = (element as Chapter).toJson();
          return processed;
        });
      }
    }

    return map;
  }
}

@Freezed(makeCollectionsUnmodifiable: false)
abstract class WebChapter with _$WebChapter {
  const WebChapter._();

  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory WebChapter({
    String? title,
    String? volume,
    @EpochTimestampSerializer() DateTime? lastUpdated,
    @MappedEpochTimestampSerializer() DateTime? releaseDate,
    @ChapterGroupSerializer() required Map<String, dynamic> groups,
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
    String? baseUrl,
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
  v0_8('0.8'),
  v0_9('1.0.0');

  final String version;
  const SupportedVersion(this.version);
}

///////////////////////////////////////////////////////////////////// PB types

enum SourceIntents {
  mangaChapters(1 << 0),
  mangaProgress(1 << 1),
  discoverSections(1 << 2),
  collectionManagement(1 << 3),
  cloudflareBypassRequired(1 << 4),
  settingsUI(1 << 5),
  mangaSearch(1 << 6);

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
abstract class Badge08 with _$Badge08 {
  const factory Badge08({
    required String text,
    @BadgeColorParser() required BadgeColor type,
  }) = _Badge08;

  factory Badge08.fromJson(Map<String, dynamic> json) =>
      _$Badge08FromJson(json);
}

@freezed
abstract class SourceBadge with _$SourceBadge {
  const factory SourceBadge({
    required String label,
    required String textColor,
    required String backgroundColor,
  }) = _SourceBadge;

  factory SourceBadge.fromJson(Map<String, dynamic> json) =>
      _$SourceBadgeFromJson(json);

  factory SourceBadge.fromBadge08(Badge08 badge) => SourceBadge(
    label: badge.text,
    textColor: '#000000',
    backgroundColor: badge.type.color.toHex(),
  );
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
abstract class SourceDeveloper with _$SourceDeveloper {
  const factory SourceDeveloper({
    required String name,
    String? website,
    String? github,
  }) = _SourceDeveloper;

  factory SourceDeveloper.fromJson(Map<String, dynamic> json) =>
      _$SourceDeveloperFromJson(json);
}

@freezed
sealed class SourceVersion with _$SourceVersion {
  const SourceVersion._();

  const factory SourceVersion.zero_eight({
    required String id,
    required String name,
    required String author,
    required String desc,
    String? website,
    required ContentRating contentRating,
    required String version,
    required String icon,
    List<Badge08>? tags,
    required String websiteBaseURL,
    int? intents,
  }) = SourceVersion08;

  const factory SourceVersion.zero_nine({
    required String id,
    required String name,
    required String description,
    required String version,
    required String icon,
    String? language,
    @ContentRatingParser() required ContentRating contentRating,
    required List<SourceBadge> badges,
    required List<SourceDeveloper> developers,
    @SourceIntentOrListParser() required List<SourceIntents> capabilities,
  }) = SourceVersion09;

  factory SourceVersion.fromJson(Map<String, dynamic> json) =>
      _$SourceVersionFromJson(json);

  String getDescription() {
    return switch (this) {
      SourceVersion08(:final desc) => desc,
      SourceVersion09(:final description) => description,
    };
  }

  String getAuthor() {
    return switch (this) {
      SourceVersion08(:final author) => author,
      SourceVersion09(:final developers) => developers.first.name,
    };
  }

  List<SourceBadge> getBadges() {
    return switch (this) {
      SourceVersion08(:final tags) =>
        tags == null
            ? []
            : tags.map((e) => SourceBadge.fromBadge08(e)).toList(),
      SourceVersion09(:final badges) => badges,
    };
  }

  List<SourceIntents> getCapabilities() {
    return switch (this) {
      SourceVersion08(:final intents) =>
        intents == null
            ? []
            : SourceIntents.values.fold([], (list, intent) {
              if ((intents & intent.flag) == intent.flag) {
                list.add(intent);
              }
              return list;
            }),
      SourceVersion09(:final capabilities) => capabilities,
    };
  }

  String getIconPath() {
    return switch (this) {
      SourceVersion08() => '$id/includes/$icon',
      SourceVersion09() => '$id/static/$icon',
    };
  }

  String? getBaseUrl() {
    RegExp exp = RegExp(r'((https:\/\/)?\w+\.\w+)');

    String? result = switch (this) {
      SourceVersion08(:final websiteBaseURL) => websiteBaseURL,
      SourceVersion09(:final description) => exp.firstMatch(description)?[0],
    };

    if (result != null && !result.startsWith('https://')) {
      result = 'https://$result';
    }

    return result;
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
    required List<dynamic> sources,
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

// abstract class DUIFormRow {
//   String get id;
// }

// abstract class DUIInputType extends DUIFormRow {
//   String get label;
// }

// abstract class DUILabelType extends DUIFormRow {
//   String get label;
// }

@Freezed(unionKey: 'type')
abstract class OAuthResponseType with _$OAuthResponseType {
  const factory OAuthResponseType.token() = OAuthTokenResponse;

  const factory OAuthResponseType.code({required String tokenEndpoint}) =
      OAuthCodeResponse;

  const factory OAuthResponseType.pkce({
    required String tokenEndpoint,
    required num pkceCodeLength,
    required String pkceCodeMethod,
    required bool formEncodeGrant,
  }) = OAuthPKCEResponse;

  factory OAuthResponseType.fromJson(Map<String, dynamic> json) =>
      _$OAuthResponseTypeFromJson(json);
}

// @Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.none)
// sealed class DUIType with _$DUIType {
//   @Implements<DUIFormRow>()
//   const factory DUIType.DUISection({
//     required String id,
//     String? header,
//     String? footer,
//     required bool isHidden,
//     required List<DUIType> rows,
//   }) = DUISection;

//   @Implements<DUIFormRow>()
//   const factory DUIType.DUISelect({
//     required String id,
//     required String label,
//     required List<String> options,
//     required bool allowsMultiselect,
//     required Map<String, String> labels,
//   }) = DUISelect;

//   @Implements<DUIInputType>()
//   const factory DUIType.DUIInputField({
//     required String id,
//     required String label,
//   }) = DUIInputField;

//   @Implements<DUIInputType>()
//   const factory DUIType.DUISecureInputField({
//     required String id,
//     required String label,
//   }) = DUISecureInputField;

//   @Implements<DUIFormRow>()
//   const factory DUIType.DUIStepper({
//     required String id,
//     required String label,
//     num? min,
//     num? max,
//     num? step,
//   }) = DUIStepper;

//   @Implements<DUILabelType>()
//   const factory DUIType.DUILabel({
//     required String id,
//     required String label,
//     String? value,
//   }) = DUILabel;

//   @Implements<DUILabelType>()
//   const factory DUIType.DUIMultilineLabel({
//     required String id,
//     required String label,
//     required String value,
//   }) = DUIMultilineLabel;

//   @Implements<DUIFormRow>()
//   const factory DUIType.DUIHeader({
//     required String id,
//     required String imageUrl,
//     required String title,
//     String? subtitle,
//   }) = DUIHeader;

//   @Implements<DUIFormRow>()
//   const factory DUIType.DUIButton({required String id, required String label}) =
//       DUIButton;

//   @Implements<DUIFormRow>()
//   const factory DUIType.DUINavigationButton({
//     required String id,
//     required String label,
//     required DUIForm form,
//   }) = DUINavigationButton;

//   @Implements<DUIFormRow>()
//   const factory DUIType.DUISwitch({required String id, required String label}) =
//       DUISwitch;

//   @Implements<DUIFormRow>()
//   const factory DUIType.DUIOAuthButton({
//     required String id,
//     required String label,
//     required String authorizeEndpoint,
//     required String clientId,
//     required OAuthResponseType responseType,
//     String? redirectUri,
//     List<String>? scopes,
//   }) = DUIOAuthButton;

//   const factory DUIType.DUIForm({
//     required List<DUISection> sections,
//     required bool hasSubmit,
//   }) = DUIForm;

//   factory DUIType.fromJson(Map<String, dynamic> json) =>
//       _$DUITypeFromJson(json);
// }

////////////////////// 0.9

class ContentRatingParser implements JsonConverter<ContentRating, dynamic> {
  const ContentRatingParser();

  @override
  ContentRating fromJson(dynamic rating) =>
      rating == 'SAFE'
          ? ContentRating.EVERYONE
          : ContentRating.values.byName(rating);

  @override
  dynamic toJson(ContentRating rating) =>
      rating == ContentRating.EVERYONE ? 'SAFE' : rating.name;
}

class NullableContentRatingParser
    implements JsonConverter<ContentRating?, dynamic> {
  const NullableContentRatingParser();

  @override
  ContentRating? fromJson(dynamic rating) =>
      rating != null ? const ContentRatingParser().fromJson(rating) : null;

  @override
  dynamic toJson(ContentRating? rating) =>
      rating != null ? const ContentRatingParser().toJson(rating) : null;
}

// ignore: constant_identifier_names
enum ContentRating { EVERYONE, MATURE, ADULT }

@freezed
abstract class SearchQuery with _$SearchQuery {
  const SearchQuery._();

  const factory SearchQuery({
    required String title,
    @Default([]) List<SearchFilterValue> filters,
  }) = _SearchQuery;

  factory SearchQuery.fromJson(Map<String, dynamic> json) =>
      _$SearchQueryFromJson(json);

  bool get isEmpty => title.isEmpty && filters.isEmpty;
}

@freezed
abstract class SearchResultItem with _$SearchResultItem {
  const factory SearchResultItem({
    required String mangaId,
    required String title,
    String? subtitle,
    required String imageUrl,
    dynamic metadata,
  }) = _SearchResultItem;

  factory SearchResultItem.fromJson(Map<String, dynamic> json) =>
      _$SearchResultItemFromJson(json);
}

@Freezed(genericArgumentFactories: true)
abstract class PagedResults<T> with _$PagedResults<T> {
  factory PagedResults({required List<T> items, dynamic metadata}) =
      _PagedResults<T>;

  factory PagedResults.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$PagedResultsFromJson<T>(json, fromJsonT);
}

@freezed
abstract class SourceManga with _$SourceManga {
  const factory SourceManga({
    required String mangaId,
    required MangaInfo mangaInfo,
  }) = _SourceManga;

  factory SourceManga.fromJson(Map<String, dynamic> json) =>
      _$SourceMangaFromJson(json);
}

@freezed
abstract class MangaInfo with _$MangaInfo {
  const factory MangaInfo({
    required String thumbnailUrl,
    required String synopsis,
    required String primaryTitle,
    required List<String> secondaryTitles,
    @ContentRatingParser() required ContentRating contentRating,
    String? status,
    String? artist,
    String? author,
    String? bannerUrl,
    num? rating,
    List<TagSection>? tagGroups,
    List<String>? artworkUrls,
    Map<String, String>? additionalInfo,
    String? shareUrl,
  }) = _MangaInfo;

  factory MangaInfo.fromJson(Map<String, dynamic> json) =>
      _$MangaInfoFromJson(json);
}

@freezed
abstract class TagSection with _$TagSection {
  const factory TagSection({
    required String id,
    required String title,
    required List<Tag> tags,
  }) = _TagSection;

  factory TagSection.fromJson(Map<String, dynamic> json) =>
      _$TagSectionFromJson(json);
}

@freezed
abstract class Tag with _$Tag {
  const factory Tag({required String id, required String title}) = _Tag;

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);
}

@freezed
abstract class Chapter with _$Chapter {
  const factory Chapter({
    required String chapterId,
    required SourceManga sourceManga,
    required String langCode,
    required num chapNum,
    String? title,
    String? version,
    num? volume,
    Map<String, String>? additionalInfo,
    @NullableTimestampSerializer() DateTime? publishDate,
    @NullableTimestampSerializer() DateTime? creationDate,
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

enum DiscoverSectionType {
  featured,
  simpleCarousel,
  prominentCarousel,
  chapterUpdates,
  genres,
}

class DiscoverSectionTypeParser
    implements JsonConverter<DiscoverSectionType, dynamic> {
  const DiscoverSectionTypeParser();

  @override
  DiscoverSectionType fromJson(dynamic type) =>
      DiscoverSectionType.values.elementAt(type);

  @override
  dynamic toJson(DiscoverSectionType type) => type.index;
}

@freezed
abstract class DiscoverSection with _$DiscoverSection {
  const factory DiscoverSection({
    required String id,
    required String title,
    String? subtitle,
    @DiscoverSectionTypeParser() required DiscoverSectionType type,
  }) = _DiscoverSection;

  factory DiscoverSection.fromJson(Map<String, dynamic> json) =>
      _$DiscoverSectionFromJson(json);
}

@Freezed(unionKey: 'type')
sealed class DiscoverSectionItem with _$DiscoverSectionItem {
  const factory DiscoverSectionItem.genresCarouselItem({
    required SearchQuery searchQuery,
    required String name,
    dynamic metadata,
    @NullableContentRatingParser() ContentRating? contentRating,
  }) = GenresCarouselItem;

  const factory DiscoverSectionItem.chapterUpdatesCarouselItem({
    required String mangaId,
    required String chapterId,
    required String imageUrl,
    required String title,
    String? subtitle,
    @NullableTimestampSerializer() DateTime? publishDate,
    dynamic metadata,
    @NullableContentRatingParser() ContentRating? contentRating,
  }) = ChapterUpdatesCarouselItem;

  const factory DiscoverSectionItem.prominentCarouselItem({
    required String mangaId,
    required String imageUrl,
    required String title,
    String? subtitle,
    dynamic metadata,
    @NullableContentRatingParser() ContentRating? contentRating,
  }) = ProminentCarouselItem;

  const factory DiscoverSectionItem.simpleCarouselItem({
    required String mangaId,
    required String imageUrl,
    required String title,
    String? subtitle,
    dynamic metadata,
    @NullableContentRatingParser() ContentRating? contentRating,
  }) = SimpleCarouselItem;

  const factory DiscoverSectionItem.featuredCarouselItem({
    required String mangaId,
    required String imageUrl,
    required String title,
    String? supertitle,
    dynamic metadata,
    @NullableContentRatingParser() ContentRating? contentRating,
  }) = FeaturedCarouselItem;

  factory DiscoverSectionItem.fromJson(Map<String, dynamic> json) =>
      _$DiscoverSectionItemFromJson(json);
}

typedef SelectorID = String;
typedef FormID = String;

@freezed
abstract class SelectRowOption with _$SelectRowOption {
  const factory SelectRowOption({required String id, required String title}) =
      _SelectRowOption;

  factory SelectRowOption.fromJson(Map<String, dynamic> json) =>
      _$SelectRowOptionFromJson(json);
}

@Freezed(unionKey: 'type')
sealed class FormItemElement with _$FormItemElement {
  const factory FormItemElement.labelRow({
    required String id,
    required bool isHidden,
    required String title,
    String? subtitle,
    String? value,
  }) = LabelRowElement;

  const factory FormItemElement.inputRow({
    required String id,
    required bool isHidden,
    required String title,
    required String value,
    required SelectorID onValueChange, // (value: string) => Promise<void>
  }) = InputRowElement;

  const factory FormItemElement.toggleRow({
    required String id,
    required bool isHidden,
    required String title,
    required bool value,
    required SelectorID onValueChange, // (value: boolean) => Promise<void>
  }) = ToggleRowElement;

  const factory FormItemElement.selectRow({
    required String id,
    required bool isHidden,
    required String title,
    String? subtitle,
    required List<String> value,
    required int minItemCount,
    int? maxItemCount,
    required List<SelectRowOption> options,
    required SelectorID onValueChange, // (value: string[]) => Promise<void>
  }) = SelectRowElement;

  const factory FormItemElement.buttonRow({
    required String id,
    required bool isHidden,
    required String title,
    required SelectorID onSelect, // () => Promise<void>
  }) = ButtonRowElement;

  const factory FormItemElement.navigationRow({
    required String id,
    required bool isHidden,
    required String title,
    String? subtitle,
    String? value,
    required FormID form,
  }) = NavigationRowElement;

  const factory FormItemElement.oauthButtonRow({
    required String id,
    required bool isHidden,
    required String title,
    String? subtitle,
    required SelectorID
    onSuccess, // (refreshToken: string, accessToken: string) => Promise<void>
    required String authorizeEndpoint,
    required OAuthResponseType responseType,
    String? clientId,
    String? redirectUri,
    List<String>? scopes,
  }) = OAuthButtonRowElement;

  factory FormItemElement.fromJson(Map<String, dynamic> json) =>
      _$FormItemElementFromJson(json);
}

@freezed
abstract class FormSectionElement with _$FormSectionElement {
  const factory FormSectionElement({
    required String id,
    String? header,
    String? footer,
    required List<FormItemElement> items,
  }) = _FormSectionElement;

  factory FormSectionElement.fromJson(Map<String, dynamic> json) =>
      _$FormSectionElementFromJson(json);
}

@freezed
abstract class FilterOption with _$FilterOption {
  const factory FilterOption({required String id, required String value}) =
      _FilterOption;

  factory FilterOption.fromJson(Map<String, dynamic> json) =>
      _$FilterOptionFromJson(json);
}

@Freezed(unionKey: 'type')
sealed class SearchFilter with _$SearchFilter {
  const factory SearchFilter.dropdown({
    required String id,
    required String title,
    required List<FilterOption> options,
    required String value,
  }) = DropdownSearchFilter;

  const factory SearchFilter.multiselect({
    required String id,
    required String title,
    required List<FilterOption> options,
    required Map<String, String> value,
    required bool allowExclusion,
    required bool allowEmptySelection,
    num? maximum,
  }) = SelectSearchFilter;

  const factory SearchFilter.tags({
    required String id,
    required String title,
    required List<TagSection> sections,
    required Map<String, Map<String, String>> value,
    required bool allowExclusion,
    required bool allowEmptySelection,
    num? maximum,
  }) = TagSearchFilter;

  const factory SearchFilter.input({
    required String id,
    required String title,
    required String placeholder,
    required String value,
  }) = InputSearchFilter;

  factory SearchFilter.fromJson(Map<String, dynamic> json) =>
      _$SearchFilterFromJson(json);
}

@freezed
abstract class SearchFilterValue with _$SearchFilterValue {
  const SearchFilterValue._();

  const factory SearchFilterValue({required String id, required Object value}) =
      _SearchFilterValue;

  factory SearchFilterValue.fromJson(Map<String, dynamic> json) =>
      _$SearchFilterValueFromJson(json);

  factory SearchFilterValue.fromSearchFilter(SearchFilter filter) =>
      SearchFilterValue(id: filter.id, value: filter.value);
}
