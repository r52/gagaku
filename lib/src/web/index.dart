import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gagaku/src/web/api.dart';
import 'package:gagaku/src/web/manga_view.dart';
import 'package:gagaku/src/web/reader.dart';
import 'package:gagaku/src/web/types.dart';

class WebGalleryHomePage extends StatefulWidget {
  WebGalleryHomePage({Key? key, required this.topScaffold}) : super(key: key);

  final GlobalKey<ScaffoldState> topScaffold;

  @override
  _WebGalleryHomePageState createState() => _WebGalleryHomePageState();
}

class _WebGalleryHomePageState extends State<WebGalleryHomePage> {
  final _urlFieldController = TextEditingController();

  Future<void> _openManga(WebManga manga) async {
    Navigator.push(context, createMangaViewRoute(manga));
  }

  Future<void> _openImgur(String src) async {
    Navigator.push(
        context, createWebGalleryReaderRoute(src, null, null, null, null));
  }

  Future<bool> _parseUrl(String url) async {
    if (!url.startsWith('https://cubari.moe/read/') &&
        !url.startsWith('https://git.io/') &&
        !url.startsWith('https://imgur.com/a/')) {
      return false;
    }

    if (url.startsWith('https://imgur.com/a/')) {
      var src = url.substring(20);
      await _openImgur(src);
    } else if (url.startsWith('https://cubari.moe/read/')) {
      var src = url.substring(24);
      var proxy = src.split('/');
      proxy.removeWhere((element) => element.isEmpty);

      if (proxy.length < 2) {
        return false;
      }

      var type = proxy[0];

      if (type == 'gist') {
        var manga = await WebGalleryAPI.getGist(proxy[1]);
        await _openManga(manga);
      } else if (type == 'imgur') {
        await _openImgur(proxy[1]);
      }
    } else if (url.startsWith('https://git.io/')) {
      var src = url.substring(15);
      var manga = await WebGalleryAPI.getGist(src);
      await _openManga(manga);
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                widget.topScaffold.currentState!.openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        title: Text('Web Gallery'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Tooltip(
              message: 'Supported URLs:\ncubari.moe\ngit.io\nimgur.com',
              padding: const EdgeInsets.all(6),
              child: Wrap(
                children: [
                  Text('Supported URLs'),
                  Icon(
                    Icons.help,
                    size: 20,
                  ),
                ],
              ),
              triggerMode: TooltipTriggerMode.tap,
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
                        title: Text('Open URL'),
                        content: TextField(
                          controller: _urlFieldController,
                          decoration: InputDecoration(
                              hintText: 'cubari.moe, git.io, imgur.com etc.'),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Paste from Clipboard'),
                            onPressed: () async {
                              var result =
                                  await Clipboard.getData('text/plain');
                              if (result != null) {
                                _urlFieldController.text = result.text!;
                              }
                            },
                          ),
                          TextButton(
                            child: Text('CANCEL'),
                            onPressed: () {
                              Navigator.pop(context);
                              _urlFieldController.clear();
                            },
                          ),
                          ElevatedButton(
                            child: Text('OK'),
                            onPressed: () {
                              Navigator.pop(context, _urlFieldController.text);
                              _urlFieldController.clear();
                            },
                          ),
                        ],
                      );
                    });

                if (result != null) {
                  var parseResult = await _parseUrl(result);

                  if (!parseResult) {
                    ScaffoldMessenger.of(context)
                      ..removeCurrentSnackBar()
                      ..showSnackBar(SnackBar(
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
