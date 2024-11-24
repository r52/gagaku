import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/reader/model/config.dart';
import 'package:gagaku/reader/model/controller_hooks.dart';
import 'package:gagaku/reader/model/types.dart';
import 'package:gagaku/util/ui.dart';
import 'package:gagaku/util/util.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:super_sliver_list/super_sliver_list.dart';

import 'package:url_launcher/url_launcher.dart';

enum LongStripScale {
  small(0.4),
  large(0.8),
  full(1.0);

  const LongStripScale(this.scale);
  final double scale;
}

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

  final List<ReaderPage> pages;
  final String title;
  final String? subtitle;
  final bool longstrip;
  final Widget? link;
  final VoidCallback? onLinkPressed;
  final String? externalUrl;

  // Backup route for BackButton if nav stack cannot pop
  final String? backRoute;

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

  void cachePage(ReaderPage page, BuildContext context) {
    precacheImage(page.provider, context);
    page.cached = true;
  }

  void cachePages(ValueNotifier<int> currentPage, int precacheCount, BuildContext context) {
    final pageCount = pages.length;

    // Forward cache precacheCount() pages
    if (currentPage.value + 1 < pageCount && !pages.elementAt(currentPage.value + 1).cached) {
      while (!pages.elementAt(currentPage.value + 1).cached) {
        pages.skip(currentPage.value).take(precacheCount).forEach((element) {
          if (!element.cached) {
            cachePage(element, context);
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
        cachePage(element, context);
      }
    });
  }

  void setPageValue({
    required int page,
    required ValueNotifier<int> currentPage,
    required int precacheCount,
    required ValueNotifier<String?> subtext,
    required BuildContext context,
  }) {
    currentPage.value = page;
    cachePages(currentPage, precacheCount, context);
    subtext.value = subtitle ?? pages.elementAt(currentPage.value).sortKey;
  }

  void jumpToPage(
    int page, {
    required ReaderFormat format,
    required PageController pageController,
    required ListController listController,
    required ScrollController scrollController,
  }) {
    final pageCount = pages.length;
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
    required PageController pageController,
    required ListController listController,
    required ScrollController scrollController,
  }) {
    assert(page >= 0 && page < pages.length);

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

  void jumpToPreviousPage(
    ValueNotifier<int> currentPage, {
    required ReaderFormat format,
    required PageController pageController,
    required ListController listController,
    required ScrollController scrollController,
  }) {
    jumpToPage(currentPage.value - 1,
        format: format,
        pageController: pageController,
        listController: listController,
        scrollController: scrollController);
  }

  void jumpToNextPage(
    ValueNotifier<int> currentPage, {
    required ReaderFormat format,
    required PageController pageController,
    required ListController listController,
    required ScrollController scrollController,
  }) {
    jumpToPage(currentPage.value + 1,
        format: format,
        pageController: pageController,
        listController: listController,
        scrollController: scrollController);
  }

  KeyEventResult onTapLeft({
    required ValueNotifier<int> currentPage,
    required ReaderConfig settings,
    required ReaderFormat format,
    required PageController pageController,
    required ListController listController,
    required ScrollController scrollController,
    required BuildContext context,
  }) {
    if (format == ReaderFormat.longstrip) return KeyEventResult.handled;

    switch (settings.direction) {
      case ReaderDirection.leftToRight:
        jumpToPreviousPage(
          currentPage,
          format: format,
          pageController: pageController,
          listController: listController,
          scrollController: scrollController,
        );
        break;
      case ReaderDirection.rightToLeft:
        if (currentPage.value < pages.length - 1) {
          jumpToNextPage(
            currentPage,
            format: format,
            pageController: pageController,
            listController: listController,
            scrollController: scrollController,
          );
        } else {
          if (context.canPop()) {
            context.pop();
          }
        }
        break;
    }

    return KeyEventResult.handled;
  }

  KeyEventResult onTapRight({
    required ValueNotifier<int> currentPage,
    required ReaderConfig settings,
    required ReaderFormat format,
    required PageController pageController,
    required ListController listController,
    required ScrollController scrollController,
    required BuildContext context,
  }) {
    if (format == ReaderFormat.longstrip) return KeyEventResult.handled;

    switch (settings.direction) {
      case ReaderDirection.leftToRight:
        if (currentPage.value < pages.length - 1) {
          jumpToNextPage(
            currentPage,
            format: format,
            pageController: pageController,
            listController: listController,
            scrollController: scrollController,
          );
        } else {
          if (context.canPop()) {
            context.pop();
          }
        }
        break;
      case ReaderDirection.rightToLeft:
        jumpToPreviousPage(
          currentPage,
          format: format,
          pageController: pageController,
          listController: listController,
          scrollController: scrollController,
        );
        break;
    }

    return KeyEventResult.handled;
  }

  KeyEventResult onTapTop(
    double offset, {
    required ValueNotifier<int> currentPage,
    required ReaderConfig settings,
    required ReaderFormat format,
    required List<PhotoViewController> viewController,
    required ListController listController,
    required ScrollController scrollController,
    required BuildContext context,
  }) {
    if (format == ReaderFormat.longstrip) {
      scrollController.animateTo(scrollController.offset - offset,
          duration: const Duration(milliseconds: 50), curve: Curves.easeInOut);

      return KeyEventResult.handled;
    }

    switch (settings.direction) {
      case ReaderDirection.leftToRight:
      case ReaderDirection.rightToLeft:
        viewController[currentPage.value].position = viewController[currentPage.value].position + Offset(0.0, offset);
        break;
    }

    return KeyEventResult.handled;
  }

  KeyEventResult onTapBottom(
    double offset, {
    required ValueNotifier<int> currentPage,
    required ReaderConfig settings,
    required ReaderFormat format,
    required List<PhotoViewController> viewController,
    required ListController listController,
    required ScrollController scrollController,
    required BuildContext context,
  }) {
    if (format == ReaderFormat.longstrip) {
      if (listController.isAttached && listController.visibleRange != null) {
        final positions = listController.visibleRange;
        final max = positions!.$2;

        if (max == pages.length - 1 &&
            scrollController.position.atEdge &&
            scrollController.position.pixels == scrollController.position.maxScrollExtent) {
          if (context.canPop()) {
            context.pop();
          }
        } else {
          scrollController.animateTo(scrollController.offset + offset,
              duration: const Duration(milliseconds: 50), curve: Curves.easeInOut);
        }
      }

      return KeyEventResult.handled;
    }

    switch (settings.direction) {
      case ReaderDirection.leftToRight:
      case ReaderDirection.rightToLeft:
        viewController[currentPage.value].position = viewController[currentPage.value].position - Offset(0.0, offset);
        break;
    }

    return KeyEventResult.handled;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageCount = pages.length;
    final focusNode = useFocusNode();
    final pageController = usePageController(initialPage: 0);
    final scaleStateController =
        List<PhotoViewScaleStateController>.generate(pageCount, (index) => usePhotoViewScaleStateController());
    final viewController = List<PhotoViewController>.generate(pageCount, (index) => usePhotoViewController());
    final settings = ref.watch(readerSettingsProvider);
    final theme = Theme.of(context);
    final currentPage = useValueNotifier(0);
    final listController = useListController();
    final scrollController = useScrollController();
    final subtext = useValueNotifier<String?>(subtitle ?? (pages.isNotEmpty ? pages.elementAt(0).sortKey : ''));
    final format = longstrip ? ReaderFormat.longstrip : settings.format;
    final isPortrait = DeviceContext.isPortraitMode(context);
    final longStripScale = useValueNotifier(isPortrait ? LongStripScale.full : LongStripScale.small);

    final precacheCount = useCallback(() {
      return (settings.precacheCount > 9 || format == ReaderFormat.longstrip) ? pageCount : settings.precacheCount;
    }, [settings, format]);

    useEffect(() {
      void pageCallback() {
        if (pageController.page != null) {
          Future.delayed(Duration.zero, () {
            if (context.mounted) {
              setPageValue(
                page: pageController.page!.toInt(),
                currentPage: currentPage,
                precacheCount: precacheCount(),
                subtext: subtext,
                context: context,
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
              setPageValue(
                page: min,
                currentPage: currentPage,
                precacheCount: precacheCount(),
                subtext: subtext,
                context: context,
              );
            }
          });
        }
      }

      listController.addListener(listPosCb);
      return () => listController.removeListener(listPosCb);
    }, [listController, settings]);

    final pageDropdownItems = List<DropdownMenuEntry<int>>.generate(
        pageCount, (int index) => DropdownMenuEntry<int>(value: index, label: (index + 1).toString()));

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
              tooltip: 'reader.settings'.tr(context: context),
            ),
          ),
        ],
      ),
      endDrawer: Drawer(
        width: 320,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 10.0,
            children: <Widget>[
              const SizedBox.shrink(),
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
                spacing: 10.0,
                children: [
                  HookBuilder(
                    builder: (_) {
                      final value = useValueListenable(currentPage);
                      return OutlinedButton(
                        onPressed: (value > 0)
                            ? () => jumpToPreviousPage(
                                  currentPage,
                                  format: format,
                                  pageController: pageController,
                                  listController: listController,
                                  scrollController: scrollController,
                                )
                            : null,
                        child: const Icon(Icons.arrow_back_ios_new),
                      );
                    },
                  ),
                  HookBuilder(
                    builder: (_) {
                      final value = useValueListenable(currentPage);
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
                            jumpToPage(
                              index,
                              format: format,
                              pageController: pageController,
                              listController: listController,
                              scrollController: scrollController,
                            );
                          }
                        },
                        dropdownMenuEntries: pageDropdownItems,
                      );
                    },
                  ),
                  HookBuilder(
                    builder: (_) {
                      final value = useValueListenable(currentPage);
                      return OutlinedButton(
                        onPressed: (value < pageCount - 1)
                            ? () => jumpToNextPage(
                                  currentPage,
                                  format: format,
                                  pageController: pageController,
                                  listController: listController,
                                  scrollController: scrollController,
                                )
                            : null,
                        child: const Icon(Icons.arrow_forward_ios),
                      );
                    },
                  ),
                ],
              ),
              const Divider(),
              Text(
                'reader.settings'.tr(context: context),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  for (final f in ReaderFormat.values)
                    ChoiceChip(
                      avatar: Icon(
                        f.icon,
                        color: theme.iconTheme.color,
                      ),
                      label: Text(context.tr(f.label)),
                      selected: settings.format == f,
                      onSelected: (longstrip)
                          ? null
                          : (value) {
                              if (value) {
                                ref.read(readerSettingsProvider.notifier).save(settings.copyWith(format: f));
                              }
                            },
                    ),
                ],
              ),
              ActionChip(
                avatar: Icon(Icons.fit_screen, color: theme.iconTheme.color),
                label: Text('reader.togglePageSize'.tr(context: context)),
                onPressed: (format == ReaderFormat.longstrip)
                    ? () {
                        longStripScale.value = toggleLongStripScale(longStripScale.value);
                      }
                    : () {
                        scaleStateController[currentPage.value].scaleState =
                            defaultScaleStateCycle(scaleStateController[currentPage.value].scaleState);
                      },
              ),
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  for (final dir in ReaderDirection.values)
                    ChoiceChip(
                      avatar: Icon(
                        dir.icon,
                        color: theme.iconTheme.color,
                      ),
                      label: Text(context.tr(dir.label)),
                      selected: settings.direction == dir,
                      onSelected: (format == ReaderFormat.longstrip)
                          ? null
                          : (value) {
                              if (value) {
                                ref.read(readerSettingsProvider.notifier).save(settings.copyWith(direction: dir));
                              }
                            },
                    ),
                ],
              ),
              ActionChip(
                avatar: Icon(
                  settings.showProgressBar ? Icons.donut_small : Icons.donut_small_outlined,
                  color: theme.iconTheme.color,
                ),
                label: Text('reader.progressBar'.tr(context: context)),
                onPressed: () {
                  ref
                      .read(readerSettingsProvider.notifier)
                      .save(settings.copyWith(showProgressBar: !settings.showProgressBar));
                },
              ),
              ActionChip(
                avatar: Icon(
                  Icons.swipe,
                  color: settings.swipeGestures ? theme.iconTheme.color : theme.disabledColor,
                ),
                label: Text('reader.swipeGestures'.tr(context: context)),
                onPressed: (format == ReaderFormat.longstrip)
                    ? null
                    : () {
                        ref
                            .read(readerSettingsProvider.notifier)
                            .save(settings.copyWith(swipeGestures: !settings.swipeGestures));
                      },
              ),
              ActionChip(
                avatar: Icon(
                  Icons.mouse,
                  color: settings.clickToTurn ? theme.iconTheme.color : theme.disabledColor,
                ),
                label: Text('reader.clickToTurn'.tr(context: context)),
                onPressed: (format == ReaderFormat.longstrip)
                    ? null
                    : () {
                        ref
                            .read(readerSettingsProvider.notifier)
                            .save(settings.copyWith(clickToTurn: !settings.clickToTurn));
                      },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 10.0,
                children: [
                  Text('reader.precacheCount'.tr(context: context)),
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
                        ref.read(readerSettingsProvider.notifier).save(settings.copyWith(precacheCount: value));
                      }
                    },
                    dropdownMenuEntries: List<DropdownMenuEntry<int>>.generate(
                      10,
                      (int index) => DropdownMenuEntry<int>(
                        value: index + 1,
                        label: (index + 1 > 9) ? 'Max (not recommended)' : (index + 1).toString(),
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
        onKeyEvent: (node, event) {
          if (event is KeyDownEvent) {
            switch (event.physicalKey) {
              case PhysicalKeyboardKey.arrowLeft:
                return onTapLeft(
                  currentPage: currentPage,
                  settings: settings,
                  format: format,
                  pageController: pageController,
                  listController: listController,
                  scrollController: scrollController,
                  context: context,
                );
              case PhysicalKeyboardKey.arrowRight:
                return onTapRight(
                  currentPage: currentPage,
                  settings: settings,
                  format: format,
                  pageController: pageController,
                  listController: listController,
                  scrollController: scrollController,
                  context: context,
                );
              case PhysicalKeyboardKey.arrowUp:
                return onTapTop(
                  250,
                  currentPage: currentPage,
                  settings: settings,
                  format: format,
                  viewController: viewController,
                  listController: listController,
                  scrollController: scrollController,
                  context: context,
                );
              case PhysicalKeyboardKey.arrowDown:
                return onTapBottom(
                  250,
                  currentPage: currentPage,
                  settings: settings,
                  format: format,
                  viewController: viewController,
                  listController: listController,
                  scrollController: scrollController,
                  context: context,
                );
              case PhysicalKeyboardKey.pageUp:
                return onTapTop(
                  1000,
                  currentPage: currentPage,
                  settings: settings,
                  format: format,
                  viewController: viewController,
                  listController: listController,
                  scrollController: scrollController,
                  context: context,
                );
              case PhysicalKeyboardKey.pageDown:
                return onTapBottom(
                  1000,
                  currentPage: currentPage,
                  settings: settings,
                  format: format,
                  viewController: viewController,
                  listController: listController,
                  scrollController: scrollController,
                  context: context,
                );
              default:
                return KeyEventResult.ignored;
            }
          } else if (event is KeyRepeatEvent) {
            switch (event.physicalKey) {
              case PhysicalKeyboardKey.arrowUp:
                return onTapTop(
                  250,
                  currentPage: currentPage,
                  settings: settings,
                  format: format,
                  viewController: viewController,
                  listController: listController,
                  scrollController: scrollController,
                  context: context,
                );
              case PhysicalKeyboardKey.arrowDown:
                return onTapBottom(
                  250,
                  currentPage: currentPage,
                  settings: settings,
                  format: format,
                  viewController: viewController,
                  listController: listController,
                  scrollController: scrollController,
                  context: context,
                );
              case PhysicalKeyboardKey.pageUp:
                return onTapTop(
                  1000,
                  currentPage: currentPage,
                  settings: settings,
                  format: format,
                  viewController: viewController,
                  listController: listController,
                  scrollController: scrollController,
                  context: context,
                );
              case PhysicalKeyboardKey.pageDown:
                return onTapBottom(
                  1000,
                  currentPage: currentPage,
                  settings: settings,
                  format: format,
                  viewController: viewController,
                  listController: listController,
                  scrollController: scrollController,
                  context: context,
                );
              default:
                return KeyEventResult.ignored;
            }
          }

          return KeyEventResult.ignored;
        },
        child: Builder(
          builder: (context) {
            if (pages.isEmpty && externalUrl != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 10.0,
                  children: [
                    const Text('Read on external site:'),
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
              final mediaSize = MediaQuery.sizeOf(context);

              return SuperListView(
                listController: listController,
                controller: scrollController,
                cacheExtent: mediaSize.height * pageCount,
                children: pages
                    .map(
                      (page) => Center(
                        key: ValueKey(page.id),
                        child: HookBuilder(
                          builder: (context) {
                            final scale = useValueListenable(longStripScale);
                            final width = mediaSize.width * scale.scale;
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
                          },
                        ),
                      ),
                    )
                    .toList(),
              );
            }

            return PhotoViewGallery.builder(
              allowImplicitScrolling: true,
              reverse: settings.direction == ReaderDirection.rightToLeft,
              scrollPhysics: !settings.swipeGestures ? const NeverScrollableScrollPhysics() : null,
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
                final page = pages.elementAt(index);
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
                            onTapLeft(
                              currentPage: currentPage,
                              settings: settings,
                              format: format,
                              pageController: pageController,
                              listController: listController,
                              scrollController: scrollController,
                              context: context,
                            );
                          } else if (taploc > viewport - tapmargin) {
                            onTapRight(
                              currentPage: currentPage,
                              settings: settings,
                              format: format,
                              pageController: pageController,
                              listController: listController,
                              scrollController: scrollController,
                              context: context,
                            );
                          }
                        }
                      : null,
                );
              },
            );
          },
        ),
      ),
      // Can't use bottomSheet anymore due to Material 3 specs
      // forcing bottom sheet width to be 640 max
      // https://github.com/flutter/flutter/pull/122445
      extendBody: true,
      bottomNavigationBar: settings.showProgressBar
          ? ProgressIndicator(
              reverse: (format != ReaderFormat.longstrip) && settings.direction == ReaderDirection.rightToLeft,
              currentPage: currentPage,
              itemCount: pageCount,
              color: theme.colorScheme.primary,
              onPageSelected: (index) => animateToPage(
                index,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
                format: format,
                pageController: pageController,
                listController: listController,
                scrollController: scrollController,
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
    required this.reverse,
    this.color = Colors.white,
  });

  final ValueNotifier<int> currentPage;
  final int itemCount;
  final ValueChanged<int> onPageSelected;
  final Color color;
  final bool reverse;

  static const double _barHeight = 8.0;

  @override
  Widget build(BuildContext context) {
    final sections = useMemoized(() {
      return List<Widget>.generate(itemCount, (index) {
        return _ProgressBarSection(
          index: index,
          currentPage: currentPage,
          color: color,
          height: _barHeight,
          tooltip: (index + 1).toString(),
          onTap: () => onPageSelected(index),
        );
      });
    });

    return ConstrainedBox(
      constraints: BoxConstraints.loose(const Size.fromHeight(30)),
      child: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            stops: [0.0, 0.6],
            colors: [
              Color.fromARGB(255, 0, 0, 0),
              Colors.transparent,
            ],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: reverse ? sections.reversed.toList() : sections,
        ),
      ),
    );
  }
}

class _ProgressBarSection extends StatelessWidget {
  const _ProgressBarSection({
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
    return Expanded(
      child: Tooltip(
        message: tooltip,
        child: InkWell(
          onTap: onTap,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: HookBuilder(
              builder: (context) {
                final page = useValueListenable(currentPage);
                return Material(
                  color: (index == 0 || page >= index) ? color : Colors.transparent,
                  child: SizedBox(
                    height: height,
                    width: double.infinity,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
