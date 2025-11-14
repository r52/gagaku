import 'dart:async';
import 'dart:math';

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

  late final List<PhotoViewScaleStateController> scaleStateController;
  late final List<PhotoViewController> viewController;

  @override
  void initState() {
    scaleStateController = List<PhotoViewScaleStateController>.generate(
      widget.pages.length,
      (index) => PhotoViewScaleStateController(),
    );

    viewController = List<PhotoViewController>.generate(
      widget.pages.length,
      (index) => PhotoViewController(),
    );

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

    for (final controller in scaleStateController) {
      controller.dispose();
    }

    for (final controller in viewController) {
      controller.dispose();
    }

    super.dispose();
  }

  void _saveSetting(ReaderConfig updated) {
    readerConfigSaveMutation.run(ref, (ref) async {
      return ref.get(readerSettingsProvider.notifier).save(updated);
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

  void setPageValue({required int page, required int precacheCount}) {
    currentPage.value = page;
    cachePages(precacheCount);
    subtext.value = widget.subtitle ?? widget.pages[currentPage.value].sortKey;
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
        viewController[currentPage.value].position =
            viewController[currentPage.value].position + Offset(0.0, offset);
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
        viewController[currentPage.value].position =
            viewController[currentPage.value].position - Offset(0.0, offset);
        break;
    }

    return KeyEventResult.handled;
  }

  @override
  Widget build(BuildContext context) {
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
    }, [settings, format]);

    useEffect(() {
      void pageCallback() {
        if (pageController.page != null) {
          Future.delayed(Duration.zero, () {
            if (context.mounted) {
              setPageValue(
                page: pageController.page!.toInt(),
                precacheCount: precacheCount(),
              );
            }
          });
        }
      }

      pageController.addListener(pageCallback);
      return () => pageController.removeListener(pageCallback);
    }, [pageController, settings]);

    useEffect(() {
      void listPosCb() {
        if (listController.isAttached && listController.visibleRange != null) {
          final positions = listController.visibleRange;
          final min = positions!.$1;

          Future.delayed(Duration.zero, () {
            if (context.mounted) {
              setPageValue(page: min, precacheCount: precacheCount());
            }
          });
        }
      }

      listController.addListener(listPosCb);
      return () => listController.removeListener(listPosCb);
    }, [listController, settings]);

    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
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
                HookBuilder(
                  builder: (context) {
                    final page = useValueListenable(currentPage);
                    final pagesDropDown = useMemoized(
                      () => List<DropdownMenuEntry<int>>.generate(
                        pageCount,
                        (int index) => DropdownMenuEntry<int>(
                          value: index,
                          label: (index + 1).toString(),
                        ),
                      ),
                      [pageCount],
                    );

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 10.0,
                      children: [
                        OutlinedButton(
                          onPressed: (page > 0)
                              ? () => jumpToPreviousPage(format: format)
                              : null,
                          child: const Icon(Icons.arrow_back_ios_new),
                        ),
                        DropdownMenu<int>(
                          initialSelection: page,
                          width: 80.0,
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
                          onSelected: (int? index) {
                            if (index != null) {
                              jumpToPage(index, format: format);
                            }
                          },
                          dropdownMenuEntries: pagesDropDown,
                        ),
                        OutlinedButton(
                          onPressed: (page < pageCount - 1)
                              ? () => jumpToNextPage(format: format)
                              : null,
                          child: const Icon(Icons.arrow_forward_ios),
                        ),
                      ],
                    );
                  },
                ),
                const Divider(),
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
                ActionChip(
                  avatar: Icon(Icons.fit_screen, color: theme.iconTheme.color),
                  label: Text(tr.reader.togglePageSize),
                  onPressed: (format == ReaderFormat.longstrip)
                      ? () {
                          longStripScale.value = toggleLongStripScale(
                            longStripScale.value,
                          );
                        }
                      : () {
                          scaleStateController[currentPage.value]
                              .scaleState = defaultScaleStateCycle(
                            scaleStateController[currentPage.value].scaleState,
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
                ActionChip(
                  avatar: Icon(
                    settings.showProgressBar
                        ? Icons.donut_small
                        : Icons.donut_small_outlined,
                    color: theme.iconTheme.color,
                  ),
                  label: Text(tr.reader.progressBar),
                  onPressed: () => _saveSetting(
                    settings.copyWith(
                      showProgressBar: !settings.showProgressBar,
                    ),
                  ),
                ),
                ActionChip(
                  avatar: Icon(
                    Icons.swipe,
                    color: settings.swipeGestures
                        ? theme.iconTheme.color
                        : theme.disabledColor,
                  ),
                  label: Text(tr.reader.swipeGestures),
                  onPressed: (format == ReaderFormat.longstrip)
                      ? null
                      : () => _saveSetting(
                          settings.copyWith(
                            swipeGestures: !settings.swipeGestures,
                          ),
                        ),
                ),
                ActionChip(
                  avatar: Icon(
                    Icons.mouse,
                    color: settings.clickToTurn
                        ? theme.iconTheme.color
                        : theme.disabledColor,
                  ),
                  label: Text(tr.reader.clickToTurn),
                  onPressed: (format == ReaderFormat.longstrip)
                      ? null
                      : () => _saveSetting(
                          settings.copyWith(clickToTurn: !settings.clickToTurn),
                        ),
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
              focusNode.requestFocus();
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
                controller: viewController[index],
                scaleStateController: scaleStateController[index],
                minScale: PhotoViewComputedScale.contained * 1.0,
                maxScale: PhotoViewComputedScale.covered * 5.0,
                initialScale: PhotoViewComputedScale.contained,
                basePosition: Alignment.topCenter,
                onTapUp: settings.clickToTurn
                    ? (context, details, value) {
                        focusNode.requestFocus();

                        final taploc = details.localPosition.dx;
                        final viewport = context.size!.width;

                        final tapmargin = viewport / 2.5;

                        if (taploc < tapmargin) {
                          onTapLeft(settings: settings, format: format);
                        } else if (taploc > viewport - tapmargin) {
                          onTapRight(settings: settings, format: format);
                        }
                      }
                    : null,
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
          ? ProgressIndicator(
              reverse:
                  (format != ReaderFormat.longstrip) &&
                  settings.direction == ReaderDirection.rightToLeft,
              currentPage: currentPage,
              itemCount: pageCount,
              onPageSelected: (index) => animateToPage(
                index,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
                format: format,
              ),
            )
          : null,
    );
  }
}

class ProgressIndicator extends HookWidget {
  const ProgressIndicator({
    super.key,
    required this.currentPage,
    required this.itemCount,
    required this.onPageSelected,
    this.reverse = false,
    this.color,
  });

  final ValueNotifier<int> currentPage;
  final int itemCount;
  final ValueChanged<int> onPageSelected;
  final Color? color;
  final bool reverse;

  static const double _barHeight = 8.0;

  @override
  Widget build(BuildContext context) {
    final progressColor = color ?? Theme.of(context).colorScheme.primary;

    final sections = useMemoized(
      () => List<Widget>.generate(
        itemCount,
        (index) => _ProgressBarSection(
          key: ValueKey('progress_bar_section_$index'),
          index: index,
          currentPage: currentPage,
          color: progressColor,
          height: _barHeight,
          tooltip: (index + 1).toString(),
          onTap: () => onPageSelected(index),
        ),
      ),
      [itemCount, color, onPageSelected],
    );

    final children = useMemoized(
      () => reverse ? sections.reversed.toList() : sections,
      [sections, reverse],
    );

    return ConstrainedBox(
      constraints: BoxConstraints.loose(const Size.fromHeight(30)),
      child: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            stops: [0.0, 0.6],
            colors: [Color.fromARGB(255, 0, 0, 0), Colors.transparent],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: children,
        ),
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
    required this.tooltip,
    required this.onTap,
  });

  final int index;
  final ValueNotifier<int> currentPage;
  final Color color;
  final double height;
  final String tooltip;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    final page = useValueListenable(currentPage);
    final isFilled = (index == 0 || page >= index);

    return Expanded(
      child: Tooltip(
        message: tooltip,
        child: InkWell(
          onTap: onTap,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: height,
              width: double.infinity,
              color: isFilled ? color : Colors.transparent,
            ),
          ),
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

  const _LongStripView({
    this.listController,
    this.scrollController,
    required this.pages,
    required this.scale,
  });

  @override
  Widget build(BuildContext context) {
    final pageCount = pages.length;
    final mediaSize = MediaQuery.sizeOf(context);

    return SuperListView(
      listController: listController,
      controller: scrollController,
      cacheExtent: mediaSize.height * pageCount,
      children: [
        for (final page in pages)
          Center(
            key: ValueKey(page.id),
            child: _LongStripPage(
              contextWidth: mediaSize.width,
              scale: scale,
              page: page,
            ),
          ),
      ],
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
