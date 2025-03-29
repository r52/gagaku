import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/web/model/model.dart';

Future<void> openLinkDialog(BuildContext context, ProxyHandler api) async {
  final tr = context.t;
  final messenger = ScaffoldMessenger.of(context);
  final result = await showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return const OpenLinkDialog();
    },
  );

  if (result != null && context.mounted) {
    final parseResult = await api.handleUrl(url: result, context: context);

    if (!context.mounted) return;
    if (!parseResult) {
      messenger
        ..removeCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(tr.errors.unsupportedUrl),
            backgroundColor: Colors.red,
          ),
        );
    }
  }
}

class OpenLinkDialog extends HookWidget {
  const OpenLinkDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final tr = context.t;
    final urlFieldController = useTextEditingController();

    return AlertDialog(
      title: Text(tr.webSources.openUrl),
      content: TextField(
        controller: urlFieldController,
        decoration: const InputDecoration(
          hintText: 'cubari.moe, imgur.com etc.',
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(tr.ui.pasteClipboard),
          onPressed: () async {
            var result = await Clipboard.getData('text/plain');
            if (result != null) {
              urlFieldController.text = result.text!;
            }
          },
        ),
        TextButton(
          child: Text(tr.ui.cancel),
          onPressed: () {
            Navigator.of(context).pop();
            urlFieldController.clear();
          },
        ),
        ElevatedButton(
          child: Text(tr.ui.go),
          onPressed: () {
            Navigator.of(context).pop(urlFieldController.text);
            urlFieldController.clear();
          },
        ),
      ],
    );
  }
}
