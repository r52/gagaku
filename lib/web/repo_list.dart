import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/ui.dart';
import 'package:gagaku/web/config.dart';
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
            tooltip: 'Add New Repo',
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
            tooltip: 'Save',
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
            ? const Text('No repos')
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
                            tooltip: 'View in browser',
                            onPressed: () async {
                              if (!await launchUrl(Uri.parse(item))) {
                                throw 'Could not launch $item';
                              }
                            },
                            icon: const Icon(Icons.open_in_new),
                          ),
                          IconButton(
                            tooltip: 'Delete',
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
      title: const Text('Add Repo'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Ensure that you are only adding trusted sources!'),
          TextFormField(
            controller: urlFieldController,
            decoration: const InputDecoration(hintText: '.json repo URL'),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (String? value) {
              if (value == null || value.isEmpty) return 'URL cannot be empty.';

              return value.startsWith(_urlStartValidation) && value.endsWith(_urlEndValidation)
                  ? null
                  : 'URL must be a .json file.';
            },
          )
        ],
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
              child: const Text('Add'),
            );
          },
        ),
      ],
    );
  }
}
