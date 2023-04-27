import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/reader/config.dart';
import 'package:gagaku/reader/types.dart';
import 'package:gagaku/ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:url_launcher/url_launcher.dart';

class ReaderWidget extends HookConsumerWidget {
  const ReaderWidget({
    super.key,
    required this.pages,
    required this.pageCount,
    required this.title,
    this.link,
    this.onLinkPressed,
    this.externalUrl,
  });

  final Iterable<ReaderPage> pages;
  final int pageCount;
  final String title;
  final Widget? link;
  final VoidCallback? onLinkPressed;
  final String? externalUrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final focusNode = useFocusNode();
    final pageController = usePageController(initialPage: 0);
    final transformController = useTransformationController();
    final settings = ref.watch(readerSettingsProvider);
    final theme = Theme.of(context);
    final scaleFactor =
        useRef(List<double>.generate(pages.length, (index) => 0.0));
    final initialized = useRef(false);

    void cachePage(ReaderPage page) {
      precacheImage(page.provider, context);
      page.cached = true;
    }

    void resetImageFit(int index) {
      if (settings.fitWidth) {
        transformController.value =
            Matrix4.identity() * scaleFactor.value[index];
      } else {
        transformController.value = Matrix4.identity();
      }
    }

    final precacheCount = useCallback(() {
      return settings.precacheCount > 9 ? pageCount : settings.precacheCount;
    }, [settings]);

    useCallback(() {
      pages.take(precacheCount()).forEach((element) {
        cachePage(element);
      });
    }, [settings]);

    useEffect(() {
      void pageCallback() {
        if (pageController.hasClients && pageController.page != null) {
          resetImageFit(pageController.page!.toInt());
        }

        if (pageController.page != null &&
            pageController.page!.toInt() + 1 < pages.length &&
            !pages.elementAt(pageController.page!.toInt() + 1).cached) {
          while (!pages.elementAt(pageController.page!.toInt() + 1).cached) {
            pages
                .skipWhile((page) => page.cached)
                .take(precacheCount())
                .forEach((element) {
              if (!element.cached) {
                cachePage(element);
              }
            });
          }
        }
      }

      pageController.addListener(pageCallback);
      return () => pageController.removeListener(pageCallback);
    }, [pageController, settings]);

    void onTapLeft() {
      switch (settings.direction) {
        case ReaderDirection.leftToRight:
          if (pageController.page! > 0) {
            pageController.jumpToPage(pageController.page!.toInt() - 1);
          }
          break;
        case ReaderDirection.rightToLeft:
          if (pageController.page! < pages.length - 1) {
            pageController.jumpToPage(pageController.page!.toInt() + 1);
          } else {
            Navigator.of(context).pop();
          }
          break;
        case ReaderDirection.topToBottom:
        default:
          // Do nothing
          break;
      }
    }

    void onTapRight() {
      switch (settings.direction) {
        case ReaderDirection.leftToRight:
          if (pageController.page! < pages.length - 1) {
            pageController.jumpToPage(pageController.page!.toInt() + 1);
          } else {
            Navigator.of(context).pop();
          }
          break;
        case ReaderDirection.rightToLeft:
          if (pageController.page! > 0) {
            pageController.jumpToPage(pageController.page!.toInt() - 1);
          }
          break;
        case ReaderDirection.topToBottom:
        default:
          // Do nothing
          break;
      }
    }

    void onTapTop(double offset) {
      switch (settings.direction) {
        case ReaderDirection.topToBottom:
          if (pageController.page! > 0) {
            pageController.animateTo(
              pageController.position.pixels - offset,
              duration: const Duration(milliseconds: 10),
              curve: Curves.easeInOut,
            );
          }
          break;
        case ReaderDirection.leftToRight:
        case ReaderDirection.rightToLeft:
        default:
          // Do nothing
          break;
      }
    }

    void onTapBottom(double offset) {
      switch (settings.direction) {
        case ReaderDirection.topToBottom:
          if (pageController.page! < pages.length - 1) {
            pageController.animateTo(
              pageController.position.pixels + offset,
              duration: const Duration(milliseconds: 10),
              curve: Curves.easeInOut,
            );
          } else {
            Navigator.of(context).pop();
          }
          break;
        case ReaderDirection.leftToRight:
        case ReaderDirection.rightToLeft:
        default:
          // Do nothing
          break;
      }
    }

    KeyEventResult handleKeyEvent(FocusNode node, KeyEvent event) {
      if (event is KeyDownEvent) {
        if (event.physicalKey == PhysicalKeyboardKey.arrowLeft) {
          onTapLeft();
          return KeyEventResult.handled;
        } else if (event.physicalKey == PhysicalKeyboardKey.arrowRight) {
          onTapRight();
          return KeyEventResult.handled;
        } else if (event.physicalKey == PhysicalKeyboardKey.arrowUp) {
          onTapTop(250);
          return KeyEventResult.handled;
        } else if (event.physicalKey == PhysicalKeyboardKey.arrowDown) {
          onTapBottom(250);
          return KeyEventResult.handled;
        } else if (event.physicalKey == PhysicalKeyboardKey.pageUp) {
          onTapTop(1000);
          return KeyEventResult.handled;
        } else if (event.physicalKey == PhysicalKeyboardKey.pageDown) {
          onTapBottom(1000);
          return KeyEventResult.handled;
        }
      } else if (event is KeyRepeatEvent) {
        if (event.physicalKey == PhysicalKeyboardKey.arrowUp) {
          onTapTop(250);
          return KeyEventResult.handled;
        } else if (event.physicalKey == PhysicalKeyboardKey.arrowDown) {
          onTapBottom(250);
          return KeyEventResult.handled;
        } else if (event.physicalKey == PhysicalKeyboardKey.pageUp) {
          onTapTop(1000);
          return KeyEventResult.handled;
        } else if (event.physicalKey == PhysicalKeyboardKey.pageDown) {
          onTapBottom(1000);
          return KeyEventResult.handled;
        }
      }

      return KeyEventResult.ignored;
    }

    void handleImageViewOnTap(TapUpDetails details) {
      focusNode.requestFocus();

      var taploc = details.localPosition.dx;
      var viewport = context.size!.width;

      if (settings.direction == ReaderDirection.topToBottom) {
        taploc = details.localPosition.dy;
        viewport = context.size!.height;
      }

      var tapmargin = viewport / 2.5;

      if (taploc < tapmargin) {
        if (settings.direction != ReaderDirection.topToBottom) {
          onTapLeft();
        } else {
          // Do something else
        }
      } else if (taploc > viewport - tapmargin) {
        if (settings.direction != ReaderDirection.topToBottom) {
          onTapRight();
        } else {
          // Do something else
        }
      }
    }

    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(title),
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
                        Navigator.of(context)
                          ..pop()
                          ..pop();

                        if (onLinkPressed != null) {
                          onLinkPressed!();
                        }
                      },
                      child: link!)
                  : const SizedBox.shrink()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: (pageController.hasClients &&
                            pageController.page!.toInt() > 0)
                        ? () {
                            pageController
                                .jumpToPage(pageController.page!.toInt() - 1);
                          }
                        : null,
                    child: const Text('Previous Page'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  DropdownButton<int>(
                    value: (pageController.hasClients
                        ? pageController.page!.toInt()
                        : pageController.initialPage),
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: theme.colorScheme.primary),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (int? index) {
                      if (pageController.hasClients && index != null) {
                        pageController.jumpToPage(index);
                      }
                    },
                    items: List<DropdownMenuItem<int>>.generate(
                        pageCount,
                        (int index) => DropdownMenuItem<int>(
                            value: index, child: Text((index + 1).toString()))),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  OutlinedButton(
                    onPressed: (pageController.hasClients &&
                            pageController.page!.toInt() < pageCount - 1)
                        ? () {
                            pageController
                                .jumpToPage(pageController.page!.toInt() + 1);
                          }
                        : null,
                    child: const Text('Next Page'),
                  ),
                ],
              ),
              const Divider(),
              const Text(
                'Reader Settings',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10.0),
              ActionChip(
                  avatar:
                      Icon(settings.fitWidth ? Icons.fit_screen : Icons.height),
                  label: Text(settings.fitWidth ? 'Fit Screen' : 'Fit Height'),
                  onPressed: () {
                    bool set = !settings.fitWidth;

                    ref
                        .read(readerSettingsProvider.notifier)
                        .save(settings.copyWith(fitWidth: set));

                    if (pageController.hasClients &&
                        pageController.page != null) {
                      // Manually set this because settings haven't finished updating
                      if (set) {
                        transformController.value = Matrix4.identity() *
                            scaleFactor.value[pageController.page!.toInt()];
                      } else {
                        transformController.value = Matrix4.identity();
                      }
                    }
                  }),
              const SizedBox(height: 10.0),
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  for (final dir in ReaderDirection.values)
                    ChoiceChip(
                      avatar: dir.icon,
                      label: Text(dir.formatted),
                      selected: settings.direction == dir,
                      onSelected: (value) {
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
                  avatar: Icon(settings.showProgressBar
                      ? Icons.donut_small
                      : Icons.donut_small_outlined),
                  label: const Text('Progress Bar'),
                  onPressed: () {
                    ref.read(readerSettingsProvider.notifier).save(settings
                        .copyWith(showProgressBar: !settings.showProgressBar));
                  }),
              const SizedBox(height: 10.0),
              ActionChip(
                  avatar: Icon(
                    Icons.swipe,
                    color: settings.swipeGestures
                        ? theme.iconTheme.color
                        : theme.disabledColor,
                  ),
                  label: const Text('Swipe Gestures'),
                  onPressed: () {
                    ref.read(readerSettingsProvider.notifier).save(settings
                        .copyWith(swipeGestures: !settings.swipeGestures));
                  }),
              const SizedBox(height: 10.0),
              ActionChip(
                  avatar: Icon(
                    Icons.mouse,
                    color: settings.clickToTurn
                        ? theme.iconTheme.color
                        : theme.disabledColor,
                  ),
                  label: const Text('Click/Tap to Turn Page'),
                  onPressed: () {
                    ref.read(readerSettingsProvider.notifier).save(
                        settings.copyWith(clickToTurn: !settings.clickToTurn));
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Page Preload'),
                  const SizedBox(
                    width: 10,
                  ),
                  DropdownButton<int>(
                    value: settings.precacheCount,
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (int? value) {
                      if (value != null) {
                        ref
                            .read(readerSettingsProvider.notifier)
                            .save(settings.copyWith(precacheCount: value));
                      }
                    },
                    items: List<DropdownMenuItem<int>>.generate(
                      10,
                      (int index) => DropdownMenuItem<int>(
                        value: index + 1,
                        child: Text(
                            (index + 1 > 9) ? 'Max' : (index + 1).toString()),
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
          child: (pages.isEmpty && externalUrl != null)
              ? Center(
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
                )
              : PageView.builder(
                  allowImplicitScrolling: true,
                  reverse: settings.direction == ReaderDirection.rightToLeft,
                  physics: !settings.swipeGestures
                      ? const NeverScrollableScrollPhysics()
                      : null,
                  scrollBehavior: MouseTouchScrollBehavior(),
                  scrollDirection:
                      settings.direction == ReaderDirection.topToBottom
                          ? Axis.vertical
                          : Axis.horizontal,
                  // pageSnapping:
                  //     settings.direction != ReaderDirection.topToBottom,
                  controller: pageController,
                  itemCount: pageCount,
                  onPageChanged: (int index) {
                    focusNode.requestFocus();
                  },
                  itemBuilder: (BuildContext context, int index) {
                    var page = pages.elementAt(index);

                    return GestureDetector(
                      onDoubleTap: () => resetImageFit(index),
                      onTapUp:
                          settings.clickToTurn ? handleImageViewOnTap : null,
                      child: InteractiveViewer(
                        constrained: !settings.fitWidth,
                        transformationController: transformController,
                        minScale: 0.1,
                        maxScale: 10,
                        child: ExtendedImage(
                          image: page.provider,
                          loadStateChanged: (state) {
                            switch (state.extendedImageLoadState) {
                              case LoadState.loading:
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              case LoadState.completed:
                                {
                                  scaleFactor.value[index] =
                                      (MediaQuery.of(context).size.width /
                                          state.extendedImageInfo!.image.width
                                              .toDouble());

                                  if (!initialized.value &&
                                      scaleFactor.value[0] != 0.0) {
                                    initialized.value = true;
                                    Future.delayed(Duration.zero, () {
                                      resetImageFit(0);
                                    });
                                  }

                                  return null;
                                }
                              case LoadState.failed:
                                {
                                  ScaffoldMessenger.of(context)
                                    ..removeCurrentSnackBar()
                                    ..showSnackBar(
                                      const SnackBar(
                                        content: Text('Image load failed'),
                                        backgroundColor: Colors.red,
                                      ),
                                    );

                                  return GestureDetector(
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: const <Widget>[
                                        Icon(Icons.error),
                                        Text(
                                          "Image load failed. Tap to retry",
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                    onTap: () {
                                      state.reLoadImage();
                                    },
                                  );
                                }
                            }
                          },
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
      bottomSheet: settings.showProgressBar
          ? ProgressIndicator(
              reverse: settings.direction == ReaderDirection.rightToLeft,
              controller: pageController,
              itemCount: pages.length,
              color: theme.colorScheme.primary,
              onPageSelected: (index) {
                if (pageController.hasClients) {
                  pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                }
              },
            )
          : null,
    );
  }
}

class ProgressIndicator extends AnimatedWidget {
  const ProgressIndicator({
    super.key,
    required this.controller,
    required this.itemCount,
    required this.onPageSelected,
    required this.reverse,
    this.color = Colors.white,
  }) : super(listenable: controller);

  final PageController controller;
  final int itemCount;
  final ValueChanged<int> onPageSelected;
  final Color color;
  final bool reverse;

  static const double _barHeight = 8.0;

  Widget _buildSection(int index) {
    var secColor = Colors.transparent;

    if (index == 0) {
      secColor = color;
    } else if (controller.hasClients && controller.page != null) {
      secColor = (controller.page! >= index ? color : Colors.transparent);
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
    var sections = List<Widget>.generate(itemCount, _buildSection);

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
            Colors.black,
            Colors.transparent,
          ],
        )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [...(reverse ? sections.reversed : sections)],
        ));
  }
}
