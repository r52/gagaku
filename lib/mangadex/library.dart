import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/mangadex/model/model.dart';
import 'package:gagaku/mangadex/model/types.dart';
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
  final me = await ref.watch(loggedUserProvider.future);
  final library = await ref.watch(userLibraryProvider(me?.id).future);

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
    final me = ref.watch(loggedUserProvider).value;
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
            title: 'library'.tr(context: context),
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
                    text: context.tr(statuses.elementAt(index).label),
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

                return RefreshIndicator(
                  key: ValueKey('LibraryTab(${me?.id}, $type)'),
                  onRefresh: () async {
                    ref.read(userLibraryProvider(me?.id).notifier).clear();
                    return ref.refresh(_getLibraryListByTypeProvider(type).future);
                  },
                  child: DataProviderWhenWidget(
                    provider: _getLibraryListByTypeProvider(type),
                    builder: (context, list) => Consumer(
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
                                      'num_manga'.plural(list.length),
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
                                            child: Text('errors.notitles'.tr(context: context)),
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
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
