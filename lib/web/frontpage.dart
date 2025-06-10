import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/routes.gr.dart';
import 'package:gagaku/util/default_scroll_controller.dart';
import 'package:gagaku/util/infinite_scroll.dart';
import 'package:gagaku/util/ui.dart';
import 'package:gagaku/web/extension_settings.dart';
import 'package:gagaku/web/model/config.dart';
import 'package:gagaku/web/model/model.dart';
import 'package:gagaku/web/model/types.dart';
import 'package:gagaku/web/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class _ExtensionHomeCard extends ConsumerWidget {
  final WebSourceInfo extensionInfo;

  const _ExtensionHomeCard({super.key, required this.extensionInfo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nav = Navigator.of(context);
    final theme = Theme.of(context);
    final tr = context.t;

    return DataProviderWhenWidget(
      provider: extensionSourceProvider(extensionInfo.id),
      errorBuilder:
          (context, defaultChild, error, stacktrace) =>
              Card(child: defaultChild),
      builder: (BuildContext context, source) {
        return Card(
          child: ListTile(
            leading:
                source.icon.isNotEmpty
                    ? Image.network(source.icon, width: 36, height: 36)
                    : const Icon(Icons.rss_feed),
            title: Text(source.name),
            onTap:
                source.hasCapability(SourceIntents.discoverSections)
                    ? () => context.router.push(
                      ExtensionHomeRoute(sourceId: source.id, source: source),
                    )
                    : null,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (source.hasCapability(SourceIntents.settingsUI))
                  IconButton(
                    color: theme.colorScheme.onPrimaryContainer,
                    icon: const Icon(Icons.settings),
                    onPressed:
                        () => nav.push(
                          SlideTransitionRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    ExtensionSettingsPage(source: source),
                          ),
                        ),
                    tooltip: tr.webSources.source.settings,
                  ),
                if (source.hasCapability(SourceIntents.mangaSearch))
                  IconButton(
                    color: theme.colorScheme.onPrimaryContainer,
                    icon: const Icon(Icons.search),
                    onPressed:
                        () => context.router.push(
                          ExtensionSearchRoute(
                            sourceId: source.id,
                            source: source,
                          ),
                        ),
                    tooltip: tr.search.arg(arg: source.name),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

@RoutePage()
class WebSourceFrontPage extends HookConsumerWidget {
  const WebSourceFrontPage({super.key, this.controller, this.process});

  final Uri? process;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tr = context.t;
    final scrollController =
        DefaultScrollController.maybeOf(context, 'WebSourceFrontPage') ??
        controller ??
        useScrollController();

    useEffect(() {
      if (process != null && process!.isScheme('paperback')) {
        final action = process!.host;
        final data = process!.queryParameters;

        Future.delayed(Duration.zero, () async {
          if (!context.mounted) return;
          final messenger = ScaffoldMessenger.of(context);
          final list = ref.read(webConfigProvider.select((c) => c.repoList));

          if (action == 'addrepo') {
            final name = data['displayName']!;
            final url = data['url']!;
            final result = await showDialog<bool>(
              context: context,
              builder: (BuildContext context) {
                final nav = Navigator.of(context);
                return AlertDialog(
                  title: Text(tr.webSources.repo.add),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(tr.webSources.repo.addConfirm(repo: name)),
                      Text(tr.webSources.repo.addWarning),
                    ],
                  ),
                  actions: <Widget>[
                    ElevatedButton(
                      child: Text(tr.ui.no),
                      onPressed: () {
                        nav.pop(null);
                      },
                    ),
                    TextButton(
                      onPressed: () {
                        nav.pop(true);
                      },
                      child: Text(tr.ui.yes),
                    ),
                  ],
                );
              },
            );

            if (result != null && context.mounted) {
              if (!context.mounted) return;

              final exists = list.indexWhere((e) => e.url == url) > -1;

              if (exists) {
                messenger
                  ..removeCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text(tr.webSources.repo.repoExists),
                      backgroundColor: Colors.orange,
                    ),
                  );
              } else {
                ref.read(webConfigProvider.saveWith)(
                  repoList: [...list, RepoInfo(name: name, url: url)],
                );
                messenger
                  ..removeCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text(tr.webSources.repo.repoAddOK),
                      backgroundColor: Colors.green,
                    ),
                  );
              }
            }
          }
        });
      }
      return null;
    }, []);

    final installed = ref.watch(
      webConfigProvider.select((cfg) => cfg.installedSources),
    );

    final homepageSources = <WebSourceInfo>[];

    for (final source in installed) {
      if (source.hasCapability(SourceIntents.mangaChapters)) {
        homepageSources.add(source);
      }
    }

    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverAppBar(
          automaticallyImplyLeading: false,
          pinned: true,
          title: Text(tr.webSources.homepages, style: TextStyle(fontSize: 24)),
        ),
        if (homepageSources.isEmpty)
          SliverToBoxAdapter(
            child: Center(child: Text(tr.webSources.noSourcesWarning)),
          ),
        if (homepageSources.isNotEmpty)
          SliverList.builder(
            itemCount: homepageSources.length,
            itemBuilder: (context, index) {
              final item = homepageSources.elementAt(index);

              return _ExtensionHomeCard(
                key: ValueKey(item.id),
                extensionInfo: item,
              );
            },
          ),
      ],
    );
  }
}

@RoutePage()
class ExtensionHomePage extends StatelessWidget {
  const ExtensionHomePage({
    super.key,
    @PathParam() required this.sourceId,
    this.source,
  });

  final String sourceId;
  final WebSourceInfo? source;

  @override
  Widget build(BuildContext context) {
    if (source != null) {
      return ExtensionHomeWidget(source: source!);
    }

    return DataProviderWhenWidget(
      provider: getExtensionFromIdProvider(sourceId),
      errorBuilder: (context, child, _, __) => Scaffold(body: child),
      builder: (context, data) {
        return ExtensionHomeWidget(source: data);
      },
    );
  }
}

class ExtensionHomeWidget extends HookConsumerWidget {
  final WebSourceInfo source;

  const ExtensionHomeWidget({super.key, required this.source});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tr = context.t;
    final theme = Theme.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final nav = Navigator.of(context);
    const style = TextStyle(fontSize: 24);
    final controller = useScrollController();
    final refresh = useState(0);
    final sectionsFuture = useMemoized(
      () =>
          ref
              .read(extensionSourceProvider(source.id).notifier)
              .getDiscoverSections(),
      [source, refresh.value],
    );
    final sectionsSnapshot = useFuture(sectionsFuture);
    final slivers = <Widget>[];

    if (sectionsSnapshot.hasError) {
      final error = sectionsSnapshot.error!;
      final stackTrace = sectionsSnapshot.stackTrace!;
      final msg = "ExtensionSource(${source.id}).getDiscoverSections() failed";

      Styles.showErrorSnackBar(messenger, '$error');
      logger.e(msg, error: error, stackTrace: stackTrace);

      slivers.add(
        SliverList.list(
          children: [Text('$error'), Text(stackTrace.toString())],
        ),
      );
    }

    if (sectionsSnapshot.connectionState == ConnectionState.waiting ||
        !sectionsSnapshot.hasData) {
      slivers.add(
        const SliverToBoxAdapter(
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    if (sectionsSnapshot.data != null) {
      final sections = sectionsSnapshot.data!;
      final homepageWidgets = <Widget>[];
      final sectionItems = useMemoized(
        () => Future.wait(
          sections.map(
            (e) => ref
                .read(extensionSourceProvider(source.id).notifier)
                .getDiscoverSectionItems(e, null),
          ),
        ),
        [source, refresh.value],
      );
      final itemFuture = useFuture(sectionItems);

      if (itemFuture.hasError) {
        final error = itemFuture.error!;
        final stackTrace = itemFuture.stackTrace!;
        final msg =
            "ExtensionSource(${source.id}).getDiscoverSectionItems() failed";

        Styles.showErrorSnackBar(messenger, '$error');
        logger.e(msg, error: error, stackTrace: stackTrace);

        slivers.add(
          SliverList.list(
            children: [Text('$error'), Text(stackTrace.toString())],
          ),
        );
      }

      if (itemFuture.connectionState == ConnectionState.waiting ||
          !itemFuture.hasData) {
        slivers.add(
          const SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()),
          ),
        );
      }

      if (itemFuture.hasData) {
        for (final (idx, section) in sections.indexed) {
          final sectionResults = itemFuture.data!.elementAt(idx);
          if (sectionResults.metadata != null) {
            homepageWidgets.add(
              TextButton.icon(
                onPressed: () {
                  nav.push(
                    SlideTransitionRouteBuilder(
                      pageBuilder:
                          (context, animation, secondaryAnimation) =>
                              _DiscoverSectionPage(
                                source: source,
                                section: section,
                              ),
                    ),
                  );
                },
                label: Text(section.title, style: style),
                icon: const Icon(Icons.arrow_forward),
                iconAlignment: IconAlignment.end,
              ),
            );
          } else {
            homepageWidgets.add(
              Center(child: Text(section.title, style: style)),
            );
          }

          if (section.type != DiscoverSectionType.genres) {
            final mangas =
                sectionResults.items
                    .map(
                      (e) => HistoryLink.fromDiscoverySectionItem(source.id, e),
                    )
                    .toList();
            homepageWidgets.add(MangaCarousel(items: mangas));
          } else {
            homepageWidgets.add(
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 256),
                  child: CarouselView(
                    itemExtent: 180,
                    shrinkExtent: 180,
                    enableSplash: true,
                    onTap: (idx) {
                      final element =
                          sectionResults.items.elementAt(idx)
                              as GenresCarouselItem;

                      context.router.push(
                        ExtensionSearchRoute(
                          sourceId: source.id,
                          source: source,
                          query: element.searchQuery,
                        ),
                      );
                    },
                    children:
                        sectionResults.items
                            .map(
                              (e) => ColoredBox(
                                color: theme.colorScheme.primaryContainer,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.theater_comedy, size: 32.0),
                                      Text(
                                        (e as GenresCarouselItem).name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                        overflow: TextOverflow.clip,
                                        softWrap: false,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                  ),
                ),
              ),
            );
          }
        }
      }

      if (homepageWidgets.isNotEmpty) {
        slivers.add(
          SliverList.separated(
            itemCount: homepageWidgets.length,
            itemBuilder: (context, index) {
              return homepageWidgets.elementAt(index);
            },
            separatorBuilder: (context, index) => const SizedBox(height: 10.0),
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: GestureDetector(
          onTap: () {
            controller.animateTo(
              0.0,
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeOutCirc,
            );
          },
          child: TitleFlexBar(title: source.name),
        ),
        leading: AutoLeadingButton(),
        actions: [
          OverflowBar(
            spacing: 0.0,
            children: [
              if (source.hasCapability(SourceIntents.mangaSearch))
                IconButton(
                  color: theme.colorScheme.onPrimaryContainer,
                  icon: const Icon(Icons.search),
                  onPressed:
                      () => context.router.push(
                        ExtensionSearchRoute(
                          sourceId: source.id,
                          source: source,
                        ),
                      ),
                  tooltip: tr.search.arg(arg: source.name),
                ),
              if (source.hasCapability(SourceIntents.settingsUI))
                IconButton(
                  color: theme.colorScheme.onPrimaryContainer,
                  icon: const Icon(Icons.settings),
                  onPressed:
                      () => nav.push(
                        SlideTransitionRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  ExtensionSettingsPage(source: source),
                        ),
                      ),
                  tooltip: tr.webSources.source.settings,
                ),
            ],
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () {
          refresh.value++;
          return sectionsFuture;
        },
        child: ScrollConfiguration(
          behavior: const MouseTouchScrollBehavior(),
          child: CustomScrollView(
            scrollBehavior: const MouseTouchScrollBehavior(),
            physics: const AlwaysScrollableScrollPhysics(),
            controller: controller,
            slivers: slivers,
          ),
        ),
      ),
    );
  }
}

class _DiscoverSectionPage extends StatefulHookConsumerWidget {
  const _DiscoverSectionPage({required this.source, required this.section});

  final WebSourceInfo source;
  final DiscoverSection section;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      __DiscoverSectionPageState();
}

class __DiscoverSectionPageState extends ConsumerState<_DiscoverSectionPage> {
  Map<String, dynamic>? metadata = {'page': 1};

  late final _pagingController = GagakuPagingController<dynamic, HistoryLink>(
    getNextPageKey:
        (state) => state.keys?.last == null ? {'page': 1} : metadata,
    fetchPage: (pageKey) async {
      final results = await ref
          .read(extensionSourceProvider(widget.source.id).notifier)
          .getDiscoverSectionItems(widget.section, metadata);

      final m = results.items.map(
        (e) => HistoryLink.fromDiscoverySectionItem(widget.source.id, e),
      );

      metadata = results.metadata;

      return PageResultsMetaData(m.toList());
    },
    getIsLastPage: (_, __) => metadata == null,
    refresh: () async {
      metadata = {'page': 1};
    },
  );

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = useScrollController();

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: GestureDetector(
          onTap: () {
            controller.animateTo(
              0.0,
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeOutCirc,
            );
          },
          child: TitleFlexBar(title: widget.section.title),
        ),
        leading: AutoLeadingButton(),
      ),
      body: RefreshIndicator(
        onRefresh: () async => _pagingController.refresh(),
        child: WebMangaListWidget(
          physics: const AlwaysScrollableScrollPhysics(),
          controller: controller,
          showToggle: false,
          children: [
            WebMangaListViewSliver(
              controller: _pagingController,
              showRemoveButton: false,
            ),
          ],
        ),
      ),
    );
  }
}

class MangaCarousel extends StatelessWidget {
  const MangaCarousel({super.key, required this.items});

  final List<HistoryLink> items;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 256),
        child: CarouselView(
          itemExtent: 180,
          shrinkExtent: 180,
          enableSplash: false,
          children:
              items
                  .map((e) => GridMangaItem(link: e, showRemoveButton: false))
                  .toList(),
        ),
      ),
    );
  }
}
