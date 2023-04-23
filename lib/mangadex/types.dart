// ignore_for_file: constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gagaku/util.dart';

part 'types.freezed.dart';
part 'types.g.dart';

typedef LocalizedString = Map<String, String>;
typedef LibraryMap = Map<String, MangaReadingStatus>;

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

  static MangaDemographic parse(String key) {
    return MangaDemographic.values.firstWhere((element) => element.name == key);
  }
}

enum MangaStatus { completed, ongoing, cancelled, hiatus }

extension MangaStatusExt on MangaStatus {
  String get formatted => name.capitalize();
}

enum MangaReadingStatus {
  reading,
  on_hold,
  plan_to_read,
  dropped,
  re_reading,
  completed
}

extension MangaReadingStatusExt on MangaReadingStatus {
  String get formatted => const [
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

enum CoverArtQuality { best, medium, small }

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
  const factory Language({required String name, required String code}) =
      _Language;
}

class Languages {
  static const Map<String, Language> _languages = {
    'en': Language(name: 'English', code: 'en'),
    'pt-br': Language(name: 'Portuguese (BR)', code: 'pt-br'),
    'pt': Language(name: 'Portuguese', code: 'pt'),
    'ru': Language(name: 'Russian', code: 'ru'),
    'fr': Language(name: 'French', code: 'fr'),
    'es-la': Language(name: 'Spanish (LATAM)', code: 'es-la'),
    'es': Language(name: 'Spanish', code: 'es'),
    'pl': Language(name: 'Polish', code: 'pl'),
    'tr': Language(name: 'Turkish', code: 'tr'),
    'it': Language(name: 'Italian', code: 'it'),
    'id': Language(name: 'Indoneasian', code: 'id'),
    'vi': Language(name: 'Vietnam', code: 'vi'),
    'hu': Language(name: 'Hungarian', code: 'hu'),
    'zh': Language(name: 'Chinese (Simp.)', code: 'zh'),
    'zh-hk': Language(name: 'Chinese (Trad.)', code: 'zh-hk'),
    'ar': Language(name: 'Arabic', code: 'ar'),
    'de': Language(name: 'German', code: 'de'),
    'th': Language(name: 'Thai', code: 'th'),
    'ca': Language(name: 'Catalan', code: 'ca'),
    'bg': Language(name: 'Bulgarian', code: 'bg'),
    'fa': Language(name: 'Persian', code: 'fa'),
    'uk': Language(name: 'Ukrainian', code: 'uk'),
    'ro': Language(name: 'Romanian', code: 'ro'),
    'he': Language(name: 'Hebrew', code: 'he'),
    'mn': Language(name: 'Mongolian', code: 'mn'),
    'ms': Language(name: 'Malay', code: 'ms'),
    'tl': Language(name: 'Tagalog', code: 'tl'),
    'ja': Language(name: 'Japanese', code: 'ja'),
    'ko': Language(name: 'Korean', code: 'ko'),
    'hi': Language(name: 'Hindi', code: 'hi'),
    'my': Language(name: 'Burmese', code: 'my'),
    'cs': Language(name: 'Czech', code: 'cs'),
    'nl': Language(name: 'Dutch', code: 'nl'),
    'sv': Language(name: 'Swedish', code: 'sv'),
    'bn': Language(name: 'Bengali', code: 'bn'),
    'no': Language(name: 'Norwegian', code: 'no'),
    'lt': Language(name: 'Lithuanian', code: 'lt'),
    'el': Language(name: 'Greek', code: 'el'),
    'sr': Language(name: 'Serbo-Croatian', code: 'sr'),
    'da': Language(name: 'Danish', code: 'da'),
    'NULL': Language(name: 'Other', code: 'NULL'),
  };

  static Map<String, Language> get languages => _languages;

  static Language get(String code) {
    if (!_languages.containsKey(code)) {
      return _languages['NULL']!;
    }

    return _languages[code]!;
  }
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
class Chapter with _$Chapter {
  const Chapter._();

  const factory Chapter({
    required String id,
    required ChapterAttributes attributes,
    required List<Relationship> relationships,
  }) = _Chapter;

  factory Chapter.fromJson(Map<String, dynamic> json) =>
      _$ChapterFromJson(json);

  Iterable<String> getGroups() {
    var groups = relationships.where((element) => element.maybeWhen(
        group: (id, attributes) => true, orElse: () => false));

    var groupNames = <String>{};
    if (groups.isNotEmpty) {
      for (var g in groups) {
        groupNames.add(g.maybeWhen(
            group: (id, attributes) => attributes.name, orElse: () => ''));
      }

      return groupNames;
    }

    return ["No Group"];
  }

  String getMangaID() {
    var mangas = relationships.where((element) =>
        element.maybeWhen(manga: (id) => true, orElse: () => false));

    if (mangas.isNotEmpty) {
      var m = mangas.first.maybeWhen(manga: (id) => id, orElse: () => '');
      return m;
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
    required String fileName,
  }) = _CoverArtAttributes;

  factory CoverArtAttributes.fromJson(Map<String, dynamic> json) =>
      _$CoverArtAttributesFromJson(json);
}

@freezed
class NamedAttributes with _$NamedAttributes {
  const factory NamedAttributes({
    required String name,
  }) = _NamedAttributes;

  factory NamedAttributes.fromJson(Map<String, dynamic> json) =>
      _$NamedAttributesFromJson(json);
}

@Freezed(unionKey: 'type')
class Relationship with _$Relationship {
  const factory Relationship.manga({
    required String id,
  }) = RelationshipManga;

  const factory Relationship.user({
    required String id,
  }) = RelationshipUser;

  const factory Relationship.artist({
    required String id,
    required NamedAttributes attributes,
  }) = RelationshipArtist;

  const factory Relationship.author({
    required String id,
    required NamedAttributes attributes,
  }) = RelationshipAuthor;

  @FreezedUnionValue('cover_art')
  const factory Relationship.cover({
    required String id,
    required CoverArtAttributes attributes,
  }) = RelationshipCoverArt;

  @FreezedUnionValue('scanlation_group')
  const factory Relationship.group({
    required String id,
    required ScanlationGroupAttributes attributes,
  }) = RelationshipGroup;

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
class MangaList with _$MangaList {
  const factory MangaList(
    List<Manga> data,
    int total,
  ) = _MangaList;

  factory MangaList.fromJson(Map<String, dynamic> json) =>
      _$MangaListFromJson(json);
}

@freezed
class Manga with _$Manga {
  const Manga._();

  const factory Manga({
    required String id,
    required MangaAttributes attributes,
    required List<Relationship> relationships,
  }) = _Manga;

  factory Manga.fromJson(Map<String, dynamic> json) => _$MangaFromJson(json);

  String getCovertArtUrl({CoverArtQuality quality = CoverArtQuality.best}) {
    var coverArt =
        'https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/624px-No-Image-Placeholder.svg.png';

    var coverArtR = relationships.where((element) => element.maybeWhen(
        cover: (id, attributes) => true, orElse: () => false));

    if (coverArtR.isNotEmpty) {
      var rel = coverArtR.first
          .maybeWhen(cover: (id, attributes) => attributes, orElse: () => null);
      coverArt = "https://uploads.mangadex.org/covers/$id/${rel?.fileName}";

      switch (quality) {
        case CoverArtQuality.best:
          break;
        case CoverArtQuality.medium:
          coverArt += '.512.jpg';
          break;
        case CoverArtQuality.small:
          coverArt += '.256.jpg';
          break;
      }
    }

    return coverArt;
  }

  String? getAuthor() {
    var authorRs = relationships.where((element) => element.maybeWhen(
        author: (id, attributes) => true, orElse: () => false));

    if (authorRs.isNotEmpty) {
      var rel = authorRs.first.maybeWhen(
          author: (id, attributes) => attributes, orElse: () => null);

      return rel?.name;
    }

    return null;
  }

  String? getArtist() {
    var artistRs = relationships.where((element) => element.maybeWhen(
        artist: (id, attributes) => true, orElse: () => false));

    if (artistRs.isNotEmpty) {
      var rel = artistRs.first.maybeWhen(
          artist: (id, attributes) => attributes, orElse: () => null);

      return rel?.name;
    }

    return null;
  }
}

@freezed
class MangaAttributes with _$MangaAttributes {
  const factory MangaAttributes({
    required LocalizedString title,
    required List<LocalizedString> altTitles,
    required LocalizedString description,
    Map<String, String>? links,
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
class Tag with _$Tag {
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

class PageData {
  const PageData(this.baseUrl, this.pages);

  final String baseUrl;
  final List<String> pages;
}

// Deprecated old style login types
@freezed
class OldToken with _$OldToken {
  OldToken._();

  factory OldToken({
    required String session,
    required String refresh,
  }) = _OldToken;

  factory OldToken.fromJson(Map<String, dynamic> json) =>
      _$OldTokenFromJson(json);

  final DateTime createdAt = DateTime.now();

  bool get expired => (DateTime.now().difference(createdAt).inMinutes > 10);
  bool get isValid => (session.isNotEmpty && refresh.isNotEmpty);
}
