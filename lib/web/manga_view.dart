import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:gagaku/model.dart';
import 'package:gagaku/ui.dart';
import 'package:gagaku/util.dart';
import 'package:gagaku/web/model.dart';
import 'package:gagaku/web/types.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';

part 'manga_view.g.dart';

Page<dynamic> buildWebMangaViewPage(BuildContext context, GoRouterState state) {
  final manga = state.extra.asOrNull<WebManga>();

  Widget child;

  if (manga != null) {
    child = WebMangaViewWidget(
      manga: manga,
      info: ProxyInfo(
        proxy: state.pathParameters['proxy']!,
        code: state.pathParameters['code']!,
      ),
    );
  } else {
    child = QueriedWebMangaViewWidget(
      proxy: state.pathParameters['proxy']!,
      code: state.pathParameters['code']!,
    );
  }

  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
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
Future<WebManga> _fetchWebMangaInfo(_FetchWebMangaInfoRef ref, ProxyInfo info) async {
  final api = ref.watch(proxyProvider);
  final proxy = await api.handleProxy(info);

  if (proxy.manga != null) {
    return proxy.manga!;
  }

  throw Exception('Invalid WebManga link. Data not found.');
}

@riverpod
Future<ProxyInfo> _fetchWebMangaRedirect(_FetchWebMangaRedirectRef ref, String url) async {
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
  final ProxyInfo? info;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final api = ref.watch(proxyProvider);
    final inf = info ?? ProxyInfo(proxy: proxy!, code: code!);
    final mangaProvider = ref.watch(_fetchWebMangaInfoProvider(inf));

    Widget child;
    PreferredSizeWidget? appBar;

    switch (mangaProvider) {
      case AsyncValue(value: final manga?):
        child = RefreshIndicator(
          onRefresh: () async {
            await api.invalidateAll(inf.getKey());
            return ref.refresh(_fetchWebMangaInfoProvider(inf).future);
          },
          child: WebMangaViewWidget(manga: manga, info: inf),
        );
      case AsyncValue(:final error?, :final stackTrace?):
        child = RefreshIndicator(
          onRefresh: () async {
            await api.invalidateAll(inf.getKey());
            return ref.refresh(_fetchWebMangaInfoProvider(inf).future);
          },
          child: ErrorList(
            error: error,
            stackTrace: stackTrace,
            message: "_fetchWebMangaInfoProvider($proxy/$code) failed",
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
  final ProxyInfo info;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final link = HistoryLink(title: '${info.proxy}: ${manga.title}', url: info.getURL());
    final chapterlist = manga.chapters.entries.map((e) => ChapterEntry(e.key, e.value)).toList();
    chapterlist.sort((a, b) => double.parse(b.name).compareTo(double.parse(a.name)));

    useEffect(() {
      Future.delayed(Duration.zero, () {
        ref.read(webSourceHistoryProvider.notifier).add(link);
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
                    blurRadius: 1.0,
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
                Consumer(
                  builder: (context, ref, child) {
                    final favorited = ref.watch(webSourceFavoritesProvider.select(
                      (value) => switch (value) {
                        AsyncValue(value: final data?) => data.indexWhere((e) => e.url == info.getURL()) > -1,
                        _ => null,
                      },
                    ));

                    if (favorited == null) {
                      return const SizedBox(
                        width: 36,
                        height: 36,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    return IconButton.filledTonal(
                      tooltip: favorited ? 'Remove from Favorites' : 'Add to Favorites',
                      style: IconButton.styleFrom(
                        backgroundColor: theme.colorScheme.surface.withAlpha(200),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(6.0),
                          ),
                        ),
                      ),
                      color: favorited ? theme.colorScheme.primary : null,
                      onPressed: () async {
                        if (favorited) {
                          ref.read(webSourceFavoritesProvider.notifier).remove(link);
                        } else {
                          ref.read(webSourceFavoritesProvider.notifier).add(link);
                        }
                      },
                      icon: Icon(favorited ? Icons.favorite : Icons.favorite_border),
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
                    ButtonChip(
                      onPressed: () async {
                        final route = cleanBaseDomains(GoRouterState.of(context).uri.toString());
                        final url = Uri.parse('http://cubari.moe$route');

                        if (!await launchUrl(url)) {
                          throw 'Could not launch $url';
                        }
                      },
                      text: const Text('Open on cubari.moe'),
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
  final ProxyInfo info;
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

    final textstyle = TextStyle(color: (isRead == true ? theme.highlightColor : theme.colorScheme.primary));

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
          color: (isRead == true ? theme.highlightColor : theme.primaryIconTheme.color)),
      constraints: const BoxConstraints(minWidth: 20.0, minHeight: 20.0, maxWidth: 30.0, maxHeight: 30.0),
      visualDensity: const VisualDensity(horizontal: -4.0, vertical: -4.0),
    );

    return ListTile(
      onTap: () {
        context.push('/read/${info.proxy}/${info.code}/$name/1/',
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
