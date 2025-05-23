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

@RoutePage()
class WebSourceFrontPage extends HookConsumerWidget {
  const WebSourceFrontPage({super.key, this.controller, this.process});

  final Uri? process;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
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

    return DataProviderWhenWidget(
      provider: extensionInfoListProvider,
      builder: (BuildContext context, sources) {
        final homepageSources = <WebSourceInfo>[];

        for (final source in sources) {
          if (source.hasCapability(SourceIntents.homepageSections)) {
            homepageSources.add(source);
          }
        }

        return CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true,
              title: Text(
                tr.webSources.homepages,
                style: TextStyle(fontSize: 24),
              ),
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

                  return Card(
                    child: ListTile(
                      leading:
                          item.icon.isNotEmpty
                              ? Image.network(item.icon, width: 36, height: 36)
                              : const Icon(Icons.rss_feed),
                      title: Text(item.name),
                      onTap: () {
                        context.router.push(
                          ExtensionHomeRoute(sourceId: item.id, source: item),
                        );
                      },
                      // XXX: needs search capability check for 0.9
                      trailing: IconButton(
                        color: theme.colorScheme.onPrimaryContainer,
                        icon: const Icon(Icons.search),
                        onPressed:
                            () => context.router.push(
                              ExtensionSearchRoute(
                                sourceId: item.id,
                                source: item,
                              ),
                            ),
                        tooltip: tr.search.arg(arg: item.name),
                      ),
                    ),
                  );
                },
              ),
          ],
        );
      },
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
    final results = useMemoized(
      () => ref.read(extensionSourceProvider(source.id).notifier).getHomePage(),
      [source, refresh.value],
    );
    final future = useFuture(results);
    final slivers = <Widget>[];

    if (future.hasError) {
      final error = future.error!;
      final stackTrace = future.stackTrace!;
      final msg = "ExtensionSource(${source.id}).getHomePage() failed";

      Styles.showErrorSnackBar(messenger, '$error');
      logger.e(msg, error: error, stackTrace: stackTrace);

      slivers.add(
        SliverList.list(
          children: [Text('$error'), Text(stackTrace.toString())],
        ),
      );
    }

    if (future.connectionState == ConnectionState.waiting || !future.hasData) {
      slivers.add(
        const SliverToBoxAdapter(
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    if (future.data != null) {
      final data = future.data!;
      final homepageWidgets = <Widget>[];

      for (final section in data) {
        if (section.containsMoreItems) {
          homepageWidgets.add(
            TextButton.icon(
              onPressed: () {
                nav.push(
                  SlideTransitionRouteBuilder(
                    pageBuilder:
                        (context, animation, secondaryAnimation) =>
                            _HomeSectionPage(source: source, section: section),
                  ),
                );
              },
              label: Text(section.title, style: style),
              icon: const Icon(Icons.arrow_forward),
              iconAlignment: IconAlignment.end,
            ),
          );
        } else {
          homepageWidgets.add(Center(child: Text(section.title, style: style)));
        }
        final mangas =
            section.items
                .map((e) => HistoryLink.fromPartialSourceManga(source.id, e))
                .toList();
        homepageWidgets.add(MangaCarousel(items: mangas));
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
              // XXX: needs search capability check for 0.9
              IconButton(
                color: theme.colorScheme.onPrimaryContainer,
                icon: const Icon(Icons.search),
                onPressed:
                    () => context.router.push(
                      ExtensionSearchRoute(sourceId: source.id, source: source),
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
          return results;
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

class _HomeSectionPage extends StatefulHookConsumerWidget {
  const _HomeSectionPage({required this.source, required this.section});

  final WebSourceInfo source;
  final HomeSection section;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      __HomeSectionPageState();
}

class __HomeSectionPageState extends ConsumerState<_HomeSectionPage> {
  Map<String, dynamic>? metadata = {'page': 1};

  late final _pagingController = GagakuPagingController<dynamic, HistoryLink>(
    getNextPageKey:
        (state) => state.keys?.last == null ? {'page': 1} : metadata,
    fetchPage: (pageKey) async {
      final results = await ref
          .read(extensionSourceProvider(widget.source.id).notifier)
          .getHomeSectionMore(widget.section.id, metadata);

      final m = results.results?.map(
        (e) => HistoryLink.fromPartialSourceManga(widget.source.id, e),
      );

      metadata = results.metadata;

      if (m != null) {
        return PageResultsMetaData(m.toList());
      }

      return PageResultsMetaData([]);
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
    final defaultCategory = ref.watch(
      webConfigProvider.select((cfg) => cfg.defaultCategory),
    );
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
              favoritesKey: defaultCategory,
              removeFromAll: true,
              showRemoveButton: false,
            ),
          ],
        ),
      ),
    );
  }
}

class MangaCarousel extends ConsumerWidget {
  const MangaCarousel({super.key, required this.items});

  final List<HistoryLink> items;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final defaultCategory = ref.watch(
      webConfigProvider.select((cfg) => cfg.defaultCategory),
    );

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 256),
        child: CarouselView(
          itemExtent: 180,
          shrinkExtent: 180,
          enableSplash: false,
          children:
              items
                  .map(
                    (e) => GridMangaItem(
                      link: e,
                      favoritesKey: defaultCategory,
                      showRemoveButton: false,
                      removeFromAll: true,
                    ),
                  )
                  .toList(),
        ),
      ),
    );
  }
}
