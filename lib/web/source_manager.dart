import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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

  Future<Map<String, RepoInfo>> fetchRepo(List<String> repoList) async {
    final list = <String, RepoInfo>{};

    for (final repo in repoList) {
      final uri = Uri.parse(repo);
      final response = await http.get(uri);

      try {
        final data = json.decode(response.body) as List<dynamic>;

        if (data.isNotEmpty) {
          final entries = data.map((e) {
            final source = RepoInfo.fromJson(e);
            final key = Uri.parse(source.url).pathSegments.last;
            return MapEntry(key, source);
          });

          list.addEntries(entries);
        }
      } catch (e) {
        logger.w('Error parsing $repo', error: e);
      }
    }

    return list;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nav = Navigator.of(context);
    final forceRefresh = useState(0);
    final cfg = ref.watch(webConfigProvider);
    final repo = useMemoized(() => fetchRepo(cfg.repoList), [cfg.repoList, forceRefresh.value]);
    final availableSources = useFuture(repo);

    final sources = ref.watch(webSourceManagerProvider);

    Widget body;

    if (cfg.sourceDirectory.isEmpty) {
      body = const Text('Please set a directory for source storage.');
    } else if (sources is AsyncLoading ||
        availableSources.connectionState == ConnectionState.waiting ||
        !availableSources.hasData) {
      body = const CircularProgressIndicator();
    } else if (sources.hasError || availableSources.hasError) {
      body = ErrorList(
        error: (sources.hasError) ? sources.asError!.error : availableSources.error!,
        stackTrace: (sources.hasError) ? sources.asError!.stackTrace : availableSources.stackTrace!,
      );
    } else {
      final srcMgr = sources.value;
      if (srcMgr != null && availableSources.data!.isEmpty) {
        body = Column(
          children: [
            const Text('No repo data. Showing installed sources only'),
            Expanded(
              child: srcMgr.sources.isEmpty
                  ? const Center(child: Text('No installed sources'))
                  : ListView.builder(
                      itemCount: srcMgr.sources.length,
                      itemBuilder: (context, index) {
                        final item = srcMgr.sources.entries.elementAt(index);

                        final actions = <Widget>[
                          IconButton(
                            tooltip: 'Delete ${item.value.name}',
                            onPressed: () {
                              final messenger = ScaffoldMessenger.of(context);
                              ref.read(webSourceManagerProvider.notifier).removeSource(item.key).then((_) {
                                messenger
                                  ..removeCurrentSnackBar()
                                  ..showSnackBar(
                                    const SnackBar(
                                      content: Text('Source deleted'),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                              });
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ];

                        String version = 'v${item.value.version}';

                        return Card(
                          key: ValueKey(item.key),
                          child: ListTile(
                            leading: const Icon(Icons.rss_feed),
                            title: Text(item.key),
                            subtitle: Text(version),
                            trailing: OverflowBar(
                              children: actions,
                            ),
                          ),
                        );
                      },
                    ),
            )
          ],
        );
      } else {
        body = ListView.builder(
          itemCount: availableSources.data!.length,
          itemBuilder: (context, index) {
            final item = availableSources.data!.entries.elementAt(index);

            final actions = <Widget>[];

            if (srcMgr != null && srcMgr.sources.containsKey(item.key)) {
              actions.addAll([
                IconButton(
                  tooltip: 'Update/Replace ${item.value.name}',
                  onPressed: () {
                    final messenger = ScaffoldMessenger.of(context);
                    ref.read(webSourceManagerProvider.notifier).updateSource(item.key, item.value).then((_) {
                      messenger
                        ..removeCurrentSnackBar()
                        ..showSnackBar(
                          const SnackBar(
                            content: Text('Source updated'),
                            backgroundColor: Colors.green,
                          ),
                        );
                    });
                  },
                  icon: const Icon(
                    Icons.refresh,
                    color: Colors.orange,
                  ),
                ),
                IconButton(
                  tooltip: 'Delete ${item.value.name}',
                  onPressed: () {
                    final messenger = ScaffoldMessenger.of(context);
                    ref.read(webSourceManagerProvider.notifier).removeSource(item.key).then((_) {
                      messenger
                        ..removeCurrentSnackBar()
                        ..showSnackBar(
                          const SnackBar(
                            content: Text('Source deleted'),
                            backgroundColor: Colors.green,
                          ),
                        );
                    });
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ]);
            } else {
              actions.addAll([
                IconButton(
                  tooltip: 'Add ${item.value.name}',
                  onPressed: () {
                    final messenger = ScaffoldMessenger.of(context);
                    ref.read(webSourceManagerProvider.notifier).addSource(item.key, item.value).then((_) {
                      messenger
                        ..removeCurrentSnackBar()
                        ..showSnackBar(
                          const SnackBar(
                            content: Text('Source added'),
                            backgroundColor: Colors.green,
                          ),
                        );
                    });
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.green,
                  ),
                ),
              ]);
            }

            String version = 'v${item.value.version}';
            if (srcMgr != null && srcMgr.sources.containsKey(item.key)) {
              version += ' (installed: v${srcMgr.sources[item.key]!.version})';
            }

            return Card(
              key: ValueKey(item.key),
              child: ListTile(
                leading: const Icon(Icons.rss_feed),
                title: Text(item.value.name),
                subtitle: Text(version),
                trailing: OverflowBar(
                  children: actions,
                ),
              ),
            );
          },
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const TitleFlexBar(title: 'Source Manager'),
        actions: [
          IconButton(
            onPressed: () {
              forceRefresh.value += 1;
            },
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh repos',
          ),
          IconButton(
            onPressed: () => nav.push(WebSourceSettingsRouteBuilder()),
            icon: const Icon(Icons.settings),
            tooltip: 'Web Source Settings',
          ),
        ],
      ),
      body: Center(
        child: body,
      ),
    );
  }
}
