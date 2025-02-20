import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/model/model.dart';
import 'package:gagaku/util/default_scroll_controller.dart';
import 'package:gagaku/util/ui.dart';
import 'package:gagaku/util/util.dart';
import 'package:gagaku/web/extension_settings.dart';
import 'package:gagaku/web/model/config.dart';
import 'package:gagaku/web/model/model.dart';
import 'package:gagaku/web/model/types.dart';
import 'package:gagaku/web/search.dart';
import 'package:gagaku/web/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Page<dynamic> buildExtensionHomepage(BuildContext context, GoRouterState state) {
  final data = state.extra.asOrNull<SourceIdentifier>();

  Widget child;

  if (data != null) {
    child = _HomepageWidget(
      key: ValueKey(data.internal.id),
      source: data,
    );
  } else {
    child = _QueriedHomepageWidget(
      sourceId: state.pathParameters['source']!,
    );
  }

  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: Styles.slideTransitionBuilder,
  );
}

class WebSourceFrontpage extends HookConsumerWidget {
  const WebSourceFrontpage({
    super.key,
    this.controller,
  });

  final ScrollController? controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = DefaultScrollController.maybeOf(context) ?? controller;

    return DataProviderWhenWidget(
      provider: extensionInfoListProvider,
      builder: (BuildContext context, List<SourceIdentifier> sources) {
        final homepageSources = <SourceIdentifier>[];

        for (final source in sources) {
          if (source.external.hasIntent(SourceIntents.homepageSections)) {
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
                'webSources.homepages'.tr(context: context),
                style: TextStyle(fontSize: 24),
              ),
            ),
            if (homepageSources.isEmpty)
              SliverToBoxAdapter(
                child: Center(
                  child: Text("webSources.noSourcesWarning".tr(context: context)),
                ),
              ),
            if (homepageSources.isNotEmpty)
              SliverList.builder(
                itemCount: homepageSources.length,
                itemBuilder: (context, index) {
                  final item = homepageSources.elementAt(index);

                  return Card(
                    child: ListTile(
                      leading: item.internal.icon != null
                          ? Image.network(
                              item.internal.icon!,
                              width: 36,
                              height: 36,
                            )
                          : const Icon(Icons.rss_feed),
                      title: Text(item.external.name),
                      onTap: () {
                        context.push('/extensions/home/${item.internal.id}', extra: item);
                      },
                    ),
                  );
                },
              )
          ],
        );
      },
    );
  }
}

class _QueriedHomepageWidget extends StatelessWidget {
  const _QueriedHomepageWidget({
    required this.sourceId,
  });

  final String sourceId;

  @override
  Widget build(BuildContext context) {
    return DataProviderWhenWidget(
      provider: extensionInfoListProvider,
      errorBuilder: (context, child) => Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.go(GagakuRoute.extensionHome);
              }
            },
          ),
        ),
        body: child,
      ),
      builder: (context, data) {
        final idx = data.indexWhere((e) => e.internal.id == sourceId);

        if (idx == -1) {
          return Scaffold(
            body: Center(
              child: Text("errors.unknownSourceID".tr(context: context, args: [sourceId])),
            ),
          );
        }

        return _HomepageWidget(
          source: data[idx],
        );
      },
    );
  }
}

class _HomepageWidget extends HookConsumerWidget {
  final SourceIdentifier source;

  const _HomepageWidget({super.key, required this.source});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final nav = Navigator.of(context);
    const style = TextStyle(fontSize: 24);
    final controller = useScrollController();
    final refresh = useState(0);
    final results = useMemoized(
        () => ref.read(extensionSourceProvider(source.internal.id).notifier).getHomePage(), [source, refresh.value]);
    final future = useFuture(results);
    final slivers = <Widget>[];

    if (future.hasError) {
      final error = future.error!;
      final stackTrace = future.stackTrace!;
      final msg = "ExtensionSource(${source.internal.id}).getHomePage() failed";

      Styles.showErrorSnackBar(messenger, '$error');
      logger.e(msg, error: error, stackTrace: stackTrace);

      slivers.add(SliverList.list(children: [
        Text('$error'),
        Text(stackTrace.toString()),
      ]));
    }

    if (future.connectionState == ConnectionState.waiting || !future.hasData) {
      slivers.add(const SliverToBoxAdapter(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ));
    }

    if (future.data != null) {
      final data = future.data!;
      final homepageWidgets = <Widget>[];

      for (final section in data) {
        if (section.containsMoreItems) {
          homepageWidgets.add(
            TextButton.icon(
              onPressed: () {
                nav.push(SlideTransitionRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => _HomeSectionPage(
                    source: source,
                    section: section,
                  ),
                ));
              },
              label: Text(
                section.title,
                style: style,
              ),
              icon: const Icon(Icons.arrow_forward),
              iconAlignment: IconAlignment.end,
            ),
          );
        } else {
          homepageWidgets.add(Center(
            child: Text(
              section.title,
              style: style,
            ),
          ));
        }
        final mangas = section.items.map((e) => HistoryLink.fromPartialSourceManga(source.internal.id, e)).toList();
        homepageWidgets.add(MangaCarousel(items: mangas));
      }

      if (homepageWidgets.isNotEmpty) {
        slivers.add(SliverList.separated(
          itemCount: homepageWidgets.length,
          itemBuilder: (context, index) {
            return homepageWidgets.elementAt(index);
          },
          separatorBuilder: (context, index) => const SizedBox(
            height: 10.0,
          ),
        ));
      }
    }

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: GestureDetector(
          onTap: () {
            controller.animateTo(0.0, duration: const Duration(milliseconds: 1000), curve: Curves.easeOutCirc);
          },
          child: TitleFlexBar(title: source.external.name),
        ),
        leading: BackButton(
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go(GagakuRoute.extensionHome);
            }
          },
        ),
        actions: [
          OverflowBar(
            spacing: 0.0,
            children: [
              IconButton(
                color: theme.colorScheme.onPrimaryContainer,
                icon: const Icon(Icons.search),
                onPressed: () => nav.push(SlideTransitionRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => WebSourceSearchWidget(
                    source: source,
                  ),
                )),
                tooltip: 'search.arg'.tr(context: context, args: [source.external.name]),
              ),
              if (source.external.hasIntent(SourceIntents.settingsUI))
                IconButton(
                  color: theme.colorScheme.onPrimaryContainer,
                  icon: const Icon(Icons.settings),
                  onPressed: () => nav.push(SlideTransitionRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) => ExtensionSettings(
                      source: source,
                    ),
                  )),
                  tooltip: 'webSources.source.settings'.tr(context: context),
                )
            ],
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () {
          refresh.value++;
          return results;
        },
        child: CustomScrollView(
          scrollBehavior: const MouseTouchScrollBehavior(),
          physics: const AlwaysScrollableScrollPhysics(),
          controller: controller,
          slivers: slivers,
        ),
      ),
    );
  }
}

class _HomeSectionPage extends HookConsumerWidget {
  final SourceIdentifier source;
  final HomeSection section;

  const _HomeSectionPage({required this.source, required this.section});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messenger = ScaffoldMessenger.of(context);
    final defaultCategory = ref.watch(webConfigProvider.select((cfg) => cfg.defaultCategory));
    final controller = useScrollController();

    final items = useState(<HistoryLink>[]);
    final metadata = useRef<Map<String, dynamic>?>({'page': 1});
    final page = useState(1);

    final results = useMemoized(() async {
      if (metadata.value != null) {
        final results = await ref
            .read(extensionSourceProvider(source.internal.id).notifier)
            .getHomeSectionMore(section.id, metadata.value);

        final m = results.results?.map((e) => HistoryLink.fromPartialSourceManga(source.internal.id, e));
        if (m != null) {
          items.value.addAll(m);
        }

        metadata.value = results.metadata;
      }

      return items.value;
    }, [page.value]);
    final future = useFuture(results);

    Widget? errorList;

    if (future.hasError) {
      final error = future.error!;
      final stackTrace = future.stackTrace!;
      final msg = "ExtensionSource(${source.internal.id}).getHomeSectionMore() failed";

      Styles.showErrorSnackBar(messenger, '$error');
      logger.e(msg, error: error, stackTrace: stackTrace);

      errorList = SliverList.list(children: [
        Text('$error'),
        Text(stackTrace.toString()),
      ]);
    }

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: GestureDetector(
          onTap: () {
            controller.animateTo(0.0, duration: const Duration(milliseconds: 1000), curve: Curves.easeOutCirc);
          },
          child: TitleFlexBar(title: section.title),
        ),
        leading: BackButton(
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go(GagakuRoute.extensionHome);
            }
          },
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          items.value = [];
          metadata.value = {'page': 1};
          page.value = 1;
          return results;
        },
        child: WebMangaListWidget(
          physics: const AlwaysScrollableScrollPhysics(),
          controller: controller,
          showToggle: false,
          onAtEdge: () {
            if (metadata.value != null) {
              page.value++;
            }
          },
          isLoading: future.connectionState == ConnectionState.waiting || !future.hasData,
          children: [
            if (errorList != null) errorList,
            WebMangaListViewSliver(
              items: items.value,
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
  const MangaCarousel({
    super.key,
    required this.items,
  });

  final List<HistoryLink> items;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final defaultCategory = ref.watch(webConfigProvider.select((cfg) => cfg.defaultCategory));

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 256),
        child: CarouselView(
          itemExtent: 180,
          shrinkExtent: 180,
          enableSplash: false,
          children: items
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
