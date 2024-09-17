import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/config.dart';
import 'package:gagaku/ui.dart';
import 'package:gagaku/web/model/config.dart';
import 'package:gagaku/web/model/model.dart';
import 'package:gagaku/web/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WebSourceSearchWidget extends HookConsumerWidget {
  const WebSourceSearchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gagakucfg = ref.watch(gagakuSettingsProvider);
    final cfg = ref.watch(webConfigProvider);
    final controller = useTextEditingController();
    final searchTerm = useState('');
    final sources = ref.watch(webSourceManagerProvider);
    final api = ref.watch(proxyProvider);

    Widget? sourcesResult = switch (sources) {
      AsyncError(:final error, :final stackTrace) => SliverToBoxAdapter(
          child: ErrorColumn(
            error: error,
            stackTrace: stackTrace,
            message: "webSourceManagerProvider() failed",
          ),
        ),
      AsyncData(value: final src) when src != null && src.sources.isNotEmpty => null,
      AsyncData(value: final src) when src == null || src.sources.isEmpty => const SliverToBoxAdapter(
          child: Center(
            child: Text("No sources installed!"),
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
        leading: [
          SliverAppBar(
            leading: const BackButton(),
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
                      autocorrect: false,
                      onTapOutside: (event) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      controller: controller,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.search),
                        hintText: 'Search Web Sources...',
                      ),
                      onSubmitted: (value) {
                        searchTerm.value = value;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        children: [
          if (sourcesResult != null) sourcesResult,
          if (sourcesResult == null)
            for (var MapEntry(key: key, value: src) in sources.value!.sources.entries) ...[
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    src.name,
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
              ),
              HookBuilder(
                builder: (context) {
                  final results = useMemoized(
                      () => sources.value!.searchManga(key, searchTerm.value.toLowerCase(), api.client),
                      [searchTerm.value]);
                  final future = useFuture(results);

                  if (future.hasError) {
                    return SliverToBoxAdapter(
                      child: ErrorColumn(
                        error: future.error!,
                        stackTrace: future.stackTrace!,
                        message: "WebSource($src).searchManga() failed",
                      ),
                    );
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
                      maxCrossAxisExtent: gagakucfg.gridAlbumExtent.grid,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      childAspectRatio: 0.7,
                    ),
                    itemBuilder: (context, index) {
                      final item = data.elementAt(index);
                      return GridMangaItem(
                        key: ValueKey(item.hashCode),
                        link: item,
                        favoritesKey: cfg.defaultCategory,
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
