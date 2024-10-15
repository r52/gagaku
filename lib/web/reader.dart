import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/model.dart';
import 'package:gagaku/reader/main.dart';
import 'package:gagaku/reader/types.dart';
import 'package:gagaku/util/ui.dart';
import 'package:gagaku/util/util.dart';
import 'package:gagaku/web/model/model.dart';
import 'package:gagaku/web/model/types.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'reader.g.dart';

Page<dynamic> buildWebReaderPage(BuildContext context, GoRouterState state) {
  final data = state.extra.asOrNull<WebReaderData>();

  Widget child;

  if (data != null) {
    child = WebSourceReaderWidget(
      source: data.source,
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
Future<WebReaderData> _fetchWebChapterInfo(_FetchWebChapterInfoRef ref, SourceInfo info) async {
  final api = ref.watch(proxyProvider);
  final manga = await api.handleSource(info);

  if (manga != null) {
    ref
        .read(webSourceHistoryProvider.notifier)
        .add(HistoryLink(title: '${info.source}: ${manga.title}', url: info.getURL(), cover: manga.cover));

    final chapter = manga.getChapter(info.chapter!);

    if (chapter != null) {
      return WebReaderData(
        source: chapter.groups.entries.first.value,
        title: chapter.getTitle(info.chapter!),
        link: Text(
          manga.title,
          style: const TextStyle(fontSize: 24),
        ),
        info: info,
        readKey: info.chapter,
      );
    }
  }

  throw Exception('Invalid WebChapter link. Data not found.');
}

@Riverpod(retry: noRetry)
Future<List<ReaderPage>> _getPages(_GetPagesRef ref, dynamic source) async {
  List<String> links;

  if (source is! List) {
    throw Exception('Unknown source type ($source)');
  }

  if (source.first is! String) {
    final imgurlist = source.map((e) => ImgurPage.fromJson(e)).toList();
    links = imgurlist.map((e) => e.src).toList();
  } else {
    links = List<String>.from(source);
  }

  final pages = links
      .map((e) => ReaderPage(
            provider: NetworkImage(e),
          ))
      .toList();

  ref.onDispose(() {
    pages.clear();
  });

  return pages;
}

@Riverpod(retry: noRetry)
Future<List<ReaderPage>> _getSourcePages(_GetSourcePagesRef ref, dynamic source, SourceInfo info) async {
  List<String>? links;

  final srcMgr = await ref.watch(webSourceManagerProvider.future);
  final api = ref.watch(proxyProvider);

  if (srcMgr != null) {
    if (info.parser != null) {
      links = await srcMgr.parsePages(info.parser!, Uri.parse(source), api.client);
    } else {
      for (final MapEntry(key: key, value: src) in srcMgr.sources.entries) {
        if (info.source == src.name) {
          links = await srcMgr.parsePages(key, Uri.parse(source), api.client);
          break;
        }
      }
    }
  }

  if (links == null) {
    throw Exception('Failed to download pages from $source');
  }

  final pages = links
      .map((e) => ReaderPage(
            provider: NetworkImage(e),
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
    final info =
        SourceInfo(type: SourceType.proxy, source: proxy, location: code, chapter: chapter.replaceFirst('-', '.'));
    final dataProvider = ref.watch(_fetchWebChapterInfoProvider(info));

    Widget child;
    PreferredSizeWidget? appBar;

    switch (dataProvider) {
      case AsyncValue(value: final data?):
        return WebSourceReaderWidget(
          source: data.source,
          title: data.title,
          link: data.link,
          info: data.info,
          readKey: data.readKey,
          onLinkPressed: data.onLinkPressed,
          backRoute: GagakuRoute.proxyHome,
        );
      case AsyncValue(:final error?, :final stackTrace?):
        child = ErrorColumn(
          error: error,
          stackTrace: stackTrace,
          message: "_fetchWebChapterInfoProvider($proxy/$code/$chapter) failed",
        );
        appBar = AppBar(
          leading: BackButton(
            onPressed: () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.go(GagakuRoute.proxyHome);
              }
            },
          ),
        );
        break;
      case AsyncValue(:final progress):
        child = ListSpinner(
          progress: progress?.toDouble(),
        );
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
    this.link,
    required this.info,
    this.readKey,
    this.onLinkPressed,
    this.backRoute,
  });

  final dynamic source;
  final String? title;
  final Widget? link;
  final SourceInfo info;
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

    final pageProvider = info.type == SourceType.proxy
        ? ref.watch(_getPagesProvider(source))
        : ref.watch(_getSourcePagesProvider(source, info));

    useEffect(() {
      if (timer.value?.isActive ?? false) timer.value?.cancel();

      timer.value = Timer(const Duration(milliseconds: 2000), () async {
        if (readKey != null) {
          ref.read(webReadMarkersProvider.notifier).set(info.getKey(), readKey!, true);
        }
      });

      return () => timer.value?.cancel();
    }, []);

    switch (pageProvider) {
      case AsyncValue(:final error?, :final stackTrace?):
        return Scaffold(
          appBar: AppBar(
            leading: BackButton(
              onPressed: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.go(backRoute ?? GagakuRoute.proxyHome);
                }
              },
            ),
          ),
          body: ErrorColumn(
            error: error,
            stackTrace: stackTrace,
            message: "_getPagesProvider($source) failed",
          ),
        );
      case AsyncValue(value: final pages?):
        return ReaderWidget(
          pages: pages,
          title: name,
          longstrip: false,
          link: link,
          onLinkPressed: onLinkPressed,
          backRoute: backRoute,
        );
      case AsyncValue(:final progress):
        return ListSpinner(
          progress: progress?.toDouble(),
        );
    }
  }
}
