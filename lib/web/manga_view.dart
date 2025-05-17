import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/routes.gr.dart';
import 'package:gagaku/reader/main.dart' show CtxCallback;
import 'package:gagaku/util/cached_network_image.dart';
import 'package:gagaku/util/ui.dart';
import 'package:gagaku/util/util.dart';
import 'package:gagaku/web/model/config.dart';
import 'package:gagaku/web/model/model.dart';
import 'package:gagaku/web/model/types.dart';
import 'package:gagaku/web/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';

part 'manga_view.g.dart';

@Riverpod(retry: noRetry)
Future<WebManga> _fetchWebMangaInfo(Ref ref, SourceHandler handle) async {
  final api = ref.watch(proxyProvider);
  final manga = await api.handleSource(handle);

  if (manga != null) {
    return manga;
  }

  throw Exception('Invalid WebManga link. Data not found.');
}

class ChapterEntry {
  const ChapterEntry(this.name, this.chapter);

  final String name;
  final WebChapter chapter;

  int get id => Object.hash(name, chapter);
}

@RoutePage()
class WebMangaViewPage extends ConsumerWidget {
  const WebMangaViewPage({
    super.key,
    @PathParam() required this.sourceId,
    @PathParam() required this.mangaId,
    this.handle,
  });

  final String sourceId;
  final String mangaId;
  final SourceHandler? handle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final installed = ref.read(
      webConfigProvider.select((cfg) => cfg.installedSources),
    );

    final hndl =
        handle ??
        SourceHandler(
          type:
              (installed.indexWhere((e) => e.id == sourceId) > -1)
                  ? SourceType.source
                  : SourceType.proxy,
          sourceId: sourceId,
          location: mangaId,
        );

    return DataProviderWhenWidget(
      provider: _fetchWebMangaInfoProvider(hndl),
      errorBuilder:
          (context, child, _, __) => Scaffold(
            appBar: AppBar(leading: AutoLeadingButton()),
            body: Consumer(
              child: child,
              builder: (context, ref, child) {
                final api = ref.watch(proxyProvider);
                return RefreshIndicator(
                  onRefresh: () async {
                    await api.invalidateAll(hndl.getKey());
                    return ref.refresh(_fetchWebMangaInfoProvider(hndl).future);
                  },
                  child: child!,
                );
              },
            ),
          ),
      builder: (context, data) => WebMangaViewWidget(manga: data, handle: hndl),
    );
  }
}

class WebMangaViewWidget extends HookConsumerWidget {
  const WebMangaViewWidget({
    super.key,
    required this.manga,
    required this.handle,
  });

  final WebManga manga;
  final SourceHandler handle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tr = context.t;
    final api = ref.watch(proxyProvider);
    final theme = Theme.of(context);
    final link = HistoryLink(
      title: '${handle.sourceId}: ${manga.title}',
      url: handle.getURL(),
      cover: manga.cover,
    );
    final chapterlist =
        manga.chapters.entries
            .map((e) => ChapterEntry(e.key, e.value))
            .toList();
    //chapterlist.sort((a, b) => double.parse(b.name).compareTo(double.parse(a.name)));
    chapterlist.sort((a, b) => compareNatural(b.name, a.name));
    final extdata =
        manga.data != null && manga.data is SourceManga
            ? manga.data as SourceManga
            : null;

    useEffect(() {
      Future.delayed(Duration.zero, () {
        ref.read(webSourceHistoryProvider.add)(link);
        ref.read(webSourceFavoritesProvider.updateAll)(link);
      });
      return null;
    }, []);

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await api.invalidateAll(handle.getKey());
          return ref.refresh(_fetchWebMangaInfoProvider(handle).future);
        },
        child: CustomScrollView(
          scrollBehavior: const MouseTouchScrollBehavior(),
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              snap: false,
              floating: false,
              expandedHeight: 250.0,
              leading: AutoLeadingButton(),
              flexibleSpace: FlexibleSpaceBar(
                expandedTitleScale: 2.0,
                title: Text(
                  manga.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(1.0, 1.0),
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ],
                  ),
                ),
                background: CachedNetworkImage(
                  imageUrl: manga.cover,
                  cacheManager: gagakuImageCache,
                  colorBlendMode: BlendMode.modulate,
                  color: Colors.grey,
                  fit: BoxFit.cover,
                  progressIndicatorBuilder:
                      (context, url, downloadProgress) =>
                          const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              actions: [
                OverflowBar(
                  spacing: 8.0,
                  children: [
                    FavoritesButton(
                      link: link,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(6.0),
                      ),
                    ),
                    Consumer(
                      builder: (context, ref, child) {
                        final key = handle.getKey();

                        return IconButton(
                          tooltip: tr.webSources.resetRead,
                          style: Styles.squareIconButtonStyle(
                            backgroundColor: theme.colorScheme.surface
                                .withAlpha(200),
                          ),
                          onPressed: () async {
                            final result = await showDialog<bool>(
                              context: context,
                              builder: (BuildContext context) {
                                final nav = Navigator.of(context);
                                return AlertDialog(
                                  title: Text(tr.webSources.resetRead),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(tr.webSources.resetReadWarning),
                                    ],
                                  ),
                                  actions: <Widget>[
                                    ElevatedButton(
                                      child: Text(tr.ui.no),
                                      onPressed: () {
                                        nav.pop(false);
                                      },
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        nav.pop(true);
                                      },
                                      child: Text(tr.ui.yes),
                                    ),
                                  ],
                                );
                              },
                            );

                            if (result == true) {
                              ref.read(webReadMarkersProvider.deleteKey)(key);
                            }
                          },
                          icon: const Icon(Icons.restore),
                        );
                      },
                    ),
                    const SizedBox(width: 2),
                  ],
                ),
              ],
            ),
            SliverList.list(
              children: [
                if (manga.description.isNotEmpty)
                  ExpansionTile(
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    title: Text(tr.mangaView.synopsis),
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(8),
                        color: theme.colorScheme.surfaceContainerHighest,
                        child: MarkdownBody(
                          data: manga.description,
                          onTapLink: (text, url, title) async {
                            if (url != null) {
                              if (!await launchUrl(Uri.parse(url))) {
                                throw 'Could not launch $url';
                              }
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ExpansionTile(
                  title: Text(tr.mangaView.info),
                  children: [
                    MultiChildExpansionTile(
                      title: tr.mangaView.author,
                      children: [IconTextChip(text: manga.author)],
                    ),
                    MultiChildExpansionTile(
                      title: tr.mangaView.artist,
                      children: [IconTextChip(text: manga.artist)],
                    ),
                    if (extdata != null)
                      for (final tagsec
                          in (extdata.mangaInfo.tags ?? <TagSection>[]))
                        MultiChildExpansionTile(
                          title: tagsec.label.capitalize(),
                          children:
                              tagsec.tags
                                  .map(
                                    (e) => IconTextChip(
                                      text: e.label,
                                      onPressed:
                                          () => context.router.push(
                                            ExtensionSearchRoute(
                                              sourceId: handle.sourceId,
                                              source: handle.parser,
                                              query: SearchRequest(
                                                includedTags: [e],
                                              ),
                                            ),
                                          ),
                                    ),
                                  )
                                  .toList(),
                        ),
                    MultiChildExpansionTile(
                      title: tr.tracking.links,
                      children: [
                        if (handle.type == SourceType.proxy)
                          ButtonChip(
                            onPressed: () async {
                              final route = cleanBaseDomains(
                                context.router.currentUrl,
                              );
                              final url = Uri.parse('http://cubari.moe$route');

                              if (!await launchUrl(url)) {
                                throw 'Could not launch $url';
                              }
                            },
                            text: tr.mangaView.openOn(arg: 'cubari.moe'),
                          ),
                        if (handle.type == SourceType.source)
                          SimpleFutureBuilder(
                            futureBuilder:
                                () => ref
                                    .read(
                                      extensionSourceProvider(
                                        handle.sourceId,
                                      ).notifier,
                                    )
                                    .getMangaURL(handle.location),
                            keys: [handle],
                            builder: (context, data) {
                              if (data == null) {
                                return SizedBox.shrink();
                              }

                              return ButtonChip(
                                onPressed: () async {
                                  final url = data;
                                  final uri = Uri.parse(url);

                                  if (!await launchUrl(uri)) {
                                    throw 'Could not launch $url';
                                  }
                                },
                                text: tr.mangaView.openOn(arg: handle.sourceId),
                              );
                            },
                          ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    tr.mangaView.chapters,
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      const Spacer(),
                      Consumer(
                        builder: (context, ref, child) {
                          final key = handle.getKey();
                          final names = chapterlist.map((e) => e.name);
                          final allRead = ref.watch(
                            webReadMarkersProvider.select(
                              (value) => switch (value) {
                                AsyncValue(value: final data?) =>
                                  data[key]?.containsAll(names) ?? false,
                                _ => false,
                              },
                            ),
                          );

                          final opt =
                              allRead ? tr.mangaView.unread : tr.mangaView.read;

                          return ElevatedButton(
                            style: Styles.buttonStyle(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                            ),
                            onPressed: () async {
                              final result = await showDialog<bool>(
                                context: context,
                                builder: (BuildContext context) {
                                  final nav = Navigator.of(context);
                                  return AlertDialog(
                                    title: Text(
                                      tr.mangaView.markAllAs(arg: opt),
                                    ),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          tr.mangaView.markAllWarning(arg: opt),
                                        ),
                                      ],
                                    ),
                                    actions: <Widget>[
                                      ElevatedButton(
                                        child: Text(tr.ui.no),
                                        onPressed: () {
                                          nav.pop(false);
                                        },
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          nav.pop(true);
                                        },
                                        child: Text(tr.ui.yes),
                                      ),
                                    ],
                                  );
                                },
                              );

                              if (result == true) {
                                ref.read(webReadMarkersProvider.setBulk)(
                                  key,
                                  read: !allRead ? names : null,
                                  unread: allRead ? names : null,
                                );
                              }
                            },
                            child: Text(tr.mangaView.markAllAs(arg: opt)),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SliverList.separated(
              findChildIndexCallback: (key) {
                final valueKey = key as ValueKey<int>;
                final val = chapterlist.indexWhere(
                  (i) => i.id == valueKey.value,
                );
                return val >= 0 ? val : null;
              },
              separatorBuilder: (_, __) => const SizedBox(height: 4.0),
              itemBuilder: (BuildContext context, int index) {
                final e = chapterlist.elementAt(index);

                return ChapterButtonWidget(
                  key: ValueKey(e.id),
                  data: e,
                  manga: manga,
                  handle: handle,
                );
              },
              itemCount: manga.chapters.length,
            ),
          ],
        ),
      ),
    );
  }
}

class ChapterButtonWidget extends HookConsumerWidget {
  const ChapterButtonWidget({
    super.key,
    required this.data,
    required this.manga,
    required this.handle,
    this.onLinkPressed,
  });

  final ChapterEntry data;
  final WebManga manga;
  final SourceHandler handle;
  final CtxCallback? onLinkPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tr = context.t;
    useAutomaticKeepAlive();
    final bool screenSizeSmall = DeviceContext.screenWidthSmall(context);
    final theme = Theme.of(context);
    final tileColor = theme.colorScheme.primaryContainer;
    final name = data.name;
    final key = handle.getKey();

    final isRead = ref.watch(
      webReadMarkersProvider.select(
        (value) => switch (value) {
          AsyncValue(value: final data?) => data[key]?.contains(name) ?? false,
          _ => false,
        },
      ),
    );

    String title = data.chapter.getTitle(name);
    String group = data.chapter.groups.entries.first.key;

    final lang = tr.$meta.locale.languageCode;
    //final locale = screenSizeSmall && timeagoLocaleList.contains('${lang}_short') ? '${lang}_short' : lang;

    String? timestamp;

    if (data.chapter.lastUpdated != null) {
      timestamp = timeago.format(data.chapter.lastUpdated!, locale: lang);
    } else if (data.chapter.releaseDate != null) {
      timestamp = timeago.format(data.chapter.releaseDate!, locale: lang);
    }

    final border = Border(
      left: BorderSide(
        color: isRead == true ? tileColor : Colors.blue,
        width: 4.0,
      ),
    );

    final textstyle = TextStyle(
      color: (isRead == true ? theme.disabledColor : theme.colorScheme.primary),
    );

    final markReadBtn = IconButton(
      onPressed: () async {
        bool set = !isRead;

        ref.read(webReadMarkersProvider.set)(key, name, set);
      },
      padding: const EdgeInsets.all(0.0),
      splashRadius: 15,
      iconSize: 20,
      tooltip: tr.mangaView.markAs(
        arg: isRead == true ? tr.mangaView.unread : tr.mangaView.read,
      ),
      icon: Icon(
        isRead == true ? Icons.visibility_off : Icons.visibility,
        color:
            (isRead == true
                ? theme.disabledColor
                : theme.primaryIconTheme.color),
      ),
      constraints: const BoxConstraints(
        minWidth: 20.0,
        minHeight: 20.0,
        maxWidth: 30.0,
        maxHeight: 30.0,
      ),
      visualDensity: const VisualDensity(horizontal: -4.0, vertical: -4.0),
    );

    final readerData = WebReaderData(
      source: data.chapter.groups.entries.first.value,
      title: title,
      link: manga.title,
      handle: handle,
      readKey: name,
      onLinkPressed: onLinkPressed,
    );

    PageRouteInfo route = ProxyWebSourceReaderRoute(
      proxy: handle.sourceId,
      code: handle.location,
      chapter: name,
      readerData: readerData,
    );

    if (handle.type == SourceType.source) {
      route = ExtensionReaderRoute(
        sourceId: handle.sourceId,
        mangaId: handle.location,
        chapterId: (data.chapter.groups.entries.first.value as Chapter).id,
        readerData: readerData,
      );
    }

    return ListTile(
      onTap: () {
        context.router.push(route);
      },
      tileColor: theme.colorScheme.primaryContainer,
      dense: true,
      minVerticalPadding: 0.0,
      contentPadding: EdgeInsets.symmetric(
        horizontal: (screenSizeSmall ? 4.0 : 10.0),
      ),
      minLeadingWidth: 0.0,
      leading: markReadBtn,
      shape: border,
      title: Text(title, style: textstyle),
      trailing: FittedBox(
        fit: BoxFit.fill,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!screenSizeSmall)
              IconTextChip(
                icon: const Icon(Icons.group, size: 20),
                text:
                    manga.groups != null &&
                            manga.groups?.containsKey(group) == true
                        ? manga.groups![group]!
                        : group,
              ),
            if (!screenSizeSmall) const SizedBox(width: 10),
            const Icon(Icons.schedule, size: 20),
            if (timestamp != null) Text(' $timestamp'),
          ],
        ),
      ),
    );
  }
}
