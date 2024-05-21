import 'dart:async';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/mangadex/model.dart';
import 'package:gagaku/mangadex/types.dart';
import 'package:gagaku/reader/main.dart';
import 'package:gagaku/reader/types.dart';
import 'package:gagaku/ui.dart';
import 'package:gagaku/util.dart';
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
    child = QueriedMangaDexReaderWidget(
        chapterId: state.pathParameters['chapterId']!);
  }

  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: Styles.slideTransitionBuilder,
  );
}

@riverpod
Future<ReaderData> _fetchChapterData(
    _FetchChapterDataRef ref, String chapterId) async {
  final api = ref.watch(mangadexProvider);

  final chapters = await api.fetchChapters([chapterId]);
  final chapter = chapters.first;

  final mangaId = chapter.manga.id;
  final mangas =
      await api.fetchManga(ids: [mangaId], limit: MangaDexEndpoints.breakLimit);
  final manga = mangas.first;

  final data = ReaderData(
    title: chapter.title,
    chapter: chapter,
    manga: manga,
  );

  return data;
}

@riverpod
Future<List<ReaderPage>> _fetchChapterPages(
    _FetchChapterPagesRef ref, Chapter chapter) async {
  final api = ref.watch(mangadexProvider);
  final mpages = await api.getChapterServer(chapter);

  final pages = mpages.pages.map((pageUrl) {
    final url = mpages.baseUrl + pageUrl;
    return ReaderPage(
      provider: ExtendedNetworkImageProvider(url,
          cache: true, cacheMaxAge: const Duration(minutes: 5)),
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
    final dataProvider = ref.watch(_fetchChapterDataProvider(chapterId));

    Widget child;

    switch (dataProvider) {
      case AsyncValue(valueOrNull: final data?):
        return MangaDexReaderWidget(
          chapter: data.chapter,
          manga: data.manga,
          title: data.title,
          link: Text(
            data.manga.attributes!.title.get('en'),
            style: const TextStyle(fontSize: 18),
          ),
          onLinkPressed: () {
            context.go('/title/${data.manga.id}', extra: data.manga);
          },
          backRoute: '/',
        );
      case AsyncValue(:final error?, :final stackTrace?):
        final messenger = ScaffoldMessenger.of(context);
        Styles.showErrorSnackBar(messenger, '$error');
        logger.e("_fetchChapterDataProvider($chapterId) failed",
            error: error, stackTrace: stackTrace);

        child = Styles.errorColumn(error, stackTrace);
        break;
      case _:
        child = Styles.listSpinner;
        break;
    }

    return Scaffold(
      body: child,
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
    final pageProvider = ref.watch(_fetchChapterPagesProvider(chapter));
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

    switch (pageProvider) {
      case AsyncValue(:final error?, :final stackTrace?):
        final messenger = ScaffoldMessenger.of(context);
        Styles.showErrorSnackBar(messenger, '$error');
        logger.e("_fetchChapterPagesProvider(${chapter.id}) failed",
            error: error, stackTrace: stackTrace);

        return Scaffold(
          appBar: AppBar(
            leading: const BackButton(),
          ),
          body: Styles.errorColumn(error, stackTrace),
        );
      case AsyncValue(valueOrNull: final pages?):
        return ReaderWidget(
          pages: pages,
          title: title,
          subtitle: manga.attributes!.title.get('en'),
          longstrip: manga.longStrip,
          link: link,
          onLinkPressed: onLinkPressed,
          externalUrl: chapter.attributes.externalUrl,
          backRoute: backRoute,
        );
      case _:
        return const Center(
          child: CircularProgressIndicator(),
        );
    }
  }
}
