import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gagaku/src/ui.dart';
import 'package:gagaku/src/util.dart';
import 'package:photo_view/photo_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ReaderDirection {
  leftToRight,
  rightToLeft,
  topToBottom,
}

extension ReaderDirectionExt on ReaderDirection {
  Icon get icon => const [
        Icon(Icons.arrow_forward),
        Icon(Icons.arrow_back),
        Icon(Icons.arrow_downward),
      ].elementAt(this.index);

  String get formatted => const [
        'Left to Right',
        'Right to Left',
        'Top to Bottom',
      ].elementAt(this.index);

  static ReaderDirection parse(int index) {
    return ReaderDirection.values.elementAt(index);
  }
}

class ReaderPage {
  final ImageProvider provider;

  bool cached = false;

  ReaderPage({required this.provider});
}

class ReaderSettings {
  /// If true, the reader fits the page to widget width, otherwise
  /// it is contrained to widget height (default)
  final bool fitWidth;
  static const _fitWidthKey = 'reader.fitWidth';

  /// Reader direction
  final ReaderDirection direction;
  static const _directionKey = 'reader.direction';

  /// Displays progress bar if true (default false)
  final bool showProgressBar;
  static const _showProgressBarKey = 'reader.showProgressBar';

  /// Enable click/tap to turn page gesture
  final bool clickToTurn;
  static const _clickToTurnKey = 'reader.clickToTurn';

  /// Enable swipe gestures
  final bool swipeGestures;
  static const _swipeGesturesKey = 'reader.swipeGestures';

  /// The number of images/pages to preload
  final int precacheCount;
  static const _precacheCountKey = 'reader.precacheCount';

  ReaderSettings({
    this.fitWidth = false,
    this.direction = ReaderDirection.leftToRight,
    this.showProgressBar = false,
    this.clickToTurn = true,
    this.swipeGestures = true,
    this.precacheCount = 3,
  });

  ReaderSettings copyWith({
    bool? fitWidth,
    ReaderDirection? direction,
    bool? showProgressBar,
    bool? clickToTurn,
    bool? swipeGestures,
    int? precacheCount,
  }) {
    return ReaderSettings(
      fitWidth: fitWidth ?? this.fitWidth,
      direction: direction ?? this.direction,
      showProgressBar: showProgressBar ?? this.showProgressBar,
      clickToTurn: clickToTurn ?? this.clickToTurn,
      swipeGestures: swipeGestures ?? this.swipeGestures,
      precacheCount: precacheCount ?? this.precacheCount,
    );
  }

  static Future<ReaderSettings> load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool fitWidth = prefs.getBool(_fitWidthKey) ?? false;
    var direction =
        prefs.getInt(_directionKey) ?? ReaderDirection.leftToRight.index;
    bool showProgressBar = prefs.getBool(_showProgressBarKey) ?? false;
    bool clickToTurn =
        prefs.getBool(_clickToTurnKey) ?? DeviceContext.isDesktop()
            ? true
            : false;
    bool swipeGestures = prefs.getBool(_swipeGesturesKey) ?? true;
    int precacheCount = prefs.getInt(_precacheCountKey) ?? 3;

    return ReaderSettings(
      fitWidth: fitWidth,
      direction: ReaderDirectionExt.parse(direction),
      showProgressBar: showProgressBar,
      clickToTurn: clickToTurn,
      swipeGestures: swipeGestures,
      precacheCount: precacheCount,
    );
  }

  Future<void> save() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_fitWidthKey, fitWidth);
    await prefs.setInt(_directionKey, direction.index);
    await prefs.setBool(_showProgressBarKey, showProgressBar);
    await prefs.setBool(_clickToTurnKey, clickToTurn);
    await prefs.setBool(_swipeGesturesKey, swipeGestures);
    await prefs.setInt(_precacheCountKey, precacheCount);
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
  final VoidCallback? onLinkPressed;

  @override
  _ReaderWidgetState createState() => _ReaderWidgetState();
}

class _ReaderWidgetState extends State<ReaderWidget> {
  final FocusNode _focusNode = FocusNode();
  ReaderSettings _settings = ReaderSettings();

  final PageController _pageController = PageController(initialPage: 0);
  final PhotoViewScaleStateController _scaleStateController =
      PhotoViewScaleStateController();

  int get _getPrecacheCount =>
      _settings.precacheCount > 9 ? widget.pageCount : _settings.precacheCount;

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

      if (_pageController.page! % _settings.precacheCount ==
              _settings.precacheCount - 2 ||
          !widget.pages.elementAt(_pageController.page!.toInt()).cached) {
        widget.pages
            .skip(_pageController.page!.toInt())
            .skipWhile((page) => page.cached == true)
            .take(_getPrecacheCount)
            .forEach((element) {
          cachePage(element);
        });
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    widget.pages.take(_getPrecacheCount).forEach((element) {
      cachePage(element);
    });
  }

  void cachePage(ReaderPage page) {
    precacheImage(page.provider, context).then((value) {
      page.cached = true;
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
    switch (_settings.direction) {
      case ReaderDirection.leftToRight:
        if (_pageController.page! > 0) {
          _pageController.jumpToPage(_pageController.page!.toInt() - 1);
        }
        break;
      case ReaderDirection.rightToLeft:
        if (_pageController.page! < widget.pages.length - 1) {
          _pageController.jumpToPage(_pageController.page!.toInt() + 1);
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

  void _onTapRight() {
    switch (_settings.direction) {
      case ReaderDirection.leftToRight:
        if (_pageController.page! < widget.pages.length - 1) {
          _pageController.jumpToPage(_pageController.page!.toInt() + 1);
        } else {
          Navigator.of(context).pop();
        }
        break;
      case ReaderDirection.rightToLeft:
        if (_pageController.page! > 0) {
          _pageController.jumpToPage(_pageController.page!.toInt() - 1);
        }
        break;
      case ReaderDirection.topToBottom:
      default:
        // Do nothing
        break;
    }
  }

  void _onTapTop() {
    switch (_settings.direction) {
      case ReaderDirection.topToBottom:
        if (_pageController.page! > 0) {
          _pageController.jumpToPage(_pageController.page!.toInt() - 1);
        }
        break;
      case ReaderDirection.leftToRight:
      case ReaderDirection.rightToLeft:
      default:
        // Do nothing
        break;
    }
  }

  void _onTapBottom() {
    switch (_settings.direction) {
      case ReaderDirection.topToBottom:
        if (_pageController.page! < widget.pages.length - 1) {
          _pageController.jumpToPage(_pageController.page!.toInt() + 1);
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

  void _handlePhotoViewOnTap(BuildContext context, TapUpDetails details,
      PhotoViewControllerValue value) {
    _focusNode.requestFocus();

    var taploc = details.localPosition.dx;
    var viewport = context.size!.width;

    if (_settings.direction == ReaderDirection.topToBottom) {
      taploc = details.localPosition.dy;
      viewport = context.size!.height;
    }

    var tapmargin = viewport / 2.5;

    if (taploc < tapmargin) {
      if (_settings.direction == ReaderDirection.topToBottom) {
        _onTapTop();
      } else {
        _onTapLeft();
      }
    } else if (taploc > viewport - tapmargin) {
      if (_settings.direction == ReaderDirection.topToBottom) {
        _onTapBottom();
      } else {
        _onTapRight();
      }
    }
  }

  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    if (event is KeyDownEvent) {
      if (event.physicalKey == PhysicalKeyboardKey.arrowLeft) {
        _onTapLeft();
        return KeyEventResult.handled;
      } else if (event.physicalKey == PhysicalKeyboardKey.arrowRight) {
        _onTapRight();
        return KeyEventResult.handled;
      } else if (event.physicalKey == PhysicalKeyboardKey.arrowUp) {
        _onTapTop();
        return KeyEventResult.handled;
      } else if (event.physicalKey == PhysicalKeyboardKey.arrowDown) {
        _onTapBottom();
        return KeyEventResult.handled;
      }
    }

    return KeyEventResult.ignored;
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: (_pageController.hasClients &&
                            _pageController.page!.toInt() > 0)
                        ? () {
                            _pageController
                                .jumpToPage(_pageController.page!.toInt() - 1);
                          }
                        : null,
                    child: Text('Previous Page'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
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
                  const SizedBox(
                    width: 10,
                  ),
                  OutlinedButton(
                    onPressed: (_pageController.hasClients &&
                            _pageController.page!.toInt() <
                                widget.pageCount - 1)
                        ? () {
                            _pageController
                                .jumpToPage(_pageController.page!.toInt() + 1);
                          }
                        : null,
                    child: Text('Next Page'),
                  ),
                ],
              ),
              const Divider(),
              Text(
                'Reader Settings',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
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
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  for (final dir in ReaderDirection.values)
                    ChoiceChip(
                      avatar: dir.icon,
                      label: Text(dir.formatted),
                      selected: _settings.direction == dir,
                      onSelected: (value) {
                        if (value) {
                          _setReaderSettings(
                              _settings.copyWith(direction: dir));
                        }
                      },
                    ),
                ],
              ),
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
              const SizedBox(height: 10.0),
              ActionChip(
                  avatar: Icon(
                    Icons.swipe,
                    color: _settings.swipeGestures
                        ? theme.iconTheme.color
                        : theme.chipTheme.disabledColor,
                  ),
                  label: Text('Swipe Gestures'),
                  onPressed: () {
                    _setReaderSettings(_settings.copyWith(
                        swipeGestures: !_settings.swipeGestures));
                  }),
              const SizedBox(height: 10.0),
              ActionChip(
                  avatar: Icon(
                    Icons.mouse,
                    color: _settings.clickToTurn
                        ? theme.iconTheme.color
                        : theme.chipTheme.disabledColor,
                  ),
                  label: Text('Click/Tap to Turn Page'),
                  onPressed: () {
                    _setReaderSettings(_settings.copyWith(
                        clickToTurn: !_settings.clickToTurn));
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Page Preload'),
                  const SizedBox(
                    width: 10,
                  ),
                  DropdownButton<int>(
                    value: _settings.precacheCount,
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (int? value) {
                      if (value != null) {
                        _setReaderSettings(
                            _settings.copyWith(precacheCount: value));
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
        focusNode: _focusNode,
        onKeyEvent: _handleKeyEvent,
        child: Container(
          child: PageView.builder(
            allowImplicitScrolling: true,
            reverse: _settings.direction == ReaderDirection.rightToLeft,
            physics: !_settings.swipeGestures
                ? NeverScrollableScrollPhysics()
                : null,
            scrollBehavior: MouseTouchScrollBehavior(),
            scrollDirection: _settings.direction == ReaderDirection.topToBottom
                ? Axis.vertical
                : Axis.horizontal,
            controller: _pageController,
            itemCount: widget.pageCount,
            onPageChanged: (int index) {
              _focusNode.requestFocus();
            },
            itemBuilder: (BuildContext context, int index) {
              var page = widget.pages.elementAt(index);

              return PhotoView(
                imageProvider: page.provider,
                backgroundDecoration: BoxDecoration(color: Colors.black),
                customSize: MediaQuery.of(context).size,
                enableRotation: false,
                scaleStateController: _scaleStateController,
                minScale: PhotoViewComputedScale.contained * 1.0,
                maxScale: PhotoViewComputedScale.covered * 2.0,
                initialScale: PhotoViewComputedScale.contained,
                basePosition: Alignment.center,
                onTapUp: _settings.clickToTurn ? _handlePhotoViewOnTap : null,
                loadingBuilder: (context, event) => Styles.buildCenterSpinner(),
              );
            },
          ),
        ),
      ),
      bottomSheet: _settings.showProgressBar
          ? ProgressIndicator(
              reverse: _settings.direction == ReaderDirection.rightToLeft,
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
