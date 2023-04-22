// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'types.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ChapterList _$$_ChapterListFromJson(Map<String, dynamic> json) =>
    _$_ChapterList(
      (json['data'] as List<dynamic>)
          .map((e) => Chapter.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['total'] as int,
    );

Map<String, dynamic> _$$_ChapterListToJson(_$_ChapterList instance) =>
    <String, dynamic>{
      'data': instance.data,
      'total': instance.total,
    };

_$_Chapter _$$_ChapterFromJson(Map<String, dynamic> json) => _$_Chapter(
      id: json['id'] as String,
      attributes: ChapterAttributes.fromJson(
          json['attributes'] as Map<String, dynamic>),
      relationships: (json['relationships'] as List<dynamic>)
          .map((e) => Relationship.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_ChapterToJson(_$_Chapter instance) =>
    <String, dynamic>{
      'id': instance.id,
      'attributes': instance.attributes,
      'relationships': instance.relationships,
    };

_$_ChapterAttributes _$$_ChapterAttributesFromJson(Map<String, dynamic> json) =>
    _$_ChapterAttributes(
      title: json['title'] as String?,
      volume: json['volume'] as String?,
      chapter: json['chapter'] as String?,
      translatedLanguage:
          const LanguageConverter().fromJson(json['translatedLanguage']),
      uploader: json['uploader'] as String?,
      externalUrl: json['externalUrl'] as String?,
      version: json['version'] as int,
      createdAt: const TimestampSerializer().fromJson(json['createdAt']),
      updatedAt: const TimestampSerializer().fromJson(json['updatedAt']),
      publishAt: const TimestampSerializer().fromJson(json['publishAt']),
    );

Map<String, dynamic> _$$_ChapterAttributesToJson(
        _$_ChapterAttributes instance) =>
    <String, dynamic>{
      'title': instance.title,
      'volume': instance.volume,
      'chapter': instance.chapter,
      'translatedLanguage':
          const LanguageConverter().toJson(instance.translatedLanguage),
      'uploader': instance.uploader,
      'externalUrl': instance.externalUrl,
      'version': instance.version,
      'createdAt': const TimestampSerializer().toJson(instance.createdAt),
      'updatedAt': const TimestampSerializer().toJson(instance.updatedAt),
      'publishAt': const TimestampSerializer().toJson(instance.publishAt),
    };

_$_ScanlationGroupAttributes _$$_ScanlationGroupAttributesFromJson(
        Map<String, dynamic> json) =>
    _$_ScanlationGroupAttributes(
      name: json['name'] as String,
      website: json['website'] as String?,
      discord: json['discord'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$$_ScanlationGroupAttributesToJson(
        _$_ScanlationGroupAttributes instance) =>
    <String, dynamic>{
      'name': instance.name,
      'website': instance.website,
      'discord': instance.discord,
      'description': instance.description,
    };

_$_CoverArtAttributes _$$_CoverArtAttributesFromJson(
        Map<String, dynamic> json) =>
    _$_CoverArtAttributes(
      fileName: json['fileName'] as String,
    );

Map<String, dynamic> _$$_CoverArtAttributesToJson(
        _$_CoverArtAttributes instance) =>
    <String, dynamic>{
      'fileName': instance.fileName,
    };

_$_NamedAttributes _$$_NamedAttributesFromJson(Map<String, dynamic> json) =>
    _$_NamedAttributes(
      name: json['name'] as String,
    );

Map<String, dynamic> _$$_NamedAttributesToJson(_$_NamedAttributes instance) =>
    <String, dynamic>{
      'name': instance.name,
    };

_$RelationshipManga _$$RelationshipMangaFromJson(Map<String, dynamic> json) =>
    _$RelationshipManga(
      id: json['id'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$RelationshipMangaToJson(_$RelationshipManga instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.$type,
    };

_$RelationshipUser _$$RelationshipUserFromJson(Map<String, dynamic> json) =>
    _$RelationshipUser(
      id: json['id'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$RelationshipUserToJson(_$RelationshipUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.$type,
    };

_$RelationshipArtist _$$RelationshipArtistFromJson(Map<String, dynamic> json) =>
    _$RelationshipArtist(
      id: json['id'] as String,
      attributes:
          NamedAttributes.fromJson(json['attributes'] as Map<String, dynamic>),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$RelationshipArtistToJson(
        _$RelationshipArtist instance) =>
    <String, dynamic>{
      'id': instance.id,
      'attributes': instance.attributes,
      'type': instance.$type,
    };

_$RelationshipAuthor _$$RelationshipAuthorFromJson(Map<String, dynamic> json) =>
    _$RelationshipAuthor(
      id: json['id'] as String,
      attributes:
          NamedAttributes.fromJson(json['attributes'] as Map<String, dynamic>),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$RelationshipAuthorToJson(
        _$RelationshipAuthor instance) =>
    <String, dynamic>{
      'id': instance.id,
      'attributes': instance.attributes,
      'type': instance.$type,
    };

_$RelationshipCoverArt _$$RelationshipCoverArtFromJson(
        Map<String, dynamic> json) =>
    _$RelationshipCoverArt(
      id: json['id'] as String,
      attributes: CoverArtAttributes.fromJson(
          json['attributes'] as Map<String, dynamic>),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$RelationshipCoverArtToJson(
        _$RelationshipCoverArt instance) =>
    <String, dynamic>{
      'id': instance.id,
      'attributes': instance.attributes,
      'type': instance.$type,
    };

_$RelationshipGroup _$$RelationshipGroupFromJson(Map<String, dynamic> json) =>
    _$RelationshipGroup(
      id: json['id'] as String,
      attributes: ScanlationGroupAttributes.fromJson(
          json['attributes'] as Map<String, dynamic>),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$RelationshipGroupToJson(_$RelationshipGroup instance) =>
    <String, dynamic>{
      'id': instance.id,
      'attributes': instance.attributes,
      'type': instance.$type,
    };

_$_ChapterAPIData _$$_ChapterAPIDataFromJson(Map<String, dynamic> json) =>
    _$_ChapterAPIData(
      hash: json['hash'] as String,
      data: (json['data'] as List<dynamic>).map((e) => e as String).toList(),
      dataSaver:
          (json['dataSaver'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$_ChapterAPIDataToJson(_$_ChapterAPIData instance) =>
    <String, dynamic>{
      'hash': instance.hash,
      'data': instance.data,
      'dataSaver': instance.dataSaver,
    };

_$_ChapterAPI _$$_ChapterAPIFromJson(Map<String, dynamic> json) =>
    _$_ChapterAPI(
      baseUrl: json['baseUrl'] as String,
      chapter: ChapterAPIData.fromJson(json['chapter'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_ChapterAPIToJson(_$_ChapterAPI instance) =>
    <String, dynamic>{
      'baseUrl': instance.baseUrl,
      'chapter': instance.chapter,
    };

_$_MangaList _$$_MangaListFromJson(Map<String, dynamic> json) => _$_MangaList(
      (json['data'] as List<dynamic>)
          .map((e) => Manga.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['total'] as int,
    );

Map<String, dynamic> _$$_MangaListToJson(_$_MangaList instance) =>
    <String, dynamic>{
      'data': instance.data,
      'total': instance.total,
    };

_$_Manga _$$_MangaFromJson(Map<String, dynamic> json) => _$_Manga(
      id: json['id'] as String,
      attributes:
          MangaAttributes.fromJson(json['attributes'] as Map<String, dynamic>),
      relationships: (json['relationships'] as List<dynamic>)
          .map((e) => Relationship.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_MangaToJson(_$_Manga instance) => <String, dynamic>{
      'id': instance.id,
      'attributes': instance.attributes,
      'relationships': instance.relationships,
    };

_$_MangaAttributes _$$_MangaAttributesFromJson(Map<String, dynamic> json) =>
    _$_MangaAttributes(
      title: Map<String, String>.from(json['title'] as Map),
      altTitles: (json['altTitles'] as List<dynamic>)
          .map((e) => Map<String, String>.from(e as Map))
          .toList(),
      description: Map<String, String>.from(json['description'] as Map),
      links: (json['links'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      originalLanguage:
          const LanguageConverter().fromJson(json['originalLanguage']),
      lastVolume: json['lastVolume'] as String?,
      lastChapter: json['lastChapter'] as String?,
      publicationDemographic: $enumDecodeNullable(
          _$MangaDemographicEnumMap, json['publicationDemographic']),
      status: $enumDecode(_$MangaStatusEnumMap, json['status']),
      year: json['year'] as int?,
      contentRating: $enumDecode(_$ContentRatingEnumMap, json['contentRating']),
      tags: (json['tags'] as List<dynamic>)
          .map((e) => Tag.fromJson(e as Map<String, dynamic>))
          .toList(),
      version: json['version'] as int,
      createdAt: const TimestampSerializer().fromJson(json['createdAt']),
      updatedAt: const TimestampSerializer().fromJson(json['updatedAt']),
    );

Map<String, dynamic> _$$_MangaAttributesToJson(_$_MangaAttributes instance) =>
    <String, dynamic>{
      'title': instance.title,
      'altTitles': instance.altTitles,
      'description': instance.description,
      'links': instance.links,
      'originalLanguage':
          const LanguageConverter().toJson(instance.originalLanguage),
      'lastVolume': instance.lastVolume,
      'lastChapter': instance.lastChapter,
      'publicationDemographic':
          _$MangaDemographicEnumMap[instance.publicationDemographic],
      'status': _$MangaStatusEnumMap[instance.status]!,
      'year': instance.year,
      'contentRating': _$ContentRatingEnumMap[instance.contentRating]!,
      'tags': instance.tags,
      'version': instance.version,
      'createdAt': const TimestampSerializer().toJson(instance.createdAt),
      'updatedAt': const TimestampSerializer().toJson(instance.updatedAt),
    };

const _$MangaDemographicEnumMap = {
  MangaDemographic.shounen: 'shounen',
  MangaDemographic.shoujo: 'shoujo',
  MangaDemographic.josei: 'josei',
  MangaDemographic.seinen: 'seinen',
};

const _$MangaStatusEnumMap = {
  MangaStatus.completed: 'completed',
  MangaStatus.ongoing: 'ongoing',
  MangaStatus.cancelled: 'cancelled',
  MangaStatus.hiatus: 'hiatus',
};

const _$ContentRatingEnumMap = {
  ContentRating.safe: 'safe',
  ContentRating.suggestive: 'suggestive',
  ContentRating.erotica: 'erotica',
  ContentRating.pornographic: 'pornographic',
};

_$_Tag _$$_TagFromJson(Map<String, dynamic> json) => _$_Tag(
      id: json['id'] as String,
      attributes:
          TagAttributes.fromJson(json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_TagToJson(_$_Tag instance) => <String, dynamic>{
      'id': instance.id,
      'attributes': instance.attributes,
    };

_$_TagAttributes _$$_TagAttributesFromJson(Map<String, dynamic> json) =>
    _$_TagAttributes(
      name: Map<String, String>.from(json['name'] as Map),
      description: Map<String, String>.from(json['description'] as Map),
      group: $enumDecode(_$TagGroupEnumMap, json['group']),
    );

Map<String, dynamic> _$$_TagAttributesToJson(_$_TagAttributes instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'group': _$TagGroupEnumMap[instance.group]!,
    };

const _$TagGroupEnumMap = {
  TagGroup.content: 'content',
  TagGroup.format: 'format',
  TagGroup.genre: 'genre',
  TagGroup.theme: 'theme',
};

_$_OldToken _$$_OldTokenFromJson(Map<String, dynamic> json) => _$_OldToken(
      session: json['session'] as String,
      refresh: json['refresh'] as String,
    );

Map<String, dynamic> _$$_OldTokenToJson(_$_OldToken instance) =>
    <String, dynamic>{
      'session': instance.session,
      'refresh': instance.refresh,
    };