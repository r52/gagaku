import 'package:flutter/material.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/mangadex/model.dart';
import 'package:gagaku/mangadex/types.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:gagaku/ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final libraryViewTypeProvider =
    StateProvider((ref) => MangaReadingStatus.reading);

class MangaDexLibraryView extends ConsumerWidget {
  const MangaDexLibraryView({
    super.key,
    this.controller,
  });

  final ScrollController? controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final type = ref.watch(libraryViewTypeProvider);
    final results = ref.watch(userLibraryProvider(type));
    final isLoading = results.isLoading;

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ToggleButtons(
                  isSelected: List<bool>.generate(
                      MangaReadingStatus.values.skip(1).length,
                      (index) => type.index == (index + 1)),
                  onPressed: (index) {
                    ref.read(libraryViewTypeProvider.notifier).state =
                        MangaReadingStatus.values.skip(1).elementAt(index);
                  },
                  children: [
                    ...MangaReadingStatus.values
                        .skip(1)
                        .map((e) => Text(
                              e.formatted,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ))
                        .toList()
                  ],
                ),
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  switch (results) {
                    AsyncValue(:final error?, :final stackTrace?) => () {
                        final messenger = ScaffoldMessenger.of(context);
                        Styles.showErrorSnackBar(messenger, '$error');
                        logger.e("userLibraryProvider($type) failed", error,
                            stackTrace);

                        return Styles.errorColumn(error, stackTrace);
                      }(),
                    AsyncValue(:final value?) => MangaListWidget(
                        title: Text(
                          '${ref.watch(userLibraryProvider(type).notifier).total()} Mangas',
                          style: const TextStyle(fontSize: 24),
                        ),
                        physics: const AlwaysScrollableScrollPhysics(),
                        controller: controller,
                        onAtEdge: () {
                          final lt = ref.read(libraryViewTypeProvider);
                          ref.read(userLibraryProvider(lt).notifier).getMore();
                        },
                        children: [
                          MangaListViewSliver(items: value),
                        ],
                      ),
                    _ => const SizedBox.shrink(),
                  },
                  if (isLoading) ...Styles.loadingOverlay,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
