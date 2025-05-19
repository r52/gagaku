import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/reader/main.dart';
import 'package:gagaku/reader/model/types.dart';
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
    ref.read(webSourceHistoryProvider.add)(
      HistoryLink(
        title: '${handle.sourceId}: ${manga.title}',
        url: handle.getURL(),
        cover: manga.cover,
        handle: handle,
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

  throw Exception('Invalid WebChapter link. Data not found.');
}

@Riverpod(retry: noRetry)
Future<List<ReaderPage>> _getPages(Ref ref, dynamic source) async {
  List<String> links;

  if (source is String && source.startsWith('/read/')) {
    final api = ref.watch(proxyProvider);
    source = await api.getProxyAPI(source);
  }

  if (source is! List) {
    throw Exception('Unknown source type ($source)');
  }

  if (source.first is! String) {
    final imgurlist = source.map((e) => ImgurPage.fromJson(e)).toList();
    links = imgurlist.map((e) => e.src).toList();
  } else {
    links = List<String>.from(source);
  }

  final pages =
      links.map((e) => ReaderPage(provider: NetworkImage(e))).toList();

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
  var id = chapter;

  if (chapter is Chapter) {
    id = chapter.id;
  }

  String referer = '';
  List<String>? links = [];

  String? sourceId;
  if (handle.parser != null) {
    sourceId = handle.parser!.id;
  } else {
    final installed = await ref.watch(extensionInfoListProvider.future);
    for (final src in installed) {
      if (handle.sourceId == src.id) {
        sourceId = handle.sourceId;
        break;
      }
    }
  }

  if (sourceId == null) {
    throw Exception(
      'Failed to allocate extension. Parser: ${handle.parser}, sourceId: ${handle.sourceId}',
    );
  }

  final ext = await ref.watch(extensionSourceProvider(sourceId).future);
  links = await ref
      .read(extensionSourceProvider(sourceId).notifier)
      .getChapterPages(handle.location, id);
  referer = ext.baseUrl;

  if (referer.isNotEmpty && !referer.endsWith('/')) {
    referer = '$referer/';
  }

  final pages =
      links
          .map(
            (e) => ReaderPage(
              provider: NetworkImage(e, headers: {'referer': referer}),
            ),
          )
          .toList();

  ref.onDispose(() {
    pages.clear();
  });

  return pages;
}

@RoutePage()
class ProxyWebSourceReaderPage extends StatelessWidget {
  const ProxyWebSourceReaderPage({
    super.key,
    @PathParam() required this.proxy,
    @PathParam() required this.code,
    @PathParam() required this.chapter,
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
      errorBuilder:
          (context, child, _, __) => Scaffold(
            appBar: AppBar(leading: AutoLeadingButton()),
            body: child,
          ),
      builder:
          (context, data) => WebSourceReaderWidget(
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

@RoutePage()
class ExtensionReaderPage extends StatelessWidget {
  const ExtensionReaderPage({
    super.key,
    @PathParam() required this.sourceId,
    @PathParam() required this.mangaId,
    @PathParam() required this.chapterId,
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
      errorBuilder:
          (context, child, _, __) => Scaffold(
            appBar: AppBar(leading: AutoLeadingButton()),
            body: child,
          ),
      builder:
          (context, data) => WebSourceReaderWidget(
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
          ref.read(webReadMarkersProvider.set)(handle.getKey(), readKey!, true);
        }
      });

      return () => timer.value?.cancel();
    }, []);

    return DataProviderWhenWidget(
      provider:
          handle.type == SourceType.proxy
              ? _getPagesProvider(source)
              : _getSourcePagesProvider(source, handle),
      errorBuilder:
          (context, child, _, __) => Scaffold(
            appBar: AppBar(leading: AutoLeadingButton()),
            body: child,
          ),
      builder:
          (context, pages) => ReaderWidget(
            pages: pages,
            title: name,
            longstrip: false,
            drawerHeader: link,
            onHeaderPressed: onLinkPressed,
          ),
    );
  }
}
