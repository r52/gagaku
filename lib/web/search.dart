import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/util/infinite_scroll.dart';
import 'package:gagaku/util/ui.dart';
import 'package:gagaku/util/util.dart';
import 'package:gagaku/web/model/model.dart';
import 'package:gagaku/web/model/types.dart';
import 'package:gagaku/web/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search.g.dart';

@Riverpod(keepAlive: true)
class _SearchHistory extends _$SearchHistory {
  @override
  List<String> build() => [];

  @override
  set state(List<String> newState) => super.state = newState;
  List<String> update(List<String> Function(List<String> state) cb) =>
      state = cb(state);
}

@RoutePage()
class ExtensionSearchPage extends StatelessWidget {
  const ExtensionSearchPage({super.key, this.initialSource, this.query});

  final WebSourceInfo? initialSource;
  final SearchQuery? query;

  @override
  Widget build(BuildContext context) {
    if (initialSource != null &&
        initialSource!.hasCapability(SourceIntents.mangaSearch)) {
      return ExtensionSearchWidget(initialSource: initialSource!, query: query);
    }

    return DataProviderWhenWidget(
      provider: extensionInfoListProvider,
      errorBuilder: (context, child, _, _) => Scaffold(body: child),
      builder: (context, extensions) {
        final firstSearchable = extensions.values.firstWhereOrNull(
          (ext) => ext.hasCapability(SourceIntents.mangaSearch),
        );

        if (firstSearchable == null) {
          return Scaffold(
            appBar: AppBar(
              title: Text(t.webSources.sourceSearch),
              leading: AutoLeadingButton(),
            ),
            body: Center(child: Text(t.webSources.noSearchableSourcesWarning)),
          );
        }

        return ExtensionSearchWidget(
          initialSource: firstSearchable,
          query: query,
        );
      },
    );
  }
}

class ExtensionSearchWidget extends StatefulHookConsumerWidget {
  const ExtensionSearchWidget({
    super.key,
    required this.initialSource,
    this.query,
  });

  final WebSourceInfo initialSource;
  final SearchQuery? query;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ExtensionSearchWidgetState();
}

class _ExtensionSearchWidgetState extends ConsumerState<ExtensionSearchWidget> {
  late WebSourceInfo source;
  Map<String, dynamic>? metadata = {'page': 1};
  SearchQuery? query;

  late final _pagingController = GagakuPagingController<dynamic, HistoryLink>(
    getNextPageKey:
        (state) => state.keys?.last == null ? {'page': 1} : metadata,
    fetchPage: (pageKey) async {
      if (query == null || query!.isEmpty) {
        return PageResultsMetaData([]);
      }

      final results = await ref
          .read(extensionSourceProvider(source.id).notifier)
          .searchManga(query!, metadata);

      final m = results.items.map(
        (e) => HistoryLink.fromSearchReultItem(source, e),
      );

      metadata = results.metadata;

      return PageResultsMetaData(m.toList());
    },
    getIsLastPage: (_, _) => metadata == null,
    refresh: () async {
      metadata = {'page': 1};
    },
  );

  @override
  void initState() {
    source = widget.initialSource;
    query = widget.query;
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tr = context.t;
    final nav = Navigator.of(context);
    final theme = Theme.of(context);
    final controller = useSearchController();

    useEffect(() {
      if (widget.query != null && widget.query!.title.isNotEmpty) {
        controller.text = widget.query!.title;
      }
      return null;
    }, [widget.query]);

    return Scaffold(
      body: WebMangaListWidget(
        physics: const AlwaysScrollableScrollPhysics(),
        showToggle: false,
        title: DataProviderWhenWidget(
          provider: extensionInfoListProvider,
          errorBuilder:
              (context, defaultChild, error, stacktrace) => Tooltip(
                message: tr.webSources.loadInstalledSourcesError,
                child: Icon(Icons.error),
              ),
          builder:
              (context, extensions) => HookBuilder(
                builder: (context) {
                  final searchExtensions = useMemoized(
                    () => Map.fromEntries(
                      extensions.entries.where(
                        (e) => e.value.hasCapability(SourceIntents.mangaSearch),
                      ),
                    ),
                    [extensions],
                  );

                  return DropdownMenu<WebSourceInfo>(
                    initialSelection: searchExtensions[source.id],
                    width: 200,
                    requestFocusOnTap: false,
                    enableSearch: false,
                    enableFilter: false,
                    dropdownMenuEntries:
                        searchExtensions.values
                            .map(
                              (opt) => DropdownMenuEntry(
                                value: opt,
                                label: opt.name,
                              ),
                            )
                            .toList(),
                    onSelected: (WebSourceInfo? opt) {
                      if (opt != null) {
                        setState(() {
                          source = opt;
                          query = query?.copyWith(filters: []);
                        });
                        _pagingController.refresh();
                      }
                    },
                  );
                },
              ),
        ),
        leading: [
          SliverAppBar(
            leading: AutoLeadingButton(),
            pinned: true,
            snap: false,
            floating: false,
            expandedHeight: 80.0,
            title: SearchAnchor(
              searchController: controller,
              isFullScreen: false,
              viewConstraints: BoxConstraints(maxHeight: 400),
              builder: (context, controller) {
                return SearchBar(
                  controller: controller,
                  hintText: tr.search.arg(arg: source.name),
                  onTap: () {
                    controller.openView();
                  },
                  onTapOutside: (event) {
                    unfocusSearchBar();
                  },
                  onSubmitted: (value) {
                    final term = value.trim();
                    if (term.isNotEmpty) {
                      final history = ref.read(_searchHistoryProvider);
                      ref.read(_searchHistoryProvider.notifier).state =
                          {term, ...history}.take(5).toList();
                    }

                    if (controller.isOpen) {
                      controller.closeView(term);
                    }

                    unfocusSearchBar();

                    setState(() {
                      query =
                          query != null
                              ? query!.copyWith(title: term.toLowerCase())
                              : SearchQuery(title: term.toLowerCase());
                    });
                    _pagingController.refresh();
                  },
                  trailing: <Widget>[
                    Tooltip(
                      message: tr.search.filters,
                      child: IconButton(
                        onPressed: () async {
                          final result = await nav
                              .push<List<SearchFilterValue>>(
                                SlideTransitionRouteBuilder(
                                  pageBuilder:
                                      (
                                        context,
                                        animation,
                                        secondaryAnimation,
                                      ) => _ExtensionFilterWidget(
                                        source: source,
                                        query: query,
                                      ),
                                ),
                              );

                          if (result != null) {
                            setState(() {
                              query =
                                  query != null
                                      ? query!.copyWith(filters: result)
                                      : SearchQuery(title: '', filters: result);
                            });
                            _pagingController.refresh();
                          }
                        },
                        color:
                            (query == null || query!.filters.isEmpty)
                                ? theme.disabledColor
                                : null,
                        icon: const Icon(Icons.filter_list),
                      ),
                    ),
                  ],
                );
              },
              viewOnSubmitted: (value) {
                final term = value.trim();
                if (term.isNotEmpty) {
                  final history = ref.read(_searchHistoryProvider);
                  ref.read(_searchHistoryProvider.notifier).state =
                      {term, ...history}.take(5).toList();
                }

                if (controller.isOpen) {
                  controller.closeView(term);
                }

                unfocusSearchBar();

                setState(() {
                  query =
                      query != null
                          ? query!.copyWith(title: term.toLowerCase())
                          : SearchQuery(title: term.toLowerCase());
                });
                _pagingController.refresh();
              },
              suggestionsBuilder: (
                BuildContext context,
                SearchController controller,
              ) {
                final history = ref.read(_searchHistoryProvider);
                return history
                    .map(
                      (e) => ListTile(
                        titleAlignment: ListTileTitleAlignment.center,
                        title: Text(e),
                        onTap: () {
                          final term = e.trim();
                          if (term.isNotEmpty) {
                            final history = ref.read(_searchHistoryProvider);
                            ref.read(_searchHistoryProvider.notifier).state =
                                {term, ...history}.take(5).toList();
                          }

                          if (controller.isOpen) {
                            controller.closeView(term);
                          }

                          unfocusSearchBar();

                          setState(() {
                            query =
                                query != null
                                    ? query!.copyWith(title: term.toLowerCase())
                                    : SearchQuery(title: term.toLowerCase());
                          });
                          _pagingController.refresh();
                        },
                      ),
                    )
                    .toList();
              },
            ),
          ),
        ],
        children: [
          WebMangaListViewSliver(
            controller: _pagingController,
            showRemoveButton: false,
          ),
        ],
      ),
    );
  }
}

class _ExtensionFilterWidget extends StatefulHookConsumerWidget {
  const _ExtensionFilterWidget({required this.source, this.query});

  final WebSourceInfo source;
  final SearchQuery? query;

  @override
  ConsumerState<_ExtensionFilterWidget> createState() =>
      _ExtensionFilterWidgetState();
}

class _ExtensionFilterWidgetState
    extends ConsumerState<_ExtensionFilterWidget> {
  late ValueNotifier<List<SearchFilterValue>> fil;

  ExpansionPanel _buildFilterPanel(SearchFilter filter, bool isExpanded) {
    return ExpansionPanel(
      canTapOnHeader: true,
      isExpanded: isExpanded,
      headerBuilder:
          (context, isExpanded) => ListTile(
            title: Text(
              filter.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
      body: SizedBox(
        width: double.infinity,
        child: switch (filter) {
          DropdownSearchFilter(:final id, :final options) => Center(
            child: DropdownMenu<String>(
              initialSelection:
                  fil.value.firstWhereOrNull((f) => f.id == id)?.value
                      as String?,
              width: 200,
              requestFocusOnTap: false,
              enableSearch: false,
              enableFilter: false,
              dropdownMenuEntries:
                  options
                      .map(
                        (opt) =>
                            DropdownMenuEntry(value: opt.id, label: opt.value),
                      )
                      .toList(),
              onSelected: (String? opt) {
                if (opt != null) {
                  fil.value.removeWhere((f) => f.id == id);

                  fil.value = [
                    ...fil.value,
                    SearchFilterValue(id: id, value: opt),
                  ];
                }
              },
            ),
          ),

          SelectSearchFilter(
            :final id,
            :final options,
            :final allowExclusion,
            :final allowEmptySelection,
            :final maximum,
          ) =>
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SectionChildren(
                  key: ValueKey('_SectionChildren($id)'),
                  children:
                      options
                          .map(
                            (opt) => HookBuilder(
                              builder: (context) {
                                final value = useListenableSelector(
                                  fil,
                                  () =>
                                      (fil.value
                                              .firstWhereOrNull(
                                                (f) => f.id == id,
                                              )
                                              ?.value
                                          as Map<String, dynamic>?)?[opt.id],
                                );

                                if (allowExclusion) {
                                  return TriStateChip(
                                    label: Text(opt.value),
                                    selectedColor: Colors.green,
                                    unselectedColor: Colors.red,
                                    onChanged: (bool? value) {
                                      Map<String, dynamic>? map = {
                                        ...?(fil.value
                                                .firstWhereOrNull(
                                                  (f) => f.id == id,
                                                )
                                                ?.value
                                            as Map<String, dynamic>?),
                                      };

                                      switch (value) {
                                        case null:
                                          map.remove(opt.id);
                                          break;
                                        case true:
                                          if (maximum == null ||
                                              (map.entries.length < maximum)) {
                                            map[opt.id] = 'included';
                                          }
                                          break;
                                        case false:
                                          map[opt.id] = 'excluded';
                                          break;
                                      }

                                      fil.value.removeWhere((f) => f.id == id);
                                      fil.value = [
                                        ...fil.value,
                                        if (map.isNotEmpty)
                                          SearchFilterValue(id: id, value: map),
                                      ];
                                    },
                                    value: switch (value) {
                                      'included' => true,
                                      'excluded' => false,
                                      null => null,
                                      Object() => null,
                                    },
                                  );
                                } else {
                                  return InputChip(
                                    label: Text(opt.value),
                                    selected: value == 'included',
                                    onSelected: (selected) {
                                      Map<String, dynamic>? map = {
                                        ...?(fil.value
                                                .firstWhereOrNull(
                                                  (f) => f.id == id,
                                                )
                                                ?.value
                                            as Map<String, dynamic>?),
                                      };

                                      switch (selected) {
                                        case true:
                                          if (maximum == null ||
                                              (map.entries.length < maximum)) {
                                            map[opt.id] = 'included';
                                          }
                                          break;
                                        case false:
                                          if (allowEmptySelection ||
                                              map.entries.length > 1) {
                                            map.remove(opt.id);
                                          }
                                          break;
                                      }

                                      fil.value.removeWhere((f) => f.id == id);
                                      fil.value = [
                                        ...fil.value,
                                        if (map.isNotEmpty)
                                          SearchFilterValue(id: id, value: map),
                                      ];
                                    },
                                  );
                                }
                              },
                            ),
                          )
                          .toList(),
                ),
              ],
            ),
          InputSearchFilter(:final id, :final placeholder) => Center(
            child: HookBuilder(
              builder: (context) {
                final controller = useTextEditingController();
                final text = useValueListenable(controller);

                final debouncedInput = useDebounced(
                  text.text,
                  Duration(milliseconds: 500),
                );

                useEffect(() {
                  fil.value.removeWhere((f) => f.id == id);
                  fil.value = [
                    ...fil.value,
                    if (debouncedInput != null && debouncedInput.isNotEmpty)
                      SearchFilterValue(id: id, value: debouncedInput),
                  ];
                  // Use debouncedInput as a dependency
                  return null;
                }, [debouncedInput]);

                return TextField(
                  controller: controller,
                  onTapOutside: (event) => unfocusSearchBar(),
                  decoration: InputDecoration(
                    hintText: placeholder,
                    suffixIcon: IconButton(
                      onPressed: controller.clear,
                      icon: Icon(Icons.clear),
                    ),
                  ),
                );
              },
            ),
          ),
          TagSearchFilter() => throw UnimplementedError('TagSearchFilter'),
        },
      ),
    );
  }

  @override
  void initState() {
    fil = ValueNotifier(
      widget.query?.filters.map((f) => f.copyWith()).toList() ?? [],
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleFutureBuilder(
      futureBuilder:
          () =>
              ref
                  .read(extensionSourceProvider(widget.source.id).notifier)
                  .getFilters(),
      keys: [widget.source],
      builder: (context, extFilters) {
        final tr = context.t;
        final nav = Navigator.of(context);

        if (extFilters == null) {
          return Scaffold(
            appBar: AppBar(
              leading: BackButton(
                onPressed: () {
                  nav.pop(null);
                },
              ),
              title: Text(tr.search.filters),
            ),
            body: Center(child: Text(tr.webSources.source.noTagsWarning)),
          );
        }

        return Scaffold(
          appBar: AppBar(
            leading: BackButton(
              onPressed: () {
                nav.pop(null);
              },
            ),
            title: Text(tr.search.filters),
            actions: [
              OverflowBar(
                spacing: 8.0,
                children: [
                  Tooltip(
                    message: tr.search.resetFilters,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        fil.value = [];
                      },
                      icon: const Icon(Icons.clear_all),
                      label: Text(tr.search.resetFilters),
                    ),
                  ),
                  Tooltip(
                    message: tr.search.applyFilters,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        nav.pop(fil.value);
                      },
                      icon: const Icon(Icons.filter_list),
                      label: Text(tr.search.applyFilters),
                    ),
                  ),
                ],
              ),
            ],
          ),
          body: HookBuilder(
            builder: (context) {
              final expanded = useState(
                List.generate(extFilters.length, (idx) => false),
              );

              final panelItems = [
                for (final (idx, f) in extFilters.indexed)
                  _buildFilterPanel(f, expanded.value[idx]),
              ];

              return SafeArea(
                child: SingleChildScrollView(
                  child: ExpansionPanelList(
                    expansionCallback: (panelIndex, isExpanded) {
                      expanded.value[panelIndex] = isExpanded;
                      expanded.value = [...expanded.value];
                    },
                    children: panelItems,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

// class _SectionHeader extends StatelessWidget {
//   final String header;

//   const _SectionHeader({super.key, required this.header});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Text(
//         header,
//         style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//       ),
//     );
//   }
// }

class _SectionChildren extends StatelessWidget {
  final List<Widget> children;

  const _SectionChildren({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(spacing: 4.0, runSpacing: 4.0, children: children),
    );
  }
}
