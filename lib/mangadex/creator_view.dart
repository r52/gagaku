import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/mangadex/model/model.dart';
import 'package:gagaku/mangadex/model/types.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:gagaku/util/infinite_scroll.dart';
import 'package:gagaku/util/ui.dart';
import 'package:gpt_markdown/gpt_markdown.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

part 'creator_view.g.dart';

@riverpod
Future<CreatorType> _fetchCreatorFromId(Ref ref, String creatorId) async {
  final api = ref.watch(mangadexProvider);
  final creator = await api.fetchCreators(uuids: [creatorId]);
  return creator.first;
}

@RoutePage()
class MangaDexCreatorViewWithNamePage extends MangaDexCreatorViewPage {
  const MangaDexCreatorViewWithNamePage({
    super.key,
    @PathParam() required super.creatorId,
    @PathParam() this.name,
  });

  final String? name;
}

@RoutePage()
class MangaDexCreatorViewPage extends StatelessWidget {
  const MangaDexCreatorViewPage({
    super.key,
    @PathParam() required this.creatorId,
    this.creator,
  });

  final String creatorId;

  final CreatorType? creator;

  @override
  Widget build(BuildContext context) {
    if (creator != null) {
      return MangaDexCreatorViewWidget(creator: creator!);
    }

    return DataProviderWhenWidget(
      provider: _fetchCreatorFromIdProvider(creatorId),
      errorBuilder: (context, child) => Scaffold(body: child),
      builder: (context, data) {
        return MangaDexCreatorViewWidget(creator: data);
      },
    );
  }
}

class MangaDexCreatorViewWidget extends StatefulHookConsumerWidget {
  const MangaDexCreatorViewWidget({super.key, required this.creator});

  final CreatorType creator;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MangaDexCreatorViewWidgetState();
}

class _MangaDexCreatorViewWidgetState
    extends ConsumerState<MangaDexCreatorViewWidget> {
  static const info = MangaDexFeeds.creatorTitles;

  late final _pagingController = GagakuPagingController<int, Manga>(
    getNextPageKey:
        (state) => state.keys?.last != null ? state.keys!.last + info.limit : 0,
    fetchPage: (pageKey) async {
      final api = ref.watch(mangadexProvider);
      final list = await api.fetchMangaList(
        limit: info.limit,
        feedKey: info.key,
        offset: pageKey,
        entity: widget.creator,
      );

      final newItems = list.data.cast<Manga>();

      await ref.read(statisticsProvider.get)(newItems);

      return newItems;
    },
    refresh: () async {
      final api = ref.watch(mangadexProvider);
      await api.invalidateAll('${info.key}(${widget.creator.id}');
    },
  );

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();
    final theme = Theme.of(context);

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async => _pagingController.refresh(),
        child: MangaListWidget(
          leading: [
            SliverAppBar(
              pinned: true,
              snap: false,
              floating: false,
              leading: AutoLeadingButton(),
              flexibleSpace: GestureDetector(
                onTap: () {
                  scrollController.animateTo(
                    0.0,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                },
                child: TitleFlexBar(title: widget.creator.attributes.name),
              ),
            ),
            SliverList.list(
              children: [
                if (widget.creator.attributes.biography.isNotEmpty)
                  ExpansionTile(
                    title: Text(
                      'mangadex.creator.biography'.tr(context: context),
                    ),
                    children: [
                      for (final MapEntry(key: prop, value: desc)
                          in widget.creator.attributes.biography.entries)
                        ExpansionTile(
                          title: Text(prop),
                          children: [
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(8),
                              color: theme.colorScheme.surfaceContainerHighest,
                              child: GptMarkdown(
                                desc,
                                onLinkTab: (url, title) async {
                                  if (!await launchUrl(Uri.parse(url))) {
                                    throw 'Could not launch $url';
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                if (widget.creator.attributes.twitter != null ||
                    widget.creator.attributes.pixiv != null ||
                    widget.creator.attributes.youtube != null ||
                    widget.creator.attributes.website != null)
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
                            if (widget.creator.attributes.twitter != null)
                              _LinkChip(
                                url: widget.creator.attributes.twitter!,
                                text: 'Twitter',
                              ),
                            if (widget.creator.attributes.pixiv != null)
                              _LinkChip(
                                url: widget.creator.attributes.pixiv!,
                                text: 'Pixiv',
                              ),
                            if (widget.creator.attributes.youtube != null)
                              _LinkChip(
                                url: widget.creator.attributes.youtube!,
                                text: 'Youtube',
                              ),
                            if (widget.creator.attributes.website != null)
                              _LinkChip(
                                url: widget.creator.attributes.website!,
                                text: 'Website',
                              ),
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
          children: [MangaListViewSliver(controller: _pagingController)],
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
