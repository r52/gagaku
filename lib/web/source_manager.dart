import 'dart:convert';

import 'package:expansion_tile_list/expansion_tile_list.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/util/ui.dart';
import 'package:gagaku/web/model/config.dart';
import 'package:gagaku/web/model/model.dart';
import 'package:gagaku/web/settings.dart';
import 'package:gagaku/web/model/types.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

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

        if (SupportedVersion.values.any(
              (v) => data.builtWith.types.startsWith(v.version),
            ) &&
            data.sources.isNotEmpty) {
          list.addEntries([
            MapEntry(
              RepoData.fromInfo(
                repo,
                SupportedVersion.values.firstWhere(
                  (v) => data.builtWith.types.startsWith(v.version),
                ),
              ),
              data.sources,
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
    final nav = Navigator.of(context);
    final forceRefresh = useState(0);
    final cfg = ref.watch(webConfigProvider);
    final repo = useMemoized(() => fetchRepo(cfg.repoList), [
      cfg.repoList,
      forceRefresh.value,
    ]);
    final availableSources = useFuture(repo);

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
      final installed = cfg.installedSources;
      final orphaned = [...installed];
      body =
          installed.isEmpty && availableSources.data!.isEmpty
              ? Center(child: Text(tr.webSources.source.noDataWarning))
              : SingleChildScrollView(
                child: ExpansionTileList(
                  children: [
                    for (final MapEntry(key: repo, value: list)
                        in availableSources.data!.entries)
                      ExpansionTile(
                        title: Text(repo.name),
                        leading: Icon(Icons.rss_feed),
                        maintainState: true,
                        shape: const Border(),
                        trailing: const Icon(
                          Icons.keyboard_arrow_down,
                          size: 20,
                        ),
                        children:
                            list.map((source) {
                              final isInstalled =
                                  installed.indexWhere(
                                    (e) =>
                                        e.repo == repo.url && e.id == source.id,
                                  ) !=
                                  -1;
                              final icon =
                                  '${repo.url}/${source.id}/includes/${source.icon}';
                              final supportedSource =
                                  source.intents != null &&
                                  (source.intents! &
                                          SourceIntents.mangaChapters.flag) ==
                                      0x1;

                              if (isInstalled) {
                                orphaned.removeWhere(
                                  (e) =>
                                      e.repo == repo.url && e.id == source.id,
                                );
                              }

                              return Card(
                                key: ValueKey('${repo.url}/${source.id}'),
                                child: _SourceItem(
                                  thumbnail: Image.network(icon),
                                  title: source.name,
                                  subtitle: source.desc,
                                  author: source.author,
                                  version: source.version,
                                  tags: source.tags,
                                  trailing:
                                      supportedSource
                                          ? Switch(
                                            activeTrackColor: Colors.green,
                                            value: isInstalled,
                                            onChanged: (value) {
                                              final messenger =
                                                  ScaffoldMessenger.of(context);

                                              if (value) {
                                                ref.read(
                                                  webConfigProvider.saveWith,
                                                )(
                                                  installedSources: [
                                                    ...cfg.installedSources,
                                                    WebSourceInfo(
                                                      id: source.id,
                                                      name: source.name,
                                                      baseUrl:
                                                          source.websiteBaseURL,
                                                      repo: repo.url,
                                                      version: repo.version,
                                                      icon: icon,
                                                      capabilities:
                                                          source
                                                              .getCapabilities(),
                                                    ),
                                                  ],
                                                );

                                                messenger
                                                  ..removeCurrentSnackBar()
                                                  ..showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        tr
                                                            .webSources
                                                            .source
                                                            .sourceAddOK,
                                                      ),
                                                      backgroundColor:
                                                          Colors.green,
                                                    ),
                                                  );
                                              } else {
                                                ref.invalidate(
                                                  extensionSourceProvider(
                                                    source.id,
                                                  ),
                                                );
                                                ref.read(
                                                  webConfigProvider.saveWith,
                                                )(
                                                  installedSources: [
                                                    ...cfg.installedSources,
                                                  ]..removeWhere(
                                                    (e) =>
                                                        e.id == source.id &&
                                                        e.repo == repo.url,
                                                  ),
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
                                                      backgroundColor:
                                                          Colors.green,
                                                    ),
                                                  );
                                              }
                                            },
                                          )
                                          : Tooltip(
                                            message:
                                                tr.errors.unsupportedSource,
                                            child: Icon(Icons.error),
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
                        trailing: const Icon(
                          Icons.keyboard_arrow_down,
                          size: 20,
                        ),
                        children:
                            orphaned.map((item) {
                              final actions = <Widget>[
                                IconButton(
                                  tooltip: tr.webSources.source.delete(
                                    arg: item.name,
                                  ),
                                  onPressed: () {
                                    final messenger = ScaffoldMessenger.of(
                                      context,
                                    );
                                    ref.invalidate(
                                      extensionSourceProvider(item.id),
                                    );
                                    ref.read(webConfigProvider.saveWith)(
                                      installedSources: [
                                        ...cfg.installedSources,
                                      ]..removeWhere(
                                        (e) =>
                                            e.id == item.id &&
                                            e.repo == item.repo,
                                      ),
                                    );

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
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                              ];

                              return Card(
                                key: ValueKey(item.id),
                                child: ListTile(
                                  leading:
                                      item.icon.isNotEmpty
                                          ? Image.network(
                                            item.icon,
                                            width: 36,
                                            height: 36,
                                          )
                                          : const Icon(Icons.rss_feed),
                                  title: Text(item.name),
                                  subtitle: Text(item.repo),
                                  trailing: OverflowBar(children: actions),
                                ),
                              );
                            }).toList(),
                      ),
                  ],
                ),
              );
    }

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: TitleFlexBar(title: tr.webSources.source.manager),
        actions: [
          IconButton(
            onPressed: () {
              forceRefresh.value += 1;
            },
            icon: const Icon(Icons.refresh),
            tooltip: tr.webSources.source.refresh,
          ),
          IconButton(
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

class _SourceItem extends StatelessWidget {
  const _SourceItem({
    required this.thumbnail,
    required this.title,
    required this.subtitle,
    required this.author,
    required this.version,
    this.tags,
    this.trailing,
  });

  final Widget thumbnail;
  final String title;
  final String subtitle;
  final String author;
  final String version;
  final List<Badge>? tags;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
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
                  tags: tags,
                ),
              ),
            ),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}

class _SourceDescription extends StatelessWidget {
  const _SourceDescription({
    required this.title,
    required this.subtitle,
    required this.author,
    required this.version,
    this.tags,
  });

  final String title;
  final String subtitle;
  final String author;
  final String version;
  final List<Badge>? tags;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const Padding(padding: EdgeInsets.only(bottom: 2.0)),
        Expanded(
          child: Text(
            subtitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12.0),
          ),
        ),
        Text('by $author, v$version', style: const TextStyle(fontSize: 12.0)),
        if (tags != null)
          Row(
            children:
                tags!
                    .map(
                      (e) => IconTextChip(
                        text: e.text,
                        color: e.type.color,
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                    .toList(),
          ),
      ],
    );
  }
}
