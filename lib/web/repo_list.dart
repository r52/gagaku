import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/model/model.dart';
import 'package:gagaku/util/ui.dart';
import 'package:gagaku/web/model/types.dart' show RepoInfo;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

const _urlStartValidation = 'http';

class RepoListManager extends HookConsumerWidget {
  const RepoListManager({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tr = context.t;
    final theme = Theme.of(context);
    final nav = Navigator.of(context);
    final box = GagakuData().store.box<RepoInfo>();
    final initial = useMemoized(() => box.getAll());
    final list = useState(initial);

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const TitleFlexBar(title: 'Repo List'),
        actions: [
          IconButton(
            color: theme.colorScheme.onPrimaryContainer,
            tooltip: tr.webSources.repo.newRepo,
            onPressed: () async {
              final result = await showDialog<RepoInfo>(
                context: context,
                builder: (BuildContext context) {
                  return const NewRepoDialog();
                },
              );

              if (result != null && context.mounted) {
                list.value = [...list.value, result];
              }
            },
            icon: const Icon(Icons.add),
          ),
          IconButton(
            color: theme.colorScheme.onPrimaryContainer,
            tooltip: tr.ui.save,
            onPressed: () {
              final diff = initial.toSet().difference(list.value.toSet());

              box.putMany(list.value);
              box.removeMany(diff.map((e) => e.dbid).toList());

              nav.pop();
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Center(
        child: list.value.isEmpty
            ? Text(tr.errors.norepos)
            : ListView.builder(
                itemCount: list.value.length,
                itemBuilder: (context, index) {
                  final item = list.value.elementAt(index);
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.cloud_download),
                      title: Text(item.name),
                      subtitle: Text(item.url),
                      trailing: OverflowBar(
                        children: [
                          IconButton(
                            tooltip: tr.webSources.repo.browser,
                            onPressed: () async {
                              if (!await launchUrl(Uri.parse(item.url))) {
                                throw 'Could not launch $item';
                              }
                            },
                            icon: const Icon(Icons.open_in_new),
                          ),
                          IconButton(
                            tooltip: tr.ui.delete,
                            onPressed: () {
                              list.value = [
                                ...list.value.where((e) => e.url != item.url),
                              ];
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
    final tr = context.t;
    final nameFieldController = useTextEditingController();
    final urlFieldController = useTextEditingController();

    return AlertDialog(
      title: Text(tr.webSources.repo.add),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(tr.webSources.repo.addWarning),
          TextFormField(
            controller: nameFieldController,
            decoration: InputDecoration(hintText: tr.webSources.repo.nameHint),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return tr.webSources.repo.nameEmptyWarning;
              }

              return null;
            },
          ),
          TextFormField(
            controller: urlFieldController,
            decoration: InputDecoration(hintText: tr.webSources.repo.urlHint),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return tr.webSources.repo.urlEmptyWarning;
              }

              return value.startsWith(_urlStartValidation)
                  ? null
                  : tr.webSources.repo.urlInvalidWarning;
            },
          ),
        ],
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
        HookBuilder(
          builder: (_) {
            final nameIsValid = useListenableSelector(
              nameFieldController,
              () => nameFieldController.text.isNotEmpty,
            );
            final urlIsValid = useListenableSelector(
              urlFieldController,
              () =>
                  urlFieldController.text.isNotEmpty &&
                  urlFieldController.text.startsWith(_urlStartValidation),
            );
            return ElevatedButton(
              onPressed: urlIsValid && nameIsValid
                  ? () {
                      Navigator.of(context).pop(
                        RepoInfo(
                          name: nameFieldController.text,
                          url: urlFieldController.text,
                        ),
                      );
                      nameFieldController.clear();
                      urlFieldController.clear();
                    }
                  : null,
              child: Text(tr.ui.add),
            );
          },
        ),
      ],
    );
  }
}
