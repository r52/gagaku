import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gagaku/src/mangadex/api.dart';
import 'package:gagaku/src/reader.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';

Route createReaderRoute(Chapter chapter, Manga manga) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        MangaDexReaderWidget(
      chapter: chapter,
      manga: manga,
    ),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

class ReaderScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class MangaDexReaderWidget extends StatefulWidget {
  const MangaDexReaderWidget(
      {Key? key, required this.chapter, required this.manga})
      : super(key: key);

  final Chapter chapter;
  final Manga manga;

  @override
  _MangaDexReaderState createState() => _MangaDexReaderState();
}

class _MangaDexReaderState extends State<MangaDexReaderWidget> {
  final FocusNode _focusNode = FocusNode();
  ReaderSettings _settings = ReaderSettings();

  final PageController _pageController = PageController(initialPage: 0);
  final PhotoViewScaleStateController _scaleStateController =
      PhotoViewScaleStateController();

  late Future<List<ImageProvider>> _pages;

  @override
  void initState() {
    super.initState();

    ReaderSettings.load().then((settings) {
      setState(() {
        _settings = settings;
      });
    });

    var dataSaver =
        Provider.of<MangaDexModel>(context, listen: false).dataSaver;

    _pages = Provider.of<MangaDexModel>(context, listen: false)
        .getChapterServer(widget.chapter)
        .then((server) {
      var chData = dataSaver ? widget.chapter.dataSaver : widget.chapter.data;

      List<ImageProvider> pages = chData.map((e) {
        var url = server + e;
        return CachedNetworkImageProvider(url);
      }).toList();
      return pages;
    });

    // Mark as read if not read
    if (!widget.chapter.read) {
      Provider.of<MangaDexModel>(context, listen: false)
          .setChapterRead(widget.chapter, true)
          .then((result) {
        if (result) {
          widget.manga.readChapters.add(widget.chapter.id);
        }
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _pages.then((pages) {
      pages.forEach((element) {
        precacheImage(element, context);
      });
    });
  }

  @override
  void dispose() {
    _scaleStateController.dispose();
    _pageController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _setReaderSettings(ReaderSettings settings) {
    setState(() {
      _settings = settings;
    });

    _settings.save();
  }

  void _onTapLeft() {
    if (_settings.rightToLeft) {
      if (_pageController.page! < widget.chapter.data.length - 1) {
        _pageController.jumpToPage(_pageController.page!.round() + 1);
      }
    } else if (_pageController.page! > 0) {
      _pageController.jumpToPage(_pageController.page!.round() - 1);
    }
  }

  void _onTapRight() {
    if (_settings.rightToLeft) {
      if (_pageController.page! > 0) {
        _pageController.jumpToPage(_pageController.page!.round() - 1);
      }
    } else if (_pageController.page! < widget.chapter.data.length - 1) {
      _pageController.jumpToPage(_pageController.page!.round() + 1);
    }
  }

  void _handlePhotoViewOnTapDown(BuildContext context, TapDownDetails details,
      PhotoViewControllerValue value) {
    _focusNode.requestFocus();

    var tapx = details.localPosition.dx;
    var tapwidth = context.size!.width / 2.5;

    if (tapx < tapwidth) {
      _onTapLeft();
    } else if (tapx > context.size!.width - tapwidth) {
      _onTapRight();
    }
  }

  void _handleKeyEvent(KeyEvent event) {
    if (event is KeyDownEvent) {
      if (event.physicalKey == PhysicalKeyboardKey.arrowLeft) {
        _onTapLeft();
      } else if (event.physicalKey == PhysicalKeyboardKey.arrowRight) {
        _onTapRight();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String title = '';

    if (widget.chapter.chapter != null) {
      title += 'Chapter ${widget.chapter.chapter!}';
    }

    if (widget.chapter.title != null) {
      title += ' - ${widget.chapter.title!}';
    }

    var platformIsMobile = Platform.isIOS || Platform.isAndroid;

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text('${widget.manga.title['en']!} - $title'),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.settings),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
              tooltip: 'Reader Settings',
            ),
          ),
        ],
      ),
      endDrawer: Drawer(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ActionChip(
                  avatar: Icon(Icons.height),
                  label:
                      Text(_settings.fitWidth ? 'Fill Screen' : 'Fit Height'),
                  onPressed: () {
                    _setReaderSettings(
                        _settings.copyWith(fitWidth: !_settings.fitWidth));

                    _scaleStateController.scaleState = _settings.fitWidth
                        ? PhotoViewScaleState.covering
                        : PhotoViewScaleState.initial;
                  }),
              const SizedBox(height: 10.0),
              ActionChip(
                  avatar: Icon(_settings.rightToLeft
                      ? Icons.arrow_back
                      : Icons.arrow_forward),
                  label: Text(_settings.rightToLeft
                      ? 'Right to Left'
                      : 'Left to Right'),
                  onPressed: () {
                    _setReaderSettings(_settings.copyWith(
                        rightToLeft: !_settings.rightToLeft));
                  }),
              const SizedBox(height: 10.0),
              ActionChip(
                  avatar: Icon(_settings.showProgressBar
                      ? Icons.donut_small
                      : Icons.donut_small_outlined),
                  label: Text('Progress Bar'),
                  onPressed: () {
                    _setReaderSettings(_settings.copyWith(
                        showProgressBar: !_settings.showProgressBar));
                  }),
              // const SizedBox(height: 10.0),
              // ActionChip(
              //     avatar: Icon(_settings.swipeToChangePage
              //         ? Icons.swipe
              //         : Icons.swipe_outlined),
              //     label: Text(_settings.swipeToChangePage
              //         ? 'Swipe to change page'
              //         : 'Tap to change page'),
              //     onPressed: () {
              //       _setReaderSettings(_settings.copyWith(
              //           swipeToChangePage: !_settings.swipeToChangePage));
              //     }),
            ],
          ),
        ),
      ),
      endDrawerEnableOpenDragGesture: false,
      body: FutureBuilder<List<ImageProvider>>(
        future: _pages,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return KeyboardListener(
              autofocus: true,
              focusNode: _focusNode,
              onKeyEvent: _handleKeyEvent,
              child: Container(
                child: PageView.builder(
                  reverse: _settings.rightToLeft,
                  scrollBehavior: ReaderScrollBehavior(),
                  scrollDirection: Axis.horizontal,
                  controller: _pageController,
                  itemCount: snapshot.data!.length,
                  onPageChanged: (int index) {
                    _focusNode.requestFocus();
                  },
                  itemBuilder: (BuildContext context, int index) {
                    ImageProvider imageProvider = snapshot.data![index];

                    return PhotoView(
                      imageProvider: imageProvider,
                      loadingBuilder: (context, progress) => Center(
                        child: Container(
                          width: 20.0,
                          height: 20.0,
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      backgroundDecoration: BoxDecoration(color: Colors.black),
                      customSize: MediaQuery.of(context).size,
                      enableRotation: false,
                      scaleStateController: _scaleStateController,
                      minScale: PhotoViewComputedScale.contained * 1.0,
                      maxScale: PhotoViewComputedScale.covered * 2.0,
                      initialScale: PhotoViewComputedScale.contained,
                      basePosition: Alignment.center,
                      onTapDown:
                          !platformIsMobile ? _handlePhotoViewOnTapDown : null,
                    );
                  },
                ),
              ),
            );
          } else if (snapshot.hasError) {
            ScaffoldMessenger.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(SnackBar(
                content: Text('${snapshot.error}'),
                backgroundColor: Colors.red,
              ));

            return Text('${snapshot.error}');
          }

          // By default, show a loading spinner.
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      bottomSheet: _settings.showProgressBar
          ? ProgressIndicator(
              reverse: _settings.rightToLeft,
              controller: _pageController,
              itemCount: widget.chapter.data.length,
              color: Theme.of(context).colorScheme.primary,
              onPageSelected: (index) {
                if (_pageController.hasClients) {
                  _pageController.animateToPage(
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
  ProgressIndicator({
    required this.controller,
    required this.itemCount,
    required this.onPageSelected,
    required this.reverse,
    this.color: Colors.white,
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
    } else if (controller.hasClients) {
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
          child: Container(
            height: _barHeight,
            child: InkWell(
              onTap: () => onPageSelected(index),
            ),
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    var sections = List<Widget>.generate(itemCount, _buildSection);

    return Container(
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        height: 30.0,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          stops: [0.0, 0.7],
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
