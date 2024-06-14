// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'types.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MangaFiltersImpl _$$MangaFiltersImplFromJson(Map<String, dynamic> json) =>
    _$MangaFiltersImpl(
      includedTags: (json['includedTags'] as List<dynamic>?)
              ?.map((e) => Tag.fromJson(e as Map<String, dynamic>))
              .toSet() ??
          const {},
      includedTagsMode:
          $enumDecodeNullable(_$TagModeEnumMap, json['includedTagsMode']) ??
              TagMode.and,
      excludedTags: (json['excludedTags'] as List<dynamic>?)
              ?.map((e) => Tag.fromJson(e as Map<String, dynamic>))
              .toSet() ??
          const {},
      excludedTagsMode:
          $enumDecodeNullable(_$TagModeEnumMap, json['excludedTagsMode']) ??
              TagMode.or,
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

Map<String, dynamic> _$$MangaFiltersImplToJson(_$MangaFiltersImpl instance) =>
    <String, dynamic>{
      'includedTags': instance.includedTags.toList(),
      'includedTagsMode': _$TagModeEnumMap[instance.includedTagsMode]!,
      'excludedTags': instance.excludedTags.toList(),
      'excludedTagsMode': _$TagModeEnumMap[instance.excludedTagsMode]!,
      'status': instance.status.map((e) => _$MangaStatusEnumMap[e]!).toList(),
      'publicationDemographic': instance.publicationDemographic
          .map((e) => _$MangaDemographicEnumMap[e]!)
          .toList(),
      'contentRating': instance.contentRating
          .map((e) => _$ContentRatingEnumMap[e]!)
          .toList(),
      'order': _$FilterOrderEnumMap[instance.order]!,
    };

const _$TagModeEnumMap = {
  TagMode.and: 'and',
  TagMode.or: 'or',
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

_$ChapterListImpl _$$ChapterListImplFromJson(Map<String, dynamic> json) =>
    _$ChapterListImpl(
      (json['data'] as List<dynamic>)
          .map((e) => Chapter.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['total'] as num).toInt(),
    );

Map<String, dynamic> _$$ChapterListImplToJson(_$ChapterListImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
      'total': instance.total,
    };

_$ChapterImpl _$$ChapterImplFromJson(Map<String, dynamic> json) =>
    _$ChapterImpl(
      id: json['id'] as String,
      attributes: ChapterAttributes.fromJson(
          json['attributes'] as Map<String, dynamic>),
      relationships: (json['relationships'] as List<dynamic>)
          .map((e) => Relationship.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ChapterImplToJson(_$ChapterImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'attributes': instance.attributes,
      'relationships': instance.relationships,
    };

_$ChapterAttributesImpl _$$ChapterAttributesImplFromJson(
        Map<String, dynamic> json) =>
    _$ChapterAttributesImpl(
      title: json['title'] as String?,
      volume: json['volume'] as String?,
      chapter: json['chapter'] as String?,
      translatedLanguage:
          const LanguageConverter().fromJson(json['translatedLanguage']),
      uploader: json['uploader'] as String?,
      externalUrl: json['externalUrl'] as String?,
      version: (json['version'] as num).toInt(),
      createdAt: const TimestampSerializer().fromJson(json['createdAt']),
      updatedAt: const TimestampSerializer().fromJson(json['updatedAt']),
      publishAt: const TimestampSerializer().fromJson(json['publishAt']),
    );

Map<String, dynamic> _$$ChapterAttributesImplToJson(
        _$ChapterAttributesImpl instance) =>
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

_$ScanlationGroupAttributesImpl _$$ScanlationGroupAttributesImplFromJson(
        Map<String, dynamic> json) =>
    _$ScanlationGroupAttributesImpl(
      name: json['name'] as String,
      website: json['website'] as String?,
      discord: json['discord'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$$ScanlationGroupAttributesImplToJson(
        _$ScanlationGroupAttributesImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'website': instance.website,
      'discord': instance.discord,
      'description': instance.description,
    };

_$CoverArtAttributesImpl _$$CoverArtAttributesImplFromJson(
        Map<String, dynamic> json) =>
    _$CoverArtAttributesImpl(
      volume: json['volume'] as String?,
      fileName: json['fileName'] as String,
      description: json['description'] as String?,
      locale: json['locale'] as String?,
    );

Map<String, dynamic> _$$CoverArtAttributesImplToJson(
        _$CoverArtAttributesImpl instance) =>
    <String, dynamic>{
      'volume': instance.volume,
      'fileName': instance.fileName,
      'description': instance.description,
      'locale': instance.locale,
    };

_$UserAttributesImpl _$$UserAttributesImplFromJson(Map<String, dynamic> json) =>
    _$UserAttributesImpl(
      username: json['username'] as String,
    );

Map<String, dynamic> _$$UserAttributesImplToJson(
        _$UserAttributesImpl instance) =>
    <String, dynamic>{
      'username': instance.username,
    };

_$AuthorAttributesImpl _$$AuthorAttributesImplFromJson(
        Map<String, dynamic> json) =>
    _$AuthorAttributesImpl(
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

Map<String, dynamic> _$$AuthorAttributesImplToJson(
        _$AuthorAttributesImpl instance) =>
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

_$MangaImpl _$$MangaImplFromJson(Map<String, dynamic> json) => _$MangaImpl(
      id: json['id'] as String,
      attributes: json['attributes'] == null
          ? null
          : MangaAttributes.fromJson(
              json['attributes'] as Map<String, dynamic>),
      relationships: (json['relationships'] as List<dynamic>?)
          ?.map((e) => Relationship.fromJson(e as Map<String, dynamic>))
          .toList(),
      related: $enumDecodeNullable(_$MangaRelationsEnumMap, json['related']),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$MangaImplToJson(_$MangaImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'attributes': instance.attributes,
      'relationships': instance.relationships,
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

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: json['id'] as String,
      attributes: json['attributes'] == null
          ? null
          : UserAttributes.fromJson(json['attributes'] as Map<String, dynamic>),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'attributes': instance.attributes,
      'type': instance.$type,
    };

_$ArtistImpl _$$ArtistImplFromJson(Map<String, dynamic> json) => _$ArtistImpl(
      id: json['id'] as String,
      attributes:
          AuthorAttributes.fromJson(json['attributes'] as Map<String, dynamic>),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$ArtistImplToJson(_$ArtistImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'attributes': instance.attributes,
      'type': instance.$type,
    };

_$AuthorImpl _$$AuthorImplFromJson(Map<String, dynamic> json) => _$AuthorImpl(
      id: json['id'] as String,
      attributes:
          AuthorAttributes.fromJson(json['attributes'] as Map<String, dynamic>),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$AuthorImplToJson(_$AuthorImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'attributes': instance.attributes,
      'type': instance.$type,
    };

_$CreatorIDImpl _$$CreatorIDImplFromJson(Map<String, dynamic> json) =>
    _$CreatorIDImpl(
      id: json['id'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$CreatorIDImplToJson(_$CreatorIDImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.$type,
    };

_$CoverArtImpl _$$CoverArtImplFromJson(Map<String, dynamic> json) =>
    _$CoverArtImpl(
      id: json['id'] as String,
      attributes: json['attributes'] == null
          ? null
          : CoverArtAttributes.fromJson(
              json['attributes'] as Map<String, dynamic>),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$CoverArtImplToJson(_$CoverArtImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'attributes': instance.attributes,
      'type': instance.$type,
    };

_$GroupImpl _$$GroupImplFromJson(Map<String, dynamic> json) => _$GroupImpl(
      id: json['id'] as String,
      attributes: ScanlationGroupAttributes.fromJson(
          json['attributes'] as Map<String, dynamic>),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$GroupImplToJson(_$GroupImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'attributes': instance.attributes,
      'type': instance.$type,
    };

_$ChapterAPIDataImpl _$$ChapterAPIDataImplFromJson(Map<String, dynamic> json) =>
    _$ChapterAPIDataImpl(
      hash: json['hash'] as String,
      data: (json['data'] as List<dynamic>).map((e) => e as String).toList(),
      dataSaver:
          (json['dataSaver'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$ChapterAPIDataImplToJson(
        _$ChapterAPIDataImpl instance) =>
    <String, dynamic>{
      'hash': instance.hash,
      'data': instance.data,
      'dataSaver': instance.dataSaver,
    };

_$ChapterAPIImpl _$$ChapterAPIImplFromJson(Map<String, dynamic> json) =>
    _$ChapterAPIImpl(
      baseUrl: json['baseUrl'] as String,
      chapter: ChapterAPIData.fromJson(json['chapter'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ChapterAPIImplToJson(_$ChapterAPIImpl instance) =>
    <String, dynamic>{
      'baseUrl': instance.baseUrl,
      'chapter': instance.chapter,
    };

_$CoverListImpl _$$CoverListImplFromJson(Map<String, dynamic> json) =>
    _$CoverListImpl(
      (json['data'] as List<dynamic>)
          .map((e) => CoverArt.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['total'] as num).toInt(),
    );

Map<String, dynamic> _$$CoverListImplToJson(_$CoverListImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
      'total': instance.total,
    };

_$MangaListImpl _$$MangaListImplFromJson(Map<String, dynamic> json) =>
    _$MangaListImpl(
      (json['data'] as List<dynamic>)
          .map((e) => Manga.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['total'] as num).toInt(),
    );

Map<String, dynamic> _$$MangaListImplToJson(_$MangaListImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
      'total': instance.total,
    };

_$GroupListImpl _$$GroupListImplFromJson(Map<String, dynamic> json) =>
    _$GroupListImpl(
      (json['data'] as List<dynamic>)
          .map((e) => Group.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['total'] as num).toInt(),
    );

Map<String, dynamic> _$$GroupListImplToJson(_$GroupListImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
      'total': instance.total,
    };

_$CreatorListListImpl _$$CreatorListListImplFromJson(
        Map<String, dynamic> json) =>
    _$CreatorListListImpl(
      (json['data'] as List<dynamic>)
          .map((e) => Author.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['total'] as num).toInt(),
    );

Map<String, dynamic> _$$CreatorListListImplToJson(
        _$CreatorListListImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
      'total': instance.total,
    };

_$MangaLinksImpl _$$MangaLinksImplFromJson(Map<String, dynamic> json) =>
    _$MangaLinksImpl(
      raw: json['raw'] as String?,
      al: json['al'] as String?,
      mu: json['mu'] as String?,
      mal: json['mal'] as String?,
    );

Map<String, dynamic> _$$MangaLinksImplToJson(_$MangaLinksImpl instance) =>
    <String, dynamic>{
      'raw': instance.raw,
      'al': instance.al,
      'mu': instance.mu,
      'mal': instance.mal,
    };

_$MangaAttributesImpl _$$MangaAttributesImplFromJson(
        Map<String, dynamic> json) =>
    _$MangaAttributesImpl(
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
      year: (json['year'] as num?)?.toInt(),
      contentRating: $enumDecode(_$ContentRatingEnumMap, json['contentRating']),
      tags: (json['tags'] as List<dynamic>)
          .map((e) => Tag.fromJson(e as Map<String, dynamic>))
          .toList(),
      version: (json['version'] as num).toInt(),
      createdAt: const TimestampSerializer().fromJson(json['createdAt']),
      updatedAt: const TimestampSerializer().fromJson(json['updatedAt']),
    );

Map<String, dynamic> _$$MangaAttributesImplToJson(
        _$MangaAttributesImpl instance) =>
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

_$TagImpl _$$TagImplFromJson(Map<String, dynamic> json) => _$TagImpl(
      id: json['id'] as String,
      attributes:
          TagAttributes.fromJson(json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$TagImplToJson(_$TagImpl instance) => <String, dynamic>{
      'id': instance.id,
      'attributes': instance.attributes,
    };

_$TagAttributesImpl _$$TagAttributesImplFromJson(Map<String, dynamic> json) =>
    _$TagAttributesImpl(
      name: Map<String, String>.from(json['name'] as Map),
      description: Map<String, String>.from(json['description'] as Map),
      group: $enumDecode(_$TagGroupEnumMap, json['group']),
    );

Map<String, dynamic> _$$TagAttributesImplToJson(_$TagAttributesImpl instance) =>
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

_$TagResponseImpl _$$TagResponseImplFromJson(Map<String, dynamic> json) =>
    _$TagResponseImpl(
      (json['data'] as List<dynamic>)
          .map((e) => Tag.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['total'] as num).toInt(),
    );

Map<String, dynamic> _$$TagResponseImplToJson(_$TagResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
      'total': instance.total,
    };

_$MangaStatisticsResponseImpl _$$MangaStatisticsResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$MangaStatisticsResponseImpl(
      (json['statistics'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, MangaStatistics.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$$MangaStatisticsResponseImplToJson(
        _$MangaStatisticsResponseImpl instance) =>
    <String, dynamic>{
      'statistics': instance.statistics,
    };

_$ChapterStatisticsResponseImpl _$$ChapterStatisticsResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$ChapterStatisticsResponseImpl(
      (json['statistics'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, ChapterStatistics.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$$ChapterStatisticsResponseImplToJson(
        _$ChapterStatisticsResponseImpl instance) =>
    <String, dynamic>{
      'statistics': instance.statistics,
    };

_$MangaStatisticsImpl _$$MangaStatisticsImplFromJson(
        Map<String, dynamic> json) =>
    _$MangaStatisticsImpl(
      comments: json['comments'] == null
          ? null
          : StatisticsDetailsComments.fromJson(
              json['comments'] as Map<String, dynamic>),
      rating: StatisticsDetailsRating.fromJson(
          json['rating'] as Map<String, dynamic>),
      follows: (json['follows'] as num).toInt(),
    );

Map<String, dynamic> _$$MangaStatisticsImplToJson(
        _$MangaStatisticsImpl instance) =>
    <String, dynamic>{
      'comments': instance.comments,
      'rating': instance.rating,
      'follows': instance.follows,
    };

_$ChapterStatisticsImpl _$$ChapterStatisticsImplFromJson(
        Map<String, dynamic> json) =>
    _$ChapterStatisticsImpl(
      comments: json['comments'] == null
          ? null
          : StatisticsDetailsComments.fromJson(
              json['comments'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ChapterStatisticsImplToJson(
        _$ChapterStatisticsImpl instance) =>
    <String, dynamic>{
      'comments': instance.comments,
    };

_$StatisticsDetailsCommentsImpl _$$StatisticsDetailsCommentsImplFromJson(
        Map<String, dynamic> json) =>
    _$StatisticsDetailsCommentsImpl(
      threadId: (json['threadId'] as num).toInt(),
      repliesCount: (json['repliesCount'] as num).toInt(),
    );

Map<String, dynamic> _$$StatisticsDetailsCommentsImplToJson(
        _$StatisticsDetailsCommentsImpl instance) =>
    <String, dynamic>{
      'threadId': instance.threadId,
      'repliesCount': instance.repliesCount,
    };

_$StatisticsDetailsRatingImpl _$$StatisticsDetailsRatingImplFromJson(
        Map<String, dynamic> json) =>
    _$StatisticsDetailsRatingImpl(
      average: (json['average'] as num?)?.toDouble(),
      bayesian: (json['bayesian'] as num).toDouble(),
    );

Map<String, dynamic> _$$StatisticsDetailsRatingImplToJson(
        _$StatisticsDetailsRatingImpl instance) =>
    <String, dynamic>{
      'average': instance.average,
      'bayesian': instance.bayesian,
    };

_$SelfRatingResponseImpl _$$SelfRatingResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$SelfRatingResponseImpl(
      (json['ratings'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, SelfRating.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$$SelfRatingResponseImplToJson(
        _$SelfRatingResponseImpl instance) =>
    <String, dynamic>{
      'ratings': instance.ratings,
    };

_$SelfRatingImpl _$$SelfRatingImplFromJson(Map<String, dynamic> json) =>
    _$SelfRatingImpl(
      rating: (json['rating'] as num).toInt(),
      createdAt: const TimestampSerializer().fromJson(json['createdAt']),
    );

Map<String, dynamic> _$$SelfRatingImplToJson(_$SelfRatingImpl instance) =>
    <String, dynamic>{
      'rating': instance.rating,
      'createdAt': const TimestampSerializer().toJson(instance.createdAt),
    };

_$CustomListListImpl _$$CustomListListImplFromJson(Map<String, dynamic> json) =>
    _$CustomListListImpl(
      (json['data'] as List<dynamic>)
          .map((e) => CustomList.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['total'] as num).toInt(),
    );

Map<String, dynamic> _$$CustomListListImplToJson(
        _$CustomListListImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
      'total': instance.total,
    };

_$CustomListImpl _$$CustomListImplFromJson(Map<String, dynamic> json) =>
    _$CustomListImpl(
      id: json['id'] as String,
      attributes: CustomListAttributes.fromJson(
          json['attributes'] as Map<String, dynamic>),
      relationships: (json['relationships'] as List<dynamic>)
          .map((e) => Relationship.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$CustomListImplToJson(_$CustomListImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'attributes': instance.attributes,
      'relationships': instance.relationships,
    };

_$CustomListAttributesImpl _$$CustomListAttributesImplFromJson(
        Map<String, dynamic> json) =>
    _$CustomListAttributesImpl(
      name: json['name'] as String,
      visibility:
          $enumDecode(_$CustomListVisibilityEnumMap, json['visibility']),
      version: (json['version'] as num).toInt(),
    );

Map<String, dynamic> _$$CustomListAttributesImplToJson(
        _$CustomListAttributesImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'visibility': _$CustomListVisibilityEnumMap[instance.visibility]!,
      'version': instance.version,
    };

const _$CustomListVisibilityEnumMap = {
  CustomListVisibility.private: 'private',
  CustomListVisibility.public: 'public',
};

_$ErrorResponseImpl _$$ErrorResponseImplFromJson(Map<String, dynamic> json) =>
    _$ErrorResponseImpl(
      json['result'] as String,
      (json['errors'] as List<dynamic>)
          .map((e) => MDError.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ErrorResponseImplToJson(_$ErrorResponseImpl instance) =>
    <String, dynamic>{
      'result': instance.result,
      'errors': instance.errors,
    };

_$MDErrorImpl _$$MDErrorImplFromJson(Map<String, dynamic> json) =>
    _$MDErrorImpl(
      id: json['id'] as String,
      status: (json['status'] as num).toInt(),
      title: json['title'] as String,
      detail: json['detail'] as String?,
      context: json['context'] as String?,
    );

Map<String, dynamic> _$$MDErrorImplToJson(_$MDErrorImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'title': instance.title,
      'detail': instance.detail,
      'context': instance.context,
    };
