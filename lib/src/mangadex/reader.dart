import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gagaku/src/mangadex/api.dart';
import 'package:gagaku/src/reader.dart';
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

class MangaDexReaderWidget extends StatefulWidget {
  const MangaDexReaderWidget(
      {Key? key, required this.chapter, required this.manga})
      : super(key: key);

  final Chapter chapter;
  final Manga manga;

  @override
  _MangaDexReaderState createState() => _MangaDexReaderState();
}

class _MangaDexReaderState extends State<MangaDexReaderWidget>
    with TickerProviderStateMixin {
  ReaderSettings _settings = ReaderSettings();

  late TabController _tabController;
  late Future<List<Image>> _pages;

  var _currentPage = 0;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
        initialIndex: 0, length: widget.chapter.data.length, vsync: this);

    ReaderSettings.load().then((settings) {
      setState(() {
        _settings = settings;
      });

      _setTabToCurrentPage(false);
    });

    var dataSaver =
        Provider.of<MangaDexModel>(context, listen: false).dataSaver;

    _pages = Provider.of<MangaDexModel>(context, listen: false)
        .getChapterServer(widget.chapter)
        .then((server) {
      var chData = dataSaver ? widget.chapter.dataSaver : widget.chapter.data;

      List<Image> pages = chData.map((e) {
        var url = server + e;
        return Image(
          image: CachedNetworkImageProvider(url),
          fit: BoxFit.cover,
        );
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
        precacheImage(element.image, context);
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _setReaderSettings(ReaderSettings settings) {
    setState(() {
      _settings = settings;
    });

    _setTabToCurrentPage(false);
    _settings.save();
  }

  void _setTabToCurrentPage([bool animate = true]) {
    var index = _currentPage;

    if (_settings.rightToLeft) {
      index = (widget.chapter.data.length - 1) - index;
    }

    if (animate) {
      _tabController.animateTo(index);
    } else {
      _tabController.index = index;
    }
  }

  void _changePage(int page) {
    setState(() {
      _currentPage = page;
    });

    _setTabToCurrentPage();
  }

  void _onTapLeft() {
    if (_settings.rightToLeft) {
      _changePage(_currentPage + 1);
    } else {
      if (_currentPage > 0) {
        _changePage(_currentPage - 1);
      }
    }
  }

  void _onTapRight() {
    if (_settings.rightToLeft) {
      if (_currentPage > 0) {
        _changePage(_currentPage - 1);
      }
    } else {
      _changePage(_currentPage + 1);
    }
  }

  void _handleOnTapDown(TapDownDetails details) {
    var halfwidth = context.size!.width / 2;
    var tapx = details.localPosition.dx;

    if (tapx < halfwidth) {
      _onTapLeft();
    } else {
      _onTapRight();
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

    var pageTabs = List<Tab>.generate(
        widget.chapter.data.length,
        (int index) => Tab(
              text: (index + 1).toString(),
            ));

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
                  label: Text(_settings.fitWidth ? 'Fit Width' : 'Fit Height'),
                  onPressed: () {
                    _setReaderSettings(
                        _settings.copyWith(fitWidth: !_settings.fitWidth));
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
      body: FutureBuilder<List<Image>>(
        future: _pages,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var imageViewer = InteractiveViewer(
                constrained: !_settings.fitWidth,
                minScale: 0.1,
                maxScale: 4.0,
                child: snapshot.data!.elementAt(_currentPage));

            return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTapDown: _handleOnTapDown,
                child: Container(child: Center(child: imageViewer)));
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
      bottomNavigationBar: _settings.showProgressBar
          ? TabBar(
              indicatorColor: Theme.of(context).colorScheme.primary,
              controller: _tabController,
              isScrollable: false,
              onTap: (index) {
                if (_settings.rightToLeft) {
                  index = (widget.chapter.data.length - 1) - index;
                }

                setState(() {
                  _currentPage = index;
                });
              },
              tabs: [...(_settings.rightToLeft ? pageTabs.reversed : pageTabs)],
            )
          : null,
    );
  }
}
