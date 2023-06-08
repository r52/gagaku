import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:gagaku/mangadex/model.dart';
import 'package:gagaku/mangadex/types.dart';
import 'package:gagaku/reader/main.dart';
import 'package:gagaku/reader/types.dart';
import 'package:gagaku/ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'reader.g.dart';

Route createMangaDexReaderRoute(
    Chapter chapter, Manga manga, Widget? link, VoidCallback? onLinkPressed) {
  return Styles.buildSlideTransitionRoute(
    (context, animation, secondaryAnimation) => MangaDexReaderWidget(
      chapter: chapter,
      manga: manga,
      link: link,
      onLinkPressed: onLinkPressed,
    ),
  );
}

@riverpod
Future<List<ReaderPage>> _fetchChapterPages(
    _FetchChapterPagesRef ref, Chapter chapter) async {
  final api = ref.watch(mangadexProvider);
  var mpages = await api.getChapterServer(chapter);

  var pages = mpages.pages.map((pageUrl) {
    var url = mpages.baseUrl + pageUrl;
    return ReaderPage(
      provider: ExtendedNetworkImageProvider(url),
    );
  }).toList();

  return pages;
}

class MangaDexReaderWidget extends HookConsumerWidget {
  const MangaDexReaderWidget({
    super.key,
    required this.chapter,
    required this.manga,
    this.link,
    this.onLinkPressed,
  });

  final Chapter chapter;
  final Manga manga;
  final Widget? link;
  final VoidCallback? onLinkPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pages = ref.watch(_fetchChapterPagesProvider(chapter));

    String title = '';

    if (chapter.attributes.chapter != null) {
      title += 'Chapter ${chapter.attributes.chapter!}';
    }

    if (chapter.attributes.title != null) {
      title += ' - ${chapter.attributes.title!}';
    }

    return pages.when(
      skipLoadingOnReload: true,
      data: (result) {
        ref.read(authControlProvider).whenData((loggedin) {
          if (loggedin) {
            ref.read(readChaptersProvider).whenData((read) {
              if (!read.containsKey(manga.id) ||
                  read[manga.id]?.contains(chapter.id) == false) {
                Future.delayed(
                    const Duration(seconds: 3),
                    () => ref
                        .read(readChaptersProvider.notifier)
                        .set(manga, [chapter], true));
              }
            });
          }
        });

        Future.delayed(const Duration(seconds: 1),
            () => ref.read(mangaDexHistoryProvider.notifier).add(chapter));

        return ReaderWidget(
          pages: result,
          pageCount: result.length,
          title: '${manga.attributes.title.get('en')} - $title',
          isLongStrip: manga.longStrip,
          link: link,
          onLinkPressed: onLinkPressed,
          externalUrl: chapter.attributes.externalUrl,
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (err, stackTrace) {
        final messenger = ScaffoldMessenger.of(context);
        Future.delayed(
          Duration.zero,
          () => messenger
            ..removeCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text('$err'),
                backgroundColor: Colors.red,
              ),
            ),
        );

        return Text('Error: $err');
      },
    );
  }
}
