import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/drawer.dart';
import 'package:gagaku/web/manga_view.dart';
import 'package:gagaku/web/model.dart';
import 'package:gagaku/web/reader.dart';
import 'package:gagaku/web/types.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WebSourcesHome extends HookConsumerWidget {
  const WebSourcesHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final api = ref.watch(proxyProvider);
    final urlFieldController = useTextEditingController();
    final nav = Navigator.of(context);

    Future<void> openManga(WebManga manga) async {
      nav.push(createMangaViewRoute(manga));
    }

    Future<bool> parseUrl(String url) async {
      if (url.startsWith('https://imgur.com/a/')) {
        final src = url.substring(20);
        final code = '/read/api/imgur/chapter/$src';
        await nav.push(createWebSourceReaderRoute(code));
        return true;
      }

      if (url.startsWith('https://cubari.moe/read/')) {
        final info = await api.parseUrl(url);

        if (info == null) {
          return false;
        }

        final proxy = await api.handleProxy(info);

        if (proxy.code != null) {
          await nav.push(createWebSourceReaderRoute(proxy.code!));
          return true;
        }

        if (proxy.manga != null) {
          await openManga(proxy.manga!);
          return true;
        }
      }

      return false;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Web Sources'),
      ),
      drawer: const MainDrawer(),
      body: Center(
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
              onPressed: () async {
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
                              var result =
                                  await Clipboard.getData('text/plain');
                              if (result != null) {
                                urlFieldController.text = result.text!;
                              }
                            },
                          ),
                          TextButton(
                            child: const Text('CANCEL'),
                            onPressed: () {
                              nav.pop();
                              urlFieldController.clear();
                            },
                          ),
                          ElevatedButton(
                            child: const Text('OK'),
                            onPressed: () {
                              nav.pop(urlFieldController.text);
                              urlFieldController.clear();
                            },
                          ),
                        ],
                      );
                    });

                if (result != null) {
                  var parseResult = await parseUrl(result);

                  if (!parseResult) {
                    messenger
                      ..removeCurrentSnackBar()
                      ..showSnackBar(const SnackBar(
                        content: Text('Unsupported URL'),
                        backgroundColor: Colors.red,
                      ));
                  }
                }
              },
              icon: const Icon(
                Icons.link,
              ),
              label: const Text('Open Web Source'),
            ),
          ],
        ),
      ),
    );
  }
}
