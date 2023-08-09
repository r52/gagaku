import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/mangadex/model.dart';
import 'package:gagaku/mangadex/types.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:gagaku/ui.dart';
import 'package:gagaku/util.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

part 'creator_view.g.dart';

Page<dynamic> buildCreatorViewPage(BuildContext context, GoRouterState state) {
  final creator = state.extra.asOrNull<CreatorType>();

  Widget child;

  if (creator != null) {
    child = MangaDexCreatorViewWidget(
      creator: creator,
    );
  } else {
    child = QueriedMangaDexCreatorViewWidget(
        creatorId: state.pathParameters['creatorId']!);
  }

  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: Styles.scaledSharedAxisTransitionBuilder,
  );
}

@riverpod
Future<CreatorType> _fetchCreatorFromId(
    _FetchCreatorFromIdRef ref, String creatorId) async {
  final api = ref.watch(mangadexProvider);
  final creator = await api.fetchCreators([creatorId]);
  return creator.first;
}

@riverpod
Future<Iterable<Manga>> _fetchCreatorTitles(
    _FetchCreatorTitlesRef ref, CreatorType creator) async {
  final mangas = await ref.watch(creatorTitlesProvider(creator).future);
  await ref.watch(statisticsProvider.notifier).get(mangas);

  ref.keepAlive();

  return mangas;
}

class QueriedMangaDexCreatorViewWidget extends ConsumerWidget {
  const QueriedMangaDexCreatorViewWidget({super.key, required this.creatorId});

  final String creatorId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final group = ref.watch(_fetchCreatorFromIdProvider(creatorId));

    Widget child;

    switch (group) {
      case AsyncData(:final value):
        return MangaDexCreatorViewWidget(
          creator: value,
        );
      case AsyncError(:final error, :final stackTrace):
        final messenger = ScaffoldMessenger.of(context);
        Styles.showErrorSnackBar(messenger, '$error');
        logger.e("_fetchCreatorFromIdProvider($creatorId) failed",
            error: error, stackTrace: stackTrace);

        child = Styles.errorColumn(error, stackTrace);
        break;
      case _:
        child = Styles.listSpinner;
        break;
    }

    return Scaffold(
      body: child,
    );
  }
}

class MangaDexCreatorViewWidget extends HookConsumerWidget {
  const MangaDexCreatorViewWidget({super.key, required this.creator});

  final CreatorType creator;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();
    final theme = Theme.of(context);
    final mangas = ref.watch(_fetchCreatorTitlesProvider(creator));
    final isLoading = ref.watch(creatorTitlesProvider(creator)).isLoading;

    Widget createLinkChip(String url, String text) {
      return ButtonChip(
        onPressed: () async {
          if (!await launchUrl(Uri.parse(url))) {
            throw 'Could not launch $url';
          }
        },
        text: Text(text),
      );
    }

    return Scaffold(
        body: Stack(
      children: [
        switch (mangas) {
          AsyncValue(:final error?, :final stackTrace?) => () {
              final messenger = ScaffoldMessenger.of(context);
              Styles.showErrorSnackBar(messenger, '$error');
              logger.e("_fetchCreatorTitlesProvider(creator) failed",
                  error: error, stackTrace: stackTrace);

              return RefreshIndicator(
                onRefresh: () async {
                  ref.invalidate(creatorTitlesProvider(creator));
                  return await ref
                      .refresh(_fetchCreatorTitlesProvider(creator).future);
                },
                child: Styles.errorList(error, stackTrace),
              );
            }(),
          AsyncValue(:final value?) => () {
              if (value.isEmpty) {
                return const Text('No manga!');
              }

              return RefreshIndicator(
                onRefresh: () async {
                  ref.read(creatorTitlesProvider(creator).notifier).clear();
                  return await ref
                      .refresh(_fetchCreatorTitlesProvider(creator).future);
                },
                child: MangaListWidget(
                  leading: [
                    SliverAppBar(
                      pinned: true,
                      snap: false,
                      floating: false,
                      leading: context.canPop()
                          ? BackButton(
                              onPressed: () => context.pop(),
                            )
                          : null,
                      flexibleSpace: GestureDetector(
                        onTap: () {
                          scrollController.animateTo(0.0,
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut);
                        },
                        child: Styles.titleFlexBar(
                            context: context, title: creator.attributes.name),
                      ),
                    ),
                    if (creator.attributes.biography.isNotEmpty)
                      SliverToBoxAdapter(
                        child: ExpansionTile(
                          title: const Text('Biography'),
                          children: [
                            for (final MapEntry(key: prop, value: desc)
                                in creator.attributes.biography.entries)
                              ExpansionTile(
                                title: Text(prop),
                                children: [
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(8),
                                    color: theme.colorScheme.surfaceVariant,
                                    child: MarkdownBody(
                                      data: desc,
                                    ),
                                  ),
                                ],
                              )
                          ],
                        ),
                      ),
                    if (creator.attributes.twitter != null ||
                        creator.attributes.pixiv != null ||
                        creator.attributes.youtube != null ||
                        creator.attributes.website != null)
                      SliverToBoxAdapter(
                        child: ExpansionTile(
                          expandedAlignment: Alignment.centerLeft,
                          title: const Text('Follow'),
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              color: theme.colorScheme.background,
                              child: Wrap(
                                spacing: 4.0,
                                runSpacing: 4.0,
                                children: [
                                  if (creator.attributes.twitter != null)
                                    createLinkChip(
                                        creator.attributes.twitter!, 'Twitter'),
                                  if (creator.attributes.pixiv != null)
                                    createLinkChip(
                                        creator.attributes.pixiv!, 'Pixiv'),
                                  if (creator.attributes.youtube != null)
                                    createLinkChip(
                                        creator.attributes.youtube!, 'Youtube'),
                                  if (creator.attributes.website != null)
                                    createLinkChip(
                                        creator.attributes.website!, 'website'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                  title: const Text(
                    'Works',
                    style: TextStyle(fontSize: 24),
                  ),
                  physics: const AlwaysScrollableScrollPhysics(),
                  controller: scrollController,
                  onAtEdge: () => ref
                      .read(creatorTitlesProvider(creator).notifier)
                      .getMore(),
                  children: [
                    MangaListViewSliver(items: value),
                  ],
                ),
              );
            }(),
          _ => const Stack(
              children: Styles.loadingOverlay,
            ),
        },
        if (isLoading) ...Styles.loadingOverlay,
      ],
    ));
  }
}
