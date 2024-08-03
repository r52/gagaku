import 'package:extended_image/extended_image.dart';
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
          code: state.pathParameters['code']!),
    );
  } else {
    child = QueriedWebMangaViewWidget(
        proxy: state.pathParameters['proxy']!,
        code: state.pathParameters['code']!);
  }

  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: Styles.scaledSharedAxisTransitionBuilder,
  );
}

@riverpod
Future<WebManga> _fetchWebMangaInfo(
    _FetchWebMangaInfoRef ref, ProxyInfo info) async {
  final api = ref.watch(proxyProvider);
  final proxy = await api.handleProxy(info);

  if (proxy.manga != null) {
    ref.read(webSourceHistoryProvider.notifier).add(HistoryLink(
        title: '${info.proxy}: ${proxy.manga?.title}', url: info.getURL()));
    return proxy.manga!;
  }

  throw Exception('Invalid WebManga link. Data not found.');
}

class ChapterEntry {
  const ChapterEntry(this.name, this.chapter);

  final String name;
  final WebChapter chapter;

  int get id => Object.hash(name, chapter);
}

class QueriedWebMangaViewWidget extends ConsumerWidget {
  const QueriedWebMangaViewWidget(
      {super.key, required this.proxy, required this.code});

  final String proxy;
  final String code;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final api = ref.watch(proxyProvider);
    final info = ProxyInfo(proxy: proxy, code: code);
    final mangaProvider = ref.watch(_fetchWebMangaInfoProvider(info));

    Widget child;
    PreferredSizeWidget? appBar;

    switch (mangaProvider) {
      case AsyncValue(value: final manga?):
        child = RefreshIndicator(
          onRefresh: () async {
            await api.invalidateAll(info.getKey());
            return ref.refresh(_fetchWebMangaInfoProvider(info).future);
          },
          child: WebMangaViewWidget(manga: manga, info: info),
        );
      case AsyncValue(:final error?, :final stackTrace?):
        child = RefreshIndicator(
          onRefresh: () async {
            await api.invalidateAll(info.getKey());
            return ref.refresh(_fetchWebMangaInfoProvider(info).future);
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

class WebMangaViewWidget extends StatelessWidget {
  const WebMangaViewWidget(
      {super.key, required this.manga, required this.info});

  final WebManga manga;
  final ProxyInfo info;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final chapterlist = manga.chapters.entries
        .map((e) => ChapterEntry(e.key, e.value))
        .toList();
    chapterlist
        .sort((a, b) => double.parse(b.name).compareTo(double.parse(a.name)));

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
                context.go(GagakuRoute.web);
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
            background: ExtendedImage.network(
              manga.cover,
              cache: true,
              colorBlendMode: BlendMode.modulate,
              color: Colors.grey,
              fit: BoxFit.cover,
              loadStateChanged: extendedImageLoadStateHandler,
            ),
          ),
        ),
        SliverList.list(children: [
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
                      var route = GoRouterState.of(context).uri.toString();
                      route = route.replaceFirst('https://cubari.moe', '');
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
        ]),
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

    final isRead =
        ref.watch(webReadMarkersProvider.select((value) => switch (value) {
              AsyncValue(value: final data?) =>
                data[key]?.contains(name) ?? false,
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
      left: BorderSide(
          color: isRead == true ? tileColor : Colors.blue, width: 4.0),
    );

    final textstyle = TextStyle(
        color: (isRead == true
            ? theme.highlightColor
            : theme.colorScheme.primary));

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
          color: (isRead == true
              ? theme.highlightColor
              : theme.primaryIconTheme.color)),
      constraints: const BoxConstraints(
          minWidth: 20.0, minHeight: 20.0, maxWidth: 30.0, maxHeight: 30.0),
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
      contentPadding:
          EdgeInsets.symmetric(horizontal: (screenSizeSmall ? 4.0 : 10.0)),
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
                    text: manga.groups != null &&
                            manga.groups?.containsKey(group) == true
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
                  const WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Icon(Icons.schedule, size: 15)),
                  if (timestamp != null) TextSpan(text: ' $timestamp'),
                ],
              ),
            ),
    );
  }
}
