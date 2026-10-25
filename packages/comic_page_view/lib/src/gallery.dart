import 'package:flutter/widgets.dart';

import 'gallery_controller.dart';
import 'page_controller.dart';
import 'recognizer.dart';
import 'scale.dart';
import 'zoomable_image.dart';

/// Configuration for one [ComicPageGallery] page.
@immutable
class ComicPageOptions {
  const ComicPageOptions({
    required this.image,
    this.minScale = const ComicScale.contained(),
    this.maxScale = const ComicScale.covered(5),
    this.initialScale = const ComicScale.contained(),
    this.basePosition = Alignment.center,
    this.scaleStateCycle,
    this.semanticLabel,
    this.wantKeepAlive,
  });

  final ImageProvider image;
  final ComicScale minScale;
  final ComicScale maxScale;
  final ComicScale initialScale;
  final Alignment basePosition;
  final ComicScaleCycle? scaleStateCycle;
  final String? semanticLabel;

  /// Overrides [ComicPageGallery.wantKeepAlive] when non-null.
  final bool? wantKeepAlive;
}

typedef ComicPageOptionsBuilder = ComicPageOptions Function(
  BuildContext context,
  int index,
);

/// A [PageView] of [ComicZoomableImage]s that share drags with the pager.
///
/// A single-pointer drag along the pager axis pans the current image while
/// it can move that way, and turns the page otherwise.
class ComicPageGallery extends StatelessWidget {
  const ComicPageGallery.builder({
    super.key,
    required this.controller,
    required this.itemCount,
    required this.builder,
    this.onPageChanged,
    this.scrollDirection = Axis.horizontal,
    this.reverse = false,
    this.scrollPhysics,
    this.allowImplicitScrolling = false,
    this.backgroundDecoration,
    this.loadingBuilder,
    this.errorBuilder,
    this.wantKeepAlive = false,
    this.resetOffscreenPages = false,
  });

  final ComicGalleryController controller;
  final int itemCount;
  final ComicPageOptionsBuilder builder;
  final ValueChanged<int>? onPageChanged;
  final Axis scrollDirection;
  final bool reverse;
  final ScrollPhysics? scrollPhysics;
  final bool allowImplicitScrolling;

  /// Painted behind each page; defaults to opaque black.
  final BoxDecoration? backgroundDecoration;

  final ComicLoadingBuilder? loadingBuilder;
  final ComicErrorBuilder? errorBuilder;

  /// Default for pages whose options leave [ComicPageOptions.wantKeepAlive]
  /// null.
  final bool wantKeepAlive;

  /// Resets every mounted page other than the new one when the page changes.
  final bool resetOffscreenPages;

  @override
  Widget build(BuildContext context) {
    return ComicGalleryScope(
      axis: scrollDirection,
      child: PageView.builder(
        controller: controller.pageController,
        scrollDirection: scrollDirection,
        reverse: reverse,
        physics: scrollPhysics,
        allowImplicitScrolling: allowImplicitScrolling,
        itemCount: itemCount,
        onPageChanged: (page) {
          if (resetOffscreenPages) {
            for (final index in controller.mountedPages) {
              if (index != page) controller.pageAt(index)?.reset();
            }
          }
          onPageChanged?.call(page);
        },
        itemBuilder: (context, index) => _ComicGalleryPage(
          controller: controller,
          index: index,
          options: builder(context, index),
          backgroundDecoration: backgroundDecoration,
          loadingBuilder: loadingBuilder,
          errorBuilder: errorBuilder,
          wantKeepAlive: wantKeepAlive,
        ),
      ),
    );
  }
}

/// Owns one page's controller and registers it with the gallery.
class _ComicGalleryPage extends StatefulWidget {
  const _ComicGalleryPage({
    required this.controller,
    required this.index,
    required this.options,
    required this.backgroundDecoration,
    required this.loadingBuilder,
    required this.errorBuilder,
    required this.wantKeepAlive,
  });

  final ComicGalleryController controller;
  final int index;
  final ComicPageOptions options;
  final BoxDecoration? backgroundDecoration;
  final ComicLoadingBuilder? loadingBuilder;
  final ComicErrorBuilder? errorBuilder;
  final bool wantKeepAlive;

  @override
  State<_ComicGalleryPage> createState() => _ComicGalleryPageState();
}

class _ComicGalleryPageState extends State<_ComicGalleryPage> {
  final _pageController = ComicPageController();

  @override
  void initState() {
    super.initState();
    widget.controller.registerPage(widget.index, _pageController);
  }

  @override
  void didUpdateWidget(_ComicGalleryPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller ||
        widget.index != oldWidget.index) {
      oldWidget.controller.unregisterPage(oldWidget.index, _pageController);
      widget.controller.registerPage(widget.index, _pageController);
    }
  }

  @override
  void dispose() {
    widget.controller.unregisterPage(widget.index, _pageController);
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final options = widget.options;

    return ComicZoomableImage(
      image: options.image,
      controller: _pageController,
      minScale: options.minScale,
      maxScale: options.maxScale,
      initialScale: options.initialScale,
      basePosition: options.basePosition,
      scaleStateCycle: options.scaleStateCycle,
      backgroundDecoration: widget.backgroundDecoration,
      loadingBuilder: widget.loadingBuilder,
      errorBuilder: widget.errorBuilder,
      wantKeepAlive: options.wantKeepAlive ?? widget.wantKeepAlive,
      semanticLabel: options.semanticLabel,
    );
  }
}
