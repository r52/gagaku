// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'types.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_HistoryLink _$$_HistoryLinkFromJson(Map<String, dynamic> json) =>
    _$_HistoryLink(
      title: json['title'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$$_HistoryLinkToJson(_$_HistoryLink instance) =>
    <String, dynamic>{
      'title': instance.title,
      'url': instance.url,
    };

_$_WebManga _$$_WebMangaFromJson(Map<String, dynamic> json) => _$_WebManga(
      title: json['title'] as String,
      description: json['description'] as String,
      artist: json['artist'] as String,
      author: json['author'] as String,
      cover: json['cover'] as String,
      chapters: (json['chapters'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, WebChapter.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$$_WebMangaToJson(_$_WebManga instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'artist': instance.artist,
      'author': instance.author,
      'cover': instance.cover,
      'chapters': instance.chapters,
    };

_$_WebChapter _$$_WebChapterFromJson(Map<String, dynamic> json) =>
    _$_WebChapter(
      title: json['title'] as String,
      volume: json['volume'] as String,
      lastUpdated:
          const EpochTimestampSerializer().fromJson(json['last_updated']),
      groups: Map<String, String>.from(json['groups'] as Map),
    );

Map<String, dynamic> _$$_WebChapterToJson(_$_WebChapter instance) =>
    <String, dynamic>{
      'title': instance.title,
      'volume': instance.volume,
      'last_updated':
          const EpochTimestampSerializer().toJson(instance.lastUpdated),
      'groups': instance.groups,
    };

_$_ImgurPage _$$_ImgurPageFromJson(Map<String, dynamic> json) => _$_ImgurPage(
      description: json['description'] as String,
      src: json['src'] as String,
    );

Map<String, dynamic> _$$_ImgurPageToJson(_$_ImgurPage instance) =>
    <String, dynamic>{
      'description': instance.description,
      'src': instance.src,
    };
