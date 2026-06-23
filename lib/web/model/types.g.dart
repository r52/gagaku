// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'types.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryLink _$HistoryLinkFromJson(Map<String, dynamic> json) => HistoryLink(
  title: json['title'] as String,
  url: json['url'] as String,
  cover: json['cover'] as String?,
  series: _historySeriesFromJson(_readHistorySeries(json, 'series')),
  lastAccessed: json['lastAccessed'] == null
      ? null
      : DateTime.parse(json['lastAccessed'] as String),
);

Map<String, dynamic> _$HistoryLinkToJson(HistoryLink instance) =>
    <String, dynamic>{
      'title': instance.title,
      'url': instance.url,
      'cover': instance.cover,
      'series': _historySeriesToJson(instance.series),
      'lastAccessed': instance.lastAccessed?.toIso8601String(),
    };

WebSourceInfo _$WebSourceInfoFromJson(Map<String, dynamic> json) =>
    WebSourceInfo(
      id: json['id'] as String,
      name: json['name'] as String,
      repo: json['repo'] as String,
      baseUrl: json['baseUrl'] as String?,
      version:
          $enumDecodeNullable(_$SupportedVersionEnumMap, json['version']) ??
          SupportedVersion.v0_9,
      icon: json['icon'] as String,
      capabilities:
          (json['capabilities'] as List<dynamic>?)
              ?.map(const SourceIntentParser().fromJson)
              .toList() ??
          const [SourceIntents.mangaChapters],
    );

Map<String, dynamic> _$WebSourceInfoToJson(WebSourceInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'repo': instance.repo,
      'baseUrl': instance.baseUrl,
      'version': _$SupportedVersionEnumMap[instance.version]!,
      'icon': instance.icon,
      'capabilities': instance.capabilities
          .map(const SourceIntentParser().toJson)
          .toList(),
    };

const _$SupportedVersionEnumMap = {SupportedVersion.v0_9: 'v0_9'};

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

ProxySeriesRef _$ProxySeriesRefFromJson(Map<String, dynamic> json) =>
    ProxySeriesRef(
      proxyId: json['proxyId'] as String,
      seriesId: json['seriesId'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$ProxySeriesRefToJson(ProxySeriesRef instance) =>
    <String, dynamic>{
      'proxyId': instance.proxyId,
      'seriesId': instance.seriesId,
      'type': instance.$type,
    };

ExtensionSeriesRef _$ExtensionSeriesRefFromJson(Map<String, dynamic> json) =>
    ExtensionSeriesRef(
      sourceId: json['sourceId'] as String,
      mangaId: json['mangaId'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$ExtensionSeriesRefToJson(ExtensionSeriesRef instance) =>
    <String, dynamic>{
      'sourceId': instance.sourceId,
      'mangaId': instance.mangaId,
      'type': instance.$type,
    };

_WebChapterRef _$WebChapterRefFromJson(Map<String, dynamic> json) =>
    _WebChapterRef(
      series: WebSeriesRef.fromJson(json['series'] as Map<String, dynamic>),
      chapterId: json['chapterId'] as String,
    );

Map<String, dynamic> _$WebChapterRefToJson(_WebChapterRef instance) =>
    <String, dynamic>{
      'series': instance.series.toJson(),
      'chapterId': instance.chapterId,
    };

_ResolvedWebLink _$ResolvedWebLinkFromJson(Map<String, dynamic> json) =>
    _ResolvedWebLink(
      series: WebSeriesRef.fromJson(json['series'] as Map<String, dynamic>),
      initialChapterId: json['initialChapterId'] as String?,
    );

Map<String, dynamic> _$ResolvedWebLinkToJson(_ResolvedWebLink instance) =>
    <String, dynamic>{
      'series': instance.series.toJson(),
      'initialChapterId': instance.initialChapterId,
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

_CubariChapterEntry _$CubariChapterEntryFromJson(Map<String, dynamic> json) =>
    _CubariChapterEntry(
      name: json['name'] as String,
      chapter: CubariChapter.fromJson(json['chapter'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CubariChapterEntryToJson(_CubariChapterEntry instance) =>
    <String, dynamic>{
      'name': instance.name,
      'chapter': instance.chapter.toJson(),
    };

WebMangaCubari _$WebMangaCubariFromJson(Map<String, dynamic> json) =>
    WebMangaCubari(
      title: json['title'] as String,
      description: json['description'] as String,
      artist: json['artist'] as String,
      author: json['author'] as String,
      cover: json['cover'] as String,
      groups: (json['groups'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      cubariChapters: const CubariChapterListConverter().fromJson(
        json['chapters'],
      ),
      $type: json['source_type'] as String?,
    );

Map<String, dynamic> _$WebMangaCubariToJson(WebMangaCubari instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'artist': instance.artist,
      'author': instance.author,
      'cover': instance.cover,
      'groups': instance.groups,
      'chapters': const CubariChapterListConverter().toJson(
        instance.cubariChapters,
      ),
      'source_type': instance.$type,
    };

WebMangaExtension _$WebMangaExtensionFromJson(Map<String, dynamic> json) =>
    WebMangaExtension(
      data: SourceManga.fromJson(json['data'] as Map<String, dynamic>),
      chaptersList: (json['chaptersList'] as List<dynamic>)
          .map((e) => Chapter.fromJson(e as Map<String, dynamic>))
          .toList(),
      $type: json['source_type'] as String?,
    );

Map<String, dynamic> _$WebMangaExtensionToJson(WebMangaExtension instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
      'chaptersList': instance.chaptersList.map((e) => e.toJson()).toList(),
      'source_type': instance.$type,
    };

_CubariChapter _$CubariChapterFromJson(Map<String, dynamic> json) =>
    _CubariChapter(
      title: json['title'] as String?,
      volume: json['volume'] as String?,
      lastUpdated: const EpochTimestampSerializer().fromJson(
        json['last_updated'],
      ),
      releaseDate: const MappedEpochTimestampSerializer().fromJson(
        json['release_date'],
      ),
      groups: json['groups'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$CubariChapterToJson(
  _CubariChapter instance,
) => <String, dynamic>{
  'title': instance.title,
  'volume': instance.volume,
  'last_updated': const EpochTimestampSerializer().toJson(instance.lastUpdated),
  'release_date': const MappedEpochTimestampSerializer().toJson(
    instance.releaseDate,
  ),
  'groups': instance.groups,
};

_ImgurPage _$ImgurPageFromJson(Map<String, dynamic> json) => _ImgurPage(
  description: json['description'] as String,
  src: json['src'] as String,
);

Map<String, dynamic> _$ImgurPageToJson(_ImgurPage instance) =>
    <String, dynamic>{'description': instance.description, 'src': instance.src};

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
  badges: (json['badges'] as List<dynamic>)
      .map((e) => SourceBadge.fromJson(e as Map<String, dynamic>))
      .toList(),
  developers: (json['developers'] as List<dynamic>)
      .map((e) => SourceDeveloper.fromJson(e as Map<String, dynamic>))
      .toList(),
  capabilities: const SourceIntentOrListParser().fromJson(json['capabilities']),
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
};

_BuiltWith _$BuiltWithFromJson(Map<String, dynamic> json) => _BuiltWith(
  toolchain: json['toolchain'] as String,
  types: json['types'] as String,
);

Map<String, dynamic> _$BuiltWithToJson(_BuiltWith instance) =>
    <String, dynamic>{'toolchain': instance.toolchain, 'types': instance.types};

_RepositoryDescription _$RepositoryDescriptionFromJson(
  Map<String, dynamic> json,
) => _RepositoryDescription(
  name: json['name'] as String,
  description: json['description'] as String?,
);

Map<String, dynamic> _$RepositoryDescriptionToJson(
  _RepositoryDescription instance,
) => <String, dynamic>{
  'name': instance.name,
  'description': instance.description,
};

_Versioning _$VersioningFromJson(Map<String, dynamic> json) => _Versioning(
  buildTime: json['buildTime'] as String,
  sources: json['sources'] as List<dynamic>,
  builtWith: BuiltWith.fromJson(json['builtWith'] as Map<String, dynamic>),
  repository: json['repository'] == null
      ? null
      : RepositoryDescription.fromJson(
          json['repository'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$VersioningToJson(_Versioning instance) =>
    <String, dynamic>{
      'buildTime': instance.buildTime,
      'sources': instance.sources,
      'builtWith': instance.builtWith.toJson(),
      'repository': instance.repository?.toJson(),
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

_SortingOption _$SortingOptionFromJson(Map<String, dynamic> json) =>
    _SortingOption(id: json['id'] as String, label: json['label'] as String);

Map<String, dynamic> _$SortingOptionToJson(_SortingOption instance) =>
    <String, dynamic>{'id': instance.id, 'label': instance.label};

_SearchQuery _$SearchQueryFromJson(Map<String, dynamic> json) =>
    _SearchQuery(title: json['title'] as String, metadata: json['metadata']);

Map<String, dynamic> _$SearchQueryToJson(_SearchQuery instance) =>
    <String, dynamic>{'title': instance.title, 'metadata': instance.metadata};

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
  secondaryTitles: (json['secondaryTitles'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  contentRating: const ContentRatingParser().fromJson(json['contentRating']),
  contentType: $enumDecodeNullable(
    _$MangaContentTypeEnumMap,
    json['contentType'],
  ),
  status: json['status'] as String?,
  artist: json['artist'] as String?,
  author: json['author'] as String?,
  bannerUrl: json['bannerUrl'] as String?,
  rating: json['rating'] as num?,
  tagGroups: (json['tagGroups'] as List<dynamic>?)
      ?.map((e) => TagSection.fromJson(e as Map<String, dynamic>))
      .toList(),
  artworkUrls: (json['artworkUrls'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
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
  'contentType': _$MangaContentTypeEnumMap[instance.contentType],
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

const _$MangaContentTypeEnumMap = {
  MangaContentType.comic: 'comic',
  MangaContentType.novel: 'novel',
};

_TagSection _$TagSectionFromJson(Map<String, dynamic> json) => _TagSection(
  id: json['id'] as String,
  title: json['title'] as String,
  tags: (json['tags'] as List<dynamic>)
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

_PaperbackRequest _$PaperbackRequestFromJson(Map<String, dynamic> json) =>
    _PaperbackRequest(
      url: json['url'] as String,
      method: json['method'] as String,
      headers: (json['headers'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      body: json['body'],
      cookies: (json['cookies'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
    );

Map<String, dynamic> _$PaperbackRequestToJson(_PaperbackRequest instance) =>
    <String, dynamic>{
      'url': instance.url,
      'method': instance.method,
      'headers': instance.headers,
      'body': instance.body,
      'cookies': instance.cookies,
    };

ImageChapterDetails _$ImageChapterDetailsFromJson(Map<String, dynamic> json) =>
    ImageChapterDetails(
      id: json['id'] as String,
      mangaId: json['mangaId'] as String,
      pages: (json['pages'] as List<dynamic>).map((e) => e as String).toList(),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$ImageChapterDetailsToJson(
  ImageChapterDetails instance,
) => <String, dynamic>{
  'id': instance.id,
  'mangaId': instance.mangaId,
  'pages': instance.pages,
  'type': instance.$type,
};

HtmlChapterDetails _$HtmlChapterDetailsFromJson(Map<String, dynamic> json) =>
    HtmlChapterDetails(
      id: json['id'] as String,
      mangaId: json['mangaId'] as String,
      html: json['html'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$HtmlChapterDetailsToJson(HtmlChapterDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'mangaId': instance.mangaId,
      'html': instance.html,
      'type': instance.$type,
    };

FileChapterDetails _$FileChapterDetailsFromJson(Map<String, dynamic> json) =>
    FileChapterDetails(
      id: json['id'] as String,
      mangaId: json['mangaId'] as String,
      format: $enumDecode(_$ChapterFileFormatEnumMap, json['format']),
      request: PaperbackRequest.fromJson(
        json['request'] as Map<String, dynamic>,
      ),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$FileChapterDetailsToJson(FileChapterDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'mangaId': instance.mangaId,
      'format': _$ChapterFileFormatEnumMap[instance.format]!,
      'request': instance.request.toJson(),
      'type': instance.$type,
    };

const _$ChapterFileFormatEnumMap = {
  ChapterFileFormat.epub: 'epub',
  ChapterFileFormat.pdf: 'pdf',
  ChapterFileFormat.cbz: 'cbz',
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
  summary: json['summary'] as String?,
  infoItems: (json['infoItems'] as List<dynamic>?)
      ?.map((e) => InfoItem.fromJson(e as Map<String, dynamic>))
      .toList(),
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
  'summary': instance.summary,
  'infoItems': instance.infoItems?.map((e) => e.toJson()).toList(),
  'metadata': instance.metadata,
  'contentRating': const NullableContentRatingParser().toJson(
    instance.contentRating,
  ),
  'type': instance.$type,
};

_InfoItem _$InfoItemFromJson(Map<String, dynamic> json) =>
    _InfoItem(symbol: json['symbol'] as String, text: json['text'] as String);

Map<String, dynamic> _$InfoItemToJson(_InfoItem instance) => <String, dynamic>{
  'symbol': instance.symbol,
  'text': instance.text,
};

_LabelRowValue _$LabelRowValueFromJson(Map<String, dynamic> json) =>
    _LabelRowValue(
      text: json['text'] as String?,
      symbol: json['symbol'] as String?,
      style: $enumDecodeNullable(_$RowStyleEnumMap, json['style']),
    );

Map<String, dynamic> _$LabelRowValueToJson(_LabelRowValue instance) =>
    <String, dynamic>{
      'text': instance.text,
      'symbol': instance.symbol,
      'style': _$RowStyleEnumMap[instance.style],
    };

const _$RowStyleEnumMap = {
  RowStyle.warning: 'warning',
  RowStyle.error: 'error',
  RowStyle.success: 'success',
  RowStyle.tinted: 'tinted',
};

LabelRowElement _$LabelRowElementFromJson(Map<String, dynamic> json) =>
    LabelRowElement(
      id: json['id'] as String,
      isHidden: json['isHidden'] as bool,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String?,
      value: const LabelRowValueConverter().fromJson(json['value']),
      style: $enumDecodeNullable(_$RowStyleEnumMap, json['style']),
      onSelect: json['onSelect'] as String?,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$LabelRowElementToJson(LabelRowElement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'isHidden': instance.isHidden,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'value': const LabelRowValueConverter().toJson(instance.value),
      'style': _$RowStyleEnumMap[instance.style],
      'onSelect': instance.onSelect,
      'type': instance.$type,
    };

InputRowElement _$InputRowElementFromJson(Map<String, dynamic> json) =>
    InputRowElement(
      id: json['id'] as String,
      isHidden: json['isHidden'] as bool,
      title: json['title'] as String,
      value: json['value'] as String,
      isSecureEntry: json['isSecureEntry'] as bool?,
      onValueChange: json['onValueChange'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$InputRowElementToJson(InputRowElement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'isHidden': instance.isHidden,
      'title': instance.title,
      'value': instance.value,
      'isSecureEntry': instance.isSecureEntry,
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

FlowSectionElement _$FlowSectionElementFromJson(Map<String, dynamic> json) =>
    FlowSectionElement(
      id: json['id'] as String,
      header: json['header'] as String?,
      footer: json['footer'] as String?,
      items: (json['items'] as List<dynamic>)
          .map((e) => FormItemElement.fromJson(e as Map<String, dynamic>))
          .toList(),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$FlowSectionElementToJson(FlowSectionElement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'header': instance.header,
      'footer': instance.footer,
      'items': instance.items.map((e) => e.toJson()).toList(),
      'type': instance.$type,
    };

ListSectionElement _$ListSectionElementFromJson(Map<String, dynamic> json) =>
    ListSectionElement(
      id: json['id'] as String,
      header: json['header'] as String?,
      footer: json['footer'] as String?,
      items: (json['items'] as List<dynamic>)
          .map((e) => FormItemElement.fromJson(e as Map<String, dynamic>))
          .toList(),
      allowDeletion: json['allowDeletion'] as bool,
      allowAddition: json['allowAddition'] as bool,
      allowReorder: json['allowReorder'] as bool,
      onReorder: json['onReorder'] as String?,
      onDeletion: json['onDeletion'] as String?,
      onAddition: json['onAddition'] as String?,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$ListSectionElementToJson(ListSectionElement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'header': instance.header,
      'footer': instance.footer,
      'items': instance.items.map((e) => e.toJson()).toList(),
      'allowDeletion': instance.allowDeletion,
      'allowAddition': instance.allowAddition,
      'allowReorder': instance.allowReorder,
      'onReorder': instance.onReorder,
      'onDeletion': instance.onDeletion,
      'onAddition': instance.onAddition,
      'type': instance.$type,
    };

_ExecuteInWebViewSource _$ExecuteInWebViewSourceFromJson(
  Map<String, dynamic> json,
) => _ExecuteInWebViewSource(
  html: json['html'] as String,
  baseUrl: json['baseUrl'] as String,
  loadCSS: json['loadCSS'] as bool,
  loadImages: json['loadImages'] as bool,
  userAgent: json['userAgent'] as String?,
);

Map<String, dynamic> _$ExecuteInWebViewSourceToJson(
  _ExecuteInWebViewSource instance,
) => <String, dynamic>{
  'html': instance.html,
  'baseUrl': instance.baseUrl,
  'loadCSS': instance.loadCSS,
  'loadImages': instance.loadImages,
  'userAgent': instance.userAgent,
};

_PaperbackCookie _$PaperbackCookieFromJson(Map<String, dynamic> json) =>
    _PaperbackCookie(
      name: json['name'] as String,
      value: json['value'] as String,
      domain: json['domain'] as String,
      path: json['path'] as String?,
      created: json['created'] == null
          ? null
          : DateTime.parse(json['created'] as String),
      expires: json['expires'] == null
          ? null
          : DateTime.parse(json['expires'] as String),
    );

Map<String, dynamic> _$PaperbackCookieToJson(_PaperbackCookie instance) =>
    <String, dynamic>{
      'name': instance.name,
      'value': instance.value,
      'domain': instance.domain,
      'path': instance.path,
      'created': instance.created?.toIso8601String(),
      'expires': instance.expires?.toIso8601String(),
    };

_WebViewStorage _$WebViewStorageFromJson(Map<String, dynamic> json) =>
    _WebViewStorage(
      cookies:
          (json['cookies'] as List<dynamic>?)
              ?.map((e) => PaperbackCookie.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$WebViewStorageToJson(_WebViewStorage instance) =>
    <String, dynamic>{
      'cookies': instance.cookies.map((e) => e.toJson()).toList(),
    };

_ExecuteInWebViewContext _$ExecuteInWebViewContextFromJson(
  Map<String, dynamic> json,
) => _ExecuteInWebViewContext(
  source: ExecuteInWebViewSource.fromJson(
    json['source'] as Map<String, dynamic>,
  ),
  inject: json['inject'] as String,
  storage: json['storage'] == null
      ? const WebViewStorage()
      : WebViewStorage.fromJson(json['storage'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ExecuteInWebViewContextToJson(
  _ExecuteInWebViewContext instance,
) => <String, dynamic>{
  'source': instance.source.toJson(),
  'inject': instance.inject,
  'storage': instance.storage.toJson(),
};

_WebViewExecutionResult _$WebViewExecutionResultFromJson(
  Map<String, dynamic> json,
) => _WebViewExecutionResult(
  result: json['result'],
  storage: json['storage'] == null
      ? const WebViewStorage()
      : WebViewStorage.fromJson(json['storage'] as Map<String, dynamic>),
);

Map<String, dynamic> _$WebViewExecutionResultToJson(
  _WebViewExecutionResult instance,
) => <String, dynamic>{
  'result': instance.result,
  'storage': instance.storage.toJson(),
};
