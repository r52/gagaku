import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gagaku/src/mangadex/api.dart';
import 'package:gagaku/src/mangadex/types.dart';
import 'package:gagaku/src/mangadex/widgets.dart';
import 'package:gagaku/src/ui.dart';
import 'package:provider/provider.dart';

Route createMangaDexSearchRoute() {
  return Styles.buildSlideTransitionRoute(
      (context, animation, secondaryAnimation) => MangaDexSearchWidget());
}

class MangaDexSearchWidget extends StatefulWidget {
  const MangaDexSearchWidget({Key? key}) : super(key: key);

  @override
  _MangaDexSearchWidgetState createState() => _MangaDexSearchWidgetState();
}

class _MangaDexSearchWidgetState extends State<MangaDexSearchWidget> {
  Timer? _debounce;

  var _searchOffset = 0;
  String _searchTerm = '';
  Set<Manga> _results = Set<Manga>();
  MangaFilters _filter = MangaFilters();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  Future<Iterable<Manga>> _searchManga(MangaDexModel model, String searchTerm,
      MangaFilters filter, int offset) async {
    // if (searchTerm.isEmpty) {
    //   return [];
    // }

    var manga = await model.searchManga(searchTerm,
        filter: filter, offset: offset, existing: _results);
    _results.addAll(manga);

    return _results;
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 750), () {
      setState(() {
        _searchTerm = query;
        _results.clear();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MangaDexModel>(
        builder: (context, mdx, child) {
          return FutureBuilder<Iterable<Manga>>(
            future: _searchManga(mdx, _searchTerm, _filter, _searchOffset),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return MangaListWidget(
                  items: snapshot.data!,
                  title: Text(
                    'Results',
                    style: TextStyle(fontSize: 24),
                  ),
                  defaultView: MangaListView.detailed,
                  onAtEdge: () {
                    if (_results.length ==
                        _searchOffset + MangaDexEndpoints.apiSearchLimit) {
                      setState(() {
                        _searchOffset += MangaDexEndpoints.apiSearchLimit;
                      });
                    }
                  },
                  leading: [
                    SliverAppBar(
                      pinned: true,
                      snap: false,
                      floating: false,
                      expandedHeight: 80.0,
                      flexibleSpace: FlexibleSpaceBar(
                          title: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              autofocus: true,
                              onChanged: _onSearchChanged,
                              decoration: InputDecoration(
                                icon: Icon(Icons.search),
                                hintText: 'Search MangaDex...',
                              ),
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.filter_list),
                            label: Text('Filters'),
                          ),
                        ],
                      )),
                    ),
                    // TODO search filters?
                    // const SliverToBoxAdapter(
                    //   child: SizedBox(
                    //     height: 50,
                    //     child: Center(
                    //       child: Text('TODO'),
                    //     ),
                    //   ),
                    // ),
                  ],
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

              return Styles.buildCenterSpinner();
            },
          );
        },
      ),
    );
  }
}
