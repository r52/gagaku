// ignore_for_file: constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gagaku/util.dart';

part 'types.freezed.dart';
part 'types.g.dart';

typedef LocalizedString = Map<String, String>;
typedef LibraryMap = Map<String, MangaReadingStatus>;
typedef ReadChaptersMap = Map<String, Set<String>>;
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

enum ContentRating { safe, suggestive, erotica, pornographic }

extension ContentRatingExt on ContentRating {
  String get formatted => name.capitalize();
}

enum MangaDemographic { shounen, shoujo, josei, seinen }

extension MangaDemographicExt on MangaDemographic {
  String get formatted => name.capitalize();
}

enum MangaStatus { completed, ongoing, cancelled, hiatus }

extension MangaStatusExt on MangaStatus {
  String get formatted => name.capitalize();
}

enum MangaReadingStatus {
  remove,
  reading,
  on_hold,
  plan_to_read,
  dropped,
  re_reading,
  completed
}

extension MangaReadingStatusExt on MangaReadingStatus {
  String get formatted => const [
        'Remove',
        'Reading',
        'On Hold',
        'Plan to Read',
        'Dropped',
        'Re-reading',
        'Completed'
      ].elementAt(index);

  static MangaReadingStatus parse(String key) {
    return MangaReadingStatus.values
        .firstWhere((element) => element.name == key);
  }
}

enum TagGroup { content, format, genre, theme }

extension TagGroupExt on TagGroup {
  String get formatted => name.capitalize();
}

enum CoverArtQuality { best, medium, small }

enum FilterOrder {
  relevance_asc,
  relevance_desc,
  followedCount_asc,
  followedCount_desc,
  latestUploadedChapter_asc,
  latestUploadedChapter_desc,
  updatedAt_asc,
  updatedAt_desc,
  createdAt_asc,
  createdAt_desc,
  year_asc,
  year_desc,
  title_asc,
  title_desc,
}

extension FilterOrderExt on FilterOrder {
  String get formatted => const [
        'Worst Match',
        'Best Match',
        'Fewest Follows',
        'Most Follows',
        'Oldest Upload',
        'Latest Upload',
        'Oldest Update',
        'Latest Update',
        'Oldest Added',
        'Recently Added',
        'Year Ascending',
        'Year Descending',
        'Title Ascending',
        'Title Descending',
      ].elementAt(index);

  MapEntry<String, Object> get entry => const [
        MapEntry('order[relevance]', 'asc'),
        MapEntry('order[relevance]', 'desc'),
        MapEntry('order[followedCount]', 'asc'),
        MapEntry('order[followedCount]', 'desc'),
        MapEntry('order[latestUploadedChapter]', 'asc'),
        MapEntry('order[latestUploadedChapter]', 'desc'),
        MapEntry('order[updatedAt]', 'asc'),
        MapEntry('order[updatedAt]', 'desc'),
        MapEntry('order[createdAt]', 'asc'),
        MapEntry('order[createdAt]', 'desc'),
        MapEntry('order[year]', 'asc'),
        MapEntry('order[year]', 'desc'),
        MapEntry('order[title]', 'asc'),
        MapEntry('order[title]', 'desc'),
      ].elementAt(index);
}

@freezed
class MangaFilters with _$MangaFilters {
  const MangaFilters._();

  const factory MangaFilters({
    @Default({}) Set<Tag> includedTags,
    @Default({}) Set<Tag> excludedTags,
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
    }

    if (excludedTags.isNotEmpty) {
      params['excludedTags[]'] = excludedTags.map((e) => e.id).toList();
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

    params.addEntries([order.entry]);

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

@freezed
class Language with _$Language {
  const factory Language({
    required String name,
    required String code,
    required String flag,
  }) = _Language;
}

class Languages {
  static const Map<String, Language> _languages = {
    'en': Language(name: 'English', code: 'en', flag: 'gb'),
    'pt-br': Language(name: 'Portuguese (BR)', code: 'pt-br', flag: 'br'),
    'pt': Language(name: 'Portuguese', code: 'pt', flag: 'pt'),
    'ru': Language(name: 'Russian', code: 'ru', flag: 'ru'),
    'fr': Language(name: 'French', code: 'fr', flag: 'fr'),
    'es-la': Language(name: 'Spanish (LATAM)', code: 'es-la', flag: 'mx'),
    'es': Language(name: 'Spanish', code: 'es', flag: 'es'),
    'pl': Language(name: 'Polish', code: 'pl', flag: 'pl'),
    'tr': Language(name: 'Turkish', code: 'tr', flag: 'tr'),
    'it': Language(name: 'Italian', code: 'it', flag: 'it'),
    'id': Language(name: 'Indonesian', code: 'id', flag: 'id'),
    'vi': Language(name: 'Vietnam', code: 'vi', flag: 'vn'),
    'hu': Language(name: 'Hungarian', code: 'hu', flag: 'hu'),
    'zh': Language(name: 'Chinese (Simp.)', code: 'zh', flag: 'cn'),
    'zh-hk': Language(name: 'Chinese (Trad.)', code: 'zh-hk', flag: 'hk'),
    'ar': Language(name: 'Arabic', code: 'ar', flag: 'sa'),
    'de': Language(name: 'German', code: 'de', flag: 'de'),
    'th': Language(name: 'Thai', code: 'th', flag: 'th'),
    'ca': Language(name: 'Catalan', code: 'ca', flag: 'ad'),
    'bg': Language(name: 'Bulgarian', code: 'bg', flag: 'bg'),
    'fa': Language(name: 'Persian', code: 'fa', flag: 'ir'),
    'uk': Language(name: 'Ukrainian', code: 'uk', flag: 'ua'),
    'ro': Language(name: 'Romanian', code: 'ro', flag: 'ro'),
    'he': Language(name: 'Hebrew', code: 'he', flag: 'il'),
    'mn': Language(name: 'Mongolian', code: 'mn', flag: 'mn'),
    'ms': Language(name: 'Malay', code: 'ms', flag: 'my'),
    'tl': Language(name: 'Tagalog', code: 'tl', flag: 'ph'),
    'ja': Language(name: 'Japanese', code: 'ja', flag: 'jp'),
    'ko': Language(name: 'Korean', code: 'ko', flag: 'kr'),
    'hi': Language(name: 'Hindi', code: 'hi', flag: 'c_in'),
    'my': Language(name: 'Burmese', code: 'my', flag: 'mm'),
    'cs': Language(name: 'Czech', code: 'cs', flag: 'cz'),
    'nl': Language(name: 'Dutch', code: 'nl', flag: 'nl'),
    'sv': Language(name: 'Swedish', code: 'sv', flag: 'se'),
    'bn': Language(name: 'Bengali', code: 'bn', flag: 'bd'),
    'no': Language(name: 'Norwegian', code: 'no', flag: 'no'),
    'lt': Language(name: 'Lithuanian', code: 'lt', flag: 'lt'),
    'el': Language(name: 'Greek', code: 'el', flag: 'gr'),
    'sr': Language(name: 'Serbo-Croatian', code: 'sr', flag: 'hr'),
    'da': Language(name: 'Danish', code: 'da', flag: 'dk'),
    'NULL': Language(name: 'Other', code: 'NULL', flag: 'Other'),
  };

  // Non-standard entries
  static const Map<String, Language> _extraLanguages = {
    'ja-ro': Language(name: 'Japanese (Romanized)', code: 'ja-ro', flag: 'jp'),
  };

  static Map<String, Language> get languages => _languages;

  static Language get(String code) {
    if (!_languages.containsKey(code) && !_extraLanguages.containsKey(code)) {
      return _languages['NULL']!;
    }

    if (_extraLanguages.containsKey(code)) {
      return _extraLanguages[code]!;
    }

    return _languages[code]!;
  }
}

mixin MangaDexUUID {
  String get id;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MangaDexUUID &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);
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

  Iterable<Group> getGroups() {
    final groups = <Group>{};

    for (final g in relationships) {
      switch (g) {
        case ScanlationGroup():
          groups.add(g);
          break;
        default:
          break;
      }
    }

    return groups;
  }

  String getMangaID() {
    final mangas = relationships.where((element) => switch (element) {
          RelationshipManga() => true,
          _ => false,
        });

    if (mangas.isNotEmpty) {
      final m = switch (mangas.first) {
        RelationshipManga(:final id) => id,
        _ => '',
      };
      return m;
    }

    return '';
  }

  String getUploadUser() {
    final user = relationships.where((element) => switch (element) {
          RelationshipUser() => true,
          _ => false,
        });

    if (user.isNotEmpty) {
      final u = switch (user.first) {
        RelationshipUser(:final attributes) => attributes.username,
        _ => '',
      };
      return u;
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

/// These classes are sued to expose the corresponding relationship union types
/// for riverpod/other generators, so that the union type being generated
/// doesn't need do be known during generation time.
abstract class Group with MangaDexUUID {
  ScanlationGroupAttributes get attributes;
}

abstract class Cover with MangaDexUUID {
  CoverArtAttributes? get attributes;
}

abstract class CreatorType with MangaDexUUID {
  AuthorAttributes get attributes;
}

/// END

@Freezed(unionKey: 'type')
class Relationship with _$Relationship, MangaDexUUID {
  const factory Relationship.manga({
    required String id,
  }) = RelationshipManga;

  const factory Relationship.user({
    required String id,
    required UserAttributes attributes,
  }) = RelationshipUser;

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
  }) = RelationshipCreator;

  @FreezedUnionValue('cover_art')
  @Implements<Cover>()
  const factory Relationship.cover({
    required String id,
    required CoverArtAttributes? attributes,
  }) = CoverArt;

  @FreezedUnionValue('scanlation_group')
  @Implements<Group>()
  const factory Relationship.group({
    required String id,
    required ScanlationGroupAttributes attributes,
  }) = ScanlationGroup;

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
class Manga with _$Manga, MangaDexUUID {
  Manga._();

  factory Manga({
    required String id,
    required MangaAttributes attributes,
    required List<Relationship> relationships,
  }) = _Manga;

  factory Manga.fromJson(Map<String, dynamic> json) => _$MangaFromJson(json);

  late final List<CreatorType>? author = getAuthor();
  late final List<CreatorType>? artist = getArtist();
  late final longStrip = isLongStrip();
  late final covers = getAllCoverArt();

  List<CoverArtUrl> getAllCoverArt() {
    final coverRelations = <CoverArtAttributes>[];

    for (final r in relationships) {
      final cr = switch (r) {
        CoverArt(:final attributes) => attributes,
        _ => null,
      };

      if (cr != null) {
        coverRelations.add(cr);
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

  CoverArtUrl getUrlFromCover(Cover cover,
      {CoverArtQuality quality = CoverArtQuality.best}) {
    final filename = cover.attributes?.fileName;

    if (filename == null) {
      return 'https://mangadex.org/img/cover-placeholder.jpg';
    }

    return 'https://uploads.mangadex.org/covers/$id/$filename'
        .quality(quality: quality);
  }

  List<CreatorType>? getAuthor() {
    final authorRs = relationships.where((element) => switch (element) {
          Author() => true,
          _ => false,
        });

    if (authorRs.isNotEmpty) {
      return authorRs.map((e) => e as Author).toList();
    }

    return null;
  }

  List<CreatorType>? getArtist() {
    final artistRs = relationships.where((element) => switch (element) {
          Artist() => true,
          _ => false,
        });

    if (artistRs.isNotEmpty) {
      return artistRs.map((e) => e as Artist).toList();
    }

    return null;
  }

  bool isLongStrip() {
    final tags = attributes.tags;

    final lstag = tags.where((e) =>
        e.attributes.group == TagGroup.format &&
        e.attributes.name.get('en') == "Long Strip");

    if (lstag.isNotEmpty) {
      return true;
    }

    return false;
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
class SelfRating with _$SelfRating {
  factory SelfRating({
    required int rating,
    @TimestampSerializer() required DateTime createdAt,
  }) = _SelfRating;

  factory SelfRating.fromJson(Map<String, dynamic> json) =>
      _$SelfRatingFromJson(json);
}

class PageData {
  const PageData(this.baseUrl, this.pages);

  final String baseUrl;
  final List<String> pages;
}

class ChapterFeedItemData {
  ChapterFeedItemData({required this.manga})
      : mangaId = manga.id,
        coverArt = manga.getFirstCoverUrl(quality: CoverArtQuality.medium);

  final Manga manga;
  final String mangaId;
  final String coverArt;

  List<Chapter> chapters = [];
}

// Deprecated old style login types
@freezed
class OldToken with _$OldToken {
  OldToken._();

  static const int expiryTime = 600; // seconds (10 minutes)

  factory OldToken({
    required String session,
    required String refresh,
  }) = _OldToken;

  factory OldToken.fromJson(Map<String, dynamic> json) =>
      _$OldTokenFromJson(json);

  final DateTime expiresAt =
      DateTime.now().add(const Duration(seconds: expiryTime));

  Duration get timeUntilExpiry => expiresAt.difference(DateTime.now());
  bool get expired => (DateTime.now().compareTo(expiresAt) >= 0);
  bool get isValid => (session.isNotEmpty && refresh.isNotEmpty);
}
