import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/mangadex/model.dart';
import 'package:gagaku/mangadex/types.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:gagaku/ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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

    Widget child;
    Widget? paginator;

    switch (listProvider) {
      case AsyncValue(valueOrNull: final list?):
        final titlesProvider =
            ref.watch(getMangaListByPageProvider(list, currentPage.value));

        isLoading = titlesProvider.isLoading;

        paginator = NumberPaginator(
          numberPages:
              max((list.length / MangaDexEndpoints.searchLimit).ceil(), 1),
          onPageChange: (int index) {
            currentPage.value = index;
          },
        );

        child = switch (titlesProvider) {
          AsyncValue(valueOrNull: final mangas?) => RefreshIndicator(
              onRefresh: () {
                ref.read(userLibraryProvider.notifier).clear();
                final lt = ref.read(libraryViewTypeProvider);
                return ref.refresh(_getLibraryListByTypeProvider(lt).future);
              },
              child: MangaListWidget(
                title: Text(
                  '${list.length} Mangas',
                  style: const TextStyle(fontSize: 24),
                ),
                physics: const AlwaysScrollableScrollPhysics(),
                controller: controller,
                children: [
                  MangaListViewSliver(items: mangas),
                ],
              ),
            ),
          AsyncValue(:final error?, :final stackTrace?) => () {
              final messenger = ScaffoldMessenger.of(context);
              Styles.showErrorSnackBar(messenger, '$error');
              logger.e(
                  "getMangaListByPageProvider(${list.toString()}, ${currentPage.value}) failed",
                  error: error,
                  stackTrace: stackTrace);

              return RefreshIndicator(
                onRefresh: () {
                  ref.read(userLibraryProvider.notifier).clear();
                  return ref
                      .refresh(_getLibraryListByTypeProvider(type).future);
                },
                child: Styles.errorList(error, stackTrace),
              );
            }(),
          _ => const SizedBox.shrink(),
        };
        break;
      case AsyncValue(:final error?, :final stackTrace?):
        final messenger = ScaffoldMessenger.of(context);
        Styles.showErrorSnackBar(messenger, '$error');
        logger.e("_getLibraryListByTypeProvider($type) failed",
            error: error, stackTrace: stackTrace);

        child = RefreshIndicator(
          onRefresh: () {
            ref.read(userLibraryProvider.notifier).clear();
            return ref.refresh(_getLibraryListByTypeProvider(type).future);
          },
          child: Styles.errorList(error, stackTrace),
        );
        break;
      case _:
        child = Styles.listSpinner;
        break;
    }

    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    DropdownMenu<MangaReadingStatus>(
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
                          value: MangaReadingStatus.values
                              .skip(1)
                              .elementAt(index),
                          label: MangaReadingStatus.values
                              .skip(1)
                              .elementAt(index)
                              .formatted,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: child,
                ),
                if (paginator != null) paginator,
              ],
            ),
            if (isLoading) ...Styles.loadingOverlay,
          ],
        ),
      ),
    );
  }
}
