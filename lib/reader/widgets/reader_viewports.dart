import 'package:flutter/material.dart';
import 'package:gagaku/reader/model/config.dart';
import 'package:gagaku/reader/model/types.dart';
import 'package:gagaku/reader/model/viewport_controller.dart';
import 'package:gagaku/reader/widgets/long_strip_page_image.dart';
import 'package:gagaku/reader/widgets/passive_tap_listener.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:super_sliver_list/super_sliver_list.dart';

class HorizontalReaderView extends StatelessWidget {
  const HorizontalReaderView({
    super.key,
    required this.controller,
    required this.pages,
    required this.settings,
    required this.onTap,
    required this.onPageChanged,
    required this.onInteraction,
  });

  final HorizontalReaderViewportController controller;
  final List<ReaderPage> pages;
  final ReaderConfig settings;
  final ValueChanged<Offset> onTap;
  final ValueChanged<int> onPageChanged;
  final VoidCallback onInteraction;

  @override
  Widget build(BuildContext context) {
    return PassiveTapListener(
      onTap: onTap,
      child: PhotoViewGallery.builder(
        allowImplicitScrolling: true,
        reverse: settings.direction == ReaderDirection.rightToLeft,
        scrollPhysics: !settings.swipeGestures
            ? const NeverScrollableScrollPhysics()
            : null,
        backgroundDecoration: const BoxDecoration(color: Colors.black),
        pageController: controller.pageController,
        onPageChanged: (index) {
          onPageChanged(index);
          onInteraction();
        },
        loadingBuilder: (context, event) => Center(
          child: SizedBox(
            width: 150,
            child: LinearProgressIndicator(
              value: event != null && event.expectedTotalBytes != null
                  ? event.cumulativeBytesLoaded / event.expectedTotalBytes!
                  : null,
            ),
          ),
        ),
        itemCount: pages.length,
        builder: (context, index) {
          final page = pages[index];
          return PhotoViewGalleryPageOptions(
            heroAttributes: PhotoViewHeroAttributes(tag: page.id),
            imageProvider: page.provider,
            controller: controller.viewController(index),
            scaleStateController: controller.scaleController(index),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 5,
            initialScale: PhotoViewComputedScale.contained,
            basePosition: Alignment.center,
          );
        },
      ),
    );
  }
}

class LongStripReaderView extends StatelessWidget {
  const LongStripReaderView({
    super.key,
    required this.controller,
    required this.pages,
    required this.displayWidth,
    required this.cacheWidth,
    required this.onCenterTap,
  });

  final LongStripReaderViewportController controller;
  final List<ReaderPage> pages;
  final double displayWidth;
  final int cacheWidth;
  final VoidCallback onCenterTap;

  @override
  Widget build(BuildContext context) {
    final mediaSize = MediaQuery.sizeOf(context);

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTapUp: (details) {
        final taploc = details.localPosition.dx;
        final tapmargin = mediaSize.width / 2.5;

        if (taploc > tapmargin && taploc < mediaSize.width - tapmargin) {
          onCenterTap();
        }
      },
      child: SuperListView.builder(
        listController: controller.listController,
        controller: controller.scrollController,
        cacheExtent: mediaSize.height * 3,
        addAutomaticKeepAlives: false,
        extentEstimation: (index, _) {
          if (index == null) return 0;
          final aspectRatio = pages[index].aspectRatio;
          return aspectRatio == null
              ? mediaSize.height
              : displayWidth / aspectRatio;
        },
        itemCount: pages.length,
        itemBuilder: (context, index) {
          final page = pages[index];
          return Center(
            key: ValueKey(page.id),
            child: RepaintBoundary(
              child: LongStripPageImage(
                page: page,
                displayWidth: displayWidth,
                cacheWidth: cacheWidth,
                onAspectRatioChanged: () => controller.invalidateExtent(index),
              ),
            ),
          );
        },
      ),
    );
  }
}
