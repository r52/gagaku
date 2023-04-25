import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/drawer.dart';
import 'package:gagaku/web/manga_view.dart';
import 'package:gagaku/web/model.dart';
import 'package:gagaku/web/reader.dart';
import 'package:gagaku/web/types.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WebGalleryHome extends HookConsumerWidget {
  const WebGalleryHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final urlFieldController = useTextEditingController();

    Future<void> openManga(WebManga manga) async {
      Navigator.push(context, createMangaViewRoute(manga));
    }

    Future<void> openImgur(String src) async {
      Navigator.push(context, createWebGalleryReaderRoute(src));
    }

    Future<bool> parseUrl(String url) async {
      if (!url.startsWith('https://cubari.moe/read/') &&
          !url.startsWith('https://imgur.com/a/')) {
        return false;
      }

      if (url.startsWith('https://imgur.com/a/')) {
        var src = url.substring(20);
        await openImgur(src);
      } else if (url.startsWith('https://cubari.moe/read/')) {
        var src = url.substring(24);
        var proxy = src.split('/');
        proxy.removeWhere((element) => element.isEmpty);

        if (proxy.length < 2) {
          return false;
        }

        var type = proxy[0];

        if (type == 'gist') {
          var manga = await ref.read(getMangaFromGistProvider(proxy[1]).future);
          await openManga(manga);
        } else if (type == 'imgur') {
          await openImgur(proxy[1]);
        }
      }

      return true;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Web Gallery'),
      ),
      drawer: const MainDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Tooltip(
              message: 'Supported URLs:\ncubari.moe\nimgur.com',
              padding: const EdgeInsets.all(6),
              triggerMode: TooltipTriggerMode.tap,
              child: Wrap(
                children: const [
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
                var result = await showDialog<String>(
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
                              Navigator.pop(context);
                              urlFieldController.clear();
                            },
                          ),
                          ElevatedButton(
                            child: const Text('OK'),
                            onPressed: () {
                              Navigator.pop(context, urlFieldController.text);
                              urlFieldController.clear();
                            },
                          ),
                        ],
                      );
                    });

                if (result != null) {
                  var parseResult = await parseUrl(result);

                  if (!parseResult) {
                    ScaffoldMessenger.of(context)
                      ..removeCurrentSnackBar()
                      ..showSnackBar(const SnackBar(
                        content: Text('Failed to parse URL.'),
                        backgroundColor: Colors.red,
                      ));
                  }
                }
              },
              icon: const Icon(
                Icons.link,
              ),
              label: const Text('Open Web Gallery'),
            ),
          ],
        ),
      ),
    );
  }
}
