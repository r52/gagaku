import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/log.dart';
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
  final SourceIdentifier source;

  const WebSourceSearchWidget({super.key, required this.source});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final defaultCategory = ref.watch(webConfigProvider.select((cfg) => cfg.defaultCategory));
    final controller = useSearchController();

    final items = useState(<HistoryLink>[]);
    final trigger = useState(UniqueKey());
    final metadata = useRef<Map<String, dynamic>?>({'page': 1});
    final searchTerm = useRef<String?>(null);

    final results = useMemoized(() async {
      if (metadata.value != null) {
        final results = await ref
            .read(extensionSourceProvider(source.internal.id).notifier)
            .searchManga(SearchRequest(title: searchTerm.value?.toLowerCase()), metadata.value);

        final m = results.results?.map((e) => HistoryLink.fromPartialSourceManga(source.internal.id, e));
        if (m != null) {
          items.value.addAll(m);
        }

        metadata.value = results.metadata;
      }

      return items.value;
    }, [trigger.value]);
    final future = useFuture(results);

    Widget? errorList;

    if (future.hasError) {
      final error = future.error!;
      final stackTrace = future.stackTrace!;
      final msg = "ExtensionSource(${source.internal.id}).searchManga() failed";

      final messenger = ScaffoldMessenger.of(context);
      Styles.showErrorSnackBar(messenger, '$error');
      logger.e(msg, error: error, stackTrace: stackTrace);

      errorList = SliverList.list(children: [
        Text('$error'),
        Text(stackTrace.toString()),
      ]);
    }

    return Scaffold(
      body: WebMangaListWidget(
        physics: const AlwaysScrollableScrollPhysics(),
        showToggle: false,
        title: Text(
          'webSources.sourceSearch'.tr(context: context),
          style: const TextStyle(fontSize: 24),
        ),
        onAtEdge: () {
          if (metadata.value != null) {
            trigger.value = UniqueKey();
          }
        },
        isLoading: future.connectionState == ConnectionState.waiting || !future.hasData,
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
                  hintText: 'search.arg'.tr(context: context, args: [source.external.name]),
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
                    metadata.value = {'page': 1};
                    items.value = [];
                    trigger.value = UniqueKey();

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
                metadata.value = {'page': 1};
                items.value = [];
                trigger.value = UniqueKey();

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
                            metadata.value = {'page': 1};
                            items.value = [];
                            trigger.value = UniqueKey();

                            unfocusSearchBar();
                          },
                        ))
                    .toList();
              },
            ),
          ),
        ],
        children: [
          if (errorList != null) errorList,
          WebMangaListViewSliver(
            items: items.value,
            favoritesKey: defaultCategory,
            showRemoveButton: false,
            removeFromAll: true,
          ),
        ],
      ),
    );
  }
}
