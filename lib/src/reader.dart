import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gagaku/src/ui.dart';
import 'package:gagaku/src/util.dart';
import 'package:photo_view/photo_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef LinkPressedCallback = void Function();

class ReaderPage {
  final String url;
  final String key;

  const ReaderPage({required this.url, required this.key});
}

class ReaderSettings {
  /// If true, the reader fits the page to widget width, otherwise
  /// it is contrained to widget height (default)
  final bool fitWidth;
  static const _fitWidthKey = 'reader.fitWidth';

  /// If true, page increments right to left, otherwise
  /// it increments left to right (default)
  final bool rightToLeft;
  static const _rightToLeftKey = 'reader.rightToLeft';

  /// Displays progress bar if true (default false)
  final bool showProgressBar;
  static const _showProgressBarKey = 'reader.showProgressBar';

  /// Whether swiping left or right changes the page (default false)
  // final bool swipeToChangePage;
  // static const _swipeToChangePage = 'reader.swipeToChangePage';

  ReaderSettings({
    this.fitWidth = false,
    this.rightToLeft = false,
    this.showProgressBar = false,
    // this.swipeToChangePage = false,
  });

  ReaderSettings copyWith({
    bool? fitWidth,
    bool? rightToLeft,
    bool? showProgressBar,
    bool? swipeToChangePage,
  }) {
    return ReaderSettings(
      fitWidth: fitWidth ?? this.fitWidth,
      rightToLeft: rightToLeft ?? this.rightToLeft,
      showProgressBar: showProgressBar ?? this.showProgressBar,
      // swipeToChangePage: swipeToChangePage ?? this.swipeToChangePage,
    );
  }

  static Future<ReaderSettings> load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool fitWidth = prefs.getBool(_fitWidthKey) ?? false;
    bool rightToLeft = prefs.getBool(_rightToLeftKey) ?? false;
    bool showProgressBar = prefs.getBool(_showProgressBarKey) ?? false;
    // bool swipeToChangePage = prefs.getBool(_swipeToChangePage) ?? false;

    return ReaderSettings(
      fitWidth: fitWidth,
      rightToLeft: rightToLeft,
      showProgressBar: showProgressBar,
      // swipeToChangePage: swipeToChangePage,
    );
  }

  Future<void> save() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_fitWidthKey, fitWidth);
    await prefs.setBool(_rightToLeftKey, rightToLeft);
    await prefs.setBool(_showProgressBarKey, showProgressBar);
    // await prefs.setBool(_swipeToChangePage, swipeToChangePage);
  }
}

class ReaderWidget extends StatefulWidget {
  const ReaderWidget({
    Key? key,
    required this.pages,
    required this.pageCount,
    required this.title,
    this.link,
    this.onLinkPressed,
  }) : super(key: key);

  final Iterable<ReaderPage> pages;
  final int pageCount;
  final String title;
  final Widget? link;
  final LinkPressedCallback? onLinkPressed;

  @override
  _ReaderWidgetState createState() => _ReaderWidgetState();
}

class _ReaderWidgetState extends State<ReaderWidget> {
  final FocusNode _focusNode = FocusNode();
  ReaderSettings _settings = ReaderSettings();

  final PageController _pageController = PageController(initialPage: 0);
  final PhotoViewScaleStateController _scaleStateController =
      PhotoViewScaleStateController();

  @override
  void initState() {
    super.initState();

    ReaderSettings.load().then((settings) {
      setState(() {
        _settings = settings;
      });
    });

    _pageController.addListener(() {
      setState(() {});
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
      if (_pageController.page! < widget.pages.length - 1) {
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
    } else if (_pageController.page! < widget.pages.length - 1) {
      _pageController.jumpToPage(_pageController.page!.round() + 1);
    }
  }

  void _handlePhotoViewOnTap(BuildContext context, TapUpDetails details,
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
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text(widget.title),
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
              (widget.link != null
                  ? TextButton(
                      onPressed: () {
                        Navigator.of(context)
                          ..pop()
                          ..pop();

                        if (widget.onLinkPressed != null) {
                          widget.onLinkPressed!();
                        }
                      },
                      child: widget.link!)
                  : SizedBox.shrink()),
              DropdownButton<int>(
                value: (_pageController.hasClients
                    ? _pageController.page!.toInt()
                    : _pageController.initialPage),
                icon: const Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: theme.colorScheme.primary),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (int? index) {
                  if (_pageController.hasClients && index != null) {
                    _pageController.jumpToPage(index);
                  }
                },
                items: List<DropdownMenuItem<int>>.generate(
                    widget.pageCount,
                    (int index) => DropdownMenuItem<int>(
                        value: index, child: Text((index + 1).toString()))),
              ),
              const Divider(),
              const SizedBox(height: 10.0),
              ActionChip(
                  avatar: Icon(
                      _settings.fitWidth ? Icons.fit_screen : Icons.height),
                  label: Text(_settings.fitWidth ? 'Fit Screen' : 'Fit Height'),
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
            ],
          ),
        ),
      ),
      endDrawerEnableOpenDragGesture: false,
      body: KeyboardListener(
        autofocus: true,
        focusNode: _focusNode,
        onKeyEvent: _handleKeyEvent,
        child: Container(
          child: PageView.builder(
            reverse: _settings.rightToLeft,
            scrollBehavior: MouseTouchScrollBehavior(),
            scrollDirection: Axis.horizontal,
            controller: _pageController,
            itemCount: widget.pageCount,
            onPageChanged: (int index) {
              _focusNode.requestFocus();
            },
            itemBuilder: (BuildContext context, int index) {
              var page = widget.pages.elementAt(index);

              return CachedNetworkImage(
                imageUrl: page.url,
                cacheKey: page.key,
                placeholder: (context, url) => Styles.buildCenterSpinner(),
                imageBuilder: (context, provider) {
                  return PhotoView(
                    imageProvider: provider,
                    // loadingBuilder: (context, progress) => Center(
                    //   child: Column(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       Text(
                    //           'Downloading pages... ${progress != null ? '${progress.cumulativeBytesLoaded} / ${progress.expectedTotalBytes!} bytes' : ''}'),
                    //       SizedBox(
                    //         height: 10,
                    //       ),
                    //       Container(
                    //         width: 20.0,
                    //         height: 20.0,
                    //         child: CircularProgressIndicator(
                    //           value: progress == null
                    //               ? null
                    //               : progress.cumulativeBytesLoaded /
                    //                   progress.expectedTotalBytes!,
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    backgroundDecoration: BoxDecoration(color: Colors.black),
                    customSize: MediaQuery.of(context).size,
                    enableRotation: false,
                    scaleStateController: _scaleStateController,
                    minScale: PhotoViewComputedScale.contained * 1.0,
                    maxScale: PhotoViewComputedScale.covered * 2.0,
                    initialScale: PhotoViewComputedScale.contained,
                    basePosition: Alignment.center,
                    onTapUp: DeviceContext.isDesktop()
                        ? _handlePhotoViewOnTap
                        : null,
                  );
                },
              );
            },
          ),
        ),
      ),
      bottomSheet: _settings.showProgressBar
          ? ProgressIndicator(
              reverse: _settings.rightToLeft,
              controller: _pageController,
              itemCount: widget.pages.length,
              color: theme.colorScheme.primary,
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
