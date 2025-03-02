import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/mangadex/model/model.dart';
import 'package:gagaku/mangadex/model/types.dart';
import 'package:gagaku/mangadex/widgets.dart';
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

@Riverpod(keepAlive: true)
class _SearchParams extends _$SearchParams {
  @override
  MangaSearchParameters build() =>
      const MangaSearchParameters(query: '', filter: MangaFilters());

  @override
  set state(MangaSearchParameters newState) => super.state = newState;
  MangaSearchParameters update(
    MangaSearchParameters Function(MangaSearchParameters state) cb,
  ) => state = cb(state);
}

@RoutePage()
class MangaDexSearchPage extends HookConsumerWidget {
  const MangaDexSearchPage({
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
    final controller = useSearchController();

    final searchProvider = ref.watch(mangaSearchProvider(filter));
    final getNextPage = ref.watch(mangaSearchProvider(filter).getNextPage);

    final isLoading =
        getNextPage.state is PendingMutationState ||
        (searchProvider.isLoading && searchProvider.isReloading);

    final selected = useReducer(
      MangaSetAction.modify,
      initialState: selectedTitles ?? <String>{},
      initialAction: MangaSetAction(action: MangaSetActions.none),
    );

    useEffect(() {
      controller.text = filter.query;
      return null;
    }, []);

    return Scaffold(
      body: MangaListWidget(
        physics: const AlwaysScrollableScrollPhysics(),
        onAtEdge: () {
          final lt = ref.read(_searchParamsProvider);
          ref.read(mangaSearchProvider(lt).getNextPage)();
        },
        showToggle: !selectMode,
        leading: [
          SliverAppBar(
            leading: BackButton(
              onPressed: () {
                context.maybePop(selectMode ? selected.state : null);
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
                  hintText: 'search.arg'.tr(
                    context: context,
                    args: ['MangaDex'],
                  ),
                  trailing: <Widget>[
                    Tooltip(
                      message: 'search.filters'.tr(context: context),
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
                            ref
                                .read(_searchParamsProvider.notifier)
                                .state = filter.copyWith(
                              query: filter.query,
                              filter: result,
                            );
                          }
                        },
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

                    ref.read(_searchParamsProvider.notifier).state = filter
                        .copyWith(query: term, filter: filter.filter);

                    unfocusSearchBar();
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
                ref.read(_searchParamsProvider.notifier).state = filter
                    .copyWith(query: term, filter: filter.filter);

                unfocusSearchBar();
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
                          ref
                              .read(_searchParamsProvider.notifier)
                              .state = filter.copyWith(
                            query: term,
                            filter: filter.filter,
                          );

                          unfocusSearchBar();
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
            title: Text('search.text'.tr(context: context)),
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
                    ref.read(_searchParamsProvider.notifier).state = filter
                        .copyWith(
                          query: filter.query,
                          filter: filter.filter.copyWith(order: order),
                        );
                  }
                },
                dropdownMenuEntries:
                    List<DropdownMenuEntry<FilterOrder>>.generate(
                      FilterOrder.values.length,
                      (int index) => DropdownMenuEntry<FilterOrder>(
                        value: FilterOrder.values.elementAt(index),
                        label: context.tr(
                          FilterOrder.values.elementAt(index).label,
                        ),
                      ),
                    ),
              ),
            ],
          ),
        ],
        isLoading: isLoading,
        children: [
          switch (searchProvider) {
            AsyncValue(:final error?, :final stackTrace?) => SliverToBoxAdapter(
              child: ErrorList(
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
            AsyncValue(value: final _?) => SliverToBoxAdapter(
              child: Center(
                child: Text('errors.noresults'.tr(context: context)),
              ),
            ),
            _ => const SliverToBoxAdapter(
              child: Center(child: CircularProgressIndicator()),
            ),
          },
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
        title: Text('search.filters'.tr(context: context)),
        actions: [
          OverflowBar(
            spacing: 8.0,
            children: [
              Tooltip(
                message: 'search.resetFilters'.tr(context: context),
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
                  label: Text('search.resetFilters'.tr(context: context)),
                ),
              ),
              Tooltip(
                message: 'search.applyFilters'.tr(context: context),
                child: ElevatedButton.icon(
                  onPressed: () {
                    nav.pop(fil.value);
                  },
                  icon: const Icon(Icons.filter_list),
                  label: Text('search.applyFilters'.tr(context: context)),
                ),
              ),
            ],
          ),
        ],
      ),
      body: DataProviderWhenWidget(
        provider: tagListProvider,
        builder:
            (context, tags) => SafeArea(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                children: [
                  _SectionHeader(
                    key: ValueKey('_selectedTagFilters'),
                    header: 'search.selectedTagFilters'.tr(context: context),
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
                                  includedTags:
                                      fil.value.includedTags
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
                                  excludedTags:
                                      fil.value.excludedTags
                                          .where((element) => element != e)
                                          .toSet(),
                                );
                              },
                              side: BorderSide(color: selectedChipColor),
                            ),
                          ),
                        ],
                      );

                      return _SectionChildren(
                        key: const ValueKey("_selectedFilters"),
                        children:
                            selectedFilters.isNotEmpty
                                ? selectedFilters
                                : [
                                  InputChip(
                                    label: Text('ui.none'.tr(context: context)),
                                  ),
                                ],
                      );
                    },
                  ),

                  const Divider(),

                  /// ContentRating
                  _SectionHeader(
                    key: ValueKey("_contentRating"),
                    header: 'mangadex.contentRating'.tr(context: context),
                  ),
                  _SectionChildren(
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
                                    label: Text(context.tr(e.label)),
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

                  /// Demographic
                  _SectionHeader(
                    key: ValueKey("_demographic"),
                    header: 'mangadex.demographic'.tr(context: context),
                  ),
                  _SectionChildren(
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
                                            ...fil.value.publicationDemographic,
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

                  /// Pub status
                  _SectionHeader(
                    key: ValueKey("_pubStatus"),
                    header: 'mangadex.pubStatus'.tr(context: context),
                  ),
                  _SectionChildren(
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
                                    label: Text(context.tr(e.label)),
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
                  const Divider(),

                  /// Tags
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
                                (element) => element.attributes.group == group,
                              )
                              .map(
                                (e) => HookBuilder(
                                  builder: (context) {
                                    final value = useListenableSelector(
                                      fil,
                                      () =>
                                          fil.value.includedTags.contains(e)
                                              ? true
                                              : (fil.value.excludedTags
                                                      .contains(e)
                                                  ? false
                                                  : null),
                                    );

                                    return TriStateChip(
                                      label: Text(e.attributes.name.get('en')),
                                      selectedColor: selectedChipColor,
                                      onChanged: (bool? value) {
                                        switch (value) {
                                          case null:
                                            fil.value =
                                                MangaFilterAction.action(
                                                  fil.value,
                                                  includedTags:
                                                      fil.value.includedTags
                                                          .where(
                                                            (element) =>
                                                                element != e,
                                                          )
                                                          .toSet(),
                                                  excludedTags:
                                                      fil.value.excludedTags
                                                          .where(
                                                            (element) =>
                                                                element != e,
                                                          )
                                                          .toSet(),
                                                );
                                            break;
                                          case true:
                                            fil.value =
                                                MangaFilterAction.action(
                                                  fil.value,
                                                  includedTags: {
                                                    ...fil.value.includedTags,
                                                    e,
                                                  },
                                                  excludedTags:
                                                      fil.value.excludedTags
                                                          .where(
                                                            (element) =>
                                                                element != e,
                                                          )
                                                          .toSet(),
                                                );
                                            break;
                                          case false:
                                            fil.value =
                                                MangaFilterAction.action(
                                                  fil.value,
                                                  includedTags:
                                                      fil.value.includedTags
                                                          .where(
                                                            (element) =>
                                                                element != e,
                                                          )
                                                          .toSet(),
                                                  excludedTags: {
                                                    ...fil.value.excludedTags,
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

                  // Modes
                  _SectionHeader(
                    key: ValueKey("Modes"),
                    header: 'search.otherOptions'.tr(context: context),
                  ),
                  _SectionChildren(
                    key: const ValueKey("_modesChildren"),
                    children: [
                      DropdownMenu<TagMode>(
                        label: Text('search.inclusion'.tr(context: context)),
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
                        label: Text('search.exclusion'.tr(context: context)),
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
      padding: const EdgeInsets.symmetric(vertical: 4),
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
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Wrap(spacing: 4.0, runSpacing: 4.0, children: children),
    );
  }
}
