import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/mangadex/model/model.dart';
import 'package:gagaku/mangadex/model/types.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:gagaku/util/infinite_scroll.dart';
import 'package:gagaku/util/ui.dart';
import 'package:gagaku/util/util.dart';
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
class MangaDexSearchPage extends StatefulHookConsumerWidget {
  const MangaDexSearchPage({
    super.key,
    this.selectMode = false,
    this.selectedTitles,
    this.parameters,
  });

  final bool selectMode;
  final Set<String>? selectedTitles;
  final MangaSearchParameters? parameters;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MangaDexSearchPageState();
}

class _MangaDexSearchPageState extends ConsumerState<MangaDexSearchPage> {
  static const info = MangaDexFeeds.search;

  late MangaSearchParameters _searchParameters =
      widget.parameters ??
      const MangaSearchParameters(query: '', filter: MangaFilters());

  late final _pagingController = GagakuPagingController<int, Manga>(
    getNextPageKey:
        (state) => state.keys?.last != null ? state.keys!.last + info.limit : 0,
    fetchPage: (pageKey) async {
      final api = ref.watch(mangadexProvider);
      final filter = _searchParameters;

      final results = await api.searchManga(
        filter.query,
        limit: info.limit,
        filter: filter.filter,
        offset: pageKey,
      );

      final manga = results.data.cast<Manga>();

      if (manga.isNotEmpty) {
        statisticsMutation.run(ref, (ref) async {
          return await ref.get(statisticsProvider.notifier).get(manga);
        });
      }

      return PageResultsMetaData(manga, results.total);
    },
  );

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tr = context.t;
    final theme = Theme.of(context);
    final nav = Navigator.of(context);
    final filter = _searchParameters;
    final controller = useSearchController();

    final selected = useReducer(
      MangaSetAction.modify,
      initialState: widget.selectedTitles ?? <String>{},
      initialAction: MangaSetAction(action: MangaSetActions.none),
    );

    useEffect(() {
      controller.text = filter.query;
      return null;
    }, []);

    return Scaffold(
      body: MangaListWidget(
        physics: const AlwaysScrollableScrollPhysics(),
        showToggle: !widget.selectMode,
        leading: [
          SliverAppBar(
            leading: BackButton(
              onPressed: () {
                context.maybePop(widget.selectMode ? selected.state : null);
              },
            ),
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
                  hintText: tr.search.arg(arg: 'MangaDex'),
                  trailing: <Widget>[
                    Tooltip(
                      message: tr.search.filters,
                      child: IconButton(
                        onPressed: () async {
                          final result = await nav.push<MangaFilters>(
                            SlideTransitionRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      _MangaDexFilterWidget(
                                        filter: filter.filter,
                                      ),
                            ),
                          );

                          if (result != null) {
                            setState(() {
                              _searchParameters = filter.copyWith(
                                query: filter.query,
                                filter: result,
                              );

                              _pagingController.refresh();
                            });
                          }
                        },
                        color:
                            _searchParameters.filter.isEmpty
                                ? theme.disabledColor
                                : null,
                        icon: const Icon(Icons.filter_list),
                      ),
                    ),
                  ],
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

                    unfocusSearchBar();

                    setState(() {
                      _searchParameters = filter.copyWith(
                        query: term,
                        filter: filter.filter,
                      );

                      _pagingController.refresh();
                    });
                  },
                );
              },
              viewOnSubmitted: (value) {
                final term = value.trim();
                if (term.isNotEmpty) {
                  final history = ref.read(_searchHistoryProvider);
                  ref.read(_searchHistoryProvider.notifier).state =
                      {term, ...history}.take(5).toList();
                }

                controller.closeView(term);

                unfocusSearchBar();

                setState(() {
                  _searchParameters = filter.copyWith(
                    query: term,
                    filter: filter.filter,
                  );

                  _pagingController.refresh();
                });
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

                          controller.closeView(term);

                          unfocusSearchBar();

                          setState(() {
                            _searchParameters = filter.copyWith(
                              query: term,
                              filter: filter.filter,
                            );

                            _pagingController.refresh();
                          });
                        },
                      ),
                    )
                    .toList();
              },
            ),
          ),
          SliverAppBar(
            automaticallyImplyLeading: false,
            primary: false,
            title: Text(tr.search.text),
            actions: [
              DropdownMenu<FilterOrder>(
                initialSelection: filter.filter.order,
                enableFilter: false,
                enableSearch: false,
                requestFocusOnTap: false,
                inputDecorationTheme: InputDecorationTheme(
                  filled: true,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 2.0,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                ),
                onSelected: (FilterOrder? order) async {
                  if (order != null) {
                    setState(() {
                      _searchParameters = filter.copyWith(
                        query: filter.query,
                        filter: filter.filter.copyWith(order: order),
                      );

                      _pagingController.refresh();
                    });
                  }
                },
                dropdownMenuEntries:
                    List<DropdownMenuEntry<FilterOrder>>.generate(
                      FilterOrder.values.length,
                      (int index) => DropdownMenuEntry<FilterOrder>(
                        value: FilterOrder.values.elementAt(index),
                        label: tr[FilterOrder.values.elementAt(index).label],
                      ),
                    ),
              ),
            ],
          ),
        ],
        children: [
          MangaListViewSliver(
            controller: _pagingController,
            selectMode: widget.selectMode,
            selectButton: (manga) {
              if (selected.state.contains(manga.id)) {
                return const Icon(Icons.remove);
              }

              return const Icon(Icons.add);
            },
            onSelected: (manga) {
              if (selected.state.contains(manga.id)) {
                selected.dispatch(
                  MangaSetAction(
                    action: MangaSetActions.remove,
                    element: manga.id,
                  ),
                );
              } else {
                selected.dispatch(
                  MangaSetAction(
                    action: MangaSetActions.add,
                    element: manga.id,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class _MangaDexFilterWidget extends HookWidget {
  const _MangaDexFilterWidget({required this.filter});

  final MangaFilters filter;

  @override
  Widget build(BuildContext context) {
    final tr = context.t;
    final nav = Navigator.of(context);
    final theme = Theme.of(context);
    final fil = useValueNotifier(filter);

    final selectedChipColor = theme.colorScheme.tertiaryContainer;

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
                    fil.value = MangaFilterAction.action(
                      fil.value,
                      includedTags: {},
                      excludedTags: {},
                      contentRating: {},
                      publicationDemographic: {},
                      status: {},
                      author: {},
                      artist: {},
                    );
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
      body: DataProviderWhenWidget(
        provider: tagListProvider,
        builder: (context, tags) {
          return HookBuilder(
            builder: (context) {
              final expanded = useState(List.generate(6, (_) => false));

              final panelItems = [
                ExpansionPanel(
                  canTapOnHeader: true,
                  isExpanded: expanded.value[0],
                  headerBuilder:
                      (context, isExpanded) => HookBuilder(
                        builder: (context) {
                          final selected = useListenableSelector(
                            fil,
                            () => fil.value.contentRating,
                          );

                          return ListTile(
                            title: Text(
                              tr.mangadex.contentRating,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle:
                                selected.isEmpty
                                    ? Text(tr.search.any)
                                    : Text(
                                      selected
                                          .map((e) => tr[e.label])
                                          .join(', '),
                                    ),
                          );
                        },
                      ),
                  body: SizedBox(
                    width: double.infinity,
                    child: _SectionChildren(
                      key: const ValueKey("_contentChildren"),
                      children:
                          ContentRating.values
                              .map(
                                (e) => HookBuilder(
                                  builder: (context) {
                                    final selected = useListenableSelector(
                                      fil,
                                      () => fil.value.contentRating.contains(e),
                                    );

                                    return FilterChip(
                                      label: Text(tr[e.label]),
                                      selectedColor: selectedChipColor,
                                      selected: selected,
                                      onSelected: (bool value) {
                                        if (value) {
                                          fil.value = MangaFilterAction.action(
                                            fil.value,
                                            contentRating: {
                                              ...fil.value.contentRating,
                                              e,
                                            },
                                          );
                                        } else {
                                          fil.value = MangaFilterAction.action(
                                            fil.value,
                                            contentRating:
                                                fil.value.contentRating
                                                    .where(
                                                      (element) => element != e,
                                                    )
                                                    .toSet(),
                                          );
                                        }
                                      },
                                    );
                                  },
                                ),
                              )
                              .toList(),
                    ),
                  ),
                ),
                ExpansionPanel(
                  canTapOnHeader: true,
                  isExpanded: expanded.value[1],
                  headerBuilder:
                      (context, isExpanded) => HookBuilder(
                        builder: (context) {
                          final selected = useListenableSelector(
                            fil,
                            () => fil.value.publicationDemographic,
                          );

                          return ListTile(
                            title: Text(
                              tr.mangadex.demographic,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle:
                                selected.isEmpty
                                    ? Text(tr.search.any)
                                    : Text(
                                      selected
                                          .map((e) => tr[e.label])
                                          .join(', '),
                                    ),
                          );
                        },
                      ),
                  body: SizedBox(
                    width: double.infinity,
                    child: _SectionChildren(
                      key: const ValueKey("_demographicChildren"),
                      children:
                          MangaDemographic.values
                              .map(
                                (e) => HookBuilder(
                                  builder: (context) {
                                    final selected = useListenableSelector(
                                      fil,
                                      () => fil.value.publicationDemographic
                                          .contains(e),
                                    );

                                    return FilterChip(
                                      label: Text(e.label),
                                      selectedColor: selectedChipColor,
                                      selected: selected,
                                      onSelected: (bool value) {
                                        if (value) {
                                          fil.value = MangaFilterAction.action(
                                            fil.value,
                                            publicationDemographic: {
                                              ...fil
                                                  .value
                                                  .publicationDemographic,
                                              e,
                                            },
                                          );
                                        } else {
                                          fil.value = MangaFilterAction.action(
                                            fil.value,
                                            publicationDemographic:
                                                fil.value.publicationDemographic
                                                    .where(
                                                      (element) => element != e,
                                                    )
                                                    .toSet(),
                                          );
                                        }
                                      },
                                    );
                                  },
                                ),
                              )
                              .toList(),
                    ),
                  ),
                ),
                ExpansionPanel(
                  canTapOnHeader: true,
                  isExpanded: expanded.value[2],
                  headerBuilder:
                      (context, isExpanded) => HookBuilder(
                        builder: (context) {
                          final selected = useListenableSelector(
                            fil,
                            () => fil.value.status,
                          );

                          return ListTile(
                            title: Text(
                              tr.mangadex.pubStatus,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle:
                                selected.isEmpty
                                    ? Text(tr.search.any)
                                    : Text(
                                      selected
                                          .map((e) => tr[e.label])
                                          .join(', '),
                                    ),
                          );
                        },
                      ),
                  body: SizedBox(
                    width: double.infinity,
                    child: _SectionChildren(
                      key: const ValueKey("_pubChildren"),
                      children:
                          MangaStatus.values
                              .map(
                                (e) => HookBuilder(
                                  builder: (context) {
                                    final selected = useListenableSelector(
                                      fil,
                                      () => fil.value.status.contains(e),
                                    );

                                    return FilterChip(
                                      label: Text(tr[e.label]),
                                      selectedColor: selectedChipColor,
                                      selected: selected,
                                      onSelected: (bool value) {
                                        if (value) {
                                          fil.value = MangaFilterAction.action(
                                            fil.value,
                                            status: {...fil.value.status, e},
                                          );
                                        } else {
                                          fil.value = MangaFilterAction.action(
                                            fil.value,
                                            status:
                                                fil.value.status
                                                    .where(
                                                      (element) => element != e,
                                                    )
                                                    .toSet(),
                                          );
                                        }
                                      },
                                    );
                                  },
                                ),
                              )
                              .toList(),
                    ),
                  ),
                ),
                ExpansionPanel(
                  canTapOnHeader: true,
                  isExpanded: expanded.value[3],
                  headerBuilder:
                      (context, isExpanded) => HookBuilder(
                        builder: (context) {
                          final selected = useListenableSelector(
                            fil,
                            () => fil.value.author,
                          );

                          return ListTile(
                            title: Text(
                              tr.mangaView.author,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle:
                                selected.isEmpty
                                    ? Text(tr.search.any)
                                    : Text(
                                      selected
                                          .map((e) => e.attributes.name)
                                          .join(', '),
                                    ),
                          );
                        },
                      ),
                  body: SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HookBuilder(
                          builder: (context) {
                            final selected = useListenableSelector(
                              fil,
                              () => fil.value.author,
                            );

                            return _CreatorSearchAnchor(
                              isSelected: (e) => selected.contains(e),
                              onSelect: (e, value) {
                                if (value == true) {
                                  fil.value = MangaFilterAction.action(
                                    fil.value,
                                    author: {...fil.value.author, e},
                                  );
                                } else {
                                  fil.value = MangaFilterAction.action(
                                    fil.value,
                                    author:
                                        fil.value.author
                                            .where((element) => element != e)
                                            .toSet(),
                                  );
                                }
                              },
                            );
                          },
                        ),
                        HookBuilder(
                          builder: (context) {
                            final selected = useListenableSelector(
                              fil,
                              () => fil.value.author,
                            );

                            return _SectionChildren(
                              key: const ValueKey("_selectedAuthors"),
                              children:
                                  selected
                                      .map(
                                        (e) => InputChip(
                                          label: Text(e.attributes.name),
                                          showCheckmark: false,
                                          selected: true,
                                          onDeleted: () {
                                            fil.value =
                                                MangaFilterAction.action(
                                                  fil.value,
                                                  author:
                                                      fil.value.author
                                                          .where(
                                                            (element) =>
                                                                element != e,
                                                          )
                                                          .toSet(),
                                                );
                                          },
                                          selectedColor: selectedChipColor,
                                        ),
                                      )
                                      .toList(),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                ExpansionPanel(
                  canTapOnHeader: true,
                  isExpanded: expanded.value[4],
                  headerBuilder:
                      (context, isExpanded) => HookBuilder(
                        builder: (context) {
                          final selected = useListenableSelector(
                            fil,
                            () => fil.value.artist,
                          );

                          return ListTile(
                            title: Text(
                              tr.mangaView.artist,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle:
                                selected.isEmpty
                                    ? Text(tr.search.any)
                                    : Text(
                                      selected
                                          .map((e) => e.attributes.name)
                                          .join(', '),
                                    ),
                          );
                        },
                      ),
                  body: SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HookBuilder(
                          builder: (context) {
                            final selected = useListenableSelector(
                              fil,
                              () => fil.value.artist,
                            );

                            return _CreatorSearchAnchor(
                              isSelected: (e) => selected.contains(e),
                              onSelect: (e, value) {
                                if (value == true) {
                                  fil.value = MangaFilterAction.action(
                                    fil.value,
                                    artist: {...fil.value.artist, e},
                                  );
                                } else {
                                  fil.value = MangaFilterAction.action(
                                    fil.value,
                                    artist:
                                        fil.value.artist
                                            .where((element) => element != e)
                                            .toSet(),
                                  );
                                }
                              },
                            );
                          },
                        ),
                        HookBuilder(
                          builder: (context) {
                            final selected = useListenableSelector(
                              fil,
                              () => fil.value.artist,
                            );

                            return _SectionChildren(
                              key: const ValueKey("_selectedArtists"),
                              children:
                                  selected
                                      .map(
                                        (e) => InputChip(
                                          label: Text(e.attributes.name),
                                          showCheckmark: false,
                                          selected: true,
                                          onDeleted: () {
                                            fil.value =
                                                MangaFilterAction.action(
                                                  fil.value,
                                                  artist:
                                                      fil.value.artist
                                                          .where(
                                                            (element) =>
                                                                element != e,
                                                          )
                                                          .toSet(),
                                                );
                                          },
                                          selectedColor: selectedChipColor,
                                        ),
                                      )
                                      .toList(),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                ExpansionPanel(
                  canTapOnHeader: true,
                  isExpanded: expanded.value[5],
                  headerBuilder:
                      (context, isExpanded) => HookBuilder(
                        builder: (context) {
                          final included = useListenableSelector(
                            fil,
                            () => fil.value.includedTags,
                          );
                          final excluded = useListenableSelector(
                            fil,
                            () => fil.value.excludedTags,
                          );

                          final includedString = included
                              .map(
                                (e) => e.attributes.name.get(
                                  tr.$meta.locale.languageCode,
                                ),
                              )
                              .join(', ');
                          final excludedString = excluded
                              .map(
                                (e) => e.attributes.name.get(
                                  tr.$meta.locale.languageCode,
                                ),
                              )
                              .join(', ');

                          return ListTile(
                            title: Text(
                              tr.search.filterTags,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle:
                                included.isEmpty && excluded.isEmpty
                                    ? Text(tr.search.any)
                                    : Text.rich(
                                      TextSpan(
                                        children: [
                                          if (included.isNotEmpty)
                                            TextSpan(
                                              text: '+ ',
                                              style: const TextStyle(
                                                color: Colors.green,
                                              ),
                                            ),
                                          if (included.isNotEmpty)
                                            TextSpan(text: includedString),
                                          if (included.isNotEmpty &&
                                              excluded.isNotEmpty)
                                            TextSpan(text: ', '),
                                          if (excluded.isNotEmpty)
                                            TextSpan(
                                              text: '- ',
                                              style: const TextStyle(
                                                color: Colors.red,
                                              ),
                                            ),
                                          if (excluded.isNotEmpty)
                                            TextSpan(text: excludedString),
                                        ],
                                      ),
                                    ),
                          );
                        },
                      ),
                  body: SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (final group in TagGroup.values) ...[
                          _SectionHeader(
                            key: ValueKey(group.label),
                            header: group.label,
                          ),
                          _SectionChildren(
                            key: ValueKey("_${group.label}Children"),
                            children:
                                tags
                                    .where(
                                      (element) =>
                                          element.attributes.group == group,
                                    )
                                    .map(
                                      (e) => HookBuilder(
                                        builder: (context) {
                                          final value = useListenableSelector(
                                            fil,
                                            () =>
                                                fil.value.includedTags.contains(
                                                      e,
                                                    )
                                                    ? true
                                                    : (fil.value.excludedTags
                                                            .contains(e)
                                                        ? false
                                                        : null),
                                          );

                                          return TriStateChip(
                                            label: Text(
                                              e.attributes.name.get(
                                                tr.$meta.locale.languageCode,
                                              ),
                                            ),
                                            selectedColor: Colors.green,
                                            unselectedColor: Colors.red,
                                            onChanged: (bool? value) {
                                              switch (value) {
                                                case null:
                                                  fil.value =
                                                      MangaFilterAction.action(
                                                        fil.value,
                                                        includedTags:
                                                            fil
                                                                .value
                                                                .includedTags
                                                                .where(
                                                                  (element) =>
                                                                      element !=
                                                                      e,
                                                                )
                                                                .toSet(),
                                                        excludedTags:
                                                            fil
                                                                .value
                                                                .excludedTags
                                                                .where(
                                                                  (element) =>
                                                                      element !=
                                                                      e,
                                                                )
                                                                .toSet(),
                                                      );
                                                  break;
                                                case true:
                                                  fil.value =
                                                      MangaFilterAction.action(
                                                        fil.value,
                                                        includedTags: {
                                                          ...fil
                                                              .value
                                                              .includedTags,
                                                          e,
                                                        },
                                                        excludedTags:
                                                            fil
                                                                .value
                                                                .excludedTags
                                                                .where(
                                                                  (element) =>
                                                                      element !=
                                                                      e,
                                                                )
                                                                .toSet(),
                                                      );
                                                  break;
                                                case false:
                                                  fil.value =
                                                      MangaFilterAction.action(
                                                        fil.value,
                                                        includedTags:
                                                            fil
                                                                .value
                                                                .includedTags
                                                                .where(
                                                                  (element) =>
                                                                      element !=
                                                                      e,
                                                                )
                                                                .toSet(),
                                                        excludedTags: {
                                                          ...fil
                                                              .value
                                                              .excludedTags,
                                                          e,
                                                        },
                                                      );
                                                  break;
                                              }
                                            },
                                            value: value,
                                          );
                                        },
                                      ),
                                    )
                                    .toList(),
                          ),
                        ],
                        _SectionHeader(
                          key: ValueKey("Modes"),
                          header: tr.search.otherOptions,
                        ),
                        _SectionChildren(
                          key: const ValueKey("_modesChildren"),
                          children: [
                            DropdownMenu<TagMode>(
                              label: Text(tr.search.inclusion),
                              initialSelection: fil.value.includedTagsMode,
                              requestFocusOnTap: false,
                              enableSearch: false,
                              enableFilter: false,
                              dropdownMenuEntries: [
                                for (final mode in TagMode.values)
                                  DropdownMenuEntry(
                                    value: mode,
                                    label: mode.label,
                                  ),
                              ],
                              onSelected: (value) {
                                if (value != null) {
                                  fil.value = MangaFilterAction.action(
                                    fil.value,
                                    includedTagsMode: value,
                                  );
                                }
                              },
                            ),
                            DropdownMenu<TagMode>(
                              label: Text(tr.search.exclusion),
                              initialSelection: fil.value.excludedTagsMode,
                              requestFocusOnTap: false,
                              enableSearch: false,
                              enableFilter: false,
                              dropdownMenuEntries: [
                                for (final mode in TagMode.values)
                                  DropdownMenuEntry(
                                    value: mode,
                                    label: mode.label,
                                  ),
                              ],
                              onSelected: (value) {
                                if (value != null) {
                                  fil.value = MangaFilterAction.action(
                                    fil.value,
                                    excludedTagsMode: value,
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
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
          );
        },
        loadingWidget: const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String header;

  const _SectionHeader({super.key, required this.header});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        header,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}

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

typedef _CreatorSelected = bool Function(CreatorType);
typedef _OnCreatorSelect = void Function(CreatorType, bool?);

class _CreatorSearchAnchor extends ConsumerStatefulWidget {
  const _CreatorSearchAnchor({
    required this.isSelected,
    required this.onSelect,
  });

  final _CreatorSelected isSelected;
  final _OnCreatorSelect onSelect;

  @override
  ConsumerState<_CreatorSearchAnchor> createState() =>
      _CreatorSearchAnchorState();
}

class _CreatorSearchAnchorState extends ConsumerState<_CreatorSearchAnchor> {
  String? _currentQuery;

  late Iterable<Widget> _lastOptions = <Widget>[];

  late final _Debounceable<List<CreatorType>?, String> _debouncedSearch;

  Future<List<CreatorType>?> _search(String query) async {
    _currentQuery = query;

    final api = ref.watch(mangadexProvider);
    final options = await api.fetchCreators(name: _currentQuery!);

    if (_currentQuery != query) {
      return null;
    }
    _currentQuery = null;

    return options;
  }

  @override
  void initState() {
    super.initState();
    _debouncedSearch = _debounce<List<CreatorType>?, String>(_search);
  }

  @override
  Widget build(BuildContext context) {
    return SearchAnchor.bar(
      suggestionsBuilder: (
        BuildContext context,
        SearchController controller,
      ) async {
        final List<CreatorType>? options =
            (await _debouncedSearch(controller.text))?.toList();
        if (options == null) {
          return _lastOptions;
        }

        _lastOptions = options.map((e) {
          return CheckboxListTile(
            title: Text(e.attributes.name),
            value: widget.isSelected(e),
            onChanged: (value) {
              widget.onSelect(e, value);
              // XXX: Not very good UX
              controller.closeView(null);
            },
          );
        });

        return _lastOptions;
      },
    );
  }
}

typedef _Debounceable<S, T> = Future<S?> Function(T parameter);

/// Specific debounce implementation for SearchAnchor
/// from https://api.flutter.dev/flutter/material/SearchAnchor-class.html
_Debounceable<S, T> _debounce<S, T>(_Debounceable<S?, T> function) {
  _DebounceTimer? debounceTimer;

  return (T parameter) async {
    if (debounceTimer != null && !debounceTimer!.isCompleted) {
      debounceTimer!.cancel();
    }
    debounceTimer = _DebounceTimer();
    try {
      await debounceTimer!.future;
    } on _CancelException {
      return null;
    }
    return function(parameter);
  };
}

class _DebounceTimer {
  _DebounceTimer() {
    _timer = Timer(const Duration(milliseconds: 500), _onComplete);
  }

  late final Timer _timer;
  final Completer<void> _completer = Completer<void>();

  void _onComplete() {
    _completer.complete();
  }

  Future<void> get future => _completer.future;

  bool get isCompleted => _completer.isCompleted;

  void cancel() {
    _timer.cancel();
    _completer.completeError(const _CancelException());
  }
}

class _CancelException implements Exception {
  const _CancelException();
}
