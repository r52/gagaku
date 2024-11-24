import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:gagaku/mangadex/model/model.dart';
import 'package:gagaku/mangadex/model/types.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:gagaku/util/ui.dart';
import 'package:gagaku/util/util.dart';
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
    child = QueriedMangaDexCreatorViewWidget(creatorId: state.pathParameters['creatorId']!);
  }

  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: Styles.scaledSharedAxisTransitionBuilder,
  );
}

@riverpod
Future<CreatorType> _fetchCreatorFromId(Ref ref, String creatorId) async {
  final api = ref.watch(mangadexProvider);
  final creator = await api.fetchCreators([creatorId]);
  return creator.first;
}

@riverpod
Future<List<Manga>> _fetchCreatorTitles(Ref ref, CreatorType creator) async {
  final mangas = await ref.watch(creatorTitlesProvider(creator).future);
  await ref.read(statisticsProvider.notifier).get(mangas);

  ref.disposeAfter(const Duration(minutes: 5));

  return mangas;
}

class QueriedMangaDexCreatorViewWidget extends StatelessWidget {
  const QueriedMangaDexCreatorViewWidget({super.key, required this.creatorId});

  final String creatorId;

  @override
  Widget build(BuildContext context) {
    return DataProviderWhenWidget(
      provider: _fetchCreatorFromIdProvider(creatorId),
      errorBuilder: (context, child) => Scaffold(body: child),
      builder: (context, creator) {
        return MangaDexCreatorViewWidget(creator: creator);
      },
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
    final titleProvider = ref.watch(_fetchCreatorTitlesProvider(creator));
    final isLoading = titleProvider.isLoading && !titleProvider.isRefreshing;

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          ref.read(creatorTitlesProvider(creator).notifier).clear();
          return ref.refresh(_fetchCreatorTitlesProvider(creator).future);
        },
        child: DataProviderWhenWidget(
          provider: _fetchCreatorTitlesProvider(creator),
          data: titleProvider,
          builder: (context, mangas) {
            return MangaListWidget(
              leading: [
                SliverAppBar(
                  pinned: true,
                  snap: false,
                  floating: false,
                  leading: BackButton(
                    onPressed: () {
                      if (context.canPop()) {
                        context.pop();
                      } else {
                        context.go('/');
                      }
                    },
                  ),
                  flexibleSpace: GestureDetector(
                    onTap: () {
                      scrollController.animateTo(0.0,
                          duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
                    },
                    child: TitleFlexBar(title: creator.attributes.name),
                  ),
                ),
                SliverList.list(
                  children: [
                    if (creator.attributes.biography.isNotEmpty)
                      ExpansionTile(
                        title: Text('mangadex.creator.biography'.tr(context: context)),
                        children: [
                          for (final MapEntry(key: prop, value: desc) in creator.attributes.biography.entries)
                            ExpansionTile(
                              title: Text(prop),
                              children: [
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(8),
                                  color: theme.colorScheme.surfaceContainerHighest,
                                  child: MarkdownBody(
                                    data: desc,
                                    onTapLink: (text, url, title) async {
                                      if (url != null) {
                                        if (!await launchUrl(Uri.parse(url))) {
                                          throw 'Could not launch $url';
                                        }
                                      }
                                    },
                                  ),
                                ),
                              ],
                            )
                        ],
                      ),
                    if (creator.attributes.twitter != null ||
                        creator.attributes.pixiv != null ||
                        creator.attributes.youtube != null ||
                        creator.attributes.website != null)
                      ExpansionTile(
                        expandedAlignment: Alignment.centerLeft,
                        title: Text('mangadex.creator.follow'.tr(context: context)),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Wrap(
                              spacing: 4.0,
                              runSpacing: 4.0,
                              children: [
                                if (creator.attributes.twitter != null)
                                  _LinkChip(url: creator.attributes.twitter!, text: 'Twitter'),
                                if (creator.attributes.pixiv != null)
                                  _LinkChip(url: creator.attributes.pixiv!, text: 'Pixiv'),
                                if (creator.attributes.youtube != null)
                                  _LinkChip(url: creator.attributes.youtube!, text: 'Youtube'),
                                if (creator.attributes.website != null)
                                  _LinkChip(url: creator.attributes.website!, text: 'Website'),
                              ],
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ],
              title: Text(
                'mangadex.creator.works'.tr(context: context),
                style: TextStyle(fontSize: 24),
              ),
              physics: const AlwaysScrollableScrollPhysics(),
              controller: scrollController,
              onAtEdge: () => ref.read(creatorTitlesProvider(creator).notifier).getMore(),
              isLoading: isLoading,
              children: [
                if (mangas.isEmpty)
                  SliverToBoxAdapter(
                    child: Center(
                      child: Text('errors.notitles'.tr(context: context)),
                    ),
                  ),
                MangaListViewSliver(items: mangas),
              ],
            );
          },
          loadingBuilder: (_, progress) => LoadingOverlayStack(
            progress: progress?.toDouble(),
          ),
        ),
      ),
    );
  }
}

class _LinkChip extends StatelessWidget {
  final String text;
  final String url;

  const _LinkChip({required this.text, required this.url});

  @override
  Widget build(BuildContext context) {
    return ButtonChip(
      onPressed: () async {
        if (!await launchUrl(Uri.parse(url))) {
          throw 'Could not launch $url';
        }
      },
      text: text,
    );
  }
}
