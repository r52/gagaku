import 'dart:collection';

import 'package:dart_eval/dart_eval_bridge.dart';
import 'package:dart_eval/dart_eval_extensions.dart';
// ignore: implementation_imports
import 'package:dart_eval/src/eval/utils/wap_helper.dart';
import 'package:dart_eval/stdlib/collection.dart';
import 'package:dart_eval/stdlib/core.dart';
import 'package:gagaku/web/eval/util.dart';
import 'package:html/dom.dart';

class $Document implements $Instance {
  static void configureForCompile(BridgeDeclarationRegistry registry) {
    registry.defineBridgeClass($declaration);
  }

  static void configureForRuntime(Runtime runtime) {
    runtime.registerBridgeFunc($type.spec!.library, 'Document.html', $html);
  }

  static final $type = const BridgeTypeSpec(GagakuWebSources.getTypesLibPath, 'Document').ref;

  static final $declaration = BridgeClassDef(
    BridgeClassType($type),
    constructors: {},
    methods: {
      'html': BridgeFunctionDef(returns: $type.annotate, params: [
        'html'.param(CoreTypes.string.ref.annotate),
      ]).asStaticMethod,
      'querySelectorAll': BridgeFunctionDef(
        returns: CoreTypes.list.refWith([$Element.$type]).annotate,
        params: [
          'selector'.param(CoreTypes.string.ref.annotate),
        ],
      ).asMethod,
      'querySelector': BridgeFunctionDef(
        returns: $Element.$type.annotateNullable,
        params: [
          'selector'.param(CoreTypes.string.ref.annotate),
        ],
      ).asMethod,
    },
    getters: {
      'documentElement': BridgeFunctionDef(
        returns: $Element.$type.annotateNullable,
      ).asMethod,
      'head': BridgeFunctionDef(
        returns: $Element.$type.annotateNullable,
      ).asMethod,
      'body': BridgeFunctionDef(
        returns: $Element.$type.annotateNullable,
      ).asMethod,
      'outerHtml': BridgeFunctionDef(
        returns: CoreTypes.string.ref.annotate,
      ).asMethod,
    },
    wrap: true,
  );

  @override
  final Document $value;

  @override
  get $reified => $value;

  $Document.wrap(this.$value);

  @override
  $Value? $getProperty(Runtime runtime, String identifier) {
    switch (identifier) {
      case 'documentElement':
        final val = $value.documentElement;
        return val != null ? $Element.wrap(val) : const $null();
      case 'head':
        final val = $value.head;
        return val != null ? $Element.wrap(val) : const $null();
      case 'body':
        final val = $value.body;
        return val != null ? $Element.wrap(val) : const $null();
      case 'outerHtml':
        return $String($value.outerHtml);
      case 'querySelectorAll':
        return __querySelectorAll;
      case 'querySelector':
        return __querySelector;
      default:
        break;
    }

    return $Object(this).$getProperty(runtime, identifier);
  }

  @override
  void $setProperty(Runtime runtime, String identifier, $Value value) {
    return $Object(this).$setProperty(runtime, identifier, value);
  }

  static $Value? $html(Runtime runtime, $Value? target, List<$Value?> args) {
    return $Document.wrap(Document.html(args[0]!.$value as String));
  }

  static const $Function __querySelector = $Function(_querySelector);
  static $Value? _querySelector(final Runtime runtime, final $Value? target, final List<$Value?> args) {
    final selector = args[0]!.$value as String;
    final result = (target as $Document).$value.querySelector(selector);
    return result != null ? $Element.wrap(result) : const $null();
  }

  static const $Function __querySelectorAll = $Function(_querySelectorAll);
  static $Value? _querySelectorAll(final Runtime runtime, final $Value? target, final List<$Value?> args) {
    final selector = args[0]!.$value as String;
    final result = (target as $Document).$value.querySelectorAll(selector);
    return wrapList<Element>(result, (e) => $Element.wrap(e));
  }

  @override
  int $getRuntimeType(Runtime runtime) => runtime.lookupType($type.spec!);
}

class $Element implements $Instance {
  static void configureForCompile(BridgeDeclarationRegistry registry) {
    registry.defineBridgeClass($declaration);
  }

  static void configureForRuntime(Runtime runtime) {
    runtime.registerBridgeFunc($type.spec!.library, 'Element.html', $html);
  }

  static final $type = const BridgeTypeSpec(GagakuWebSources.getTypesLibPath, 'Element').ref;

  static final $declaration = BridgeClassDef(
    BridgeClassType($type),
    constructors: {},
    methods: {
      'html': BridgeFunctionDef(returns: $type.annotate, params: [
        'html'.param(CoreTypes.string.ref.annotate),
      ]).asStaticMethod,
      'querySelectorAll': BridgeFunctionDef(
        returns: CoreTypes.list.refWith([$type]).annotate,
        params: [
          'selector'.param(CoreTypes.string.ref.annotate),
        ],
      ).asMethod,
      'querySelector': BridgeFunctionDef(
        returns: $type.annotateNullable,
        params: [
          'selector'.param(CoreTypes.string.ref.annotate),
        ],
      ).asMethod,
    },
    getters: {
      'className': BridgeFunctionDef(
        returns: CoreTypes.string.ref.annotate,
      ).asMethod,
      'id': BridgeFunctionDef(
        returns: CoreTypes.string.ref.annotate,
      ).asMethod,
      'innerHtml': BridgeFunctionDef(
        returns: CoreTypes.string.ref.annotate,
      ).asMethod,
      'outerHtml': BridgeFunctionDef(
        returns: CoreTypes.string.ref.annotate,
      ).asMethod,
      'text': BridgeFunctionDef(
        returns: CoreTypes.string.ref.annotate,
      ).asMethod,
      'attributes': BridgeFunctionDef(
        returns: CollectionTypes.linkedHashMap.refWith([
          CoreTypes.string.ref,
          CoreTypes.string.ref,
        ]).annotate,
      ).asMethod,
      'children': BridgeFunctionDef(
        returns: CoreTypes.list.refWith([$type]).annotate,
      ).asMethod,
      'previousElementSibling': BridgeFunctionDef(
        returns: $type.annotateNullable,
      ).asMethod,
      'nextElementSibling': BridgeFunctionDef(
        returns: $type.annotateNullable,
      ).asMethod,
      'parent': BridgeFunctionDef(
        returns: $type.annotateNullable,
      ).asMethod,
    },
    wrap: true,
  );

  @override
  final Element $value;

  @override
  get $reified => $value;

  $Element.wrap(this.$value);

  @override
  $Value? $getProperty(Runtime runtime, String identifier) {
    switch (identifier) {
      case 'className':
        return $String($value.className);
      case 'id':
        return $String($value.id);
      case 'innerHtml':
        return $String($value.innerHtml);
      case 'outerHtml':
        return $String($value.outerHtml);
      case 'text':
        return $String($value.text);
      case 'attributes':
        final map = $value.attributes.map((key, value) => MapEntry($String(key as String), $String(value)));
        return $LinkedHashMap.wrap(LinkedHashMap.from(map));
      case 'children':
        return wrapList($value.children, (e) => $Element.wrap(e));
      case 'previousElementSibling':
        return $value.previousElementSibling != null ? $Element.wrap($value.previousElementSibling!) : const $null();
      case 'nextElementSibling':
        return $value.nextElementSibling != null ? $Element.wrap($value.nextElementSibling!) : const $null();
      case 'parent':
        return $value.parent != null ? $Element.wrap($value.parent!) : const $null();
      case 'querySelectorAll':
        return __querySelectorAll;
      case 'querySelector':
        return __querySelector;
      default:
        break;
    }

    return $Object(this).$getProperty(runtime, identifier);
  }

  @override
  void $setProperty(Runtime runtime, String identifier, $Value value) {
    return $Object(this).$setProperty(runtime, identifier, value);
  }

  static $Value? $html(Runtime runtime, $Value? target, List<$Value?> args) {
    return $Element.wrap(Element.html(args[0]!.$value as String));
  }

  static const $Function __querySelector = $Function(_querySelector);
  static $Value? _querySelector(final Runtime runtime, final $Value? target, final List<$Value?> args) {
    final selector = args[0]!.$value as String;
    final result = (target as $Element).$value.querySelector(selector);
    return result != null ? $Element.wrap(result) : const $null();
  }

  static const $Function __querySelectorAll = $Function(_querySelectorAll);
  static $Value? _querySelectorAll(final Runtime runtime, final $Value? target, final List<$Value?> args) {
    final selector = args[0]!.$value as String;
    final result = (target as $Element).$value.querySelectorAll(selector);
    return wrapList<Element>(result, (e) => $Element.wrap(e));
  }

  @override
  int $getRuntimeType(Runtime runtime) => runtime.lookupType($type.spec!);
}
