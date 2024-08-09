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

final libraryViewTypeProvider =
    StateProvider((ref) => MangaReadingStatus.reading);

@riverpod
Future<List<String>> _getLibraryListByType(
    _GetLibraryListByTypeRef ref, MangaReadingStatus type) async {
  final library = await ref.watch(userLibraryProvider.future);

  final results = library.entries
      .where((element) => element.value == type)
      .map((e) => e.key)
      .toList();

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
    final theme = Theme.of(context);
    final type = ref.watch(libraryViewTypeProvider);
    final currentPage = useState(0);
    bool isLoading = false;

    final listProvider = ref.watch(_getLibraryListByTypeProvider(type));

    List<Widget> children;

    switch (listProvider) {
      case AsyncValue(value: final list?):
        final titlesProvider =
            ref.watch(getMangaListByPageProvider(list, currentPage.value));

        isLoading = titlesProvider.isLoading;

        children = [
          Expanded(
            child: switch (titlesProvider) {
              AsyncValue(:final error?, :final stackTrace?) => RefreshIndicator(
                  onRefresh: () async {
                    ref.read(userLibraryProvider.notifier).clear();
                    return ref
                        .refresh(_getLibraryListByTypeProvider(type).future);
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
                    final lt = ref.read(libraryViewTypeProvider);
                    return ref
                        .refresh(_getLibraryListByTypeProvider(lt).future);
                  },
                  child: MangaListWidget(
                    title: Text(
                      '${list.length} Mangas',
                      style: const TextStyle(fontSize: 24),
                    ),
                    physics: const AlwaysScrollableScrollPhysics(),
                    controller: controller,
                    children: [
                      if (mangas != null) MangaListViewSliver(items: mangas),
                    ],
                  ),
                ),
            },
          ),
          NumberPaginator(
            numberPages:
                max((list.length / MangaDexEndpoints.searchLimit).ceil(), 1),
            onPageChange: (int index) {
              currentPage.value = index;
            },
          )
        ];
        break;
      case AsyncValue(:final error?, :final stackTrace?):
        children = [
          Expanded(
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
          ),
        ];
        break;
      case _:
        children = [Styles.listSpinner];
        break;
    }

    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: const Alignment(-0.95, 0.0),
                  child: DropdownMenu<MangaReadingStatus>(
                    initialSelection: type,
                    enableFilter: false,
                    enableSearch: false,
                    requestFocusOnTap: false,
                    inputDecorationTheme: InputDecorationTheme(
                      filled: true,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 2.0,
                          color: theme.colorScheme.inversePrimary,
                        ),
                      ),
                    ),
                    onSelected: (MangaReadingStatus? status) async {
                      if (status != null) {
                        ref.read(libraryViewTypeProvider.notifier).state =
                            status;
                        currentPage.value = 0;
                      }
                    },
                    dropdownMenuEntries:
                        List<DropdownMenuEntry<MangaReadingStatus>>.generate(
                      MangaReadingStatus.values.skip(1).length,
                      (int index) => DropdownMenuEntry<MangaReadingStatus>(
                        value:
                            MangaReadingStatus.values.skip(1).elementAt(index),
                        label: MangaReadingStatus.values
                            .skip(1)
                            .elementAt(index)
                            .label,
                      ),
                    ),
                  ),
                ),
                ...children,
              ],
            ),
            if (isLoading) ...Styles.loadingOverlay,
          ],
        ),
      ),
    );
  }
}
