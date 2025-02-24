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
      lastUpdated: const EpochTimestampSerializer().fromJson(
        json['last_updated'],
      ),
      releaseDate: const MappedEpochTimestampSerializer().fromJson(
        json['release_date'],
      ),
      groups: json['groups'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$$WebChapterImplToJson(
  _$WebChapterImpl instance,
) => <String, dynamic>{
  'title': instance.title,
  'volume': instance.volume,
  'last_updated': const EpochTimestampSerializer().toJson(instance.lastUpdated),
  'release_date': const MappedEpochTimestampSerializer().toJson(
    instance.releaseDate,
  ),
  'groups': instance.groups,
};

_$ImgurPageImpl _$$ImgurPageImplFromJson(Map<String, dynamic> json) =>
    _$ImgurPageImpl(
      description: json['description'] as String,
      src: json['src'] as String,
    );

Map<String, dynamic> _$$ImgurPageImplToJson(_$ImgurPageImpl instance) =>
    <String, dynamic>{'description': instance.description, 'src': instance.src};

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

_$SourceIdentifierImpl _$$SourceIdentifierImplFromJson(
  Map<String, dynamic> json,
) => _$SourceIdentifierImpl(
  internal: WebSourceInfo.fromJson(json['internal'] as Map<String, dynamic>),
  external: SourceInfo.fromJson(json['external'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$SourceIdentifierImplToJson(
  _$SourceIdentifierImpl instance,
) => <String, dynamic>{
  'internal': instance.internal,
  'external': instance.external,
};

_$BadgeImpl _$$BadgeImplFromJson(Map<String, dynamic> json) => _$BadgeImpl(
  text: json['text'] as String,
  type: const BadgeColorParser().fromJson(json['type']),
);

Map<String, dynamic> _$$BadgeImplToJson(_$BadgeImpl instance) =>
    <String, dynamic>{
      'text': instance.text,
      'type': const BadgeColorParser().toJson(instance.type),
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
      tags:
          (json['tags'] as List<dynamic>?)
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
      sourceTags:
          (json['sourceTags'] as List<dynamic>?)
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
    <String, dynamic>{'toolchain': instance.toolchain, 'types': instance.types};

_$VersioningImpl _$$VersioningImplFromJson(Map<String, dynamic> json) =>
    _$VersioningImpl(
      buildTime: json['buildTime'] as String,
      sources:
          (json['sources'] as List<dynamic>)
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
    _$RepoInfoImpl(name: json['name'] as String, url: json['url'] as String);

Map<String, dynamic> _$$RepoInfoImplToJson(_$RepoInfoImpl instance) =>
    <String, dynamic>{'name': instance.name, 'url': instance.url};

_$PartialSourceMangaImpl _$$PartialSourceMangaImplFromJson(
  Map<String, dynamic> json,
) => _$PartialSourceMangaImpl(
  mangaId: json['mangaId'] as String,
  image: json['image'] as String,
  title: json['title'] as String,
  subtitle: json['subtitle'] as String?,
);

Map<String, dynamic> _$$PartialSourceMangaImplToJson(
  _$PartialSourceMangaImpl instance,
) => <String, dynamic>{
  'mangaId': instance.mangaId,
  'image': instance.image,
  'title': instance.title,
  'subtitle': instance.subtitle,
};

_$PagedResultsImpl _$$PagedResultsImplFromJson(Map<String, dynamic> json) =>
    _$PagedResultsImpl(
      results:
          (json['results'] as List<dynamic>?)
              ?.map(
                (e) => PartialSourceManga.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
      metadata: json['metadata'],
    );

Map<String, dynamic> _$$PagedResultsImplToJson(_$PagedResultsImpl instance) =>
    <String, dynamic>{
      'results': instance.results,
      'metadata': instance.metadata,
    };

_$MangaInfoImpl _$$MangaInfoImplFromJson(
  Map<String, dynamic> json,
) => _$MangaInfoImpl(
  image: json['image'] as String,
  artist: json['artist'] as String?,
  author: json['author'] as String?,
  desc: json['desc'] as String,
  status: json['status'] as String,
  hentai: json['hentai'] as bool?,
  titles: (json['titles'] as List<dynamic>).map((e) => e as String).toList(),
  banner: json['banner'] as String?,
  rating: json['rating'] as num?,
  tags:
      (json['tags'] as List<dynamic>?)
          ?.map((e) => TagSection.fromJson(e as Map<String, dynamic>))
          .toList(),
  covers: (json['covers'] as List<dynamic>?)?.map((e) => e as String).toList(),
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

_$TagImpl _$$TagImplFromJson(Map<String, dynamic> json) =>
    _$TagImpl(id: json['id'] as String, label: json['label'] as String);

Map<String, dynamic> _$$TagImplToJson(_$TagImpl instance) => <String, dynamic>{
  'id': instance.id,
  'label': instance.label,
};

_$TagSectionImpl _$$TagSectionImplFromJson(Map<String, dynamic> json) =>
    _$TagSectionImpl(
      id: json['id'] as String,
      label: json['label'] as String,
      tags:
          (json['tags'] as List<dynamic>)
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
    <String, dynamic>{'id': instance.id, 'mangaInfo': instance.mangaInfo};

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
        instance.time,
        const TimestampSerializer().toJson,
      ),
      'sortingIndex': instance.sortingIndex,
    };

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);

_$ChapterDetailsImpl _$$ChapterDetailsImplFromJson(Map<String, dynamic> json) =>
    _$ChapterDetailsImpl(
      id: json['id'] as String,
      mangaId: json['mangaId'] as String,
      pages: (json['pages'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$ChapterDetailsImplToJson(
  _$ChapterDetailsImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'mangaId': instance.mangaId,
  'pages': instance.pages,
};

_$SearchRequestImpl _$$SearchRequestImplFromJson(Map<String, dynamic> json) =>
    _$SearchRequestImpl(
      title: json['title'] as String?,
      includedTags:
          (json['includedTags'] as List<dynamic>?)
              ?.map((e) => Tag.fromJson(e as Map<String, dynamic>))
              .toList(),
      excludedTags:
          (json['excludedTags'] as List<dynamic>?)
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
      items:
          (json['items'] as List<dynamic>)
              .map(
                (e) => PartialSourceManga.fromJson(e as Map<String, dynamic>),
              )
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

_$DUIOAuthTokenResponseImpl _$$DUIOAuthTokenResponseImplFromJson(
  Map<String, dynamic> json,
) => _$DUIOAuthTokenResponseImpl($type: json['type'] as String?);

Map<String, dynamic> _$$DUIOAuthTokenResponseImplToJson(
  _$DUIOAuthTokenResponseImpl instance,
) => <String, dynamic>{'type': instance.$type};

_$DUIOAuthCodeResponseImpl _$$DUIOAuthCodeResponseImplFromJson(
  Map<String, dynamic> json,
) => _$DUIOAuthCodeResponseImpl(
  tokenEndpoint: json['tokenEndpoint'] as String,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$$DUIOAuthCodeResponseImplToJson(
  _$DUIOAuthCodeResponseImpl instance,
) => <String, dynamic>{
  'tokenEndpoint': instance.tokenEndpoint,
  'type': instance.$type,
};

_$DUIOAuthPKCEResponseImpl _$$DUIOAuthPKCEResponseImplFromJson(
  Map<String, dynamic> json,
) => _$DUIOAuthPKCEResponseImpl(
  tokenEndpoint: json['tokenEndpoint'] as String,
  pkceCodeLength: json['pkceCodeLength'] as num,
  pkceCodeMethod: json['pkceCodeMethod'] as String,
  formEncodeGrant: json['formEncodeGrant'] as bool,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$$DUIOAuthPKCEResponseImplToJson(
  _$DUIOAuthPKCEResponseImpl instance,
) => <String, dynamic>{
  'tokenEndpoint': instance.tokenEndpoint,
  'pkceCodeLength': instance.pkceCodeLength,
  'pkceCodeMethod': instance.pkceCodeMethod,
  'formEncodeGrant': instance.formEncodeGrant,
  'type': instance.$type,
};

_$DUISectionImpl _$$DUISectionImplFromJson(Map<String, dynamic> json) =>
    _$DUISectionImpl(
      id: json['id'] as String,
      header: json['header'] as String?,
      footer: json['footer'] as String?,
      isHidden: json['isHidden'] as bool,
      rows:
          (json['rows'] as List<dynamic>)
              .map((e) => DUIType.fromJson(e as Map<String, dynamic>))
              .toList(),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$DUISectionImplToJson(_$DUISectionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'header': instance.header,
      'footer': instance.footer,
      'isHidden': instance.isHidden,
      'rows': instance.rows,
      'type': instance.$type,
    };

_$DUISelectImpl _$$DUISelectImplFromJson(Map<String, dynamic> json) =>
    _$DUISelectImpl(
      id: json['id'] as String,
      label: json['label'] as String,
      options:
          (json['options'] as List<dynamic>).map((e) => e as String).toList(),
      allowsMultiselect: json['allowsMultiselect'] as bool,
      labels: Map<String, String>.from(json['labels'] as Map),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$DUISelectImplToJson(_$DUISelectImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'options': instance.options,
      'allowsMultiselect': instance.allowsMultiselect,
      'labels': instance.labels,
      'type': instance.$type,
    };

_$DUIInputFieldImpl _$$DUIInputFieldImplFromJson(Map<String, dynamic> json) =>
    _$DUIInputFieldImpl(
      id: json['id'] as String,
      label: json['label'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$DUIInputFieldImplToJson(_$DUIInputFieldImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'type': instance.$type,
    };

_$DUISecureInputFieldImpl _$$DUISecureInputFieldImplFromJson(
  Map<String, dynamic> json,
) => _$DUISecureInputFieldImpl(
  id: json['id'] as String,
  label: json['label'] as String,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$$DUISecureInputFieldImplToJson(
  _$DUISecureInputFieldImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'label': instance.label,
  'type': instance.$type,
};

_$DUIStepperImpl _$$DUIStepperImplFromJson(Map<String, dynamic> json) =>
    _$DUIStepperImpl(
      id: json['id'] as String,
      label: json['label'] as String,
      min: json['min'] as num?,
      max: json['max'] as num?,
      step: json['step'] as num?,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$DUIStepperImplToJson(_$DUIStepperImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'min': instance.min,
      'max': instance.max,
      'step': instance.step,
      'type': instance.$type,
    };

_$DUILabelImpl _$$DUILabelImplFromJson(Map<String, dynamic> json) =>
    _$DUILabelImpl(
      id: json['id'] as String,
      label: json['label'] as String,
      value: json['value'] as String?,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$DUILabelImplToJson(_$DUILabelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'value': instance.value,
      'type': instance.$type,
    };

_$DUIMultilineLabelImpl _$$DUIMultilineLabelImplFromJson(
  Map<String, dynamic> json,
) => _$DUIMultilineLabelImpl(
  id: json['id'] as String,
  label: json['label'] as String,
  value: json['value'] as String,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$$DUIMultilineLabelImplToJson(
  _$DUIMultilineLabelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'label': instance.label,
  'value': instance.value,
  'type': instance.$type,
};

_$DUIHeaderImpl _$$DUIHeaderImplFromJson(Map<String, dynamic> json) =>
    _$DUIHeaderImpl(
      id: json['id'] as String,
      imageUrl: json['imageUrl'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String?,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$DUIHeaderImplToJson(_$DUIHeaderImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'imageUrl': instance.imageUrl,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'type': instance.$type,
    };

_$DUIButtonImpl _$$DUIButtonImplFromJson(Map<String, dynamic> json) =>
    _$DUIButtonImpl(
      id: json['id'] as String,
      label: json['label'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$DUIButtonImplToJson(_$DUIButtonImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'type': instance.$type,
    };

_$DUINavigationButtonImpl _$$DUINavigationButtonImplFromJson(
  Map<String, dynamic> json,
) => _$DUINavigationButtonImpl(
  id: json['id'] as String,
  label: json['label'] as String,
  form: DUIForm.fromJson(json['form'] as Map<String, dynamic>),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$$DUINavigationButtonImplToJson(
  _$DUINavigationButtonImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'label': instance.label,
  'form': instance.form,
  'type': instance.$type,
};

_$DUISwitchImpl _$$DUISwitchImplFromJson(Map<String, dynamic> json) =>
    _$DUISwitchImpl(
      id: json['id'] as String,
      label: json['label'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$DUISwitchImplToJson(_$DUISwitchImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'type': instance.$type,
    };

_$DUIOAuthButtonImpl _$$DUIOAuthButtonImplFromJson(Map<String, dynamic> json) =>
    _$DUIOAuthButtonImpl(
      id: json['id'] as String,
      label: json['label'] as String,
      authorizeEndpoint: json['authorizeEndpoint'] as String,
      clientId: json['clientId'] as String,
      responseType: DUIOAuthResponseType.fromJson(
        json['responseType'] as Map<String, dynamic>,
      ),
      redirectUri: json['redirectUri'] as String?,
      scopes:
          (json['scopes'] as List<dynamic>?)?.map((e) => e as String).toList(),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$DUIOAuthButtonImplToJson(
  _$DUIOAuthButtonImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'label': instance.label,
  'authorizeEndpoint': instance.authorizeEndpoint,
  'clientId': instance.clientId,
  'responseType': instance.responseType,
  'redirectUri': instance.redirectUri,
  'scopes': instance.scopes,
  'type': instance.$type,
};

_$DUIFormImpl _$$DUIFormImplFromJson(Map<String, dynamic> json) =>
    _$DUIFormImpl(
      sections:
          (json['sections'] as List<dynamic>)
              .map((e) => DUISection.fromJson(e as Map<String, dynamic>))
              .toList(),
      hasSubmit: json['hasSubmit'] as bool,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$DUIFormImplToJson(_$DUIFormImpl instance) =>
    <String, dynamic>{
      'sections': instance.sections,
      'hasSubmit': instance.hasSubmit,
      'type': instance.$type,
    };
