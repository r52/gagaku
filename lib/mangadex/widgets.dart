// ignore_for_file: unused_element
import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/config.dart';
import 'package:gagaku/mangadex/model.dart';
import 'package:gagaku/mangadex/reader.dart';
import 'package:gagaku/mangadex/search.dart';
import 'package:gagaku/mangadex/settings.dart';
import 'package:gagaku/model.dart';
import 'package:gagaku/util/default_scroll_controller.dart';
import 'package:gagaku/util/ui.dart';
import 'package:gagaku/util/util.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:super_sliver_list/super_sliver_list.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';

import 'types.dart';

part 'widgets.g.dart';

const statsError = 'Error Retrieving Stats';

typedef MangaSelectCallback = void Function(Manga manga);
typedef MangaButtonBuilderCallback = Widget Function(Manga manga);

enum MangaListView { grid, list, detailed }

@Riverpod(keepAlive: true)
class _MangaListView extends _$MangaListView {
  @override
  MangaListView build() => MangaListView.grid;

  @override
  set state(MangaListView newState) => super.state = newState;
  MangaListView update(MangaListView Function(MangaListView state) cb) => state = cb(state);
}

const _endChip = IconTextChip(
  key: ValueKey('END'),
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
  _IconSet.group: _groupIconB,
  _IconSet.circle: _circleIconB,
  _IconSet.person: _personIconB,
  _IconSet.check: _checkIconB,
  _IconSet.open: _openIconB,
  _IconSet.schedule: _scheduleIconB,
};

const _iconSetS = {
  _IconSet.group: _groupIconS,
  _IconSet.circle: _circleIconS,
  _IconSet.person: _personIconS,
  _IconSet.check: _checkIconS,
  _IconSet.open: _openIconS,
  _IconSet.schedule: _scheduleIconS,
};

enum _IconSet { group, circle, person, check, open, schedule }

class MangaDexSliverAppBar extends StatelessWidget {
  const MangaDexSliverAppBar({
    super.key,
    this.controller,
    this.title,
  });

  final ScrollController? controller;
  final String? title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final flex = GestureDetector(
      onTap: () {
        final c = controller ?? DefaultScrollController.maybeOf(context);
        c?.animateTo(0.0, duration: const Duration(milliseconds: 1000), curve: Curves.easeOutCirc);
      },
      child: TitleFlexBar(title: title ?? 'MangaDex'),
    );

    final actions = <Widget>[
      OverflowBar(
        spacing: 8.0,
        children: [
          Tooltip(
            message: 'search.arg'.tr(context: context, args: ['MangaDex']),
            child: OpenContainer(
              closedColor: theme.colorScheme.primaryContainer,
              closedShape: const CircleBorder(),
              closedElevation: 0.0,
              closedBuilder: (context, openContainer) {
                return IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    openContainer();
                  },
                );
              },
              openBuilder: (context, closedContainer) {
                return const MangaDexSearchWidget();
              },
            ),
          ),
          Tooltip(
            message: 'arg_settings'.tr(context: context, args: ['MangaDex']),
            child: OpenContainer<bool>(
              closedColor: theme.colorScheme.primaryContainer,
              closedShape: const CircleBorder(),
              closedElevation: 0.0,
              closedBuilder: (context, openContainer) {
                return IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () {
                    openContainer();
                  },
                );
              },
              openBuilder: (context, closedContainer) {
                return const MangaDexSettingsWidget();
              },
            ),
          ),
          Consumer(
            builder: (context, ref, child) {
              final auth = ref.watch(authControlProvider);

              switch (auth) {
                case AsyncValue(value: final loggedin?):
                  // XXX: This changes when OAuth is released
                  return IconButton(
                    color: theme.colorScheme.primary,
                    tooltip: loggedin ? 'auth.logout'.tr(context: context) : 'auth.login'.tr(context: context),
                    icon: loggedin ? const Icon(Icons.logout) : const Icon(Icons.login),
                    onPressed: loggedin
                        ? () => ref.read(authControlProvider.notifier).logout()
                        : () => context.push(GagakuRoute.login),
                  );
                // ignore: unused_local_variable
                case AsyncValue(:final error?, :final stackTrace?):
                  return const Icon(Icons.error);
                case _:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
              }
            },
          ),
        ],
      )
    ];

    return SliverAppBar(
      floating: true,
      flexibleSpace: flex,
      actions: actions,
    );
  }
}

class MarkReadButton extends ConsumerWidget {
  const MarkReadButton({super.key, required this.chapter, required this.manga});

  final Chapter chapter;
  final Manga manga;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loggedin = ref.watch(authControlProvider).value ?? false;

    if (!loggedin) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);

    bool? isRead = ref.watch(readChaptersProvider.select(
      (value) => switch (value) {
        AsyncValue(value: final data?) => data[manga.id]?.contains(chapter.id) == true,
        _ => null,
      },
    ));

    return switch (isRead) {
      null => const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(),
        ),
      true || false => IconButton(
          onPressed: () async {
            bool set = !isRead;
            ref
                .read(readChaptersProvider.notifier)
                .set(manga, read: set ? [chapter] : null, unread: !set ? [chapter] : null);
          },
          padding: EdgeInsets.zero,
          splashRadius: 15,
          iconSize: 20,
          tooltip: 'mangaView.markAs'.tr(
              context: context,
              args: [isRead == true ? 'mangaView.unread'.tr(context: context) : 'mangaView.read'.tr(context: context)]),
          icon: isRead == true
              ? Icon(Icons.visibility_off, color: theme.disabledColor)
              : Icon(Icons.visibility, color: theme.primaryIconTheme.color),
          constraints: const BoxConstraints(minWidth: 20.0, minHeight: 20.0, maxWidth: 24.0, maxHeight: 24.0),
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
    this.leading = const [],
  });

  final ProviderBase<AsyncValue<List<ChapterFeedItemData>>> provider;
  final String? title;
  final String? emptyText;
  final VoidCallback? onAtEdge;
  final RefreshCallback onRefresh;
  final ScrollController? controller;
  final String? restorationId;
  final List<Widget> leading;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = controller ?? useScrollController();
    final resultProvider = ref.watch(provider);
    final isLoading = resultProvider.isLoading && !resultProvider.isRefreshing;

    useEffect(() {
      void controllerAtEdge() {
        if (onAtEdge != null &&
            scrollController.position.atEdge &&
            scrollController.position.pixels == scrollController.position.maxScrollExtent) {
          onAtEdge!();
        }
      }

      scrollController.addListener(controllerAtEdge);
      return () => scrollController.removeListener(controllerAtEdge);
    }, [scrollController]);

    return Center(
      child: RefreshIndicator(
        onRefresh: onRefresh,
        child: DataProviderWhenWidget(
          provider: provider,
          data: resultProvider,
          builder: (context, results) => CustomScrollView(
            scrollBehavior: const MouseTouchScrollBehavior(),
            physics: const AlwaysScrollableScrollPhysics(),
            controller: scrollController,
            restorationId: restorationId,
            cacheExtent: MediaQuery.sizeOf(context).height,
            slivers: [
              ...leading,
              if (title != null)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        title!,
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                ),
              if (results.isEmpty)
                SliverToBoxAdapter(
                  child: Center(
                    child: Text(emptyText ?? 'errors.noresults'.tr(context: context)),
                  ),
                ),
              SuperSliverList.builder(
                itemCount: results.length,
                findChildIndexCallback: (key) {
                  final valueKey = key as ValueKey<int>;
                  final val = results.indexWhere((i) => i.id == valueKey.value);
                  return val >= 0 ? val : null;
                },
                itemBuilder: (context, index) {
                  final elem = results.elementAt(index);
                  return ChapterFeedItem(key: ValueKey(elem.id), state: elem);
                },
              ),
              if (isLoading)
                const SliverToBoxAdapter(
                  child: ListSpinner(),
                ),
            ],
          ),
          loadingBuilder: (context, progress) => LoadingOverlayStack(
            progress: progress?.toDouble(),
          ),
        ),
      ),
    );
  }
}

class ChapterFeedItem extends HookConsumerWidget {
  const ChapterFeedItem({super.key, required this.state});

  final ChapterFeedItemData state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();
    final screenSizeSmall = DeviceContext.screenWidthSmall(context);
    final theme = Theme.of(context);

    final listsliver = SliverList.separated(
      findChildIndexCallback: (key) {
        final valueKey = key as ValueKey<String>;
        final val = state.chapters.indexWhere((i) => i.id == valueKey.value);
        return val >= 0 ? val : null;
      },
      itemBuilder: (context, index) {
        final e = state.chapters.elementAt(index);
        return ChapterButtonWidget(
          key: ValueKey(e.id),
          chapter: e,
          manga: state.manga,
          link: Text(
            state.manga.attributes!.title.get('en'),
            style: const TextStyle(fontSize: 18),
          ),
          onLinkPressed: () async {
            ref.read(readChaptersProvider.notifier).get([state.manga]);
            ref.read(ratingsProvider.notifier).get([state.manga]);
            ref.read(statisticsProvider.notifier).get([state.manga]);
            context.push('/title/${state.manga.id}', extra: state.manga);
          },
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        height: 4,
      ),
      itemCount: state.chapters.length,
    );

    final titleBtn = TextButton.icon(
      style: TextButton.styleFrom(
        alignment: Alignment.centerLeft,
        minimumSize: const Size(0.0, 24.0),
        shape: const RoundedRectangleBorder(),
        foregroundColor: theme.colorScheme.onSurface,
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        visualDensity: const VisualDensity(horizontal: -4.0, vertical: -4.0),
      ),
      onPressed: () async {
        ref.read(readChaptersProvider.notifier).get([state.manga]);
        ref.read(ratingsProvider.notifier).get([state.manga]);
        ref.read(statisticsProvider.notifier).get([state.manga]);
        context.push('/title/${state.manga.id}', extra: state.manga);
      },
      icon: CountryFlag(
        key: ValueKey('CountryFlag(${state.manga.attributes!.originalLanguage.code})'),
        flag: state.manga.attributes!.originalLanguage.flag,
      ),
      label: Text(
        state.manga.attributes!.title.get('en'),
        overflow: TextOverflow.ellipsis,
      ),
    );

    final coverBtn = InkWell(
      onTap: () async {
        ref.read(readChaptersProvider.notifier).get([state.manga]);
        ref.read(ratingsProvider.notifier).get([state.manga]);
        ref.read(statisticsProvider.notifier).get([state.manga]);
        context.push('/title/${state.manga.id}', extra: state.manga);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 6.0),
        child: CachedNetworkImage(
          imageUrl: state.coverArt,
          imageBuilder: (context, imageProvider) => Ink(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(4.0)),
            ),
          ),
          width: screenSizeSmall ? 64.0 : 128.0,
          height: screenSizeSmall ? 91.0 : 182.0,
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
          errorWidget: (context, url, error) => const Icon(Icons.error),
          fit: BoxFit.cover,
        ),
      ),
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
                        child: CustomScrollView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          slivers: [listsliver],
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
                    child: CustomScrollView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      slivers: [
                        SliverList.list(
                          children: [
                            titleBtn,
                            const Divider(height: 10.0),
                          ],
                        ),
                        listsliver,
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }
}

class ChapterButtonWidget extends HookWidget {
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
    useAutomaticKeepAlive();
    final bool screenSizeSmall = DeviceContext.screenWidthSmall(context);

    final isEndChapter = manga.attributes!.lastChapter != null &&
        manga.attributes!.lastChapter?.isNotEmpty == true &&
        chapter.attributes.chapter == manga.attributes!.lastChapter;
    final isOfficialPub = chapter.attributes.externalUrl != null;

    final user = chapter.uploadUser;
    final userChip = IconTextChip(
      key: ValueKey(user?.id),
      icon: isOfficialPub ? _checkIconB : null,
      text: !isOfficialPub ? (user?.attributes?.username.crop() ?? '') : 'mangadex.officialPub'.tr(context: context),
    );

    final statsChip = Consumer(
      builder: (context, ref, child) {
        final comments = ref.watch(chapterStatsProvider.select(
          (value) => switch (value) {
            AsyncValue(value: final data?) when data.containsKey(chapter.id) => data[chapter.id]?.comments,
            _ => null,
          },
        ));

        return CommentChip(
          key: ValueKey('CommentChip(${chapter.id})'),
          comments: comments,
        );
      },
    );

    final statsChipRow = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(child: statsChip),
      ],
    );

    final pubtime = _PubTime(
      key: ValueKey(chapter.attributes.publishAt.millisecondsSinceEpoch),
      time: chapter.attributes.publishAt,
    );

    final markReadButton = MarkReadButton(
      key: ValueKey('MarkReadButton(${chapter.id})'),
      chapter: chapter,
      manga: manga,
    );

    final title = Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 6.0,
      children: [
        const SizedBox.shrink(),
        CountryFlag(
          key: ValueKey('CountryFlag(${chapter.attributes.translatedLanguage.code})'),
          flag: chapter.attributes.translatedLanguage.flag,
        ),
        if (isOfficialPub) _openIconB,
        Expanded(
          child: Row(
            spacing: 6.0,
            children: [
              Flexible(
                child: ChapterTitle(
                  key: ValueKey('ChapterTitle(${chapter.id})'),
                  chapter: chapter,
                  manga: manga,
                ),
              ),
              if (isEndChapter) _endChip,
            ],
          ),
        ),
        if (screenSizeSmall) statsChipRow
      ],
    );

    final groups = _GroupRow(
      key: ValueKey('_GroupRow(${chapter.id})'),
      chapter: chapter,
    );

    final tile = screenSizeSmall
        ? Table(
            columnWidths: const <int, TableColumnWidth>{
              0: FixedColumnWidth(24),
              1: FlexColumnWidth(),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: <TableRow>[
              TableRow(
                children: <Widget>[
                  markReadButton,
                  title,
                ],
              ),
              TableRow(
                children: <Widget>[
                  _groupIconB,
                  groups,
                ],
              ),
              TableRow(
                children: [
                  _personIconB,
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Flexible(child: userChip),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        spacing: 4.0,
                        children: [
                          _scheduleIconB,
                          pubtime,
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          )
        : Table(
            columnWidths: const <int, TableColumnWidth>{
              0: FixedColumnWidth(24),
              1: FlexColumnWidth(),
              2: FixedColumnWidth(24),
              3: FixedColumnWidth(145),
              4: FixedColumnWidth(60),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: <TableRow>[
              TableRow(
                children: <Widget>[
                  markReadButton,
                  title,
                  _scheduleIconB,
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(width: 2.0),
                      pubtime,
                    ],
                  ),
                  const SizedBox.shrink(),
                ],
              ),
              TableRow(
                children: <Widget>[
                  _groupIconB,
                  groups,
                  _personIconB,
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(child: userChip),
                    ],
                  ),
                  statsChipRow,
                ],
              ),
            ],
          );

    return InkWell(
      onTap: () {
        context.push(
          '/chapter/${chapter.id}',
          extra: ReaderData(
            title: chapter.title,
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
          final loggedin = ref.watch(authControlProvider).value ?? false;

          Border border;

          if (!loggedin) {
            border = Border(
              left: BorderSide(color: tileColor, width: 4.0),
            );
          } else {
            bool? isRead = ref.watch(readChaptersProvider.select(
              (value) => switch (value) {
                AsyncValue(value: final data?) => data[manga.id]?.contains(chapter.id) == true,
                _ => null,
              },
            ));

            border = Border(
              left: BorderSide(color: isRead == true ? tileColor : Colors.blue, width: 4.0),
            );
          }

          return Ink(
            padding: EdgeInsets.symmetric(horizontal: (screenSizeSmall ? 6.0 : 10.0), vertical: 4.0),
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
    this.isLoading = false,
  });

  final Widget? title;
  final List<Widget> children;
  final List<Widget> leading;
  final ScrollPhysics? physics;
  final VoidCallback? onAtEdge;
  final ScrollController? controller;
  final bool noController;
  final bool showToggle;
  final bool isLoading;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = controller ?? (noController ? null : useScrollController());
    final view = showToggle ? ref.watch(_mangaListViewProvider) : MangaListView.grid;

    useEffect(() {
      void controllerAtEdge() {
        if (scrollController != null &&
            onAtEdge != null &&
            scrollController.position.atEdge &&
            scrollController.position.pixels == scrollController.position.maxScrollExtent) {
          onAtEdge!();
        }
      }

      scrollController?.addListener(controllerAtEdge);
      return () => scrollController?.removeListener(controllerAtEdge);
    }, [scrollController]);

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
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                child: Row(
                  children: [
                    if (title != null) title!,
                    const Spacer(),
                    const GridExtentSlider(),
                    if (showToggle)
                      SegmentedButton<MangaListView>(
                        showSelectedIcon: false,
                        style: SegmentedButton.styleFrom(shape: const RoundedRectangleBorder()),
                        segments: <ButtonSegment<MangaListView>>[
                          ButtonSegment<MangaListView>(
                            value: MangaListView.grid,
                            icon: Icon(Icons.grid_view, size: 24),
                            tooltip: 'ui.gridView'.tr(context: context),
                          ),
                          ButtonSegment<MangaListView>(
                            value: MangaListView.list,
                            icon: Icon(Icons.table_rows, size: 24),
                            tooltip: 'ui.listView'.tr(context: context),
                          ),
                          ButtonSegment<MangaListView>(
                            value: MangaListView.detailed,
                            icon: Icon(Icons.view_list, size: 24),
                            tooltip: 'ui.detailedView'.tr(context: context),
                          ),
                        ],
                        selected: <MangaListView>{view},
                        onSelectionChanged: (Set<MangaListView> newSelection) {
                          ref.read(_mangaListViewProvider.notifier).state = newSelection.first;
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

  int? _findChildIndexCb(Key? key) {
    final valueKey = key as ValueKey<String>;
    final val = items.indexWhere((i) => i.id == valueKey.value);
    return val >= 0 ? val : null;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cfg = ref.watch(gagakuSettingsProvider);
    final view = selectMode ? MangaListView.grid : ref.watch(_mangaListViewProvider);

    switch (view) {
      case MangaListView.list:
        return SliverList.builder(
          findChildIndexCallback: _findChildIndexCb,
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
            maxCrossAxisExtent: cfg.gridAlbumExtent.detailed,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: DeviceContext.screenWidthSmall(context) ? 1.0 : 2.0,
          ),
          findChildIndexCallback: _findChildIndexCb,
          itemBuilder: (context, index) {
            final manga = items.elementAt(index);
            return GridMangaDetailedItem(
              key: ValueKey(manga.id),
              manga: manga,
              header: headers?[manga.id],
            );
          },
          itemCount: items.length,
        );

      case MangaListView.grid:
        return SliverGrid.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: cfg.gridAlbumExtent.grid,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 0.7,
          ),
          findChildIndexCallback: _findChildIndexCb,
          itemBuilder: (context, index) {
            final manga = items.elementAt(index);
            return GridMangaItem(
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

class GridMangaItem extends HookConsumerWidget {
  const GridMangaItem({
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
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();
    final aniController = useAnimationController(duration: const Duration(milliseconds: 100));
    final gradient = useAnimation(aniController.drive(Styles.coverArtGradientTween));

    final image = GridAlbumImage(
      gradient: gradient,
      child: CachedNetworkImage(
        imageUrl: manga.getFirstCoverUrl(quality: CoverArtQuality.medium),
        width: 256.0,
        fit: BoxFit.cover,
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );

    return InkWell(
      onTap: () async {
        ref.read(readChaptersProvider.notifier).get([manga]);
        ref.read(ratingsProvider.notifier).get([manga]);
        ref.read(statisticsProvider.notifier).get([manga]);
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
                ? GridAlbumTextBar(
                    height: 40,
                    backgroundColor: Colors.black87,
                    text: header!,
                  )
                : null),
        footer: GridAlbumTextBar(
          height: 80,
          leading: CountryFlag(
            flag: manga.attributes!.originalLanguage.flag,
            size: 18,
          ),
          text: manga.attributes!.title.get('en'),
        ),
        child: image,
      ),
    );
  }
}

class GridMangaDetailedItem extends HookConsumerWidget {
  const GridMangaDetailedItem({
    super.key,
    required this.manga,
    this.header,
  });

  final Manga manga;
  final String? header;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();
    final bool screenSizeSmall = DeviceContext.screenWidthSmall(context);
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8.0,
          children: [
            TextButton.icon(
              style: TextButton.styleFrom(
                  foregroundColor: theme.colorScheme.onSurface,
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              onPressed: () async {
                ref.read(readChaptersProvider.notifier).get([manga]);
                ref.read(ratingsProvider.notifier).get([manga]);
                ref.read(statisticsProvider.notifier).get([manga]);
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
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () async {
                      ref.read(readChaptersProvider.notifier).get([manga]);
                      ref.read(ratingsProvider.notifier).get([manga]);
                      ref.read(statisticsProvider.notifier).get([manga]);
                      context.push('/title/${manga.id}', extra: manga);
                    },
                    child: CachedNetworkImage(
                      imageUrl: manga.getFirstCoverUrl(quality: CoverArtQuality.medium),
                      width: screenSizeSmall ? 80.0 : 128.0,
                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                          Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 4.0,
                      children: [
                        if (header != null) IconTextChip(text: header!),
                        MangaStatisticsRow(
                          key: ValueKey('MangaStatisticsRow(${manga.id})'),
                          manga: manga,
                        ),
                        MangaGenreRow(
                          key: ValueKey('MangaGenreRow(${manga.id})'),
                          manga: manga,
                        ),
                        if (manga.attributes!.description.isNotEmpty)
                          Expanded(
                            child: Text(
                              manga.attributes!.description.get('en'),
                              overflow: TextOverflow.clip,
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

class _ListMangaItem extends HookConsumerWidget {
  const _ListMangaItem({
    super.key,
    required this.manga,
    this.header,
  });

  final Manga manga;
  final String? header;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
              onPressed: () async {
                ref.read(readChaptersProvider.notifier).get([manga]);
                ref.read(ratingsProvider.notifier).get([manga]);
                ref.read(statisticsProvider.notifier).get([manga]);
                context.push('/title/${manga.id}', extra: manga);
              },
              child: CachedNetworkImage(
                imageUrl: manga.getFirstCoverUrl(quality: CoverArtQuality.medium),
                width: 80.0,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10.0,
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
                      ref.read(readChaptersProvider.notifier).get([manga]);
                      ref.read(ratingsProvider.notifier).get([manga]);
                      ref.read(statisticsProvider.notifier).get([manga]);
                      context.push('/title/${manga.id}', extra: manga);
                    },
                    icon: CountryFlag(
                      flag: manga.attributes!.originalLanguage.flag,
                      size: 18,
                    ),
                    label: Text(manga.attributes!.title.get('en')),
                  ),
                  if (header != null) IconTextChip(text: header!),
                  MangaGenreRow(
                    key: ValueKey('MangaGenreRow(${manga.id})'),
                    manga: manga,
                  ),
                  MangaStatisticsRow(
                    key: ValueKey('MangaStatisticsRow(${manga.id})'),
                    manga: manga,
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

class ChapterTitle extends ConsumerWidget {
  final Chapter chapter;
  final Manga manga;

  const ChapterTitle({super.key, required this.chapter, required this.manga});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final loggedin = ref.watch(authControlProvider).value ?? false;

    TextStyle textstyle;

    if (!loggedin) {
      textstyle = TextStyle(
        color: theme.colorScheme.onPrimaryContainer,
      );
    } else {
      bool? isRead = ref.watch(readChaptersProvider.select(
        (value) => switch (value) {
          AsyncValue(value: final data?) => data[manga.id]?.contains(chapter.id) == true,
          _ => null,
        },
      ));

      textstyle = TextStyle(color: (isRead == true ? theme.disabledColor : theme.colorScheme.onPrimaryContainer));
    }

    return Text(
      chapter.title,
      overflow: TextOverflow.ellipsis,
      style: textstyle,
    );
  }
}

class MangaGenreRow extends HookWidget {
  const MangaGenreRow({
    super.key,
    required this.manga,
  });

  final Manga manga;

  @override
  Widget build(BuildContext context) {
    final contentTagChips = useMemoized(() {
      return manga.attributes!.tags
          .where((tag) => tag.attributes.group == TagGroup.content)
          .map((e) => ContentChip(key: ValueKey(e.id), content: e.attributes.name.get('en')));
    }, [manga]);

    final genreTagChips = useMemoized(() {
      return manga.attributes!.tags.where((tag) => tag.attributes.group != TagGroup.content).map(
            (e) => IconTextChip(key: ValueKey(e.id), text: e.attributes.name.get('en')),
          );
    }, [manga]);

    return Wrap(
      spacing: 4.0,
      runSpacing: 4.0,
      children: [
        if (manga.attributes!.contentRating != ContentRating.safe)
          ContentRatingChip(rating: manga.attributes!.contentRating),
        ...contentTagChips,
        ...genreTagChips,
      ],
    );
  }
}

class MangaStatisticsRow extends HookConsumerWidget {
  const MangaStatisticsRow({
    super.key,
    required this.manga,
    this.shortStatus = true,
  });

  final Manga manga;
  final bool shortStatus;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsProvider = ref.watch(statisticsProvider.select(
      (map) => switch (map) {
        AsyncValue(value: final stats?) when stats.containsKey(manga.id) => stats[manga.id],
        _ => null,
      },
    ));

    // Redundancy
    useEffect(() {
      Future.delayed(Duration.zero, () async {
        await ref.read(statisticsProvider.notifier).get([manga]);
      });
      return null;
    }, []);

    final numFormatter = useMemoized(() {
      return NumberFormat.compact(locale: context.locale.toString());
    }, [context.locale]);

    return Wrap(
      runSpacing: 4.0,
      spacing: 5.0,
      children: [
        ...switch (statsProvider) {
          MangaStatistics(:final rating, :final follows, :final comments) => [
              IconTextChip(
                key: ValueKey('_RatingChip(${manga.id})'),
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
                text: rating.bayesian.toStringAsFixed(2),
                style: const TextStyle(
                  color: Colors.amber,
                  shadows: [
                    Shadow(
                      offset: Offset(1.0, 1.0),
                    ),
                  ],
                ),
              ),
              IconTextChip(
                key: ValueKey('_FollowsChip(${manga.id})'),
                icon: const Icon(
                  Icons.bookmark_outline,
                  size: 18,
                ),
                text: numFormatter.format(follows),
              ),
              CommentChip(key: ValueKey('CommentChip(${manga.id})'), comments: comments),
            ],
          _ => [
              IconTextChip(
                text: 'ui.loadingDot'.tr(context: context),
              )
            ],
        },
        const SizedBox.shrink(),
        MangaStatusChip(
          key: ValueKey('MangaStatusChip(${manga.id})'),
          status: manga.attributes!.status,
          year: manga.attributes!.year,
          short: shortStatus,
        ),
      ],
    );
  }
}

class _GroupRow extends HookWidget {
  final Chapter chapter;

  const _GroupRow({super.key, required this.chapter});

  @override
  Widget build(BuildContext context) {
    final bool screenSizeSmall = DeviceContext.screenWidthSmall(context);
    final iconSet = screenSizeSmall ? _iconSetS : _iconSetB;
    final isOfficialPub = chapter.attributes.externalUrl != null;

    final groupChips = useMemoized(() {
      final chips = <Widget>[];

      for (final g in chapter.groups) {
        chips.add(Flexible(
            child: IconTextChip(
          key: ValueKey(g.id),
          icon: isOfficialPub ? iconSet[_IconSet.circle] : null,
          text: g.attributes.name,
          onPressed: () {
            context.push('/group/${g.id}', extra: g);
          },
        )));
      }

      if (chips.isEmpty) {
        chips.add(Flexible(
            child: IconTextChip(
          key: const ValueKey('nogroup'),
          text: 'No Group',
        )));
      }

      return chips;
    }, [chapter, screenSizeSmall]);

    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 6.0,
      children: groupChips,
    );
  }
}

class _PubTime extends StatelessWidget {
  final DateTime time;

  const _PubTime({super.key, required this.time});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    //final bool screenSizeSmall = DeviceContext.screenWidthSmall(context);

    final lang = context.locale.languageCode;
    //final locale = screenSizeSmall && timeagoLocaleList.contains('${lang}_short') ? '${lang}_short' : lang;

    final pubtime = timeago.format(
      time,
      locale: lang,
    );

    return Text(
      pubtime,
      style: TextStyle(color: theme.colorScheme.onPrimaryContainer),
    );
  }
}

class CommentChip extends HookWidget {
  final StatisticsDetailsComments? comments;

  const CommentChip({super.key, this.comments});

  @override
  Widget build(BuildContext context) {
    final numFormatter = useMemoized(() {
      return NumberFormat.compact(locale: context.locale.toString());
    }, [context.locale]);

    return IconTextChip(
      icon: const Icon(
        Icons.chat_bubble_outline,
        size: 18,
      ),
      text: (comments != null) ? numFormatter.format(comments!.repliesCount) : 'N/A',
      onPressed: (comments != null)
          ? () async {
              final url = 'https://forums.mangadex.org/threads/${comments!.threadId}';

              if (!await launchUrl(Uri.parse(url))) {
                throw 'Could not launch $url';
              }
            }
          : null,
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
    final label = context.tr(status.label);
    return IconTextChip(
      icon: Icon(
        Icons.circle,
        color: switch (status) {
          MangaStatus.completed => Colors.blue,
          MangaStatus.cancelled => Colors.red,
          MangaStatus.hiatus => Colors.orange,
          _ => Colors.green,
        },
        size: 10,
      ),
      text: (year != null && !short) ? "$year, $label" : label,
    );
  }
}

class ContentRatingChip extends StatelessWidget {
  const ContentRatingChip({super.key, required this.rating});

  final ContentRating rating;

  @override
  Widget build(BuildContext context) {
    return IconTextChip(
      color: switch (rating) {
        ContentRating.safe => Colors.green,
        ContentRating.suggestive => Colors.orange,
        ContentRating.erotica || ContentRating.pornographic => Colors.red,
      },
      text: context.tr(rating.label),
    );
  }
}

class ContentChip extends StatelessWidget {
  const ContentChip({super.key, required this.content});

  final String content;

  @override
  Widget build(BuildContext context) {
    return IconTextChip(
      color: switch (content) {
        'Gore' || 'Sexual Violence' => Colors.red,
        _ => Colors.orange,
      },
      text: content,
    );
  }
}

Future<bool?> showDeleteListDialog(BuildContext context, String listName) async => await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        final nav = Navigator.of(context);
        return AlertDialog(
          title: Text('mangadex.deleteList'.tr(context: context)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('mangadex.deleteListWarning'.tr(context: context, args: [listName])),
              Text('mangadex.irreversibleWarning'.tr(context: context)),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('ui.no'.tr(context: context)),
              onPressed: () {
                nav.pop(null);
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
