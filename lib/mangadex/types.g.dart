// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'types.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MangaFilters _$$_MangaFiltersFromJson(Map<String, dynamic> json) =>
    _$_MangaFilters(
      includedTags: (json['includedTags'] as List<dynamic>?)
              ?.map((e) => Tag.fromJson(e as Map<String, dynamic>))
              .toSet() ??
          const {},
      excludedTags: (json['excludedTags'] as List<dynamic>?)
              ?.map((e) => Tag.fromJson(e as Map<String, dynamic>))
              .toSet() ??
          const {},
      status: (json['status'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$MangaStatusEnumMap, e))
              .toSet() ??
          const {},
      publicationDemographic: (json['publicationDemographic'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$MangaDemographicEnumMap, e))
              .toSet() ??
          const {},
      contentRating: (json['contentRating'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$ContentRatingEnumMap, e))
              .toSet() ??
          const {},
      order: $enumDecodeNullable(_$FilterOrderEnumMap, json['order']) ??
          FilterOrder.relevance_desc,
    );

Map<String, dynamic> _$$_MangaFiltersToJson(_$_MangaFilters instance) =>
    <String, dynamic>{
      'includedTags': instance.includedTags.toList(),
      'excludedTags': instance.excludedTags.toList(),
      'status': instance.status.map((e) => _$MangaStatusEnumMap[e]!).toList(),
      'publicationDemographic': instance.publicationDemographic
          .map((e) => _$MangaDemographicEnumMap[e]!)
          .toList(),
      'contentRating': instance.contentRating
          .map((e) => _$ContentRatingEnumMap[e]!)
          .toList(),
      'order': _$FilterOrderEnumMap[instance.order]!,
    };

const _$MangaStatusEnumMap = {
  MangaStatus.completed: 'completed',
  MangaStatus.ongoing: 'ongoing',
  MangaStatus.cancelled: 'cancelled',
  MangaStatus.hiatus: 'hiatus',
};

const _$MangaDemographicEnumMap = {
  MangaDemographic.shounen: 'shounen',
  MangaDemographic.shoujo: 'shoujo',
  MangaDemographic.josei: 'josei',
  MangaDemographic.seinen: 'seinen',
};

const _$ContentRatingEnumMap = {
  ContentRating.safe: 'safe',
  ContentRating.suggestive: 'suggestive',
  ContentRating.erotica: 'erotica',
  ContentRating.pornographic: 'pornographic',
};

const _$FilterOrderEnumMap = {
  FilterOrder.relevance_asc: 'relevance_asc',
  FilterOrder.relevance_desc: 'relevance_desc',
  FilterOrder.followedCount_asc: 'followedCount_asc',
  FilterOrder.followedCount_desc: 'followedCount_desc',
  FilterOrder.latestUploadedChapter_asc: 'latestUploadedChapter_asc',
  FilterOrder.latestUploadedChapter_desc: 'latestUploadedChapter_desc',
  FilterOrder.updatedAt_asc: 'updatedAt_asc',
  FilterOrder.updatedAt_desc: 'updatedAt_desc',
  FilterOrder.createdAt_asc: 'createdAt_asc',
  FilterOrder.createdAt_desc: 'createdAt_desc',
  FilterOrder.year_asc: 'year_asc',
  FilterOrder.year_desc: 'year_desc',
  FilterOrder.title_asc: 'title_asc',
  FilterOrder.title_desc: 'title_desc',
};

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
      volume: json['volume'] as String?,
      fileName: json['fileName'] as String,
    );

Map<String, dynamic> _$$_CoverArtAttributesToJson(
        _$_CoverArtAttributes instance) =>
    <String, dynamic>{
      'volume': instance.volume,
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

_$_UserAttributes _$$_UserAttributesFromJson(Map<String, dynamic> json) =>
    _$_UserAttributes(
      username: json['username'] as String,
    );

Map<String, dynamic> _$$_UserAttributesToJson(_$_UserAttributes instance) =>
    <String, dynamic>{
      'username': instance.username,
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
      attributes:
          UserAttributes.fromJson(json['attributes'] as Map<String, dynamic>),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$RelationshipUserToJson(_$RelationshipUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'attributes': instance.attributes,
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

_$RelationshipCreator _$$RelationshipCreatorFromJson(
        Map<String, dynamic> json) =>
    _$RelationshipCreator(
      id: json['id'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$RelationshipCreatorToJson(
        _$RelationshipCreator instance) =>
    <String, dynamic>{
      'id': instance.id,
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

_$_Group _$$_GroupFromJson(Map<String, dynamic> json) => _$_Group(
      id: json['id'] as String,
      attributes: ScanlationGroupAttributes.fromJson(
          json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_GroupToJson(_$_Group instance) => <String, dynamic>{
      'id': instance.id,
      'attributes': instance.attributes,
    };

_$_Cover _$$_CoverFromJson(Map<String, dynamic> json) => _$_Cover(
      id: json['id'] as String,
      attributes: CoverArtAttributes.fromJson(
          json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_CoverToJson(_$_Cover instance) => <String, dynamic>{
      'id': instance.id,
      'attributes': instance.attributes,
    };

_$_CoverList _$$_CoverListFromJson(Map<String, dynamic> json) => _$_CoverList(
      (json['data'] as List<dynamic>)
          .map((e) => Cover.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['total'] as int,
    );

Map<String, dynamic> _$$_CoverListToJson(_$_CoverList instance) =>
    <String, dynamic>{
      'data': instance.data,
      'total': instance.total,
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

_$_MangaLinks _$$_MangaLinksFromJson(Map<String, dynamic> json) =>
    _$_MangaLinks(
      raw: json['raw'] as String?,
      al: json['al'] as String?,
      mu: json['mu'] as String?,
      mal: json['mal'] as String?,
    );

Map<String, dynamic> _$$_MangaLinksToJson(_$_MangaLinks instance) =>
    <String, dynamic>{
      'raw': instance.raw,
      'al': instance.al,
      'mu': instance.mu,
      'mal': instance.mal,
    };

_$_MangaAttributes _$$_MangaAttributesFromJson(Map<String, dynamic> json) =>
    _$_MangaAttributes(
      title: Map<String, String>.from(json['title'] as Map),
      altTitles: (json['altTitles'] as List<dynamic>)
          .map((e) => Map<String, String>.from(e as Map))
          .toList(),
      description: Map<String, String>.from(json['description'] as Map),
      links: json['links'] == null
          ? null
          : MangaLinks.fromJson(json['links'] as Map<String, dynamic>),
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

_$_TagResponse _$$_TagResponseFromJson(Map<String, dynamic> json) =>
    _$_TagResponse(
      (json['data'] as List<dynamic>)
          .map((e) => Tag.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['total'] as int,
    );

Map<String, dynamic> _$$_TagResponseToJson(_$_TagResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'total': instance.total,
    };

_$_MangaStatisticsResponse _$$_MangaStatisticsResponseFromJson(
        Map<String, dynamic> json) =>
    _$_MangaStatisticsResponse(
      (json['statistics'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, MangaStatistics.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$$_MangaStatisticsResponseToJson(
        _$_MangaStatisticsResponse instance) =>
    <String, dynamic>{
      'statistics': instance.statistics,
    };

_$_MangaStatistics _$$_MangaStatisticsFromJson(Map<String, dynamic> json) =>
    _$_MangaStatistics(
      comments: json['comments'] == null
          ? null
          : StatisticsDetailsComments.fromJson(
              json['comments'] as Map<String, dynamic>),
      rating: StatisticsDetailsRating.fromJson(
          json['rating'] as Map<String, dynamic>),
      follows: json['follows'] as int,
    );

Map<String, dynamic> _$$_MangaStatisticsToJson(_$_MangaStatistics instance) =>
    <String, dynamic>{
      'comments': instance.comments,
      'rating': instance.rating,
      'follows': instance.follows,
    };

_$_StatisticsDetailsComments _$$_StatisticsDetailsCommentsFromJson(
        Map<String, dynamic> json) =>
    _$_StatisticsDetailsComments(
      threadId: json['threadId'] as int,
      repliesCount: json['repliesCount'] as int,
    );

Map<String, dynamic> _$$_StatisticsDetailsCommentsToJson(
        _$_StatisticsDetailsComments instance) =>
    <String, dynamic>{
      'threadId': instance.threadId,
      'repliesCount': instance.repliesCount,
    };

_$_StatisticsDetailsRating _$$_StatisticsDetailsRatingFromJson(
        Map<String, dynamic> json) =>
    _$_StatisticsDetailsRating(
      average: (json['average'] as num?)?.toDouble(),
      bayesian: (json['bayesian'] as num).toDouble(),
    );

Map<String, dynamic> _$$_StatisticsDetailsRatingToJson(
        _$_StatisticsDetailsRating instance) =>
    <String, dynamic>{
      'average': instance.average,
      'bayesian': instance.bayesian,
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
