import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:gagaku/model/model.dart';
import 'package:gagaku/util/ui.dart';
import 'package:gagaku/util/util.dart';
import 'package:gagaku/web/model/config.dart';
import 'package:gagaku/web/model/model.dart';
import 'package:gagaku/web/model/types.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';

part 'manga_view.g.dart';

Page<dynamic> buildWebMangaViewPage(BuildContext context, GoRouterState state) {
  final handle = state.extra.asOrNull<SourceHandler>();

  final proxy = state.pathParameters['proxy'] ?? state.pathParameters['source'];
  final code = state.pathParameters['code'] ?? state.pathParameters['mangaId'];

  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: QueriedWebMangaViewWidget(
      proxy: proxy,
      code: code,
      handle: handle,
    ),
    transitionsBuilder: Styles.scaledSharedAxisTransitionBuilder,
  );
}

Page<dynamic> buildRedirectedWebMangaViewPage(BuildContext context, GoRouterState state) {
  final url = state.uri.toString();

  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: RedirectedWebMangaViewWidget(url: url),
    transitionsBuilder: Styles.scaledSharedAxisTransitionBuilder,
  );
}

@Riverpod(retry: noRetry)
Future<WebManga> _fetchWebMangaInfo(Ref ref, SourceHandler handle) async {
  final api = ref.watch(proxyProvider);
  final manga = await api.handleSource(handle);

  if (manga != null) {
    return manga;
  }

  throw Exception('Invalid WebManga link. Data not found.');
}

@Riverpod(retry: noRetry)
Future<SourceHandler> _fetchWebMangaRedirect(Ref ref, String url) async {
  final api = ref.watch(proxyProvider);
  final handle = await api.parseUrl(url);

  if (handle != null) {
    return handle;
  }

  throw Exception('Invalid url $url. Data not found.');
}

class ChapterEntry {
  const ChapterEntry(this.name, this.chapter);

  final String name;
  final WebChapter chapter;

  int get id => Object.hash(name, chapter);
}

class QueriedWebMangaViewWidget extends ConsumerWidget {
  const QueriedWebMangaViewWidget({
    super.key,
    this.proxy,
    this.code,
    this.handle,
  }) : assert((proxy != null && code != null) || handle != null);

  final String? proxy;
  final String? code;
  final SourceHandler? handle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hndl = handle ??
        SourceHandler(
          type: SourceType.proxy,
          source: proxy!,
          location: code!,
        );

    return DataProviderWhenWidget(
      provider: _fetchWebMangaInfoProvider(hndl),
      errorBuilder: (context, child) => Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.go(GagakuRoute.extensionHome);
              }
            },
          ),
        ),
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

class RedirectedWebMangaViewWidget extends StatelessWidget {
  const RedirectedWebMangaViewWidget({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return DataProviderWhenWidget(
      provider: _fetchWebMangaRedirectProvider(url),
      errorBuilder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            leading: BackButton(
              onPressed: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.go(GagakuRoute.extensionHome);
                }
              },
            ),
          ),
          body: Consumer(
            child: child,
            builder: (context, ref, child) => RefreshIndicator(
              onRefresh: () async => ref.refresh(_fetchWebMangaRedirectProvider(url).future),
              child: child!,
            ),
          ),
        );
      },
      builder: (context, data) => QueriedWebMangaViewWidget(handle: data),
    );
  }
}

class WebMangaViewWidget extends HookConsumerWidget {
  const WebMangaViewWidget({super.key, required this.manga, required this.handle});

  final WebManga manga;
  final SourceHandler handle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final api = ref.watch(proxyProvider);
    final theme = Theme.of(context);
    final link = HistoryLink(title: '${handle.source}: ${manga.title}', url: handle.getURL(), cover: manga.cover);
    final chapterlist = manga.chapters.entries.map((e) => ChapterEntry(e.key, e.value)).toList();
    //chapterlist.sort((a, b) => double.parse(b.name).compareTo(double.parse(a.name)));
    chapterlist.sort((a, b) => compareNatural(b.name, a.name));

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
              leading: BackButton(
                onPressed: () {
                  if (context.canPop()) {
                    context.pop();
                  } else {
                    context.go(GagakuRoute.extensionHome);
                  }
                },
              ),
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
                  colorBlendMode: BlendMode.modulate,
                  color: Colors.grey,
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              actions: [
                OverflowBar(
                  spacing: 8.0,
                  children: [
                    _FavoritesMenu(link: link, handle: handle),
                    Consumer(
                      builder: (context, ref, child) {
                        final key = handle.getKey();

                        return IconButton(
                          tooltip: 'webSources.resetRead'.tr(context: context),
                          style:
                              Styles.squareIconButtonStyle(backgroundColor: theme.colorScheme.surface.withAlpha(200)),
                          onPressed: () async {
                            final result = await showDialog<bool>(
                              context: context,
                              builder: (BuildContext context) {
                                final nav = Navigator.of(context);
                                return AlertDialog(
                                  title: Text('webSources.resetRead'.tr(context: context)),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('webSources.resetReadWarning'.tr(context: context)),
                                    ],
                                  ),
                                  actions: <Widget>[
                                    ElevatedButton(
                                      child: Text('ui.no'.tr(context: context)),
                                      onPressed: () {
                                        nav.pop(false);
                                      },
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        nav.pop(true);
                                      },
                                      child: Text('ui.yes'.tr(context: context)),
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
                    title: Text('mangaView.synopsis'.tr(context: context)),
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
                  title: Text('mangaView.info'.tr(context: context)),
                  children: [
                    MultiChildExpansionTile(
                      title: 'mangaView.author'.tr(context: context),
                      children: [
                        IconTextChip(
                          text: manga.author,
                        )
                      ],
                    ),
                    MultiChildExpansionTile(
                      title: 'mangaView.artist'.tr(context: context),
                      children: [
                        IconTextChip(
                          text: manga.artist,
                        )
                      ],
                    ),
                    MultiChildExpansionTile(
                      title: 'tracking.links'.tr(context: context),
                      children: [
                        if (handle.type == SourceType.proxy)
                          ButtonChip(
                            onPressed: () async {
                              final route = cleanBaseDomains(GoRouterState.of(context).uri.toString());
                              final url = Uri.parse('http://cubari.moe$route');

                              if (!await launchUrl(url)) {
                                throw 'Could not launch $url';
                              }
                            },
                            text: 'mangaView.openOn'.tr(context: context, args: ['cubari.moe']),
                          ),
                        if (handle.type == SourceType.source)
                          ButtonChip(
                            onPressed: () async {
                              final url = await ref
                                  .read(webSourceManagerProvider.notifier)
                                  .getMangaURL(handle.source, handle.location);
                              final uri = Uri.parse(url);

                              if (!await launchUrl(uri)) {
                                throw 'Could not launch $url';
                              }
                            },
                            text: 'mangaView.openOn'.tr(context: context, args: [handle.source]),
                          ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'mangaView.chapters'.tr(context: context),
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
                          final allRead = ref.watch(webReadMarkersProvider.select((value) => switch (value) {
                                AsyncValue(value: final data?) => data[key]?.containsAll(names) ?? false,
                                _ => false,
                              }));

                          final opt =
                              allRead ? 'mangaView.unread'.tr(context: context) : 'mangaView.read'.tr(context: context);

                          return ElevatedButton(
                            style: Styles.buttonStyle(padding: const EdgeInsets.symmetric(horizontal: 8.0)),
                            onPressed: () async {
                              final result = await showDialog<bool>(
                                context: context,
                                builder: (BuildContext context) {
                                  final nav = Navigator.of(context);
                                  return AlertDialog(
                                    title: Text('mangaView.markAllAs'.tr(context: context, args: [opt])),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('mangaView.markAllWarning'.tr(context: context, args: [opt])),
                                      ],
                                    ),
                                    actions: <Widget>[
                                      ElevatedButton(
                                        child: Text('ui.no'.tr(context: context)),
                                        onPressed: () {
                                          nav.pop(false);
                                        },
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          nav.pop(true);
                                        },
                                        child: Text('ui.yes'.tr(context: context)),
                                      ),
                                    ],
                                  );
                                },
                              );

                              if (result == true) {
                                ref.read(webReadMarkersProvider.setBulk)(key,
                                    read: !allRead ? names : null, unread: allRead ? names : null);
                              }
                            },
                            child: Text('mangaView.markAllAs'.tr(context: context, args: [opt])),
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
                final val = chapterlist.indexWhere((i) => i.id == valueKey.value);
                return val >= 0 ? val : null;
              },
              separatorBuilder: (_, __) => const SizedBox(
                height: 4.0,
              ),
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
  final VoidCallback? onLinkPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();
    final bool screenSizeSmall = DeviceContext.screenWidthSmall(context);
    final theme = Theme.of(context);
    final tileColor = theme.colorScheme.primaryContainer;
    final name = data.name;
    final key = handle.getKey();

    final isRead = ref.watch(webReadMarkersProvider.select((value) => switch (value) {
          AsyncValue(value: final data?) => data[key]?.contains(name) ?? false,
          _ => false,
        }));

    String title = data.chapter.getTitle(name);
    String group = data.chapter.groups.entries.first.key;

    final lang = context.locale.languageCode;
    //final locale = screenSizeSmall && timeagoLocaleList.contains('${lang}_short') ? '${lang}_short' : lang;

    String? timestamp;

    if (data.chapter.lastUpdated != null) {
      timestamp = timeago.format(data.chapter.lastUpdated!, locale: lang);
    } else if (data.chapter.releaseDate != null) {
      timestamp = timeago.format(data.chapter.releaseDate!, locale: lang);
    }

    final border = Border(
      left: BorderSide(color: isRead == true ? tileColor : Colors.blue, width: 4.0),
    );

    final textstyle = TextStyle(color: (isRead == true ? theme.disabledColor : theme.colorScheme.primary));

    final markReadBtn = IconButton(
      onPressed: () async {
        bool set = !isRead;

        ref.read(webReadMarkersProvider.set)(key, name, set);
      },
      padding: const EdgeInsets.all(0.0),
      splashRadius: 15,
      iconSize: 20,
      tooltip: 'mangaView.markAs'.tr(
          context: context,
          args: [isRead == true ? 'mangaView.unread'.tr(context: context) : 'mangaView.read'.tr(context: context)]),
      icon: Icon(isRead == true ? Icons.visibility_off : Icons.visibility,
          color: (isRead == true ? theme.disabledColor : theme.primaryIconTheme.color)),
      constraints: const BoxConstraints(minWidth: 20.0, minHeight: 20.0, maxWidth: 30.0, maxHeight: 30.0),
      visualDensity: const VisualDensity(horizontal: -4.0, vertical: -4.0),
    );

    var url = '/read/${handle.source}/${handle.location}/$name/1/';

    if (handle.type == SourceType.source) {
      url = '/read-chapter/${handle.source}/${handle.location}/${data.chapter.groups.entries.first.value}';
    }

    return ListTile(
      onTap: () {
        context.push(url,
            extra: WebReaderData(
              source: data.chapter.groups.entries.first.value,
              title: title,
              link: manga.title,
              handle: handle,
              readKey: name,
              onLinkPressed: onLinkPressed,
            ));
      },
      tileColor: theme.colorScheme.primaryContainer,
      dense: true,
      minVerticalPadding: 0.0,
      contentPadding: EdgeInsets.symmetric(horizontal: (screenSizeSmall ? 4.0 : 10.0)),
      minLeadingWidth: 0.0,
      leading: markReadBtn,
      shape: border,
      title: Text(
        title,
        style: textstyle,
      ),
      trailing: FittedBox(
        fit: BoxFit.fill,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!screenSizeSmall)
              IconTextChip(
                icon: const Icon(Icons.group, size: 20),
                text: manga.groups != null && manga.groups?.containsKey(group) == true ? manga.groups![group]! : group,
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

class _FavoritesMenu extends HookConsumerWidget {
  const _FavoritesMenu({
    required this.link,
    required this.handle,
  });

  final HistoryLink link;
  final SourceHandler handle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final cfg = ref.watch(webConfigProvider);

    final favorites = ref.watch(webSourceFavoritesProvider.select(
      (value) => switch (value) {
        AsyncValue(value: final data?) => data,
        _ => null,
      },
    ));

    final favorited =
        useMemoized(() => favorites?.values.any((l) => l.any((e) => e.url == handle.getURL())) ?? false, [favorites]);

    return MenuAnchor(
      builder: (context, controller, child) {
        return Material(
          color: theme.colorScheme.surfaceContainerHighest,
          borderRadius: const BorderRadius.all(Radius.circular(6.0)),
          child: favorites == null
              ? const SizedBox(
                  width: 36,
                  height: 36,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  ),
                )
              : InkWell(
                  onTap: () {
                    if (controller.isOpen) {
                      controller.close();
                    } else {
                      controller.open();
                    }
                  },
                  child: child,
                ),
        );
      },
      menuChildren: favorites != null
          ? List.generate(
              cfg.categories.length,
              (index) => Builder(
                builder: (context) {
                  final cat = cfg.categories.elementAt(index);
                  return CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text(cat.name),
                    value: favorites[cat.id]?.contains(link) ?? false,
                    onChanged: (bool? value) async {
                      if (value == true) {
                        await ref.read(webSourceFavoritesProvider.add)(cat.id, link);
                      } else {
                        await ref.read(webSourceFavoritesProvider.remove)(cat.id, link);
                      }
                    },
                  );
                },
              ),
            )
          : [],
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Icon(
          favorited ? Icons.favorite : Icons.favorite_border,
          color: favorited ? theme.colorScheme.primary : null,
        ),
      ),
    );
  }
}
