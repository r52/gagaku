import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/util/infinite_scroll.dart';
import 'package:gagaku/util/util.dart';
import 'package:gagaku/web/model/config.dart';
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

class WebSourceSearchWidget extends StatefulHookConsumerWidget {
  const WebSourceSearchWidget({super.key, required this.source});

  final SourceIdentifier source;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _WebSourceSearchWidgetState();
}

class _WebSourceSearchWidgetState extends ConsumerState<WebSourceSearchWidget> {
  Map<String, dynamic>? metadata = {'page': 1};
  String? searchTerm;

  late final _pagingController = GagakuPagingController<dynamic, HistoryLink>(
    getNextPageKey:
        (state) => state.keys?.last == null ? {'page': 1} : metadata,
    fetchPage: (pageKey) async {
      if (searchTerm == null || searchTerm!.isEmpty) {
        return [];
      }

      final results = await ref
          .read(extensionSourceProvider(widget.source.internal.id).notifier)
          .searchManga(
            SearchRequest(title: searchTerm?.toLowerCase()),
            metadata,
          );

      final m = results.results?.map(
        (e) => HistoryLink.fromPartialSourceManga(widget.source.internal.id, e),
      );

      metadata = results.metadata;

      if (m != null) {
        return m.toList();
      }

      return [];
    },
    getIsLastPage: (_, __) => metadata == null,
    refresh: () async {
      metadata = {'page': 1};
    },
  );

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultCategory = ref.watch(
      webConfigProvider.select((cfg) => cfg.defaultCategory),
    );
    final controller = useSearchController();

    return Scaffold(
      body: WebMangaListWidget(
        physics: const AlwaysScrollableScrollPhysics(),
        showToggle: false,
        title: Text(
          'webSources.sourceSearch'.tr(context: context),
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
                  hintText: 'search.arg'.tr(
                    context: context,
                    args: [widget.source.external.name],
                  ),
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
                      searchTerm = term;
                    });
                    _pagingController.refresh();
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

                if (controller.isOpen) {
                  controller.closeView(term);
                }

                unfocusSearchBar();

                setState(() {
                  searchTerm = term;
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
                            searchTerm = term;
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
            favoritesKey: defaultCategory,
            showRemoveButton: false,
            removeFromAll: true,
          ),
        ],
      ),
    );
  }
}
