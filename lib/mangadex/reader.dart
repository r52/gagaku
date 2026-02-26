import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/mangadex/model/model.dart';
import 'package:gagaku/mangadex/model/types.dart';
import 'package:gagaku/reader/main.dart';
import 'package:gagaku/reader/model/types.dart';
import 'package:gagaku/util/riverpod.dart';
import 'package:gagaku/util/ui.dart';
import 'package:gagaku/util/util.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'reader.g.dart';

class ReaderData {
  const ReaderData({
    required this.title,
    required this.chapter,
    required this.manga,
    this.link,
    this.onLinkPressed,
  });

  final String title;
  final Chapter chapter;
  final Manga manga;
  final String? link;
  final CtxCallback? onLinkPressed;
}

@Riverpod(retry: noRetry)
Future<ReaderData> _fetchChapterData(Ref ref, String chapterId) async {
  final api = ref.watch(mangadexProvider);

  final chapters = await api.fetchChapters([chapterId]);
  final chapter = chapters.first;

  final mangaId = chapter.manga.id;
  final mangas = await api.fetchMangaById(
    ids: [mangaId],
    limit: MangaDexEndpoints.breakLimit,
  );
  final manga = mangas.first;

  final data = ReaderData(title: chapter.title, chapter: chapter, manga: manga);

  return data;
}

@Riverpod(retry: noRetry)
Future<List<ReaderPage>> _fetchChapterPages(Ref ref, Chapter chapter) async {
  final api = ref.watch(mangadexProvider);
  final mpages = await api.getChapterServer(chapter);

  final pages = mpages.pages.map((pageUrl) {
    final url = mpages.baseUrl + pageUrl;
    return ReaderPage(provider: NetworkImage(url));
  }).toList();

  ref.onDispose(() {
    pages.clear();
  });

  return pages;
}

class MangaDexReaderPage extends ConsumerWidget {
  const MangaDexReaderPage({
    super.key,
    required this.chapterId,
    this.readerData,
  });

  final String chapterId;
  final ReaderData? readerData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (readerData != null) {
      return MangaDexReaderWidget(
        chapter: readerData!.chapter,
        manga: readerData!.manga,
        title: readerData!.title,
        link: readerData!.manga.attributes!.title.get('en'),
        onLinkPressed: readerData!.onLinkPressed,
      );
    }

    return DataProviderWhenWidget(
      provider: _fetchChapterDataProvider(chapterId),
      errorBuilder: (context, child, _, _) => Scaffold(body: child),
      builder: (context, data) => MangaDexReaderWidget(
        chapter: data.chapter,
        manga: data.manga,
        title: data.title,
        link: data.manga.attributes!.title.get('en'),
        onLinkPressed: (context) =>
            context.go('/title/${data.manga.id}', extra: data.manga),
      ),
    );
  }
}

class MangaDexReaderWidget extends HookConsumerWidget {
  const MangaDexReaderWidget({
    super.key,
    required this.title,
    required this.chapter,
    required this.manga,
    this.link,
    this.onLinkPressed,
  });

  final String title;
  final Chapter chapter;
  final Manga manga;
  final String? link;
  final CtxCallback? onLinkPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timer = useRef<Timer?>(null);

    useEffect(() {
      if (timer.value?.isActive ?? false) timer.value?.cancel();

      timer.value = Timer(const Duration(milliseconds: 2000), () async {
        final me = await ref.watch(loggedUserProvider.future);

        if (me != null) {
          final readData = await ref.readAsync(
            mangaReadChaptersProvider(manga).future,
          );

          if (readData?.contains(chapter.id) != true) {
            readChaptersMutation(me.id).run(ref, (ref) async {
              return await ref
                  .get(readChaptersProvider(me.id).notifier)
                  .set(manga, read: [chapter]);
            });
          }
        }

        mangadexHistoryMutation.run(ref, (ref) async {
          return await ref.get(mangaDexHistoryProvider.notifier).add(chapter);
        });
      });

      return () => timer.value?.cancel();
    }, [chapter]);

    return DataProviderWhenWidget(
      provider: _fetchChapterPagesProvider(chapter),
      errorBuilder: (context, child, _, _) => Scaffold(
        appBar: AppBar(leading: const BackButton()),
        body: child,
      ),
      builder: (context, pages) => ReaderWidget(
        pages: pages,
        title: title,
        subtitle: manga.attributes!.title.get('en'),
        longstrip: manga.longStrip,
        drawerHeader: link,
        onHeaderPressed: onLinkPressed,
        externalUrl: chapter.attributes.externalUrl,
      ),
      loadingWidget: const Center(child: CircularProgressIndicator()),
    );
  }
}
