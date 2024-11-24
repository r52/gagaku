import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/mangadex/model/model.dart';
import 'package:gagaku/mangadex/model/types.dart';
import 'package:gagaku/reader/main.dart';
import 'package:gagaku/reader/model/types.dart';
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
  final Widget? link;
  final VoidCallback? onLinkPressed;
}

Page<dynamic> buildMDReaderPage(BuildContext context, GoRouterState state) {
  final data = state.extra.asOrNull<ReaderData>();

  Widget child;

  if (data != null) {
    child = MangaDexReaderWidget(
      chapter: data.chapter,
      manga: data.manga,
      title: data.title,
      link: data.link,
      onLinkPressed: data.onLinkPressed,
    );
  } else {
    child = QueriedMangaDexReaderWidget(chapterId: state.pathParameters['chapterId']!);
  }

  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: Styles.slideTransitionBuilder,
  );
}

@Riverpod(retry: noRetry)
Future<ReaderData> _fetchChapterData(Ref ref, String chapterId) async {
  final api = ref.watch(mangadexProvider);

  final chapters = await api.fetchChapters([chapterId]);
  final chapter = chapters.first;

  final mangaId = chapter.manga.id;
  final mangas = await api.fetchManga(ids: [mangaId], limit: MangaDexEndpoints.breakLimit);
  final manga = mangas.first;

  final data = ReaderData(
    title: chapter.title,
    chapter: chapter,
    manga: manga,
  );

  return data;
}

@Riverpod(retry: noRetry)
Future<List<ReaderPage>> _fetchChapterPages(Ref ref, Chapter chapter) async {
  final api = ref.watch(mangadexProvider);
  final mpages = await api.getChapterServer(chapter);

  final pages = mpages.pages.map((pageUrl) {
    final url = mpages.baseUrl + pageUrl;
    return ReaderPage(
      provider: NetworkImage(url),
    );
  }).toList();

  ref.onDispose(() {
    pages.clear();
  });

  return pages;
}

class QueriedMangaDexReaderWidget extends ConsumerWidget {
  const QueriedMangaDexReaderWidget({super.key, required this.chapterId});

  final String chapterId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DataProviderWhenWidget(
      provider: _fetchChapterDataProvider(chapterId),
      errorBuilder: (context, child) => Scaffold(
        body: child,
      ),
      builder: (context, data) => MangaDexReaderWidget(
        chapter: data.chapter,
        manga: data.manga,
        title: data.title,
        link: Text(
          data.manga.attributes!.title.get('en'),
          style: const TextStyle(fontSize: 18),
        ),
        onLinkPressed: () async {
          ref.read(readChaptersProvider.notifier).get([data.manga]);
          ref.read(ratingsProvider.notifier).get([data.manga]);
          ref.read(statisticsProvider.notifier).get([data.manga]);
          context.go('/title/${data.manga.id}', extra: data.manga);
        },
        backRoute: '/',
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
    this.backRoute,
  });

  final String title;
  final Chapter chapter;
  final Manga manga;
  final Widget? link;
  final VoidCallback? onLinkPressed;
  final String? backRoute;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timer = useRef<Timer?>(null);

    useEffect(() {
      if (timer.value?.isActive ?? false) timer.value?.cancel();

      timer.value = Timer(const Duration(milliseconds: 2000), () async {
        final loggedin = await ref.read(authControlProvider.future);

        if (loggedin) {
          // One more redundant read here for direct-linked chapters
          await ref.read(readChaptersProvider.notifier).get([manga]);

          final readData = await ref.read(readChaptersProvider.future);

          if (readData[manga.id]?.contains(chapter.id) != true) {
            ref.read(readChaptersProvider.notifier).set(manga, read: [chapter]);
          }
        }

        ref.read(mangaDexHistoryProvider.notifier).add(chapter);
      });

      return () => timer.value?.cancel();
    }, [chapter]);

    return DataProviderWhenWidget(
      provider: _fetchChapterPagesProvider(chapter),
      errorBuilder: (context, child) => Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
        ),
        body: child,
      ),
      builder: (context, pages) => ReaderWidget(
        pages: pages,
        title: title,
        subtitle: manga.attributes!.title.get('en'),
        longstrip: manga.longStrip,
        link: link,
        onLinkPressed: onLinkPressed,
        externalUrl: chapter.attributes.externalUrl,
        backRoute: backRoute,
      ),
      loadingWidget: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
