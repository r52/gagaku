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

const _$SupportedVersionEnumMap = {SupportedVersion.v0_8: 'v0_8'};

_HistoryLink _$HistoryLinkFromJson(Map<String, dynamic> json) => _HistoryLink(
  title: json['title'] as String,
  url: json['url'] as String,
  cover: json['cover'] as String?,
);

Map<String, dynamic> _$HistoryLinkToJson(_HistoryLink instance) =>
    <String, dynamic>{
      'title': instance.title,
      'url': instance.url,
      'cover': instance.cover,
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
  chapters: (json['chapters'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(k, WebChapter.fromJson(e as Map<String, dynamic>)),
  ),
);

Map<String, dynamic> _$WebMangaToJson(_WebManga instance) => <String, dynamic>{
  'title': instance.title,
  'description': instance.description,
  'artist': instance.artist,
  'author': instance.author,
  'cover': instance.cover,
  'groups': instance.groups,
  'chapters': instance.chapters.map((k, e) => MapEntry(k, e.toJson())),
};

_WebChapter _$WebChapterFromJson(Map<String, dynamic> json) => _WebChapter(
  title: json['title'] as String?,
  volume: json['volume'] as String?,
  lastUpdated: const EpochTimestampSerializer().fromJson(json['last_updated']),
  releaseDate: const MappedEpochTimestampSerializer().fromJson(
    json['release_date'],
  ),
  groups: json['groups'] as Map<String, dynamic>,
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
  'groups': instance.groups,
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
      version:
          $enumDecodeNullable(_$SupportedVersionEnumMap, json['version']) ??
          SupportedVersion.v0_8,
      icon: json['icon'] as String?,
    );

Map<String, dynamic> _$WebSourceInfoToJson(_WebSourceInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'repo': instance.repo,
      'version': _$SupportedVersionEnumMap[instance.version]!,
      'icon': instance.icon,
    };

_SourceIdentifier _$SourceIdentifierFromJson(Map<String, dynamic> json) =>
    _SourceIdentifier(
      internal: WebSourceInfo.fromJson(
        json['internal'] as Map<String, dynamic>,
      ),
      external: SourceInfo.fromJson(json['external'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SourceIdentifierToJson(_SourceIdentifier instance) =>
    <String, dynamic>{
      'internal': instance.internal.toJson(),
      'external': instance.external.toJson(),
    };

_Badge _$BadgeFromJson(Map<String, dynamic> json) => _Badge(
  text: json['text'] as String,
  type: const BadgeColorParser().fromJson(json['type']),
);

Map<String, dynamic> _$BadgeToJson(_Badge instance) => <String, dynamic>{
  'text': instance.text,
  'type': const BadgeColorParser().toJson(instance.type),
};

_SourceVersion _$SourceVersionFromJson(Map<String, dynamic> json) =>
    _SourceVersion(
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

Map<String, dynamic> _$SourceVersionToJson(_SourceVersion instance) =>
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
    };

const _$ContentRatingEnumMap = {
  ContentRating.EVERYONE: 'EVERYONE',
  ContentRating.MATURE: 'MATURE',
  ContentRating.ADULT: 'ADULT',
};

_SourceInfo _$SourceInfoFromJson(Map<String, dynamic> json) => _SourceInfo(
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

Map<String, dynamic> _$SourceInfoToJson(_SourceInfo instance) =>
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
      'sourceTags': instance.sourceTags?.map((e) => e.toJson()).toList(),
      'intents': instance.intents,
    };

_BuiltWith _$BuiltWithFromJson(Map<String, dynamic> json) => _BuiltWith(
  toolchain: json['toolchain'] as String,
  types: json['types'] as String,
);

Map<String, dynamic> _$BuiltWithToJson(_BuiltWith instance) =>
    <String, dynamic>{'toolchain': instance.toolchain, 'types': instance.types};

_Versioning _$VersioningFromJson(Map<String, dynamic> json) => _Versioning(
  buildTime: json['buildTime'] as String,
  sources:
      (json['sources'] as List<dynamic>)
          .map((e) => SourceVersion.fromJson(e as Map<String, dynamic>))
          .toList(),
  builtWith: BuiltWith.fromJson(json['builtWith'] as Map<String, dynamic>),
);

Map<String, dynamic> _$VersioningToJson(_Versioning instance) =>
    <String, dynamic>{
      'buildTime': instance.buildTime,
      'sources': instance.sources.map((e) => e.toJson()).toList(),
      'builtWith': instance.builtWith.toJson(),
    };

_PartialSourceManga _$PartialSourceMangaFromJson(Map<String, dynamic> json) =>
    _PartialSourceManga(
      mangaId: json['mangaId'] as String,
      image: json['image'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String?,
    );

Map<String, dynamic> _$PartialSourceMangaToJson(_PartialSourceManga instance) =>
    <String, dynamic>{
      'mangaId': instance.mangaId,
      'image': instance.image,
      'title': instance.title,
      'subtitle': instance.subtitle,
    };

_PagedResults _$PagedResultsFromJson(Map<String, dynamic> json) =>
    _PagedResults(
      results:
          (json['results'] as List<dynamic>?)
              ?.map(
                (e) => PartialSourceManga.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
      metadata: json['metadata'],
    );

Map<String, dynamic> _$PagedResultsToJson(_PagedResults instance) =>
    <String, dynamic>{
      'results': instance.results?.map((e) => e.toJson()).toList(),
      'metadata': instance.metadata,
    };

_MangaInfo _$MangaInfoFromJson(Map<String, dynamic> json) => _MangaInfo(
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

Map<String, dynamic> _$MangaInfoToJson(_MangaInfo instance) =>
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
      'tags': instance.tags?.map((e) => e.toJson()).toList(),
      'covers': instance.covers,
    };

_Tag _$TagFromJson(Map<String, dynamic> json) =>
    _Tag(id: json['id'] as String, label: json['label'] as String);

Map<String, dynamic> _$TagToJson(_Tag instance) => <String, dynamic>{
  'id': instance.id,
  'label': instance.label,
};

_TagSection _$TagSectionFromJson(Map<String, dynamic> json) => _TagSection(
  id: json['id'] as String,
  label: json['label'] as String,
  tags:
      (json['tags'] as List<dynamic>)
          .map((e) => Tag.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$TagSectionToJson(_TagSection instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'tags': instance.tags.map((e) => e.toJson()).toList(),
    };

_SourceManga _$SourceMangaFromJson(Map<String, dynamic> json) => _SourceManga(
  id: json['id'] as String,
  mangaInfo: MangaInfo.fromJson(json['mangaInfo'] as Map<String, dynamic>),
);

Map<String, dynamic> _$SourceMangaToJson(_SourceManga instance) =>
    <String, dynamic>{
      'id': instance.id,
      'mangaInfo': instance.mangaInfo.toJson(),
    };

_Chapter _$ChapterFromJson(Map<String, dynamic> json) => _Chapter(
  id: json['id'] as String,
  chapNum: json['chapNum'] as num,
  langCode: json['langCode'] as String?,
  name: json['name'] as String?,
  volume: json['volume'] as num?,
  group: json['group'] as String?,
  time: const TimestampSerializer().fromJson(json['time']),
  sortingIndex: json['sortingIndex'] as num?,
);

Map<String, dynamic> _$ChapterToJson(_Chapter instance) => <String, dynamic>{
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

_SearchRequest _$SearchRequestFromJson(Map<String, dynamic> json) =>
    _SearchRequest(
      title: json['title'] as String?,
      includedTags:
          (json['includedTags'] as List<dynamic>?)
              ?.map((e) => Tag.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      excludedTags:
          (json['excludedTags'] as List<dynamic>?)
              ?.map((e) => Tag.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$SearchRequestToJson(_SearchRequest instance) =>
    <String, dynamic>{
      'title': instance.title,
      'includedTags': instance.includedTags.map((e) => e.toJson()).toList(),
      'excludedTags': instance.excludedTags.map((e) => e.toJson()).toList(),
    };

_HomeSection _$HomeSectionFromJson(Map<String, dynamic> json) => _HomeSection(
  id: json['id'] as String,
  title: json['title'] as String,
  items:
      (json['items'] as List<dynamic>)
          .map((e) => PartialSourceManga.fromJson(e as Map<String, dynamic>))
          .toList(),
  containsMoreItems: json['containsMoreItems'] as bool,
);

Map<String, dynamic> _$HomeSectionToJson(_HomeSection instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'items': instance.items.map((e) => e.toJson()).toList(),
      'containsMoreItems': instance.containsMoreItems,
    };

DUIOAuthTokenResponse _$DUIOAuthTokenResponseFromJson(
  Map<String, dynamic> json,
) => DUIOAuthTokenResponse($type: json['type'] as String?);

Map<String, dynamic> _$DUIOAuthTokenResponseToJson(
  DUIOAuthTokenResponse instance,
) => <String, dynamic>{'type': instance.$type};

DUIOAuthCodeResponse _$DUIOAuthCodeResponseFromJson(
  Map<String, dynamic> json,
) => DUIOAuthCodeResponse(
  tokenEndpoint: json['tokenEndpoint'] as String,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$DUIOAuthCodeResponseToJson(
  DUIOAuthCodeResponse instance,
) => <String, dynamic>{
  'tokenEndpoint': instance.tokenEndpoint,
  'type': instance.$type,
};

DUIOAuthPKCEResponse _$DUIOAuthPKCEResponseFromJson(
  Map<String, dynamic> json,
) => DUIOAuthPKCEResponse(
  tokenEndpoint: json['tokenEndpoint'] as String,
  pkceCodeLength: json['pkceCodeLength'] as num,
  pkceCodeMethod: json['pkceCodeMethod'] as String,
  formEncodeGrant: json['formEncodeGrant'] as bool,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$DUIOAuthPKCEResponseToJson(
  DUIOAuthPKCEResponse instance,
) => <String, dynamic>{
  'tokenEndpoint': instance.tokenEndpoint,
  'pkceCodeLength': instance.pkceCodeLength,
  'pkceCodeMethod': instance.pkceCodeMethod,
  'formEncodeGrant': instance.formEncodeGrant,
  'type': instance.$type,
};

DUISection _$DUISectionFromJson(Map<String, dynamic> json) => DUISection(
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

Map<String, dynamic> _$DUISectionToJson(DUISection instance) =>
    <String, dynamic>{
      'id': instance.id,
      'header': instance.header,
      'footer': instance.footer,
      'isHidden': instance.isHidden,
      'rows': instance.rows.map((e) => e.toJson()).toList(),
      'type': instance.$type,
    };

DUISelect _$DUISelectFromJson(Map<String, dynamic> json) => DUISelect(
  id: json['id'] as String,
  label: json['label'] as String,
  options: (json['options'] as List<dynamic>).map((e) => e as String).toList(),
  allowsMultiselect: json['allowsMultiselect'] as bool,
  labels: Map<String, String>.from(json['labels'] as Map),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$DUISelectToJson(DUISelect instance) => <String, dynamic>{
  'id': instance.id,
  'label': instance.label,
  'options': instance.options,
  'allowsMultiselect': instance.allowsMultiselect,
  'labels': instance.labels,
  'type': instance.$type,
};

DUIInputField _$DUIInputFieldFromJson(Map<String, dynamic> json) =>
    DUIInputField(
      id: json['id'] as String,
      label: json['label'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$DUIInputFieldToJson(DUIInputField instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'type': instance.$type,
    };

DUISecureInputField _$DUISecureInputFieldFromJson(Map<String, dynamic> json) =>
    DUISecureInputField(
      id: json['id'] as String,
      label: json['label'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$DUISecureInputFieldToJson(
  DUISecureInputField instance,
) => <String, dynamic>{
  'id': instance.id,
  'label': instance.label,
  'type': instance.$type,
};

DUIStepper _$DUIStepperFromJson(Map<String, dynamic> json) => DUIStepper(
  id: json['id'] as String,
  label: json['label'] as String,
  min: json['min'] as num?,
  max: json['max'] as num?,
  step: json['step'] as num?,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$DUIStepperToJson(DUIStepper instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'min': instance.min,
      'max': instance.max,
      'step': instance.step,
      'type': instance.$type,
    };

DUILabel _$DUILabelFromJson(Map<String, dynamic> json) => DUILabel(
  id: json['id'] as String,
  label: json['label'] as String,
  value: json['value'] as String?,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$DUILabelToJson(DUILabel instance) => <String, dynamic>{
  'id': instance.id,
  'label': instance.label,
  'value': instance.value,
  'type': instance.$type,
};

DUIMultilineLabel _$DUIMultilineLabelFromJson(Map<String, dynamic> json) =>
    DUIMultilineLabel(
      id: json['id'] as String,
      label: json['label'] as String,
      value: json['value'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$DUIMultilineLabelToJson(DUIMultilineLabel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'value': instance.value,
      'type': instance.$type,
    };

DUIHeader _$DUIHeaderFromJson(Map<String, dynamic> json) => DUIHeader(
  id: json['id'] as String,
  imageUrl: json['imageUrl'] as String,
  title: json['title'] as String,
  subtitle: json['subtitle'] as String?,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$DUIHeaderToJson(DUIHeader instance) => <String, dynamic>{
  'id': instance.id,
  'imageUrl': instance.imageUrl,
  'title': instance.title,
  'subtitle': instance.subtitle,
  'type': instance.$type,
};

DUIButton _$DUIButtonFromJson(Map<String, dynamic> json) => DUIButton(
  id: json['id'] as String,
  label: json['label'] as String,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$DUIButtonToJson(DUIButton instance) => <String, dynamic>{
  'id': instance.id,
  'label': instance.label,
  'type': instance.$type,
};

DUINavigationButton _$DUINavigationButtonFromJson(Map<String, dynamic> json) =>
    DUINavigationButton(
      id: json['id'] as String,
      label: json['label'] as String,
      form: DUIForm.fromJson(json['form'] as Map<String, dynamic>),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$DUINavigationButtonToJson(
  DUINavigationButton instance,
) => <String, dynamic>{
  'id': instance.id,
  'label': instance.label,
  'form': instance.form.toJson(),
  'type': instance.$type,
};

DUISwitch _$DUISwitchFromJson(Map<String, dynamic> json) => DUISwitch(
  id: json['id'] as String,
  label: json['label'] as String,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$DUISwitchToJson(DUISwitch instance) => <String, dynamic>{
  'id': instance.id,
  'label': instance.label,
  'type': instance.$type,
};

DUIOAuthButton _$DUIOAuthButtonFromJson(Map<String, dynamic> json) =>
    DUIOAuthButton(
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

Map<String, dynamic> _$DUIOAuthButtonToJson(DUIOAuthButton instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'authorizeEndpoint': instance.authorizeEndpoint,
      'clientId': instance.clientId,
      'responseType': instance.responseType.toJson(),
      'redirectUri': instance.redirectUri,
      'scopes': instance.scopes,
      'type': instance.$type,
    };

DUIForm _$DUIFormFromJson(Map<String, dynamic> json) => DUIForm(
  sections:
      (json['sections'] as List<dynamic>)
          .map((e) => DUISection.fromJson(e as Map<String, dynamic>))
          .toList(),
  hasSubmit: json['hasSubmit'] as bool,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$DUIFormToJson(DUIForm instance) => <String, dynamic>{
  'sections': instance.sections.map((e) => e.toJson()).toList(),
  'hasSubmit': instance.hasSubmit,
  'type': instance.$type,
};
