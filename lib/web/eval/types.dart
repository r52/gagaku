import 'package:dart_eval/dart_eval_bridge.dart';
import 'package:dart_eval/dart_eval_extensions.dart';
import 'package:dart_eval/stdlib/core.dart';
// ignore: implementation_imports
import 'package:dart_eval/src/eval/utils/wap_helper.dart';
import 'package:gagaku/web/eval/util.dart';
import 'package:gagaku/web/model/types.dart';

/*
class $WebSourceInfo implements $Instance {
  static void configureForCompile(BridgeDeclarationRegistry registry) {
    registry.defineBridgeClass($declaration);
  }

  static void configureForRuntime(Runtime runtime) {
    runtime.registerBridgeFunc($type.spec!.library, 'WebSourceInfo.', $new);
  }

  static final $type = const BridgeTypeSpec(GagakuWebSources.getTypesLibPath, 'WebSourceInfo').ref;

  static final $declaration = BridgeClassDef(
    BridgeClassType($type),
    constructors: {
      '': BridgeFunctionDef(
        returns: $type.annotate,
        namedParams: [
          'name'.param(CoreTypes.string.ref.annotate),
          'version'.param(CoreTypes.string.ref.annotate),
          'baseUrl'.param(CoreTypes.string.ref.annotate),
          'mangaPath'.param(CoreTypes.string.ref.annotate),
          'search'.param(CoreTypes.string.ref.annotate),
          'manga'.param(CoreTypes.string.ref.annotate),
          'pages'.param(CoreTypes.string.ref.annotate),
        ],
      ).asFactory
    },
    methods: {},
    getters: {
      'name': BridgeFunctionDef(
        returns: CoreTypes.string.ref.annotate,
      ).asMethod,
      'version': BridgeFunctionDef(
        returns: CoreTypes.string.ref.annotate,
      ).asMethod,
      'baseUrl': BridgeFunctionDef(
        returns: CoreTypes.string.ref.annotate,
      ).asMethod,
      'mangaPath': BridgeFunctionDef(
        returns: CoreTypes.string.ref.annotate,
      ).asMethod,
      'search': BridgeFunctionDef(
        returns: CoreTypes.string.ref.annotate,
      ).asMethod,
      'manga': BridgeFunctionDef(
        returns: CoreTypes.string.ref.annotate,
      ).asMethod,
      'pages': BridgeFunctionDef(
        returns: CoreTypes.string.ref.annotate,
      ).asMethod,
    },
    wrap: true,
  );

  @override
  final WebSourceInfo $value;

  @override
  get $reified => $value;

  $WebSourceInfo.wrap(this.$value);

  static $Value? $new(Runtime runtime, $Value? target, List<$Value?> args) {
    return $WebSourceInfo.wrap(WebSourceInfo(
      name: args[0]!.$value as String,
      version: args[1]!.$value as String,
      baseUrl: args[2]!.$value as String,
      mangaPath: args[3]!.$value as String,
      search: args[4]!.$value as String,
      manga: args[5]!.$value as String,
      pages: args[6]!.$value as String,
    ));
  }

  @override
  $Value? $getProperty(Runtime runtime, String identifier) {
    switch (identifier) {
      case 'name':
        return $String($value.name);
      case 'version':
        return $String($value.version);
      case 'baseUrl':
        return $String($value.baseUrl);
      case 'mangaPath':
        return $String($value.mangaPath);
      case 'search':
        return $String($value.search);
      case 'manga':
        return $String($value.manga);
      case 'pages':
        return $String($value.pages);
      default:
        break;
    }

    return $Object(this).$getProperty(runtime, identifier);
  }

  @override
  void $setProperty(Runtime runtime, String identifier, $Value value) {
    return $Object(this).$setProperty(runtime, identifier, value);
  }

  @override
  int $getRuntimeType(Runtime runtime) => runtime.lookupType($type.spec!);
}
*/

class $HistoryLink implements $Instance {
  static void configureForCompile(BridgeDeclarationRegistry registry) {
    registry.defineBridgeClass($declaration);
  }

  static void configureForRuntime(Runtime runtime) {
    runtime.registerBridgeFunc($type.spec!.library, 'HistoryLink.', $new);
  }

  static final $type = const BridgeTypeSpec(GagakuWebSources.getTypesLibPath, 'HistoryLink').ref;

  static final $declaration = BridgeClassDef(
    BridgeClassType($type),
    constructors: {
      '': BridgeFunctionDef(
        returns: $type.annotate,
        namedParams: [
          'title'.param(CoreTypes.string.ref.annotate),
          'url'.param(CoreTypes.string.ref.annotate),
          'cover'.param(CoreTypes.string.ref.annotateNullable),
        ],
      ).asFactory
    },
    methods: {},
    getters: {
      'title': BridgeFunctionDef(
        returns: CoreTypes.string.ref.annotate,
      ).asMethod,
      'url': BridgeFunctionDef(
        returns: CoreTypes.string.ref.annotate,
      ).asMethod,
      'cover': BridgeFunctionDef(
        returns: CoreTypes.string.ref.annotateNullable,
      ).asMethod,
    },
    wrap: true,
  );

  @override
  final HistoryLink $value;

  @override
  get $reified => $value;

  $HistoryLink.wrap(this.$value);

  static $Value? $new(Runtime runtime, $Value? target, List<$Value?> args) {
    return $HistoryLink.wrap(HistoryLink(
      title: args[0]!.$value as String,
      url: args[1]!.$value as String,
      cover: args[2]?.$value as String?,
    ));
  }

  @override
  $Value? $getProperty(Runtime runtime, String identifier) {
    switch (identifier) {
      case 'title':
        return $String($value.title);
      case 'url':
        return $String($value.url);
      case 'cover':
        return $value.cover != null ? $String($value.cover!) : const $null();
      default:
        break;
    }

    return $Object(this).$getProperty(runtime, identifier);
  }

  @override
  void $setProperty(Runtime runtime, String identifier, $Value value) {
    return $Object(this).$setProperty(runtime, identifier, value);
  }

  @override
  int $getRuntimeType(Runtime runtime) => runtime.lookupType($type.spec!);
}

class $WebChapter implements $Instance {
  static void configureForCompile(BridgeDeclarationRegistry registry) {
    registry.defineBridgeClass($declaration);
  }

  static void configureForRuntime(Runtime runtime) {
    runtime.registerBridgeFunc($type.spec!.library, 'WebChapter.', $new);
  }

  static final $type = const BridgeTypeSpec(GagakuWebSources.getTypesLibPath, 'WebChapter').ref;

  static final $declaration = BridgeClassDef(
    BridgeClassType($type),
    constructors: {
      '': BridgeFunctionDef(
        returns: $type.annotate,
        namedParams: [
          'title'.param(CoreTypes.string.ref.annotateNullable),
          'volume'.param(CoreTypes.string.ref.annotateNullable),
          'lastUpdated'.param(CoreTypes.dateTime.ref.annotateNullable),
          'releaseDate'.param(CoreTypes.dateTime.ref.annotateNullable),
          'groups'.param(CoreTypes.map.refWith([CoreTypes.string.ref, CoreTypes.dynamic.ref]).annotate),
        ],
      ).asFactory
    },
    methods: {
      'getTitle': BridgeFunctionDef(
        returns: CoreTypes.string.ref.annotate,
        params: [
          'index'.param(CoreTypes.string.ref.annotate),
        ],
      ).asMethod,
    },
    getters: {
      'title': BridgeFunctionDef(
        returns: CoreTypes.string.ref.annotateNullable,
      ).asMethod,
      'volume': BridgeFunctionDef(
        returns: CoreTypes.string.ref.annotateNullable,
      ).asMethod,
      'lastUpdated': BridgeFunctionDef(
        returns: CoreTypes.dateTime.ref.annotateNullable,
      ).asMethod,
      'releaseDate': BridgeFunctionDef(
        returns: CoreTypes.dateTime.ref.annotateNullable,
      ).asMethod,
      'groups': BridgeFunctionDef(
        returns: CoreTypes.map.refWith([CoreTypes.string.ref, CoreTypes.dynamic.ref]).annotate,
      ).asMethod,
    },
    wrap: true,
  );

  @override
  final WebChapter $value;

  @override
  get $reified => $value;

  $WebChapter.wrap(this.$value);

  static $Value? $new(Runtime runtime, $Value? target, List<$Value?> args) {
    final groups = (args[4]!.$value as Map).map((key, value) => MapEntry(key.$reified.toString(), value.$reified));

    return $WebChapter.wrap(WebChapter(
      title: args[0]?.$value as String?,
      volume: args[1]?.$value as String?,
      lastUpdated: args[2]?.$value as DateTime?,
      releaseDate: args[3]?.$value as DateTime?,
      groups: groups,
    ));
  }

  @override
  $Value? $getProperty(Runtime runtime, String identifier) {
    switch (identifier) {
      case 'title':
        return $value.title != null ? $String($value.title!) : const $null();
      case 'volume':
        return $value.volume != null ? $String($value.volume!) : const $null();
      case 'lastUpdated':
        return $value.lastUpdated != null ? $DateTime.wrap($value.lastUpdated!) : const $null();
      case 'releaseDate':
        return $value.releaseDate != null ? $DateTime.wrap($value.releaseDate!) : const $null();
      case 'groups':
        return wrapMap<String, dynamic>($value.groups, (key, value) => MapEntry($String(key), value));
      case 'getTitle':
        return __getTitle;
      default:
        break;
    }

    return $Object(this).$getProperty(runtime, identifier);
  }

  @override
  void $setProperty(Runtime runtime, String identifier, $Value value) {
    return $Object(this).$setProperty(runtime, identifier, value);
  }

  static const $Function __getTitle = $Function(_getTitle);

  static $Value? _getTitle(Runtime runtime, $Value? target, List<$Value?> args) {
    final $t = target as $WebChapter;
    return $String($t.$value.getTitle(args[0]!.$value));
  }

  @override
  int $getRuntimeType(Runtime runtime) => runtime.lookupType($type.spec!);
}

class $WebManga implements $Instance {
  static void configureForCompile(BridgeDeclarationRegistry registry) {
    registry.defineBridgeClass($declaration);
  }

  static void configureForRuntime(Runtime runtime) {
    runtime.registerBridgeFunc($type.spec!.library, 'WebManga.', $WebManga.$new);
  }

  static final $type = const BridgeTypeSpec(GagakuWebSources.getTypesLibPath, 'WebManga').ref;

  static final $declaration = BridgeClassDef(
    BridgeClassType($type),
    constructors: {
      '': BridgeFunctionDef(
        returns: $type.annotate,
        namedParams: [
          'title'.param(CoreTypes.string.ref.annotate),
          'description'.param(CoreTypes.string.ref.annotate),
          'artist'.param(CoreTypes.string.ref.annotate),
          'author'.param(CoreTypes.string.ref.annotate),
          'cover'.param(CoreTypes.string.ref.annotate),
          'groups'.param(CoreTypes.map.refWith([CoreTypes.string.ref, CoreTypes.string.ref]).annotateNullable),
          'chapters'.param(CoreTypes.map.refWith([CoreTypes.string.ref, $WebChapter.$type]).annotate),
        ],
      ).asFactory
    },
    methods: {
      'getChapter': BridgeFunctionDef(
        returns: $WebChapter.$type.annotateNullable,
        params: ['chapter'.param(CoreTypes.string.ref.annotate)],
      ).asMethod,
    },
    getters: {
      'title': BridgeFunctionDef(
        returns: CoreTypes.string.ref.annotate,
      ).asMethod,
      'description': BridgeFunctionDef(
        returns: CoreTypes.string.ref.annotate,
      ).asMethod,
      'artist': BridgeFunctionDef(
        returns: CoreTypes.string.ref.annotate,
      ).asMethod,
      'author': BridgeFunctionDef(
        returns: CoreTypes.string.ref.annotate,
      ).asMethod,
      'cover': BridgeFunctionDef(
        returns: CoreTypes.string.ref.annotate,
      ).asMethod,
      'groups': BridgeFunctionDef(
        returns: CoreTypes.map.refWith([CoreTypes.string.ref, CoreTypes.string.ref]).annotateNullable,
      ).asMethod,
      'chapters': BridgeFunctionDef(
        returns: CoreTypes.map.refWith([CoreTypes.string.ref, $WebChapter.$type]).annotate,
      ).asMethod,
    },
    wrap: true,
  );

  @override
  final WebManga $value;

  @override
  get $reified => $value;

  $WebManga.wrap(this.$value);

  static $Value? $new(Runtime runtime, $Value? target, List<$Value?> args) {
    final groups =
        (args[5]?.$value as Map?)?.map((key, value) => MapEntry(key.$reified.toString(), value.$reified.toString()));
    final chapters =
        (args[6]!.$value as Map).map((key, value) => MapEntry(key.$reified.toString(), value.$reified as WebChapter));
    return $WebManga.wrap(WebManga(
      title: args[0]!.$value as String,
      description: args[1]!.$value as String,
      artist: args[2]!.$value as String,
      author: args[3]!.$value as String,
      cover: args[4]!.$value as String,
      groups: groups,
      chapters: chapters,
    ));
  }

  @override
  $Value? $getProperty(Runtime runtime, String identifier) {
    switch (identifier) {
      case 'title':
        return $String($value.title);
      case 'description':
        return $String($value.description);
      case 'artist':
        return $String($value.artist);
      case 'author':
        return $String($value.author);
      case 'cover':
        return $String($value.cover);
      case 'groups':
        if ($value.groups == null) {
          return const $null();
        }
        return wrapMap<String, String>($value.groups!, (key, value) => MapEntry($String(key), $String(value)));
      case 'chapters':
        return wrapMap<String, WebChapter>(
            $value.chapters, (key, value) => MapEntry($String(key), $WebChapter.wrap(value)));
      case 'getChapter':
        return __getChapter;
      default:
        break;
    }

    return $Object(this).$getProperty(runtime, identifier);
  }

  static const $Function __getChapter = $Function(_getChapter);

  static $Value? _getChapter(Runtime runtime, $Value? target, List<$Value?> args) {
    final $t = target as $WebManga;
    final val = $t.$value.getChapter(args[0]!.$value);
    if (val != null) {
      return $WebChapter.wrap(val);
    }
    return const $null();
  }

  @override
  void $setProperty(Runtime runtime, String identifier, $Value value) {
    return $Object(this).$setProperty(runtime, identifier, value);
  }

  @override
  int $getRuntimeType(Runtime runtime) => runtime.lookupType($type.spec!);
}
