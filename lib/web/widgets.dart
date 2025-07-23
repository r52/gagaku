import 'dart:collection';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/model/config.dart';
import 'package:gagaku/reader/main.dart';
import 'package:gagaku/routes.gr.dart';
import 'package:gagaku/util/cached_network_image.dart';
import 'package:gagaku/util/ui.dart';
import 'package:gagaku/util/util.dart';
import 'package:gagaku/web/model/model.dart';
import 'package:gagaku/web/model/types.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:timeago/timeago.dart' as timeago;

part 'widgets.g.dart';

enum WebMangaListView { grid, list }

Widget? _getSourceIcon(HistoryLink link, Map<String, WebSourceInfo> sources) {
  Widget? sourceIcon;

  if (link.handle != null) {
    final srcId = link.handle!.sourceId;
    if (sources.containsKey(srcId) && sources[srcId]!.icon.isNotEmpty) {
      final icon = sources[srcId]!.icon;
      sourceIcon = Image.network(icon, width: 24, height: 24);
    } else {
      sourceIcon = Text(
        link.handle!.sourceId,
        style: const TextStyle(fontSize: 12),
      );
    }
  }

  return sourceIcon;
}

@Riverpod(keepAlive: true)
class _MangaListView extends _$MangaListView {
  @override
  WebMangaListView build() => WebMangaListView.grid;

  @override
  set state(WebMangaListView newState) => super.state = newState;
  WebMangaListView update(
    WebMangaListView Function(WebMangaListView state) cb,
  ) => state = cb(state);
}

class WebMangaListWidget extends HookConsumerWidget {
  const WebMangaListWidget({
    super.key,
    this.title,
    required this.children,
    this.leading = const <Widget>[],
    this.physics,
    this.controller,
    this.noController = false,
    this.showToggle = true,
    this.isLoading = false,
  });

  final Widget? title;
  final List<Widget> children;
  final List<Widget> leading;
  final ScrollPhysics? physics;
  final ScrollController? controller;
  final bool noController;
  final bool showToggle;
  final bool isLoading;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tr = context.t;
    final scrollController =
        controller ?? (noController ? null : useScrollController());
    final view = showToggle
        ? ref.watch(_mangaListViewProvider)
        : WebMangaListView.grid;

    return Stack(
      children: [
        CustomScrollView(
          controller: scrollController,
          scrollBehavior: const MouseTouchScrollBehavior(),
          physics: physics,
          // cacheExtent: MediaQuery.sizeOf(context).height,
          slivers: [
            ...leading,
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 10.0,
                ),
                child: Row(
                  children: [
                    if (title != null) title!,
                    const Spacer(),
                    const GridExtentSlider(),
                    if (showToggle)
                      SegmentedButton<WebMangaListView>(
                        showSelectedIcon: false,
                        style: SegmentedButton.styleFrom(
                          shape: const RoundedRectangleBorder(),
                        ),
                        segments: <ButtonSegment<WebMangaListView>>[
                          ButtonSegment<WebMangaListView>(
                            value: WebMangaListView.grid,
                            icon: Icon(Icons.grid_view, size: 24),
                            tooltip: tr.ui.gridView,
                          ),
                          ButtonSegment<WebMangaListView>(
                            value: WebMangaListView.list,
                            icon: Icon(Icons.table_rows, size: 24),
                            tooltip: tr.ui.listView,
                          ),
                        ],
                        selected: <WebMangaListView>{view},
                        onSelectionChanged:
                            (Set<WebMangaListView> newSelection) {
                              ref.read(_mangaListViewProvider.notifier).state =
                                  newSelection.first;
                            },
                      ),
                  ],
                ),
              ),
            ),
            ...children,
          ],
        ),
        if (isLoading) ...Styles.loadingOverlay,
      ],
    );
  }
}

class WebMangaListViewSliver extends ConsumerWidget {
  const WebMangaListViewSliver({
    super.key,
    this.items,
    this.controller,
    this.favoritesKey,
    this.reorderable = false,
    this.showRemoveButton = true,
  }) : assert(items != null || controller != null),
       assert(
         reorderable == false || (reorderable == true && favoritesKey != null),
       );

  final String? favoritesKey;
  final List<HistoryLink>? items;
  final bool reorderable;
  final bool showRemoveButton;

  final PagingController<dynamic, HistoryLink>? controller;

  int? _findChildIndexCb(Key? key) {
    final valueKey = key as ValueKey<String>;
    final val = items!.indexWhere((i) => i.url == valueKey.value);
    return val >= 0 ? val : null;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sourcesMap = ref.watch(
      extensionInfoListProvider.select(
        (value) => switch (value) {
          AsyncValue(value: final data?) => data,
          _ => <String, WebSourceInfo>{},
        },
      ),
    );
    final api = ref.watch(proxyProvider);
    WebMangaListView view = items != null
        ? ref.watch(_mangaListViewProvider)
        : WebMangaListView.grid;
    final gridExtent = ref.watch(
      gagakuSettingsProvider.select((c) => c.gridAlbumExtent),
    );
    final theme = Theme.of(context);

    if (items != null) {
      switch (view) {
        case WebMangaListView.list:
          return reorderable
              ? SliverReorderableList(
                  onReorder: (int oldIndex, int newIndex) =>
                      webSourceFavoritesMutation.run(ref, (ref) async {
                        return await ref
                            .get(webSourceFavoritesProvider.notifier)
                            .updateList(favoritesKey!, oldIndex, newIndex);
                      }),
                  itemCount: items!.length,
                  // findChildIndexCallback: _findChildIndexCb,
                  itemBuilder: (context, index) {
                    final item = items!.elementAt(index);
                    Widget? sourceIcon = _getSourceIcon(item, sourcesMap);

                    return ReorderableDelayedDragStartListener(
                      key: ValueKey(item.url),
                      index: index,
                      child: ListTile(
                        tileColor: index.isOdd
                            ? theme.colorScheme.surfaceContainer
                            : theme.colorScheme.surfaceContainerHighest,
                        leading: FavoritesButton(link: item),
                        title: Text(item.title),
                        textColor: theme.colorScheme.onSurface,
                        onTap: () async {
                          final tr = context.t;
                          final messenger = ScaffoldMessenger.of(context);
                          final result = await api.handleLink(item);

                          if (!context.mounted) return;
                          if (result.handle == null) {
                            messenger
                              ..removeCurrentSnackBar()
                              ..showSnackBar(
                                SnackBar(
                                  content: Text(tr.errors.unsupportedUrl),
                                  backgroundColor: Colors.red,
                                ),
                              );
                          } else {
                            openWebSource(context, result.handle!);
                          }
                        },
                        trailing: sourceIcon,
                      ),
                    );
                  },
                )
              : SliverList.separated(
                  itemCount: items!.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 4.0),
                  findChildIndexCallback: _findChildIndexCb,
                  itemBuilder: (context, index) {
                    final tr = context.t;
                    final item = items!.elementAt(index);
                    Widget? sourceIcon = _getSourceIcon(item, sourcesMap);

                    return ListTile(
                      key: ValueKey(item.url),
                      tileColor: index.isOdd
                          ? theme.colorScheme.surfaceContainer
                          : theme.colorScheme.surfaceContainerHighest,
                      leading: FavoritesButton(link: item),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (sourceIcon != null) sourceIcon,
                          IconButton(
                            tooltip: tr.mangaActions.removeHistory,
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () async {
                              webSourceHistoryMutation.run(ref, (ref) async {
                                await ref
                                    .get(webSourceHistoryProvider.notifier)
                                    .remove(item);
                              });
                            },
                          ),
                        ],
                      ),
                      title: Text(item.title),
                      textColor: theme.colorScheme.onSurface,
                      onTap: () async {
                        final tr = context.t;
                        final messenger = ScaffoldMessenger.of(context);
                        final result = await api.handleLink(item);

                        if (!context.mounted) return;
                        if (result.handle == null) {
                          messenger
                            ..removeCurrentSnackBar()
                            ..showSnackBar(
                              SnackBar(
                                content: Text(tr.errors.unsupportedUrl),
                                backgroundColor: Colors.red,
                              ),
                            );
                        } else {
                          openWebSource(context, result.handle!);
                        }
                      },
                    );
                  },
                );

        case WebMangaListView.grid:
          return SliverGrid.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: gridExtent.grid,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 0.7,
            ),
            findChildIndexCallback: _findChildIndexCb,
            itemBuilder: (context, index) {
              final item = items!.elementAt(index);
              return GridMangaItem(
                key: ValueKey(item.url),
                link: item,
                showRemoveButton: showRemoveButton,
              );
            },
            itemCount: items!.length,
          );
      }
    }

    return PagingListener(
      controller: controller!,
      builder: (context, state, fetchNextPage) {
        switch (view) {
          case WebMangaListView.list:
            return PagedSliverList.separated(
              state: state,
              fetchNextPage: fetchNextPage,
              separatorBuilder: (_, _) => const SizedBox(height: 4.0),
              builderDelegate: PagedChildBuilderDelegate<HistoryLink>(
                animateTransitions: true,
                itemBuilder: (context, item, index) {
                  final tr = context.t;
                  return ListTile(
                    key: ValueKey(item.url),
                    tileColor: index.isOdd
                        ? theme.colorScheme.surfaceContainer
                        : theme.colorScheme.surfaceContainerHighest,
                    leading: FavoritesButton(link: item),
                    trailing: showRemoveButton
                        ? IconButton(
                            tooltip: tr.mangaActions.removeHistory,
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () async {
                              webSourceHistoryMutation.run(ref, (ref) async {
                                await ref
                                    .get(webSourceHistoryProvider.notifier)
                                    .remove(item);
                              });
                            },
                          )
                        : null,
                    title: Text(item.title),
                    textColor: theme.colorScheme.onSurface,
                    onTap: () async {
                      final tr = context.t;
                      final messenger = ScaffoldMessenger.of(context);
                      final result = await api.handleLink(item);

                      if (!context.mounted) return;
                      if (result.handle == null) {
                        messenger
                          ..removeCurrentSnackBar()
                          ..showSnackBar(
                            SnackBar(
                              content: Text(tr.errors.unsupportedUrl),
                              backgroundColor: Colors.red,
                            ),
                          );
                      } else {
                        openWebSource(context, result.handle!);
                      }
                    },
                  );
                },
              ),
            );
          case WebMangaListView.grid:
            return PagedSliverGrid(
              state: state,
              fetchNextPage: fetchNextPage,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: gridExtent.grid,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 0.7,
              ),
              builderDelegate: PagedChildBuilderDelegate<HistoryLink>(
                animateTransitions: true,
                itemBuilder: (context, item, index) {
                  return GridMangaItem(
                    key: ValueKey(item.url),
                    link: item,
                    showRemoveButton: showRemoveButton,
                  );
                },
              ),
            );
        }
      },
    );
  }
}

class GridMangaItem extends HookConsumerWidget {
  const GridMangaItem({
    super.key,
    required this.link,
    this.showFavoriteButton = true,
    this.showRemoveButton = true,
  });

  final HistoryLink link;
  final bool showFavoriteButton;
  final bool showRemoveButton;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();
    final tr = context.t;
    final sourcesMap = ref.watch(
      extensionInfoListProvider.select(
        (value) => switch (value) {
          AsyncValue(value: final data?) => data,
          _ => <String, WebSourceInfo>{},
        },
      ),
    );
    final api = ref.watch(proxyProvider);
    final aniController = useAnimationController(
      duration: const Duration(milliseconds: 100),
    );
    final gradient = useAnimation(
      aniController.drive(Styles.coverArtGradientTween),
    );
    final theme = Theme.of(context);

    final Widget cover = link.cover != null
        ? CachedNetworkImage(
            imageUrl: link.cover!,
            cacheManager: gagakuImageCache,
            memCacheWidth: 512,
            maxWidthDiskCache: 512,
            width: 128.0,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            fit: BoxFit.cover,
          )
        : const Icon(Icons.menu_book, size: 128.0);

    Widget? sourceIcon = _getSourceIcon(link, sourcesMap);

    return InkWell(
      onTap: () async {
        final messenger = ScaffoldMessenger.of(context);
        final result = await api.handleLink(link);

        if (!context.mounted) return;
        if (result.handle == null) {
          messenger
            ..removeCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(tr.errors.unsupportedUrl),
                backgroundColor: Colors.red,
              ),
            );
        } else {
          openWebSource(context, result.handle!);
        }
      },
      onHover: (hovering) {
        if (hovering) {
          aniController.forward();
        } else {
          aniController.reverse();
        }
      },
      child: Stack(
        children: [
          GridTile(
            footer: GridAlbumTextBar(height: 80, text: link.title),
            child: GridAlbumImage(gradient: gradient, child: cover),
          ),
          if (sourceIcon != null)
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.only(right: 0.0, bottom: 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [sourceIcon],
                ),
              ),
            ),
          if (showFavoriteButton)
            Align(
              alignment: Alignment.topLeft,
              child: FavoritesButton(link: link),
            ),
          if (showRemoveButton)
            Align(
              alignment: Alignment.topRight,
              child: FloatingActionButton(
                heroTag: UniqueKey(),
                mini: true,
                shape: const CircleBorder(),
                tooltip: tr.mangaActions.removeHistory,
                onPressed: () async {
                  webSourceHistoryMutation.run(ref, (ref) async {
                    await ref
                        .get(webSourceHistoryProvider.notifier)
                        .remove(link);
                  });
                },
                backgroundColor: theme.colorScheme.errorContainer,
                child: Icon(
                  Icons.delete,
                  color: theme.colorScheme.onErrorContainer,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class FavoritesButton extends HookConsumerWidget {
  const FavoritesButton({super.key, required this.link, this.borderRadius});

  final HistoryLink link;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tr = context.t;
    final theme = Theme.of(context);

    final favorites = ref.watch(
      webSourceFavoritesProvider.select(
        (value) => switch (value) {
          AsyncValue(value: final data?) => data,
          _ => <String, WebFavoritesList>{},
        },
      ),
    );

    final favlist = favorites.values.map((l) => l.list.contains(link)).toList();
    final favorited = favlist.any((e) => e);

    return MenuAnchor(
      builder: (context, controller, child) {
        return Tooltip(
          message: tr.mangaActions.favorite,
          child: Material(
            color: theme.colorScheme.surface.withAlpha(200),
            shape: borderRadius == null ? const CircleBorder() : null,
            borderRadius: borderRadius,
            child: favorites.isEmpty
                ? const SizedBox(
                    width: 40,
                    height: 40,
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
          ),
        );
      },
      menuChildren: favorites.isNotEmpty
          ? [
              for (final (idx, cat) in favorites.values.indexed)
                CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text(cat.name),
                  value: favlist.elementAt(idx),
                  onChanged: (bool? value) async {
                    if (value == true) {
                      webSourceFavoritesMutation.run(ref, (ref) async {
                        return await ref
                            .get(webSourceFavoritesProvider.notifier)
                            .add(cat.id, link);
                      });
                    } else {
                      webSourceFavoritesMutation.run(ref, (ref) async {
                        return await ref
                            .get(webSourceFavoritesProvider.notifier)
                            .remove(cat.id, link);
                      });
                    }
                  },
                ),
              MenuItemButton(
                onPressed: () =>
                    webSourceFavoritesMutation.run(ref, (ref) async {
                      return await ref
                          .get(webSourceFavoritesProvider.notifier)
                          .remove('all', link);
                    }),
                child: Text(tr.ui.clear),
              ),
            ]
          : [],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          favorited ? Icons.favorite : Icons.favorite_border,
          color: favorited ? theme.colorScheme.primary : null,
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
    final theme = Theme.of(context);
    final chapterkey = data.name;
    final mangakey = handle.getKey();

    final isRead = ref.watch(
      webReadMarkersProvider.select(
        (value) => switch (value) {
          AsyncValue(value: final db?) =>
            db.markers[mangakey]?.contains(chapterkey) ?? false,
          _ => false,
        },
      ),
    );

    final sourceValue = data.chapter.groups.entries.first.value;
    String title = data.chapter.getTitle(chapterkey);
    final groupKey = data.chapter.groups.entries.first.key;
    final groupText =
        manga.groups != null && manga.groups?.containsKey(groupKey) == true
        ? manga.groups![groupKey]!
        : groupKey;

    final lang = tr.$meta.locale.languageCode;
    //final locale = screenSizeSmall && timeagoLocaleList.contains('${lang}_short') ? '${lang}_short' : lang;

    String? timestamp;

    if (data.chapter.lastUpdated != null) {
      timestamp = timeago.format(data.chapter.lastUpdated!, locale: lang);
    } else if (data.chapter.releaseDate != null) {
      timestamp = timeago.format(data.chapter.releaseDate!, locale: lang);
    }

    final language = sourceValue is Chapter
        ? CountryFlag(flag: sourceValue.langCode, size: 12)
        : null;

    final textstyle = TextStyle(
      color: (isRead == true ? theme.disabledColor : theme.colorScheme.primary),
    );

    final markReadBtn = IconButton(
      onPressed: () async {
        bool set = !isRead;

        webReadMarkerMutation.run(ref, (ref) async {
          return await ref
              .get(webReadMarkersProvider.notifier)
              .set(mangakey, chapterkey, set);
        });
      },
      padding: const EdgeInsets.all(0.0),
      splashRadius: 15,
      iconSize: 20,
      tooltip: tr.mangaView.markAs(
        arg: isRead == true ? tr.mangaView.unread : tr.mangaView.read,
      ),
      icon: Icon(
        isRead == true ? Icons.visibility_off : Icons.visibility,
        color: (isRead == true
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
      source: sourceValue,
      title: title,
      link: manga.title,
      handle: handle,
      readKey: chapterkey,
      onLinkPressed: onLinkPressed,
    );

    PageRouteInfo route = ProxyWebSourceReaderRoute(
      proxy: handle.sourceId,
      code: handle.location,
      chapter: chapterkey,
      readerData: readerData,
    );

    if (handle.type == SourceType.source) {
      route = ExtensionReaderRoute(
        sourceId: handle.sourceId,
        mangaId: handle.location,
        chapterId: (sourceValue as Chapter).chapterId,
        readerData: readerData,
      );
    }

    final tile = Table(
      columnWidths: const <int, TableColumnWidth>{
        0: FixedColumnWidth(24),
        1: FixedColumnWidth(6),
        2: FlexColumnWidth(),
        3: FixedColumnWidth(150),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: <TableRow>[
        TableRow(
          children: <Widget>[
            markReadBtn,
            const SizedBox.shrink(),
            Text(title, style: textstyle),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [if (language != null) language],
            ),
          ],
        ),
        TableRow(
          children: <Widget>[
            const Icon(Icons.group, size: 20),
            const SizedBox.shrink(),
            Text(groupText),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(Icons.schedule, size: 20),
                if (timestamp != null) Text(' $timestamp'),
              ],
            ),
          ],
        ),
      ],
    );

    return InkWell(
      onTap: () {
        context.router.push(route);
      },
      child: _ChapterButtonCard(
        key: ValueKey('_ChapterButtonCard($chapterkey)'),
        mangaKey: mangakey,
        chapterKey: chapterkey,
        child: tile,
      ),
    );
  }
}

class _ChapterButtonCard extends ConsumerWidget {
  final String chapterKey;
  final String mangaKey;
  final Widget child;

  const _ChapterButtonCard({
    super.key,
    required this.chapterKey,
    required this.mangaKey,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSizeSmall = DeviceContext.screenWidthSmall(context);
    final theme = Theme.of(context);
    final tileColor = theme.colorScheme.primaryContainer;

    final isRead = ref.watch(
      webReadMarkersProvider.select(
        (value) => switch (value) {
          AsyncValue(value: final db?) =>
            db.markers[mangaKey]?.contains(chapterKey) ?? false,
          _ => false,
        },
      ),
    );

    return Ink(
      padding: EdgeInsets.symmetric(
        horizontal: (screenSizeSmall ? 6.0 : 10.0),
        vertical: 4.0,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        color: tileColor,
        border: Border(
          left: BorderSide(
            color: isRead == true ? tileColor : Colors.blue,
            width: 4.0,
          ),
        ),
      ),
      child: child,
    );
  }
}

class ChapterFeedItem extends HookWidget {
  const ChapterFeedItem({super.key, required this.state});

  final UpdateFeedItem state;

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive();
    final screenSizeSmall = DeviceContext.screenWidthSmall(context);

    final titleBtn = _MangaTitle(
      key: ValueKey('_MangaTitle(${state.link.handle!.getKey()})'),
      link: state.link,
    );

    final coverBtn = _CoverButton(
      key: ValueKey('_CoverButton(${state.link.handle!.getKey()})'),
      link: state.link,
    );

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: screenSizeSmall
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  titleBtn,
                  const Divider(height: 4.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      coverBtn,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 4.0,
                          children: state.manga.chapters
                              .take(3)
                              .map(
                                (e) => ChapterButtonWidget(
                                  data: e,
                                  manga: state.manga,
                                  handle: state.link.handle!,
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  coverBtn,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 4.0,
                      children: [
                        titleBtn,
                        const Divider(height: 10.0),
                        ...state.manga.chapters
                            .take(3)
                            .map(
                              (e) => ChapterButtonWidget(
                                data: e,
                                manga: state.manga,
                                handle: state.link.handle!,
                              ),
                            ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class _CoverButton extends ConsumerWidget {
  const _CoverButton({super.key, required this.link});

  final HistoryLink link;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tr = context.t;
    final api = ref.watch(proxyProvider);
    final screenSizeSmall = DeviceContext.screenWidthSmall(context);

    return TextButton(
      onPressed: () async {
        final messenger = ScaffoldMessenger.of(context);
        final result = await api.handleLink(link);

        if (!context.mounted) return;
        if (result.handle == null) {
          messenger
            ..removeCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(tr.errors.unsupportedUrl),
                backgroundColor: Colors.red,
              ),
            );
        } else {
          openWebSource(context, result.handle!);
        }
      },
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 6.0),
      ),
      child: CachedNetworkImage(
        imageUrl: link.cover!,
        cacheManager: gagakuImageCache,
        memCacheWidth: 512,
        maxWidthDiskCache: 512,
        imageBuilder: (context, imageProvider) => DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(image: imageProvider),
            borderRadius: const BorderRadius.all(Radius.circular(4.0)),
          ),
        ),
        width: screenSizeSmall ? 64.0 : 128.0,
        height: screenSizeSmall ? 91.0 : 182.0,
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            const Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        fit: BoxFit.cover,
      ),
    );
  }
}

class _MangaTitle extends ConsumerWidget {
  final HistoryLink link;

  const _MangaTitle({super.key, required this.link});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tr = context.t;
    final api = ref.watch(proxyProvider);
    final theme = Theme.of(context);

    return TextButton.icon(
      style: TextButton.styleFrom(
        alignment: Alignment.centerLeft,
        minimumSize: const Size(0.0, 24.0),
        shape: const RoundedRectangleBorder(),
        foregroundColor: theme.colorScheme.onSurface,
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        visualDensity: const VisualDensity(horizontal: -4.0, vertical: -4.0),
      ),
      onPressed: () async {
        final messenger = ScaffoldMessenger.of(context);
        final result = await api.handleLink(link);

        if (!context.mounted) return;
        if (result.handle == null) {
          messenger
            ..removeCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(tr.errors.unsupportedUrl),
                backgroundColor: Colors.red,
              ),
            );
        } else {
          openWebSource(context, result.handle!);
        }
      },
      label: Text(link.title, overflow: TextOverflow.ellipsis),
    );
  }
}
