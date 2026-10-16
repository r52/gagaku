import 'package:material_ui/material_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/mangadex/model/model.dart';
import 'package:gagaku/mangadex/model/types.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:gagaku/util/detail_scaffold.dart';
import 'package:gagaku/util/material_hooks.dart';
import 'package:gagaku/util/ui.dart';
import 'package:gagaku/util/util.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'creator_view.g.dart';

@Riverpod(retry: noRetry)
Future<CreatorType> _fetchCreatorFromId(Ref ref, String creatorId) async {
  final api = ref.watch(mangadexProvider);
  final creator = await api.fetchCreators(uuids: [creatorId]);
  return creator.first;
}

class MangaDexCreatorViewPage extends StatelessWidget {
  const MangaDexCreatorViewPage({
    super.key,
    required this.creatorId,
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
      loadingBuilder: (context, progress) => Scaffold(
        appBar: AppBar(leading: const BackButton()),
        body: Center(
          child: CircularProgressIndicator(value: progress?.toDouble()),
        ),
      ),
      errorBuilder: (context, child, _, _) => Scaffold(
        appBar: AppBar(leading: const BackButton()),
        body: child,
      ),
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
  late final _works = EntityTitlesPager(
    ref: ref,
    info: MangaDexFeeds.creatorTitles,
    entity: widget.creator,
  );

  @override
  void dispose() {
    _works.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tr = context.t;
    final tabController = useMaterialTabController(initialLength: 1);
    final scrollController = useScrollController();

    return DetailScaffold(
      title: widget.creator.attributes.name,
      metadata: _CreatorInfo(creator: widget.creator),
      tabController: tabController,
      tabs: [
        DetailTab(
          label: tr.mangadex.creator.works,
          scrollToTop: true,
          // A single tab has no tab bar, so the list carries the heading.
          body: MangaListWidget(
            title: Text(
              tr.mangadex.creator.works,
              style: CommonTextStyles.twentyfour,
            ),
            physics: const AlwaysScrollableScrollPhysics(),
            noController: true,
            children: [MangaListViewSliver(controller: _works.controller)],
          ),
        ),
      ],
      onRefresh: _works.refresh,
      scrollController: scrollController,
    );
  }
}

class _CreatorInfo extends StatelessWidget {
  const _CreatorInfo({required this.creator});

  final CreatorType creator;

  @override
  Widget build(BuildContext context) {
    final tr = context.t;
    final theme = Theme.of(context);
    final attributes = creator.attributes;
    final biography = attributes.biography;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (biography.isNotEmpty)
          ExpansionTile(
            initiallyExpanded: true,
            title: Text(tr.mangadex.creator.biography),
            children: [
              for (final MapEntry(key: prop, value: desc) in biography.entries)
                ExpansionTile(
                  // Several translations would push the works far down.
                  initiallyExpanded: biography.length == 1,
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
                            await Styles.tryLaunchUrl(context, url);
                          }
                        },
                      ),
                    ),
                  ],
                ),
            ],
          ),
        if (attributes.twitter != null ||
            attributes.pixiv != null ||
            attributes.youtube != null ||
            attributes.website != null)
          ExpansionTile(
            initiallyExpanded: true,
            expandedAlignment: Alignment.centerLeft,
            title: Text(tr.mangadex.creator.follow),
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Wrap(
                  spacing: 4.0,
                  runSpacing: 4.0,
                  children: [
                    if (attributes.twitter != null)
                      _LinkChip(
                        url: attributes.twitter!,
                        text: tr.tracking.twitter,
                      ),
                    if (attributes.pixiv != null)
                      _LinkChip(
                        url: attributes.pixiv!,
                        text: tr.tracking.pixiv,
                      ),
                    if (attributes.youtube != null)
                      _LinkChip(
                        url: attributes.youtube!,
                        text: tr.tracking.youtube,
                      ),
                    if (attributes.website != null)
                      _LinkChip(
                        url: attributes.website!,
                        text: tr.tracking.website,
                      ),
                  ],
                ),
              ),
            ],
          ),
      ],
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
        await Styles.tryLaunchUrl(context, url);
      },
      text: text,
    );
  }
}
