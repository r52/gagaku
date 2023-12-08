import 'dart:async';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/model.dart';
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
    this.info,
    this.readKey,
    this.onLinkPressed,
  });

  final dynamic source;
  final String? title;
  final WebManga? manga;
  final Widget? link;
  final ProxyInfo? info;
  final String? readKey;
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
      info: data.info,
      readKey: data.readKey,
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
    ref.read(webSourceHistoryProvider.notifier).add(HistoryLink(
        title: '${info.proxy}: ${info.code}', url: '${info.getURL()}1/1/'));
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
        info: info,
        readKey: info.chapter,
      );
    }
  }

  throw Exception('Invalid WebChapter link. Data not found.');
}

@riverpod
Future<List<ReaderPage>> _getPages(_GetPagesRef ref, dynamic source) async {
  List<String> links;

  if (source is List) {
    links = List<String>.from(source);
  } else {
    final api = ref.watch(proxyProvider);
    links = await api.getChapter(source);
  }

  final pages = links
      .map((e) => ReaderPage(
            provider: ExtendedNetworkImageProvider(e),
          ))
      .toList();

  ref.onDispose(() {
    pages.clear();
  });

  return pages;
}

class QueriedWebSourceReaderWidget extends ConsumerWidget {
  const QueriedWebSourceReaderWidget({
    super.key,
    required this.proxy,
    required this.code,
    required this.chapter,
  });

  final String proxy;
  final String code;
  final String chapter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final info = ProxyInfo(
        proxy: proxy, code: code, chapter: chapter.replaceFirst('-', '.'));
    final dataProvider = ref.watch(_fetchWebChapterInfoProvider(info));

    Widget child;
    PreferredSizeWidget? appBar;

    switch (dataProvider) {
      case AsyncValue(valueOrNull: final data?):
        return WebSourceReaderWidget(
          source: data.source,
          manga: data.manga,
          title: data.title,
          link: data.link,
          info: data.info,
          readKey: data.readKey,
          onLinkPressed: data.onLinkPressed,
          backRoute: GagakuRoute.web,
        );
      case AsyncValue(:final error?, :final stackTrace?):
        final messenger = ScaffoldMessenger.of(context);
        Styles.showErrorSnackBar(messenger, '$error');
        logger.e("_fetchWebChapterInfoProvider($proxy/$code/$chapter) failed",
            error: error, stackTrace: stackTrace);

        child = Styles.errorColumn(error, stackTrace);
        appBar = AppBar(
          leading: BackButton(
            onPressed: () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.go(GagakuRoute.web);
              }
            },
          ),
        );
        break;
      case _:
        child = Styles.listSpinner;
        break;
    }

    return Scaffold(
      appBar: appBar,
      body: child,
    );
  }
}

class WebSourceReaderWidget extends HookConsumerWidget {
  const WebSourceReaderWidget({
    super.key,
    required this.source,
    this.title,
    this.manga,
    this.link,
    this.info,
    this.readKey,
    this.onLinkPressed,
    this.backRoute,
  });

  final dynamic source;
  final String? title;
  final WebManga? manga;
  final Widget? link;
  final ProxyInfo? info;
  final String? readKey;
  final VoidCallback? onLinkPressed;
  final String? backRoute;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timer = useRef<Timer?>(null);
    String name = '';

    if (title != null) {
      name = title!;
    } else if (source is String) {
      name = source;
    }

    final pageProvider = ref.watch(_getPagesProvider(source));

    useEffect(() {
      if (timer.value?.isActive ?? false) timer.value?.cancel();

      timer.value = Timer(const Duration(milliseconds: 2000), () async {
        if (info != null && readKey != null) {
          ref
              .read(webReadMarkersProvider.notifier)
              .set(info!.getKey(), readKey!, true);
        }
      });

      return () => timer.value?.cancel();
    }, []);

    switch (pageProvider) {
      case AsyncValue(:final error?, :final stackTrace?):
        final messenger = ScaffoldMessenger.of(context);
        Styles.showErrorSnackBar(messenger, '$error');
        logger.e("_getPagesProvider($source) failed",
            error: error, stackTrace: stackTrace);

        return Scaffold(
          appBar: AppBar(
            leading: BackButton(
              onPressed: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.go(backRoute ?? GagakuRoute.web);
                }
              },
            ),
          ),
          body: Styles.errorColumn(error, stackTrace),
        );
      case AsyncValue(valueOrNull: final pages?):
        return ReaderWidget(
          pages: pages,
          title: name,
          isLongStrip: false, // TODO longstrip
          link: link,
          onLinkPressed: onLinkPressed,
          backRoute: backRoute,
        );
      case _:
        return const Center(
          child: CircularProgressIndicator(),
        );
    }
  }
}
