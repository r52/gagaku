import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/util/ui.dart';
import 'package:gagaku/web/model/config.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

const _urlStartValidation = 'http';
const _urlEndValidation = '.json';

class RepoListManager extends HookConsumerWidget {
  const RepoListManager({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nav = Navigator.of(context);
    final list = useState(ref.watch(webConfigProvider.select((c) => c.repoList)));

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const TitleFlexBar(title: 'Repo List'),
        actions: [
          IconButton(
            tooltip: 'webSources.repo.newRepo'.tr(context: context),
            onPressed: () async {
              final result = await showDialog<String>(
                  context: context,
                  builder: (BuildContext context) {
                    return const NewRepoDialog();
                  });

              if (result != null && context.mounted) {
                list.value = [...list.value, result];
              }
            },
            icon: const Icon(Icons.add),
          ),
          IconButton(
            tooltip: 'ui.save'.tr(context: context),
            onPressed: () {
              ref.read(webConfigProvider.notifier).saveWith(repoList: list.value);
              nav.pop();
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Center(
        child: list.value.isEmpty
            ? Text('errors.norepos'.tr(context: context))
            : ListView.builder(
                itemCount: list.value.length,
                itemBuilder: (context, index) {
                  final item = list.value.elementAt(index);
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.cloud_download),
                      title: Text(item),
                      trailing: OverflowBar(
                        children: [
                          IconButton(
                            tooltip: 'webSources.repo.browser'.tr(context: context),
                            onPressed: () async {
                              if (!await launchUrl(Uri.parse(item))) {
                                throw 'Could not launch $item';
                              }
                            },
                            icon: const Icon(Icons.open_in_new),
                          ),
                          IconButton(
                            tooltip: 'ui.delete'.tr(context: context),
                            onPressed: () {
                              list.value.remove(item);
                              list.value = [...list.value];
                            },
                            icon: const Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}

class NewRepoDialog extends HookWidget {
  const NewRepoDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final urlFieldController = useTextEditingController();

    return AlertDialog(
      title: Text('webSources.repo.add'.tr(context: context)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('webSources.repo.addWarning'.tr(context: context)),
          TextFormField(
            controller: urlFieldController,
            decoration: InputDecoration(hintText: 'webSources.repo.urlHint'.tr(context: context)),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (String? value) {
              if (value == null || value.isEmpty) return 'webSources.repo.urlEmptyWarning'.tr(context: context);

              return value.startsWith(_urlStartValidation) && value.endsWith(_urlEndValidation)
                  ? null
                  : 'webSources.repo.urlInvalidWarning'.tr(context: context);
            },
          )
        ],
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
        HookBuilder(
          builder: (_) {
            final urlIsValid = useListenableSelector(
                urlFieldController,
                () =>
                    urlFieldController.text.isNotEmpty &&
                    urlFieldController.text.startsWith(_urlStartValidation) &&
                    urlFieldController.text.endsWith(_urlEndValidation));
            return ElevatedButton(
              onPressed: urlIsValid
                  ? () {
                      Navigator.of(context).pop(urlFieldController.text);
                      urlFieldController.clear();
                    }
                  : null,
              child: Text('ui.add'.tr(context: context)),
            );
          },
        ),
      ],
    );
  }
}
