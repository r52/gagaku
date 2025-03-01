// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'types.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MangaFilters _$MangaFiltersFromJson(Map<String, dynamic> json) =>
    _MangaFilters(
      includedTags:
          (json['includedTags'] as List<dynamic>?)
              ?.map((e) => Tag.fromJson(e as Map<String, dynamic>))
              .toSet() ??
          const {},
      includedTagsMode:
          $enumDecodeNullable(_$TagModeEnumMap, json['includedTagsMode']) ??
          TagMode.and,
      excludedTags:
          (json['excludedTags'] as List<dynamic>?)
              ?.map((e) => Tag.fromJson(e as Map<String, dynamic>))
              .toSet() ??
          const {},
      excludedTagsMode:
          $enumDecodeNullable(_$TagModeEnumMap, json['excludedTagsMode']) ??
          TagMode.or,
      status:
          (json['status'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$MangaStatusEnumMap, e))
              .toSet() ??
          const {},
      publicationDemographic:
          (json['publicationDemographic'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$MangaDemographicEnumMap, e))
              .toSet() ??
          const {},
      contentRating:
          (json['contentRating'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$ContentRatingEnumMap, e))
              .toSet() ??
          const {},
      order:
          $enumDecodeNullable(_$FilterOrderEnumMap, json['order']) ??
          FilterOrder.relevance_desc,
    );

Map<String, dynamic> _$MangaFiltersToJson(
  _MangaFilters instance,
) => <String, dynamic>{
  'includedTags': instance.includedTags.map((e) => e.toJson()).toList(),
  'includedTagsMode': _$TagModeEnumMap[instance.includedTagsMode]!,
  'excludedTags': instance.excludedTags.map((e) => e.toJson()).toList(),
  'excludedTagsMode': _$TagModeEnumMap[instance.excludedTagsMode]!,
  'status': instance.status.map((e) => _$MangaStatusEnumMap[e]!).toList(),
  'publicationDemographic':
      instance.publicationDemographic
          .map((e) => _$MangaDemographicEnumMap[e]!)
          .toList(),
  'contentRating':
      instance.contentRating.map((e) => _$ContentRatingEnumMap[e]!).toList(),
  'order': _$FilterOrderEnumMap[instance.order]!,
};

const _$TagModeEnumMap = {TagMode.and: 'and', TagMode.or: 'or'};

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

Chapter _$ChapterFromJson(Map<String, dynamic> json) => Chapter(
  id: json['id'] as String,
  attributes: ChapterAttributes.fromJson(
    json['attributes'] as Map<String, dynamic>,
  ),
  relationships:
      (json['relationships'] as List<dynamic>)
          .map((e) => MangaDexEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$ChapterToJson(Chapter instance) => <String, dynamic>{
  'id': instance.id,
  'attributes': instance.attributes.toJson(),
  'relationships': instance.relationships.map((e) => e.toJson()).toList(),
  'type': instance.$type,
};

Manga _$MangaFromJson(Map<String, dynamic> json) => Manga(
  id: json['id'] as String,
  attributes:
      json['attributes'] == null
          ? null
          : MangaAttributes.fromJson(
            json['attributes'] as Map<String, dynamic>,
          ),
  relationships:
      (json['relationships'] as List<dynamic>?)
          ?.map((e) => MangaDexEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
  related: $enumDecodeNullable(_$MangaRelationsEnumMap, json['related']),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$MangaToJson(Manga instance) => <String, dynamic>{
  'id': instance.id,
  'attributes': instance.attributes?.toJson(),
  'relationships': instance.relationships?.map((e) => e.toJson()).toList(),
  'related': _$MangaRelationsEnumMap[instance.related],
  'type': instance.$type,
};

const _$MangaRelationsEnumMap = {
  MangaRelations.monochrome: 'monochrome',
  MangaRelations.main_story: 'main_story',
  MangaRelations.adapted_from: 'adapted_from',
  MangaRelations.based_on: 'based_on',
  MangaRelations.prequel: 'prequel',
  MangaRelations.side_story: 'side_story',
  MangaRelations.doujinshi: 'doujinshi',
  MangaRelations.same_franchise: 'same_franchise',
  MangaRelations.shared_universe: 'shared_universe',
  MangaRelations.sequel: 'sequel',
  MangaRelations.spin_off: 'spin_off',
  MangaRelations.alternate_story: 'alternate_story',
  MangaRelations.alternate_version: 'alternate_version',
  MangaRelations.preserialization: 'preserialization',
  MangaRelations.colored: 'colored',
  MangaRelations.serialization: 'serialization',
};

User _$UserFromJson(Map<String, dynamic> json) => User(
  id: json['id'] as String,
  attributes:
      json['attributes'] == null
          ? null
          : UserAttributes.fromJson(json['attributes'] as Map<String, dynamic>),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'id': instance.id,
  'attributes': instance.attributes?.toJson(),
  'type': instance.$type,
};

Artist _$ArtistFromJson(Map<String, dynamic> json) => Artist(
  id: json['id'] as String,
  attributes: AuthorAttributes.fromJson(
    json['attributes'] as Map<String, dynamic>,
  ),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$ArtistToJson(Artist instance) => <String, dynamic>{
  'id': instance.id,
  'attributes': instance.attributes.toJson(),
  'type': instance.$type,
};

Author _$AuthorFromJson(Map<String, dynamic> json) => Author(
  id: json['id'] as String,
  attributes: AuthorAttributes.fromJson(
    json['attributes'] as Map<String, dynamic>,
  ),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$AuthorToJson(Author instance) => <String, dynamic>{
  'id': instance.id,
  'attributes': instance.attributes.toJson(),
  'type': instance.$type,
};

CreatorID _$CreatorIDFromJson(Map<String, dynamic> json) =>
    CreatorID(id: json['id'] as String, $type: json['type'] as String?);

Map<String, dynamic> _$CreatorIDToJson(CreatorID instance) => <String, dynamic>{
  'id': instance.id,
  'type': instance.$type,
};

CoverArt _$CoverArtFromJson(Map<String, dynamic> json) => CoverArt(
  id: json['id'] as String,
  attributes:
      json['attributes'] == null
          ? null
          : CoverArtAttributes.fromJson(
            json['attributes'] as Map<String, dynamic>,
          ),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$CoverArtToJson(CoverArt instance) => <String, dynamic>{
  'id': instance.id,
  'attributes': instance.attributes?.toJson(),
  'type': instance.$type,
};

Group _$GroupFromJson(Map<String, dynamic> json) => Group(
  id: json['id'] as String,
  attributes: ScanlationGroupAttributes.fromJson(
    json['attributes'] as Map<String, dynamic>,
  ),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$GroupToJson(Group instance) => <String, dynamic>{
  'id': instance.id,
  'attributes': instance.attributes.toJson(),
  'type': instance.$type,
};

CustomList _$CustomListFromJson(Map<String, dynamic> json) => CustomList(
  id: json['id'] as String,
  attributes: CustomListAttributes.fromJson(
    json['attributes'] as Map<String, dynamic>,
  ),
  relationships:
      (json['relationships'] as List<dynamic>)
          .map((e) => MangaDexEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$CustomListToJson(CustomList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'attributes': instance.attributes.toJson(),
      'relationships': instance.relationships.map((e) => e.toJson()).toList(),
      'type': instance.$type,
    };

MDError _$MDErrorFromJson(Map<String, dynamic> json) => MDError(
  id: json['id'] as String,
  status: (json['status'] as num).toInt(),
  title: json['title'] as String,
  detail: json['detail'] as String?,
  context: json['context'] as String?,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$MDErrorToJson(MDError instance) => <String, dynamic>{
  'id': instance.id,
  'status': instance.status,
  'title': instance.title,
  'detail': instance.detail,
  'context': instance.context,
  'type': instance.$type,
};

Tag _$TagFromJson(Map<String, dynamic> json) => Tag(
  id: json['id'] as String,
  attributes: TagAttributes.fromJson(
    json['attributes'] as Map<String, dynamic>,
  ),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$TagToJson(Tag instance) => <String, dynamic>{
  'id': instance.id,
  'attributes': instance.attributes.toJson(),
  'type': instance.$type,
};

_ChapterAPIData _$ChapterAPIDataFromJson(Map<String, dynamic> json) =>
    _ChapterAPIData(
      hash: json['hash'] as String,
      data: (json['data'] as List<dynamic>).map((e) => e as String).toList(),
      dataSaver:
          (json['dataSaver'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ChapterAPIDataToJson(_ChapterAPIData instance) =>
    <String, dynamic>{
      'hash': instance.hash,
      'data': instance.data,
      'dataSaver': instance.dataSaver,
    };

_ChapterAPI _$ChapterAPIFromJson(Map<String, dynamic> json) => _ChapterAPI(
  baseUrl: json['baseUrl'] as String,
  chapter: ChapterAPIData.fromJson(json['chapter'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ChapterAPIToJson(_ChapterAPI instance) =>
    <String, dynamic>{
      'baseUrl': instance.baseUrl,
      'chapter': instance.chapter.toJson(),
    };

_MDEntityList _$MDEntityListFromJson(Map<String, dynamic> json) =>
    _MDEntityList(
      result: json['result'] as String,
      response: json['response'] as String,
      data:
          (json['data'] as List<dynamic>)
              .map((e) => MangaDexEntity.fromJson(e as Map<String, dynamic>))
              .toList(),
      limit: (json['limit'] as num).toInt(),
      offset: (json['offset'] as num).toInt(),
      total: (json['total'] as num).toInt(),
    );

Map<String, dynamic> _$MDEntityListToJson(_MDEntityList instance) =>
    <String, dynamic>{
      'result': instance.result,
      'response': instance.response,
      'data': instance.data.map((e) => e.toJson()).toList(),
      'limit': instance.limit,
      'offset': instance.offset,
      'total': instance.total,
    };

_MangaLinks _$MangaLinksFromJson(Map<String, dynamic> json) => _MangaLinks(
  raw: json['raw'] as String?,
  al: json['al'] as String?,
  mu: json['mu'] as String?,
  mal: json['mal'] as String?,
);

Map<String, dynamic> _$MangaLinksToJson(_MangaLinks instance) =>
    <String, dynamic>{
      'raw': instance.raw,
      'al': instance.al,
      'mu': instance.mu,
      'mal': instance.mal,
    };

_MangaAttributes _$MangaAttributesFromJson(Map<String, dynamic> json) =>
    _MangaAttributes(
      title: Map<String, String>.from(json['title'] as Map),
      altTitles:
          (json['altTitles'] as List<dynamic>)
              .map((e) => Map<String, String>.from(e as Map))
              .toList(),
      description: Map<String, String>.from(json['description'] as Map),
      links:
          json['links'] == null
              ? null
              : MangaLinks.fromJson(json['links'] as Map<String, dynamic>),
      originalLanguage: const LanguageConverter().fromJson(
        json['originalLanguage'],
      ),
      lastVolume: json['lastVolume'] as String?,
      lastChapter: json['lastChapter'] as String?,
      publicationDemographic: $enumDecodeNullable(
        _$MangaDemographicEnumMap,
        json['publicationDemographic'],
      ),
      status: $enumDecode(_$MangaStatusEnumMap, json['status']),
      year: (json['year'] as num?)?.toInt(),
      contentRating: $enumDecode(_$ContentRatingEnumMap, json['contentRating']),
      tags:
          (json['tags'] as List<dynamic>)
              .map((e) => Tag.fromJson(e as Map<String, dynamic>))
              .toList(),
      version: (json['version'] as num).toInt(),
      createdAt: const TimestampSerializer().fromJson(json['createdAt']),
      updatedAt: const TimestampSerializer().fromJson(json['updatedAt']),
    );

Map<String, dynamic> _$MangaAttributesToJson(_MangaAttributes instance) =>
    <String, dynamic>{
      'title': instance.title,
      'altTitles': instance.altTitles,
      'description': instance.description,
      'links': instance.links?.toJson(),
      'originalLanguage': const LanguageConverter().toJson(
        instance.originalLanguage,
      ),
      'lastVolume': instance.lastVolume,
      'lastChapter': instance.lastChapter,
      'publicationDemographic':
          _$MangaDemographicEnumMap[instance.publicationDemographic],
      'status': _$MangaStatusEnumMap[instance.status]!,
      'year': instance.year,
      'contentRating': _$ContentRatingEnumMap[instance.contentRating]!,
      'tags': instance.tags.map((e) => e.toJson()).toList(),
      'version': instance.version,
      'createdAt': const TimestampSerializer().toJson(instance.createdAt),
      'updatedAt': const TimestampSerializer().toJson(instance.updatedAt),
    };

_ChapterAttributes _$ChapterAttributesFromJson(Map<String, dynamic> json) =>
    _ChapterAttributes(
      title: json['title'] as String?,
      volume: json['volume'] as String?,
      chapter: json['chapter'] as String?,
      translatedLanguage: const LanguageConverter().fromJson(
        json['translatedLanguage'],
      ),
      uploader: json['uploader'] as String?,
      externalUrl: json['externalUrl'] as String?,
      version: (json['version'] as num).toInt(),
      createdAt: const TimestampSerializer().fromJson(json['createdAt']),
      updatedAt: const TimestampSerializer().fromJson(json['updatedAt']),
      publishAt: const TimestampSerializer().fromJson(json['publishAt']),
    );

Map<String, dynamic> _$ChapterAttributesToJson(_ChapterAttributes instance) =>
    <String, dynamic>{
      'title': instance.title,
      'volume': instance.volume,
      'chapter': instance.chapter,
      'translatedLanguage': const LanguageConverter().toJson(
        instance.translatedLanguage,
      ),
      'uploader': instance.uploader,
      'externalUrl': instance.externalUrl,
      'version': instance.version,
      'createdAt': const TimestampSerializer().toJson(instance.createdAt),
      'updatedAt': const TimestampSerializer().toJson(instance.updatedAt),
      'publishAt': const TimestampSerializer().toJson(instance.publishAt),
    };

_ScanlationGroupAttributes _$ScanlationGroupAttributesFromJson(
  Map<String, dynamic> json,
) => _ScanlationGroupAttributes(
  name: json['name'] as String,
  website: json['website'] as String?,
  discord: json['discord'] as String?,
  description: json['description'] as String?,
);

Map<String, dynamic> _$ScanlationGroupAttributesToJson(
  _ScanlationGroupAttributes instance,
) => <String, dynamic>{
  'name': instance.name,
  'website': instance.website,
  'discord': instance.discord,
  'description': instance.description,
};

_CoverArtAttributes _$CoverArtAttributesFromJson(Map<String, dynamic> json) =>
    _CoverArtAttributes(
      volume: json['volume'] as String?,
      fileName: json['fileName'] as String,
      description: json['description'] as String?,
      locale: json['locale'] as String?,
    );

Map<String, dynamic> _$CoverArtAttributesToJson(_CoverArtAttributes instance) =>
    <String, dynamic>{
      'volume': instance.volume,
      'fileName': instance.fileName,
      'description': instance.description,
      'locale': instance.locale,
    };

_UserAttributes _$UserAttributesFromJson(Map<String, dynamic> json) =>
    _UserAttributes(username: json['username'] as String);

Map<String, dynamic> _$UserAttributesToJson(_UserAttributes instance) =>
    <String, dynamic>{'username': instance.username};

_AuthorAttributes _$AuthorAttributesFromJson(Map<String, dynamic> json) =>
    _AuthorAttributes(
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String?,
      biography: Map<String, String>.from(json['biography'] as Map),
      twitter: json['twitter'] as String?,
      pixiv: json['pixiv'] as String?,
      youtube: json['youtube'] as String?,
      website: json['website'] as String?,
      createdAt: const TimestampSerializer().fromJson(json['createdAt']),
      updatedAt: const TimestampSerializer().fromJson(json['updatedAt']),
    );

Map<String, dynamic> _$AuthorAttributesToJson(_AuthorAttributes instance) =>
    <String, dynamic>{
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'biography': instance.biography,
      'twitter': instance.twitter,
      'pixiv': instance.pixiv,
      'youtube': instance.youtube,
      'website': instance.website,
      'createdAt': const TimestampSerializer().toJson(instance.createdAt),
      'updatedAt': const TimestampSerializer().toJson(instance.updatedAt),
    };

_TagAttributes _$TagAttributesFromJson(Map<String, dynamic> json) =>
    _TagAttributes(
      name: Map<String, String>.from(json['name'] as Map),
      description: Map<String, String>.from(json['description'] as Map),
      group: $enumDecode(_$TagGroupEnumMap, json['group']),
    );

Map<String, dynamic> _$TagAttributesToJson(_TagAttributes instance) =>
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

_MangaStatisticsResponse _$MangaStatisticsResponseFromJson(
  Map<String, dynamic> json,
) => _MangaStatisticsResponse(
  (json['statistics'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(k, MangaStatistics.fromJson(e as Map<String, dynamic>)),
  ),
);

Map<String, dynamic> _$MangaStatisticsResponseToJson(
  _MangaStatisticsResponse instance,
) => <String, dynamic>{
  'statistics': instance.statistics.map((k, e) => MapEntry(k, e.toJson())),
};

_ChapterStatisticsResponse _$ChapterStatisticsResponseFromJson(
  Map<String, dynamic> json,
) => _ChapterStatisticsResponse(
  (json['statistics'] as Map<String, dynamic>).map(
    (k, e) =>
        MapEntry(k, ChapterStatistics.fromJson(e as Map<String, dynamic>)),
  ),
);

Map<String, dynamic> _$ChapterStatisticsResponseToJson(
  _ChapterStatisticsResponse instance,
) => <String, dynamic>{
  'statistics': instance.statistics.map((k, e) => MapEntry(k, e.toJson())),
};

_MangaStatistics _$MangaStatisticsFromJson(Map<String, dynamic> json) =>
    _MangaStatistics(
      comments:
          json['comments'] == null
              ? null
              : StatisticsDetailsComments.fromJson(
                json['comments'] as Map<String, dynamic>,
              ),
      rating: StatisticsDetailsRating.fromJson(
        json['rating'] as Map<String, dynamic>,
      ),
      follows: (json['follows'] as num).toInt(),
    );

Map<String, dynamic> _$MangaStatisticsToJson(_MangaStatistics instance) =>
    <String, dynamic>{
      'comments': instance.comments?.toJson(),
      'rating': instance.rating.toJson(),
      'follows': instance.follows,
    };

_ChapterStatistics _$ChapterStatisticsFromJson(Map<String, dynamic> json) =>
    _ChapterStatistics(
      comments:
          json['comments'] == null
              ? null
              : StatisticsDetailsComments.fromJson(
                json['comments'] as Map<String, dynamic>,
              ),
    );

Map<String, dynamic> _$ChapterStatisticsToJson(_ChapterStatistics instance) =>
    <String, dynamic>{'comments': instance.comments?.toJson()};

_StatisticsDetailsComments _$StatisticsDetailsCommentsFromJson(
  Map<String, dynamic> json,
) => _StatisticsDetailsComments(
  threadId: (json['threadId'] as num).toInt(),
  repliesCount: (json['repliesCount'] as num).toInt(),
);

Map<String, dynamic> _$StatisticsDetailsCommentsToJson(
  _StatisticsDetailsComments instance,
) => <String, dynamic>{
  'threadId': instance.threadId,
  'repliesCount': instance.repliesCount,
};

_StatisticsDetailsRating _$StatisticsDetailsRatingFromJson(
  Map<String, dynamic> json,
) => _StatisticsDetailsRating(
  average: (json['average'] as num?)?.toDouble(),
  bayesian: (json['bayesian'] as num).toDouble(),
);

Map<String, dynamic> _$StatisticsDetailsRatingToJson(
  _StatisticsDetailsRating instance,
) => <String, dynamic>{
  'average': instance.average,
  'bayesian': instance.bayesian,
};

_SelfRatingResponse _$SelfRatingResponseFromJson(Map<String, dynamic> json) =>
    _SelfRatingResponse(
      (json['ratings'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, SelfRating.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$SelfRatingResponseToJson(_SelfRatingResponse instance) =>
    <String, dynamic>{
      'ratings': instance.ratings.map((k, e) => MapEntry(k, e.toJson())),
    };

_SelfRating _$SelfRatingFromJson(Map<String, dynamic> json) => _SelfRating(
  rating: (json['rating'] as num).toInt(),
  createdAt: const TimestampSerializer().fromJson(json['createdAt']),
);

Map<String, dynamic> _$SelfRatingToJson(_SelfRating instance) =>
    <String, dynamic>{
      'rating': instance.rating,
      'createdAt': const TimestampSerializer().toJson(instance.createdAt),
    };

_CustomListAttributes _$CustomListAttributesFromJson(
  Map<String, dynamic> json,
) => _CustomListAttributes(
  name: json['name'] as String,
  visibility: $enumDecode(_$CustomListVisibilityEnumMap, json['visibility']),
  version: (json['version'] as num).toInt(),
);

Map<String, dynamic> _$CustomListAttributesToJson(
  _CustomListAttributes instance,
) => <String, dynamic>{
  'name': instance.name,
  'visibility': _$CustomListVisibilityEnumMap[instance.visibility]!,
  'version': instance.version,
};

const _$CustomListVisibilityEnumMap = {
  CustomListVisibility.private: 'private',
  CustomListVisibility.public: 'public',
};

_ErrorResponse _$ErrorResponseFromJson(Map<String, dynamic> json) =>
    _ErrorResponse(
      json['result'] as String,
      (json['errors'] as List<dynamic>)
          .map((e) => MDError.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ErrorResponseToJson(_ErrorResponse instance) =>
    <String, dynamic>{
      'result': instance.result,
      'errors': instance.errors.map((e) => e.toJson()).toList(),
    };

_FrontPageData _$FrontPageDataFromJson(Map<String, dynamic> json) =>
    _FrontPageData(
      staffPicks: json['staffPicks'] as String,
      seasonal: json['seasonal'] as String,
    );

Map<String, dynamic> _$FrontPageDataToJson(_FrontPageData instance) =>
    <String, dynamic>{
      'staffPicks': instance.staffPicks,
      'seasonal': instance.seasonal,
    };
