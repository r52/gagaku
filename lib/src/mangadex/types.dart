import 'package:flutter/foundation.dart';
import 'package:gagaku/src/util.dart';

typedef LocalizedString = Map<String, String>;

typedef LibraryMap = Map<String, MangaReadingStatus>;

enum ContentRating { safe, suggestive, erotica, pornographic }

extension ContentRatingExt on ContentRating {
  String get name => describeEnum(this);

  String get formatted => this.name.capitalize();

  static ContentRating parse(String key) {
    return ContentRating.values.firstWhere((element) => element.name == key);
  }
}

enum CoverArtQuality { best, medium, small }

enum MangaStatus { none, ongoing, completed, hiatus, cancelled }

extension MangaStatusExt on MangaStatus {
  String get name => describeEnum(this);

  String get formatted => this.name.capitalize();

  static MangaStatus parse(String key) {
    return MangaStatus.values.firstWhere((element) => element.name == key);
  }
}

enum MangaReadingStatus {
  none,
  reading,
  on_hold,
  plan_to_read,
  dropped,
  re_reading,
  completed
}

extension MangaReadingStatusExt on MangaReadingStatus {
  String get name => describeEnum(this);

  String get formatted => const [
        'Remove from Library',
        'Reading',
        'On Hold',
        'Plan to Read',
        'Dropped',
        'Re-reading',
        'Completed'
      ].elementAt(this.index);

  static MangaReadingStatus parse(String key) {
    return MangaReadingStatus.values
        .firstWhere((element) => element.name == key);
  }
}

class Language {
  final String name;
  final String code;

  const Language({required this.name, required this.code});

  @override
  String toString() {
    return code;
  }

  @override
  bool operator ==(Object other) =>
      other is Language &&
      other.runtimeType == runtimeType &&
      other.code == code;

  @override
  int get hashCode => code.hashCode;
}

class Languages {
  static const Map<String, Language> _languages = {
    'en': const Language(name: 'English', code: 'en'),
    'pt-br': const Language(name: 'Portuguese (BR)', code: 'pt-br'),
    'pt': const Language(name: 'Portuguese', code: 'pt'),
    'ru': const Language(name: 'Russian', code: 'ru'),
    'fr': const Language(name: 'French', code: 'fr'),
    'es-la': const Language(name: 'Spanish (LATAM)', code: 'es-la'),
    'es': const Language(name: 'Spanish', code: 'es'),
    'pl': const Language(name: 'Polish', code: 'pl'),
    'tr': const Language(name: 'Turkish', code: 'tr'),
    'it': const Language(name: 'Italian', code: 'it'),
    'id': const Language(name: 'Indoneasian', code: 'id'),
    'vi': const Language(name: 'Vietnam', code: 'vi'),
    'hu': const Language(name: 'Hungarian', code: 'hu'),
    'zh': const Language(name: 'Chinese (Simp.)', code: 'zh'),
    'zh-hk': const Language(name: 'Chinese (Trad.)', code: 'zh-hk'),
    'ar': const Language(name: 'Arabic', code: 'ar'),
    'de': const Language(name: 'German', code: 'de'),
    'th': const Language(name: 'Thai', code: 'th'),
    'ca': const Language(name: 'Catalan', code: 'ca'),
    'bg': const Language(name: 'Bulgarian', code: 'bg'),
    'fa': const Language(name: 'Persian', code: 'fa'),
    'uk': const Language(name: 'Ukrainian', code: 'uk'),
    'ro': const Language(name: 'Romanian', code: 'ro'),
    'he': const Language(name: 'Hebrew', code: 'he'),
    'mn': const Language(name: 'Mongolian', code: 'mn'),
    'ms': const Language(name: 'Malay', code: 'ms'),
    'tl': const Language(name: 'Tagalog', code: 'tl'),
    'ja': const Language(name: 'Japanese', code: 'ja'),
    'ko': const Language(name: 'Korean', code: 'ko'),
    'hi': const Language(name: 'Hindi', code: 'hi'),
    'my': const Language(name: 'Burmese', code: 'my'),
    'cs': const Language(name: 'Czech', code: 'cs'),
    'nl': const Language(name: 'Dutch', code: 'nl'),
    'sv': const Language(name: 'Swedish', code: 'sv'),
    'bn': const Language(name: 'Bengali', code: 'bn'),
    'no': const Language(name: 'Norwegian', code: 'no'),
    'lt': const Language(name: 'Lithuanian', code: 'lt'),
    'el': const Language(name: 'Greek', code: 'el'),
    'sr': const Language(name: 'Serbo-Croatian', code: 'sr'),
    'da': const Language(name: 'Danish', code: 'da'),
    'NULL': const Language(name: 'Other', code: 'NULL'),
  };

  static Map<String, Language> get languages => _languages;

  static Language get(String code) {
    return _languages[code]!;
  }
}

abstract class MangaDexAPIData {
  final String id;
  final String type;
  final int _cacheExpiration;

  int get cacheExpiration => _cacheExpiration;

  MangaDexAPIData._(this.id, this.type, this._cacheExpiration);

  @override
  bool operator ==(Object other) =>
      other is MangaDexAPIData &&
      other.runtimeType == runtimeType &&
      other.id == id;

  @override
  int get hashCode => id.hashCode;
}

class Chapter extends MangaDexAPIData {
  final String? volume;
  final String? chapter;
  final String? title;
  final String translatedLanguage;
  final String hash;
  final List<String> data;
  final List<String> dataSaver;
  final String? externalUrl;
  final int version;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime publishAt;

  final String mangaId;
  final String? userId;
  final String? groupId;
  final String groupName;

  bool read = false;

  Chapter(
      {required String id,
      this.volume,
      this.chapter,
      this.title,
      required this.translatedLanguage,
      required this.hash,
      required this.data,
      required this.dataSaver,
      this.externalUrl,
      required this.version,
      required this.createdAt,
      required this.updatedAt,
      required this.publishAt,
      required this.mangaId,
      this.userId,
      this.groupId,
      required this.groupName})
      : super._(id, 'chapter', 65535);

  factory Chapter.fromJson(Map<String, dynamic> data) {
    if (data['type'] == 'chapter') {
      Map<String, dynamic> attr = data['attributes'];

      String mangaId = '';
      String groupId = '';
      String groupName = 'No Group';
      String userId = '';

      List<Map<String, dynamic>> relations =
          List<Map<String, dynamic>>.from(data['relationships']);
      relations.forEach((r) {
        if (r['type'] == 'manga') {
          mangaId = r['id'];
        } else if (r['type'] == 'user') {
          userId = r['id'];
        } else if (r['type'] == 'scanlation_group') {
          groupId = r['id'];
          Map<String, dynamic> cattrs = r['attributes'];
          groupName = cattrs['name'];
        }
      });

      return Chapter(
          id: data['id'],
          volume: attr['volume'],
          chapter: attr['chapter'],
          title: attr['title'],
          translatedLanguage: attr['translatedLanguage'],
          hash: attr['hash'],
          data: List<String>.from(attr['data']),
          dataSaver: List<String>.from(attr['dataSaver']),
          externalUrl: attr['externalUrl'],
          publishAt: DateTime.parse(attr['publishAt']),
          createdAt: DateTime.parse(attr['publishAt']),
          updatedAt: DateTime.parse(attr['publishAt']),
          version: attr['version'],
          mangaId: mangaId,
          userId: userId,
          groupId: groupId,
          groupName: groupName);
    }

    throw ArgumentError('Unexpected data retrieval failure');
  }
}

class Manga extends MangaDexAPIData {
  final LocalizedString title;
  final List<LocalizedString> altTitles;
  final LocalizedString description;
  final Map<String, String>? links;
  final String originalLanguage;

  final String? lastVolume;
  final String? lastChapter;
  final String? publicationDemographic;
  final MangaStatus status;
  final int? year;
  final ContentRating contentRating;
  final List<Tag> tags;
  final int version;
  final DateTime createdAt;
  final DateTime updatedAt;

  final String? authorId;
  final String? author;
  final String? artistId;
  final String? artist;

  // Only store the primary cover returned by the API
  final String coverArt;

  // User data

  /// List of user's read chapters of this manga
  Set<String>? readChapters;

  /// List of readable chapters
  List<String>? chapters;

  /// User follows this manga?
  bool? userFollowing;

  MangaReadingStatus? userReadStatus;

  Manga(
      {required String id,
      required this.title,
      required this.altTitles,
      required this.description,
      this.links,
      required this.originalLanguage,
      this.lastVolume,
      this.lastChapter,
      this.publicationDemographic,
      required this.status,
      this.year,
      required this.contentRating,
      required this.tags,
      required this.version,
      required this.createdAt,
      required this.updatedAt,
      this.authorId,
      this.artistId,
      this.author,
      this.artist,
      required this.coverArt})
      : super._(id, 'manga', 30);

  factory Manga.fromJson(Map<String, dynamic> data) {
    if (data['type'] == 'manga') {
      Map<String, dynamic> attr = data['attributes'];

      // Tags
      List<Map<String, dynamic>> tagData =
          List<Map<String, dynamic>>.from(attr['tags']);

      var tags = tagData.map((e) => Tag.fromJson(e)).toList();

      String authorId = '';
      String artistId = '';
      String author = '';
      String artist = '';
      String coverArt = '';

      // Cover Art
      List<Map<String, dynamic>> relations =
          List<Map<String, dynamic>>.from(data['relationships']);
      relations.forEach((r) {
        if (r['type'] == 'author') {
          authorId = r['id'];
          Map<String, dynamic> caattrs = r['attributes'];
          author = caattrs['name'];
        } else if (r['type'] == 'artist') {
          artistId = r['id'];
          Map<String, dynamic> caattrs = r['attributes'];
          artist = caattrs['name'];
        } else if (r['type'] == 'cover_art') {
          Map<String, dynamic> caattrs = r['attributes'];
          coverArt = caattrs['fileName'];
        }
      });

      // Alt titles
      List<Map<String, dynamic>> alt =
          List<Map<String, dynamic>>.from(attr['altTitles']);
      List<LocalizedString> altTitles = alt
          .map((e) => Map.castFrom<String, dynamic, String, String>(e))
          .toList();

      var status = (attr['status'] != null
          ? MangaStatusExt.parse(attr['status'])
          : MangaStatus.none);

      var contentRating = ContentRatingExt.parse(attr['contentRating']);

      return Manga(
          id: data['id'],
          title: Map.castFrom(attr['title']),
          altTitles: altTitles,
          description: Map.castFrom(attr['description']),
          links: attr['links'] != null ? Map.castFrom(attr['links']) : null,
          originalLanguage: attr['originalLanguage'],
          lastVolume: attr['lastVolume'],
          lastChapter: attr['lastChapter'],
          publicationDemographic: attr['publicationDemographic'],
          status: status,
          year: attr['year'],
          contentRating: contentRating,
          tags: tags,
          createdAt: DateTime.parse(attr['createdAt']),
          updatedAt: DateTime.parse(attr['updatedAt']),
          version: attr['version'],
          authorId: authorId,
          artistId: artistId,
          author: author,
          artist: artist,
          coverArt: coverArt);
    }

    throw ArgumentError('Unexpected data retrieval failure');
  }

  String getCovertArtUrl({CoverArtQuality quality = CoverArtQuality.best}) {
    if (coverArt.isEmpty) {
      return 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/624px-No-Image-Placeholder.svg.png';
    }

    String url = "https://uploads.mangadex.org/covers/$id/$coverArt";

    switch (quality) {
      case CoverArtQuality.best:
        break;
      case CoverArtQuality.medium:
        url += '.512.jpg';
        break;
      case CoverArtQuality.small:
        url += '.256.jpg';
        break;
    }

    return url;
  }
}

class Tag extends MangaDexAPIData {
  final LocalizedString name;
  final String group;
  final int version;

  Tag(
      {required String id,
      required this.name,
      required this.group,
      required this.version})
      : super._(id, 'tag', 65535);

  factory Tag.fromJson(Map<String, dynamic> json) {
    if (json['type'] == 'tag') {
      Map<String, dynamic> attr = json['attributes'];

      return Tag(
        id: json['id'],
        name: Map.castFrom(attr['name']),
        group: attr['group'],
        version: attr['version'],
      );
    }

    throw ArgumentError('Unexpected data retrieval failure');
  }
}
