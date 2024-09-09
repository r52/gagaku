import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/web/model/model.dart';

Future<void> openLinkDialog(BuildContext context, ProxyHandler api) async {
  final messenger = ScaffoldMessenger.of(context);
  final result = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return const OpenLinkDialog();
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

class OpenLinkDialog extends HookWidget {
  const OpenLinkDialog({super.key});

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
