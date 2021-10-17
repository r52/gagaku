import 'dart:async';

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
        _searchOffset = 0;
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
                  title: DropdownButton<FilterOrder>(
                    value: _filter.order,
                    icon: const Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    underline: Container(
                      height: 2,
                      color: Colors.deepOrangeAccent,
                    ),
                    onChanged: (FilterOrder? order) async {
                      if (order != null) {
                        setState(() {
                          _filter.order = order;
                          _searchOffset = 0;
                          _results.clear();
                        });
                      }
                    },
                    items: List<DropdownMenuItem<FilterOrder>>.generate(
                      FilterOrder.values.length,
                      (int index) => DropdownMenuItem<FilterOrder>(
                        value: FilterOrder.values.elementAt(index),
                        child: Text(
                          FilterOrder.values.elementAt(index).formatted,
                        ),
                      ),
                    ),
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
                            onPressed: () async {
                              final result = await Navigator.push<MangaFilters>(
                                  context,
                                  Styles.buildSlideTransitionRoute((context,
                                          animation, secondaryAnimation) =>
                                      _MangaDexFilterWidget(
                                        filter: _filter.copy(),
                                      )));

                              if (result != null) {
                                setState(() {
                                  _filter = result;
                                  _searchOffset = 0;
                                  _results.clear();
                                });
                              }
                            },
                            icon: Icon(Icons.filter_list),
                            label: Text('Filters'),
                          ),
                        ],
                      )),
                    ),
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

class _MangaDexFilterWidget extends StatefulWidget {
  const _MangaDexFilterWidget({
    Key? key,
    required this.filter,
  }) : super(key: key);

  final MangaFilters filter;

  @override
  _MangaDexFilterWidgetState createState() => _MangaDexFilterWidgetState();
}

class _MangaDexFilterWidgetState extends State<_MangaDexFilterWidget> {
  late Future<Iterable<Tag>> _tags;

  @override
  void initState() {
    super.initState();

    _tags = Provider.of<MangaDexModel>(context, listen: false).getTagList();
  }

  List<Widget> _buildSection(
      {required Widget header, required List<Widget> children}) {
    return [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: header,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Wrap(
          children: children,
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final headingStyle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context, null);
          },
        ),
        title: Text('Search Filters'),
        actions: [
          ButtonBar(
            children: [
              Tooltip(
                message: 'Reset Filters',
                child: ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      widget.filter.includedTags.clear();
                      widget.filter.excludedTags.clear();
                      widget.filter.contentRating.clear();
                      widget.filter.publicationDemographic.clear();
                      widget.filter.status.clear();
                    });
                  },
                  icon: Icon(Icons.clear_all),
                  label: Text('Reset Filters'),
                ),
              ),
              Tooltip(
                message: 'Apply Filters',
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context, widget.filter);
                  },
                  icon: Icon(Icons.filter_list),
                  label: Text('Apply Filters'),
                ),
              ),
            ],
          )
        ],
      ),
      body: FutureBuilder<Iterable<Tag>>(
        future: _tags,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final tags = snapshot.data!;

            final selectedFilters = [
              ...widget.filter.includedTags
                  .map((e) => Padding(
                        padding: const EdgeInsets.all(2),
                        child: InputChip(
                          label: Text(e.name['en']!),
                          avatar: Icon(Icons.add),
                          onDeleted: () {
                            setState(() {
                              widget.filter.includedTags.remove(e);
                            });
                          },
                          backgroundColor: Colors.deepOrangeAccent,
                        ),
                      ))
                  .toList(),
              ...widget.filter.excludedTags
                  .map((e) => Padding(
                        padding: const EdgeInsets.all(2),
                        child: InputChip(
                          label: Text(e.name['en']!),
                          avatar: Icon(Icons.remove),
                          onDeleted: () {
                            setState(() {
                              widget.filter.excludedTags.remove(e);
                            });
                          },
                          backgroundColor: theme.primaryColor,
                        ),
                      ))
                  .toList()
            ];

            return SafeArea(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      'Selected Tag Filters',
                      style: headingStyle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Wrap(
                      children: selectedFilters.isNotEmpty
                          ? selectedFilters
                          : [InputChip(label: Text('None'))],
                    ),
                  ),
                  const Divider(),
                  // ContentRating
                  ..._buildSection(
                    header: Text(
                      'Content Rating',
                      style: headingStyle,
                    ),
                    children: ContentRating.values
                        .map((e) => Padding(
                              padding: const EdgeInsets.all(2),
                              child: FilterChip(
                                label: Text(e.formatted),
                                selectedColor: Colors.deepOrangeAccent,
                                selected:
                                    widget.filter.contentRating.contains(e),
                                onSelected: (bool value) {
                                  setState(() {
                                    if (value) {
                                      widget.filter.contentRating.add(e);
                                    } else {
                                      widget.filter.contentRating.remove(e);
                                    }
                                  });
                                },
                              ),
                            ))
                        .toList(),
                  ),
                  // Demographic
                  ..._buildSection(
                    header: Text(
                      'Demographic',
                      style: headingStyle,
                    ),
                    children: MangaDemographic.values
                        .map((e) => Padding(
                            padding: const EdgeInsets.all(2),
                            child: FilterChip(
                              label: Text(e.formatted),
                              selectedColor: Colors.deepOrangeAccent,
                              selected: widget.filter.publicationDemographic
                                  .contains(e),
                              onSelected: (bool value) {
                                setState(() {
                                  if (value) {
                                    widget.filter.publicationDemographic.add(e);
                                  } else {
                                    widget.filter.publicationDemographic
                                        .remove(e);
                                  }
                                });
                              },
                            )))
                        .toList(),
                  ),
                  // Pub status
                  ..._buildSection(
                    header: Text(
                      'Publication Status',
                      style: headingStyle,
                    ),
                    children: MangaStatus.values
                        .skip(1)
                        .map((e) => Padding(
                              padding: const EdgeInsets.all(2),
                              child: FilterChip(
                                label: Text(e.formatted),
                                selectedColor: Colors.deepOrangeAccent,
                                selected: widget.filter.status.contains(e),
                                onSelected: (bool value) {
                                  setState(() {
                                    if (value) {
                                      widget.filter.status.add(e);
                                    } else {
                                      widget.filter.status.remove(e);
                                    }
                                  });
                                },
                              ),
                            ))
                        .toList(),
                  ),
                  // Tags
                  for (final group in TagGroup.values) ...[
                    ..._buildSection(
                      header: Text(
                        group.formatted,
                        style: headingStyle,
                      ),
                      children: tags
                          .where((element) => element.group == group)
                          .map((e) => Padding(
                                padding: const EdgeInsets.all(2),
                                child: TriStateChip(
                                  label: Text(e.name['en']!),
                                  selectedColor: Colors.deepOrangeAccent,
                                  unselectedColor: theme.primaryColor,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      switch (value) {
                                        case null:
                                          widget.filter.includedTags.remove(e);
                                          widget.filter.excludedTags.remove(e);
                                          break;
                                        case true:
                                          widget.filter.includedTags.add(e);
                                          widget.filter.excludedTags.remove(e);
                                          break;
                                        case false:
                                          widget.filter.excludedTags.add(e);
                                          widget.filter.includedTags.remove(e);
                                          break;
                                      }
                                    });
                                  },
                                  value: () {
                                    if (widget.filter.includedTags
                                        .contains(e)) {
                                      return true;
                                    }

                                    if (widget.filter.excludedTags
                                        .contains(e)) {
                                      return false;
                                    }

                                    return null;
                                  }(),
                                ),
                              ))
                          .toList(),
                    ),
                  ]
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

          return Styles.buildCenterSpinner();
        },
      ),
    );
  }
}
