import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gagaku/src/mangadex/api.dart';
import 'package:gagaku/src/mangadex/widgets.dart';
import 'package:provider/provider.dart';

class MangaDexLibraryView extends StatefulWidget {
  const MangaDexLibraryView({Key? key}) : super(key: key);

  @override
  _MangaDexLibraryViewState createState() => _MangaDexLibraryViewState();
}

class _MangaDexLibraryViewState extends State<MangaDexLibraryView> {
  var _scrollController = ScrollController();
  var _type = MangaReadingStatus.reading;
  var _mangaOffset = 0;
  var _totalResultsLength = 0;

  //List<String> _results = [];
  Set<Manga> _cachedResults = Set<Manga>();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels != 0) {
          if (_cachedResults.length ==
              _mangaOffset + MangaDexEndpoints.apiQueryLimit) {
            setState(() {
              _mangaOffset += MangaDexEndpoints.apiQueryLimit;
            });
          }
        }
      }
    });
  }

  Future<Iterable<Manga>> _fetchLibraryFeed(
      MangaDexModel model, MangaReadingStatus type, int offset) async {
    var library = await model.fetchUserLibrary();

    if (library == null) {
      // If no library, return empty
      return [];
    }

    var results = library.entries
        .where((element) => element.value == type)
        .map((e) => e.key)
        .toList();

    _totalResultsLength = results.length;

    var range = min(results.length, offset + MangaDexEndpoints.apiQueryLimit);

    var mangas = await model.fetchManga(results.getRange(offset, range));

    _cachedResults.addAll(mangas);

    return _cachedResults;
  }

  void _selectType(MangaReadingStatus type) {
    setState(() {
      if (_type != type) {
        _type = type;
        _cachedResults.clear();
        _mangaOffset = 0;
        _totalResultsLength = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer<MangaDexModel>(
          builder: (context, mdx, child) {
            return FutureBuilder<Iterable<Manga>>(
              future: _fetchLibraryFeed(mdx, _type, _mangaOffset),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ScrollConfiguration(
                    behavior:
                        ScrollConfiguration.of(context).copyWith(dragDevices: {
                      PointerDeviceKind.touch,
                      PointerDeviceKind.mouse,
                    }),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 10.0),
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              ...MangaReadingStatus.values
                                  .skip(1)
                                  .map((e) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        child: ChoiceChip(
                                          label: Text(MangaDexStrings
                                              .readingStatus
                                              .elementAt(e.index)),
                                          labelStyle: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                          selected: _type == e,
                                          onSelected: (value) {
                                            _selectType(e);
                                          },
                                        ),
                                      ))
                                  .toList()
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 10.0),
                          child: Row(
                            children: [
                              Text(
                                '$_totalResultsLength Mangas',
                                style: TextStyle(fontSize: 24),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: GridView.extent(
                            controller: _scrollController,
                            physics: const AlwaysScrollableScrollPhysics(),
                            restorationId: 'manga_library_grid_offset',
                            maxCrossAxisExtent: 300,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            padding: const EdgeInsets.all(8),
                            childAspectRatio: 0.7,
                            children: snapshot.data!
                                .map((manga) => GridMangaItem(manga: manga))
                                .toList(),
                          ),
                        ),
                      ],
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
            );
          },
        ),
      ),
    );
  }
}