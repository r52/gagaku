// ignore_for_file: use_super_parameters

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:photo_view/photo_view.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

ItemScrollController useItemScrollController({
  List<Object?>? keys,
}) {
  return use(
    _ItemScrollControllerHook(
      keys: keys,
    ),
  );
}

class _ItemScrollControllerHook extends Hook<ItemScrollController> {
  const _ItemScrollControllerHook({
    List<Object?>? keys,
  }) : super(keys: keys);

  @override
  HookState<ItemScrollController, Hook<ItemScrollController>> createState() =>
      _ItemScrollControllerHookState();
}

class _ItemScrollControllerHookState
    extends HookState<ItemScrollController, _ItemScrollControllerHook> {
  late final controller = ItemScrollController();

  @override
  ItemScrollController build(BuildContext context) => controller;

  @override
  String get debugLabel => 'useItemScrollController';
}

ScrollOffsetController useScrollOffsetController({
  List<Object?>? keys,
}) {
  return use(
    _ScrollOffsetControllerHook(
      keys: keys,
    ),
  );
}

class _ScrollOffsetControllerHook extends Hook<ScrollOffsetController> {
  const _ScrollOffsetControllerHook({
    List<Object?>? keys,
  }) : super(keys: keys);

  @override
  HookState<ScrollOffsetController, Hook<ScrollOffsetController>>
      createState() => _ScrollOffsetControllerHookState();
}

class _ScrollOffsetControllerHookState
    extends HookState<ScrollOffsetController, _ScrollOffsetControllerHook> {
  late final controller = ScrollOffsetController();

  @override
  ScrollOffsetController build(BuildContext context) => controller;

  @override
  String get debugLabel => 'useScrollOffsetController';
}

ItemPositionsListener useItemPositionsListener({
  List<Object?>? keys,
}) {
  return use(
    _ItemPositionsListenerHook(
      keys: keys,
    ),
  );
}

class _ItemPositionsListenerHook extends Hook<ItemPositionsListener> {
  const _ItemPositionsListenerHook({
    List<Object?>? keys,
  }) : super(keys: keys);

  @override
  HookState<ItemPositionsListener, Hook<ItemPositionsListener>> createState() =>
      _ItemPositionsListenerHookState();
}

class _ItemPositionsListenerHookState
    extends HookState<ItemPositionsListener, _ItemPositionsListenerHook> {
  late final listener = ItemPositionsListener.create();

  @override
  ItemPositionsListener build(BuildContext context) => listener;

  @override
  String get debugLabel => 'useItemPositionsListener';
}

ExtendedPageController useExtendedPageController({
  int initialPage = 0,
  bool keepPage = true,
  double viewportFraction = 1.0,
  double pageSpacing = 0.0,
  bool shouldIgnorePointerWhenScrolling = false,
  List<Object?>? keys,
}) {
  return use(
    _ExtendedPageControllerHook(
      initialPage: initialPage,
      keepPage: keepPage,
      viewportFraction: viewportFraction,
      pageSpacing: pageSpacing,
      shouldIgnorePointerWhenScrolling: shouldIgnorePointerWhenScrolling,
      keys: keys,
    ),
  );
}

class _ExtendedPageControllerHook extends Hook<ExtendedPageController> {
  const _ExtendedPageControllerHook({
    required this.initialPage,
    required this.keepPage,
    required this.viewportFraction,
    required this.pageSpacing,
    required this.shouldIgnorePointerWhenScrolling,
    List<Object?>? keys,
  }) : super(keys: keys);

  final int initialPage;
  final bool keepPage;
  final double viewportFraction;
  final double pageSpacing;
  final bool shouldIgnorePointerWhenScrolling;

  @override
  HookState<ExtendedPageController, Hook<ExtendedPageController>>
      createState() => _ExtendedPageControllerHookState();
}

class _ExtendedPageControllerHookState
    extends HookState<ExtendedPageController, _ExtendedPageControllerHook> {
  late final controller = ExtendedPageController(
    initialPage: hook.initialPage,
    keepPage: hook.keepPage,
    viewportFraction: hook.viewportFraction,
    pageSpacing: hook.pageSpacing,
    shouldIgnorePointerWhenScrolling: hook.shouldIgnorePointerWhenScrolling,
  );

  @override
  ExtendedPageController build(BuildContext context) => controller;

  @override
  void dispose() => controller.dispose();

  @override
  String get debugLabel => 'useExtendedPageController';
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
  return use(
    _PhotoViewScaleStateControllerHook(
      keys: keys,
    ),
  );
}

class _PhotoViewScaleStateControllerHook
    extends Hook<PhotoViewScaleStateController> {
  const _PhotoViewScaleStateControllerHook({
    List<Object?>? keys,
  }) : super(keys: keys);

  @override
  HookState<PhotoViewScaleStateController, Hook<PhotoViewScaleStateController>>
      createState() => _PhotoViewScaleStateControllerHookState();
}

class _PhotoViewScaleStateControllerHookState extends HookState<
    PhotoViewScaleStateController, _PhotoViewScaleStateControllerHook> {
  late final controller = PhotoViewScaleStateController();

  @override
  PhotoViewScaleStateController build(BuildContext context) => controller;

  @override
  void dispose() => controller.dispose();

  @override
  String get debugLabel => 'usePhotoViewScaleStateController';
}
