import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:gagaku/model.dart';
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
  final info = state.extra.asOrNull<SourceInfo>();

  final proxy = state.pathParameters['proxy'] ?? state.pathParameters['source'];
  final code = state.pathParameters['code'] ?? state.pathParameters['url'];

  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: QueriedWebMangaViewWidget(
      proxy: proxy,
      code: code,
      info: info,
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

@riverpod
Future<WebManga> _fetchWebMangaInfo(_FetchWebMangaInfoRef ref, SourceInfo info) async {
  final api = ref.watch(proxyProvider);
  final proxy = await api.handleSource(info);

  if (proxy.manga != null) {
    return proxy.manga!;
  }

  throw Exception('Invalid WebManga link. Data not found.');
}

@riverpod
Future<SourceInfo> _fetchWebMangaRedirect(_FetchWebMangaRedirectRef ref, String url) async {
  final api = ref.watch(proxyProvider);
  final proxy = await api.parseUrl(url);

  if (proxy != null) {
    return proxy;
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
    this.info,
  }) : assert((proxy != null && code != null) || info != null);

  final String? proxy;
  final String? code;
  final SourceInfo? info;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final api = ref.watch(proxyProvider);
    final inf = info ??
        SourceInfo(
          type: SourceType.proxy,
          source: proxy!,
          location: code!,
        );
    final mangaProvider = ref.watch(_fetchWebMangaInfoProvider(inf));

    Widget child;
    PreferredSizeWidget? appBar;

    switch (mangaProvider) {
      case AsyncValue(value: final manga?):
        child = WebMangaViewWidget(manga: manga, info: inf);
      case AsyncValue(:final error?, :final stackTrace?):
        child = ErrorList(
          error: error,
          stackTrace: stackTrace,
          message: "_fetchWebMangaInfoProvider($proxy/$code) failed",
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
      body: RefreshIndicator(
        onRefresh: () async {
          await api.invalidateAll(inf.getKey());
          return ref.refresh(_fetchWebMangaInfoProvider(inf).future);
        },
        child: child,
      ),
    );
  }
}

class RedirectedWebMangaViewWidget extends ConsumerWidget {
  const RedirectedWebMangaViewWidget({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final infoProvider = ref.watch(_fetchWebMangaRedirectProvider(url));

    Widget child;
    PreferredSizeWidget? appBar;

    switch (infoProvider) {
      case AsyncValue(value: final info?):
        return QueriedWebMangaViewWidget(info: info);
      case AsyncValue(:final error?, :final stackTrace?):
        child = RefreshIndicator(
          onRefresh: () async => ref.refresh(_fetchWebMangaRedirectProvider(url).future),
          child: ErrorList(
            error: error,
            stackTrace: stackTrace,
            message: "_fetchWebMangaRedirectProvider($url) failed",
          ),
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

class WebMangaViewWidget extends HookConsumerWidget {
  const WebMangaViewWidget({super.key, required this.manga, required this.info});

  final WebManga manga;
  final SourceInfo info;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final link = HistoryLink(title: '${info.source}: ${manga.title}', url: info.getURL(), cover: manga.cover);
    final chapterlist = manga.chapters.entries.map((e) => ChapterEntry(e.key, e.value)).toList();
    //chapterlist.sort((a, b) => double.parse(b.name).compareTo(double.parse(a.name)));
    chapterlist.sort((a, b) => compareNatural(b.name, a.name));

    useEffect(() {
      Future.delayed(Duration.zero, () {
        ref.read(webSourceHistoryProvider.notifier).add(link);
        ref.read(webSourceFavoritesProvider.notifier).updateAll(link);
      });
      return null;
    }, []);

    return CustomScrollView(
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
                context.go(GagakuRoute.proxyHome);
              }
            },
          ),
          flexibleSpace: FlexibleSpaceBar(
            expandedTitleScale: 3.0,
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
                  Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          actions: [
            OverflowBar(
              spacing: 8.0,
              children: [
                _FavoritesMenu(link: link, info: info),
                Consumer(
                  builder: (context, ref, child) {
                    final key = info.getKey();

                    return IconButton(
                      tooltip: 'Reset Read Markers',
                      style: Styles.squareIconButtonStyle(backgroundColor: theme.colorScheme.surface.withAlpha(200)),
                      onPressed: () async {
                        final result = await showDialog<bool>(
                          context: context,
                          builder: (BuildContext context) {
                            final nav = Navigator.of(context);
                            return AlertDialog(
                              title: const Text('Reset Read Markers'),
                              content: const Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Are you sure you want to reset all read markers for this manga?'),
                                ],
                              ),
                              actions: <Widget>[
                                ElevatedButton(
                                  child: const Text('No'),
                                  onPressed: () {
                                    nav.pop(false);
                                  },
                                ),
                                TextButton(
                                  onPressed: () {
                                    nav.pop(true);
                                  },
                                  child: const Text('Yes'),
                                ),
                              ],
                            );
                          },
                        );

                        if (result == true) {
                          ref.read(webReadMarkersProvider.notifier).deleteKey(key);
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
                title: const Text('Synopsis'),
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
              title: const Text('Info'),
              children: [
                MultiChildExpansionTile(
                  title: 'Author',
                  children: [
                    IconTextChip(
                      text: manga.author,
                    )
                  ],
                ),
                MultiChildExpansionTile(
                  title: 'Artist',
                  children: [
                    IconTextChip(
                      text: manga.artist,
                    )
                  ],
                ),
                MultiChildExpansionTile(
                  title: 'Links',
                  children: [
                    if (info.type == SourceType.proxy)
                      ButtonChip(
                        onPressed: () async {
                          final route = cleanBaseDomains(GoRouterState.of(context).uri.toString());
                          final url = Uri.parse('http://cubari.moe$route');

                          if (!await launchUrl(url)) {
                            throw 'Could not launch $url';
                          }
                        },
                        text: 'Open on cubari.moe',
                      ),
                    if (info.type == SourceType.source)
                      ButtonChip(
                        onPressed: () async {
                          final url = Uri.parse(info.location);

                          if (!await launchUrl(url)) {
                            throw 'Could not launch $url';
                          }
                        },
                        text: 'Open on ${info.source}',
                      ),
                  ],
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'Chapters',
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
                      final key = info.getKey();
                      final names = chapterlist.map((e) => e.name);
                      final allRead = ref.watch(webReadMarkersProvider.select((value) => switch (value) {
                            AsyncValue(value: final data?) => data[key]?.containsAll(names) ?? false,
                            _ => false,
                          }));

                      final opt = allRead ? 'unread' : 'read';

                      return ElevatedButton(
                        style: Styles.buttonStyle(padding: const EdgeInsets.symmetric(horizontal: 8.0)),
                        onPressed: () async {
                          final result = await showDialog<bool>(
                            context: context,
                            builder: (BuildContext context) {
                              final nav = Navigator.of(context);
                              return AlertDialog(
                                title: Text('Mark all as $opt'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Are you sure you want to mark all chapters as $opt?'),
                                  ],
                                ),
                                actions: <Widget>[
                                  ElevatedButton(
                                    child: const Text('No'),
                                    onPressed: () {
                                      nav.pop(false);
                                    },
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      nav.pop(true);
                                    },
                                    child: const Text('Yes'),
                                  ),
                                ],
                              );
                            },
                          );

                          if (result == true) {
                            ref
                                .read(webReadMarkersProvider.notifier)
                                .setBulk(key, read: !allRead ? names : null, unread: allRead ? names : null);
                          }
                        },
                        child: Text('Mark all chapters as $opt'),
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
              info: info,
              link: Text(
                manga.title,
                style: const TextStyle(fontSize: 24),
              ),
            );
          },
          itemCount: manga.chapters.length,
        ),
      ],
    );
  }
}

class ChapterButtonWidget extends HookConsumerWidget {
  const ChapterButtonWidget({
    super.key,
    required this.data,
    required this.manga,
    required this.info,
    this.link,
    this.onLinkPressed,
  });

  final ChapterEntry data;
  final WebManga manga;
  final SourceInfo info;
  final Widget? link;
  final VoidCallback? onLinkPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();
    final bool screenSizeSmall = DeviceContext.screenWidthSmall(context);
    final theme = Theme.of(context);
    final tileColor = theme.colorScheme.primaryContainer;
    final name = data.name;
    final key = info.getKey();

    final isRead = ref.watch(webReadMarkersProvider.select((value) => switch (value) {
          AsyncValue(value: final data?) => data[key]?.contains(name) ?? false,
          _ => false,
        }));

    String title = data.chapter.getTitle(name);
    String group = data.chapter.groups.entries.first.key;

    String? timestamp;

    if (data.chapter.lastUpdated != null) {
      timestamp = timeago.format(data.chapter.lastUpdated!);
    } else if (data.chapter.releaseDate != null) {
      timestamp = timeago.format(data.chapter.releaseDate!);
    }

    final border = Border(
      left: BorderSide(color: isRead == true ? tileColor : Colors.blue, width: 4.0),
    );

    final textstyle = TextStyle(color: (isRead == true ? theme.disabledColor : theme.colorScheme.primary));

    final markReadBtn = IconButton(
      onPressed: () async {
        bool set = !isRead;

        ref.read(webReadMarkersProvider.notifier).set(key, name, set);
      },
      padding: const EdgeInsets.all(0.0),
      splashRadius: 15,
      iconSize: 20,
      tooltip: isRead == true ? 'Unmark as read' : 'Mark as read',
      icon: Icon(isRead == true ? Icons.visibility_off : Icons.visibility,
          color: (isRead == true ? theme.disabledColor : theme.primaryIconTheme.color)),
      constraints: const BoxConstraints(minWidth: 20.0, minHeight: 20.0, maxWidth: 30.0, maxHeight: 30.0),
      visualDensity: const VisualDensity(horizontal: -4.0, vertical: -4.0),
    );

    var url = '/read/${info.source}/${info.location}/$name/1/';

    if (info.type == SourceType.source) {
      url = '/read-chapter/${info.source}/${data.chapter.groups.entries.first.value}';
    }

    return ListTile(
      onTap: () {
        context.push(url,
            extra: WebReaderData(
              source: data.chapter.groups.entries.first.value,
              title: title,
              manga: manga,
              link: link,
              info: info,
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
      trailing: !screenSizeSmall
          ? FittedBox(
              fit: BoxFit.fill,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconTextChip(
                    icon: const Icon(Icons.group, size: 20),
                    text: manga.groups != null && manga.groups?.containsKey(group) == true
                        ? manga.groups![group]!
                        : group,
                  ),
                  const SizedBox(width: 10),
                  const Icon(Icons.schedule, size: 20),
                  if (timestamp != null) Text(' $timestamp'),
                ],
              ),
            )
          : Text.rich(
              TextSpan(
                children: [
                  const WidgetSpan(alignment: PlaceholderAlignment.middle, child: Icon(Icons.schedule, size: 15)),
                  if (timestamp != null) TextSpan(text: ' $timestamp'),
                ],
              ),
            ),
    );
  }
}

class _FavoritesMenu extends HookConsumerWidget {
  const _FavoritesMenu({
    required this.link,
    required this.info,
  });

  final HistoryLink link;
  final SourceInfo info;

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
        useMemoized(() => favorites?.values.any((l) => l.any((e) => e.url == info.getURL())) ?? false, [favorites]);

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
                        await ref.read(webSourceFavoritesProvider.notifier).add(cat.id, link);
                      } else {
                        await ref.read(webSourceFavoritesProvider.notifier).remove(cat.id, link);
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
