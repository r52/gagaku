import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/mangadex/model.dart';
import 'package:gagaku/mangadex/types.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:gagaku/ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//part 'search.g.dart';

final _searchParamsProvider = StateProvider(
    (ref) => const MangaSearchParameters(query: '', filter: MangaFilters()));

class MangaDexSearchWidget extends HookConsumerWidget {
  const MangaDexSearchWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nav = Navigator.of(context);
    final filter = ref.watch(_searchParamsProvider);
    final controller = useTextEditingController();
    final debounce = useRef<Timer?>(null);

    final results = ref.watch(mangaSearchProvider(filter));
    final isLoading = results.isLoading && results.isReloading;

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
          title: DropdownButton<FilterOrder>(
            value: filter.filter.order,
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            underline: Container(
              height: 2,
              color: Colors.deepOrangeAccent,
            ),
            onChanged: (FilterOrder? order) async {
              if (order != null) {
                ref.read(_searchParamsProvider.notifier).state =
                    filter.copyWith(
                  query: filter.query,
                  filter: filter.filter.copyWith(order: order),
                );
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
          onAtEdge: () {
            final lt = ref.read(_searchParamsProvider);
            ref.read(mangaSearchProvider(lt).notifier).getMore();
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
            switch (results) {
              AsyncValue(:final error?, :final stackTrace?) => () {
                  final messenger = ScaffoldMessenger.of(context);
                  Styles.showErrorSnackBar(messenger, '$error');
                  logger.e("mangaSearchProvider(filter) failed",
                      error: error, stackTrace: stackTrace);

                  return SliverToBoxAdapter(
                    child: Styles.errorColumn(error, stackTrace),
                  );
                }(),
              AsyncValue(:final value?) => () {
                  if (value.isNotEmpty) {
                    return MangaListViewSliver(items: value);
                  }

                  return const SliverToBoxAdapter(
                    child: Center(
                      child: Text("No results!"),
                    ),
                  );
                }(),
              _ => const SliverToBoxAdapter(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            },
            if (!results.isLoading &&
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
    final tags = ref.watch(tagListProvider);

    const headingStyle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );

    const selectedChipColor = Colors.deepOrangeAccent;

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            nav.pop(null);
          },
        ),
        title: const Text('Search Filters'),
        actions: [
          ButtonBar(
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
      body: switch (tags) {
        AsyncData(:final value) => () {
            final selectedFilters = [
              ...fil.value.includedTags
                  .map(
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
                  )
                  .toList(),
              ...fil.value.excludedTags
                  .map(
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
                      side: const BorderSide(color: selectedChipColor),
                    ),
                  )
                  .toList()
            ];

            return SafeArea(
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
                            label: Text(e.formatted),
                            selectedColor: selectedChipColor,
                            selected: fil.value.contentRating.contains(e),
                            onSelected: (bool value) {
                              if (value) {
                                fil.value = fil.value.copyWith(
                                  contentRating: {
                                    ...fil.value.contentRating,
                                    e
                                  },
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
                              label: Text(e.formatted),
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
                        .skip(1)
                        .map(
                          (e) => FilterChip(
                            label: Text(e.formatted),
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

                  /// Tags
                  for (final group in TagGroup.values) ...[
                    ..._buildSection(
                      header: Text(
                        group.formatted,
                        style: headingStyle,
                      ),
                      children: value
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
                              value: () {
                                if (fil.value.includedTags.contains(e)) {
                                  return true;
                                }

                                if (fil.value.excludedTags.contains(e)) {
                                  return false;
                                }

                                return null;
                              }(),
                            ),
                          )
                          .toList(),
                    ),
                  ]
                ],
              ),
            );
          }(),
        AsyncError(:final error, :final stackTrace) => () {
            final messenger = ScaffoldMessenger.of(context);
            Styles.showErrorSnackBar(messenger, '$error');
            logger.e("tagListProvider failed",
                error: error, stackTrace: stackTrace);

            return Styles.errorColumn(error, stackTrace);
          }(),
        _ => const Center(
            child: CircularProgressIndicator(),
          ),
      },
    );
  }
}
