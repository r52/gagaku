import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/mangadex/login_password.dart';
import 'package:gagaku/mangadex/model/model.dart';
import 'package:gagaku/mangadex/model/types.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:gagaku/model/common.dart';
import 'package:gagaku/util/default_scroll_controller.dart';
import 'package:gagaku/util/ui.dart';
import 'package:gagaku/util/util.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:riverpod_annotation/experimental/scope.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'library.g.dart';

@Riverpod(keepAlive: true)
class LibraryViewType extends _$LibraryViewType {
  @override
  MangaReadingStatus build() => MangaReadingStatus.reading;

  @override
  set state(MangaReadingStatus newState) => super.state = newState;
  MangaReadingStatus update(
    MangaReadingStatus Function(MangaReadingStatus state) cb,
  ) => state = cb(state);
}

@Riverpod(retry: noRetry)
Future<List<String>> _getLibraryListByType(
  Ref ref,
  MangaReadingStatus type,
) async {
  final me = await ref.watch(loggedUserProvider.future);
  final library = await ref.watch(userLibraryProvider(me?.id).future);

  final results = library.entries
      .where((element) => element.value == type)
      .map((e) => e.key)
      .toList();

  return results;
}

@Dependencies([chipTextStyle])
class MangaDexLibraryPage extends StatelessWidget {
  const MangaDexLibraryPage({super.key, this.controller});

  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    return MangaDexLoginWidget(
      builder: (context) => MangaDexLibraryWidget(controller: controller),
    );
  }
}

@Dependencies([chipTextStyle])
class MangaDexLibraryWidget extends HookConsumerWidget {
  const MangaDexLibraryWidget({super.key, this.controller});

  final ScrollController? controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final me = ref.watch(loggedUserProvider).value;
    final scrollController =
        DefaultScrollController.maybeOf(context, 'MangaDexLibraryPage') ??
        controller ??
        useScrollController();
    final statuses = useMemoized(
      () => MangaReadingStatus.values.skip(1).toList(),
    );
    final initialtype = ref.read(libraryViewTypeProvider);
    final tabController = useTabController(
      initialLength: statuses.length,
      initialIndex: statuses.indexOf(initialtype),
    );

    useEffect(() {
      void tabCallback() {
        if (!tabController.indexIsChanging) {
          ref.read(libraryViewTypeProvider.notifier).state =
              statuses[tabController.index];
        }
      }

      tabController.addListener(tabCallback);
      return () => tabController.removeListener(tabCallback);
    }, [tabController]);

    return NestedScrollView(
      scrollBehavior: const MouseTouchScrollBehavior(),
      controller: scrollController,
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          MangaDexSliverAppBar(title: t.library, controller: scrollController),
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
                  (int index) => Tab(text: t[statuses[index].label]),
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
                final currentPage = useValueNotifier(0);

                return RefreshIndicator(
                  key: ValueKey('LibraryTab(${me?.id}, $type)'),
                  onRefresh: () async {
                    ref.read(userLibraryProvider(me?.id).notifier).clear();
                    return ref.refresh(
                      _getLibraryListByTypeProvider(type).future,
                    );
                  },
                  child: DataProviderWhenWidget(
                    provider: _getLibraryListByTypeProvider(type),
                    builder: (context, list) => Column(
                      children: [
                        Expanded(
                          child: HookConsumer(
                            builder: (context, ref, child) {
                              final page = useValueListenable(currentPage);
                              final data = useMemoized(
                                () => getMangaListByPage(ref, list, page),
                                [list, page],
                              );
                              final future = useFuture(data);

                              return MangaListWidget(
                                title: Text(
                                  t.num_manga(n: list.length),
                                  style: CommonTextStyles.twentyfour,
                                ),
                                scrollBehavior: MouseTouchScrollBehavior()
                                    .copyWith(scrollbars: false),
                                physics: const AlwaysScrollableScrollPhysics(),
                                noController: true,
                                future: future,
                                leading: [
                                  SliverOverlapInjector(
                                    handle:
                                        NestedScrollView.sliverOverlapAbsorberHandleFor(
                                          context,
                                        ),
                                  ),
                                ],
                                children: [
                                  if (future.hasData &&
                                      (future.data == null ||
                                          future.data!.isEmpty))
                                    SliverToBoxAdapter(
                                      child: Center(
                                        child: Text(t.errors.notitles),
                                      ),
                                    ),
                                  if (future.hasData && future.data != null)
                                    MangaListViewSliver(items: future.data),
                                ],
                              );
                            },
                          ),
                        ),
                        HookBuilder(
                          builder: (context) {
                            final _ = useValueListenable(currentPage);
                            return NumberPaginator(
                              numberPages: max(
                                (list.length / MangaDexEndpoints.searchLimit)
                                    .ceil(),
                                1,
                              ),
                              onPageChange: (int index) {
                                scrollController.jumpTo(0.0);
                                currentPage.value = index;
                              },
                            );
                          },
                        ),
                      ],
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
