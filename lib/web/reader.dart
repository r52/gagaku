import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/reader/main.dart';
import 'package:gagaku/reader/types.dart';
import 'package:gagaku/ui.dart';
import 'package:gagaku/util.dart';
import 'package:gagaku/web/model.dart';
import 'package:gagaku/web/types.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'reader.g.dart';

class WebReaderData {
  const WebReaderData({
    required this.source,
    this.title,
    this.manga,
    this.link,
    this.onLinkPressed,
  });

  final String source;
  final String? title;
  final WebManga? manga;
  final Widget? link;
  final VoidCallback? onLinkPressed;
}

Page<dynamic> buildWebReaderPage(BuildContext context, GoRouterState state) {
  final data = state.extra.asOrNull<WebReaderData>();

  Widget child;

  if (data != null) {
    child = WebSourceReaderWidget(
      source: data.source,
      manga: data.manga,
      title: data.title,
      link: data.link,
      onLinkPressed: data.onLinkPressed,
    );
  } else {
    child = QueriedWebSourceReaderWidget(
        proxy: state.pathParameters['proxy']!,
        code: state.pathParameters['code']!,
        chapter: state.pathParameters['chapter']!);
  }

  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: Styles.slideTransitionBuilder,
  );
}

@riverpod
Future<WebReaderData> _fetchWebChapterInfo(
    _FetchWebChapterInfoRef ref, ProxyInfo info) async {
  final api = ref.watch(proxyProvider);
  final proxy = await api.handleProxy(info);

  if (proxy.code != null) {
    return WebReaderData(source: proxy.code!);
  }

  if (proxy.manga != null) {
    ref.read(webSourceHistoryProvider.notifier).add(HistoryLink(
        title: '${info.proxy}: ${proxy.manga?.title}', url: info.getURL()));

    final chapter = proxy.manga!.getChapter(info.chapter!);

    if (chapter != null) {
      return WebReaderData(
        source: chapter.groups.entries.first.value,
        title: chapter.getTitle(info.chapter!),
        manga: proxy.manga!,
        link: Text(
          proxy.manga!.title,
          style: const TextStyle(fontSize: 24),
        ),
      );
    }
  }

  throw Exception('Invalid WebChapter link. Data not found.');
}

@riverpod
Future<List<ReaderPage>> _getPages(_GetPagesRef ref, String code) async {
  final api = ref.watch(proxyProvider);
  final pages = await api.getChapter(code);

  return pages
      .map((e) => ReaderPage(
            provider: ExtendedNetworkImageProvider(e),
          ))
      .toList();
}

class QueriedWebSourceReaderWidget extends ConsumerWidget {
  const QueriedWebSourceReaderWidget(
      {super.key,
      required this.proxy,
      required this.code,
      required this.chapter});

  final String proxy;
  final String code;
  final String chapter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final info = ProxyInfo(
        proxy: proxy, code: code, chapter: chapter.replaceFirst('-', '.'));
    final data = ref.watch(_fetchWebChapterInfoProvider(info));

    Widget child;

    switch (data) {
      case AsyncData(:final value):
        return WebSourceReaderWidget(
          source: value.source,
          manga: value.manga,
          title: value.title,
          link: value.link,
          onLinkPressed: value.onLinkPressed,
        );
      case AsyncError(:final error, :final stackTrace):
        final messenger = ScaffoldMessenger.of(context);
        Styles.showErrorSnackBar(messenger, '$error');
        logger.e("_fetchWebChapterInfoProvider($proxy/$code/$chapter) failed",
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

class WebSourceReaderWidget extends ConsumerWidget {
  const WebSourceReaderWidget({
    super.key,
    required this.source,
    this.title,
    this.manga,
    this.link,
    this.onLinkPressed,
  });

  final String source;
  final String? title;
  final WebManga? manga;
  final Widget? link;
  final VoidCallback? onLinkPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String name = source;

    if (title != null) {
      name = title!;
    }

    final pages = ref.watch(_getPagesProvider(source));

    switch (pages) {
      case AsyncValue(:final error?, :final stackTrace?):
        final messenger = ScaffoldMessenger.of(context);
        Styles.showErrorSnackBar(messenger, '$error');
        logger.e("_getPagesProvider($source) failed",
            error: error, stackTrace: stackTrace);

        return Scaffold(
          appBar: AppBar(
            leading: const BackButton(),
          ),
          body: Styles.errorColumn(error, stackTrace),
        );
      case AsyncValue(:final value?):
        return ReaderWidget(
          pages: value,
          pageCount: value.length,
          title: name,
          isLongStrip: false, // TODO longstrip
          link: link,
          onLinkPressed: onLinkPressed,
        );
      case _:
        return const Center(
          child: CircularProgressIndicator(),
        );
    }
  }
}
