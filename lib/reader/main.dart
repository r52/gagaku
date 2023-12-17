import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/reader/config.dart';
import 'package:gagaku/reader/controller_hooks.dart';
import 'package:gagaku/reader/types.dart';
import 'package:gagaku/ui.dart';
import 'package:gagaku/util.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photo_view/photo_view.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'package:url_launcher/url_launcher.dart';

class ReaderWidget extends HookConsumerWidget {
  const ReaderWidget({
    super.key,
    required this.pages,
    required this.title,
    this.subtitle,
    this.longstrip = false,
    this.link,
    this.onLinkPressed,
    this.externalUrl,
    this.backRoute,
  });

  final Iterable<ReaderPage> pages;
  final String title;
  final String? subtitle;
  final bool longstrip;
  final Widget? link;
  final VoidCallback? onLinkPressed;
  final String? externalUrl;

  // Backup route for BackButton if nav stack cannot pop
  final String? backRoute;

  ItemPosition? _getListViewFirstShownPage(Iterable<ItemPosition> positions) {
    if (positions.isNotEmpty) {
      // Determine the first visible item by finding the item with the
      // smallest trailing edge that is greater than 0.  i.e. the first
      // item whose trailing edge in visible in the viewport.
      return positions
          .where((ItemPosition position) => position.itemTrailingEdge > 0)
          .reduce((ItemPosition min, ItemPosition position) =>
              position.itemTrailingEdge < min.itemTrailingEdge
                  ? position
                  : min);
    }

    return null;
  }

  ItemPosition? _getListViewLastShownPage(Iterable<ItemPosition> positions) {
    if (positions.isNotEmpty) {
      // Determine the last visible item by finding the item with the
      // greatest leading edge that is less than 1.  i.e. the last
      // item whose leading edge in visible in the viewport.
      return positions
          .where((ItemPosition position) => position.itemLeadingEdge < 1)
          .reduce((ItemPosition max, ItemPosition position) =>
              position.itemLeadingEdge > max.itemLeadingEdge ? position : max);
    }

    return null;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageCount = pages.length;
    final mediaContext = MediaQuery.of(context);
    final focusNode = useFocusNode();
    final pageController = usePageController(initialPage: 0);
    final scaleStateController = List<PhotoViewScaleStateController>.generate(
        pageCount, (index) => usePhotoViewScaleStateController());
    final viewController = List<PhotoViewController>.generate(
        pageCount, (index) => usePhotoViewController());
    final settings = ref.watch(readerSettingsProvider);
    final theme = Theme.of(context);
    final currentPage = useValueNotifier(0);
    final itemPositionsListener = useItemPositionsListener();
    final itemScrollController = useItemScrollController();
    final scrollOffsetController = useScrollOffsetController();
    final currentImageScale =
        useState<PhotoViewScaleState>(PhotoViewScaleState.initial);
    final subtext = useState<String?>(subtitle ?? pages.elementAt(0).sortKey);
    final format = longstrip ? ReaderFormat.longstrip : settings.format;

    void cachePage(ReaderPage page) {
      precacheImage(page.provider, context);
      page.cached = true;
    }

    final precacheCount = useCallback(() {
      return settings.precacheCount > 9 ? pageCount : settings.precacheCount;
    }, [settings]);

    void cachePages() {
      // Forward cache precacheCount() pages
      if (currentPage.value + 1 < pageCount &&
          !pages.elementAt(currentPage.value + 1).cached) {
        while (!pages.elementAt(currentPage.value + 1).cached) {
          pages
              .skip(currentPage.value)
              .take(precacheCount())
              .forEach((element) {
            if (!element.cached) {
              cachePage(element);
            }
          });
        }
      }

      // Try and back cache 3 pages
      const backCacheAmount = 3;
      var backCache = currentPage.value - backCacheAmount;
      if (backCache < 0) {
        backCache = 0;
      }

      pages.skip(backCache).take(backCacheAmount).forEach((element) {
        if (!element.cached) {
          cachePage(element);
        }
      });
    }

    void scaleStateListener(PhotoViewScaleState value) {
      currentImageScale.value = value;
    }

    void pageCallback() {
      if (pageController.page != null) {
        currentPage.value = pageController.page!.toInt();

        cachePages();

        subtext.value = subtitle ?? pages.elementAt(currentPage.value).sortKey;
      }
    }

    void listPosCb() {
      final positions = itemPositionsListener.itemPositions.value;

      final min = _getListViewFirstShownPage(positions);

      if (min != null) {
        currentPage.value = min.index;

        cachePages();
      }
    }

    useEffect(() {
      final subs = <StreamSubscription<PhotoViewScaleState>>[];

      for (final c in scaleStateController) {
        subs.add(c.outputScaleStateStream.listen(scaleStateListener));
      }

      return () {
        for (final s in subs) {
          s.cancel();
        }
      };
    }, []);

    useEffect(() {
      pageController.addListener(pageCallback);
      return () => pageController.removeListener(pageCallback);
    }, [pageController, settings]);

    useEffect(() {
      itemPositionsListener.itemPositions.addListener(listPosCb);
      return () =>
          itemPositionsListener.itemPositions.removeListener(listPosCb);
    }, [settings]);

    void jumpToPage(int page) {
      assert(page >= 0 && page < pageCount);

      switch (format) {
        case ReaderFormat.longstrip:
          if (itemScrollController.isAttached) {
            itemScrollController.jumpTo(index: page);
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
    }) {
      assert(page >= 0 && page < pageCount);

      switch (format) {
        case ReaderFormat.longstrip:
          if (itemScrollController.isAttached) {
            itemScrollController.scrollTo(
                index: page, duration: duration, curve: curve);
          }
          break;
        default:
          if (pageController.hasClients) {
            pageController.animateToPage(page,
                duration: duration, curve: curve);
          }
          break;
      }
    }

    void jumpToPreviousPage() {
      if (currentPage.value > 0) {
        jumpToPage(currentPage.value - 1);
      }
    }

    void jumpToNextPage() {
      if (currentPage.value < pageCount - 1) {
        jumpToPage(currentPage.value + 1);
      }
    }

    KeyEventResult onTapLeft() {
      if (format == ReaderFormat.longstrip) return KeyEventResult.handled;

      switch (settings.direction) {
        case ReaderDirection.leftToRight:
          jumpToPreviousPage();
          break;
        case ReaderDirection.rightToLeft:
          if (currentPage.value < pageCount - 1) {
            jumpToNextPage();
          } else {
            if (context.canPop()) {
              context.pop();
            }
          }
          break;
        default:
          // Do nothing
          break;
      }

      return KeyEventResult.handled;
    }

    KeyEventResult onTapRight() {
      if (format == ReaderFormat.longstrip) return KeyEventResult.handled;

      switch (settings.direction) {
        case ReaderDirection.leftToRight:
          if (currentPage.value < pageCount - 1) {
            jumpToNextPage();
          } else {
            if (context.canPop()) {
              context.pop();
            }
          }
          break;
        case ReaderDirection.rightToLeft:
          jumpToPreviousPage();
          break;
        default:
          // Do nothing
          break;
      }

      return KeyEventResult.handled;
    }

    KeyEventResult onTapTop(double offset) {
      if (format == ReaderFormat.longstrip) {
        scrollOffsetController.animateScroll(
            offset: -offset, duration: const Duration(milliseconds: 50));

        return KeyEventResult.handled;
      }

      switch (settings.direction) {
        // case ReaderDirection.topToBottom:
        //   final oldpos = viewController[currentPage.value].position;
        //   viewController[currentPage.value].position =
        //       viewController[currentPage.value].position + Offset(0.0, offset);

        //   if (viewController[currentPage.value].position == oldpos) {
        //     // At edge
        //     if (currentPage.value > 0) {
        //       jumpToPreviousPage();
        //     }
        //   }
        //   break;
        case ReaderDirection.leftToRight:
        case ReaderDirection.rightToLeft:
          viewController[currentPage.value].position =
              viewController[currentPage.value].position + Offset(0.0, offset);
          break;
        default:
          // Do nothing
          break;
      }

      return KeyEventResult.handled;
    }

    KeyEventResult onTapBottom(double offset) {
      if (format == ReaderFormat.longstrip) {
        final positions = itemPositionsListener.itemPositions.value;
        final max = _getListViewLastShownPage(positions);

        if (max != null) {
          if (max.index == pageCount - 1 && max.itemTrailingEdge == 1.0) {
            if (context.canPop()) {
              context.pop();
            }
          } else {
            scrollOffsetController.animateScroll(
                offset: offset, duration: const Duration(milliseconds: 50));
          }
        }

        return KeyEventResult.handled;
      }

      switch (settings.direction) {
        // case ReaderDirection.topToBottom:
        //   final oldpos = viewController[currentPage.value].position;
        //   viewController[currentPage.value].position =
        //       viewController[currentPage.value].position - Offset(0.0, offset);

        //   if (viewController[currentPage.value].position == oldpos) {
        //     // At edge
        //     if (currentPage.value < pageCount - 1) {
        //       jumpToNextPage();
        //     } else {
        //       if (context.canPop()) {
        //         context.pop();
        //       }
        //     }
        //   }
        //   break;
        case ReaderDirection.leftToRight:
        case ReaderDirection.rightToLeft:
          viewController[currentPage.value].position =
              viewController[currentPage.value].position - Offset(0.0, offset);
          break;
        default:
          // Do nothing
          break;
      }

      return KeyEventResult.handled;
    }

    KeyEventResult handleKeyEvent(FocusNode node, KeyEvent event) {
      if (event is KeyDownEvent) {
        switch (event.physicalKey) {
          case PhysicalKeyboardKey.arrowLeft:
            return onTapLeft();
          case PhysicalKeyboardKey.arrowRight:
            return onTapRight();
          case PhysicalKeyboardKey.arrowUp:
            return onTapTop(250);
          case PhysicalKeyboardKey.arrowDown:
            return onTapBottom(250);
          case PhysicalKeyboardKey.pageUp:
            return onTapTop(1000);
          case PhysicalKeyboardKey.pageDown:
            return onTapBottom(1000);
          default:
            return KeyEventResult.ignored;
        }
      } else if (event is KeyRepeatEvent) {
        switch (event.physicalKey) {
          case PhysicalKeyboardKey.arrowUp:
            return onTapTop(250);
          case PhysicalKeyboardKey.arrowDown:
            return onTapBottom(250);
          case PhysicalKeyboardKey.pageUp:
            return onTapTop(1000);
          case PhysicalKeyboardKey.pageDown:
            return onTapBottom(1000);
          default:
            return KeyEventResult.ignored;
        }
      }

      return KeyEventResult.ignored;
    }

    void handleImageViewOnTap(BuildContext context, TapUpDetails details,
        PhotoViewControllerValue value) {
      focusNode.requestFocus();

      final taploc = details.localPosition.dx;
      final viewport = context.size!.width;

      final tapmargin = viewport / 2.5;

      if (taploc < tapmargin) {
        onTapLeft();
      } else if (taploc > viewport - tapmargin) {
        onTapRight();
      }
    }

    final pageDropdownItems = List<DropdownMenuEntry<int>>.generate(
        pageCount,
        (int index) => DropdownMenuEntry<int>(
            value: index, label: (index + 1).toString()));

    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else if (backRoute != null) {
              context.go(backRoute!);
            }
          },
        ),
        title: ListTile(
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: subtext.value != null ? Text(subtext.value!) : null,
        ),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
              tooltip: 'Reader Settings',
            ),
          ),
        ],
      ),
      endDrawer: Drawer(
        width: 320,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              (link != null
                  ? TextButton(
                      onPressed: () {
                        // First one pops the drawer
                        if (context.canPop()) {
                          context.pop();
                        }

                        // Second one pops the reader
                        if (context.canPop()) {
                          context.pop();
                        }

                        if (onLinkPressed != null) {
                          onLinkPressed!();
                        }
                      },
                      child: link!)
                  : const SizedBox.shrink()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ValueListenableBuilder<int>(
                    builder: (BuildContext context, int value, Widget? child) {
                      return OutlinedButton(
                        onPressed:
                            (value > 0) ? () => jumpToPreviousPage() : null,
                        child: const Icon(Icons.arrow_back_ios_new),
                      );
                    },
                    valueListenable: currentPage,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ValueListenableBuilder<int>(
                    builder: (BuildContext context, int value, Widget? child) {
                      return DropdownMenu<int>(
                        initialSelection: value,
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
                            jumpToPage(index);
                          }
                        },
                        dropdownMenuEntries: pageDropdownItems,
                      );
                    },
                    valueListenable: currentPage,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ValueListenableBuilder<int>(
                    builder: (BuildContext context, int value, Widget? child) {
                      return OutlinedButton(
                        onPressed: (value < pageCount - 1)
                            ? () => jumpToNextPage()
                            : null,
                        child: const Icon(Icons.arrow_forward_ios),
                      );
                    },
                    valueListenable: currentPage,
                  ),
                ],
              ),
              const Divider(),
              const Text(
                'Reader Settings',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10.0),
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  for (final f in ReaderFormat.values)
                    ChoiceChip(
                      avatar: Icon(
                        f.icon,
                        color: theme.iconTheme.color,
                      ),
                      label: Text(f.formatted),
                      selected: settings.format == f,
                      onSelected: (longstrip)
                          ? null
                          : (value) {
                              if (value) {
                                ref
                                    .read(readerSettingsProvider.notifier)
                                    .save(settings.copyWith(format: f));
                              }
                            },
                    ),
                ],
              ),
              const SizedBox(height: 10.0),
              ActionChip(
                avatar: Icon(Icons.fit_screen, color: theme.iconTheme.color),
                label: const Text('Toggle Page Size'),
                onPressed: (format == ReaderFormat.longstrip)
                    ? null
                    : () {
                        scaleStateController[currentPage.value].scaleState =
                            defaultScaleStateCycle(
                                scaleStateController[currentPage.value]
                                    .scaleState);
                      },
              ),
              const SizedBox(height: 10.0),
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  for (final dir in ReaderDirection.values)
                    ChoiceChip(
                      avatar: Icon(
                        dir.icon,
                        color: theme.iconTheme.color,
                      ),
                      label: Text(dir.formatted),
                      selected: settings.direction == dir,
                      onSelected: (format == ReaderFormat.longstrip)
                          ? null
                          : (value) {
                              if (value) {
                                ref
                                    .read(readerSettingsProvider.notifier)
                                    .save(settings.copyWith(direction: dir));
                              }
                            },
                    ),
                ],
              ),
              const SizedBox(height: 10.0),
              ActionChip(
                avatar: Icon(
                  settings.showProgressBar
                      ? Icons.donut_small
                      : Icons.donut_small_outlined,
                  color: theme.iconTheme.color,
                ),
                label: const Text('Progress Bar'),
                onPressed: () {
                  ref.read(readerSettingsProvider.notifier).save(settings
                      .copyWith(showProgressBar: !settings.showProgressBar));
                },
              ),
              const SizedBox(height: 10.0),
              ActionChip(
                avatar: Icon(
                  Icons.swipe,
                  color: settings.swipeGestures
                      ? theme.iconTheme.color
                      : theme.disabledColor,
                ),
                label: const Text('Swipe Gestures'),
                onPressed: (format == ReaderFormat.longstrip)
                    ? null
                    : () {
                        ref.read(readerSettingsProvider.notifier).save(settings
                            .copyWith(swipeGestures: !settings.swipeGestures));
                      },
              ),
              const SizedBox(height: 10.0),
              ActionChip(
                avatar: Icon(
                  Icons.mouse,
                  color: settings.clickToTurn
                      ? theme.iconTheme.color
                      : theme.disabledColor,
                ),
                label: const Text('Click/Tap to Turn Page'),
                onPressed: (format == ReaderFormat.longstrip)
                    ? null
                    : () {
                        ref.read(readerSettingsProvider.notifier).save(settings
                            .copyWith(clickToTurn: !settings.clickToTurn));
                      },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Page Preload'),
                  const SizedBox(
                    width: 10,
                  ),
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
                        ref
                            .read(readerSettingsProvider.notifier)
                            .save(settings.copyWith(precacheCount: value));
                      }
                    },
                    dropdownMenuEntries: List<DropdownMenuEntry<int>>.generate(
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
      endDrawerEnableOpenDragGesture: false,
      body: Focus(
        autofocus: true,
        focusNode: focusNode,
        onKeyEvent: handleKeyEvent,
        child: Container(
          child: (() {
            if (pages.isEmpty && externalUrl != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Read on external site:'),
                    const SizedBox(
                      height: 10.0,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (!await launchUrl(Uri.parse(externalUrl!))) {
                          throw 'Could not launch ${externalUrl!}';
                        }
                      },
                      child: Text(externalUrl!),
                    ),
                  ],
                ),
              );
            }

            if (format == ReaderFormat.longstrip) {
              return ScrollablePositionedList.builder(
                itemScrollController: itemScrollController,
                itemPositionsListener: itemPositionsListener,
                scrollOffsetController: scrollOffsetController,
                itemCount: pageCount,
                itemBuilder: (BuildContext context, int index) {
                  final page = pages.elementAt(index);

                  return PhotoView(
                    imageProvider: page.provider,
                    backgroundDecoration:
                        const BoxDecoration(color: Colors.black),
                    enableRotation: false,
                    disableGestures: true,
                    customSize: mediaContext.size,
                    minScale: PhotoViewComputedScale.contained * 1.0,
                    maxScale: PhotoViewComputedScale.covered * 5.0,
                    initialScale: DeviceContext.isPortraitMode(context)
                        ? PhotoViewComputedScale.covered
                        : PhotoViewComputedScale.covered * 0.5,
                    basePosition: Alignment.topCenter,
                    tightMode: true,
                    loadingBuilder: (context, event) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              );
            }

            return PageView.builder(
              allowImplicitScrolling: true,
              reverse: settings.direction == ReaderDirection.rightToLeft,
              physics: (!settings.swipeGestures ||
                      currentImageScale.value != PhotoViewScaleState.initial)
                  ? const NeverScrollableScrollPhysics()
                  : null,
              scrollBehavior: MouseTouchScrollBehavior(),
              controller: pageController,
              itemCount: pageCount,
              onPageChanged: (int index) {
                focusNode.requestFocus();
                currentImageScale.value =
                    scaleStateController[index].scaleState;
              },
              itemBuilder: (BuildContext context, int index) {
                final page = pages.elementAt(index);

                return PhotoView(
                  imageProvider: page.provider,
                  backgroundDecoration:
                      const BoxDecoration(color: Colors.black),
                  enableRotation: false,
                  scaleStateController: scaleStateController[index],
                  controller: viewController[index],
                  minScale: PhotoViewComputedScale.contained * 1.0,
                  maxScale: PhotoViewComputedScale.covered * 5.0,
                  initialScale: PhotoViewComputedScale.contained,
                  basePosition: Alignment.topCenter,
                  onTapUp: settings.clickToTurn ? handleImageViewOnTap : null,
                  loadingBuilder: (context, event) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            );
          })(),
        ),
      ),
      // Can't use bottomSheet anymore due to Material 3 specs
      // forcing bottom sheet width to be 640 max
      // https://github.com/flutter/flutter/pull/122445
      extendBody: true,
      bottomNavigationBar: settings.showProgressBar
          ? ProgressIndicator(
              reverse: (format != ReaderFormat.longstrip) &&
                  settings.direction == ReaderDirection.rightToLeft,
              currentPage: currentPage,
              itemCount: pageCount,
              color: theme.colorScheme.primary,
              onPageSelected: (index) => animateToPage(
                index,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
              ),
            )
          : null,
    );
  }
}

class ProgressIndicator extends AnimatedWidget {
  const ProgressIndicator({
    super.key,
    required this.currentPage,
    required this.itemCount,
    required this.onPageSelected,
    required this.reverse,
    this.color = Colors.white,
  }) : super(listenable: currentPage);

  final ValueNotifier<int> currentPage;
  final int itemCount;
  final ValueChanged<int> onPageSelected;
  final Color color;
  final bool reverse;

  static const double _barHeight = 8.0;

  Widget _buildSection(int index) {
    var secColor = Colors.transparent;

    if (index == 0) {
      secColor = color;
    } else {
      secColor = (currentPage.value >= index ? color : Colors.transparent);
    }

    return Expanded(
      child: Container(
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        color: Colors.transparent,
        alignment: Alignment.bottomCenter,
        child: Material(
          color: secColor,
          type: MaterialType.canvas,
          child: SizedBox(
            height: _barHeight,
            child: Tooltip(
              message: (index + 1).toString(),
              child: InkWell(
                onTap: () => onPageSelected(index),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final sections = List<Widget>.generate(itemCount, _buildSection);

    return Container(
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        height: 30.0,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          stops: [0.0, 0.6],
          colors: [
            Color.fromARGB(255, 0, 0, 0),
            Colors.transparent,
          ],
        )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [...(reverse ? sections.reversed : sections)],
        ));
  }
}
