import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/model/model.dart';
import 'package:gagaku/web/model/config.dart';
import 'package:gagaku/web/model/model.dart';
import 'package:gagaku/web/model/types.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PruneExtensionDialog extends HookConsumerWidget {
  const PruneExtensionDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tr = context.t;
    final nav = Navigator.of(context);
    final theme = Theme.of(context);

    // Compute elements that are deemed unused.
    final pruneDataFuture = useMemoized(() async {
      final store = GagakuData().store;
      final sourceBox = store.box<WebSourceInfo>();
      final installedIds = sourceBox.getAll().map((e) => e.id).toSet();
      final staleState = ref
          .read(extensionStateProvider.notifier)
          .getStaleKeys(installedIds);
      final staleSecureState = ref
          .read(extensionSecureStateProvider.notifier)
          .getStaleKeys(installedIds);

      final historyBox = store.box<HistoryLink>();
      final validUrls = historyBox.getAll().map((e) => e.url).toSet();
      final staleReadMarkers = await ref
          .read(webReadMarkersProvider.notifier)
          .getStaleKeys(validUrls);

      return (
        state: staleState,
        secure: staleSecureState,
        markers: staleReadMarkers,
      );
    }, []);

    final pruneDataSnapshot = useFuture(pruneDataFuture);
    final isComputing =
        pruneDataSnapshot.connectionState == ConnectionState.waiting;
    final staleState = pruneDataSnapshot.data?.state ?? [];
    final staleSecureState = pruneDataSnapshot.data?.secure ?? [];
    final staleReadMarkers = pruneDataSnapshot.data?.markers ?? [];

    final totalStale =
        staleState.length + staleSecureState.length + staleReadMarkers.length;

    return AlertDialog(
      title: Text(tr.webSources.settings.pruneExtension),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isComputing) ...[
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(),
                ),
              ),
            ] else if (totalStale > 0) ...[
              Text(tr.webSources.settings.pruneSummary),
              const SizedBox(height: 16),
              Text(tr.webSources.settings.pruneState(count: staleState.length)),
              Text(
                tr.webSources.settings.pruneSecureState(
                  count: staleSecureState.length,
                ),
              ),
              Text(
                tr.webSources.settings.pruneReadMarkers(
                  count: staleReadMarkers.length,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                tr.ui.irreversibleWarning,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.error,
                ),
              ),
            ] else ...[
              Text(tr.webSources.settings.pruneEmpty),
            ],
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
          onPressed: isComputing || totalStale == 0
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

                  // Perform pruning
                  ref
                      .read(extensionStateProvider.notifier)
                      .pruneKeys(staleState);
                  ref
                      .read(extensionSecureStateProvider.notifier)
                      .pruneKeys(staleSecureState);
                  await ref
                      .read(webReadMarkersProvider.notifier)
                      .pruneKeys(staleReadMarkers);

                  if (!context.mounted) return;
                  nav.pop();
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        content: Text(tr.webSources.settings.pruneSuccess),
                        backgroundColor: Colors.green,
                        duration: const Duration(seconds: 3),
                      ),
                    );
                },
          child: Text(tr.ui.go),
        ),
      ],
    );
  }
}
