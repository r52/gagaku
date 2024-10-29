import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/mangadex/model.dart';
import 'package:gagaku/mangadex/types.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:gagaku/util/default_scroll_controller.dart';
import 'package:gagaku/util/ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'library.g.dart';

@Riverpod(keepAlive: true)
class LibraryViewType extends _$LibraryViewType {
  @override
  MangaReadingStatus build() => MangaReadingStatus.reading;

  @override
  set state(MangaReadingStatus newState) => super.state = newState;
  MangaReadingStatus update(MangaReadingStatus Function(MangaReadingStatus state) cb) => state = cb(state);
}

@riverpod
Future<List<String>> _getLibraryListByType(Ref ref, MangaReadingStatus type) async {
  final library = await ref.watch(userLibraryProvider.future);

  final results = library.entries.where((element) => element.value == type).map((e) => e.key).toList();

  return results;
}

class MangaDexLibraryView extends HookConsumerWidget {
  const MangaDexLibraryView({
    super.key,
    this.controller,
  });

  final ScrollController? controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = DefaultScrollController.maybeOf(context) ?? controller;
    final statuses = useMemoized(() => MangaReadingStatus.values.skip(1).toList());
    final initialtype = ref.read(libraryViewTypeProvider);
    final tabController = useTabController(initialLength: statuses.length, initialIndex: statuses.indexOf(initialtype));

    useEffect(() {
      void tabCallback() {
        if (!tabController.indexIsChanging) {
          ref.read(libraryViewTypeProvider.notifier).state = statuses.elementAt(tabController.index);
        }
      }

      tabController.addListener(tabCallback);
      return () => tabController.removeListener(tabCallback);
    }, [tabController]);

    return NestedScrollView(
      controller: scrollController,
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          MangaDexSliverAppBar(
            title: 'Library',
            controller: scrollController,
          ),
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: SliverAppBar(
              forceElevated: innerBoxIsScrolled,
              automaticallyImplyLeading: false,
              primary: false,
              pinned: true,
              bottom: TabBar(
                tabAlignment: TabAlignment.center,
                isScrollable: true,
                controller: tabController,
                tabs: List<Tab>.generate(
                  statuses.length,
                  (int index) => Tab(
                    text: statuses.elementAt(index).label,
                  ),
                ),
              ),
            ),
          ),
        ];
      },
      body: TabBarView(
        controller: tabController,
        children: [
          for (final type in statuses)
            HookConsumer(
              builder: (context, ref, child) {
                final currentPage = useState(0);
                final listProvider = ref.watch(_getLibraryListByTypeProvider(type));

                return RefreshIndicator(
                  onRefresh: () async {
                    ref.read(userLibraryProvider.notifier).clear();
                    return ref.refresh(_getLibraryListByTypeProvider(type).future);
                  },
                  child: switch (listProvider) {
                    AsyncValue(value: final list?) => Consumer(
                        builder: (context, ref, child) {
                          final titlesProvider = ref.watch(getMangaListByPageProvider(list, currentPage.value));

                          return Column(
                            children: [
                              Expanded(
                                child: switch (titlesProvider) {
                                  AsyncValue(:final error?, :final stackTrace?) => ErrorList(
                                      error: error,
                                      stackTrace: stackTrace,
                                      message:
                                          "getMangaListByPageProvider(${list.toString()}, ${currentPage.value}) failed",
                                    ),
                                  AsyncValue(value: final mangas) => MangaListWidget(
                                      title: Text(
                                        '${list.length} Mangas',
                                        style: const TextStyle(fontSize: 24),
                                      ),
                                      physics: const AlwaysScrollableScrollPhysics(),
                                      noController: true,
                                      isLoading: titlesProvider.isLoading,
                                      leading: [
                                        SliverOverlapInjector(
                                          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                                        ),
                                      ],
                                      children: [
                                        if (mangas == null || mangas.isEmpty)
                                          SliverToBoxAdapter(
                                            child: Center(
                                              child: Text('No Titles'),
                                            ),
                                          ),
                                        if (mangas != null) MangaListViewSliver(items: mangas),
                                      ],
                                    ),
                                },
                              ),
                              NumberPaginator(
                                numberPages: max((list.length / MangaDexEndpoints.searchLimit).ceil(), 1),
                                onPageChange: (int index) {
                                  currentPage.value = index;
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    AsyncValue(:final error?, :final stackTrace?) => ErrorList(
                        error: error,
                        stackTrace: stackTrace,
                        message: "_getLibraryListByTypeProvider($type) failed",
                      ),
                    AsyncValue(:final progress) => ListSpinner(
                        progress: progress?.toDouble(),
                      ),
                  },
                );
              },
            ),
        ],
      ),
    );
  }
}
