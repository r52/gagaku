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
import 'package:gagaku/web/model/config.dart';
import 'package:gagaku/web/model/model.dart';
import 'package:gagaku/web/model/types.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:timeago/timeago.dart' as timeago;

part 'widgets.g.dart';

enum WebMangaListView { grid, list }

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
    final view =
        showToggle ? ref.watch(_mangaListViewProvider) : WebMangaListView.grid;

    return Stack(
      children: [
        CustomScrollView(
          controller: scrollController,
          scrollBehavior: const MouseTouchScrollBehavior(),
          physics: physics,
          cacheExtent: MediaQuery.sizeOf(context).height,
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
                        onSelectionChanged: (
                          Set<WebMangaListView> newSelection,
                        ) {
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
    final valueKey = key as ValueKey<int>;
    final val = items!.indexWhere((i) => i.hashCode == valueKey.value);
    return val >= 0 ? val : null;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final api = ref.watch(proxyProvider);
    WebMangaListView view =
        items != null
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
                onReorder:
                    (int oldIndex, int newIndex) => ref.read(
                      webSourceFavoritesProvider.updateList,
                    )(favoritesKey!, oldIndex, newIndex),
                itemCount: items!.length,
                // findChildIndexCallback: _findChildIndexCb,
                itemBuilder: (context, index) {
                  final item = items!.elementAt(index);
                  return ReorderableDelayedDragStartListener(
                    key: ValueKey(item.hashCode),
                    index: index,
                    child: ListTile(
                      tileColor:
                          index.isOdd
                              ? theme.colorScheme.surfaceContainer
                              : theme.colorScheme.surfaceContainerHighest,
                      leading: FavoritesButton(link: item),
                      title: Text(item.title),
                      textColor: Colors.blue,
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
                    ),
                  );
                },
              )
              : SliverList.separated(
                itemCount: items!.length,
                separatorBuilder: (_, __) => const SizedBox(height: 4.0),
                findChildIndexCallback: _findChildIndexCb,
                itemBuilder: (context, index) {
                  final tr = context.t;
                  final item = items!.elementAt(index);
                  return ListTile(
                    key: ValueKey(item.hashCode),
                    tileColor:
                        index.isOdd
                            ? theme.colorScheme.surfaceContainer
                            : theme.colorScheme.surfaceContainerHighest,
                    leading: FavoritesButton(link: item),
                    trailing: IconButton(
                      tooltip: tr.mangaActions.removeHistory,
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        ref.read(webSourceHistoryProvider.remove)(item);
                      },
                    ),
                    title: Text(item.title),
                    textColor: Colors.blue,
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
                key: ValueKey(item.hashCode),
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
              separatorBuilder: (_, __) => const SizedBox(height: 4.0),
              builderDelegate: PagedChildBuilderDelegate<HistoryLink>(
                animateTransitions: true,
                itemBuilder: (context, item, index) {
                  final tr = context.t;
                  return ListTile(
                    key: ValueKey(item.hashCode),
                    tileColor:
                        index.isOdd
                            ? theme.colorScheme.surfaceContainer
                            : theme.colorScheme.surfaceContainerHighest,
                    leading: FavoritesButton(link: item),
                    trailing:
                        showRemoveButton
                            ? IconButton(
                              tooltip: tr.mangaActions.removeHistory,
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () async {
                                ref.read(webSourceHistoryProvider.remove)(item);
                              },
                            )
                            : null,
                    title: Text(item.title),
                    textColor: Colors.blue,
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
                    key: ValueKey(item.hashCode),
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
    final tr = context.t;
    useAutomaticKeepAlive();
    final api = ref.watch(proxyProvider);
    final aniController = useAnimationController(
      duration: const Duration(milliseconds: 100),
    );
    final gradient = useAnimation(
      aniController.drive(Styles.coverArtGradientTween),
    );
    final theme = Theme.of(context);

    final image = GridAlbumImage(
      gradient: gradient,
      child:
          link.cover != null
              ? CachedNetworkImage(
                imageUrl: link.cover!,
                cacheManager: gagakuImageCache,
                width: 256.0,
                progressIndicatorBuilder:
                    (context, url, downloadProgress) =>
                        const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.cover,
              )
              : const Icon(Icons.menu_book, size: 128.0),
    );

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
            child: image,
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
                  ref.read(webSourceHistoryProvider.remove)(link);
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

    final categories = ref.watch(
      webConfigProvider.select((cfg) => cfg.categories),
    );

    final favorites = ref.watch(
      webSourceFavoritesProvider.select(
        (value) => switch (value) {
          AsyncValue(value: final data?) => data,
          _ => null,
        },
      ),
    );

    final favorited = ref.watch(
      webSourceFavoritesProvider.select(
        (value) => switch (value) {
          AsyncValue(value: final data?) => data.values.any(
            (l) => l.contains(link),
          ),
          _ => null,
        },
      ),
    );

    if (favorited == null) {
      return const CircularProgressIndicator();
    }

    return MenuAnchor(
      builder: (context, controller, child) {
        return Tooltip(
          message: tr.mangaActions.favorite,
          child: Material(
            color: theme.colorScheme.surfaceContainerHighest,
            shape: borderRadius == null ? const CircleBorder() : null,
            borderRadius: borderRadius,
            child:
                favorites == null
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
          ),
        );
      },
      menuChildren:
          favorites != null
              ? [
                ...List.generate(
                  categories.length,
                  (index) => Builder(
                    builder: (context) {
                      final cat = categories.elementAt(index);
                      return CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(cat.name),
                        value: favorites[cat.id]?.contains(link) ?? false,
                        onChanged: (bool? value) async {
                          if (value == true) {
                            await ref.read(webSourceFavoritesProvider.add)(
                              cat.id,
                              link,
                            );
                          } else {
                            await ref.read(webSourceFavoritesProvider.remove)(
                              cat.id,
                              link,
                            );
                          }
                        },
                      );
                    },
                  ),
                ),
                MenuItemButton(
                  onPressed:
                      () => ref.read(webSourceFavoritesProvider.remove)(
                        'all',
                        link,
                      ),
                  child: Text(tr.ui.clear),
                ),
              ]
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
    final chapterkey = data.name;
    final mangakey = handle.getKey();

    final isRead = ref.watch(
      webReadMarkersProvider.select(
        (value) => switch (value) {
          AsyncValue(value: final map?) =>
            map[mangakey]?.contains(chapterkey) ?? false,
          _ => false,
        },
      ),
    );

    String title = data.chapter.getTitle(chapterkey);
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

        ref.read(webReadMarkersProvider.set)(mangakey, chapterkey, set);
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
