import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/drawer.dart';
import 'package:gagaku/ui.dart';
import 'package:gagaku/web/model.dart';
import 'package:gagaku/web/reader.dart';
import 'package:gagaku/web/types.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WebSourcesHome extends HookConsumerWidget {
  const WebSourcesHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final api = ref.watch(proxyProvider);
    final urlFieldController = useTextEditingController();
    final scrollController = useScrollController();
    final history = ref.watch(webSourceHistoryProvider);

    bool parseUrl(String url) {
      if (url.startsWith('https://imgur.com/a/')) {
        final src = url.substring(20);
        final code = '/read/api/imgur/chapter/$src';
        GoRouter.of(context)
            .push('/read/imgur/$src/1/1/', extra: WebReaderData(source: code));
        ref
            .read(webSourceHistoryProvider.notifier)
            .add(HistoryLink(title: url, url: url));
        return true;
      }

      if (url.startsWith('https://cubari.moe/read/')) {
        final info = api.parseUrl(url);

        if (info == null) {
          return false;
        }

        if (info.chapter != null) {
          GoRouter.of(context)
              .push('/read/${info.proxy}/${info.code}/${info.chapter}/1/');
        } else {
          GoRouter.of(context).push('/read/${info.proxy}/${info.code}');
        }

        return true;
      }

      return false;
    }

    Future<void> openLinkDialog() async {
      final messenger = ScaffoldMessenger.of(context);
      final result = await showDialog<String>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Open URL'),
              content: TextField(
                controller: urlFieldController,
                decoration: const InputDecoration(
                    hintText: 'cubari.moe, imgur.com etc.'),
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
          });

      if (result != null) {
        final parseResult = parseUrl(result);

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

    return Scaffold(
      appBar: AppBar(
        flexibleSpace:
            Styles.titleFlexBar(context: context, title: 'Web Sources'),
        actions: [
          IconButton(
            onPressed: openLinkDialog,
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
        ],
      ),
      drawer: const MainDrawer(),
      body: switch (history) {
        AsyncData(:final value) => () {
            if (value.isEmpty) {
              return Center(
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
                      onPressed: openLinkDialog,
                      icon: const Icon(
                        Icons.link,
                      ),
                      label: const Text('Open Web Source'),
                    ),
                  ],
                ),
              );
            }

            return Column(
              children: [
                const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                  child: Row(
                    children: [
                      Text(
                        'History',
                        style: TextStyle(fontSize: 24),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(6),
                    itemCount: value.length,
                    itemBuilder: (context, index) {
                      final item = value.elementAt(index);
                      return ListTile(
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
                        onTap: () {
                          final messenger = ScaffoldMessenger.of(context);
                          final parseResult = parseUrl(item.url);

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
            );
          }(),
        AsyncError(:final error, :final stackTrace) =>
          Styles.errorColumn(error, stackTrace),
        _ => const Center(
            child: CircularProgressIndicator(),
          ),
      },
    );
  }
}
