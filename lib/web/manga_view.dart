import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/ui.dart';
import 'package:gagaku/util.dart';
import 'package:gagaku/web/model.dart';
import 'package:gagaku/web/reader.dart';
import 'package:gagaku/web/types.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart' as custom_tabs;

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
    final manga = ref.watch(_fetchWebMangaInfoProvider(info));

    Widget child;
    PreferredSizeWidget? appBar;

    switch (manga) {
      case AsyncData(:final value):
        child = RefreshIndicator(
          onRefresh: () async {
            await api.invalidateAll(info.getKey());
            return await ref.refresh(_fetchWebMangaInfoProvider(info).future);
          },
          child: WebMangaViewWidget(manga: value, info: info),
        );
      case AsyncError(:final error, :final stackTrace):
        final messenger = ScaffoldMessenger.of(context);
        Styles.showErrorSnackBar(messenger, '$error');
        logger.e("_fetchWebMangaInfoProvider($proxy/$code) failed",
            error: error, stackTrace: stackTrace);

        child = Styles.errorColumn(error, stackTrace);
        appBar = AppBar();
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

class WebMangaViewWidget extends ConsumerWidget {
  const WebMangaViewWidget(
      {super.key, required this.manga, required this.info});

  final WebManga manga;
  final ProxyInfo info;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final chapterlist = manga.chapters.entries
        .map((e) => ChapterEntry(e.key, e.value))
        .toList();
    chapterlist
        .sort((a, b) => double.parse(b.name).compareTo(double.parse(a.name)));

    final readMarkers = ref.watch(webReadMarkersProvider).valueOrNull;

    return CustomScrollView(
      scrollBehavior: MouseTouchScrollBehavior(),
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          snap: false,
          floating: false,
          expandedHeight: 200.0,
          leading: context.canPop()
              ? BackButton(
                  onPressed: () => context.pop(),
                )
              : null,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              manga.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(2.0, 2.0),
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
        if (manga.description.isNotEmpty)
          SliverToBoxAdapter(
            child: ExpansionTile(
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              title: const Text('Synopsis'),
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  color: theme.colorScheme.surfaceVariant,
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
          ),
        SliverToBoxAdapter(
          child: ExpansionTile(
            title: const Text('Info'),
            children: [
              ExpansionTile(
                title: const Text('Author'),
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: theme.colorScheme.background,
                    child: Row(
                      children: [
                        IconTextChip(
                          text: Text(manga.author),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              ExpansionTile(
                title: const Text('Artist'),
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: theme.colorScheme.background,
                    child: Row(
                      children: [
                        IconTextChip(
                          text: Text(manga.artist),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              ExpansionTile(
                expandedAlignment: Alignment.centerLeft,
                title: const Text('Links'),
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: theme.colorScheme.background,
                    child: Wrap(
                      spacing: 4.0,
                      runSpacing: 4.0,
                      children: [
                        ButtonChip(
                          onPressed: () async {
                            final route =
                                GoRouterState.of(context).uri.toString();
                            final url = 'https://cubari.moe$route';

                            if (DeviceContext.isMobile()) {
                              try {
                                await custom_tabs.launch(
                                  url,
                                  customTabsOption:
                                      const custom_tabs.CustomTabsOption(
                                    extraCustomTabs: <String>[
                                      'org.mozilla.firefox',
                                      'com.microsoft.emmx',
                                    ],
                                  ),
                                );
                              } catch (e) {
                                // An exception is thrown if browser app is not installed on Android device.
                                debugPrint(e.toString());
                              }
                            } else if (!await launchUrl(Uri.parse(url))) {
                              throw 'Could not launch $url';
                            }
                          },
                          text: const Text('Open on cubari.moe'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.all(8),
            color: theme.cardColor,
            child: const Text(
              'Chapters',
              style: TextStyle(fontSize: 24),
            ),
          ),
        ),
        SliverList.builder(
          itemBuilder: (BuildContext context, int index) {
            final e = chapterlist.elementAt(index);

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: ChapterButtonWidget(
                name: e.name,
                chapter: e.chapter,
                manga: manga,
                info: info,
                isRead: readMarkers?[info.getURL()]?.contains(e.name) ?? false,
                link: Text(
                  manga.title,
                  style: const TextStyle(fontSize: 24),
                ),
              ),
            );
          },
          itemCount: manga.chapters.length,
        ),
      ],
    );
  }
}

class ChapterButtonWidget extends ConsumerWidget {
  const ChapterButtonWidget({
    super.key,
    required this.name,
    required this.chapter,
    required this.manga,
    required this.info,
    required this.isRead,
    this.link,
    this.onLinkPressed,
  });

  final String name;
  final WebChapter chapter;
  final WebManga manga;
  final ProxyInfo info;
  final bool isRead;
  final Widget? link;
  final VoidCallback? onLinkPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool screenSizeSmall = DeviceContext.screenWidthSmall(context);
    final theme = Theme.of(context);
    final tileColor = theme.colorScheme.primaryContainer;

    String title = chapter.getTitle(name);
    String group = chapter.groups.entries.first.key;

    Widget? timestamp;

    if (chapter.lastUpdated != null) {
      timestamp = Text(timeago.format(chapter.lastUpdated!));
    } else if (chapter.releaseDate != null) {
      timestamp = Text(timeago.format(chapter.releaseDate!));
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

        ref.read(webReadMarkersProvider.notifier).set(info.getURL(), name, set);
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
              source: chapter.groups.entries.first.value,
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
                    text: Text(manga.groups != null &&
                            manga.groups?.containsKey(group) == true
                        ? manga.groups![group]!
                        : group),
                  ),
                  const SizedBox(width: 10),
                  const Icon(Icons.schedule, size: 20),
                  const SizedBox(width: 5),
                  if (timestamp != null) timestamp
                ],
              ),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.schedule, size: 15),
                const SizedBox(width: 5),
                if (timestamp != null) timestamp
              ],
            ),
    );
  }
}
