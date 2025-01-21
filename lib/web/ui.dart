import 'package:easy_localization/easy_localization.dart';
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

    if (!context.mounted) return;
    if (!parseResult) {
      messenger
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(
          content: Text('ui.unsupportedUrl'.tr(context: context)),
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
      title: Text('webSources.openUrl'.tr(context: context)),
      content: TextField(
        controller: urlFieldController,
        decoration: const InputDecoration(hintText: 'cubari.moe, imgur.com etc.'),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('ui.pasteClipboard'.tr(context: context)),
          onPressed: () async {
            var result = await Clipboard.getData('text/plain');
            if (result != null) {
              urlFieldController.text = result.text!;
            }
          },
        ),
        TextButton(
          child: Text('ui.cancel'.tr(context: context)),
          onPressed: () {
            Navigator.of(context).pop();
            urlFieldController.clear();
          },
        ),
        ElevatedButton(
          child: Text('ui.go'.tr(context: context)),
          onPressed: () {
            Navigator.of(context).pop(urlFieldController.text);
            urlFieldController.clear();
          },
        ),
      ],
    );
  }
}
