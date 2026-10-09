import 'dart:math';

import 'package:cached_network_image_ce/cached_network_image.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/util/cached_network_image.dart';
import 'package:gagaku/util/ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:photo_view/photo_view.dart';

/// A tab shown by [MangaDetailScaffold].
class MangaDetailTab {
  const MangaDetailTab({
    required this.label,
    required this.body,
    this.scrollToTop = false,
  });

  final String label;

  /// A vertical scroll view that does not set its own controller. Its pinned
  /// headers belong in its own slivers so the outer layout stays stable when
  /// switching tabs.
  final Widget body;

  /// Whether the scroll-to-top button is shown for this tab and attached to
  /// its scroll view.
  final bool scrollToTop;
}

/// Shared adaptive layout for manga detail pages.
///
/// The layout is chosen from the space available to the page rather than the
/// window, so navigation chrome is accounted for. Short viewports, such as
/// phones in landscape, keep the collapsing single-pane layout.
class MangaDetailScaffold extends StatelessWidget {
  static const minTwoPaneWidth = 600.0;
  static const minTwoPaneHeight = 480.0;

  static bool useTwoPane(Size size) =>
      size.width >= minTwoPaneWidth && size.height >= minTwoPaneHeight;

  const MangaDetailScaffold({
    super.key,
    required this.title,
    required this.coverUrl,
    this.coverHeaders,
    this.badge,
    this.actions,
    required this.metadata,
    required this.tabController,
    required this.tabs,
    required this.onRefresh,
    required this.scrollController,
    this.onBack,
    this.collapsedBannerHeight,
  }) : assert(tabs.length > 0);

  final String title;
  final String coverUrl;
  final Map<String, String>? coverHeaders;

  /// Small source/language marker shown on the banner or below the title.
  final Widget? badge;
  final Widget? actions;
  final Widget metadata;
  final TabController tabController;
  final List<MangaDetailTab> tabs;
  final RefreshCallback onRefresh;

  /// Used by the scroll-to-top button. In the single-pane layout it drives
  /// the whole [NestedScrollView]; in the two-pane layout it is attached to
  /// the active [MangaDetailTab.scrollToTop] tab.
  final ScrollController scrollController;
  final VoidCallback? onBack;
  final double? collapsedBannerHeight;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.biggest;
        if (useTwoPane(size)) {
          return _MangaDetailTwoPane(config: this, width: size.width);
        }
        return _MangaDetailSinglePane(
          config: this,
          width: size.width,
          compactHeight: size.height < minTwoPaneHeight,
        );
      },
    );
  }
}

MangaDetailTab _activeTab(MangaDetailScaffold config, int index) =>
    config.tabs[index.clamp(0, config.tabs.length - 1)];

class _MangaDetailTabBar extends StatelessWidget {
  const _MangaDetailTabBar({required this.config});

  final MangaDetailScaffold config;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      child: TabBar(
        controller: config.tabController,
        tabs: [for (final tab in config.tabs) Tab(text: tab.label)],
      ),
    );
  }
}

class _MangaDetailTwoPane extends HookWidget {
  const _MangaDetailTwoPane({required this.config, required this.width});

  final MangaDetailScaffold config;
  final double width;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final index = useListenableSelector(
      config.tabController,
      () => config.tabController.index,
    );
    final active = _activeTab(config, index);
    final paneWidth = (width * 0.35).clamp(240.0, 360.0);
    const coverPadding = 12.0;

    return Scaffold(
      // The title lives in the side pane, where long titles can wrap, so the
      // toolbar keeps its width for actions.
      appBar: AppBar(
        leading: BackButton(onPressed: config.onBack),
        actions: [?config.actions],
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: paneWidth,
            child: SingleChildScrollView(
              primary: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(coverPadding),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: AspectRatio(
                        aspectRatio: 2 / 3,
                        child: MangaDetailCover(
                          url: config.coverUrl,
                          headers: config.coverHeaders,
                          displayWidth: paneWidth - coverPadding * 2,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: coverPadding,
                    ),
                    child: Text(
                      config.title,
                      style: theme.textTheme.titleLarge,
                    ),
                  ),
                  if (config.badge != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: coverPadding,
                        vertical: 4.0,
                      ),
                      child: config.badge,
                    ),
                  config.metadata,
                ],
              ),
            ),
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: Column(
              children: [
                if (config.tabs.length > 1) _MangaDetailTabBar(config: config),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: config.onRefresh,
                    child: active.scrollToTop
                        ? PrimaryScrollController(
                            controller: config.scrollController,
                            automaticallyInheritForPlatforms: TargetPlatform
                                .values
                                .toSet(),
                            child: KeyedSubtree(
                              key: ValueKey(index),
                              child: active.body,
                            ),
                          )
                        : PrimaryScrollController.none(
                            child: KeyedSubtree(
                              key: ValueKey(index),
                              child: active.body,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: ScrollToTopFab(
        controller: config.scrollController,
        visibleCondition: () => active.scrollToTop,
      ),
    );
  }
}

class _MangaDetailSinglePane extends HookWidget {
  const _MangaDetailSinglePane({
    required this.config,
    required this.width,
    required this.compactHeight,
  });

  final MangaDetailScaffold config;
  final double width;
  final bool compactHeight;

  @override
  Widget build(BuildContext context) {
    final index = useListenableSelector(
      config.tabController,
      () => config.tabController.index,
    );
    final active = _activeTab(config, index);
    // Matches the collapsed SliverAppBar extent below.
    final padding = MediaQuery.paddingOf(context);
    final pinnedExtent =
        (config.collapsedBannerHeight ?? kToolbarHeight) + padding.top;
    // The toolbar's leading button respects side insets (e.g. a landscape
    // display cutout); the banner title and badge must too.
    final titleStart =
        kToolbarHeight +
        NavigationToolbar.kMiddleSpacing +
        switch (Directionality.of(context)) {
          TextDirection.ltr => padding.left,
          TextDirection.rtl => padding.right,
        };

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: config.onRefresh,
        notificationPredicate: (notification) {
          // Depth 1 is the top of the NestedScrollView
          if (notification is OverscrollNotification &&
              notification.velocity == 0.0 &&
              notification.overscroll < 0.0) {
            return notification.depth == 1;
          }

          return notification.depth == 0;
        },
        child: NestedScrollView(
          controller: config.scrollController,
          scrollBehavior: const MouseTouchScrollBehavior(),
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            _SliverPinnedOverlap(
              extent: pinnedExtent,
              sliver: SliverMainAxisGroup(
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    snap: false,
                    floating: false,
                    forceElevated: innerBoxIsScrolled,
                    expandedHeight: compactHeight ? 120.0 : 250.0,
                    collapsedHeight: config.collapsedBannerHeight,
                    leading: BackButton(onPressed: config.onBack),
                    flexibleSpace: FlexibleSpaceBar(
                      expandedTitleScale: compactHeight ? 1.5 : 2.0,
                      titlePadding: EdgeInsetsDirectional.only(
                        start: titleStart,
                        bottom: 16.0,
                      ),
                      title: Text(
                        config.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(1.0, 1.0),
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ],
                        ),
                      ),
                      background: Stack(
                        fit: StackFit.expand,
                        children: [
                          // Dimmed so the banner title stays legible.
                          MangaDetailCover(
                            url: config.coverUrl,
                            headers: config.coverHeaders,
                            displayWidth: width,
                            dimmed: true,
                          ),
                          // Beside the back button: clear of the expanded
                          // title, and faded out with the background before
                          // the collapsed title appears in the toolbar.
                          if (config.badge != null)
                            PositionedDirectional(
                              top: padding.top,
                              start: titleStart,
                              height: kToolbarHeight,
                              child: Align(
                                alignment: AlignmentDirectional.centerStart,
                                child: config.badge,
                              ),
                            ),
                        ],
                      ),
                    ),
                    actions: [?config.actions],
                  ),
                  SliverToBoxAdapter(child: config.metadata),
                  if (config.tabs.length > 1)
                    SliverToBoxAdapter(
                      child: _MangaDetailTabBar(config: config),
                    ),
                ],
              ),
            ),
          ],
          body: SafeArea(
            top: false,
            bottom: true,
            child: Padding(
              padding: EdgeInsets.only(top: pinnedExtent),
              child: KeyedSubtree(key: ValueKey(index), child: active.body),
            ),
          ),
        ),
      ),
      floatingActionButton: ScrollToTopFab(
        controller: config.scrollController,
        visibleCondition: () => active.scrollToTop,
      ),
    );
  }
}

/// Keeps the pinned part of the header out of the outer scroll range, like
/// [SliverOverlapAbsorber], so a [NestedScrollView] body padded by [extent]
/// is never covered by the collapsed app bar.
///
/// [SliverOverlapAbsorber] cannot be used directly: it must wrap the last
/// header sliver, and [SliverMainAxisGroup] does not report its pinned
/// extent.
class _SliverPinnedOverlap extends SingleChildRenderObjectWidget {
  const _SliverPinnedOverlap({required this.extent, required Widget sliver})
    : super(child: sliver);

  final double extent;

  @override
  RenderObject createRenderObject(BuildContext context) =>
      _RenderSliverPinnedOverlap(extent);

  @override
  void updateRenderObject(
    BuildContext context,
    _RenderSliverPinnedOverlap renderObject,
  ) {
    renderObject.extent = extent;
  }
}

class _RenderSliverPinnedOverlap extends RenderProxySliver {
  _RenderSliverPinnedOverlap(this._extent);

  double _extent;
  set extent(double value) {
    if (value == _extent) return;
    _extent = value;
    markNeedsLayout();
  }

  @override
  void performLayout() {
    super.performLayout();
    final childGeometry = geometry!;
    if (childGeometry.scrollOffsetCorrection != null) return;
    geometry = childGeometry.copyWith(
      scrollExtent: max(0.0, childGeometry.scrollExtent - _extent),
      layoutExtent: max(0.0, childGeometry.paintExtent - _extent),
    );
  }
}

/// Cover image decoded close to its rendered size.
class MangaDetailCover extends ConsumerWidget {
  /// Decode widths are rounded up to this step so resizing a window does not
  /// re-decode the image on every frame.
  static const _decodeStep = 128;

  const MangaDetailCover({
    super.key,
    required this.url,
    this.headers,
    required this.displayWidth,
    this.dimmed = false,
  });

  final String url;
  final Map<String, String>? headers;
  final double displayWidth;
  final bool dimmed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final physicalWidth = displayWidth * MediaQuery.devicePixelRatioOf(context);
    final decodeWidth =
        max(1, (physicalWidth / _decodeStep).ceil()) * _decodeStep;

    return CachedNetworkImage(
      imageUrl: url,
      httpHeaders: headers,
      cacheManager: ref.watch(extensionImageCacheProvider),
      memCacheWidth: decodeWidth,
      color: dimmed ? Colors.grey : null,
      colorBlendMode: dimmed ? BlendMode.modulate : null,
      fit: BoxFit.cover,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          const Center(child: CircularProgressIndicator()),
      errorBuilder: (context, error, stacktrace) =>
          Tooltip(message: error.toString(), child: const Icon(Icons.error)),
    );
  }
}

/// Grid tile for a cover or artwork image that opens [CoverArtPagedOverlay].
class CoverArtGridItem extends HookConsumerWidget {
  const CoverArtGridItem({
    super.key,
    required this.url,
    this.headers,
    required this.heroTag,
    this.footer,
    this.onTap,
  });

  final String url;
  final Map<String, String>? headers;
  final Object heroTag;
  final Widget? footer;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final aniController = useAnimationController(
      duration: const Duration(milliseconds: 100),
    );

    final image = GridAlbumImage(
      animation: aniController.drive(Styles.coverArtGradientTween),
      child: CachedNetworkImage(
        imageUrl: url,
        httpHeaders: headers,
        cacheManager: ref.watch(extensionImageCacheProvider),
        width: 256.0,
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            const Center(child: CircularProgressIndicator()),
        errorBuilder: (context, error, stacktrace) =>
            Tooltip(message: error.toString(), child: const Icon(Icons.error)),
        fit: BoxFit.cover,
      ),
    );

    return Hero(
      tag: heroTag,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          onHover: (hovering) {
            if (hovering) {
              aniController.forward();
            } else {
              aniController.reverse();
            }
          },
          child: footer != null
              ? GridTile(footer: footer, child: image)
              : image,
        ),
      ),
    );
  }
}

typedef CoverArtOverlayItem = ({String url, Object heroTag});

/// Full-screen, zoomable pager over cover or artwork images.
class CoverArtPagedOverlay extends HookConsumerWidget {
  const CoverArtPagedOverlay({
    super.key,
    required this.index,
    required this.items,
    this.headers,
  });

  final int index;
  final List<CoverArtOverlayItem> items;
  final Map<String, String>? headers;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = usePageController(initialPage: index);
    final activePage = useState(index);
    final imageCache = ref.watch(extensionImageCacheProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const OverlayCloseButton(),
      ),
      backgroundColor: Colors.transparent,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: PageView.builder(
        scrollBehavior: const MouseTouchScrollBehavior(),
        findChildIndexCallback: (key) {
          final valueKey = key as ValueKey<Object>;
          final val = items.indexWhere((i) => i.heroTag == valueKey.value);
          return val >= 0 ? val : null;
        },
        itemBuilder: (BuildContext context, int id) {
          final (:url, :heroTag) = items[id];

          final child = Container(
            padding: const EdgeInsets.all(10.0),
            color: Colors.transparent,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: CachedNetworkImage(
                cacheManager: imageCache,
                httpHeaders: headers,
                imageUrl: url,
                imageBuilder: (context, imageProvider) {
                  return PhotoView(
                    backgroundDecoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    imageProvider: imageProvider,
                    minScale: PhotoViewComputedScale.contained * 0.8,
                    maxScale: PhotoViewComputedScale.covered * 5.0,
                    initialScale: PhotoViewComputedScale.contained,
                  );
                },
                fit: BoxFit.contain,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    const Center(child: CircularProgressIndicator()),
                errorBuilder: (context, error, stacktrace) => Tooltip(
                  message: error.toString(),
                  child: const Icon(Icons.error),
                ),
              ),
            ),
          );

          return activePage.value == id
              ? Hero(key: ValueKey<Object>(heroTag), tag: heroTag, child: child)
              : KeyedSubtree(key: ValueKey<Object>(heroTag), child: child);
        },
        itemCount: items.length,
        controller: controller,
        onPageChanged: (id) => activePage.value = id,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
