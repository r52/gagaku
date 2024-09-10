import 'dart:convert';

import 'package:dart_eval/dart_eval_bridge.dart';
import 'package:dart_eval/dart_eval_extensions.dart';
// ignore: implementation_imports
import 'package:dart_eval/src/eval/utils/wap_helper.dart';
import 'package:dart_eval/stdlib/core.dart';
import 'package:dart_eval/stdlib/typed_data.dart';
import 'package:dart_eval/stdlib/convert.dart';
import 'package:gagaku/http.dart';
import 'package:gagaku/web/eval/util.dart';
import 'package:http/http.dart';

class $Client implements $Instance {
  static void configureForCompile(BridgeDeclarationRegistry registry) {
    registry.defineBridgeClass($declaration);
  }

  static void configureForRuntime(Runtime runtime) {
    runtime.registerBridgeFunc($type.spec!.library, 'Client.', $new);
  }

  static final $type = const BridgeTypeSpec(GagakuWebSources.getTypesLibPath, 'Client').ref;

  static final $declaration = BridgeClassDef(
    BridgeClassType($type),
    constructors: {
      '': BridgeFunctionDef(returns: BridgeTypeAnnotation($type), params: [], namedParams: []).asConstructor,
    },
    methods: {
      'get': BridgeFunctionDef(
        returns: CoreTypes.future.refWith([$Response.$type]).annotate,
        params: ['url'.param(CoreTypes.uri.ref.annotate)],
        namedParams: [
          'headers'.paramOptional(CoreTypes.map.refWith([CoreTypes.string.ref, CoreTypes.string.ref]).annotateNullable)
        ],
      ).asMethod,
      'post': BridgeFunctionDef(
        returns: CoreTypes.future.refWith([$Response.$type]).annotate,
        params: ['url'.param(CoreTypes.uri.ref.annotate)],
        namedParams: [
          'headers'.paramOptional(CoreTypes.map.refWith([CoreTypes.string.ref, CoreTypes.string.ref]).annotateNullable),
          'body'.paramOptional(CoreTypes.object.ref.annotateNullable),
          'encoding'.paramOptional(ConvertTypes.encoding.ref.annotateNullable),
        ],
      ).asMethod,
      'send': BridgeFunctionDef(
        returns: CoreTypes.future.refWith([$StreamedResponse.$type]).annotate,
        params: [
          'request'.param($BaseRequest.$type.annotate),
        ],
        namedParams: [],
      ).asMethod,
    },
    getters: {},
    setters: {},
    fields: {},
    wrap: true,
  );

  @override
  final Client $value;

  @override
  get $reified => $value;

  $Client.wrap(this.$value);

  static $Client $new(Runtime runtime, $Value? target, List<$Value?> args) {
    return $Client.wrap(CustomClient());
  }

  @override
  $Value? $getProperty(Runtime runtime, String identifier) {
    switch (identifier) {
      case 'get':
        return __get;
      case 'post':
        return __post;
      case 'send':
        return __send;
      default:
        return $Object($value).$getProperty(runtime, identifier);
    }
  }

  static const $Function __get = $Function(_get);

  static $Value? _get(Runtime runtime, $Value? target, List<$Value?> args) {
    final url = args[0]!.$value as Uri;
    final headers =
        (args[1]?.$value as Map?)?.map((key, value) => MapEntry(key.$reified.toString(), value.$reified.toString()));
    if (!runtime.checkPermission('network', url.toString())) {
      runtime.assertPermission('network', url.toString());
    }
    final request = (target!.$value as Client).get(url, headers: headers);
    return $Future.wrap(request.then((value) => $Response.wrap(value)));
  }

  static const $Function __post = $Function(_post);

  static $Value? _post(Runtime runtime, $Value? target, List<$Value?> args) {
    final url = args[0]!.$value as Uri;
    final headers =
        (args[1]?.$value as Map?)?.map((key, value) => MapEntry(key.$reified.toString(), value.$reified.toString()));
    final obj = args[1]?.$value as Map?;
    final enc = args[2]?.$value as Encoding?;
    if (!runtime.checkPermission('network', url.toString())) {
      runtime.assertPermission('network', url.toString());
    }
    final request = (target!.$value as Client).post(url, headers: headers, body: obj, encoding: enc);
    return $Future.wrap(request.then((value) => $Response.wrap(value)));
  }

  static const $Function __send = $Function(_send);

  static $Value? _send(Runtime runtime, $Value? target, List<$Value?> args) {
    final req = args[0]!.$value as BaseRequest;
    if (!runtime.checkPermission('network', req.url.toString())) {
      runtime.assertPermission('network', req.url.toString());
    }
    final request = (target!.$value as Client).send(req);
    return $Future.wrap(request.then((value) => $StreamedResponse.wrap(value)));
  }

  @override
  int $getRuntimeType(Runtime runtime) => runtime.lookupType($type.spec!);

  @override
  void $setProperty(Runtime runtime, String identifier, $Value value) {
    $Object($value).$setProperty(runtime, identifier, value);
  }
}

class $BaseRequest implements $Instance {
  static void configureForCompile(BridgeDeclarationRegistry registry) {
    registry.defineBridgeClass($declaration);
  }

  static void configureForRuntime(Runtime runtime) {}

  static final $type = const BridgeTypeSpec(GagakuWebSources.getTypesLibPath, 'BaseRequest').ref;

  static final $declaration = BridgeClassDef(
    BridgeClassType($type),
    constructors: {
      '': BridgeFunctionDef(
        returns: BridgeTypeAnnotation($type),
        params: [
          'method'.param(CoreTypes.string.ref.annotate),
          'url'.param(CoreTypes.uri.ref.annotate),
        ],
        namedParams: [],
      ).asConstructor,
    },
    methods: {},
    getters: {
      'method': BridgeFunctionDef(
        returns: CoreTypes.string.ref.annotate,
      ).asMethod,
      'url': BridgeFunctionDef(
        returns: CoreTypes.uri.ref.annotate,
      ).asMethod,
      'contentLength': BridgeFunctionDef(
        returns: CoreTypes.int.ref.annotate,
      ).asMethod,
      'persistentConnection': BridgeFunctionDef(
        returns: CoreTypes.bool.ref.annotate,
      ).asMethod,
      'followRedirects': BridgeFunctionDef(
        returns: CoreTypes.bool.ref.annotate,
      ).asMethod,
      'finalized': BridgeFunctionDef(
        returns: CoreTypes.bool.ref.annotate,
      ).asMethod,
      'maxRedirects': BridgeFunctionDef(
        returns: CoreTypes.int.ref.annotate,
      ).asMethod,
      'headers': BridgeFunctionDef(
        returns: CoreTypes.map.refWith([CoreTypes.string.ref, CoreTypes.string.ref]).annotate,
      ).asMethod,
    },
    setters: {
      'followRedirects': BridgeFunctionDef(returns: CoreTypes.voidType.ref.annotate, params: [
        'value'.param(CoreTypes.bool.ref.annotate),
      ]).asMethod,
    },
    fields: {},
    wrap: true,
  );

  @override
  final BaseRequest $value;

  @override
  get $reified => $value;

  $BaseRequest.wrap(this.$value);

  @override
  $Value? $getProperty(Runtime runtime, String identifier) {
    switch (identifier) {
      case 'method':
        return $String($value.method);
      case 'url':
        return $Uri.wrap($value.url);
      case 'contentLength':
        final val = $value.contentLength;
        return val != null ? $int(val) : const $null();
      case 'persistentConnection':
        return $bool($value.persistentConnection);
      case 'followRedirects':
        return $bool($value.followRedirects);
      case 'finalized':
        return $bool($value.finalized);
      case 'maxRedirects':
        return $int($value.maxRedirects);
      case 'headers':
        return wrapMap<String, String>($value.headers, (key, value) => MapEntry($String(key), $String(value)));
      default:
        return $Object($value).$getProperty(runtime, identifier);
    }
  }

  @override
  int $getRuntimeType(Runtime runtime) => runtime.lookupType($type.spec!);

  @override
  void $setProperty(Runtime runtime, String identifier, $Value value) {
    switch (identifier) {
      case 'followRedirects':
        $value.followRedirects = value as bool;
        break;
      default:
        $Object($value).$setProperty(runtime, identifier, value);
    }
  }
}

class $Request implements $Instance {
  static void configureForCompile(BridgeDeclarationRegistry registry) {
    registry.defineBridgeClass($declaration);
  }

  static void configureForRuntime(Runtime runtime) {
    runtime.registerBridgeFunc($type.spec!.library, 'Request.', $new);
  }

  late final $BaseRequest _superclass = $BaseRequest.wrap($value);

  static final $type = const BridgeTypeSpec(GagakuWebSources.getTypesLibPath, 'Request').ref;

  static final $declaration = BridgeClassDef(
    BridgeClassType($type, $extends: $BaseRequest.$type),
    constructors: {
      '': BridgeFunctionDef(
        returns: BridgeTypeAnnotation($type),
        params: [
          'method'.param(CoreTypes.string.ref.annotate),
          'url'.param(CoreTypes.uri.ref.annotate),
        ],
        namedParams: [],
      ).asConstructor,
    },
    methods: {},
    getters: {
      'bodyBytes': BridgeFunctionDef(
        returns: TypedDataTypes.uint8List.ref.annotate,
      ).asMethod,
      'body': BridgeFunctionDef(
        returns: CoreTypes.string.ref.annotate,
      ).asMethod,
      'contentLength': BridgeFunctionDef(
        returns: CoreTypes.int.ref.annotate,
      ).asMethod,
      'encoding': BridgeFunctionDef(
        returns: ConvertTypes.encoding.ref.annotate,
      ).asMethod,
      'bodyFields': BridgeFunctionDef(
        returns: CoreTypes.map.refWith([CoreTypes.string.ref, CoreTypes.string.ref]).annotate,
      ).asMethod,
    },
    setters: {},
    fields: {},
    wrap: true,
  );

  @override
  final Request $value;

  @override
  get $reified => $value;

  $Request.wrap(this.$value);

  static $Value? $new(Runtime runtime, $Value? target, List<$Value?> args) {
    return $Request.wrap(Request(
      args[0]!.$value as String,
      args[1]!.$value as Uri,
    ));
  }

  @override
  $Value? $getProperty(Runtime runtime, String identifier) {
    switch (identifier) {
      case 'bodyBytes':
        return $Uint8List.wrap($value.bodyBytes);
      case 'body':
        return $String($value.body);
      case 'contentLength':
        return $int($value.contentLength);
      case 'encoding':
        return $Encoding.wrap($value.encoding);
      case 'bodyFields':
        return wrapMap<String, String>($value.bodyFields, (key, value) => MapEntry($String(key), $String(value)));
      default:
        return _superclass.$getProperty(runtime, identifier);
    }
  }

  @override
  int $getRuntimeType(Runtime runtime) => runtime.lookupType($type.spec!);

  @override
  void $setProperty(Runtime runtime, String identifier, $Value value) {
    _superclass.$setProperty(runtime, identifier, value);
  }
}

class $BaseResponse implements $Instance {
  static void configureForCompile(BridgeDeclarationRegistry registry) {
    registry.defineBridgeClass($declaration);
  }

  static void configureForRuntime(Runtime runtime) {}

  static final $type = const BridgeTypeSpec(GagakuWebSources.getTypesLibPath, 'BaseResponse').ref;

  static final $declaration = BridgeClassDef(
    BridgeClassType($type),
    constructors: {
      '': BridgeFunctionDef(
        returns: BridgeTypeAnnotation($type),
        params: [
          'statusCode'.param(CoreTypes.int.ref.annotate),
        ],
        namedParams: [
          'contentLength'.param(CoreTypes.int.ref.annotateNullable),
          'request'.param($BaseRequest.$type.annotateNullable),
          'headers'.paramOptional(CoreTypes.map.refWith([CoreTypes.string.ref, CoreTypes.string.ref]).annotate),
          'isRedirect'.paramOptional(CoreTypes.bool.ref.annotate),
          'persistentConnection'.paramOptional(CoreTypes.bool.ref.annotate),
          'reasonPhrase'.param(CoreTypes.string.ref.annotateNullable),
        ],
      ).asConstructor,
    },
    methods: {},
    getters: {
      'statusCode': BridgeFunctionDef(
        returns: CoreTypes.int.ref.annotate,
      ).asMethod,
      'contentLength': BridgeFunctionDef(
        returns: CoreTypes.int.ref.annotateNullable,
      ).asMethod,
      'request': BridgeFunctionDef(
        returns: $BaseRequest.$type.annotateNullable,
      ).asMethod,
      'headers': BridgeFunctionDef(
        returns: CoreTypes.map.refWith([CoreTypes.string.ref, CoreTypes.string.ref]).annotate,
      ).asMethod,
      'isRedirect': BridgeFunctionDef(
        returns: CoreTypes.bool.ref.annotate,
      ).asMethod,
      'persistentConnection': BridgeFunctionDef(
        returns: CoreTypes.bool.ref.annotate,
      ).asMethod,
      'reasonPhrase': BridgeFunctionDef(
        returns: CoreTypes.string.ref.annotateNullable,
      ).asMethod,
    },
    setters: {},
    fields: {},
    wrap: true,
  );

  @override
  final BaseResponse $value;

  @override
  get $reified => $value;

  $BaseResponse.wrap(this.$value);

  @override
  $Value? $getProperty(Runtime runtime, String identifier) {
    switch (identifier) {
      case 'statusCode':
        return $int($value.statusCode);
      case 'contentLength':
        final val = $value.contentLength;
        return val != null ? $int(val) : const $null();
      case 'request':
        return $value.request != null ? $BaseRequest.wrap($value.request!) : const $null();
      case 'headers':
        return wrapMap<String, String>($value.headers, (key, value) => MapEntry($String(key), $String(value)));
      case 'isRedirect':
        return $bool($value.isRedirect);
      case 'persistentConnection':
        return $bool($value.persistentConnection);
      case 'reasonPhrase':
        return $value.reasonPhrase != null ? $String($value.reasonPhrase!) : const $null();
      default:
        return $Object($value).$getProperty(runtime, identifier);
    }
  }

  @override
  int $getRuntimeType(Runtime runtime) => runtime.lookupType($type.spec!);

  @override
  void $setProperty(Runtime runtime, String identifier, $Value value) {
    $Object($value).$setProperty(runtime, identifier, value);
  }
}

class $StreamedResponse implements $Instance {
  static void configureForCompile(BridgeDeclarationRegistry registry) {
    registry.defineBridgeClass($declaration);
  }

  static void configureForRuntime(Runtime runtime) {}

  late final $BaseResponse _superclass = $BaseResponse.wrap($value);

  static final $type = const BridgeTypeSpec(GagakuWebSources.getTypesLibPath, 'StreamedResponse').ref;

  static final $declaration = BridgeClassDef(
    BridgeClassType($type, $extends: $BaseResponse.$type),
    constructors: {},
    methods: {},
    getters: {
      'url': BridgeFunctionDef(
        returns: CoreTypes.uri.ref.annotateNullable,
      ).asMethod,
    },
    wrap: true,
  );

  @override
  final StreamedResponse $value;

  @override
  get $reified => $value;

  $StreamedResponse.wrap(this.$value);

  @override
  $Value? $getProperty(Runtime runtime, String identifier) {
    if (identifier == "url") {
      if ($value case BaseResponseWithUrl(:final url)) {
        return $Uri.wrap(url);
      }
      return const $null();
    }

    return _superclass.$getProperty(runtime, identifier);
  }

  @override
  void $setProperty(Runtime runtime, String identifier, $Value value) {
    return _superclass.$setProperty(runtime, identifier, value);
  }

  @override
  int $getRuntimeType(Runtime runtime) => runtime.lookupType($type.spec!);
}

class $Response implements $Instance {
  static void configureForCompile(BridgeDeclarationRegistry registry) {
    registry.defineBridgeClass($declaration);
  }

  static void configureForRuntime(Runtime runtime) {
    runtime.registerBridgeFunc($type.spec!.library, 'Response.', $new);
    runtime.registerBridgeFunc($type.spec!.library, 'Response.bytes', $bytes);
    runtime.registerBridgeFunc($type.spec!.library, 'Response.fromStream', $fromStream);
  }

  late final $BaseResponse _superclass = $BaseResponse.wrap($value);

  static final $type = const BridgeTypeSpec(GagakuWebSources.getTypesLibPath, 'Response').ref;

  static final $declaration = BridgeClassDef(
    BridgeClassType($type, $extends: $BaseResponse.$type),
    constructors: {
      '': BridgeFunctionDef(
        returns: BridgeTypeAnnotation($type),
        params: [
          'body'.param(CoreTypes.string.ref.annotate),
          'statusCode'.param(CoreTypes.int.ref.annotate),
        ],
        namedParams: [
          'contentLength'.param(CoreTypes.int.ref.annotateNullable),
          'request'.param($BaseRequest.$type.annotateNullable),
          'headers'.paramOptional(CoreTypes.map.refWith([CoreTypes.string.ref, CoreTypes.string.ref]).annotate),
          'isRedirect'.paramOptional(CoreTypes.bool.ref.annotate),
          'persistentConnection'.paramOptional(CoreTypes.bool.ref.annotate),
          'reasonPhrase'.param(CoreTypes.string.ref.annotateNullable),
        ],
      ).asConstructor,
      'bytes': BridgeFunctionDef(
        returns: BridgeTypeAnnotation($type),
        params: [
          'bodyBytes'.param(CoreTypes.list.refWith([CoreTypes.int.ref]).annotate),
          'statusCode'.param(CoreTypes.int.ref.annotate),
        ],
        namedParams: [
          'contentLength'.param(CoreTypes.int.ref.annotateNullable),
          'request'.param($BaseRequest.$type.annotateNullable),
          'headers'.paramOptional(CoreTypes.map.refWith([CoreTypes.string.ref, CoreTypes.string.ref]).annotate),
          'isRedirect'.paramOptional(CoreTypes.bool.ref.annotate),
          'persistentConnection'.paramOptional(CoreTypes.bool.ref.annotate),
          'reasonPhrase'.param(CoreTypes.string.ref.annotateNullable),
        ],
      ).asConstructor,
    },
    methods: {
      'fromStream': BridgeFunctionDef(
        returns: CoreTypes.future.refWith([$type]).annotate,
        params: [
          'response'.param($StreamedResponse.$type.annotate),
        ],
        namedParams: [],
      ).asStaticMethod,
    },
    getters: {
      'bodyBytes': BridgeFunctionDef(
        returns: TypedDataTypes.uint8List.ref.annotate,
      ).asMethod,
      'body': BridgeFunctionDef(
        returns: CoreTypes.string.ref.annotate,
      ).asMethod,
    },
    setters: {},
    fields: {},
    wrap: true,
  );

  @override
  final Response $value;

  @override
  get $reified => $value;

  $Response.wrap(this.$value);

  static $Value? $new(Runtime runtime, $Value? target, List<$Value?> args) {
    return $Response.wrap(Response(
      args[0]!.$value as String,
      args[1]!.$value as int,
      request: args[2]?.$value,
      headers: args[3]?.$value ?? {},
      isRedirect: (args[4]?.$value as bool?) ?? false,
      persistentConnection: (args[5]?.$value as bool?) ?? true,
      reasonPhrase: args[6]?.$value as String?,
    ));
  }

  static $Value? $bytes(Runtime runtime, $Value? target, List<$Value?> args) {
    final bytes = (args[0]!.$value as List).map((value) => value.$reified as int).toList();
    return $Response.wrap(Response.bytes(
      bytes,
      args[1]!.$value as int,
      request: args[2]?.$value,
      headers: args[3]?.$value ?? {},
      isRedirect: (args[4]?.$value as bool?) ?? false,
      persistentConnection: (args[5]?.$value as bool?) ?? true,
      reasonPhrase: args[6]?.$value as String?,
    ));
  }

  static $Value? $fromStream(Runtime runtime, $Value? target, List<$Value?> args) {
    final response = args[0]!.$value as StreamedResponse;
    final result = Response.fromStream(response);
    return $Future.wrap(result.then((value) => $Response.wrap(value)));
  }

  @override
  $Value? $getProperty(Runtime runtime, String identifier) {
    switch (identifier) {
      case 'bodyBytes':
        return $Uint8List.wrap($value.bodyBytes);
      case 'body':
        return $String($value.body);
      default:
        return _superclass.$getProperty(runtime, identifier);
    }
  }

  @override
  int $getRuntimeType(Runtime runtime) => runtime.lookupType($type.spec!);

  @override
  void $setProperty(Runtime runtime, String identifier, $Value value) {
    _superclass.$setProperty(runtime, identifier, value);
  }
}
