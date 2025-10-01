// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:photo_view/photo_view.dart';
import 'package:super_sliver_list/super_sliver_list.dart';

ListController useListController({
  VoidCallback? onAttached,
  VoidCallback? onDetached,
  List<Object?>? keys,
}) {
  return use(
    _ListControllerHook(
      onAttached: onAttached,
      onDetached: onDetached,
      keys: keys,
    ),
  );
}

class _ListControllerHook extends Hook<ListController> {
  const _ListControllerHook({
    this.onAttached,
    this.onDetached,
    List<Object?>? keys,
  }) : super(keys: keys);

  /// Callback invoked when the controller is attached to a [SuperSliverList].
  final VoidCallback? onAttached;

  /// Callback invoked when the controller is detached from a [SuperSliverList].
  final VoidCallback? onDetached;

  @override
  HookState<ListController, Hook<ListController>> createState() =>
      _ListControllerHookHookState();
}

class _ListControllerHookHookState
    extends HookState<ListController, _ListControllerHook> {
  late final controller = ListController(
    onAttached: hook.onAttached,
    onDetached: hook.onDetached,
  );

  @override
  ListController build(BuildContext context) => controller;

  @override
  void dispose() => controller.dispose();

  @override
  String get debugLabel => 'useListController';
}

PhotoViewController usePhotoViewController({
  Offset initialPosition = Offset.zero,
  double initialRotation = 0.0,
  double? initialScale,
  List<Object?>? keys,
}) {
  return use(
    _PhotoViewControllerHook(
      initialPosition: initialPosition,
      initialRotation: initialRotation,
      initialScale: initialScale,
      keys: keys,
    ),
  );
}

class _PhotoViewControllerHook extends Hook<PhotoViewController> {
  const _PhotoViewControllerHook({
    required this.initialPosition,
    required this.initialRotation,
    this.initialScale,
    List<Object?>? keys,
  }) : super(keys: keys);

  final Offset initialPosition;
  final double initialRotation;
  final double? initialScale;

  @override
  HookState<PhotoViewController, Hook<PhotoViewController>> createState() =>
      _PhotoViewControllerHookState();
}

class _PhotoViewControllerHookState
    extends HookState<PhotoViewController, _PhotoViewControllerHook> {
  late final controller = PhotoViewController(
    initialPosition: hook.initialPosition,
    initialRotation: hook.initialRotation,
    initialScale: hook.initialScale,
  );

  @override
  PhotoViewController build(BuildContext context) => controller;

  @override
  void dispose() => controller.dispose();

  @override
  String get debugLabel => 'usePhotoViewController';
}

PhotoViewScaleStateController usePhotoViewScaleStateController({
  List<Object?>? keys,
}) {
  return use(_PhotoViewScaleStateControllerHook(keys: keys));
}

class _PhotoViewScaleStateControllerHook
    extends Hook<PhotoViewScaleStateController> {
  const _PhotoViewScaleStateControllerHook({List<Object?>? keys})
    : super(keys: keys);

  @override
  HookState<PhotoViewScaleStateController, Hook<PhotoViewScaleStateController>>
  createState() => _PhotoViewScaleStateControllerHookState();
}

class _PhotoViewScaleStateControllerHookState
    extends
        HookState<
          PhotoViewScaleStateController,
          _PhotoViewScaleStateControllerHook
        > {
  late final controller = PhotoViewScaleStateController();

  @override
  PhotoViewScaleStateController build(BuildContext context) => controller;

  @override
  void dispose() => controller.dispose();

  @override
  String get debugLabel => 'usePhotoViewScaleStateController';
}
