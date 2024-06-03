import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/mangadex/model.dart';
import 'package:gagaku/mangadex/types.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:gagaku/ui.dart';
import 'package:gagaku/util.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hooks_riverpod/legacy.dart';

//part 'search.g.dart';

final _searchParamsProvider = StateProvider(
    (ref) => const MangaSearchParameters(query: '', filter: MangaFilters()));

Widget buildMDSearchPage(BuildContext context, GoRouterState state) {
  final selectMode = state.uri.queryParameters['selectMode'] == 'true';
  final selectedTitles = state.extra.asOrNull<Set<String>>();
  return MangaDexSearchWidget(
    selectMode: selectMode,
    selectedTitles: selectedTitles,
  );
}

class MangaDexSearchWidget extends HookConsumerWidget {
  const MangaDexSearchWidget({
    super.key,
    this.selectMode = false,
    this.selectedTitles,
  });

  final bool selectMode;
  final Set<String>? selectedTitles;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nav = Navigator.of(context);
    final filter = ref.watch(_searchParamsProvider);
    final controller = useTextEditingController();
    final debounce = useRef<Timer?>(null);

    final searchProvider = ref.watch(mangaSearchProvider(filter));
    final isLoading = searchProvider.isLoading && searchProvider.isReloading;

    final selected = useState<Set<String>>(selectedTitles ?? {});

    useEffect(() {
      return () => debounce.value?.cancel();
    }, [debounce]);

    useEffect(() {
      controller.text = filter.query;
      return null;
    }, []);

    void onSearchChanged(String query) {
      if (debounce.value?.isActive ?? false) debounce.value?.cancel();
      debounce.value = Timer(const Duration(milliseconds: 1000), () {
        ref.read(_searchParamsProvider.notifier).state =
            filter.copyWith(query: query, filter: filter.filter);
      });
    }

    return Scaffold(
        body: Stack(
      children: [
        MangaListWidget(
          physics: const AlwaysScrollableScrollPhysics(),
          title: DropdownMenu<FilterOrder>(
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
                ref.read(_searchParamsProvider.notifier).state =
                    filter.copyWith(
                  query: filter.query,
                  filter: filter.filter.copyWith(order: order),
                );
              }
            },
            dropdownMenuEntries: List<DropdownMenuEntry<FilterOrder>>.generate(
              FilterOrder.values.length,
              (int index) => DropdownMenuEntry<FilterOrder>(
                value: FilterOrder.values.elementAt(index),
                label: FilterOrder.values.elementAt(index).label,
              ),
            ),
          ),
          onAtEdge: () {
            final lt = ref.read(_searchParamsProvider);
            ref.read(mangaSearchProvider(lt).notifier).getMore();
          },
          showToggle: !selectMode,
          leading: [
            SliverAppBar(
              leading: BackButton(onPressed: () {
                if (context.canPop()) {
                  context.pop(selectMode ? selected.value : null);
                } else {
                  context.go('/');
                }
              }),
              pinned: true,
              snap: false,
              floating: false,
              expandedHeight: 80.0,
              flexibleSpace: FlexibleSpaceBar(
                title: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        textInputAction: TextInputAction.search,
                        autofocus: true,
                        controller: controller,
                        onChanged: onSearchChanged,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.search),
                          hintText: 'Search MangaDex...',
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () async {
                        final result = await nav.push<MangaFilters>(
                          Styles.buildSlideTransitionRoute(
                            (context, animation, secondaryAnimation) =>
                                _MangaDexFilterWidget(
                              filter: filter.filter,
                            ),
                          ),
                        );

                        if (result != null) {
                          ref.read(_searchParamsProvider.notifier).state =
                              filter.copyWith(
                            query: filter.query,
                            filter: result,
                          );
                        }
                      },
                      icon: const Icon(Icons.filter_list),
                      label: const Text('Filters'),
                    ),
                  ],
                ),
              ),
            ),
          ],
          children: [
            switch (searchProvider) {
              AsyncValue(:final error?, :final stackTrace?) =>
                SliverToBoxAdapter(
                  child: ErrorColumn(
                    error: error,
                    stackTrace: stackTrace,
                    message: "mangaSearchProvider() failed",
                  ),
                ),
              AsyncValue(value: final results?) when results.isNotEmpty =>
                MangaListViewSliver(
                  items: results,
                  selectMode: selectMode,
                  selectButton: (manga) {
                    if (selected.value.contains(manga.id)) {
                      return const Icon(Icons.remove);
                    }

                    return const Icon(Icons.add);
                  },
                  onSelected: (manga) {
                    if (selected.value.contains(manga.id)) {
                      selected.value = {...selected.value..remove(manga.id)};
                    } else {
                      selected.value = {...selected.value..add(manga.id)};
                    }
                  },
                ),
              AsyncValue(value: final _?) => const SliverToBoxAdapter(
                  child: Center(
                    child: Text("No results!"),
                  ),
                ),
              _ => const SliverToBoxAdapter(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            },
            if (!searchProvider.isLoading &&
                !ref.watch(mangaSearchProvider(filter).notifier).isAtEnd())
              SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: ElevatedButton(
                      onPressed: () {
                        final lt = ref.read(_searchParamsProvider);
                        ref.read(mangaSearchProvider(lt).notifier).getMore();
                      },
                      child: const Text('Load More'),
                    ),
                  ),
                ),
              ),
          ],
        ),
        if (isLoading) ...Styles.loadingOverlay,
      ],
    ));
  }
}

class _MangaDexFilterWidget extends HookConsumerWidget {
  const _MangaDexFilterWidget({
    required this.filter,
  });

  final MangaFilters filter;

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
          spacing: 4.0,
          runSpacing: 4.0,
          children: children,
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nav = Navigator.of(context);
    final theme = Theme.of(context);
    final fil = useState(filter);
    final tagsProvider = ref.watch(tagListProvider);

    const headingStyle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );

    final selectedChipColor = theme.colorScheme.tertiaryContainer;

    final selectedFilters = [
      ...fil.value.includedTags.map(
        (e) => InputChip(
          label: Text(e.attributes.name.get('en')),
          showCheckmark: true,
          selected: true,
          onDeleted: () {
            fil.value = fil.value.copyWith(
              includedTags: fil.value.includedTags
                  .where((element) => element != e)
                  .toSet(),
            );
          },
          selectedColor: selectedChipColor,
        ),
      ),
      ...fil.value.excludedTags.map(
        (e) => InputChip(
          label: Text(e.attributes.name.get('en')),
          avatar: Icon(
            Icons.remove,
            color: theme.colorScheme.primary,
          ),
          onDeleted: () {
            fil.value = fil.value.copyWith(
              excludedTags: fil.value.excludedTags
                  .where((element) => element != e)
                  .toSet(),
            );
          },
          side: BorderSide(color: selectedChipColor),
        ),
      )
    ];

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            nav.pop(null);
          },
        ),
        title: const Text('Search Filters'),
        actions: [
          OverflowBar(
            spacing: 8.0,
            children: [
              Tooltip(
                message: 'Reset Filters',
                child: ElevatedButton.icon(
                  onPressed: () {
                    fil.value = fil.value.copyWith(
                      includedTags: {},
                      excludedTags: {},
                      contentRating: {},
                      publicationDemographic: {},
                      status: {},
                    );
                  },
                  icon: const Icon(Icons.clear_all),
                  label: const Text('Reset Filters'),
                ),
              ),
              Tooltip(
                message: 'Apply Filters',
                child: ElevatedButton.icon(
                  onPressed: () {
                    nav.pop(fil.value);
                  },
                  icon: const Icon(Icons.filter_list),
                  label: const Text('Apply Filters'),
                ),
              ),
            ],
          )
        ],
      ),
      body: switch (tagsProvider) {
        AsyncValue(value: final tags?) => SafeArea(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    'Selected Tag Filters',
                    style: headingStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Wrap(
                    spacing: 4.0,
                    runSpacing: 4.0,
                    children: selectedFilters.isNotEmpty
                        ? selectedFilters
                        : [const InputChip(label: Text('None'))],
                  ),
                ),
                const Divider(),

                /// ContentRating
                ..._buildSection(
                  header: const Text(
                    'Content Rating',
                    style: headingStyle,
                  ),
                  children: ContentRating.values
                      .map(
                        (e) => FilterChip(
                          label: Text(e.label),
                          selectedColor: selectedChipColor,
                          selected: fil.value.contentRating.contains(e),
                          onSelected: (bool value) {
                            if (value) {
                              fil.value = fil.value.copyWith(
                                contentRating: {...fil.value.contentRating, e},
                              );
                            } else {
                              fil.value = fil.value.copyWith(
                                contentRating: fil.value.contentRating
                                    .where((element) => element != e)
                                    .toSet(),
                              );
                            }
                          },
                        ),
                      )
                      .toList(),
                ),

                /// Demographic
                ..._buildSection(
                  header: const Text(
                    'Demographic',
                    style: headingStyle,
                  ),
                  children: MangaDemographic.values
                      .map((e) => FilterChip(
                            label: Text(e.label),
                            selectedColor: selectedChipColor,
                            selected:
                                fil.value.publicationDemographic.contains(e),
                            onSelected: (bool value) {
                              if (value) {
                                fil.value = fil.value.copyWith(
                                  publicationDemographic: {
                                    ...fil.value.publicationDemographic,
                                    e
                                  },
                                );
                              } else {
                                fil.value = fil.value.copyWith(
                                  publicationDemographic: fil
                                      .value.publicationDemographic
                                      .where((element) => element != e)
                                      .toSet(),
                                );
                              }
                            },
                          ))
                      .toList(),
                ),

                /// Pub status
                ..._buildSection(
                  header: const Text(
                    'Publication Status',
                    style: headingStyle,
                  ),
                  children: MangaStatus.values
                      .map(
                        (e) => FilterChip(
                          label: Text(e.label),
                          selectedColor: selectedChipColor,
                          selected: fil.value.status.contains(e),
                          onSelected: (bool value) {
                            if (value) {
                              fil.value = fil.value.copyWith(
                                status: {...fil.value.status, e},
                              );
                            } else {
                              fil.value = fil.value.copyWith(
                                status: fil.value.status
                                    .where((element) => element != e)
                                    .toSet(),
                              );
                            }
                          },
                        ),
                      )
                      .toList(),
                ),
                const Divider(),

                /// Tags
                for (final group in TagGroup.values) ...[
                  ..._buildSection(
                    header: Text(
                      group.label,
                      style: headingStyle,
                    ),
                    children: tags
                        .where((element) => element.attributes.group == group)
                        .map(
                          (e) => TriStateChip(
                            label: Text(e.attributes.name.get('en')),
                            selectedColor: selectedChipColor,
                            onChanged: (bool? value) {
                              switch (value) {
                                case null:
                                  fil.value = fil.value.copyWith(
                                    includedTags: fil.value.includedTags
                                        .where((element) => element != e)
                                        .toSet(),
                                    excludedTags: fil.value.excludedTags
                                        .where((element) => element != e)
                                        .toSet(),
                                  );
                                  break;
                                case true:
                                  fil.value = fil.value.copyWith(
                                    includedTags: {
                                      ...fil.value.includedTags,
                                      e
                                    },
                                    excludedTags: fil.value.excludedTags
                                        .where((element) => element != e)
                                        .toSet(),
                                  );
                                  break;
                                case false:
                                  fil.value = fil.value.copyWith(
                                    includedTags: fil.value.includedTags
                                        .where((element) => element != e)
                                        .toSet(),
                                    excludedTags: {
                                      ...fil.value.excludedTags,
                                      e
                                    },
                                  );
                                  break;
                              }
                            },
                            value: fil.value.includedTags.contains(e)
                                ? true
                                : (fil.value.excludedTags.contains(e)
                                    ? false
                                    : null),
                          ),
                        )
                        .toList(),
                  ),
                ],

                // Modes
                ..._buildSection(
                  header: const Text(
                    'Other Options',
                    style: headingStyle,
                  ),
                  children: [
                    DropdownMenu<TagMode>(
                      label: const Text('Inclusion Mode'),
                      initialSelection: fil.value.includedTagsMode,
                      requestFocusOnTap: false,
                      enableSearch: false,
                      enableFilter: false,
                      dropdownMenuEntries: [
                        for (final mode in TagMode.values)
                          DropdownMenuEntry(value: mode, label: mode.label),
                      ],
                      onSelected: (value) {
                        if (value != null) {
                          fil.value = fil.value.copyWith(
                            includedTagsMode: value,
                          );
                        }
                      },
                    ),
                    DropdownMenu<TagMode>(
                      label: const Text('Exclusion Mode'),
                      initialSelection: fil.value.excludedTagsMode,
                      requestFocusOnTap: false,
                      enableSearch: false,
                      enableFilter: false,
                      dropdownMenuEntries: [
                        for (final mode in TagMode.values)
                          DropdownMenuEntry(value: mode, label: mode.label),
                      ],
                      onSelected: (value) {
                        if (value != null) {
                          fil.value = fil.value.copyWith(
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
        AsyncValue(:final error?, :final stackTrace?) => ErrorColumn(
            error: error,
            stackTrace: stackTrace,
            message: "tagListProvider failed",
          ),
        _ => const Center(
            child: CircularProgressIndicator(),
          ),
      },
    );
  }
}
