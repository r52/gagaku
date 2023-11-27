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
    final theme = Theme.of(context);
    final type = ref.watch(libraryViewTypeProvider);
    final results = ref.watch(userLibraryProvider(type));
    final isLoading = results.isLoading;

    return Scaffold(
      body: Center(
        child: Column(
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
                      ref.read(libraryViewTypeProvider.notifier).state = status;
                    }
                  },
                  dropdownMenuEntries:
                      List<DropdownMenuEntry<MangaReadingStatus>>.generate(
                    MangaReadingStatus.values.skip(1).length,
                    (int index) => DropdownMenuEntry<MangaReadingStatus>(
                      value: MangaReadingStatus.values.skip(1).elementAt(index),
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
              child: Stack(
                children: [
                  switch (results) {
                    AsyncValue(:final error?, :final stackTrace?) => () {
                        final messenger = ScaffoldMessenger.of(context);
                        Styles.showErrorSnackBar(messenger, '$error');
                        logger.e("userLibraryProvider($type) failed",
                            error: error, stackTrace: stackTrace);

                        return Styles.errorColumn(error, stackTrace);
                      }(),
                    AsyncValue(:final value?) => RefreshIndicator(
                        onRefresh: () async {
                          final lt = ref.read(libraryViewTypeProvider);
                          return await ref
                              .read(userLibraryProvider(lt).notifier)
                              .clear(true);
                        },
                        child: MangaListWidget(
                          title: Text(
                            '${ref.watch(userLibraryProvider(type).notifier).total()} Mangas',
                            style: const TextStyle(fontSize: 24),
                          ),
                          physics: const AlwaysScrollableScrollPhysics(),
                          controller: controller,
                          onAtEdge: () {
                            final lt = ref.read(libraryViewTypeProvider);
                            ref
                                .read(userLibraryProvider(lt).notifier)
                                .getMore();
                          },
                          children: [
                            MangaListViewSliver(items: value),
                          ],
                        ),
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
