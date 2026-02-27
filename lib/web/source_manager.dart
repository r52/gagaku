import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:expansion_tile_list/expansion_tile_list.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/model/common.dart';
import 'package:gagaku/model/model.dart';
import 'package:gagaku/util/ui.dart';
import 'package:gagaku/util/util.dart';
import 'package:gagaku/web/model/model.dart';
import 'package:gagaku/web/settings.dart';
import 'package:gagaku/web/model/types.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/experimental/scope.dart';

@Dependencies([chipTextStyle])
class SourceManager extends HookConsumerWidget {
  const SourceManager({super.key});

  Future<Map<RepoData, List<SourceVersion>>> fetchRepo(
    List<RepoInfo> repoList,
  ) async {
    final list = <RepoData, List<SourceVersion>>{};

    for (final repo in repoList) {
      final uri = Uri.parse('${repo.url}/versioning.json');
      final response = await http.get(uri);

      try {
        final data = Versioning.fromJson(json.decode(response.body));

        if (data.builtWith.types.startsWith(SupportedVersion.v0_9.version) &&
            data.sources.isNotEmpty) {
          final version = SupportedVersion.values.firstWhere(
            (v) => data.builtWith.types.startsWith(v.version),
          );

          final sources = data.sources
              .map(
                (e) => switch (version) {
                  SupportedVersion.v0_9 => SourceVersion09.fromJson(e),
                }
              )
              .toList();

          list.addEntries([
            MapEntry(
              RepoData.fromInfo(
                repo,
                SupportedVersion.values.firstWhere(
                  (v) => data.builtWith.types.startsWith(v.version),
                ),
              ),
              sources,
            ),
          ]);
        }
      } catch (e) {
        logger.w('Error parsing ${repo.url}/versioning.json', error: e);
      }
    }

    return list;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tr = context.t;
    final theme = Theme.of(context);
    final nav = Navigator.of(context);
    final forceRefresh = useState(0);
    final repoBox = GagakuData().store.box<RepoInfo>();
    final repo = useMemoized(() => fetchRepo(repoBox.getAll()), [
      forceRefresh.value,
    ]);
    final availableSources = useFuture(repo);

    final sourcesBox = GagakuData().store.box<WebSourceInfo>();
    final installed = ref.watch(
      installedSourcesProvider.select(
        (value) => switch (value) {
          AsyncValue<List<WebSourceInfo>>(value: final data?) => data,
          _ => <WebSourceInfo>[],
        },
      ),
    );

    Widget body;

    if (availableSources.connectionState == ConnectionState.waiting ||
        !availableSources.hasData) {
      body = const CircularProgressIndicator();
    } else if (availableSources.hasError) {
      body = ErrorList(
        error: availableSources.error!,
        stackTrace: availableSources.stackTrace!,
      );
    } else {
      final orphaned = [...installed];
      body = installed.isEmpty && availableSources.data!.isEmpty
          ? Center(child: Text(tr.webSources.source.noDataWarning))
          : ExpansionTileList(
              children: [
                for (final MapEntry(key: repo, value: list)
                    in availableSources.data!.entries)
                  ExpansionTile(
                    title: Text(repo.name),
                    leading: Icon(Icons.rss_feed),
                    maintainState: true,
                    shape: const Border(),
                    trailing: const Icon(Icons.keyboard_arrow_down, size: 20),
                    children: list.map((source) {
                      final match = installed.firstWhereOrNull(
                        (e) => e.repo == repo.url && e.id == source.id,
                      );
                      final isInstalled = match != null;
                      final icon = '${repo.url}/${source.getIconPath()}';

                      final capabilities = source.getCapabilities();

                      final supportedSource = capabilities.contains(
                        SourceIntents.mangaChapters,
                      );

                      final cfRequired = capabilities.contains(
                        SourceIntents.cloudflareBypassRequired,
                      );

                      if (isInstalled) {
                        orphaned.removeWhere(
                          (e) => e.repo == repo.url && e.id == source.id,
                        );
                      }

                      return Card(
                        key: ValueKey('${repo.url}/${source.id}'),
                        child: _SourceItem(
                          thumbnail: Image.network(icon),
                          title: source.name,
                          subtitle: source.getDescription(),
                          author: source.getAuthor(),
                          version: source.version,
                          badges: source.getBadges(),
                          cfRequired: cfRequired,
                          trailing: supportedSource
                              ? Switch(
                                  activeTrackColor: Colors.green,
                                  value: isInstalled,
                                  onChanged: (value) async {
                                    final messenger = ScaffoldMessenger.of(
                                      context,
                                    );

                                    if (value) {
                                      sourcesBox.put(
                                        WebSourceInfo(
                                          id: source.id,
                                          name: source.name,
                                          repo: repo.url,
                                          baseUrl: source.getBaseUrl(),
                                          version: repo.version,
                                          icon: icon,
                                          capabilities: capabilities,
                                        ),
                                      );

                                      messenger
                                        ..removeCurrentSnackBar()
                                        ..showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              tr.webSources.source.sourceAddOK,
                                            ),
                                            backgroundColor: Colors.green,
                                          ),
                                        );
                                    } else {
                                      if (match != null) {
                                        sourcesBox.remove(match.dbid);
                                      }

                                      ref.invalidate(
                                        extensionSourceProvider(source.id),
                                      );

                                      messenger
                                        ..removeCurrentSnackBar()
                                        ..showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              tr
                                                  .webSources
                                                  .source
                                                  .sourceDeleteOK,
                                            ),
                                            backgroundColor: Colors.green,
                                          ),
                                        );
                                    }
                                  },
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(
                                    top: 5.0,
                                    right: 10.0,
                                  ),
                                  child: Tooltip(
                                    message: tr.errors.unsupportedSource,
                                    triggerMode: TooltipTriggerMode.tap,
                                    child: Icon(
                                      Icons.error,
                                      color: theme.colorScheme.error,
                                    ),
                                  ),
                                ),
                        ),
                      );
                    }).toList(),
                  ),
                if (orphaned.isNotEmpty)
                  ExpansionTile(
                    title: Text(tr.webSources.repo.missingRepo),
                    leading: Icon(Icons.question_mark),
                    maintainState: true,
                    shape: const Border(),
                    trailing: const Icon(Icons.keyboard_arrow_down, size: 20),
                    children: orphaned.map((item) {
                      final actions = <Widget>[
                        IconButton(
                          tooltip: tr.webSources.source.delete(arg: item.name),
                          onPressed: () {
                            final messenger = ScaffoldMessenger.of(context);
                            sourcesBox.remove(item.dbid);
                            ref.invalidate(extensionSourceProvider(item.id));

                            messenger
                              ..removeCurrentSnackBar()
                              ..showSnackBar(
                                SnackBar(
                                  content: Text(
                                    tr.webSources.source.sourceDeleteOK,
                                  ),
                                  backgroundColor: Colors.green,
                                ),
                              );
                          },
                          icon: const Icon(Icons.delete, color: Colors.red),
                        ),
                      ];

                      return Card(
                        key: ValueKey(item.id),
                        child: ListTile(
                          leading: item.icon.isNotEmpty
                              ? Image.network(item.icon, width: 36, height: 36)
                              : const Icon(Icons.rss_feed),
                          title: Text(item.name),
                          subtitle: Text(item.repo),
                          trailing: OverflowBar(children: actions),
                        ),
                      );
                    }).toList(),
                  ),
              ],
            );
    }

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: TitleFlexBar(title: tr.webSources.source.manager),
        actions: [
          IconButton(
            color: theme.colorScheme.onPrimaryContainer,
            onPressed: () {
              forceRefresh.value += 1;
            },
            icon: const Icon(Icons.refresh),
            tooltip: tr.webSources.source.refresh,
          ),
          IconButton(
            color: theme.colorScheme.onPrimaryContainer,
            onPressed: () => nav.push(WebSourceSettingsRouteBuilder()),
            icon: const Icon(Icons.settings),
            tooltip: tr.arg_settings(arg: tr.webSources.text),
          ),
        ],
      ),
      body: body,
    );
  }
}

@Dependencies([chipTextStyle])
class _SourceItem extends StatelessWidget {
  const _SourceItem({
    required this.thumbnail,
    required this.title,
    required this.subtitle,
    required this.author,
    required this.version,
    required this.badges,
    this.cfRequired = false,
    this.trailing,
  });

  final Widget thumbnail;
  final String title;
  final String subtitle;
  final String author;
  final String version;
  final List<SourceBadge> badges;
  final bool cfRequired;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final tr = context.t;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        height: 100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(aspectRatio: 1.0, child: thumbnail),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 0.0),
                child: _SourceDescription(
                  title: title,
                  subtitle: subtitle,
                  author: author,
                  version: version,
                  badges: badges,
                ),
              ),
            ),
            if (cfRequired)
              Padding(
                padding: const EdgeInsets.only(top: 5.0, right: 5.0),
                child: Tooltip(
                  message: tr.webSources.cfRequired,
                  triggerMode: TooltipTriggerMode.tap,
                  child: Icon(Icons.warning),
                ),
              ),
            ?trailing,
          ],
        ),
      ),
    );
  }
}

@Dependencies([chipTextStyle])
class _SourceDescription extends StatelessWidget {
  const _SourceDescription({
    required this.title,
    required this.subtitle,
    required this.author,
    required this.version,
    required this.badges,
  });

  final String title;
  final String subtitle;
  final String author;
  final String version;
  final List<SourceBadge> badges;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: CommonTextStyles.defaultBold,
        ),
        const Padding(padding: EdgeInsets.only(bottom: 2.0)),
        Expanded(
          child: Text(
            subtitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: CommonTextStyles.twelve,
          ),
        ),
        Text('by $author, v$version', style: CommonTextStyles.twelve),
        if (badges.isNotEmpty)
          Row(
            children: badges
                .map(
                  (e) => IconTextChip(
                    text: e.label,
                    color: HexColor.fromHex(e.backgroundColor),
                    style: TextStyle(color: HexColor.fromHex(e.textColor)),
                  ),
                )
                .toList(),
          ),
      ],
    );
  }
}
