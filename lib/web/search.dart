import 'package:auto_route/auto_route.dart';
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
  const ExtensionSearchPage({
    super.key,
    @PathParam() required this.sourceId,
    this.source,
    this.query,
  });

  final String sourceId;
  final WebSourceInfo? source;
  final SearchRequest? query;

  @override
  Widget build(BuildContext context) {
    if (source != null) {
      return ExtensionSearchWidget(source: source!, query: query);
    }

    return DataProviderWhenWidget(
      provider: getExtensionFromIdProvider(sourceId),
      errorBuilder: (context, child, _, __) => Scaffold(body: child),
      builder: (context, data) {
        return ExtensionSearchWidget(source: data, query: query);
      },
    );
  }
}

class ExtensionSearchWidget extends StatefulHookConsumerWidget {
  const ExtensionSearchWidget({super.key, required this.source, this.query});

  final WebSourceInfo source;
  final SearchRequest? query;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ExtensionSearchWidgetState();
}

class _ExtensionSearchWidgetState extends ConsumerState<ExtensionSearchWidget> {
  Map<String, dynamic>? metadata = {'page': 1};
  SearchRequest? query;

  late final _pagingController = GagakuPagingController<dynamic, HistoryLink>(
    getNextPageKey:
        (state) => state.keys?.last == null ? {'page': 1} : metadata,
    fetchPage: (pageKey) async {
      if (query == null || query!.isEmpty) {
        return PageResultsMetaData([]);
      }

      final results = await ref
          .read(extensionSourceProvider(widget.source.id).notifier)
          .searchManga(query!, metadata);

      final m = results.results?.map(
        (e) => HistoryLink.fromPartialSourceManga(widget.source, e),
      );

      metadata = results.metadata;

      if (m != null) {
        return PageResultsMetaData(m.toList());
      }

      return PageResultsMetaData([]);
    },
    getIsLastPage: (_, __) => metadata == null,
    refresh: () async {
      metadata = {'page': 1};
    },
  );

  @override
  void initState() {
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

    return Scaffold(
      body: WebMangaListWidget(
        physics: const AlwaysScrollableScrollPhysics(),
        showToggle: false,
        title: Text(
          tr.webSources.sourceSearch,
          style: const TextStyle(fontSize: 24),
        ),
        leading: [
          SliverAppBar(
            leading: const BackButton(),
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
                  hintText: tr.search.arg(arg: widget.source.name),
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
                              : SearchRequest(title: term.toLowerCase());
                    });
                    _pagingController.refresh();
                  },
                  trailing: <Widget>[
                    Tooltip(
                      message: tr.search.filters,
                      child: IconButton(
                        onPressed: () async {
                          final result = await nav.push<(List<Tag>, List<Tag>)>(
                            SlideTransitionRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      _ExtensionFilterWidget(
                                        source: widget.source,
                                        filter: query,
                                      ),
                            ),
                          );

                          if (result != null) {
                            setState(() {
                              query =
                                  query != null
                                      ? query!.copyWith(
                                        includedTags: result.$1,
                                        excludedTags: result.$2,
                                      )
                                      : SearchRequest(
                                        includedTags: result.$1,
                                        excludedTags: result.$2,
                                      );
                            });
                            _pagingController.refresh();
                          }
                        },
                        color:
                            (query == null || query!.isFiltersEmpty)
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
                          : SearchRequest(title: term.toLowerCase());
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
                                    : SearchRequest(title: term.toLowerCase());
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

class _ExtensionFilterWidget extends HookConsumerWidget {
  const _ExtensionFilterWidget({required this.source, this.filter});

  final WebSourceInfo source;
  final SearchRequest? filter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SimpleFutureBuilder(
      futureBuilder:
          () => ref.read(extensionSourceProvider(source.id).notifier).getTags(),
      builder: (context, data) {
        final tr = context.t;
        final nav = Navigator.of(context);
        final fil = useValueNotifier<(List<Tag>, List<Tag>)>((
          filter?.includedTags ?? [],
          filter?.excludedTags ?? [],
        ));

        if (data == null) {
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
                        fil.value = ([], []);
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
              final expanded = useState([false]);

              final panelItems = [
                ExpansionPanel(
                  canTapOnHeader: true,
                  isExpanded: expanded.value[0],
                  headerBuilder:
                      (context, isExpanded) => HookBuilder(
                        builder: (context) {
                          final included = useListenableSelector(
                            fil,
                            () => fil.value.$1,
                          );
                          final excluded = useListenableSelector(
                            fil,
                            () => fil.value.$2,
                          );

                          final includedString = included
                              .map((e) => e.label)
                              .join(', ');
                          final excludedString = excluded
                              .map((e) => e.label)
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
                        for (final group in data) ...[
                          _SectionHeader(
                            key: ValueKey(group.label),
                            header: group.label,
                          ),
                          _SectionChildren(
                            key: ValueKey("_${group.label}Children"),
                            children:
                                group.tags
                                    .map(
                                      (e) => HookBuilder(
                                        builder: (context) {
                                          final value = useListenableSelector(
                                            fil,
                                            () =>
                                                fil.value.$1.contains(e)
                                                    ? true
                                                    : (fil.value.$2.contains(e)
                                                        ? false
                                                        : null),
                                          );

                                          return TriStateChip(
                                            label: Text(e.label),
                                            selectedColor: Colors.green,
                                            unselectedColor: Colors.red,
                                            onChanged: (bool? value) {
                                              switch (value) {
                                                case null:
                                                  fil.value = (
                                                    fil.value.$1
                                                        .where(
                                                          (element) =>
                                                              element != e,
                                                        )
                                                        .toList(),
                                                    fil.value.$2
                                                        .where(
                                                          (element) =>
                                                              element != e,
                                                        )
                                                        .toList(),
                                                  );
                                                  break;
                                                case true:
                                                  fil.value = (
                                                    [...fil.value.$1, e],
                                                    fil.value.$2
                                                        .where(
                                                          (element) =>
                                                              element != e,
                                                        )
                                                        .toList(),
                                                  );
                                                  break;
                                                case false:
                                                  fil.value = (
                                                    fil.value.$1
                                                        .where(
                                                          (element) =>
                                                              element != e,
                                                        )
                                                        .toList(),
                                                    [...fil.value.$2, e],
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
          ),
        );
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
