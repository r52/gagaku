// ignore_for_file: unused_element
import 'package:extended_image/extended_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/mangadex/model.dart';
import 'package:gagaku/mangadex/reader.dart';
import 'package:gagaku/ui.dart';
import 'package:gagaku/util.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:super_sliver_list/super_sliver_list.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'types.dart';

const statsError = 'Error Retrieving Stats';

typedef MangaSelectCallback = void Function(Manga manga);
typedef MangaButtonBuilderCallback = Widget Function(Manga manga);

enum MangaListView { grid, list, detailed }

final _mangaListViewProvider = StateProvider((ref) => MangaListView.grid);

const _rowPadding = SizedBox(
  width: 6.0,
);

const _endChip = IconTextChip(
  color: Colors.blue,
  text: 'END',
);

const _groupIconB = Icon(Icons.group, size: 20.0);
const _groupIconS = Icon(Icons.group, size: 15.0);
const _circleIconB = Icon(Icons.add_circle, size: 20.0);
const _circleIconS = Icon(Icons.add_circle, size: 15.0);
const _personIconB = Icon(Icons.person, size: 20.0);
const _personIconS = Icon(Icons.person, size: 15.0);
const _checkIconB = Icon(Icons.check, color: Colors.amber, size: 20.0);
const _checkIconS = Icon(Icons.check, color: Colors.amber, size: 15.0);
const _openIconB = Icon(Icons.open_in_new, size: 20.0);
const _openIconS = Icon(Icons.open_in_new, size: 15.0);
const _scheduleIconB = Icon(Icons.schedule, size: 20.0);
const _scheduleIconS = Icon(Icons.schedule, size: 15.0);

const _iconSetB = {
  'group': _groupIconB,
  'circle': _circleIconB,
  'person': _personIconB,
  'check': _checkIconB,
  'open': _openIconB,
  'schedule': _scheduleIconB,
};

const _iconSetS = {
  'group': _groupIconS,
  'circle': _circleIconS,
  'person': _personIconS,
  'check': _checkIconS,
  'open': _openIconS,
  'schedule': _scheduleIconS,
};

class MarkReadButton extends ConsumerWidget {
  const MarkReadButton({super.key, required this.chapter, required this.manga});

  final Chapter chapter;
  final Manga manga;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loggedin = ref.watch(authControlProvider).valueOrNull ?? false;

    if (!loggedin) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);

    bool? isRead =
        ref.watch(readChaptersProvider.select((value) => switch (value) {
              AsyncValue(valueOrNull: final data?) =>
                data[manga.id]?.contains(chapter.id) == true,
              _ => null,
            }));

    return switch (isRead) {
      null => const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(),
        ),
      true || false => IconButton(
          onPressed: () async {
            bool set = !isRead;
            ref.read(readChaptersProvider.notifier).set(manga,
                read: set ? [chapter] : null, unread: !set ? [chapter] : null);
          },
          padding: const EdgeInsets.only(right: 10.0),
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
        ),
    };
  }
}

class ChapterFeedWidget extends HookConsumerWidget {
  const ChapterFeedWidget({
    super.key,
    required this.provider,
    this.title,
    this.emptyText,
    this.onAtEdge,
    required this.onRefresh,
    this.controller,
    this.restorationId,
  });

  final AutoDisposeFutureProvider<List<ChapterFeedItemData>> provider;
  final String? title;
  final String? emptyText;
  final VoidCallback? onAtEdge;
  final RefreshCallback onRefresh;
  final ScrollController? controller;
  final String? restorationId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = controller ?? useScrollController();
    final resultProvider = ref.watch(provider);
    final isLoading = resultProvider.isLoading && !resultProvider.isRefreshing;

    useEffect(() {
      void controllerAtEdge() {
        if (onAtEdge != null &&
            scrollController.position.atEdge &&
            scrollController.position.pixels ==
                scrollController.position.maxScrollExtent) {
          onAtEdge!();
        }
      }

      scrollController.addListener(controllerAtEdge);
      return () => scrollController.removeListener(controllerAtEdge);
    }, [scrollController]);

    return Center(
      child: switch (resultProvider) {
        AsyncValue(:final error?, :final stackTrace?) => () {
            final messenger = ScaffoldMessenger.of(context);
            Styles.showErrorSnackBar(messenger, '$error');
            logger.e("${provider.toString()} failed",
                error: error, stackTrace: stackTrace);

            return RefreshIndicator(
              onRefresh: onRefresh,
              child: Styles.errorList(error, stackTrace),
            );
          }(),
        AsyncValue(valueOrNull: final results?) => () {
            return ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
                PointerDeviceKind.touch,
                PointerDeviceKind.mouse,
                PointerDeviceKind.trackpad,
              }),
              child: RefreshIndicator(
                onRefresh: onRefresh,
                child: results.isEmpty
                    ? Text(emptyText ?? 'No results!')
                    : Column(
                        children: [
                          if (title != null)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 10.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  title!,
                                  style: const TextStyle(fontSize: 24),
                                ),
                              ),
                            ),
                          Expanded(
                            child: SuperListView.builder(
                              controller: scrollController,
                              physics: const AlwaysScrollableScrollPhysics(),
                              restorationId: restorationId,
                              padding: const EdgeInsets.all(6),
                              itemCount: results.length,
                              findChildIndexCallback: (key) {
                                final valueKey = key as ValueKey<int>;
                                final val = results
                                    .indexWhere((i) => i.id == valueKey.value);
                                return val >= 0 ? val : null;
                              },
                              itemBuilder: (context, index) {
                                final elem = results.elementAt(index);
                                return ChapterFeedItem(
                                    key: ValueKey(elem.id), state: elem);
                              },
                            ),
                          ),
                          if (isLoading) Styles.listSpinner,
                        ],
                      ),
              ),
            );
          }(),
        _ => const Stack(
            children: Styles.loadingOverlay,
          ),
      },
    );
  }
}

class ChapterFeedItem extends StatelessWidget {
  const ChapterFeedItem({super.key, required this.state});

  final ChapterFeedItemData state;

  @override
  Widget build(BuildContext context) {
    final screenSizeSmall = DeviceContext.screenWidthSmall(context);
    final theme = Theme.of(context);

    final chapterBtns = state.chapters.map((e) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        child: ChapterButtonWidget(
          key: ValueKey(e.id),
          chapter: e,
          manga: state.manga,
          link: Text(
            state.manga.attributes!.title.get('en'),
            style: const TextStyle(fontSize: 18),
          ),
          onLinkPressed: () {
            context.push('/title/${state.manga.id}', extra: state.manga);
          },
        ),
      );
    }).toList();

    final titleBtn = TextButton.icon(
      style: TextButton.styleFrom(
        minimumSize: const Size(0.0, 24.0),
        shape: const RoundedRectangleBorder(),
        foregroundColor: theme.colorScheme.onSurface,
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        visualDensity: const VisualDensity(horizontal: -4.0, vertical: -4.0),
      ),
      onPressed: () async {
        context.push('/title/${state.manga.id}', extra: state.manga);
      },
      icon: CountryFlag(
        flag: state.manga.attributes!.originalLanguage.flag,
      ),
      label: Text(
        state.manga.attributes!.title.get('en'),
        overflow: TextOverflow.ellipsis,
      ),
    );

    final coverBtn = TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 6.0),
        shape: const RoundedRectangleBorder(),
      ),
      onPressed: () async {
        context.push('/title/${state.manga.id}', extra: state.manga);
      },
      child: ExtendedImage.network(
        state.coverArt,
        loadStateChanged: extendedImageLoadStateHandler,
        shape: BoxShape.rectangle,
        borderRadius: const BorderRadius.all(Radius.circular(4.0)),
        width: screenSizeSmall ? 64.0 : 128.0,
      ),
    );

    return Card(
      margin: const EdgeInsets.all(6),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: screenSizeSmall
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  titleBtn,
                  const Divider(
                    height: 4.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      coverBtn,
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: chapterBtns,
                      )),
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
                      children: [
                        titleBtn,
                        const Divider(
                          height: 10.0,
                        ),
                        ...chapterBtns,
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }
}

class ChapterButtonWidget extends StatelessWidget {
  const ChapterButtonWidget({
    super.key,
    required this.chapter,
    required this.manga,
    this.link,
    this.onLinkPressed,
  });

  final Chapter chapter;
  final Manga manga;
  final Widget? link;
  final VoidCallback? onLinkPressed;

  @override
  Widget build(BuildContext context) {
    final bool screenSizeSmall = DeviceContext.screenWidthSmall(context);
    final iconSet = screenSizeSmall ? _iconSetS : _iconSetB;

    final isEndChapter = manga.attributes!.lastChapter != null &&
        manga.attributes!.lastChapter?.isNotEmpty == true &&
        chapter.attributes.chapter == manga.attributes!.lastChapter;
    final isOfficialPub = chapter.attributes.externalUrl != null;

    String title = chapter.title;

    final pubtime = timeago.format(chapter.attributes.publishAt);

    final groupChips = <Widget>[];

    for (final g in chapter.groups) {
      groupChips.add(IconTextChip(
        icon: isOfficialPub ? iconSet['circle'] : iconSet['group'],
        text: g.attributes.name.crop(),
        onPressed: () {
          context.push('/group/${g.id}', extra: g);
        },
      ));
      groupChips.add(_rowPadding);
    }

    if (groupChips.isEmpty) {
      groupChips.add(IconTextChip(
        icon: iconSet['group'],
        text: 'No Group',
      ));
      groupChips.add(_rowPadding);
    }

    Widget userChip;

    if (isOfficialPub) {
      userChip = IconTextChip(
        icon: iconSet['check'],
        text: 'Official Publisher',
      );
    } else {
      userChip = IconTextChip(
        icon: iconSet['person'],
        text: chapter.uploadUser.crop(),
      );
    }

    final vPadding =
        EdgeInsets.symmetric(vertical: (screenSizeSmall ? 2.0 : 4.0));

    final tile = Padding(
      padding: EdgeInsets.symmetric(horizontal: (screenSizeSmall ? 6.0 : 10.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              children: [
                MarkReadButton(
                  key: ValueKey(chapter.id),
                  chapter: chapter,
                  manga: manga,
                ),
                CountryFlag(
                  flag: chapter.attributes.translatedLanguage.flag,
                  size: screenSizeSmall ? 15 : 18,
                ),
                _rowPadding,
                if (isOfficialPub) ...[iconSet['open']!, _rowPadding],
                Expanded(
                  child: Consumer(
                    builder: (context, ref, child) {
                      final theme = Theme.of(context);
                      final loggedin =
                          ref.watch(authControlProvider).valueOrNull ?? false;

                      TextStyle textstyle;

                      if (!loggedin) {
                        textstyle = TextStyle(
                          color: theme.colorScheme.primary,
                        );
                      } else {
                        bool? isRead = ref.watch(readChaptersProvider
                            .select((value) => switch (value) {
                                  AsyncValue(valueOrNull: final data?) =>
                                    data[manga.id]?.contains(chapter.id) ==
                                        true,
                                  _ => null,
                                }));

                        textstyle = TextStyle(
                            color: (isRead == true
                                ? theme.highlightColor
                                : theme.colorScheme.primary));
                      }

                      return Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        style: textstyle,
                      );
                    },
                  ),
                ),
                _rowPadding,
                if (isEndChapter) _endChip,
                if (!screenSizeSmall) const Spacer(),
                if (!screenSizeSmall)
                  Text.rich(
                    overflow: TextOverflow.ellipsis,
                    TextSpan(
                      children: [
                        WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: iconSet['schedule']!),
                        TextSpan(text: ' $pubtime'),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: vPadding,
            child: screenSizeSmall
                ? Wrap(
                    runSpacing: 2.0,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    children: groupChips,
                  )
                : Row(
                    children: [
                      ...groupChips,
                      const Spacer(),
                      userChip,
                    ],
                  ),
          ),
          if (screenSizeSmall)
            Padding(
              padding: vPadding,
              child: userChip,
            ),
          if (screenSizeSmall)
            Padding(
              padding: vPadding,
              child: Align(
                alignment: Alignment.centerRight,
                child: Text.rich(
                  overflow: TextOverflow.ellipsis,
                  TextSpan(
                    children: [
                      WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: iconSet['schedule']!),
                      TextSpan(text: ' $pubtime'),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );

    return InkWell(
      onTap: () {
        context.push(
          '/chapter/${chapter.id}',
          extra: ReaderData(
            title: title,
            chapter: chapter,
            manga: manga,
            link: link,
            onLinkPressed: onLinkPressed,
          ),
        );
      },
      child: Consumer(
        child: tile,
        builder: (context, ref, child) {
          final theme = Theme.of(context);
          final tileColor = theme.colorScheme.primaryContainer;
          final loggedin = ref.watch(authControlProvider).valueOrNull ?? false;

          Border border;

          if (!loggedin) {
            border = Border(
              left: BorderSide(color: tileColor, width: 4.0),
            );
          } else {
            bool? isRead = ref
                .watch(readChaptersProvider.select((value) => switch (value) {
                      AsyncValue(valueOrNull: final data?) =>
                        data[manga.id]?.contains(chapter.id) == true,
                      _ => null,
                    }));

            border = Border(
              left: BorderSide(
                  color: isRead == true ? tileColor : Colors.blue, width: 4.0),
            );
          }

          return Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              color: tileColor,
              border: border,
            ),
            child: child,
          );
        },
      ),
    );
  }
}

class MangaListWidget extends HookConsumerWidget {
  const MangaListWidget({
    super.key,
    this.title,
    required this.children,
    this.leading = const <Widget>[],
    this.physics,
    this.onAtEdge,
    this.controller,
    this.noController = false,
    this.showToggle = true,
  });

  final Widget? title;
  final List<Widget> children;
  final List<Widget> leading;
  final ScrollPhysics? physics;
  final VoidCallback? onAtEdge;
  final ScrollController? controller;
  final bool noController;
  final bool showToggle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController =
        controller ?? (noController ? null : useScrollController());
    final view =
        showToggle ? ref.watch(_mangaListViewProvider) : MangaListView.grid;

    useEffect(() {
      void controllerAtEdge() {
        if (scrollController != null &&
            onAtEdge != null &&
            scrollController.position.atEdge &&
            scrollController.position.pixels ==
                scrollController.position.maxScrollExtent) {
          onAtEdge!();
        }
      }

      scrollController?.addListener(controllerAtEdge);
      return () => scrollController?.removeListener(controllerAtEdge);
    }, [scrollController]);

    return CustomScrollView(
      controller: scrollController,
      scrollBehavior: MouseTouchScrollBehavior(),
      physics: physics,
      slivers: [
        ...leading,
        SliverToBoxAdapter(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
            child: Row(
              children: [
                if (title != null) title!,
                const Spacer(),
                if (showToggle)
                  ToggleButtons(
                    isSelected: List<bool>.generate(MangaListView.values.length,
                        (index) => view.index == index),
                    onPressed: (index) {
                      ref.read(_mangaListViewProvider.notifier).state =
                          MangaListView.values.elementAt(index);
                    },
                    children: const [
                      Icon(
                        Icons.grid_view,
                      ),
                      Icon(
                        Icons.table_rows,
                      ),
                      Icon(
                        Icons.view_list,
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
        ...children,
      ],
    );
  }
}

class MangaListViewSliver extends ConsumerWidget {
  const MangaListViewSliver({
    super.key,
    required this.items,
    this.selectMode = false,
    this.selectButton,
    this.onSelected,
    this.headers,
  });

  final List<Manga> items;
  final bool selectMode;
  final MangaButtonBuilderCallback? selectButton;
  final MangaSelectCallback? onSelected;
  final Map<String, String>? headers;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final view =
        selectMode ? MangaListView.grid : ref.watch(_mangaListViewProvider);
    final onMobilePortrait =
        DeviceContext.isPortraitMode(context) && DeviceContext.isMobile();

    switch (view) {
      case MangaListView.list:
        return SliverList.builder(
          findChildIndexCallback: (key) {
            final valueKey = key as ValueKey<String>;
            final val = items.indexWhere((i) => i.id == valueKey.value);
            return val >= 0 ? val : null;
          },
          itemBuilder: (BuildContext context, int index) {
            final manga = items.elementAt(index);
            return _ListMangaItem(
              key: ValueKey(manga.id),
              manga: manga,
              header: headers?[manga.id],
            );
          },
          itemCount: items.length,
        );
      case MangaListView.detailed:
        return SliverGrid.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 1024,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: onMobilePortrait ? 1.0 : 3.0,
          ),
          findChildIndexCallback: (key) {
            final valueKey = key as ValueKey<String>;
            final val = items.indexWhere((i) => i.id == valueKey.value);
            return val >= 0 ? val : null;
          },
          itemBuilder: (context, index) {
            final manga = items.elementAt(index);
            return _GridMangaDetailedItem(
              key: ValueKey(manga.id),
              manga: manga,
              header: headers?[manga.id],
            );
          },
          itemCount: items.length,
        );

      case MangaListView.grid:
      default:
        return SliverGrid.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 256,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 0.7,
          ),
          findChildIndexCallback: (key) {
            final valueKey = key as ValueKey<String>;
            final val = items.indexWhere((i) => i.id == valueKey.value);
            return val >= 0 ? val : null;
          },
          itemBuilder: (context, index) {
            final manga = items.elementAt(index);
            return _GridMangaItem(
              key: ValueKey(manga.id),
              manga: manga,
              selectMode: selectMode,
              selectButton: selectButton,
              onSelected: onSelected,
              header: headers?[manga.id],
            );
          },
          itemCount: items.length,
        );
    }
  }
}

class _GridMangaItem extends HookWidget {
  const _GridMangaItem({
    super.key,
    required this.manga,
    this.selectMode = false,
    this.selectButton,
    this.onSelected,
    this.header,
  });

  final Manga manga;
  final bool selectMode;
  final MangaButtonBuilderCallback? selectButton;
  final MangaSelectCallback? onSelected;
  final String? header;

  @override
  Widget build(BuildContext context) {
    final aniController =
        useAnimationController(duration: const Duration(milliseconds: 100));
    final gradient =
        useAnimation(aniController.drive(Styles.coverArtGradientTween));

    final Widget image = Material(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      clipBehavior: Clip.antiAlias,
      child: ShaderMask(
        shaderCallback: (rect) {
          return LinearGradient(
            begin: gradient,
            end: Alignment.bottomCenter,
            colors: const [Colors.black, Colors.transparent],
          ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
        },
        blendMode: BlendMode.dstIn,
        child: ExtendedImage.network(
          manga.getFirstCoverUrl(quality: CoverArtQuality.medium),
          cache: true,
          loadStateChanged: extendedImageLoadStateHandler,
          width: 256.0,
        ),
      ),
    );

    return InkWell(
      onTap: () {
        context.push('/title/${manga.id}', extra: manga);
      },
      onHover: (hovering) {
        if (hovering) {
          aniController.forward();
        } else {
          aniController.reverse();
        }
      },
      child: GridTile(
        header: selectMode
            ? Align(
                alignment: Alignment.topRight,
                child: FloatingActionButton(
                  heroTag: manga.id,
                  mini: true,
                  shape: const CircleBorder(),
                  onPressed: () => onSelected!(manga),
                  child: selectButton!(manga),
                ),
              )
            : (header != null
                ? SizedBox(
                    height: 40,
                    child: Material(
                      color: Colors.transparent,
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(4)),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: GridTileBar(
                        backgroundColor: Colors.black87,
                        title: Text(
                          header!,
                          softWrap: true,
                          style: const TextStyle(
                            overflow: TextOverflow.fade,
                          ),
                        ),
                      ),
                    ),
                  )
                : null),
        footer: SizedBox(
          height: 80,
          child: Material(
            color: Colors.transparent,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(4)),
            ),
            clipBehavior: Clip.antiAlias,
            child: GridTileBar(
              leading: CountryFlag(
                flag: manga.attributes!.originalLanguage.flag,
                size: 18,
              ),
              title: Text(
                manga.attributes!.title.get('en'),
                softWrap: true,
                style: const TextStyle(
                  overflow: TextOverflow.fade,
                ),
              ),
            ),
          ),
        ),
        child: image,
      ),
    );
  }
}

class _GridMangaDetailedItem extends ConsumerWidget {
  const _GridMangaDetailedItem({
    super.key,
    required this.manga,
    this.header,
  });

  final Manga manga;
  final String? header;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool screenSizeSmall = DeviceContext.screenWidthSmall(context);
    final theme = Theme.of(context);
    final statsProvider = ref.watch(statisticsProvider);

    return Card(
      margin: const EdgeInsets.all(6),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton.icon(
              style: TextButton.styleFrom(
                  foregroundColor: theme.colorScheme.onSurface,
                  textStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
              onPressed: () async {
                context.push('/title/${manga.id}', extra: manga);
              },
              icon: CountryFlag(
                flag: manga.attributes!.originalLanguage.flag,
                size: 18,
              ),
              label: Text(
                manga.attributes!.title.get('en'),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () async {
                      context.push('/title/${manga.id}', extra: manga);
                    },
                    child: ExtendedImage.network(
                        manga.getFirstCoverUrl(quality: CoverArtQuality.medium),
                        cache: true,
                        loadStateChanged: extendedImageLoadStateHandler,
                        width: screenSizeSmall ? 80.0 : 128.0),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (header != null) ...[
                          IconTextChip(text: header!),
                          const SizedBox(
                            height: 4,
                          ),
                        ],
                        Wrap(
                          runSpacing: 4.0,
                          children: [
                            ...switch (statsProvider) {
                              // ignore: unused_local_variable
                              AsyncValue(:final error?, :final stackTrace?) => [
                                  const IconTextChip(
                                    text: statsError,
                                  )
                                ],
                              AsyncValue(valueOrNull: final stats?) => () {
                                  if (stats.containsKey(manga.id)) {
                                    return [
                                      IconTextChip(
                                        icon: const Icon(
                                          Icons.star_border,
                                          color: Colors.amber,
                                          size: 18,
                                          shadows: [
                                            Shadow(
                                              offset: Offset(1.0, 1.0),
                                            ),
                                          ],
                                        ),
                                        text: stats[manga.id]
                                                ?.rating
                                                .bayesian
                                                .toStringAsFixed(2) ??
                                            statsError,
                                        style: const TextStyle(
                                          color: Colors.amber,
                                          shadows: [
                                            Shadow(
                                              offset: Offset(1.0, 1.0),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      IconTextChip(
                                        icon: const Icon(
                                          Icons.bookmark_outline,
                                          size: 18,
                                        ),
                                        text: stats[manga.id]
                                                ?.follows
                                                .toString() ??
                                            statsError,
                                      ),
                                    ];
                                  }

                                  return [
                                    const IconTextChip(
                                      text: statsError,
                                    )
                                  ];
                                }(),
                              _ => [
                                  const IconTextChip(
                                    text: 'Loading...',
                                  )
                                ],
                            },
                            const SizedBox(width: 10),
                            MangaStatusChip(
                              status: manga.attributes!.status,
                              year: manga.attributes!.year,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 4.0,
                        ),
                        Wrap(
                          spacing: 4.0,
                          runSpacing: 4.0,
                          children: [
                            if (manga.attributes!.contentRating !=
                                ContentRating.safe)
                              ContentRatingChip(
                                  rating: manga.attributes!.contentRating),
                            ...manga.attributes!.tags
                                .where((tag) =>
                                    tag.attributes.group == TagGroup.content)
                                .map((e) => ContentChip(
                                    content: e.attributes.name.get('en'))),
                            ...manga.attributes!.tags
                                .where((tag) =>
                                    tag.attributes.group != TagGroup.content)
                                .map(
                                  (e) => IconTextChip(
                                      text: e.attributes.name.get('en')),
                                ),
                          ],
                        ),
                        if (manga.attributes!.description.isNotEmpty)
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                manga.attributes!.description.get('en'),
                                overflow: TextOverflow.clip,
                              ),
                            ),
                          ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ListMangaItem extends ConsumerWidget {
  const _ListMangaItem({
    super.key,
    required this.manga,
    this.header,
  });

  final Manga manga;
  final String? header;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final statsProvider = ref.watch(statisticsProvider);

    return Card(
      margin: const EdgeInsets.all(6),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
              onPressed: () async {
                context.push('/title/${manga.id}', extra: manga);
              },
              child: ExtendedImage.network(
                manga.getFirstCoverUrl(quality: CoverArtQuality.medium),
                cache: true,
                loadStateChanged: extendedImageLoadStateHandler,
                width: 80.0,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton.icon(
                    style: TextButton.styleFrom(
                      foregroundColor: theme.colorScheme.onSurface,
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () async {
                      context.push('/title/${manga.id}', extra: manga);
                    },
                    icon: CountryFlag(
                      flag: manga.attributes!.originalLanguage.flag,
                      size: 18,
                    ),
                    label: Text(manga.attributes!.title.get('en')),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (header != null) ...[
                    IconTextChip(text: header!),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                  Wrap(
                    spacing: 4.0,
                    runSpacing: 4.0,
                    children: [
                      if (manga.attributes!.contentRating != ContentRating.safe)
                        ContentRatingChip(
                            rating: manga.attributes!.contentRating),
                      ...manga.attributes!.tags
                          .where(
                              (tag) => tag.attributes.group == TagGroup.content)
                          .map((e) => ContentChip(
                              content: e.attributes.name.get('en'))),
                      if (manga.attributes!.tags.isNotEmpty)
                        ...manga.attributes!.tags
                            .where((tag) =>
                                (tag.attributes.group == TagGroup.genre ||
                                    tag.attributes.group == TagGroup.theme))
                            .map(
                              (e) => IconTextChip(
                                  text: e.attributes.name.get('en')),
                            ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Wrap(
                    runSpacing: 4.0,
                    children: [
                      ...switch (statsProvider) {
                        // ignore: unused_local_variable
                        AsyncValue(:final error?, :final stackTrace?) => [
                            const IconTextChip(
                              text: statsError,
                            )
                          ],
                        AsyncValue(valueOrNull: final stats?) => () {
                            if (stats.containsKey(manga.id)) {
                              return [
                                IconTextChip(
                                  icon: const Icon(
                                    Icons.star_border,
                                    color: Colors.amber,
                                    size: 18,
                                    shadows: [
                                      Shadow(
                                        offset: Offset(1.0, 1.0),
                                      ),
                                    ],
                                  ),
                                  text: stats[manga.id]
                                          ?.rating
                                          .bayesian
                                          .toStringAsFixed(2) ??
                                      statsError,
                                  style: const TextStyle(
                                    color: Colors.amber,
                                    shadows: [
                                      Shadow(
                                        offset: Offset(1.0, 1.0),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                IconTextChip(
                                  icon: const Icon(
                                    Icons.bookmark_outline,
                                    size: 18,
                                  ),
                                  text: stats[manga.id]?.follows.toString() ??
                                      statsError,
                                ),
                              ];
                            }

                            return [
                              const IconTextChip(
                                text: statsError,
                              )
                            ];
                          }(),
                        _ => [
                            const IconTextChip(
                              text: 'Loading...',
                            )
                          ],
                      },
                      const SizedBox(width: 10),
                      MangaStatusChip(
                        status: manga.attributes!.status,
                        year: manga.attributes!.year,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MangaStatusChip extends StatelessWidget {
  const MangaStatusChip({
    super.key,
    required this.status,
    this.year,
    this.short = true,
  });

  final MangaStatus status;
  final int? year;
  final bool short;

  @override
  Widget build(BuildContext context) {
    var iconColor = Colors.green;

    switch (status) {
      case MangaStatus.ongoing:
        break;
      case MangaStatus.completed:
        iconColor = Colors.blue;
        break;
      case MangaStatus.hiatus:
        iconColor = Colors.orange;
        break;
      case MangaStatus.cancelled:
        iconColor = Colors.red;
        break;
    }

    String label = status.label;

    if (year != null && !short) {
      label = "$year, $label";
    }

    return IconTextChip(
      icon: Icon(
        Icons.circle,
        color: iconColor,
        size: 10,
      ),
      text: label,
    );
  }
}

class ContentRatingChip extends StatelessWidget {
  const ContentRatingChip({super.key, required this.rating});

  final ContentRating rating;

  @override
  Widget build(BuildContext context) {
    var iconColor = Colors.orange;

    switch (rating) {
      case ContentRating.suggestive:
        break;
      case ContentRating.safe:
        iconColor = Colors.green;
        break;
      case ContentRating.erotica:
      case ContentRating.pornographic:
        iconColor = Colors.red;
        break;
    }

    return IconTextChip(
      color: iconColor,
      text: rating.label,
    );
  }
}

class ContentChip extends StatelessWidget {
  const ContentChip({super.key, required this.content});

  final String content;

  @override
  Widget build(BuildContext context) {
    var iconColor = Colors.orange;

    switch (content) {
      case 'Gore':
      case 'Sexual Violence':
        iconColor = Colors.red;
        break;
    }

    return IconTextChip(
      color: iconColor,
      text: content,
    );
  }
}

Future<bool?> showDeleteListDialog(
        BuildContext context, String listName) async =>
    await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        final nav = Navigator.of(context);
        return AlertDialog(
          title: const Text('Delete List'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  'Are you sure you want to permanently delete \'$listName\'?'),
              const Text('NOTE: THIS ACTION IS IRREVERSIBLE'),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('No'),
              onPressed: () {
                nav.pop(null);
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
