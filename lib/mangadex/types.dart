// ignore_for_file: constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gagaku/util.dart';

part 'types.freezed.dart';
part 'types.g.dart';

typedef LocalizedString = Map<String, String>;
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

extension LocalizedStringExt on LocalizedString {
  String get(String code) {
    return containsKey(code) ? this[code]! : entries.first.value;
  }
}

enum ContentRating {
  safe,
  suggestive,
  erotica,
  pornographic;

  String get label => name.capitalize();
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

  String get label => name.capitalize();
}

enum MangaReadingStatus {
  remove('Remove'),
  reading('Reading'),
  on_hold('On Hold'),
  plan_to_read('Plan to Read'),
  dropped('Dropped'),
  re_reading('Re-reading'),
  completed('Completed');

  const MangaReadingStatus(this.label);
  final String label;
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
  relevance_asc('Worst Match', MapEntry('order[relevance]', 'asc')),
  relevance_desc('Best Match', MapEntry('order[relevance]', 'desc')),
  followedCount_asc('Fewest Follows', MapEntry('order[followedCount]', 'asc')),
  followedCount_desc('Most Follows', MapEntry('order[followedCount]', 'desc')),
  latestUploadedChapter_asc(
      'Oldest Upload', MapEntry('order[latestUploadedChapter]', 'asc')),
  latestUploadedChapter_desc(
      'Latest Upload', MapEntry('order[latestUploadedChapter]', 'desc')),
  updatedAt_asc('Oldest Update', MapEntry('order[updatedAt]', 'asc')),
  updatedAt_desc('Latest Update', MapEntry('order[updatedAt]', 'desc')),
  createdAt_asc('Oldest Added', MapEntry('order[createdAt]', 'asc')),
  createdAt_desc('Recently Added', MapEntry('order[createdAt]', 'desc')),
  year_asc('Year Ascending', MapEntry('order[year]', 'asc')),
  year_desc('Year Descending', MapEntry('order[year]', 'desc')),
  title_asc('Title Ascending', MapEntry('order[title]', 'asc')),
  title_desc('Title Descending', MapEntry('order[title]', 'desc'));

  const FilterOrder(this.label, this.json);
  final String label;
  final MapEntry<String, dynamic> json;
}

enum CustomListVisibility { private, public }

enum MangaRelations {
  monochrome('Monochrome'),
  main_story('Main Story'),
  adapted_from('Adapted from'),
  based_on('Based on'),
  prequel('Prequel'),
  side_story('Side story'),
  doujinshi('Doujinshi'),
  same_franchise('Same franchise'),
  shared_universe('Shared universe'),
  sequel('Sequel'),
  spin_off('Spinoff'),
  alternate_story('Alternate story'),
  alternate_version('Alternate version'),
  preserialization('Pre-serialization'),
  colored('Colored'),
  serialization('Serialization');

  const MangaRelations(this.label);
  final String label;
}

enum TagMode {
  and,
  or;

  String get label => name.capitalize();
  String get code => name.toUpperCase();
}

@freezed
class MangaFilters with _$MangaFilters {
  const MangaFilters._();

  const factory MangaFilters({
    @Default({}) Set<Tag> includedTags,
    @Default(TagMode.and) TagMode includedTagsMode,
    @Default({}) Set<Tag> excludedTags,
    @Default(TagMode.or) TagMode excludedTagsMode,
    @Default({}) Set<MangaStatus> status,
    @Default({}) Set<MangaDemographic> publicationDemographic,
    @Default({}) Set<ContentRating> contentRating,
    @Default(FilterOrder.relevance_desc) FilterOrder order,
  }) = _MangaFilters;

  factory MangaFilters.fromJson(Map<String, dynamic> json) =>
      _$MangaFiltersFromJson(json);

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

    params.addEntries([order.json]);

    return params;
  }
}

@freezed
class MangaSearchParameters with _$MangaSearchParameters {
  const factory MangaSearchParameters({
    required String query,
    required MangaFilters filter,
  }) = _MangaSearchParameters;
}

class TimestampSerializer implements JsonConverter<DateTime, dynamic> {
  const TimestampSerializer();

  @override
  DateTime fromJson(dynamic timestamp) => DateTime.parse(timestamp);

  @override
  dynamic toJson(DateTime date) => date.toString();
}

class LanguageConverter implements JsonConverter<Language, dynamic> {
  const LanguageConverter();

  @override
  Language fromJson(dynamic lang) => Languages.get(lang);

  @override
  dynamic toJson(Language lang) => lang.code;
}

enum Language {
  en('English', 'en', '🇬🇧'),
  ar('Arabic', 'ar', '🇸🇦'),
  az('Azerbaijani', 'az', '🇦🇿'),
  bn('Bengali', 'bn', '🇧🇩'),
  bg('Bulgarian', 'bg', '🇧🇬'),
  my('Burmese', 'my', '🇲🇲'),
  ca('Catalan', 'ca', '🇦🇩'),
  zh('Chinese (Simp.)', 'zh', '🇨🇳'),
  zh_hk('Chinese (Trad.)', 'zh-hk', '🇭🇰'),
  hr('Croatian', 'hr', '🇭🇷'),
  cs('Czech', 'cs', '🇨🇿'),
  da('Danish', 'da', '🇩🇰'),
  nl('Dutch', 'nl', '🇳🇱'),
  eo('Esperanto', 'eo', '🇺🇳'),
  et('Estonian', 'et', '🇪🇪'),
  tl('Filipino', 'tl', '🇵🇭'),
  fi('Finnish', 'fi', '🇫🇮'),
  fr('French', 'fr', '🇫🇷'),
  ka('Georgian', 'ka', '🇬🇪'),
  de('German', 'de', '🇩🇪'),
  el('Greek', 'el', '🇬🇷'),
  he('Hebrew', 'he', '🇮🇱'),
  hi('Hindi', 'hi', '🇮🇳'),
  hu('Hungarian', 'hu', '🇭🇺'),
  id('Indonesian', 'id', '🇮🇩'),
  it('Italian', 'it', '🇮🇹'),
  ja('Japanese', 'ja', '🇯🇵'),
  kk('Kazakh', 'kk', '🇰🇿'),
  ko('Korean', 'ko', '🇰🇷'),
  la('Latin', 'la', '🇻🇦'),
  lt('Lithuanian', 'lt', '🇱🇹'),
  ms('Malay', 'ms', '🇲🇾'),
  mn('Mongolian', 'mn', '🇲🇳'),
  ne('Nepali', 'ne', '🇳🇵'),
  no('Norwegian', 'no', '🇳🇴'),
  fa('Persian', 'fa', '🇮🇷'),
  pl('Polish', 'pl', '🇵🇱'),
  pt_br('Portuguese (BR)', 'pt-br', '🇧🇷'),
  pt('Portuguese', 'pt', '🇵🇹'),
  ro('Romanian', 'ro', '🇷🇴'),
  ru('Russian', 'ru', '🇷🇺'),
  sr('Serbian', 'sr', '🇷🇸'),
  sk('Slovak', 'sk', '🇸🇰'),
  es('Spanish', 'es', '🇪🇸'),
  es_la('Spanish (LATAM)', 'es-la', '🇲🇽'),
  sv('Swedish', 'sv', '🇸🇪'),
  ta('Tamil', 'ta', '🇱🇰'),
  th('Thai', 'th', '🇹🇭'),
  tr('Turkish', 'tr', '🇹🇷'),
  uk('Ukrainian', 'uk', '🇺🇦'),
  vi('Vietnam', 'vi', '🇻🇳'),

  // Non-standard
  ja_ro('Japanese (Romanized)', 'ja-ro', 'jp', true),
  ko_ro('Korean (Romanized)', 'ko-ro', 'ko', true),
  zh_ro('Chinese (Romanized)', 'zh-ro', 'zh', true),
  other('Other', 'NULL', '🇺🇳', true);

  const Language(this.label, this.code, this.flag, [this.nonStandard = false]);
  final String label;
  final String code;
  final String flag;
  final bool nonStandard;
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

mixin MangaDexUUID {
  String get id;

  Map<String, dynamic> toJson();
}

@freezed
class ChapterList with _$ChapterList {
  const factory ChapterList(
    List<Chapter> data,
    int total,
  ) = _ChapterList;

  factory ChapterList.fromJson(Map<String, dynamic> json) =>
      _$ChapterListFromJson(json);
}

@freezed
class Chapter with _$Chapter, MangaDexUUID {
  const Chapter._();

  const factory Chapter({
    required String id,
    required ChapterAttributes attributes,
    required List<Relationship> relationships,
  }) = _Chapter;

  factory Chapter.fromJson(Map<String, dynamic> json) =>
      _$ChapterFromJson(json);

  String getTitle() {
    String title = '';

    if (attributes.chapter != null && attributes.chapter!.isNotEmpty) {
      title += 'Chapter ${attributes.chapter}';
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

  Iterable<Group> getGroups() {
    final groups = relationships.whereType<Group>();
    return groups;
  }

  Manga getManga() {
    final mangas = relationships.whereType<Manga>();

    if (mangas.isNotEmpty) {
      return mangas.first;
    }

    throw Exception('Chapter $id has no associated manga');
  }

  String getUploadUser() {
    final user = relationships.whereType<User>();

    if (user.isNotEmpty) {
      return user.first.attributes?.username ?? '';
    }

    return '';
  }
}

@freezed
class ChapterAttributes with _$ChapterAttributes {
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
class ScanlationGroupAttributes with _$ScanlationGroupAttributes {
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
class CoverArtAttributes with _$CoverArtAttributes {
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
class UserAttributes with _$UserAttributes {
  const factory UserAttributes({
    required String username,
  }) = _UserAttributes;

  factory UserAttributes.fromJson(Map<String, dynamic> json) =>
      _$UserAttributesFromJson(json);
}

@freezed
class AuthorAttributes with _$AuthorAttributes {
  const factory AuthorAttributes({
    required String name,
    String? imageUrl,
    required LocalizedString biography,
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

abstract class CreatorType with MangaDexUUID {
  AuthorAttributes get attributes;
}

@Freezed(unionKey: 'type')
class Relationship with _$Relationship, MangaDexUUID {
  @With<MangaOps>()
  factory Relationship.manga({
    required String id,
    MangaAttributes? attributes,
    List<Relationship>? relationships,
    MangaRelations? related,
  }) = Manga;

  const factory Relationship.user({
    required String id,
    UserAttributes? attributes,
  }) = User;

  @Implements<CreatorType>()
  const factory Relationship.artist({
    required String id,
    required AuthorAttributes attributes,
  }) = Artist;

  @Implements<CreatorType>()
  const factory Relationship.author({
    required String id,
    required AuthorAttributes attributes,
  }) = Author;

  const factory Relationship.creator({
    required String id,
  }) = CreatorID;

  @FreezedUnionValue('cover_art')
  const factory Relationship.cover({
    required String id,
    CoverArtAttributes? attributes,
  }) = CoverArt;

  @FreezedUnionValue('scanlation_group')
  const factory Relationship.group({
    required String id,
    required ScanlationGroupAttributes attributes,
  }) = Group;

  factory Relationship.fromJson(Map<String, dynamic> json) =>
      _$RelationshipFromJson(json);
}

@freezed
class ChapterAPIData with _$ChapterAPIData {
  const factory ChapterAPIData({
    required String hash,
    required List<String> data,
    required List<String> dataSaver,
  }) = _ChapterAPIData;

  factory ChapterAPIData.fromJson(Map<String, dynamic> json) =>
      _$ChapterAPIDataFromJson(json);
}

@freezed
class ChapterAPI with _$ChapterAPI {
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
class CoverList with _$CoverList {
  const factory CoverList(
    List<CoverArt> data,
    int total,
  ) = _CoverList;

  factory CoverList.fromJson(Map<String, dynamic> json) =>
      _$CoverListFromJson(json);
}

@freezed
class MangaList with _$MangaList {
  const factory MangaList(
    List<Manga> data,
    int total,
  ) = _MangaList;

  factory MangaList.fromJson(Map<String, dynamic> json) =>
      _$MangaListFromJson(json);
}

@freezed
class GroupList with _$GroupList {
  const factory GroupList(
    List<Group> data,
    int total,
  ) = _GroupList;

  factory GroupList.fromJson(Map<String, dynamic> json) =>
      _$GroupListFromJson(json);
}

@freezed
class CreatorList with _$CreatorList {
  const factory CreatorList(
    List<Author> data,
    int total,
  ) = _CreatorListList;

  factory CreatorList.fromJson(Map<String, dynamic> json) =>
      _$CreatorListFromJson(json);
}

mixin MangaOps {
  String get id;
  MangaAttributes? get attributes;
  List<Relationship>? get relationships;
  MangaRelations? get related;

  late final List<CreatorType>? author = getAuthor();
  late final List<CreatorType>? artist = getArtist();
  late final longStrip = isLongStrip();
  late final covers = getAllCoverArt();
  late final relatedMangas = getRelatedManga();

  List<CoverArtUrl> getAllCoverArt() {
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

  CoverArtUrl getUrlFromCover(CoverArt cover,
      {CoverArtQuality quality = CoverArtQuality.best}) {
    final filename = cover.attributes?.fileName;

    if (filename == null) {
      return 'https://mangadex.org/img/cover-placeholder.jpg';
    }

    return 'https://uploads.mangadex.org/covers/$id/$filename'
        .quality(quality: quality);
  }

  List<CreatorType>? getAuthor() {
    final authorRs = relationships?.whereType<Author>();

    if (authorRs != null && authorRs.isNotEmpty) {
      return authorRs.toList();
    }

    return null;
  }

  List<CreatorType>? getArtist() {
    final artistRs = relationships?.whereType<Artist>();

    if (artistRs != null && artistRs.isNotEmpty) {
      return artistRs.toList();
    }

    return null;
  }

  bool isLongStrip() {
    if (attributes == null) {
      return false;
    }

    final tags = attributes!.tags;

    final lstag = tags.any((e) =>
        e.attributes.group == TagGroup.format &&
        e.attributes.name.get('en') == "Long Strip");

    return lstag;
  }

  List<Manga> getRelatedManga() {
    final mangaRs = relationships?.whereType<Manga>();

    if (mangaRs != null && mangaRs.isNotEmpty) {
      return mangaRs.toList();
    }

    return [];
  }
}

@freezed
class MangaLinks with _$MangaLinks {
  const factory MangaLinks({
    String? raw,
    String? al,
    String? mu,
    String? mal,
  }) = _MangaLinks;

  factory MangaLinks.fromJson(Map<String, dynamic> json) =>
      _$MangaLinksFromJson(json);
}

@freezed
class MangaAttributes with _$MangaAttributes {
  const factory MangaAttributes({
    required LocalizedString title,
    required List<LocalizedString> altTitles,
    required LocalizedString description,
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
class Tag with _$Tag, MangaDexUUID {
  const factory Tag({
    required String id,
    required TagAttributes attributes,
  }) = _Tag;

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);
}

@freezed
class TagAttributes with _$TagAttributes {
  const factory TagAttributes({
    required LocalizedString name,
    required LocalizedString description,
    required TagGroup group,
  }) = _TagAttributes;

  factory TagAttributes.fromJson(Map<String, dynamic> json) =>
      _$TagAttributesFromJson(json);
}

@freezed
class TagResponse with _$TagResponse {
  const factory TagResponse(
    List<Tag> data,
    int total,
  ) = _TagResponse;

  factory TagResponse.fromJson(Map<String, dynamic> json) =>
      _$TagResponseFromJson(json);
}

@freezed
class MangaStatisticsResponse with _$MangaStatisticsResponse {
  const factory MangaStatisticsResponse(
    Map<String, MangaStatistics> statistics,
  ) = _MangaStatisticsResponse;

  factory MangaStatisticsResponse.fromJson(Map<String, dynamic> json) =>
      _$MangaStatisticsResponseFromJson(json);
}

@freezed
class MangaStatistics with _$MangaStatistics {
  const factory MangaStatistics({
    StatisticsDetailsComments? comments,
    required StatisticsDetailsRating rating,
    required int follows,
  }) = _MangaStatistics;

  factory MangaStatistics.fromJson(Map<String, dynamic> json) =>
      _$MangaStatisticsFromJson(json);
}

@freezed
class StatisticsDetailsComments with _$StatisticsDetailsComments {
  const factory StatisticsDetailsComments({
    required int threadId,
    required int repliesCount,
  }) = _StatisticsDetailsComments;

  factory StatisticsDetailsComments.fromJson(Map<String, dynamic> json) =>
      _$StatisticsDetailsCommentsFromJson(json);
}

@freezed
class StatisticsDetailsRating with _$StatisticsDetailsRating {
  const factory StatisticsDetailsRating({
    double? average,
    required double bayesian,
  }) = _StatisticsDetailsRating;

  factory StatisticsDetailsRating.fromJson(Map<String, dynamic> json) =>
      _$StatisticsDetailsRatingFromJson(json);
}

@freezed
class SelfRatingResponse with _$SelfRatingResponse {
  const factory SelfRatingResponse(
    Map<String, SelfRating> ratings,
  ) = _SelfRatingResponse;

  factory SelfRatingResponse.fromJson(Map<String, dynamic> json) =>
      _$SelfRatingResponseFromJson(json);
}

@freezed
class SelfRating with _$SelfRating, ExpiringData {
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
class CustomListList with _$CustomListList {
  const factory CustomListList(
    List<CustomList> data,
    int total,
  ) = _CustomListList;

  factory CustomListList.fromJson(Map<String, dynamic> json) =>
      _$CustomListListFromJson(json);
}

@freezed
class CustomList with _$CustomList, MangaDexUUID, ChangeNotifier {
  CustomList._();

  factory CustomList({
    required String id,
    required CustomListAttributes attributes,
    required List<Relationship> relationships,
  }) = _CustomList;

  late final set = _convertIDs();
  late final user = _getUser();

  factory CustomList.fromJson(Map<String, dynamic> json) =>
      _$CustomListFromJson(json);

  bool add(String mangaId) {
    final result = set.add(mangaId);
    notifyListeners();
    return result;
  }

  bool remove(String mangaId) {
    final result = set.remove(mangaId);
    notifyListeners();
    return result;
  }

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
class CustomListAttributes with _$CustomListAttributes {
  const factory CustomListAttributes({
    required String name,
    required CustomListVisibility visibility,
    required int version,
  }) = _CustomListAttributes;

  factory CustomListAttributes.fromJson(Map<String, dynamic> json) =>
      _$CustomListAttributesFromJson(json);
}

@freezed
class ErrorResponse with _$ErrorResponse {
  const factory ErrorResponse(
    String result,
    List<MDError> errors,
  ) = _ErrorResponse;

  factory ErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$ErrorResponseFromJson(json);
}

@freezed
class MDError with _$MDError {
  const factory MDError({
    required String id,
    required int status,
    required String title,
    String? detail,
    String? context,
  }) = _MDError;

  factory MDError.fromJson(Map<String, dynamic> json) =>
      _$MDErrorFromJson(json);
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
  String get coverArt =>
      manga.getFirstCoverUrl(quality: CoverArtQuality.medium);

  List<Chapter> chapters = [];

  void clear() {
    chapters.clear();
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
