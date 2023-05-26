import 'package:animations/animations.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:gagaku/ui.dart';
import 'package:gagaku/util.dart';
import 'package:gagaku/web/reader.dart';
import 'package:gagaku/web/types.dart';
import 'package:timeago/timeago.dart' as timeago;

Route createMangaViewRoute(WebManga manga) {
  return Styles.buildSharedAxisTransitionRoute(
    (context, animation, secondaryAnimation) => WebMangaViewWidget(
      manga: manga,
    ),
    SharedAxisTransitionType.scaled,
  );
}

class ChapterEntry {
  const ChapterEntry(this.name, this.chapter);

  final String name;
  final WebChapter chapter;
}

class WebMangaViewWidget extends StatelessWidget {
  const WebMangaViewWidget({super.key, required this.manga});

  final WebManga manga;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final chapterlist = manga.chapters.entries
        .map((e) => ChapterEntry(e.key, e.value))
        .toList();
    chapterlist
        .sort((a, b) => double.parse(b.name).compareTo(double.parse(a.name)));

    return Scaffold(
      body: CustomScrollView(
        scrollBehavior: MouseTouchScrollBehavior(),
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            snap: false,
            floating: false,
            expandedHeight: 180.0,
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
                    color: theme.colorScheme.background,
                    child: Text(manga.description),
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
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                var e = chapterlist.elementAt(index);

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: ChapterButtonWidget(
                    name: e.name,
                    chapter: e.chapter,
                    manga: manga,
                    link: Text(
                      manga.title,
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                );
              },
              childCount: manga.chapters.length,
            ),
          ),
        ],
      ),
    );
  }
}

class ChapterButtonWidget extends StatelessWidget {
  const ChapterButtonWidget({
    super.key,
    required this.name,
    required this.chapter,
    required this.manga,
    this.link,
    this.onLinkPressed,
  });

  final String name;
  final WebChapter chapter;
  final WebManga manga;
  final Widget? link;
  final VoidCallback? onLinkPressed;

  @override
  Widget build(BuildContext context) {
    final bool screenSizeSmall = DeviceContext.screenWidthSmall(context);
    final theme = Theme.of(context);

    String title = 'Chapter $name';

    if (chapter.title.isNotEmpty) {
      title += ' - ${chapter.title}';
    }

    return Container(
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: theme.colorScheme.background, width: 4.0),
        ),
      ),
      child: ListTile(
        onTap: () {
          Navigator.push(
              context,
              createWebSourceReaderRoute(chapter.groups.entries.first.value,
                  title: title,
                  manga: manga,
                  link: link,
                  onLinkPressed: onLinkPressed));
        },
        tileColor: theme.colorScheme.primaryContainer,
        dense: true,
        minVerticalPadding: 0.0,
        contentPadding:
            EdgeInsets.symmetric(horizontal: (screenSizeSmall ? 4.0 : 10.0)),
        minLeadingWidth: 0.0,
        title: Text(
          title,
          style: TextStyle(color: theme.colorScheme.primary),
        ),
        trailing: !screenSizeSmall
            ? FittedBox(
                fit: BoxFit.fill,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconTextChip(
                      icon: const Icon(Icons.group, size: 20),
                      text: Text(chapter.groups.entries.first.key),
                    ),
                    const SizedBox(width: 10),
                    const Icon(Icons.schedule, size: 20),
                    const SizedBox(width: 5),
                    if (chapter.lastUpdated != null)
                      Text(timeago.format(chapter.lastUpdated!))
                  ],
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.schedule, size: 15),
                  const SizedBox(width: 5),
                  if (chapter.lastUpdated != null)
                    Text(timeago.format(chapter.lastUpdated!))
                ],
              ),
      ),
    );
  }
}
