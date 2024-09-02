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

_$TagParserImpl _$$TagParserImplFromJson(Map<String, dynamic> json) =>
    _$TagParserImpl(
      pattern: json['pattern'] as String,
      content: json['content'] as String?,
      format: json['format'] as String?,
    );

Map<String, dynamic> _$$TagParserImplToJson(_$TagParserImpl instance) =>
    <String, dynamic>{
      'pattern': instance.pattern,
      'content': instance.content,
      'format': instance.format,
    };

_$WebSourceImpl _$$WebSourceImplFromJson(Map<String, dynamic> json) =>
    _$WebSourceImpl(
      name: json['name'] as String,
      version: json['version'] as String,
      type: $enumDecode(_$WebSourceParseTypeEnumMap, json['type']),
      baseUrl: json['baseUrl'] as String,
      search: WebSourceSearchParser.fromJson(
          json['search'] as Map<String, dynamic>),
      manga: json['manga'] == null
          ? null
          : WebSourceMangaParser.fromJson(
              json['manga'] as Map<String, dynamic>),
      slug: json['slug'] as String,
    );

Map<String, dynamic> _$$WebSourceImplToJson(_$WebSourceImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'version': instance.version,
      'type': _$WebSourceParseTypeEnumMap[instance.type]!,
      'baseUrl': instance.baseUrl,
      'search': instance.search,
      'manga': instance.manga,
      'slug': instance.slug,
    };

const _$WebSourceParseTypeEnumMap = {
  WebSourceParseType.html: 'html',
  WebSourceParseType.regex: 'regex',
};

_$WebSourceSearchParserImpl _$$WebSourceSearchParserImplFromJson(
        Map<String, dynamic> json) =>
    _$WebSourceSearchParserImpl(
      searchPath: json['searchPath'] as String,
      items: TagParser.fromJson(json['items'] as Map<String, dynamic>),
      url: TagParser.fromJson(json['url'] as Map<String, dynamic>),
      cover: TagParser.fromJson(json['cover'] as Map<String, dynamic>),
      title: TagParser.fromJson(json['title'] as Map<String, dynamic>),
      altTitles: json['altTitles'] == null
          ? null
          : TagParser.fromJson(json['altTitles'] as Map<String, dynamic>),
      urlTrim: json['urlTrim'] == null
          ? null
          : TagParser.fromJson(json['urlTrim'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$WebSourceSearchParserImplToJson(
        _$WebSourceSearchParserImpl instance) =>
    <String, dynamic>{
      'searchPath': instance.searchPath,
      'items': instance.items,
      'url': instance.url,
      'cover': instance.cover,
      'title': instance.title,
      'altTitles': instance.altTitles,
      'urlTrim': instance.urlTrim,
    };

_$WebSourceMangaParserImpl _$$WebSourceMangaParserImplFromJson(
        Map<String, dynamic> json) =>
    _$WebSourceMangaParserImpl(
      mangaPath: json['mangaPath'] as String,
      title: TagParser.fromJson(json['title'] as Map<String, dynamic>),
      description:
          TagParser.fromJson(json['description'] as Map<String, dynamic>),
      artist: TagParser.fromJson(json['artist'] as Map<String, dynamic>),
      author: TagParser.fromJson(json['author'] as Map<String, dynamic>),
      cover: TagParser.fromJson(json['cover'] as Map<String, dynamic>),
      chapters: WebSourceChapterParser.fromJson(
          json['chapters'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$WebSourceMangaParserImplToJson(
        _$WebSourceMangaParserImpl instance) =>
    <String, dynamic>{
      'mangaPath': instance.mangaPath,
      'title': instance.title,
      'description': instance.description,
      'artist': instance.artist,
      'author': instance.author,
      'cover': instance.cover,
      'chapters': instance.chapters,
    };

_$WebSourceChapterParserImpl _$$WebSourceChapterParserImplFromJson(
        Map<String, dynamic> json) =>
    _$WebSourceChapterParserImpl(
      items: TagParser.fromJson(json['items'] as Map<String, dynamic>),
      url: TagParser.fromJson(json['url'] as Map<String, dynamic>),
      title: TagParser.fromJson(json['title'] as Map<String, dynamic>),
      lastUpdated:
          TagParser.fromJson(json['lastUpdated'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$WebSourceChapterParserImplToJson(
        _$WebSourceChapterParserImpl instance) =>
    <String, dynamic>{
      'items': instance.items,
      'url': instance.url,
      'title': instance.title,
      'lastUpdated': instance.lastUpdated,
    };
