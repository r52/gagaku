import 'dart:math';
import 'dart:ui';
import 'package:gagaku/util/riverpod.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/reader/model/config.dart';
import 'package:gagaku/reader/model/types.dart';
import 'package:gagaku/util/ui.dart';
import 'package:gagaku/util/util.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:super_sliver_list/super_sliver_list.dart';

enum LongStripScale {
  small(0.4),
  large(0.8),
  full(1.0);

  const LongStripScale(this.scale);
  final double scale;
}

typedef CtxCallback = void Function(BuildContext);

class ReaderWidget extends StatefulHookConsumerWidget {
  const ReaderWidget({
    super.key,
    required this.pages,
    required this.title,
    this.subtitle,
    this.longstrip = false,
    this.drawerHeader,
    this.onHeaderPressed,
    this.externalUrl,
  });

  final List<ReaderPage> pages;
  final String title;
  final String? subtitle;
  final bool longstrip;
  final String? drawerHeader;
  final CtxCallback? onHeaderPressed;
  final String? externalUrl;

  @override
  ConsumerState<ReaderWidget> createState() => _ReaderWidgetState();
}

class _ReaderWidgetState extends ConsumerState<ReaderWidget> {
  final ValueNotifier<int> currentPage = ValueNotifier<int>(0);
  final ValueNotifier<String?> subtext = ValueNotifier<String?>('');
  final ScrollController scrollController = ScrollController();
  final ListController listController = ListController();
  final PageController pageController = PageController(initialPage: 0);

  final Map<int, PhotoViewScaleStateController> _scaleControllers = {};
  final Map<int, PhotoViewController> _viewControllers = {};

  int _cacheScheduleToken = 0;

  PhotoViewController _getViewController(int index) {
    return _viewControllers.putIfAbsent(index, () => PhotoViewController());
  }

  PhotoViewScaleStateController _getScaleController(int index) {
    return _scaleControllers.putIfAbsent(
      index,
      () => PhotoViewScaleStateController(),
    );
  }

  @override
  void initState() {
    super.initState();
    subtext.value =
        widget.subtitle ??
        (widget.pages.isNotEmpty ? widget.pages[0].sortKey : '');
  }

  @override
  void dispose() {
    currentPage.dispose();
    subtext.dispose();
    scrollController.dispose();
    listController.dispose();
    pageController.dispose();

    for (final controller in _scaleControllers.values) {
      controller.dispose();
    }

    for (final controller in _viewControllers.values) {
      controller.dispose();
    }

    super.dispose();
  }

  void _saveSetting(ReaderConfig updated) {
    ref.run((tsx) async {
      return tsx.get(readerSettingsProvider.notifier).save(updated);
    });
  }

  LongStripScale toggleLongStripScale(LongStripScale current) {
    switch (current) {
      case LongStripScale.small:
        return LongStripScale.large;
      case LongStripScale.large:
        return LongStripScale.full;
      case LongStripScale.full:
        return LongStripScale.small;
    }
  }

  void cachePage(ReaderPage page) {
    precacheImage(page.provider, context);
    page.cached = true;
  }

  void cachePages(int precacheCount) {
    final pageCount = widget.pages.length;
    final currentIndex = currentPage.value;

    // Forward Caching
    // Define the range of pages to cache *after* the current one.
    final forwardStart = currentIndex + 1;
    final forwardEnd = min(forwardStart + precacheCount, pageCount);

    // Iterate through the forward window and initiate caching for any page
    // that isn't already cached. This range is only valid if start < end.
    if (forwardStart < forwardEnd) {
      for (final page in widget.pages.getRange(forwardStart, forwardEnd)) {
        if (!page.cached) {
          cachePage(page);
        }
      }
    }

    // Backward Caching
    const backCacheAmount = 3;
    // Define the range of pages to cache *before* the current one.
    final backwardStart = max(0, currentIndex - backCacheAmount);
    // The range for back-caching ends at the current page (exclusive).
    final backwardEnd = currentIndex;

    // Iterate through the backward window and initiate caching.
    // This range is only valid if start < end.
    if (backwardStart < backwardEnd) {
      for (final page in widget.pages.getRange(backwardStart, backwardEnd)) {
        if (!page.cached) {
          cachePage(page);
        }
      }
    }
  }

  void _scheduleCachePages(int precacheCount) {
    final token = ++_cacheScheduleToken;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || token != _cacheScheduleToken) return;
      cachePages(precacheCount);
    });
  }

  void setPageValue({required int page, required int precacheCount}) {
    if (page < 0 || page >= widget.pages.length) return;

    if (currentPage.value != page) {
      currentPage.value = page;
    }

    final nextSubtext = widget.subtitle ?? widget.pages[page].sortKey;
    if (subtext.value != nextSubtext) {
      subtext.value = nextSubtext;
    }

    _scheduleCachePages(precacheCount);
  }

  void jumpToPage(int page, {required ReaderFormat format}) {
    final pageCount = widget.pages.length;
    if (page < 0 || page >= pageCount) return;
    assert(page >= 0 && page < pageCount);

    switch (format) {
      case ReaderFormat.longstrip:
        if (listController.isAttached) {
          listController.jumpToItem(
            index: page,
            scrollController: scrollController,
            alignment: 0,
          );
        }

        break;
      default:
        if (pageController.hasClients) {
          pageController.jumpToPage(page);
        }
        break;
    }
  }

  void animateToPage(
    int page, {
    required Duration duration,
    required Curve curve,
    required ReaderFormat format,
  }) {
    assert(page >= 0 && page < widget.pages.length);

    switch (format) {
      case ReaderFormat.longstrip:
        if (listController.isAttached) {
          listController.animateToItem(
            index: page,
            scrollController: scrollController,
            alignment: 0,
            duration: (estimatedDistance) => duration,
            curve: (estimatedDistance) => curve,
          );
        }
        break;
      default:
        if (pageController.hasClients) {
          pageController.animateToPage(page, duration: duration, curve: curve);
        }
        break;
    }
  }

  void jumpToPreviousPage({required ReaderFormat format}) {
    jumpToPage(currentPage.value - 1, format: format);
  }

  void jumpToNextPage({required ReaderFormat format}) {
    jumpToPage(currentPage.value + 1, format: format);
  }

  KeyEventResult onTapLeft({
    required ReaderConfig settings,
    required ReaderFormat format,
  }) {
    if (format == ReaderFormat.longstrip) return KeyEventResult.handled;

    switch (settings.direction) {
      case ReaderDirection.leftToRight:
        jumpToPreviousPage(format: format);
        break;
      case ReaderDirection.rightToLeft:
        if (currentPage.value < widget.pages.length - 1) {
          jumpToNextPage(format: format);
        } else {
          context.pop();
        }
        break;
    }

    return KeyEventResult.handled;
  }

  KeyEventResult onTapRight({
    required ReaderConfig settings,
    required ReaderFormat format,
  }) {
    if (format == ReaderFormat.longstrip) return KeyEventResult.handled;

    switch (settings.direction) {
      case ReaderDirection.leftToRight:
        if (currentPage.value < widget.pages.length - 1) {
          jumpToNextPage(format: format);
        } else {
          context.pop();
        }
        break;
      case ReaderDirection.rightToLeft:
        jumpToPreviousPage(format: format);
        break;
    }

    return KeyEventResult.handled;
  }

  KeyEventResult onTapTop(
    double offset, {
    required ReaderConfig settings,
    required ReaderFormat format,
  }) {
    if (format == ReaderFormat.longstrip) {
      scrollController.animateTo(
        scrollController.offset - offset,
        duration: const Duration(milliseconds: 50),
        curve: Curves.easeInOut,
      );

      return KeyEventResult.handled;
    }

    switch (settings.direction) {
      case ReaderDirection.leftToRight:
      case ReaderDirection.rightToLeft:
        final currentController = _getViewController(currentPage.value);
        currentController.position =
            currentController.position + Offset(0.0, offset);
        break;
    }

    return KeyEventResult.handled;
  }

  KeyEventResult onTapBottom(
    double offset, {
    required ReaderConfig settings,
    required ReaderFormat format,
  }) {
    if (format == ReaderFormat.longstrip) {
      if (listController.isAttached && listController.visibleRange != null) {
        final positions = listController.visibleRange;
        final max = positions!.$2;

        if (max == widget.pages.length - 1 &&
            scrollController.position.atEdge &&
            scrollController.position.pixels ==
                scrollController.position.maxScrollExtent) {
          context.pop();
        } else {
          scrollController.animateTo(
            scrollController.offset + offset,
            duration: const Duration(milliseconds: 50),
            curve: Curves.easeInOut,
          );
        }
      }

      return KeyEventResult.handled;
    }

    switch (settings.direction) {
      case ReaderDirection.leftToRight:
      case ReaderDirection.rightToLeft:
        final currentController = _getViewController(currentPage.value);
        currentController.position =
            currentController.position - Offset(0.0, offset);
        break;
    }

    return KeyEventResult.handled;
  }

  @override
  Widget build(BuildContext context) {
    final showUI = useState(false);

    useEffect(() {
      if (showUI.value) {
        SystemChrome.setEnabledSystemUIMode(
          SystemUiMode.manual,
          overlays: SystemUiOverlay.values,
        );
      } else {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      }
      return () => SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual,
        overlays: SystemUiOverlay.values,
      );
    }, [showUI.value]);

    final tr = context.t;
    final pageCount = widget.pages.length;
    final focusNode = useFocusNode();

    final settings = ref.watch(readerSettingsProvider);
    final theme = Theme.of(context);
    final format = widget.longstrip ? ReaderFormat.longstrip : settings.format;
    final isPortrait = DeviceContext.isPortraitMode(context);
    final longStripScale = useValueNotifier(
      isPortrait ? LongStripScale.full : LongStripScale.small,
    );

    final precacheCount = useCallback(() {
      return (settings.precacheCount > 9 || format == ReaderFormat.longstrip)
          ? pageCount
          : settings.precacheCount;
    }, [settings.precacheCount, format, pageCount]);

    useEffect(() {
      if (widget.pages.isEmpty) return null;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        setPageValue(page: currentPage.value, precacheCount: precacheCount());
      });

      return null;
    }, [widget.pages.length, settings.precacheCount, format]);

    useEffect(() {
      void listPosCb() {
        if (!listController.isAttached) return;
        final range = listController.visibleRange;
        if (range == null) return;

        final min = range.$1;
        if (min != currentPage.value) {
          setPageValue(page: min, precacheCount: precacheCount());
        }
      }

      listController.addListener(listPosCb);
      return () => listController.removeListener(listPosCb);
    }, [listController, settings.precacheCount, format]);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: SlidingAppBar(
        visible: showUI.value,
        child: AppBar(
          leading: const BackButton(),
          title: ListTile(
            title: Text(
              widget.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: HookBuilder(
              builder: (_) {
                final value = useValueListenable(subtext);
                if (value == null) {
                  return const SizedBox.shrink();
                }

                return Text(value);
              },
            ),
          ),
          actions: [
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () => Scaffold.of(context).openEndDrawer(),
                tooltip: tr.reader.settings,
              ),
            ),
          ],
        ),
      ),
      endDrawer: Drawer(
        width: 320,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10.0,
              children: <Widget>[
                if (widget.onHeaderPressed != null &&
                    widget.drawerHeader != null)
                  TextButton(
                    onPressed: () {
                      // First one pops the drawer
                      context.pop();

                      // Second one pops the reader
                      context.pop();

                      widget.onHeaderPressed!(context);
                    },
                    child: Text(
                      widget.drawerHeader!,
                      style: CommonTextStyles.eighteen,
                    ),
                  ),
                if (widget.drawerHeader != null &&
                    widget.onHeaderPressed == null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      widget.drawerHeader!,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontSize: 18,
                      ),
                    ),
                  ),
                Text(tr.reader.settings, style: CommonTextStyles.twentyBold),
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    for (final f in ReaderFormat.values)
                      ChoiceChip(
                        avatar: Icon(f.icon, color: theme.iconTheme.color),
                        label: Text(tr[f.label]),
                        selected: settings.format == f,
                        onSelected: (widget.longstrip)
                            ? null
                            : (value) {
                                if (value) {
                                  _saveSetting(settings.copyWith(format: f));
                                }
                              },
                      ),
                  ],
                ),
                ListTile(
                  leading: const Icon(Icons.fit_screen),
                  title: Text(tr.reader.togglePageSize),
                  onTap: (format == ReaderFormat.longstrip)
                      ? () {
                          longStripScale.value = toggleLongStripScale(
                            longStripScale.value,
                          );
                        }
                      : () {
                          final currentController = _getScaleController(
                            currentPage.value,
                          );
                          currentController.scaleState = defaultScaleStateCycle(
                            currentController.scaleState,
                          );
                        },
                ),
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    for (final dir in ReaderDirection.values)
                      ChoiceChip(
                        avatar: Icon(dir.icon, color: theme.iconTheme.color),
                        label: Text(tr[dir.label]),
                        selected: settings.direction == dir,
                        onSelected: (format == ReaderFormat.longstrip)
                            ? null
                            : (value) {
                                if (value) {
                                  _saveSetting(
                                    settings.copyWith(direction: dir),
                                  );
                                }
                              },
                      ),
                  ],
                ),
                SwitchListTile(
                  secondary: const Icon(Icons.donut_small),
                  title: Text(tr.reader.progressBar),
                  value: settings.showProgressBar,
                  onChanged: (value) =>
                      _saveSetting(settings.copyWith(showProgressBar: value)),
                ),
                SwitchListTile(
                  secondary: const Icon(Icons.swipe),
                  title: Text(tr.reader.swipeGestures),
                  value: settings.swipeGestures,
                  onChanged: (format == ReaderFormat.longstrip)
                      ? null
                      : (value) => _saveSetting(
                          settings.copyWith(swipeGestures: value),
                        ),
                ),
                SwitchListTile(
                  secondary: const Icon(Icons.mouse),
                  title: Text(tr.reader.clickToTurn),
                  value: settings.clickToTurn,
                  onChanged: (format == ReaderFormat.longstrip)
                      ? null
                      : (value) =>
                            _saveSetting(settings.copyWith(clickToTurn: value)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 10.0,
                  children: [
                    Text(tr.reader.precacheCount),
                    DropdownMenu<int>(
                      initialSelection: settings.precacheCount,
                      width: 160.0,
                      enableFilter: false,
                      enableSearch: false,
                      requestFocusOnTap: false,
                      inputDecorationTheme: InputDecorationTheme(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 2.0,
                            color: theme.colorScheme.inversePrimary,
                          ),
                        ),
                      ),
                      onSelected: (int? value) {
                        if (value != null) {
                          _saveSetting(settings.copyWith(precacheCount: value));
                        }
                      },
                      dropdownMenuEntries:
                          List<DropdownMenuEntry<int>>.generate(
                            10,
                            (int index) => DropdownMenuEntry<int>(
                              value: index + 1,
                              label: (index + 1 > 9)
                                  ? 'Max (not recommended)'
                                  : (index + 1).toString(),
                            ),
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      endDrawerEnableOpenDragGesture: false,
      body: Focus(
        autofocus: true,
        focusNode: focusNode,
        onKeyEvent: (node, event) {
          // We only care about key down and repeat events.
          if (event is! KeyDownEvent && event is! KeyRepeatEvent) {
            return KeyEventResult.ignored;
          }

          final key = event.physicalKey;

          // Handle horizontal navigation only on the initial key press.
          if (event is KeyDownEvent) {
            switch (key) {
              case PhysicalKeyboardKey.arrowLeft:
                return onTapLeft(settings: settings, format: format);
              case PhysicalKeyboardKey.arrowRight:
                return onTapRight(settings: settings, format: format);
            }
          }

          // Handle vertical navigation on key press and repeat.
          switch (key) {
            case PhysicalKeyboardKey.arrowUp:
              return onTapTop(250, settings: settings, format: format);
            case PhysicalKeyboardKey.arrowDown:
              return onTapBottom(250, settings: settings, format: format);
            case PhysicalKeyboardKey.pageUp:
              return onTapTop(1000, settings: settings, format: format);
            case PhysicalKeyboardKey.pageDown:
              return onTapBottom(1000, settings: settings, format: format);
            default:
              return KeyEventResult.ignored;
          }
        },
        child: switch (widget.pages.isEmpty) {
          true when widget.externalUrl != null => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10.0,
              children: [
                const Text('Read on external site:'),
                ElevatedButton(
                  onPressed: () async {
                    await Styles.tryLaunchUrl(context, widget.externalUrl!);
                  },
                  child: Text(widget.externalUrl!),
                ),
              ],
            ),
          ),
          _ when format == ReaderFormat.longstrip => _LongStripView(
            listController: listController,
            scrollController: scrollController,
            pages: widget.pages,
            scale: longStripScale,
            onCenterTap: () {
              showUI.value = !showUI.value;
            },
          ),
          _ => PhotoViewGallery.builder(
            allowImplicitScrolling: true,
            reverse: settings.direction == ReaderDirection.rightToLeft,
            scrollPhysics: !settings.swipeGestures
                ? const NeverScrollableScrollPhysics()
                : null,
            backgroundDecoration: const BoxDecoration(color: Colors.black),
            pageController: pageController,
            onPageChanged: (int index) {
              if (index != currentPage.value) {
                setPageValue(page: index, precacheCount: precacheCount());
              }

              if (!focusNode.hasFocus) {
                focusNode.requestFocus();
              }
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
            itemCount: pageCount,
            builder: (context, index) {
              final page = widget.pages[index];
              return PhotoViewGalleryPageOptions(
                heroAttributes: PhotoViewHeroAttributes(tag: page.id),
                imageProvider: page.provider,
                controller: _getViewController(index),
                scaleStateController: _getScaleController(index),
                minScale: PhotoViewComputedScale.contained * 1.0,
                maxScale: PhotoViewComputedScale.covered * 5.0,
                initialScale: PhotoViewComputedScale.contained,
                basePosition: Alignment.center,
                onTapUp: (context, details, value) {
                  focusNode.requestFocus();

                  final taploc = details.localPosition.dx;
                  final viewport = context.size!.width;
                  final tapmargin = viewport / 2.5;

                  // Tap in the middle 20% (from 40% to 60%, or depending on tapmargin)
                  if (taploc > tapmargin && taploc < viewport - tapmargin) {
                    showUI.value = !showUI.value;
                    return;
                  }

                  if (settings.clickToTurn) {
                    if (taploc <= tapmargin) {
                      onTapLeft(settings: settings, format: format);
                    } else if (taploc >= viewport - tapmargin) {
                      onTapRight(settings: settings, format: format);
                    }
                  }
                },
              );
            },
          ),
        },
      ),
      // Can't use bottomSheet anymore due to Material 3 specs
      // forcing bottom sheet width to be 640 max
      // https://github.com/flutter/flutter/pull/122445
      extendBody: true,
      bottomNavigationBar: settings.showProgressBar
          ? AnimatedSlide(
              offset: showUI.value ? Offset.zero : const Offset(0, 1),
              duration: const Duration(milliseconds: 200),
              child: ReaderProgressIndicator(
                reverse:
                    (format != ReaderFormat.longstrip) &&
                    settings.direction == ReaderDirection.rightToLeft,
                currentPage: currentPage,
                itemCount: pageCount,
                onPageSelected: (index, isDrag) {
                  if (isDrag) {
                    jumpToPage(index, format: format);
                  } else {
                    animateToPage(
                      index,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                      format: format,
                    );
                  }
                },
              ),
            )
          : null,
    );
  }
}

class ReaderProgressIndicator extends HookWidget {
  const ReaderProgressIndicator({
    super.key,
    required this.currentPage,
    required this.itemCount,
    required this.onPageSelected,
    this.reverse = false,
    this.color,
  });

  final ValueNotifier<int> currentPage;
  final int itemCount;
  final void Function(int, bool) onPageSelected;
  final Color? color;
  final bool reverse;

  static const double _barHeight = 8.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tr = context.t;
    final progressColor = color ?? theme.colorScheme.primary;

    final sections = useMemoized(
      () => List<Widget>.generate(
        itemCount,
        (index) => _ProgressBarSection(
          key: ValueKey('progress_bar_section_$index'),
          index: index,
          currentPage: currentPage,
          color: progressColor,
          height: _barHeight,
        ),
      ),
      [itemCount, progressColor],
    );

    final children = useMemoized(
      () => reverse ? sections.reversed.toList() : sections,
      [sections, reverse],
    );

    void handleTapOrDrag(Offset localPosition, double totalWidth, bool isDrag) {
      if (totalWidth <= 0) return;
      double dx = localPosition.dx;
      if (reverse) dx = totalWidth - dx;
      final int index = ((dx / totalWidth) * itemCount)
          .clamp(0, itemCount - 1)
          .floor();
      onPageSelected(index, isDrag);
    }

    final page = useValueListenable(currentPage);

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          stops: [0.0, 1.0],
          colors: [Color.fromARGB(200, 0, 0, 0), Colors.transparent],
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface.withAlpha(217),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      enableDrag: false,
                      backgroundColor: theme.colorScheme.surface,
                      builder: (context) {
                        return SizedBox(
                          height: 250,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  tr.reader.gotoPage,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ScrollConfiguration(
                                  behavior: ScrollConfiguration.of(context)
                                      .copyWith(
                                        dragDevices: {
                                          PointerDeviceKind.mouse,
                                          PointerDeviceKind.touch,
                                          PointerDeviceKind.trackpad,
                                        },
                                      ),
                                  child: CupertinoPicker(
                                    scrollController:
                                        FixedExtentScrollController(
                                          initialItem: page,
                                        ),
                                    itemExtent: 40,
                                    onSelectedItemChanged: (index) {
                                      onPageSelected(index, false);
                                    },
                                    children: List.generate(itemCount, (index) {
                                      return Center(
                                        child: Text('${index + 1}'),
                                      );
                                    }),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Text(
                    tr.reader.pageCount(current: page + 1, total: itemCount),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          LayoutBuilder(
            builder: (context, constraints) {
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTapDown: (details) => handleTapOrDrag(
                  details.localPosition,
                  constraints.maxWidth,
                  false,
                ),
                onHorizontalDragUpdate: (details) => handleTapOrDrag(
                  details.localPosition,
                  constraints.maxWidth,
                  true,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints.loose(const Size.fromHeight(30)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: children,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ProgressBarSection extends HookWidget {
  const _ProgressBarSection({
    super.key,
    required this.index,
    required this.currentPage,
    required this.color,
    required this.height,
  });

  final int index;
  final ValueNotifier<int> currentPage;
  final Color color;
  final double height;

  @override
  Widget build(BuildContext context) {
    final isFilled =
        index == 0 ||
        useListenableSelector(currentPage, () => currentPage.value >= index);

    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          height: height,
          width: double.infinity,
          child: ColoredBox(color: isFilled ? color : Colors.transparent),
        ),
      ),
    );
  }
}

class _LongStripView extends StatelessWidget {
  final ListController? listController;
  final ScrollController? scrollController;
  final List<ReaderPage> pages;
  final ValueNotifier<LongStripScale> scale;
  final VoidCallback? onCenterTap;

  const _LongStripView({
    this.listController,
    this.scrollController,
    required this.pages,
    required this.scale,
    this.onCenterTap,
  });

  @override
  Widget build(BuildContext context) {
    final mediaSize = MediaQuery.sizeOf(context);

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTapUp: (details) {
        final taploc = details.localPosition.dx;
        final viewport = mediaSize.width;
        final tapmargin = viewport / 2.5;

        if (taploc > tapmargin && taploc < viewport - tapmargin) {
          onCenterTap?.call();
        }
      },
      child: SuperListView.builder(
        listController: listController,
        controller: scrollController,
        cacheExtent: mediaSize.height * 3,
        itemCount: pages.length,
        itemBuilder: (context, index) {
          final page = pages[index];
          return Center(
            key: ValueKey(page.id),
            child: RepaintBoundary(
              child: _LongStripPage(
                contextWidth: mediaSize.width,
                scale: scale,
                page: page,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _LongStripPage extends HookWidget {
  const _LongStripPage({
    required this.page,
    required this.contextWidth,
    required this.scale,
  });

  final ValueNotifier<LongStripScale> scale;
  final ReaderPage page;
  final double contextWidth;

  @override
  Widget build(BuildContext context) {
    final scl = useValueListenable(scale);
    final width = contextWidth * scl.scale;
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: width, maxWidth: width),
      child: KeepAliveImage(
        image: page.provider,
        fit: BoxFit.contain,
        alignment: Alignment.topCenter,
        loadingBuilder: (context, child, event) {
          if (event == null) {
            return child;
          }

          return Center(
            child: CircularProgressIndicator(
              value: event.expectedTotalBytes != null
                  ? event.cumulativeBytesLoaded / event.expectedTotalBytes!
                  : null,
            ),
          );
        },
      ),
    );
  }
}

class SlidingAppBar extends StatelessWidget implements PreferredSizeWidget {
  final PreferredSizeWidget child;
  final bool visible;

  const SlidingAppBar({super.key, required this.child, required this.visible});

  @override
  Size get preferredSize => child.preferredSize;

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      offset: visible ? Offset.zero : const Offset(0, -1),
      duration: const Duration(milliseconds: 200),
      child: child,
    );
  }
}
