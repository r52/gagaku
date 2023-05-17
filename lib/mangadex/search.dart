import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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
    final filter = ref.watch(_searchParamsProvider);
    final results = ref.watch(mangaSearchProvider(filter));
    final controller = useTextEditingController();
    final debounce = useRef<Timer?>(null);

    useEffect(() {
      return () => debounce.value?.cancel();
    }, [debounce]);

    useEffect(() {
      controller.text = filter.query;
      return null;
    }, [filter]);

    void onSearchChanged(String query) {
      if (debounce.value?.isActive ?? false) debounce.value?.cancel();
      debounce.value = Timer(const Duration(milliseconds: 750), () {
        ref.read(_searchParamsProvider.notifier).state =
            filter.copyWith(query: query, filter: filter.filter);
      });
    }

    return Scaffold(
        body: MangaListWidget(
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
            ref.read(_searchParamsProvider.notifier).state = filter.copyWith(
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
                    final nav = Navigator.of(context);
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
        results.when(
          skipLoadingOnReload: true,
          data: (data) {
            if (data.isNotEmpty) {
              return MangaListViewSliver(items: data);
            }

            return const SliverToBoxAdapter(
              child: Center(
                child: Text("No results!"),
              ),
            );
          },
          loading: () => const SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
          error: (err, stackTrace) {
            final messenger = ScaffoldMessenger.of(context);
            Future.delayed(
              Duration.zero,
              () => messenger
                ..removeCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text('$err'),
                    backgroundColor: Colors.red,
                  ),
                ),
            );

            return SliverToBoxAdapter(
              child: Center(
                child: Text('Error: $err'),
              ),
            );
          },
        )
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
          children: children,
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final fil = useState(filter);
    final tags = ref.watch(tagListProvider);

    const headingStyle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pop(null);
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
                    Navigator.of(context).pop(fil.value);
                  },
                  icon: const Icon(Icons.filter_list),
                  label: const Text('Apply Filters'),
                ),
              ),
            ],
          )
        ],
      ),
      body: tags.when(
        data: (tagres) {
          final selectedFilters = [
            ...fil.value.includedTags
                .map((e) => Padding(
                      padding: const EdgeInsets.all(2),
                      child: InputChip(
                        label: Text(e.attributes.name.get('en')),
                        avatar: const Icon(Icons.add),
                        onDeleted: () {
                          fil.value = fil.value.copyWith(
                            includedTags: fil.value.includedTags
                                .where((element) => element != e)
                                .toSet(),
                          );
                        },
                        backgroundColor: Colors.deepOrangeAccent,
                      ),
                    ))
                .toList(),
            ...fil.value.excludedTags
                .map((e) => Padding(
                      padding: const EdgeInsets.all(2),
                      child: InputChip(
                        label: Text(e.attributes.name.get('en')),
                        avatar: const Icon(Icons.remove),
                        onDeleted: () {
                          fil.value = fil.value.copyWith(
                            excludedTags: fil.value.excludedTags
                                .where((element) => element != e)
                                .toSet(),
                          );
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
                      .map((e) => Padding(
                            padding: const EdgeInsets.all(2),
                            child: FilterChip(
                              label: Text(e.formatted),
                              selectedColor: Colors.deepOrangeAccent,
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
                          ))
                      .toList(),
                ),

                /// Demographic
                ..._buildSection(
                  header: const Text(
                    'Demographic',
                    style: headingStyle,
                  ),
                  children: MangaDemographic.values
                      .map((e) => Padding(
                          padding: const EdgeInsets.all(2),
                          child: FilterChip(
                            label: Text(e.formatted),
                            selectedColor: Colors.deepOrangeAccent,
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
                          )))
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
                      .map((e) => Padding(
                            padding: const EdgeInsets.all(2),
                            child: FilterChip(
                              label: Text(e.formatted),
                              selectedColor: Colors.deepOrangeAccent,
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
                          ))
                      .toList(),
                ),

                /// Tags
                for (final group in TagGroup.values) ...[
                  ..._buildSection(
                    header: Text(
                      group.formatted,
                      style: headingStyle,
                    ),
                    children: tagres
                        .where((element) => element.attributes.group == group)
                        .map((e) => Padding(
                              padding: const EdgeInsets.all(2),
                              child: TriStateChip(
                                label: Text(e.attributes.name.get('en')),
                                selectedColor: Colors.deepOrangeAccent,
                                unselectedColor: theme.primaryColor,
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
                            ))
                        .toList(),
                  ),
                ]
              ],
            ),
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (err, stackTrace) {
          final messenger = ScaffoldMessenger.of(context);
          Future.delayed(
            Duration.zero,
            () => messenger
              ..removeCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text('$err'),
                  backgroundColor: Colors.red,
                ),
              ),
          );

          return Text('Error: $err');
        },
      ),
    );
  }
}
