import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
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
      body = Text('webSources.source.noDirWarning'.tr(context: context));
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
            Text('webSources.source.noRepoDataWarning'.tr(context: context)),
            Expanded(
              child: srcMgr.sources.isEmpty
                  ? Center(child: Text('webSources.noSourcesWarning'.tr(context: context)))
                  : ListView.builder(
                      itemCount: srcMgr.sources.length,
                      itemBuilder: (context, index) {
                        final item = srcMgr.sources.entries.elementAt(index);

                        final actions = <Widget>[
                          IconButton(
                            tooltip: 'webSources.source.delete'.tr(context: context, args: [item.value.name]),
                            onPressed: () {
                              final messenger = ScaffoldMessenger.of(context);
                              ref.read(webSourceManagerProvider.notifier).removeSource(item.key).then((_) {
                                if (!context.mounted) return;
                                messenger
                                  ..removeCurrentSnackBar()
                                  ..showSnackBar(
                                    SnackBar(
                                      content: Text('webSources.source.sourceDeleteOK'.tr(context: context)),
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
                  tooltip: 'webSources.source.update'.tr(context: context, args: [item.value.name]),
                  onPressed: () {
                    final messenger = ScaffoldMessenger.of(context);
                    ref.read(webSourceManagerProvider.notifier).updateSource(item.key, item.value).then((_) {
                      if (!context.mounted) return;
                      messenger
                        ..removeCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(
                            content: Text('webSources.source.sourceUpdateOK'.tr(context: context)),
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
                  tooltip: 'webSources.source.delete'.tr(context: context, args: [item.value.name]),
                  onPressed: () {
                    final messenger = ScaffoldMessenger.of(context);
                    ref.read(webSourceManagerProvider.notifier).removeSource(item.key).then((_) {
                      if (!context.mounted) return;
                      messenger
                        ..removeCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(
                            content: Text('webSources.source.sourceDeleteOK'.tr(context: context)),
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
                  tooltip: 'webSources.source.add'.tr(context: context, args: [item.value.name]),
                  onPressed: () {
                    final messenger = ScaffoldMessenger.of(context);
                    ref.read(webSourceManagerProvider.notifier).addSource(item.key, item.value).then((_) {
                      if (!context.mounted) return;
                      messenger
                        ..removeCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(
                            content: Text('webSources.source.sourceAddOK'.tr(context: context)),
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
              version +=
                  'webSources.source.installedVersion'.tr(context: context, args: [srcMgr.sources[item.key]!.version]);
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
        flexibleSpace: TitleFlexBar(title: 'webSources.source.manager'.tr(context: context)),
        actions: [
          IconButton(
            onPressed: () {
              forceRefresh.value += 1;
            },
            icon: const Icon(Icons.refresh),
            tooltip: 'webSources.source.refresh'.tr(context: context),
          ),
          IconButton(
            onPressed: () => nav.push(WebSourceSettingsRouteBuilder()),
            icon: const Icon(Icons.settings),
            tooltip: 'arg_settings'.tr(context: context, args: ['webSources.text'.tr(context: context)]),
          ),
        ],
      ),
      body: Center(
        child: body,
      ),
    );
  }
}
