// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'types.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HistoryLinkImpl _$$HistoryLinkImplFromJson(Map<String, dynamic> json) =>
    _$HistoryLinkImpl(
      title: json['title'] as String,
      url: json['url'] as String,
      cover: json['cover'] as String?,
    );

Map<String, dynamic> _$$HistoryLinkImplToJson(_$HistoryLinkImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'url': instance.url,
      'cover': instance.cover,
    };

_$WebMangaImpl _$$WebMangaImplFromJson(Map<String, dynamic> json) =>
    _$WebMangaImpl(
      title: json['title'] as String,
      description: json['description'] as String,
      artist: json['artist'] as String,
      author: json['author'] as String,
      cover: json['cover'] as String,
      groups: (json['groups'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      chapters: (json['chapters'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, WebChapter.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$$WebMangaImplToJson(_$WebMangaImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'artist': instance.artist,
      'author': instance.author,
      'cover': instance.cover,
      'groups': instance.groups,
      'chapters': instance.chapters,
    };

_$WebChapterImpl _$$WebChapterImplFromJson(Map<String, dynamic> json) =>
    _$WebChapterImpl(
      title: json['title'] as String?,
      volume: json['volume'] as String?,
      lastUpdated:
          const EpochTimestampSerializer().fromJson(json['last_updated']),
      releaseDate:
          const MappedEpochTimestampSerializer().fromJson(json['release_date']),
      groups: json['groups'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$$WebChapterImplToJson(_$WebChapterImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'volume': instance.volume,
      'last_updated':
          const EpochTimestampSerializer().toJson(instance.lastUpdated),
      'release_date':
          const MappedEpochTimestampSerializer().toJson(instance.releaseDate),
      'groups': instance.groups,
    };

_$ImgurPageImpl _$$ImgurPageImplFromJson(Map<String, dynamic> json) =>
    _$ImgurPageImpl(
      description: json['description'] as String,
      src: json['src'] as String,
    );

Map<String, dynamic> _$$ImgurPageImplToJson(_$ImgurPageImpl instance) =>
    <String, dynamic>{
      'description': instance.description,
      'src': instance.src,
    };

_$WebSourceInfoImpl _$$WebSourceInfoImplFromJson(Map<String, dynamic> json) =>
    _$WebSourceInfoImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      repo: json['repo'] as String,
      icon: json['icon'] as String?,
    );

Map<String, dynamic> _$$WebSourceInfoImplToJson(_$WebSourceInfoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'repo': instance.repo,
      'icon': instance.icon,
    };

_$BadgeImpl _$$BadgeImplFromJson(Map<String, dynamic> json) => _$BadgeImpl(
      text: json['text'] as String,
      type: $enumDecode(_$BadgeColorEnumMap, json['type']),
    );

Map<String, dynamic> _$$BadgeImplToJson(_$BadgeImpl instance) =>
    <String, dynamic>{
      'text': instance.text,
      'type': _$BadgeColorEnumMap[instance.type]!,
    };

const _$BadgeColorEnumMap = {
  BadgeColor.success: 'success',
  BadgeColor.info: 'info',
  BadgeColor.warning: 'warning',
  BadgeColor.danger: 'danger',
};

_$SourceVersionImpl _$$SourceVersionImplFromJson(Map<String, dynamic> json) =>
    _$SourceVersionImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      author: json['author'] as String,
      desc: json['desc'] as String,
      website: json['website'] as String?,
      contentRating: $enumDecode(_$ContentRatingEnumMap, json['contentRating']),
      version: json['version'] as String,
      icon: json['icon'] as String,
      tags: (json['tags'] as List<dynamic>?)
          ?.map((e) => Badge.fromJson(e as Map<String, dynamic>))
          .toList(),
      websiteBaseURL: json['websiteBaseURL'] as String,
      intents: (json['intents'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$SourceVersionImplToJson(_$SourceVersionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'author': instance.author,
      'desc': instance.desc,
      'website': instance.website,
      'contentRating': _$ContentRatingEnumMap[instance.contentRating]!,
      'version': instance.version,
      'icon': instance.icon,
      'tags': instance.tags,
      'websiteBaseURL': instance.websiteBaseURL,
      'intents': instance.intents,
    };

const _$ContentRatingEnumMap = {
  ContentRating.EVERYONE: 'EVERYONE',
  ContentRating.MATURE: 'MATURE',
  ContentRating.ADULT: 'ADULT',
};

_$SourceInfoImpl _$$SourceInfoImplFromJson(Map<String, dynamic> json) =>
    _$SourceInfoImpl(
      name: json['name'] as String,
      author: json['author'] as String,
      description: json['description'] as String,
      contentRating: $enumDecode(_$ContentRatingEnumMap, json['contentRating']),
      version: json['version'] as String,
      icon: json['icon'] as String,
      websiteBaseURL: json['websiteBaseURL'] as String,
      authorWebsite: json['authorWebsite'] as String?,
      language: json['language'] as String?,
      sourceTags: (json['sourceTags'] as List<dynamic>?)
          ?.map((e) => Badge.fromJson(e as Map<String, dynamic>))
          .toList(),
      intents: (json['intents'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$SourceInfoImplToJson(_$SourceInfoImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'author': instance.author,
      'description': instance.description,
      'contentRating': _$ContentRatingEnumMap[instance.contentRating]!,
      'version': instance.version,
      'icon': instance.icon,
      'websiteBaseURL': instance.websiteBaseURL,
      'authorWebsite': instance.authorWebsite,
      'language': instance.language,
      'sourceTags': instance.sourceTags,
      'intents': instance.intents,
    };

_$BuiltWithImpl _$$BuiltWithImplFromJson(Map<String, dynamic> json) =>
    _$BuiltWithImpl(
      toolchain: json['toolchain'] as String,
      types: json['types'] as String,
    );

Map<String, dynamic> _$$BuiltWithImplToJson(_$BuiltWithImpl instance) =>
    <String, dynamic>{
      'toolchain': instance.toolchain,
      'types': instance.types,
    };

_$VersioningImpl _$$VersioningImplFromJson(Map<String, dynamic> json) =>
    _$VersioningImpl(
      buildTime: json['buildTime'] as String,
      sources: (json['sources'] as List<dynamic>)
          .map((e) => SourceVersion.fromJson(e as Map<String, dynamic>))
          .toList(),
      builtWith: BuiltWith.fromJson(json['builtWith'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$VersioningImplToJson(_$VersioningImpl instance) =>
    <String, dynamic>{
      'buildTime': instance.buildTime,
      'sources': instance.sources,
      'builtWith': instance.builtWith,
    };

_$RepoInfoImpl _$$RepoInfoImplFromJson(Map<String, dynamic> json) =>
    _$RepoInfoImpl(
      name: json['name'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$$RepoInfoImplToJson(_$RepoInfoImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
    };

_$PartialSourceMangaImpl _$$PartialSourceMangaImplFromJson(
        Map<String, dynamic> json) =>
    _$PartialSourceMangaImpl(
      mangaId: json['mangaId'] as String,
      image: json['image'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String?,
    );

Map<String, dynamic> _$$PartialSourceMangaImplToJson(
        _$PartialSourceMangaImpl instance) =>
    <String, dynamic>{
      'mangaId': instance.mangaId,
      'image': instance.image,
      'title': instance.title,
      'subtitle': instance.subtitle,
    };

_$PagedResultsImpl _$$PagedResultsImplFromJson(Map<String, dynamic> json) =>
    _$PagedResultsImpl(
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => PartialSourceManga.fromJson(e as Map<String, dynamic>))
          .toList(),
      metadata: json['metadata'],
    );

Map<String, dynamic> _$$PagedResultsImplToJson(_$PagedResultsImpl instance) =>
    <String, dynamic>{
      'results': instance.results,
      'metadata': instance.metadata,
    };

_$MangaInfoImpl _$$MangaInfoImplFromJson(Map<String, dynamic> json) =>
    _$MangaInfoImpl(
      image: json['image'] as String,
      artist: json['artist'] as String?,
      author: json['author'] as String?,
      desc: json['desc'] as String,
      status: json['status'] as String,
      hentai: json['hentai'] as bool?,
      titles:
          (json['titles'] as List<dynamic>).map((e) => e as String).toList(),
      banner: json['banner'] as String?,
      rating: json['rating'] as num?,
      tags: (json['tags'] as List<dynamic>?)
          ?.map((e) => TagSection.fromJson(e as Map<String, dynamic>))
          .toList(),
      covers:
          (json['covers'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$MangaInfoImplToJson(_$MangaInfoImpl instance) =>
    <String, dynamic>{
      'image': instance.image,
      'artist': instance.artist,
      'author': instance.author,
      'desc': instance.desc,
      'status': instance.status,
      'hentai': instance.hentai,
      'titles': instance.titles,
      'banner': instance.banner,
      'rating': instance.rating,
      'tags': instance.tags,
      'covers': instance.covers,
    };

_$TagImpl _$$TagImplFromJson(Map<String, dynamic> json) => _$TagImpl(
      id: json['id'] as String,
      label: json['label'] as String,
    );

Map<String, dynamic> _$$TagImplToJson(_$TagImpl instance) => <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
    };

_$TagSectionImpl _$$TagSectionImplFromJson(Map<String, dynamic> json) =>
    _$TagSectionImpl(
      id: json['id'] as String,
      label: json['label'] as String,
      tags: (json['tags'] as List<dynamic>)
          .map((e) => Tag.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$TagSectionImplToJson(_$TagSectionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'tags': instance.tags,
    };

_$SourceMangaImpl _$$SourceMangaImplFromJson(Map<String, dynamic> json) =>
    _$SourceMangaImpl(
      id: json['id'] as String,
      mangaInfo: MangaInfo.fromJson(json['mangaInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$SourceMangaImplToJson(_$SourceMangaImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'mangaInfo': instance.mangaInfo,
    };

_$ChapterImpl _$$ChapterImplFromJson(Map<String, dynamic> json) =>
    _$ChapterImpl(
      id: json['id'] as String,
      chapNum: json['chapNum'] as num,
      langCode: json['langCode'] as String?,
      name: json['name'] as String?,
      volume: json['volume'] as num?,
      group: json['group'] as String?,
      time: const TimestampSerializer().fromJson(json['time']),
      sortingIndex: json['sortingIndex'] as num?,
    );

Map<String, dynamic> _$$ChapterImplToJson(_$ChapterImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'chapNum': instance.chapNum,
      'langCode': instance.langCode,
      'name': instance.name,
      'volume': instance.volume,
      'group': instance.group,
      'time': _$JsonConverterToJson<dynamic, DateTime>(
          instance.time, const TimestampSerializer().toJson),
      'sortingIndex': instance.sortingIndex,
    };

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);

_$ChapterDetailsImpl _$$ChapterDetailsImplFromJson(Map<String, dynamic> json) =>
    _$ChapterDetailsImpl(
      id: json['id'] as String,
      mangaId: json['mangaId'] as String,
      pages: (json['pages'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$ChapterDetailsImplToJson(
        _$ChapterDetailsImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'mangaId': instance.mangaId,
      'pages': instance.pages,
    };

_$SearchRequestImpl _$$SearchRequestImplFromJson(Map<String, dynamic> json) =>
    _$SearchRequestImpl(
      title: json['title'] as String?,
      includedTags: (json['includedTags'] as List<dynamic>?)
          ?.map((e) => Tag.fromJson(e as Map<String, dynamic>))
          .toList(),
      excludedTags: (json['excludedTags'] as List<dynamic>?)
          ?.map((e) => Tag.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$SearchRequestImplToJson(_$SearchRequestImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'includedTags': instance.includedTags,
      'excludedTags': instance.excludedTags,
    };

_$HomeSectionImpl _$$HomeSectionImplFromJson(Map<String, dynamic> json) =>
    _$HomeSectionImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => PartialSourceManga.fromJson(e as Map<String, dynamic>))
          .toList(),
      containsMoreItems: json['containsMoreItems'] as bool,
    );

Map<String, dynamic> _$$HomeSectionImplToJson(_$HomeSectionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'items': instance.items,
      'containsMoreItems': instance.containsMoreItems,
    };
