import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/model/model.dart';
import 'package:gagaku/util/ui.dart';
import 'package:gagaku/util/util.dart';
import 'package:gagaku/web/model/model.dart';
import 'package:gagaku/web/repo_list.dart';
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

        if (data.builtWith.types.startsWith(SupportedVersion.v0_9.version) &&
            data.sources.isNotEmpty) {
          final version = SupportedVersion.values.firstWhere(
            (v) => data.builtWith.types.startsWith(v.version),
          );

          final sources = data.sources
              .map(
                (e) => switch (version) {
                  SupportedVersion.v0_9 => SourceVersion09.fromJson(e),
                },
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
    final searchController = useTextEditingController();
    final searchValue = useValueListenable(searchController);

    final repoBox = GagakuData().store.box<RepoInfo>();
    final repoNamesByUrl = useMemoized(
      () => {for (final r in repoBox.getAll()) r.url: r.name},
      [forceRefresh.value],
    );

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

    final isSearching = searchValue.text.isNotEmpty;
    final query = searchValue.text.toLowerCase();

    // Filter available repos
    final filteredAvailable = <RepoData, List<SourceVersion>>{};
    if (availableSources.hasData) {
      for (final entry in availableSources.data!.entries) {
        final r = entry.key;
        final list = entry.value;
        final filteredList = query.isEmpty
            ? list
            : list
                  .where(
                    (s) =>
                        s.name.toLowerCase().contains(query) ||
                        s.getDescription().toLowerCase().contains(query),
                  )
                  .toList();

        if (filteredList.isNotEmpty) {
          filteredAvailable[r] = filteredList;
        }
      }
    }

    // Filter installed
    final filteredInstalled = query.isEmpty
        ? installed
        : installed.where((e) => e.name.toLowerCase().contains(query)).toList();

    List<Widget> slivers = [
      SliverAppBar(
        floating: true,
        pinned: true,
        title: Text(tr.webSources.source.manager),
        actions: [
          IconButton(
            color: theme.colorScheme.onPrimaryContainer,
            onPressed: () async {
              await nav.push(
                SlideTransitionRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const RepoListManager(),
                ),
              );
              forceRefresh.value += 1;
            },
            icon: const Icon(Icons.library_add),
            tooltip: tr.webSources.repo.manage,
          ),
          IconButton(
            color: theme.colorScheme.onPrimaryContainer,
            onPressed: () {
              forceRefresh.value += 1;
            },
            icon: const Icon(Icons.refresh),
            tooltip: tr.webSources.source.refresh,
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 12.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: tr.search.text,
                prefixIcon: const Icon(Icons.search),
                suffixIcon: isSearching
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: searchController.clear,
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                isDense: true,
              ),
            ),
          ),
        ),
      ),
    ];

    if (availableSources.connectionState == ConnectionState.waiting &&
        !availableSources.hasData) {
      slivers.add(
        const SliverFillRemaining(
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    } else if (availableSources.hasError) {
      slivers.add(
        SliverFillRemaining(
          child: ErrorList(
            error: availableSources.error!,
            stackTrace: availableSources.stackTrace!,
          ),
        ),
      );
    } else {
      if (filteredInstalled.isNotEmpty) {
        slivers.add(
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
              ),
              child: Text(
                'Installed',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );

        slivers.add(
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final item = filteredInstalled[index];
              final repoName = repoNamesByUrl[item.repo] ?? item.repo;

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
                          content: Text(tr.webSources.source.sourceDeleteOK),
                          backgroundColor: Colors.green,
                        ),
                      );
                  },
                  icon: const Icon(Icons.delete, color: Colors.red),
                ),
              ];

              return Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 4.0,
                ),
                key: ValueKey('installed-${item.id}'),
                child: ListTile(
                  leading: item.icon.isNotEmpty
                      ? Image.network(
                          item.icon,
                          width: 36,
                          height: 36,
                          errorBuilder: (c, e, s) =>
                              const Icon(Icons.extension),
                        )
                      : const Icon(Icons.extension),
                  title: Text(
                    item.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    repoName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: OverflowBar(children: actions),
                ),
              );
            }, childCount: filteredInstalled.length),
          ),
        );
      }

      if (filteredAvailable.isNotEmpty) {
        slivers.add(
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 16.0,
              ).copyWith(bottom: 8.0),
              child: Text(
                'Available',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );

        slivers.add(
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final repoEntry = filteredAvailable.entries.elementAt(index);
              final repo = repoEntry.key;
              final sources = repoEntry.value;

              return ExpansionTile(
                title: Text(repo.name),
                leading: const Icon(Icons.library_books),
                initiallyExpanded: isSearching,
                maintainState: true,
                shape: const Border(),
                children: sources.map((source) {
                  final isInstalledId = installed.firstWhereOrNull(
                    (e) => e.id == source.id,
                  );
                  final isExactInstalled =
                      isInstalledId != null && isInstalledId.repo == repo.url;
                  final hasConflict =
                      isInstalledId != null && !isExactInstalled;

                  final icon = '${repo.url}/${source.getIconPath()}';
                  final capabilities = source.getCapabilities();
                  final supportedSource = capabilities.contains(
                    SourceIntents.mangaChapters,
                  );
                  final cfRequired = capabilities.contains(
                    SourceIntents.cloudflareBypassRequired,
                  );

                  Widget trailing;
                  final compactBtnStyle = FilledButton.styleFrom(
                    visualDensity: VisualDensity.compact,
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    textStyle: const TextStyle(fontSize: 13),
                  );

                  if (!supportedSource) {
                    trailing = Tooltip(
                      message: tr.errors.unsupportedSource,
                      triggerMode: TooltipTriggerMode.tap,
                      child: Icon(Icons.error, color: theme.colorScheme.error),
                    );
                  } else if (isExactInstalled) {
                    trailing = FilledButton.tonalIcon(
                      style: compactBtnStyle,
                      onPressed: () {
                        sourcesBox.remove(isInstalledId.dbid);
                        ref.invalidate(extensionSourceProvider(source.id));
                        ScaffoldMessenger.of(context)
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
                      icon: const Icon(Icons.delete, size: 18),
                      label: const Text('Remove'),
                    );
                  } else if (hasConflict) {
                    trailing = FilledButton.icon(
                      style: compactBtnStyle.copyWith(
                        backgroundColor: WidgetStateProperty.all(Colors.orange),
                        foregroundColor: WidgetStateProperty.all(Colors.white),
                      ),
                      onPressed: () {
                        sourcesBox.remove(isInstalledId.dbid);
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
                        ref.invalidate(extensionSourceProvider(source.id));
                        ScaffoldMessenger.of(context)
                          ..removeCurrentSnackBar()
                          ..showSnackBar(
                            SnackBar(
                              content: Text(tr.webSources.source.sourceAddOK),
                              backgroundColor: Colors.green,
                            ),
                          );
                      },
                      icon: const Icon(Icons.sync, size: 18),
                      label: const Text('Replace'),
                    );
                  } else {
                    trailing = FilledButton.icon(
                      style: compactBtnStyle,
                      onPressed: () {
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
                        ScaffoldMessenger.of(context)
                          ..removeCurrentSnackBar()
                          ..showSnackBar(
                            SnackBar(
                              content: Text(tr.webSources.source.sourceAddOK),
                              backgroundColor: Colors.green,
                            ),
                          );
                      },
                      icon: const Icon(Icons.download, size: 18),
                      label: const Text('Install'),
                    );
                  }

                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 4.0,
                    ),
                    key: ValueKey('${repo.url}/${source.id}'),
                    child: _SourceItem(
                      thumbnail: Image.network(
                        icon,
                        fit: BoxFit.cover,
                        errorBuilder: (c, e, s) =>
                            const Icon(Icons.extension, size: 32),
                      ),
                      title: source.name,
                      subtitle: source.getDescription(),
                      author: source.getAuthor(),
                      version: source.version,
                      badges: source.getBadges(),
                      cfRequired: cfRequired,
                      trailing: trailing,
                    ),
                  );
                }).toList(),
              );
            }, childCount: filteredAvailable.length),
          ),
        );
      }

      if (filteredInstalled.isEmpty && filteredAvailable.isEmpty) {
        slivers.add(
          SliverFillRemaining(
            hasScrollBody: false,
            child: Center(child: Text(tr.webSources.source.noDataWarning)),
          ),
        );
      }
    }

    return Scaffold(body: CustomScrollView(slivers: slivers));
  }
}

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
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 56,
                height: 56,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: thumbnail,
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: _SourceDescription(
                  title: title,
                  subtitle: subtitle,
                  author: author,
                  version: version,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Wrap(
                  spacing: 4.0,
                  runSpacing: 4.0,
                  children: badges
                      .map(
                        (e) => IconTextChip(
                          text: e.label,
                          color: HexColor.fromHex(e.backgroundColor),
                          style: TextStyle(
                            color: HexColor.fromHex(e.textColor),
                            fontSize: 10.0,
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              if (cfRequired || trailing != null)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (cfRequired)
                      Padding(
                        padding: EdgeInsets.only(
                          right: trailing != null ? 8.0 : 0.0,
                        ),
                        child: Tooltip(
                          message: tr.webSources.cfRequired,
                          triggerMode: TooltipTriggerMode.tap,
                          child: const Icon(Icons.warning, color: Colors.amber),
                        ),
                      ),
                    ?trailing,
                  ],
                ),
            ],
          ),
        ],
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
  });

  final String title;
  final String subtitle;
  final String author;
  final String version;

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
        const SizedBox(height: 2.0),
        Text(
          subtitle,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: CommonTextStyles.twelve,
        ),
        const SizedBox(height: 4.0),
        Text('by $author, v$version', style: CommonTextStyles.twelve),
      ],
    );
  }
}
