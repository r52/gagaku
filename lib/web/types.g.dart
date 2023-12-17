// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'types.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HistoryLinkImpl _$$HistoryLinkImplFromJson(Map<String, dynamic> json) =>
    _$HistoryLinkImpl(
      title: json['title'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$$HistoryLinkImplToJson(_$HistoryLinkImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'url': instance.url,
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
