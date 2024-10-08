import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/mangadex/model.dart';
import 'package:gagaku/mangadex/types.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:gagaku/ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hooks_riverpod/legacy.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'library.g.dart';

final libraryViewTypeProvider = StateProvider((ref) => MangaReadingStatus.reading);

@riverpod
Future<List<String>> _getLibraryListByType(_GetLibraryListByTypeRef ref, MangaReadingStatus type) async {
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
    final statuses = useMemoized(() => MangaReadingStatus.values.skip(1).toList());
    final initialtype = ref.read(libraryViewTypeProvider);
    final tabController = useTabController(initialLength: statuses.length, initialIndex: statuses.indexOf(initialtype));

    useEffect(() {
      void tabCallback() {
        ref.read(libraryViewTypeProvider.notifier).state = statuses.elementAt(tabController.index);
      }

      tabController.addListener(tabCallback);
      return () => tabController.removeListener(tabCallback);
    }, [tabController]);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ScrollConfiguration(
          behavior: const MouseTouchScrollBehavior(),
          child: TabBar(
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
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: [
              for (final type in statuses)
                HookConsumer(
                  builder: (context, ref, child) {
                    final currentPage = useState(0);
                    final scrollController = useScrollController();
                    final listProvider = ref.watch(_getLibraryListByTypeProvider(type));

                    switch (listProvider) {
                      case AsyncValue(value: final list?):
                        final titlesProvider = ref.watch(getMangaListByPageProvider(list, currentPage.value));

                        return Column(
                          children: [
                            Expanded(
                              child: Stack(
                                children: [
                                  switch (titlesProvider) {
                                    AsyncValue(:final error?, :final stackTrace?) => RefreshIndicator(
                                        onRefresh: () async {
                                          ref.read(userLibraryProvider.notifier).clear();
                                          return ref.refresh(_getLibraryListByTypeProvider(type).future);
                                        },
                                        child: ErrorList(
                                          error: error,
                                          stackTrace: stackTrace,
                                          message:
                                              "getMangaListByPageProvider(${list.toString()}, ${currentPage.value}) failed",
                                        ),
                                      ),
                                    AsyncValue(value: final mangas) => RefreshIndicator(
                                        onRefresh: () async {
                                          ref.read(userLibraryProvider.notifier).clear();
                                          return ref.refresh(_getLibraryListByTypeProvider(type).future);
                                        },
                                        child: MangaListWidget(
                                          title: Text(
                                            '${list.length} Mangas',
                                            style: const TextStyle(fontSize: 24),
                                          ),
                                          physics: const AlwaysScrollableScrollPhysics(),
                                          controller: scrollController,
                                          children: [
                                            if (mangas != null) MangaListViewSliver(items: mangas),
                                          ],
                                        ),
                                      ),
                                  },
                                  if (titlesProvider.isLoading) ...Styles.loadingOverlay,
                                ],
                              ),
                            ),
                            NumberPaginator(
                              numberPages: max((list.length / MangaDexEndpoints.searchLimit).ceil(), 1),
                              onPageChange: (int index) {
                                currentPage.value = index;
                              },
                            )
                          ],
                        );
                      case AsyncValue(:final error?, :final stackTrace?):
                        return Expanded(
                          child: RefreshIndicator(
                            onRefresh: () async {
                              ref.read(userLibraryProvider.notifier).clear();
                              return ref.refresh(_getLibraryListByTypeProvider(type).future);
                            },
                            child: ErrorList(
                              error: error,
                              stackTrace: stackTrace,
                              message: "_getLibraryListByTypeProvider($type) failed",
                            ),
                          ),
                        );
                      case AsyncValue(:final progress):
                        return ListSpinner(
                          progress: progress?.toDouble(),
                        );
                    }
                  },
                ),
            ],
          ),
        ),
      ],
    );
  }
}
