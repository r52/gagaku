import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:number_paginator/number_paginator.dart';

NumberPaginatorController useNumberPaginatorController({List<Object?>? keys}) {
  return use(_NumberPaginatorControllerHook(keys: keys));
}

class _NumberPaginatorControllerHook extends Hook<NumberPaginatorController> {
  const _NumberPaginatorControllerHook({super.keys});

  @override
  HookState<NumberPaginatorController, Hook<NumberPaginatorController>>
  createState() => _NumberPaginatorControllerHookHookState();
}

class _NumberPaginatorControllerHookHookState
    extends
        HookState<NumberPaginatorController, _NumberPaginatorControllerHook> {
  late final controller = NumberPaginatorController();

  @override
  NumberPaginatorController build(BuildContext context) => controller;

  @override
  void dispose() => controller.dispose();

  @override
  String get debugLabel => 'useNumberPaginatorController';
}
