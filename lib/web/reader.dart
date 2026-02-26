import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/reader/main.dart';
import 'package:gagaku/reader/model/types.dart';
import 'package:gagaku/util/exception.dart';
import 'package:gagaku/util/http.dart' show baseUserAgent;
import 'package:gagaku/util/riverpod.dart';
import 'package:gagaku/util/ui.dart';
import 'package:gagaku/util/util.dart';
import 'package:gagaku/web/model/model.dart';
import 'package:gagaku/web/model/types.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'reader.g.dart';

@Riverpod(retry: noRetry)
Future<WebReaderData> _fetchWebChapterInfo(
  Ref ref,
  SourceHandler handle,
) async {
  final api = ref.watch(proxyProvider);
  final manga = await api.getMangaFromSource(handle);

  if (manga != null) {
    WebHistoryManager().add(
      HistoryLink(
        title: manga.title,
        url: handle.getURL(),
        cover: manga.cover,
        handle: handle,
        lastAccessed: DateTime.now(),
      ),
    );

    final chapter = manga.getChapter(handle.chapter!);

    if (chapter != null) {
      return WebReaderData(
        source: chapter.groups.entries.first.value,
        title: chapter.getTitle(handle.chapter!),
        link: manga.title,
        handle: handle,
        readKey: handle.chapter,
      );
    }
  }

  throw InvalidDataException('Invalid WebChapter link. Data not found.');
}

@Riverpod(retry: noRetry)
Future<List<ReaderPage>> _getPages(Ref ref, dynamic data) async {
  List<String> links;

  if (data is String && data.startsWith('/read/')) {
    final api = ref.watch(proxyProvider);
    data = await api.getProxyAPI(data);
  }

  if (data is! List) {
    throw InvalidDataException('Unknown page data type ($data)');
  }

  if (data.first is! String) {
    final imgurlist = data.map((e) => ImgurPage.fromJson(e)).toList();
    links = imgurlist.map((e) => e.src).toList();
  } else {
    links = List<String>.from(data);
  }

  final pages = links
      .map((e) => ReaderPage(provider: NetworkImage(e)))
      .toList();

  ref.onDispose(() {
    pages.clear();
  });

  return pages;
}

@Riverpod(retry: noRetry)
Future<List<ReaderPage>> _getSourcePages(
  Ref ref,
  dynamic chapter,
  SourceHandler handle,
) async {
  List<String>? links = [];

  final sourceId = handle.sourceId;

  final refer = ref.watch(extensionReferrerProvider);
  await ref.readAsync(extensionSourceProvider(sourceId).future);
  links = await ref
      .read(extensionSourceProvider(sourceId).notifier)
      .getChapterPages(chapter as Chapter);

  String referer = refer[sourceId] ?? '';

  final pages = links
      .map(
        (e) => ReaderPage(
          provider: NetworkImage(
            e,
            headers: {'referer': referer, 'user-agent': baseUserAgent},
          ),
        ),
      )
      .toList();

  ref.onDispose(() {
    pages.clear();
  });

  return pages;
}

class ProxyWebSourceReaderPage extends StatelessWidget {
  const ProxyWebSourceReaderPage({
    super.key,
    required this.proxy,
    required this.code,
    required this.chapter,
    this.page,
    this.readerData,
  });

  final String proxy;
  final String code;
  final String chapter;
  final String? page;

  final WebReaderData? readerData;

  @override
  Widget build(BuildContext context) {
    if (readerData != null) {
      return WebSourceReaderWidget(
        source: readerData!.source,
        title: readerData!.title,
        link: readerData!.link,
        handle: readerData!.handle,
        readKey: readerData!.readKey,
        onLinkPressed: readerData!.onLinkPressed,
      );
    }

    final handle = SourceHandler(
      type: SourceType.proxy,
      sourceId: proxy,
      location: code,
      chapter: chapter.replaceFirst('-', '.'),
    );

    return DataProviderWhenWidget(
      provider: _fetchWebChapterInfoProvider(handle),
      errorBuilder: (context, child, _, _) => Scaffold(
        appBar: AppBar(leading: const BackButton()),
        body: child,
      ),
      builder: (context, data) => WebSourceReaderWidget(
        source: data.source,
        title: data.title,
        link: data.link,
        handle: data.handle,
        readKey: data.readKey,
        onLinkPressed: data.onLinkPressed,
      ),
    );
  }
}

class ExtensionReaderPage extends StatelessWidget {
  const ExtensionReaderPage({
    super.key,
    required this.sourceId,
    required this.mangaId,
    required this.chapterId,
    this.readerData,
  });

  final String sourceId;
  final String mangaId;
  final String chapterId;
  final WebReaderData? readerData;

  @override
  Widget build(BuildContext context) {
    if (readerData != null) {
      return WebSourceReaderWidget(
        source: readerData!.source,
        title: readerData!.title,
        link: readerData!.link,
        handle: readerData!.handle,
        readKey: readerData!.readKey,
        onLinkPressed: readerData!.onLinkPressed,
      );
    }

    final handle = SourceHandler(
      type: SourceType.source,
      sourceId: sourceId,
      location: mangaId,
      chapter: chapterId,
    );

    return DataProviderWhenWidget(
      provider: _fetchWebChapterInfoProvider(handle),
      errorBuilder: (context, child, _, _) => Scaffold(
        appBar: AppBar(leading: const BackButton()),
        body: child,
      ),
      builder: (context, data) => WebSourceReaderWidget(
        source: data.source,
        title: data.title,
        link: data.link,
        handle: data.handle,
        readKey: data.readKey,
        onLinkPressed: data.onLinkPressed,
      ),
    );
  }
}

class WebSourceReaderWidget extends HookConsumerWidget {
  const WebSourceReaderWidget({
    super.key,
    required this.source,
    this.title,
    this.link,
    required this.handle,
    this.readKey,
    this.onLinkPressed,
  });

  final dynamic source;
  final String? title;
  final String? link;
  final SourceHandler handle;
  final String? readKey;
  final CtxCallback? onLinkPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timer = useRef<Timer?>(null);
    String name = '';

    if (title != null) {
      name = title!;
    } else if (source is String) {
      name = source;
    }

    useEffect(() {
      if (timer.value?.isActive ?? false) timer.value?.cancel();

      timer.value = Timer(const Duration(milliseconds: 2000), () async {
        if (readKey != null) {
          webReadMarkerMutation.run(ref, (ref) async {
            return await ref
                .get(webReadMarkersProvider.notifier)
                .set(handle.getKey(), readKey!, true);
          });
        }
      });

      return () => timer.value?.cancel();
    }, []);

    return DataProviderWhenWidget(
      provider: handle.type == SourceType.proxy
          ? _getPagesProvider(source)
          : _getSourcePagesProvider(source, handle),
      errorBuilder: (context, child, _, _) => Scaffold(
        appBar: AppBar(leading: const BackButton()),
        body: child,
      ),
      builder: (context, pages) => ReaderWidget(
        pages: pages,
        title: name,
        longstrip: false,
        drawerHeader: link,
        onHeaderPressed: onLinkPressed,
      ),
    );
  }
}
