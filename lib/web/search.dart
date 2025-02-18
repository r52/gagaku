import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/model/config.dart';
import 'package:gagaku/util/ui.dart';
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
  List<String> update(List<String> Function(List<String> state) cb) => state = cb(state);
}

class WebSourceSearchWidget extends HookConsumerWidget {
  const WebSourceSearchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gridExtent = ref.watch(gagakuSettingsProvider.select((c) => c.gridAlbumExtent));
    final defaultCategory = ref.watch(webConfigProvider.select((cfg) => cfg.defaultCategory));
    final controller = useSearchController();
    final searchTerm = useState('');
    final sources = ref.watch(extensionInfoListProvider);

    Widget? sourcesResult = switch (sources) {
      AsyncError(:final error, :final stackTrace) => SliverToBoxAdapter(
          child: ErrorList(
            error: error,
            stackTrace: stackTrace,
            message: "webSourceManagerProvider() failed",
          ),
        ),
      AsyncData(value: final src) when src.isNotEmpty => null,
      AsyncData(value: final src) when src.isEmpty => SliverToBoxAdapter(
          child: Center(
            child: Text("webSources.noSourcesWarning".tr(context: context)),
          ),
        ),
      _ => const SliverToBoxAdapter(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
    };

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
                  hintText: 'search.arg'.tr(context: context, args: ['webSources.text'.tr(context: context)]),
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
                      ref.read(_searchHistoryProvider.notifier).state = {term, ...history}.take(5).toList();
                    }

                    searchTerm.value = term;

                    unfocusSearchBar();
                  },
                );
              },
              viewOnSubmitted: (value) {
                final term = value.trim();
                if (term.isNotEmpty) {
                  final history = ref.read(_searchHistoryProvider);
                  ref.read(_searchHistoryProvider.notifier).state = {term, ...history}.take(5).toList();
                }

                controller.closeView(term);
                searchTerm.value = term;

                unfocusSearchBar();
              },
              suggestionsBuilder: (BuildContext context, SearchController controller) {
                final history = ref.read(_searchHistoryProvider);
                return history
                    .map((e) => ListTile(
                          titleAlignment: ListTileTitleAlignment.center,
                          title: Text(e),
                          onTap: () {
                            final term = e.trim();
                            if (term.isNotEmpty) {
                              final history = ref.read(_searchHistoryProvider);
                              ref.read(_searchHistoryProvider.notifier).state = {term, ...history}.take(5).toList();
                            }

                            controller.closeView(term);
                            searchTerm.value = term;

                            unfocusSearchBar();
                          },
                        ))
                    .toList();
              },
            ),
          ),
        ],
        children: [
          if (sourcesResult != null) sourcesResult,
          if (sourcesResult == null)
            for (final src in sources.value!) ...[
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    src.external.name,
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
              ),
              HookBuilder(
                builder: (context) {
                  final results = useMemoized(
                      () => ref
                          .read(extensionSourceProvider(src.internal.id).notifier)
                          .searchManga(SearchRequest(title: searchTerm.value.toLowerCase())),
                      [searchTerm.value]);
                  final future = useFuture(results);

                  if (future.hasError) {
                    final error = future.error!;
                    final stackTrace = future.stackTrace!;
                    final msg = "WebSource($src).searchManga() failed";

                    final messenger = ScaffoldMessenger.of(context);
                    Styles.showErrorSnackBar(messenger, '$error');
                    logger.e(msg, error: error, stackTrace: stackTrace);

                    return SliverList.list(children: [
                      Text('$error'),
                      Text(stackTrace.toString()),
                    ]);
                  }

                  if (future.connectionState == ConnectionState.waiting || !future.hasData) {
                    return const SliverToBoxAdapter(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  final data = future.data!;

                  return SliverGrid.builder(
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: gridExtent.grid,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      childAspectRatio: 0.7,
                    ),
                    itemBuilder: (context, index) {
                      final item = data.elementAt(index);
                      return GridMangaItem(
                        key: ValueKey(item.hashCode),
                        link: item,
                        favoritesKey: defaultCategory,
                        showFavoriteButton: false,
                        showRemoveButton: false,
                      );
                    },
                    itemCount: data.length,
                  );
                },
              ),
            ]
        ],
      ),
    );
  }
}
