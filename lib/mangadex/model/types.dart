// ignore_for_file: constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gagaku/util/freezed.dart';
import 'package:gagaku/util/util.dart';

part 'types.freezed.dart';
part 'types.g.dart';

typedef LibraryMap = Map<String, MangaReadingStatus>;
typedef ReadChaptersMap = Map<String, ReadChapterSet>;
typedef CoverArtUrl = String;

extension CoverArtUrlExt on CoverArtUrl {
  String quality({CoverArtQuality quality = CoverArtQuality.best}) {
    var cv = this;

    switch (quality) {
      case CoverArtQuality.best:
        break;
      case CoverArtQuality.medium:
        cv += '.512.jpg';
        break;
      case CoverArtQuality.small:
        cv += '.256.jpg';
        break;
    }

    return cv;
  }
}

extension LocalizedStringExt on Map<String, String> {
  String get(String code) {
    return containsKey(code) ? this[code]! : entries.first.value;
  }
}

enum ContentRating {
  safe,
  suggestive,
  erotica,
  pornographic;

  static const _key = 'contentRating.';
  String get label => '$_key$name';
}

enum MangaDemographic {
  shounen,
  shoujo,
  josei,
  seinen;

  String get label => name.capitalize();
}

enum MangaStatus {
  completed,
  ongoing,
  cancelled,
  hiatus;

  static const _key = 'mangaStatus.';
  String get label => '$_key$name';
}

enum MangaReadingStatus {
  remove,
  reading,
  on_hold,
  plan_to_read,
  dropped,
  re_reading,
  completed;

  static const _key = 'readingStatus.';
  String get label => '$_key$name';
}

const RatingLabel = [
  'Remove Rating',
  '(1) Appalling',
  '(2) Horrible',
  '(3) Very Bad',
  '(4) Bad',
  '(5) Average',
  '(6) Fine',
  '(7) Good',
  '(8) Very Good',
  '(9) Great',
  '(10) Masterpiece',
];

enum TagGroup {
  content,
  format,
  genre,
  theme;

  String get label => name.capitalize();
}

enum CoverArtQuality { best, medium, small }

enum FilterOrder {
  relevance_asc(MapEntry('order[relevance]', 'asc')),
  relevance_desc(MapEntry('order[relevance]', 'desc')),
  followedCount_asc(MapEntry('order[followedCount]', 'asc')),
  followedCount_desc(MapEntry('order[followedCount]', 'desc')),
  latestUploadedChapter_asc(MapEntry('order[latestUploadedChapter]', 'asc')),
  latestUploadedChapter_desc(MapEntry('order[latestUploadedChapter]', 'desc')),
  updatedAt_asc(MapEntry('order[updatedAt]', 'asc')),
  updatedAt_desc(MapEntry('order[updatedAt]', 'desc')),
  createdAt_asc(MapEntry('order[createdAt]', 'asc')),
  createdAt_desc(MapEntry('order[createdAt]', 'desc')),
  year_asc(MapEntry('order[year]', 'asc')),
  year_desc(MapEntry('order[year]', 'desc')),
  title_asc(MapEntry('order[title]', 'asc')),
  title_desc(MapEntry('order[title]', 'desc'));

  const FilterOrder(this.json);
  final MapEntry<String, dynamic> json;

  static const _key = 'mangadex.sort.';
  String get label => '$_key$name';
}

enum CustomListVisibility {
  private,
  public;

  static const _key = 'mangadex.listVisibility.';
  String get label => '$_key$name';
}

enum MangaRelations {
  monochrome,
  main_story,
  adapted_from,
  based_on,
  prequel,
  side_story,
  doujinshi,
  same_franchise,
  shared_universe,
  sequel,
  spin_off,
  alternate_story,
  alternate_version,
  preserialization,
  colored,
  serialization;

  static const _key = 'mangaRelations.';
  String get label => '$_key$name';
}

enum TagMode {
  and,
  or;

  String get label => name.capitalize();
  String get code => name.toUpperCase();
}

enum ListSort {
  descending('desc'),
  ascending('asc');

  const ListSort(this.order);
  final String order;
}

class MangaFilterAction {
  static MangaFilters action(
    MangaFilters state, {
    Set<Tag>? includedTags,
    TagMode? includedTagsMode,
    Set<Tag>? excludedTags,
    TagMode? excludedTagsMode,
    Set<MangaStatus>? status,
    Set<MangaDemographic>? publicationDemographic,
    Set<ContentRating>? contentRating,
    Set<CreatorType>? author,
    Set<CreatorType>? artist,
  }) {
    MangaFilters updated = state.copyWith(
      includedTags: includedTags ?? state.includedTags,
      includedTagsMode: includedTagsMode ?? state.includedTagsMode,
      excludedTags: excludedTags ?? state.excludedTags,
      excludedTagsMode: excludedTagsMode ?? state.excludedTagsMode,
      status: status ?? state.status,
      publicationDemographic:
          publicationDemographic ?? state.publicationDemographic,
      contentRating: contentRating ?? state.contentRating,
      author: author ?? state.author,
      artist: artist ?? state.artist,
    );

    return updated;
  }
}

@freezed
abstract class MangaFilters with _$MangaFilters {
  const MangaFilters._();

  const factory MangaFilters({
    @Default({}) Set<Tag> includedTags,
    @Default(TagMode.and) TagMode includedTagsMode,
    @Default({}) Set<Tag> excludedTags,
    @Default(TagMode.or) TagMode excludedTagsMode,
    @Default({}) Set<CreatorType> author,
    @Default({}) Set<CreatorType> artist,
    @Default({}) Set<MangaStatus> status,
    @Default({}) Set<MangaDemographic> publicationDemographic,
    @Default({}) Set<ContentRating> contentRating,
    @Default(FilterOrder.relevance_desc) FilterOrder order,
  }) = _MangaFilters;

  // factory MangaFilters.fromJson(Map<String, dynamic> json) =>
  //     _$MangaFiltersFromJson(json);

  Map<String, dynamic> getMap() {
    var params = <String, dynamic>{};

    if (includedTags.isNotEmpty) {
      params['includedTags[]'] = includedTags.map((e) => e.id).toList();
      params['includedTagsMode'] = includedTagsMode.code;
    }

    if (excludedTags.isNotEmpty) {
      params['excludedTags[]'] = excludedTags.map((e) => e.id).toList();
      params['excludedTagsMode'] = excludedTagsMode.code;
    }

    if (status.isNotEmpty) {
      params['status[]'] = status.map((e) => e.name).toList();
    }

    if (publicationDemographic.isNotEmpty) {
      params['publicationDemographic[]'] =
          publicationDemographic.map((e) => e.name).toList();
    }

    if (contentRating.isNotEmpty) {
      params['contentRating[]'] = contentRating.map((e) => e.name).toList();
    }

    if (author.isNotEmpty) {
      params['authors[]'] = author.map((e) => e.id).toList();
    }

    if (artist.isNotEmpty) {
      params['artists[]'] = artist.map((e) => e.id).toList();
    }

    params.addEntries([order.json]);

    return params;
  }
}

@freezed
abstract class MangaSearchParameters with _$MangaSearchParameters {
  const factory MangaSearchParameters({
    required String query,
    required MangaFilters filter,
  }) = _MangaSearchParameters;
}

class LanguageConverter implements JsonConverter<Language, dynamic> {
  const LanguageConverter();

  @override
  Language fromJson(dynamic lang) => Languages.get(lang);

  @override
  dynamic toJson(Language lang) => lang.code;
}

enum Language {
  en('en', '🇬🇧'),
  ar('ar', '🇸🇦'),
  az('az', '🇦🇿'),
  bn('bn', '🇧🇩'),
  bg('bg', '🇧🇬'),
  my('my', '🇲🇲'),
  ca('ca', '🇦🇩'),
  zh('zh', '🇨🇳'),
  zh_hk('zh-hk', '🇭🇰'),
  hr('hr', '🇭🇷'),
  cs('cs', '🇨🇿'),
  da('da', '🇩🇰'),
  nl('nl', '🇳🇱'),
  eo('eo', '🇺🇳'),
  et('et', '🇪🇪'),
  tl('tl', '🇵🇭'),
  fi('fi', '🇫🇮'),
  fr('fr', '🇫🇷'),
  ka('ka', '🇬🇪'),
  de('de', '🇩🇪'),
  el('el', '🇬🇷'),
  he('he', '🇮🇱'),
  hi('hi', '🇮🇳'),
  hu('hu', '🇭🇺'),
  id('id', '🇮🇩'),
  it('it', '🇮🇹'),
  ja('ja', '🇯🇵'),
  kk('kk', '🇰🇿'),
  ko('ko', '🇰🇷'),
  la('la', '🇻🇦'),
  lt('lt', '🇱🇹'),
  ms('ms', '🇲🇾'),
  mn('mn', '🇲🇳'),
  ne('ne', '🇳🇵'),
  no('no', '🇳🇴'),
  fa('fa', '🇮🇷'),
  pl('pl', '🇵🇱'),
  pt_br('pt-br', '🇧🇷'),
  pt('pt', '🇵🇹'),
  ro('ro', '🇷🇴'),
  ru('ru', '🇷🇺'),
  sr('sr', '🇷🇸'),
  sk('sk', '🇸🇰'),
  es('es', '🇪🇸'),
  es_la('es-la', '🇲🇽'),
  sv('sv', '🇸🇪'),
  ta('ta', '🇱🇰'),
  th('th', '🇹🇭'),
  tr('tr', '🇹🇷'),
  uk('uk', '🇺🇦'),
  vi('vi', '🇻🇳'),

  // Non-standard
  ja_ro('ja-ro', 'jp', true),
  ko_ro('ko-ro', 'ko', true),
  zh_ro('zh-ro', 'zh', true),
  other('NULL', '🇺🇳', true);

  const Language(this.code, this.flag, [this.nonStandard = false]);

  final String code;
  final String flag;
  final bool nonStandard;

  static const _key = 'language.';
  String get label => '$_key$name';
}

class Languages {
  static Iterable<Language> get languages =>
      Language.values.where((element) => element.nonStandard == false);

  static Language get(String code) {
    final langs = Language.values.where((element) => element.code == code);

    if (langs.isEmpty) {
      return Language.other;
    }

    return langs.first;
  }
}

abstract class MangaDexUUID {
  String get id;

  Map<String, dynamic> toJson();
}

abstract class CreatorType implements MangaDexUUID {
  AuthorAttributes get attributes;
}

@Freezed(unionKey: 'type')
sealed class MangaDexEntity with _$MangaDexEntity implements MangaDexUUID {
  const MangaDexEntity._();

  @With<ChapterOps>()
  factory MangaDexEntity.chapter({
    required String id,
    required ChapterAttributes attributes,
    required List<MangaDexEntity> relationships,
  }) = Chapter;

  @With<MangaOps>()
  factory MangaDexEntity.manga({
    required String id,
    MangaAttributes? attributes,
    List<MangaDexEntity>? relationships,
    MangaRelations? related,
  }) = Manga;

  const factory MangaDexEntity.user({
    required String id,
    UserAttributes? attributes,
  }) = User;

  @Implements<CreatorType>()
  const factory MangaDexEntity.artist({
    required String id,
    required AuthorAttributes attributes,
  }) = Artist;

  @Implements<CreatorType>()
  const factory MangaDexEntity.author({
    required String id,
    required AuthorAttributes attributes,
  }) = Author;

  const factory MangaDexEntity.creator({required String id}) = CreatorID;

  @FreezedUnionValue('cover_art')
  const factory MangaDexEntity.cover({
    required String id,
    CoverArtAttributes? attributes,
  }) = CoverArt;

  @FreezedUnionValue('scanlation_group')
  const factory MangaDexEntity.group({
    required String id,
    required ScanlationGroupAttributes attributes,
  }) = Group;

  @FreezedUnionValue('custom_list')
  @With<CustomListOps>()
  factory MangaDexEntity.customList({
    required String id,
    required CustomListAttributes attributes,
    required List<MangaDexEntity> relationships,
  }) = CustomList;

  const factory MangaDexEntity.error({
    required String id,
    required int status,
    required String title,
    String? detail,
    String? context,
  }) = MDError;

  const factory MangaDexEntity.tag({
    required String id,
    required TagAttributes attributes,
  }) = Tag;

  factory MangaDexEntity.fromJson(Map<String, dynamic> json) =>
      _$MangaDexEntityFromJson(json);
}

@freezed
abstract class ChapterAPIData with _$ChapterAPIData {
  const factory ChapterAPIData({
    required String hash,
    required List<String> data,
    required List<String> dataSaver,
  }) = _ChapterAPIData;

  factory ChapterAPIData.fromJson(Map<String, dynamic> json) =>
      _$ChapterAPIDataFromJson(json);
}

@freezed
abstract class ChapterAPI with _$ChapterAPI {
  const ChapterAPI._();

  const factory ChapterAPI({
    required String baseUrl,
    required ChapterAPIData chapter,
  }) = _ChapterAPI;

  factory ChapterAPI.fromJson(Map<String, dynamic> json) =>
      _$ChapterAPIFromJson(json);

  String getUrl(bool datasaver) =>
      '$baseUrl/${datasaver ? 'data-saver' : 'data'}/${chapter.hash}/';
}

@freezed
abstract class MDEntityList with _$MDEntityList {
  const factory MDEntityList({
    required String result,
    required String response,
    required List<MangaDexEntity> data,
    required int limit,
    required int offset,
    required int total,
  }) = _MDEntityList;

  factory MDEntityList.fromJson(Map<String, dynamic> json) =>
      _$MDEntityListFromJson(json);
}

mixin ChapterOps on MangaDexEntity {
  ChapterAttributes get attributes;
  List<MangaDexEntity> get relationships;

  late final title = _getTitle();
  late final List<Group> groups = List.unmodifiable(_getGroups());
  late final manga = _getManga();
  late final uploadUser = _getUploadUser();

  String _getTitle() {
    String title = '';

    if (attributes.chapter != null && attributes.chapter!.isNotEmpty) {
      title += 'Ch. ${attributes.chapter}';
    }

    if (attributes.title != null && attributes.title!.isNotEmpty) {
      if (title.isNotEmpty) {
        title += ' - ';
      }

      title += '${attributes.title}';
    }

    if (title.isEmpty) {
      // Probably a oneshot?
      title = 'Oneshot';
    }

    return title;
  }

  List<Group> _getGroups() {
    final groups = relationships.whereType<Group>();
    return groups.toList();
  }

  Manga _getManga() {
    final mangas = relationships.whereType<Manga>();

    if (mangas.isNotEmpty) {
      return mangas.first;
    }

    throw Exception('Chapter $id has no associated manga');
  }

  User? _getUploadUser() {
    final user = relationships.whereType<User>();

    if (user.isNotEmpty) {
      return user.first;
    }

    return null;
  }
}

mixin MangaOps on MangaDexEntity {
  MangaAttributes? get attributes;
  List<MangaDexEntity>? get relationships;
  MangaRelations? get related;

  late final List<CreatorType> author = List.unmodifiable(_getAuthor());
  late final List<CreatorType> artist = List.unmodifiable(_getArtist());
  late final longStrip = _isLongStrip();
  late final List<CoverArtUrl> covers = List.unmodifiable(_getAllCoverArt());
  late final List<Manga> relatedMangas = List.unmodifiable(_getRelatedManga());

  List<CoverArtUrl> _getAllCoverArt() {
    final coverRelations = <CoverArtAttributes>[];

    if (relationships != null) {
      for (final r in relationships!) {
        final cr = switch (r) {
          CoverArt(:final attributes) => attributes,
          _ => null,
        };

        if (cr != null) {
          coverRelations.add(cr);
        }
      }
    }

    if (coverRelations.isNotEmpty) {
      final covers = <CoverArtUrl>[];

      for (final rel in coverRelations) {
        covers.add('https://uploads.mangadex.org/covers/$id/${rel.fileName}');
      }

      return covers;
    }

    return [];
  }

  String getFirstCoverUrl({CoverArtQuality quality = CoverArtQuality.best}) {
    if (covers.isEmpty) {
      return 'https://mangadex.org/img/cover-placeholder.jpg';
    }

    return covers.first.quality(quality: quality);
  }

  CoverArtUrl getUrlFromCover(
    CoverArt cover, {
    CoverArtQuality quality = CoverArtQuality.best,
  }) {
    final filename = cover.attributes?.fileName;

    if (filename == null) {
      return 'https://mangadex.org/img/cover-placeholder.jpg';
    }

    return 'https://uploads.mangadex.org/covers/$id/$filename'.quality(
      quality: quality,
    );
  }

  List<CreatorType> _getAuthor() {
    final authorRs = relationships?.whereType<Author>();

    if (authorRs != null && authorRs.isNotEmpty) {
      return authorRs.toList();
    }

    return [];
  }

  List<CreatorType> _getArtist() {
    final artistRs = relationships?.whereType<Artist>();

    if (artistRs != null && artistRs.isNotEmpty) {
      return artistRs.toList();
    }

    return [];
  }

  bool _isLongStrip() {
    if (attributes == null) {
      return false;
    }

    final tags = attributes!.tags;

    final lstag = tags.any(
      (e) =>
          e.attributes.group == TagGroup.format &&
          e.attributes.name.get('en') == "Long Strip",
    );

    return lstag;
  }

  List<Manga> _getRelatedManga() {
    final mangaRs = relationships?.whereType<Manga>();

    if (mangaRs != null && mangaRs.isNotEmpty) {
      return mangaRs.toList();
    }

    return [];
  }
}

mixin CustomListOps on MangaDexEntity {
  CustomListAttributes get attributes;
  List<MangaDexEntity> get relationships;

  late final set = Set.unmodifiable(_convertIDs());
  late final user = _getUser();

  Set<String> _convertIDs() {
    final rs = relationships.whereType<Manga>();

    if (rs.isNotEmpty) {
      return rs.map((e) => e.id).toSet();
    }

    return {};
  }

  User? _getUser() {
    final user = relationships.whereType<User>();

    if (user.isNotEmpty) {
      return user.first;
    }

    return null;
  }
}

@freezed
abstract class MangaLinks with _$MangaLinks {
  const factory MangaLinks({String? raw, String? al, String? mu, String? mal}) =
      _MangaLinks;

  factory MangaLinks.fromJson(Map<String, dynamic> json) =>
      _$MangaLinksFromJson(json);
}

@freezed
abstract class MangaAttributes with _$MangaAttributes {
  const factory MangaAttributes({
    required Map<String, String> title,
    required List<Map<String, String>> altTitles,
    required Map<String, String> description,
    MangaLinks? links,
    @LanguageConverter() required Language originalLanguage,
    String? lastVolume,
    String? lastChapter,
    MangaDemographic? publicationDemographic,
    required MangaStatus status,
    int? year,
    required ContentRating contentRating,
    required List<Tag> tags,
    required int version,
    @TimestampSerializer() required DateTime createdAt,
    @TimestampSerializer() required DateTime updatedAt,
  }) = _MangaAttributes;

  factory MangaAttributes.fromJson(Map<String, dynamic> json) =>
      _$MangaAttributesFromJson(json);
}

@freezed
abstract class ChapterAttributes with _$ChapterAttributes {
  const factory ChapterAttributes({
    String? title,
    String? volume,
    String? chapter,
    @LanguageConverter() required Language translatedLanguage,
    String? uploader,
    String? externalUrl,
    required int version,
    @TimestampSerializer() required DateTime createdAt,
    @TimestampSerializer() required DateTime updatedAt,
    @TimestampSerializer() required DateTime publishAt,
  }) = _ChapterAttributes;

  factory ChapterAttributes.fromJson(Map<String, dynamic> json) =>
      _$ChapterAttributesFromJson(json);
}

@freezed
abstract class ScanlationGroupAttributes with _$ScanlationGroupAttributes {
  const factory ScanlationGroupAttributes({
    required String name,
    String? website,
    String? discord,
    String? description,
  }) = _ScanlationGroupAttributes;

  factory ScanlationGroupAttributes.fromJson(Map<String, dynamic> json) =>
      _$ScanlationGroupAttributesFromJson(json);
}

@freezed
abstract class CoverArtAttributes with _$CoverArtAttributes {
  const factory CoverArtAttributes({
    String? volume,
    required String fileName,
    String? description,
    String? locale,
  }) = _CoverArtAttributes;

  factory CoverArtAttributes.fromJson(Map<String, dynamic> json) =>
      _$CoverArtAttributesFromJson(json);
}

@freezed
abstract class UserAttributes with _$UserAttributes {
  const factory UserAttributes({required String username}) = _UserAttributes;

  factory UserAttributes.fromJson(Map<String, dynamic> json) =>
      _$UserAttributesFromJson(json);
}

@freezed
abstract class AuthorAttributes with _$AuthorAttributes {
  const factory AuthorAttributes({
    required String name,
    String? imageUrl,
    required Map<String, String> biography,
    String? twitter,
    String? pixiv,
    String? youtube,
    String? website,
    @TimestampSerializer() required DateTime createdAt,
    @TimestampSerializer() required DateTime updatedAt,
  }) = _AuthorAttributes;

  factory AuthorAttributes.fromJson(Map<String, dynamic> json) =>
      _$AuthorAttributesFromJson(json);
}

@freezed
abstract class TagAttributes with _$TagAttributes {
  const factory TagAttributes({
    required Map<String, String> name,
    required Map<String, String> description,
    required TagGroup group,
  }) = _TagAttributes;

  factory TagAttributes.fromJson(Map<String, dynamic> json) =>
      _$TagAttributesFromJson(json);
}

@freezed
abstract class MangaStatisticsResponse with _$MangaStatisticsResponse {
  const factory MangaStatisticsResponse(
    Map<String, MangaStatistics> statistics,
  ) = _MangaStatisticsResponse;

  factory MangaStatisticsResponse.fromJson(Map<String, dynamic> json) =>
      _$MangaStatisticsResponseFromJson(json);
}

@freezed
abstract class ChapterStatisticsResponse with _$ChapterStatisticsResponse {
  const factory ChapterStatisticsResponse(
    Map<String, ChapterStatistics> statistics,
  ) = _ChapterStatisticsResponse;

  factory ChapterStatisticsResponse.fromJson(Map<String, dynamic> json) =>
      _$ChapterStatisticsResponseFromJson(json);
}

@freezed
abstract class MangaStatistics with _$MangaStatistics {
  const factory MangaStatistics({
    StatisticsDetailsComments? comments,
    required StatisticsDetailsRating rating,
    required int follows,
  }) = _MangaStatistics;

  factory MangaStatistics.fromJson(Map<String, dynamic> json) =>
      _$MangaStatisticsFromJson(json);
}

@freezed
abstract class ChapterStatistics with _$ChapterStatistics {
  const factory ChapterStatistics({StatisticsDetailsComments? comments}) =
      _ChapterStatistics;

  factory ChapterStatistics.fromJson(Map<String, dynamic> json) =>
      _$ChapterStatisticsFromJson(json);
}

@freezed
abstract class StatisticsDetailsComments with _$StatisticsDetailsComments {
  const factory StatisticsDetailsComments({
    required int threadId,
    required int repliesCount,
  }) = _StatisticsDetailsComments;

  factory StatisticsDetailsComments.fromJson(Map<String, dynamic> json) =>
      _$StatisticsDetailsCommentsFromJson(json);
}

@freezed
abstract class StatisticsDetailsRating with _$StatisticsDetailsRating {
  const factory StatisticsDetailsRating({
    double? average,
    required double bayesian,
  }) = _StatisticsDetailsRating;

  factory StatisticsDetailsRating.fromJson(Map<String, dynamic> json) =>
      _$StatisticsDetailsRatingFromJson(json);
}

@freezed
abstract class SelfRatingResponse with _$SelfRatingResponse {
  const factory SelfRatingResponse(Map<String, SelfRating> ratings) =
      _SelfRatingResponse;

  factory SelfRatingResponse.fromJson(Map<String, dynamic> json) =>
      _$SelfRatingResponseFromJson(json);
}

@freezed
abstract class SelfRating with _$SelfRating, ExpiringData {
  SelfRating._();

  factory SelfRating({
    required int rating,
    @TimestampSerializer() required DateTime createdAt,
  }) = _SelfRating;

  @override
  final expiry = DateTime.now().add(const Duration(minutes: 10));

  factory SelfRating.fromJson(Map<String, dynamic> json) =>
      _$SelfRatingFromJson(json);
}

@freezed
abstract class CustomListAttributes with _$CustomListAttributes {
  const factory CustomListAttributes({
    required String name,
    required CustomListVisibility visibility,
    required int version,
  }) = _CustomListAttributes;

  factory CustomListAttributes.fromJson(Map<String, dynamic> json) =>
      _$CustomListAttributesFromJson(json);
}

@freezed
abstract class ErrorResponse with _$ErrorResponse {
  const factory ErrorResponse(String result, List<MDError> errors) =
      _ErrorResponse;

  factory ErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$ErrorResponseFromJson(json);
}

@freezed
abstract class FrontPageData with _$FrontPageData {
  const factory FrontPageData({
    required String staffPicks,
    required String seasonal,
  }) = _FrontPageData;

  factory FrontPageData.fromJson(Map<String, dynamic> json) =>
      _$FrontPageDataFromJson(json);
}

class MangaDexException implements Exception {
  final String message;
  final List<MDError>? errors;

  const MangaDexException([this.message = "", this.errors]);

  @override
  String toString() {
    String report = "MangaDexException";

    Object? message = this.message;

    if (errors != null && errors!.isNotEmpty) {
      final e = errors!.first;
      report = '$report(${e.title}:${e.status})';

      if (e.detail != null) {
        message = e.detail;
      }
    }

    if (message != null && "" != message) {
      report = "$report: $message";
    }

    return report;
  }
}

class PageData {
  const PageData(this.baseUrl, this.pages);

  final String baseUrl;
  final List<String> pages;
}

class ChapterFeedItemData {
  ChapterFeedItemData({required this.manga});

  final Manga manga;

  String get mangaId => manga.id;
  late final id = generateKey();

  final List<Chapter> chapters = [];

  void clear() {
    chapters.clear();
  }

  int generateKey() {
    if (chapters.isNotEmpty) {
      return Object.hash(runtimeType, mangaId, chapters.first.id);
    }

    return Object.hash(runtimeType, mangaId);
  }
}

class ReadChapterSet with ExpiringData {
  ReadChapterSet(this.mangaId, this._chapters);

  final String mangaId;
  final Set<String> _chapters;

  static const _expiryDuration = Duration(minutes: 10);

  @override
  DateTime expiry = DateTime.now().add(_expiryDuration);

  DateTime updateExpiry() => expiry = DateTime.now().add(_expiryDuration);

  bool contains(String entry) => _chapters.contains(entry);
  bool containsAll(Iterable<String> entries) => _chapters.containsAll(entries);
  bool get isEmpty => _chapters.isEmpty;
  bool get isNotEmpty => _chapters.isNotEmpty;

  bool add(String entry) {
    bool result = _chapters.add(entry);
    updateExpiry();
    return result;
  }

  void addAll(Iterable<String> entry) {
    _chapters.addAll(entry);
    updateExpiry();
  }

  bool remove(String entry) {
    bool result = _chapters.remove(entry);
    updateExpiry();
    return result;
  }

  void removeAll(Iterable<String> entry) {
    _chapters.removeAll(entry);
    updateExpiry();
  }
}

enum MangaSetActions { replace, add, remove, none }

class MangaSetAction {
  final MangaSetActions action;
  final Set<String>? replacement;
  final String? element;

  MangaSetAction({required this.action, this.replacement, this.element})
    : assert(
        action == MangaSetActions.none
            ? (replacement == null || element == null)
            : (replacement != null || element != null),
      );

  static Set<String> modify(Set<String> state, MangaSetAction action) {
    switch (action.action) {
      case MangaSetActions.replace:
        return action.replacement!;
      case MangaSetActions.add:
        return {...state..add(action.element!)};
      case MangaSetActions.remove:
        return {...state..remove(action.element!)};
      case MangaSetActions.none:
        break;
    }

    return state;
  }
}
