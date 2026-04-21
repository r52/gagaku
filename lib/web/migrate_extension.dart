import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/model/model.dart';
import 'package:gagaku/objectbox.g.dart';
import 'package:gagaku/web/model/config.dart';
import 'package:gagaku/web/model/model.dart';
import 'package:gagaku/web/model/types.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MigrateExtensionDialog extends HookConsumerWidget {
  const MigrateExtensionDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tr = context.t;
    final nav = Navigator.of(context);
    final theme = Theme.of(context);

    // Get all unique old extension IDs from HistoryLink
    final oldExtensionsConfig = useMemoized(() {
      final store = GagakuData().store;
      final historyBox = store.box<HistoryLink>();
      final query = historyBox.query().build();
      final urls = query.property(HistoryLink_.url).find();
      query.close();
      final ids = urls.map((u) => u.split('/').first).toSet().toList();
      ids.sort();
      return ids;
    });

    final newExtensionsConfig = useMemoized(() {
      final store = GagakuData().store;
      final sourceBox = store.box<WebSourceInfo>();
      final sources = sourceBox.getAll();
      sources.sort((a, b) => a.name.compareTo(b.name));
      return sources;
    });

    final oldId = useState<String?>(null);
    final newId = useState<String?>(null);

    return AlertDialog(
      title: Text(tr.webSources.settings.migrateExtension),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(tr.webSources.settings.verifyMigration),
            const SizedBox(height: 16),
            Text(tr.webSources.settings.oldExtensionId),
            DropdownButton<String>(
              isExpanded: true,
              value: oldId.value,
              hint: Text(tr.webSources.settings.chooseExtension),
              items: oldExtensionsConfig.map((String id) {
                return DropdownMenuItem<String>(value: id, child: Text(id));
              }).toList(),
              onChanged: (String? newValue) {
                oldId.value = newValue;
              },
            ),
            const SizedBox(height: 16),
            Text(tr.webSources.settings.newExtensionId),
            DropdownButton<String>(
              isExpanded: true,
              value: newId.value,
              hint: Text(tr.webSources.settings.chooseExtension),
              items: newExtensionsConfig.map((WebSourceInfo source) {
                return DropdownMenuItem<String>(
                  value: source.id,
                  child: Text('${source.name} (${source.id})'),
                );
              }).toList(),
              onChanged: (String? newValue) {
                newId.value = newValue;
              },
            ),
            const SizedBox(height: 16),
            Text(
              tr.ui.irreversibleWarning,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.error,
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(tr.ui.cancel),
          onPressed: () {
            nav.pop();
          },
        ),
        ElevatedButton(
          onPressed:
              (oldId.value == null ||
                  newId.value == null ||
                  oldId.value == newId.value)
              ? null
              : () async {
                  final confirmed = await showDialog<bool>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(tr.ui.sureContinue),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: Text(tr.ui.no),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: Text(tr.ui.yes),
                          ),
                        ],
                      );
                    },
                  );

                  if (confirmed != true) return;

                  final store = GagakuData().store;

                  // 1. Migrate HistoryLink (and by extension WebFavoritesList links)
                  final historyBox = store.box<HistoryLink>();
                  final query = historyBox
                      .query(HistoryLink_.url.startsWith('${oldId.value}/'))
                      .build();
                  final links = query.find();
                  query.close();

                  for (final link in links) {
                    if (link.url.startsWith('${oldId.value}/')) {
                      link.url = link.url.replaceFirst(
                        '${oldId.value}/',
                        '${newId.value}/',
                      );
                    }
                    if (link.handle != null) {
                      link.handle = link.handle!.copyWith(
                        sourceId: newId.value!,
                      );
                    }
                  }
                  historyBox.putMany(links);

                  // 2. Migrate ExtensionState
                  ref
                      .read(extensionStateProvider.notifier)
                      .migrate(oldId.value!, newId.value!);
                  ref
                      .read(extensionSecureStateProvider.notifier)
                      .migrate(oldId.value!, newId.value!);

                  // 3. Migrate WebReadMarkers
                  await ref
                      .read(webReadMarkersProvider.notifier)
                      .migrate(oldId.value!, newId.value!);

                  // Optional: Delete old WebSourceInfo if it exists
                  final sourceBox = store.box<WebSourceInfo>();
                  final oldSourceQuery = sourceBox
                      .query(WebSourceInfo_.id.equals(oldId.value!))
                      .build();
                  final oldSource = oldSourceQuery.findUnique();
                  oldSourceQuery.close();
                  if (oldSource != null) {
                    sourceBox.remove(oldSource.dbid);
                  }

                  if (!context.mounted) return;
                  nav.pop();
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        content: Text(tr.webSources.settings.migrateSuccess),
                        backgroundColor: Colors.green,
                        duration: const Duration(seconds: 5),
                      ),
                    );
                },
          child: Text(tr.ui.go),
        ),
      ],
    );
  }
}
