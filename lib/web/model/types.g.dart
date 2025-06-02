// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'types.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RepoInfo _$RepoInfoFromJson(Map<String, dynamic> json) =>
    RepoInfo(name: json['name'] as String, url: json['url'] as String);

Map<String, dynamic> _$RepoInfoToJson(RepoInfo instance) => <String, dynamic>{
  'name': instance.name,
  'url': instance.url,
};

RepoData _$RepoDataFromJson(Map<String, dynamic> json) => RepoData(
  name: json['name'] as String,
  url: json['url'] as String,
  version: $enumDecode(_$SupportedVersionEnumMap, json['version']),
);

Map<String, dynamic> _$RepoDataToJson(RepoData instance) => <String, dynamic>{
  'name': instance.name,
  'url': instance.url,
  'version': _$SupportedVersionEnumMap[instance.version]!,
};

const _$SupportedVersionEnumMap = {
  SupportedVersion.v0_8: 'v0_8',
  SupportedVersion.v0_9: 'v0_9',
};

_SourceHandler _$SourceHandlerFromJson(Map<String, dynamic> json) =>
    _SourceHandler(
      type: $enumDecode(_$SourceTypeEnumMap, json['type']),
      sourceId: json['sourceId'] as String,
      location: json['location'] as String,
      chapter: json['chapter'] as String?,
    );

Map<String, dynamic> _$SourceHandlerToJson(_SourceHandler instance) =>
    <String, dynamic>{
      'type': _$SourceTypeEnumMap[instance.type]!,
      'sourceId': instance.sourceId,
      'location': instance.location,
      'chapter': instance.chapter,
    };

const _$SourceTypeEnumMap = {
  SourceType.proxy: 'proxy',
  SourceType.source: 'source',
};

_UpdateFeedItem _$UpdateFeedItemFromJson(Map<String, dynamic> json) =>
    _UpdateFeedItem(
      link: HistoryLink.fromJson(json['link'] as Map<String, dynamic>),
      manga: WebManga.fromJson(json['manga'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UpdateFeedItemToJson(_UpdateFeedItem instance) =>
    <String, dynamic>{
      'link': instance.link.toJson(),
      'manga': instance.manga.toJson(),
    };

_HistoryLink _$HistoryLinkFromJson(Map<String, dynamic> json) => _HistoryLink(
  title: json['title'] as String,
  url: json['url'] as String,
  cover: json['cover'] as String?,
  handle:
      json['handle'] == null
          ? null
          : SourceHandler.fromJson(json['handle'] as Map<String, dynamic>),
);

Map<String, dynamic> _$HistoryLinkToJson(_HistoryLink instance) =>
    <String, dynamic>{
      'title': instance.title,
      'url': instance.url,
      'cover': instance.cover,
      'handle': instance.handle?.toJson(),
    };

_WebManga _$WebMangaFromJson(Map<String, dynamic> json) => _WebManga(
  title: json['title'] as String,
  description: json['description'] as String,
  artist: json['artist'] as String,
  author: json['author'] as String,
  cover: json['cover'] as String,
  groups: (json['groups'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, e as String),
  ),
  chapters: const WebChapterSerializer().fromJson(json['chapters']),
  data:
      json['data'] == null
          ? null
          : SourceManga.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$WebMangaToJson(_WebManga instance) => <String, dynamic>{
  'title': instance.title,
  'description': instance.description,
  'artist': instance.artist,
  'author': instance.author,
  'cover': instance.cover,
  'groups': instance.groups,
  'chapters': const WebChapterSerializer().toJson(instance.chapters),
  'data': instance.data?.toJson(),
};

_WebChapter _$WebChapterFromJson(Map<String, dynamic> json) => _WebChapter(
  title: json['title'] as String?,
  volume: json['volume'] as String?,
  lastUpdated: const EpochTimestampSerializer().fromJson(json['last_updated']),
  releaseDate: const MappedEpochTimestampSerializer().fromJson(
    json['release_date'],
  ),
  groups: const ChapterGroupSerializer().fromJson(json['groups']),
);

Map<String, dynamic> _$WebChapterToJson(
  _WebChapter instance,
) => <String, dynamic>{
  'title': instance.title,
  'volume': instance.volume,
  'last_updated': const EpochTimestampSerializer().toJson(instance.lastUpdated),
  'release_date': const MappedEpochTimestampSerializer().toJson(
    instance.releaseDate,
  ),
  'groups': const ChapterGroupSerializer().toJson(instance.groups),
};

_ImgurPage _$ImgurPageFromJson(Map<String, dynamic> json) => _ImgurPage(
  description: json['description'] as String,
  src: json['src'] as String,
);

Map<String, dynamic> _$ImgurPageToJson(_ImgurPage instance) =>
    <String, dynamic>{'description': instance.description, 'src': instance.src};

_WebSourceInfo _$WebSourceInfoFromJson(Map<String, dynamic> json) =>
    _WebSourceInfo(
      id: json['id'] as String,
      name: json['name'] as String,
      repo: json['repo'] as String,
      baseUrl: json['baseUrl'] as String?,
      version:
          $enumDecodeNullable(_$SupportedVersionEnumMap, json['version']) ??
          SupportedVersion.v0_8,
      icon: json['icon'] as String,
      capabilities:
          (json['capabilities'] as List<dynamic>?)
              ?.map(const SourceIntentParser().fromJson)
              .toList() ??
          const [SourceIntents.mangaChapters],
    );

Map<String, dynamic> _$WebSourceInfoToJson(_WebSourceInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'repo': instance.repo,
      'baseUrl': instance.baseUrl,
      'version': _$SupportedVersionEnumMap[instance.version]!,
      'icon': instance.icon,
      'capabilities':
          instance.capabilities.map(const SourceIntentParser().toJson).toList(),
    };

_Badge08 _$Badge08FromJson(Map<String, dynamic> json) => _Badge08(
  text: json['text'] as String,
  type: const BadgeColorParser().fromJson(json['type']),
);

Map<String, dynamic> _$Badge08ToJson(_Badge08 instance) => <String, dynamic>{
  'text': instance.text,
  'type': const BadgeColorParser().toJson(instance.type),
};

_SourceBadge _$SourceBadgeFromJson(Map<String, dynamic> json) => _SourceBadge(
  label: json['label'] as String,
  textColor: json['textColor'] as String,
  backgroundColor: json['backgroundColor'] as String,
);

Map<String, dynamic> _$SourceBadgeToJson(_SourceBadge instance) =>
    <String, dynamic>{
      'label': instance.label,
      'textColor': instance.textColor,
      'backgroundColor': instance.backgroundColor,
    };

_SourceDeveloper _$SourceDeveloperFromJson(Map<String, dynamic> json) =>
    _SourceDeveloper(
      name: json['name'] as String,
      website: json['website'] as String?,
      github: json['github'] as String?,
    );

Map<String, dynamic> _$SourceDeveloperToJson(_SourceDeveloper instance) =>
    <String, dynamic>{
      'name': instance.name,
      'website': instance.website,
      'github': instance.github,
    };

SourceVersion08 _$SourceVersion08FromJson(Map<String, dynamic> json) =>
    SourceVersion08(
      id: json['id'] as String,
      name: json['name'] as String,
      author: json['author'] as String,
      desc: json['desc'] as String,
      website: json['website'] as String?,
      contentRating: $enumDecode(_$ContentRatingEnumMap, json['contentRating']),
      version: json['version'] as String,
      icon: json['icon'] as String,
      tags:
          (json['tags'] as List<dynamic>?)
              ?.map((e) => Badge08.fromJson(e as Map<String, dynamic>))
              .toList(),
      websiteBaseURL: json['websiteBaseURL'] as String,
      intents: (json['intents'] as num?)?.toInt(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$SourceVersion08ToJson(SourceVersion08 instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'author': instance.author,
      'desc': instance.desc,
      'website': instance.website,
      'contentRating': _$ContentRatingEnumMap[instance.contentRating]!,
      'version': instance.version,
      'icon': instance.icon,
      'tags': instance.tags?.map((e) => e.toJson()).toList(),
      'websiteBaseURL': instance.websiteBaseURL,
      'intents': instance.intents,
      'runtimeType': instance.$type,
    };

const _$ContentRatingEnumMap = {
  ContentRating.EVERYONE: 'EVERYONE',
  ContentRating.MATURE: 'MATURE',
  ContentRating.ADULT: 'ADULT',
};

SourceVersion09 _$SourceVersion09FromJson(
  Map<String, dynamic> json,
) => SourceVersion09(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  version: json['version'] as String,
  icon: json['icon'] as String,
  language: json['language'] as String?,
  contentRating: const ContentRatingParser().fromJson(json['contentRating']),
  badges:
      (json['badges'] as List<dynamic>)
          .map((e) => SourceBadge.fromJson(e as Map<String, dynamic>))
          .toList(),
  developers:
      (json['developers'] as List<dynamic>)
          .map((e) => SourceDeveloper.fromJson(e as Map<String, dynamic>))
          .toList(),
  capabilities: const SourceIntentOrListParser().fromJson(json['capabilities']),
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$SourceVersion09ToJson(
  SourceVersion09 instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'version': instance.version,
  'icon': instance.icon,
  'language': instance.language,
  'contentRating': const ContentRatingParser().toJson(instance.contentRating),
  'badges': instance.badges.map((e) => e.toJson()).toList(),
  'developers': instance.developers.map((e) => e.toJson()).toList(),
  'capabilities': const SourceIntentOrListParser().toJson(
    instance.capabilities,
  ),
  'runtimeType': instance.$type,
};

_BuiltWith _$BuiltWithFromJson(Map<String, dynamic> json) => _BuiltWith(
  toolchain: json['toolchain'] as String,
  types: json['types'] as String,
);

Map<String, dynamic> _$BuiltWithToJson(_BuiltWith instance) =>
    <String, dynamic>{'toolchain': instance.toolchain, 'types': instance.types};

_Versioning _$VersioningFromJson(Map<String, dynamic> json) => _Versioning(
  buildTime: json['buildTime'] as String,
  sources: json['sources'] as List<dynamic>,
  builtWith: BuiltWith.fromJson(json['builtWith'] as Map<String, dynamic>),
);

Map<String, dynamic> _$VersioningToJson(_Versioning instance) =>
    <String, dynamic>{
      'buildTime': instance.buildTime,
      'sources': instance.sources,
      'builtWith': instance.builtWith.toJson(),
    };

OAuthTokenResponse _$OAuthTokenResponseFromJson(Map<String, dynamic> json) =>
    OAuthTokenResponse($type: json['type'] as String?);

Map<String, dynamic> _$OAuthTokenResponseToJson(OAuthTokenResponse instance) =>
    <String, dynamic>{'type': instance.$type};

OAuthCodeResponse _$OAuthCodeResponseFromJson(Map<String, dynamic> json) =>
    OAuthCodeResponse(
      tokenEndpoint: json['tokenEndpoint'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$OAuthCodeResponseToJson(OAuthCodeResponse instance) =>
    <String, dynamic>{
      'tokenEndpoint': instance.tokenEndpoint,
      'type': instance.$type,
    };

OAuthPKCEResponse _$OAuthPKCEResponseFromJson(Map<String, dynamic> json) =>
    OAuthPKCEResponse(
      tokenEndpoint: json['tokenEndpoint'] as String,
      pkceCodeLength: json['pkceCodeLength'] as num,
      pkceCodeMethod: json['pkceCodeMethod'] as String,
      formEncodeGrant: json['formEncodeGrant'] as bool,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$OAuthPKCEResponseToJson(OAuthPKCEResponse instance) =>
    <String, dynamic>{
      'tokenEndpoint': instance.tokenEndpoint,
      'pkceCodeLength': instance.pkceCodeLength,
      'pkceCodeMethod': instance.pkceCodeMethod,
      'formEncodeGrant': instance.formEncodeGrant,
      'type': instance.$type,
    };

_SearchQuery _$SearchQueryFromJson(Map<String, dynamic> json) => _SearchQuery(
  title: json['title'] as String,
  filters:
      (json['filters'] as List<dynamic>?)
          ?.map((e) => SearchFilterValue.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$SearchQueryToJson(_SearchQuery instance) =>
    <String, dynamic>{
      'title': instance.title,
      'filters': instance.filters.map((e) => e.toJson()).toList(),
    };

_SearchResultItem _$SearchResultItemFromJson(Map<String, dynamic> json) =>
    _SearchResultItem(
      mangaId: json['mangaId'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String?,
      imageUrl: json['imageUrl'] as String,
      metadata: json['metadata'],
    );

Map<String, dynamic> _$SearchResultItemToJson(_SearchResultItem instance) =>
    <String, dynamic>{
      'mangaId': instance.mangaId,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'imageUrl': instance.imageUrl,
      'metadata': instance.metadata,
    };

_PagedResults<T> _$PagedResultsFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => _PagedResults<T>(
  items: (json['items'] as List<dynamic>).map(fromJsonT).toList(),
  metadata: json['metadata'],
);

Map<String, dynamic> _$PagedResultsToJson<T>(
  _PagedResults<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'items': instance.items.map(toJsonT).toList(),
  'metadata': instance.metadata,
};

_SourceManga _$SourceMangaFromJson(Map<String, dynamic> json) => _SourceManga(
  mangaId: json['mangaId'] as String,
  mangaInfo: MangaInfo.fromJson(json['mangaInfo'] as Map<String, dynamic>),
);

Map<String, dynamic> _$SourceMangaToJson(_SourceManga instance) =>
    <String, dynamic>{
      'mangaId': instance.mangaId,
      'mangaInfo': instance.mangaInfo.toJson(),
    };

_MangaInfo _$MangaInfoFromJson(Map<String, dynamic> json) => _MangaInfo(
  thumbnailUrl: json['thumbnailUrl'] as String,
  synopsis: json['synopsis'] as String,
  primaryTitle: json['primaryTitle'] as String,
  secondaryTitles:
      (json['secondaryTitles'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
  contentRating: const ContentRatingParser().fromJson(json['contentRating']),
  status: json['status'] as String?,
  artist: json['artist'] as String?,
  author: json['author'] as String?,
  bannerUrl: json['bannerUrl'] as String?,
  rating: json['rating'] as num?,
  tagGroups:
      (json['tagGroups'] as List<dynamic>?)
          ?.map((e) => TagSection.fromJson(e as Map<String, dynamic>))
          .toList(),
  artworkUrls:
      (json['artworkUrls'] as List<dynamic>?)?.map((e) => e as String).toList(),
  additionalInfo: (json['additionalInfo'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, e as String),
  ),
  shareUrl: json['shareUrl'] as String?,
);

Map<String, dynamic> _$MangaInfoToJson(
  _MangaInfo instance,
) => <String, dynamic>{
  'thumbnailUrl': instance.thumbnailUrl,
  'synopsis': instance.synopsis,
  'primaryTitle': instance.primaryTitle,
  'secondaryTitles': instance.secondaryTitles,
  'contentRating': const ContentRatingParser().toJson(instance.contentRating),
  'status': instance.status,
  'artist': instance.artist,
  'author': instance.author,
  'bannerUrl': instance.bannerUrl,
  'rating': instance.rating,
  'tagGroups': instance.tagGroups?.map((e) => e.toJson()).toList(),
  'artworkUrls': instance.artworkUrls,
  'additionalInfo': instance.additionalInfo,
  'shareUrl': instance.shareUrl,
};

_TagSection _$TagSectionFromJson(Map<String, dynamic> json) => _TagSection(
  id: json['id'] as String,
  title: json['title'] as String,
  tags:
      (json['tags'] as List<dynamic>)
          .map((e) => Tag.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$TagSectionToJson(_TagSection instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'tags': instance.tags.map((e) => e.toJson()).toList(),
    };

_Tag _$TagFromJson(Map<String, dynamic> json) =>
    _Tag(id: json['id'] as String, title: json['title'] as String);

Map<String, dynamic> _$TagToJson(_Tag instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
};

_Chapter _$ChapterFromJson(Map<String, dynamic> json) => _Chapter(
  chapterId: json['chapterId'] as String,
  sourceManga: SourceManga.fromJson(
    json['sourceManga'] as Map<String, dynamic>,
  ),
  langCode: json['langCode'] as String,
  chapNum: json['chapNum'] as num,
  title: json['title'] as String?,
  version: json['version'] as String?,
  volume: json['volume'] as num?,
  additionalInfo: (json['additionalInfo'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, e as String),
  ),
  publishDate: const NullableTimestampSerializer().fromJson(
    json['publishDate'],
  ),
  creationDate: const NullableTimestampSerializer().fromJson(
    json['creationDate'],
  ),
  sortingIndex: json['sortingIndex'] as num?,
);

Map<String, dynamic> _$ChapterToJson(_Chapter instance) => <String, dynamic>{
  'chapterId': instance.chapterId,
  'sourceManga': instance.sourceManga.toJson(),
  'langCode': instance.langCode,
  'chapNum': instance.chapNum,
  'title': instance.title,
  'version': instance.version,
  'volume': instance.volume,
  'additionalInfo': instance.additionalInfo,
  'publishDate': const NullableTimestampSerializer().toJson(
    instance.publishDate,
  ),
  'creationDate': const NullableTimestampSerializer().toJson(
    instance.creationDate,
  ),
  'sortingIndex': instance.sortingIndex,
};

_ChapterDetails _$ChapterDetailsFromJson(Map<String, dynamic> json) =>
    _ChapterDetails(
      id: json['id'] as String,
      mangaId: json['mangaId'] as String,
      pages: (json['pages'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ChapterDetailsToJson(_ChapterDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'mangaId': instance.mangaId,
      'pages': instance.pages,
    };

_DiscoverSection _$DiscoverSectionFromJson(Map<String, dynamic> json) =>
    _DiscoverSection(
      id: json['id'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String?,
      type: const DiscoverSectionTypeParser().fromJson(json['type']),
    );

Map<String, dynamic> _$DiscoverSectionToJson(_DiscoverSection instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'type': const DiscoverSectionTypeParser().toJson(instance.type),
    };

GenresCarouselItem _$GenresCarouselItemFromJson(Map<String, dynamic> json) =>
    GenresCarouselItem(
      searchQuery: SearchQuery.fromJson(
        json['searchQuery'] as Map<String, dynamic>,
      ),
      name: json['name'] as String,
      metadata: json['metadata'],
      contentRating: const NullableContentRatingParser().fromJson(
        json['contentRating'],
      ),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$GenresCarouselItemToJson(GenresCarouselItem instance) =>
    <String, dynamic>{
      'searchQuery': instance.searchQuery.toJson(),
      'name': instance.name,
      'metadata': instance.metadata,
      'contentRating': const NullableContentRatingParser().toJson(
        instance.contentRating,
      ),
      'type': instance.$type,
    };

ChapterUpdatesCarouselItem _$ChapterUpdatesCarouselItemFromJson(
  Map<String, dynamic> json,
) => ChapterUpdatesCarouselItem(
  mangaId: json['mangaId'] as String,
  chapterId: json['chapterId'] as String,
  imageUrl: json['imageUrl'] as String,
  title: json['title'] as String,
  subtitle: json['subtitle'] as String?,
  publishDate: const NullableTimestampSerializer().fromJson(
    json['publishDate'],
  ),
  metadata: json['metadata'],
  contentRating: const NullableContentRatingParser().fromJson(
    json['contentRating'],
  ),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$ChapterUpdatesCarouselItemToJson(
  ChapterUpdatesCarouselItem instance,
) => <String, dynamic>{
  'mangaId': instance.mangaId,
  'chapterId': instance.chapterId,
  'imageUrl': instance.imageUrl,
  'title': instance.title,
  'subtitle': instance.subtitle,
  'publishDate': const NullableTimestampSerializer().toJson(
    instance.publishDate,
  ),
  'metadata': instance.metadata,
  'contentRating': const NullableContentRatingParser().toJson(
    instance.contentRating,
  ),
  'type': instance.$type,
};

ProminentCarouselItem _$ProminentCarouselItemFromJson(
  Map<String, dynamic> json,
) => ProminentCarouselItem(
  mangaId: json['mangaId'] as String,
  imageUrl: json['imageUrl'] as String,
  title: json['title'] as String,
  subtitle: json['subtitle'] as String?,
  metadata: json['metadata'],
  contentRating: const NullableContentRatingParser().fromJson(
    json['contentRating'],
  ),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$ProminentCarouselItemToJson(
  ProminentCarouselItem instance,
) => <String, dynamic>{
  'mangaId': instance.mangaId,
  'imageUrl': instance.imageUrl,
  'title': instance.title,
  'subtitle': instance.subtitle,
  'metadata': instance.metadata,
  'contentRating': const NullableContentRatingParser().toJson(
    instance.contentRating,
  ),
  'type': instance.$type,
};

SimpleCarouselItem _$SimpleCarouselItemFromJson(Map<String, dynamic> json) =>
    SimpleCarouselItem(
      mangaId: json['mangaId'] as String,
      imageUrl: json['imageUrl'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String?,
      metadata: json['metadata'],
      contentRating: const NullableContentRatingParser().fromJson(
        json['contentRating'],
      ),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$SimpleCarouselItemToJson(SimpleCarouselItem instance) =>
    <String, dynamic>{
      'mangaId': instance.mangaId,
      'imageUrl': instance.imageUrl,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'metadata': instance.metadata,
      'contentRating': const NullableContentRatingParser().toJson(
        instance.contentRating,
      ),
      'type': instance.$type,
    };

FeaturedCarouselItem _$FeaturedCarouselItemFromJson(
  Map<String, dynamic> json,
) => FeaturedCarouselItem(
  mangaId: json['mangaId'] as String,
  imageUrl: json['imageUrl'] as String,
  title: json['title'] as String,
  supertitle: json['supertitle'] as String?,
  metadata: json['metadata'],
  contentRating: const NullableContentRatingParser().fromJson(
    json['contentRating'],
  ),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$FeaturedCarouselItemToJson(
  FeaturedCarouselItem instance,
) => <String, dynamic>{
  'mangaId': instance.mangaId,
  'imageUrl': instance.imageUrl,
  'title': instance.title,
  'supertitle': instance.supertitle,
  'metadata': instance.metadata,
  'contentRating': const NullableContentRatingParser().toJson(
    instance.contentRating,
  ),
  'type': instance.$type,
};

_SelectRowOption _$SelectRowOptionFromJson(Map<String, dynamic> json) =>
    _SelectRowOption(id: json['id'] as String, title: json['title'] as String);

Map<String, dynamic> _$SelectRowOptionToJson(_SelectRowOption instance) =>
    <String, dynamic>{'id': instance.id, 'title': instance.title};

LabelRowElement _$LabelRowElementFromJson(Map<String, dynamic> json) =>
    LabelRowElement(
      id: json['id'] as String,
      isHidden: json['isHidden'] as bool,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String?,
      value: json['value'] as String?,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$LabelRowElementToJson(LabelRowElement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'isHidden': instance.isHidden,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'value': instance.value,
      'type': instance.$type,
    };

InputRowElement _$InputRowElementFromJson(Map<String, dynamic> json) =>
    InputRowElement(
      id: json['id'] as String,
      isHidden: json['isHidden'] as bool,
      title: json['title'] as String,
      value: json['value'] as String,
      onValueChange: json['onValueChange'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$InputRowElementToJson(InputRowElement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'isHidden': instance.isHidden,
      'title': instance.title,
      'value': instance.value,
      'onValueChange': instance.onValueChange,
      'type': instance.$type,
    };

ToggleRowElement _$ToggleRowElementFromJson(Map<String, dynamic> json) =>
    ToggleRowElement(
      id: json['id'] as String,
      isHidden: json['isHidden'] as bool,
      title: json['title'] as String,
      value: json['value'] as bool,
      onValueChange: json['onValueChange'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$ToggleRowElementToJson(ToggleRowElement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'isHidden': instance.isHidden,
      'title': instance.title,
      'value': instance.value,
      'onValueChange': instance.onValueChange,
      'type': instance.$type,
    };

SelectRowElement _$SelectRowElementFromJson(Map<String, dynamic> json) =>
    SelectRowElement(
      id: json['id'] as String,
      isHidden: json['isHidden'] as bool,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String?,
      value: (json['value'] as List<dynamic>).map((e) => e as String).toList(),
      minItemCount: (json['minItemCount'] as num).toInt(),
      maxItemCount: (json['maxItemCount'] as num?)?.toInt(),
      options:
          (json['options'] as List<dynamic>)
              .map((e) => SelectRowOption.fromJson(e as Map<String, dynamic>))
              .toList(),
      onValueChange: json['onValueChange'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$SelectRowElementToJson(SelectRowElement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'isHidden': instance.isHidden,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'value': instance.value,
      'minItemCount': instance.minItemCount,
      'maxItemCount': instance.maxItemCount,
      'options': instance.options.map((e) => e.toJson()).toList(),
      'onValueChange': instance.onValueChange,
      'type': instance.$type,
    };

ButtonRowElement _$ButtonRowElementFromJson(Map<String, dynamic> json) =>
    ButtonRowElement(
      id: json['id'] as String,
      isHidden: json['isHidden'] as bool,
      title: json['title'] as String,
      onSelect: json['onSelect'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$ButtonRowElementToJson(ButtonRowElement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'isHidden': instance.isHidden,
      'title': instance.title,
      'onSelect': instance.onSelect,
      'type': instance.$type,
    };

NavigationRowElement _$NavigationRowElementFromJson(
  Map<String, dynamic> json,
) => NavigationRowElement(
  id: json['id'] as String,
  isHidden: json['isHidden'] as bool,
  title: json['title'] as String,
  subtitle: json['subtitle'] as String?,
  value: json['value'] as String?,
  form: json['form'] as String,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$NavigationRowElementToJson(
  NavigationRowElement instance,
) => <String, dynamic>{
  'id': instance.id,
  'isHidden': instance.isHidden,
  'title': instance.title,
  'subtitle': instance.subtitle,
  'value': instance.value,
  'form': instance.form,
  'type': instance.$type,
};

StepperRowElement _$StepperRowElementFromJson(Map<String, dynamic> json) =>
    StepperRowElement(
      id: json['id'] as String,
      isHidden: json['isHidden'] as bool,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String?,
      value: json['value'] as num,
      minValue: json['minValue'] as num,
      maxValue: json['maxValue'] as num,
      stepValue: json['stepValue'] as num,
      loopOver: json['loopOver'] as bool,
      onValueChange: json['onValueChange'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$StepperRowElementToJson(StepperRowElement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'isHidden': instance.isHidden,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'value': instance.value,
      'minValue': instance.minValue,
      'maxValue': instance.maxValue,
      'stepValue': instance.stepValue,
      'loopOver': instance.loopOver,
      'onValueChange': instance.onValueChange,
      'type': instance.$type,
    };

OAuthButtonRowElement _$OAuthButtonRowElementFromJson(
  Map<String, dynamic> json,
) => OAuthButtonRowElement(
  id: json['id'] as String,
  isHidden: json['isHidden'] as bool,
  title: json['title'] as String,
  subtitle: json['subtitle'] as String?,
  onSuccess: json['onSuccess'] as String,
  authorizeEndpoint: json['authorizeEndpoint'] as String,
  responseType: OAuthResponseType.fromJson(
    json['responseType'] as Map<String, dynamic>,
  ),
  clientId: json['clientId'] as String?,
  redirectUri: json['redirectUri'] as String?,
  scopes: (json['scopes'] as List<dynamic>?)?.map((e) => e as String).toList(),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$OAuthButtonRowElementToJson(
  OAuthButtonRowElement instance,
) => <String, dynamic>{
  'id': instance.id,
  'isHidden': instance.isHidden,
  'title': instance.title,
  'subtitle': instance.subtitle,
  'onSuccess': instance.onSuccess,
  'authorizeEndpoint': instance.authorizeEndpoint,
  'responseType': instance.responseType.toJson(),
  'clientId': instance.clientId,
  'redirectUri': instance.redirectUri,
  'scopes': instance.scopes,
  'type': instance.$type,
};

WebViewRowElement _$WebViewRowElementFromJson(Map<String, dynamic> json) =>
    WebViewRowElement(
      id: json['id'] as String,
      isHidden: json['isHidden'] as bool,
      title: json['title'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$WebViewRowElementToJson(WebViewRowElement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'isHidden': instance.isHidden,
      'title': instance.title,
      'type': instance.$type,
    };

_FormSectionElement _$FormSectionElementFromJson(Map<String, dynamic> json) =>
    _FormSectionElement(
      id: json['id'] as String,
      header: json['header'] as String?,
      footer: json['footer'] as String?,
      items:
          (json['items'] as List<dynamic>)
              .map((e) => FormItemElement.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$FormSectionElementToJson(_FormSectionElement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'header': instance.header,
      'footer': instance.footer,
      'items': instance.items.map((e) => e.toJson()).toList(),
    };

_FilterOption _$FilterOptionFromJson(Map<String, dynamic> json) =>
    _FilterOption(id: json['id'] as String, value: json['value'] as String);

Map<String, dynamic> _$FilterOptionToJson(_FilterOption instance) =>
    <String, dynamic>{'id': instance.id, 'value': instance.value};

DropdownSearchFilter _$DropdownSearchFilterFromJson(
  Map<String, dynamic> json,
) => DropdownSearchFilter(
  id: json['id'] as String,
  title: json['title'] as String,
  options:
      (json['options'] as List<dynamic>)
          .map((e) => FilterOption.fromJson(e as Map<String, dynamic>))
          .toList(),
  value: json['value'] as String,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$DropdownSearchFilterToJson(
  DropdownSearchFilter instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'options': instance.options.map((e) => e.toJson()).toList(),
  'value': instance.value,
  'type': instance.$type,
};

SelectSearchFilter _$SelectSearchFilterFromJson(Map<String, dynamic> json) =>
    SelectSearchFilter(
      id: json['id'] as String,
      title: json['title'] as String,
      options:
          (json['options'] as List<dynamic>)
              .map((e) => FilterOption.fromJson(e as Map<String, dynamic>))
              .toList(),
      value: Map<String, String>.from(json['value'] as Map),
      allowExclusion: json['allowExclusion'] as bool,
      allowEmptySelection: json['allowEmptySelection'] as bool,
      maximum: json['maximum'] as num?,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$SelectSearchFilterToJson(SelectSearchFilter instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'options': instance.options.map((e) => e.toJson()).toList(),
      'value': instance.value,
      'allowExclusion': instance.allowExclusion,
      'allowEmptySelection': instance.allowEmptySelection,
      'maximum': instance.maximum,
      'type': instance.$type,
    };

TagSearchFilter _$TagSearchFilterFromJson(Map<String, dynamic> json) =>
    TagSearchFilter(
      id: json['id'] as String,
      title: json['title'] as String,
      sections:
          (json['sections'] as List<dynamic>)
              .map((e) => TagSection.fromJson(e as Map<String, dynamic>))
              .toList(),
      value: (json['value'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, Map<String, String>.from(e as Map)),
      ),
      allowExclusion: json['allowExclusion'] as bool,
      allowEmptySelection: json['allowEmptySelection'] as bool,
      maximum: json['maximum'] as num?,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$TagSearchFilterToJson(TagSearchFilter instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'sections': instance.sections.map((e) => e.toJson()).toList(),
      'value': instance.value,
      'allowExclusion': instance.allowExclusion,
      'allowEmptySelection': instance.allowEmptySelection,
      'maximum': instance.maximum,
      'type': instance.$type,
    };

InputSearchFilter _$InputSearchFilterFromJson(Map<String, dynamic> json) =>
    InputSearchFilter(
      id: json['id'] as String,
      title: json['title'] as String,
      placeholder: json['placeholder'] as String,
      value: json['value'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$InputSearchFilterToJson(InputSearchFilter instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'placeholder': instance.placeholder,
      'value': instance.value,
      'type': instance.$type,
    };

_SearchFilterValue _$SearchFilterValueFromJson(Map<String, dynamic> json) =>
    _SearchFilterValue(
      id: json['id'] as String,
      value: json['value'] as Object,
    );

Map<String, dynamic> _$SearchFilterValueToJson(_SearchFilterValue instance) =>
    <String, dynamic>{'id': instance.id, 'value': instance.value};
