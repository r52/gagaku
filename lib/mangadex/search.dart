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
    final searchText = useListenableSelector(controller, () => controller.text);
    final debouncedInput = useDebounced(
      searchText,
      const Duration(milliseconds: 1000), // Set your desired timeout
    );

    final searchProvider = ref.watch(mangaSearchProvider(filter));
    final isLoading = searchProvider.isLoading && searchProvider.isReloading;

    final selected = useReducer(MangaSetAction.modify,
        initialState: selectedTitles ?? <String>{},
        initialAction: MangaSetAction(action: MangaSetActions.none));

    useEffect(() {
      controller.text = filter.query;
      return null;
    }, []);

    useEffect(() {
      if (debouncedInput != null) {
        Future.delayed(Duration.zero, () {
          ref.read(_searchParamsProvider.notifier).state =
              filter.copyWith(query: debouncedInput, filter: filter.filter);
        });
      }
      return null;
    }, [debouncedInput]);

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
              leading: BackButton(
                onPressed: () {
                  if (context.canPop()) {
                    context.pop(selectMode ? selected.state : null);
                  } else {
                    context.go('/');
                  }
                },
              ),
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
                        decoration: const InputDecoration(
                          icon: Icon(Icons.search),
                          hintText: 'Search MangaDex...',
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
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
                    if (selected.state.contains(manga.id)) {
                      return const Icon(Icons.remove);
                    }

                    return const Icon(Icons.add);
                  },
                  onSelected: (manga) {
                    if (selected.state.contains(manga.id)) {
                      selected.dispatch(MangaSetAction(
                        action: MangaSetActions.remove,
                        element: manga.id,
                      ));
                    } else {
                      selected.dispatch(MangaSetAction(
                        action: MangaSetActions.add,
                        element: manga.id,
                      ));
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nav = Navigator.of(context);
    final theme = Theme.of(context);
    final fil = useValueNotifier(filter);

    final tagsProvider = ref.watch(tagListProvider);

    final selectedChipColor = theme.colorScheme.tertiaryContainer;

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
                    fil.value = MangaFilterAction.action(
                      fil.value,
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
                const _SectionHeader(
                  key: ValueKey('Selected Tag Filters'),
                  header: 'Selected Tag Filters',
                ),
                HookBuilder(
                  builder: (context) {
                    final selectedFilters = useListenableSelector(
                        fil,
                        () => [
                              ...fil.value.includedTags.map(
                                (e) => InputChip(
                                  label: Text(e.attributes.name.get('en')),
                                  showCheckmark: true,
                                  selected: true,
                                  onDeleted: () {
                                    fil.value = MangaFilterAction.action(
                                      fil.value,
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
                                    fil.value = MangaFilterAction.action(
                                      fil.value,
                                      excludedTags: fil.value.excludedTags
                                          .where((element) => element != e)
                                          .toSet(),
                                    );
                                  },
                                  side: BorderSide(color: selectedChipColor),
                                ),
                              )
                            ]);

                    return _SectionChildren(
                      key: const ValueKey("selectedFilters"),
                      children: selectedFilters.isNotEmpty
                          ? selectedFilters
                          : [const InputChip(label: Text('None'))],
                    );
                  },
                ),

                const Divider(),

                /// ContentRating
                const _SectionHeader(
                  key: ValueKey("Content Rating"),
                  header: 'Content Rating',
                ),
                _SectionChildren(
                  key: const ValueKey("Content children"),
                  children: ContentRating.values
                      .map(
                        (e) => HookBuilder(
                          builder: (context) {
                            final selected = useListenableSelector(
                                fil, () => fil.value.contentRating.contains(e));

                            return FilterChip(
                              label: Text(e.label),
                              selectedColor: selectedChipColor,
                              selected: selected,
                              onSelected: (bool value) {
                                if (value) {
                                  fil.value = MangaFilterAction.action(
                                    fil.value,
                                    contentRating: {
                                      ...fil.value.contentRating,
                                      e
                                    },
                                  );
                                } else {
                                  fil.value = MangaFilterAction.action(
                                    fil.value,
                                    contentRating: fil.value.contentRating
                                        .where((element) => element != e)
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

                /// Demographic
                const _SectionHeader(
                  key: ValueKey("Demographic"),
                  header: 'Demographic',
                ),
                _SectionChildren(
                  key: const ValueKey("Demographic children"),
                  children: MangaDemographic.values
                      .map(
                        (e) => HookBuilder(
                          builder: (context) {
                            final selected = useListenableSelector(
                                fil,
                                () => fil.value.publicationDemographic
                                    .contains(e));

                            return FilterChip(
                              label: Text(e.label),
                              selectedColor: selectedChipColor,
                              selected: selected,
                              onSelected: (bool value) {
                                if (value) {
                                  fil.value = MangaFilterAction.action(
                                    fil.value,
                                    publicationDemographic: {
                                      ...fil.value.publicationDemographic,
                                      e
                                    },
                                  );
                                } else {
                                  fil.value = MangaFilterAction.action(
                                    fil.value,
                                    publicationDemographic: fil
                                        .value.publicationDemographic
                                        .where((element) => element != e)
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

                /// Pub status
                const _SectionHeader(
                  key: ValueKey("Publication Status"),
                  header: 'Publication Status',
                ),
                _SectionChildren(
                  key: const ValueKey("Pub children"),
                  children: MangaStatus.values
                      .map(
                        (e) => HookBuilder(
                          builder: (context) {
                            final selected = useListenableSelector(
                                fil, () => fil.value.status.contains(e));

                            return FilterChip(
                              label: Text(e.label),
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
                                    status: fil.value.status
                                        .where((element) => element != e)
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
                const Divider(),

                /// Tags
                for (final group in TagGroup.values) ...[
                  _SectionHeader(
                    key: ValueKey(group.label),
                    header: group.label,
                  ),
                  _SectionChildren(
                    key: ValueKey("${group.label} children"),
                    children: tags
                        .where((element) => element.attributes.group == group)
                        .map(
                          (e) => HookBuilder(
                            builder: (context) {
                              final value = useListenableSelector(
                                  fil,
                                  () => fil.value.includedTags.contains(e)
                                      ? true
                                      : (fil.value.excludedTags.contains(e)
                                          ? false
                                          : null));

                              return TriStateChip(
                                label: Text(e.attributes.name.get('en')),
                                selectedColor: selectedChipColor,
                                onChanged: (bool? value) {
                                  switch (value) {
                                    case null:
                                      fil.value = MangaFilterAction.action(
                                        fil.value,
                                        includedTags: fil.value.includedTags
                                            .where((element) => element != e)
                                            .toSet(),
                                        excludedTags: fil.value.excludedTags
                                            .where((element) => element != e)
                                            .toSet(),
                                      );
                                      break;
                                    case true:
                                      fil.value = MangaFilterAction.action(
                                        fil.value,
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
                                      fil.value = MangaFilterAction.action(
                                        fil.value,
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
                                value: value,
                              );
                            },
                          ),
                        )
                        .toList(),
                  ),
                ],

                // Modes
                const _SectionHeader(
                  key: ValueKey("Modes"),
                  header: 'Other Options',
                ),
                _SectionChildren(
                  key: const ValueKey("Modes children"),
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
                          fil.value = MangaFilterAction.action(
                            fil.value,
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

class _SectionHeader extends StatelessWidget {
  final String header;

  const _SectionHeader({super.key, required this.header});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(
        header,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
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
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Wrap(
        spacing: 4.0,
        runSpacing: 4.0,
        children: children,
      ),
    );
  }
}
