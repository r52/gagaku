import 'package:flutter/material.dart';
import 'package:gagaku/mangadex/model.dart';
import 'package:gagaku/mangadex/types.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final libraryViewTypeProvider =
    StateProvider((ref) => MangaReadingStatus.reading);

class MangaDexLibraryView extends HookConsumerWidget {
  const MangaDexLibraryView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final type = ref.watch(libraryViewTypeProvider);
    final results = ref.watch(userLibraryProvider(type));

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  ToggleButtons(
                    isSelected: List<bool>.generate(
                        MangaReadingStatus.values.length,
                        (index) => type.index == index),
                    onPressed: (index) {
                      ref.read(libraryViewTypeProvider.notifier).state =
                          MangaReadingStatus.values.elementAt(index);
                    },
                    children: [
                      ...MangaReadingStatus.values
                          .map((e) => Text(
                                e.formatted,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ))
                          .toList()
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: results.when(
                skipLoadingOnReload: true,
                data: (result) {
                  return MangaListWidget(
                    items: result,
                    title: Text(
                      '${ref.read(userLibraryProvider(type).notifier).total()} Mangas',
                      style: const TextStyle(fontSize: 24),
                    ),
                    physics: const AlwaysScrollableScrollPhysics(),
                    onAtEdge: () {
                      final lt = ref.read(libraryViewTypeProvider);
                      ref.read(userLibraryProvider(lt).notifier).getMore();
                    },
                  );
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (err, stackTrace) {
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(SnackBar(
                      content: Text('$err'),
                      backgroundColor: Colors.red,
                    ));

                  return Text('Error: $err');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}