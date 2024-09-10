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
      name: json['name'] as String,
      version: json['version'] as String,
      baseUrl: json['baseUrl'] as String,
      mangaPath: json['mangaPath'] as String,
      search: json['search'] as String,
      manga: json['manga'] as String,
      pages: json['pages'] as String,
    );

Map<String, dynamic> _$$WebSourceInfoImplToJson(_$WebSourceInfoImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'version': instance.version,
      'baseUrl': instance.baseUrl,
      'mangaPath': instance.mangaPath,
      'search': instance.search,
      'manga': instance.manga,
      'pages': instance.pages,
    };

_$RepoInfoImpl _$$RepoInfoImplFromJson(Map<String, dynamic> json) =>
    _$RepoInfoImpl(
      name: json['name'] as String,
      version: json['version'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$$RepoInfoImplToJson(_$RepoInfoImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'version': instance.version,
      'url': instance.url,
    };
