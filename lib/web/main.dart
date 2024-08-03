import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/drawer.dart';
import 'package:gagaku/ui.dart';
import 'package:gagaku/web/model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WebSourcesHome extends HookConsumerWidget {
  const WebSourcesHome({super.key});

  Future<void> openLinkDialog(BuildContext context, ProxyHandler api) async {
    final messenger = ScaffoldMessenger.of(context);
    final result = await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return _OpenLinkDialog();
        });

    if (result != null && context.mounted) {
      final parseResult = await api.handleUrl(url: result, context: context);

      if (!parseResult) {
        messenger
          ..removeCurrentSnackBar()
          ..showSnackBar(const SnackBar(
            content: Text('Unsupported URL'),
            backgroundColor: Colors.red,
          ));
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final api = ref.watch(proxyProvider);

    final scrollController = useScrollController();
    final historyProvider = ref.watch(webSourceHistoryProvider);

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const TitleFlexBar(title: 'Web Sources'),
        actions: [
          IconButton(
            onPressed: () => openLinkDialog(context, api),
            icon: const Icon(Icons.open_in_browser),
            tooltip: 'Open Link',
          ),
          IconButton(
            onPressed: () async {
              final result = await showDialog<bool>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Clear History'),
                    content: const Text(
                        'Are you sure you want to remove all history?'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('No'),
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                      ),
                      ElevatedButton(
                        child: const Text('Yes'),
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                      ),
                    ],
                  );
                },
              );

              if (result == true) {
                ref.read(webSourceHistoryProvider.notifier).clear();
              }
            },
            icon: const Icon(Icons.clear_all),
            tooltip: 'Clear History',
          ),
          IconButton(
            onPressed: () async {
              final result = await showDialog<bool>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Reset Read Markers'),
                    content: const Text(
                        'Are you sure you want to reset all read markers?'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('No'),
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                      ),
                      ElevatedButton(
                        child: const Text('Yes'),
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                      ),
                    ],
                  );
                },
              );

              if (result == true) {
                ref.read(webReadMarkersProvider.notifier).clear();
              }
            },
            icon: const Icon(Icons.restart_alt),
            tooltip: 'Reset Read Markers',
          ),
        ],
      ),
      drawer: const MainDrawer(),
      body: switch (historyProvider) {
        AsyncValue(value: final history?) when history.isEmpty => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Tooltip(
                  message: 'Supported URLs:\ncubari.moe\nimgur.com',
                  padding: EdgeInsets.all(6),
                  triggerMode: TooltipTriggerMode.tap,
                  child: Wrap(
                    children: [
                      Text('Supported URLs'),
                      Icon(
                        Icons.help,
                        size: 20,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton.icon(
                  onPressed: () => openLinkDialog(context, api),
                  icon: const Icon(
                    Icons.link,
                  ),
                  label: const Text('Open Web Source'),
                ),
              ],
            ),
          ),
        AsyncValue(value: final history?) => Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'History',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  controller: scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(6),
                  itemCount: history.length,
                  separatorBuilder: (_, __) => const SizedBox(
                    height: 4.0,
                  ),
                  itemBuilder: (context, index) {
                    final item = history.elementAt(index);
                    return ListTile(
                      key: ValueKey(item.hashCode),
                      tileColor: theme.colorScheme.surfaceContainer,
                      leading: const Icon(Icons.link),
                      trailing: IconButton(
                        tooltip: 'Remove from History',
                        icon: const Icon(Icons.clear),
                        onPressed: () async {
                          ref
                              .read(webSourceHistoryProvider.notifier)
                              .remove(item);
                        },
                      ),
                      title: Text(item.title),
                      textColor: Colors.blue,
                      onTap: () async {
                        final messenger = ScaffoldMessenger.of(context);
                        final parseResult = await api.handleUrl(
                            url: item.url, context: context);

                        if (!parseResult) {
                          messenger
                            ..removeCurrentSnackBar()
                            ..showSnackBar(const SnackBar(
                              content: Text('Unsupported URL'),
                              backgroundColor: Colors.red,
                            ));
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        AsyncValue(:final error?, :final stackTrace?) =>
          ErrorColumn(error: error, stackTrace: stackTrace),
        _ => const Center(
            child: CircularProgressIndicator(),
          ),
      },
    );
  }
}

class _OpenLinkDialog extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final urlFieldController = useTextEditingController();

    return AlertDialog(
      title: const Text('Open URL'),
      content: TextField(
        controller: urlFieldController,
        decoration:
            const InputDecoration(hintText: 'cubari.moe, imgur.com etc.'),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Paste from Clipboard'),
          onPressed: () async {
            var result = await Clipboard.getData('text/plain');
            if (result != null) {
              urlFieldController.text = result.text!;
            }
          },
        ),
        TextButton(
          child: const Text('CANCEL'),
          onPressed: () {
            Navigator.of(context).pop();
            urlFieldController.clear();
          },
        ),
        ElevatedButton(
          child: const Text('OK'),
          onPressed: () {
            Navigator.of(context).pop(urlFieldController.text);
            urlFieldController.clear();
          },
        ),
      ],
    );
  }
}
