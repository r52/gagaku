import 'package:cached_network_image/cached_network_image.dart';
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
          ));
}

@riverpod
Future<List<ReaderPage>> _fetchChapterPages(
    _FetchChapterPagesRef ref, Chapter chapter) async {
  final api = ref.watch(mangadexProvider);
  var mpages = await api.getChapterServer(chapter);

  var pages = mpages.pages.map((pageUrl) {
    var url = mpages.baseUrl + pageUrl;
    return ReaderPage(
      provider: CachedNetworkImageProvider(url, cacheKey: pageUrl),
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
    final readChapters = ref.watch(readChaptersProvider);

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
        readChapters.maybeWhen(
            data: (read) {
              if (!read.contains(chapter.id)) {
                Future.delayed(
                    Duration.zero,
                    () => ref
                        .read(readChaptersProvider.notifier)
                        .set(manga, [chapter], true));
              }
            },
            orElse: () => {});

        return ReaderWidget(
          pages: result,
          pageCount: result.length,
          title: '${manga.attributes.title.get('en')} - $title',
          link: link,
          onLinkPressed: onLinkPressed,
          externalUrl: chapter.attributes.externalUrl,
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
    );
  }
}
