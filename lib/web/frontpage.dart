import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/model/model.dart';
import 'package:gagaku/util/default_scroll_controller.dart';
import 'package:gagaku/util/ui.dart';
import 'package:gagaku/util/util.dart';
import 'package:gagaku/web/model/config.dart';
import 'package:gagaku/web/model/model.dart';
import 'package:gagaku/web/model/types.dart';
import 'package:gagaku/web/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Page<dynamic> buildExtensionHomepage(BuildContext context, GoRouterState state) {
  final data = state.extra.asOrNull<WebSourceInfo>();

  Widget child;

  if (data != null) {
    child = _HomepageWidget(
      key: ValueKey(data.id),
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
      provider: webSourceManagerProvider,
      builder: (BuildContext context, List<WebSourceInfo> sources) {
        final homepageSources = <WebSourceInfo>[];

        for (final source in sources) {
          final info = ref.read(webSourceManagerProvider.notifier).getInfo(source.id);

          if (info.hasIntent(SourceIntents.homepageSections)) {
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
                      leading: item.icon != null
                          ? Image.network(
                              item.icon!,
                              width: 36,
                              height: 36,
                            )
                          : const Icon(Icons.rss_feed),
                      title: Text(item.name),
                      onTap: () {
                        context.push('/extensions/home/${item.id}', extra: item);
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
      provider: webSourceManagerProvider,
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
        final idx = data.indexWhere((e) => e.id == sourceId);

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
  final WebSourceInfo source;

  const _HomepageWidget({super.key, required this.source});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messenger = ScaffoldMessenger.of(context);
    const style = TextStyle(fontSize: 24);
    final controller = useScrollController();
    final results = useMemoized(() => ref.read(webSourceManagerProvider.notifier).getHomePage(source.id), [source]);
    final future = useFuture(results);
    final slivers = <Widget>[];

    if (future.hasError) {
      final error = future.error!;
      final stackTrace = future.stackTrace!;
      final msg = "WebSource(${source.id}).getHomePage() failed";

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
        homepageWidgets.add(Center(
          child: Text(
            section.title,
            style: style,
          ),
        ));
        final mangas = section.items.map((e) => HistoryLink.fromPartialSourceManga(source.id, e)).toList();
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
          child: TitleFlexBar(title: source.name),
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
      body: CustomScrollView(
        controller: controller,
        slivers: slivers,
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
    final cfg = ref.watch(webConfigProvider);

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
                  favoritesKey: cfg.defaultCategory,
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
