import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/ui.dart';
import 'package:gagaku/web/model.dart';
import 'package:gagaku/web/ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WebSourceHistory extends HookConsumerWidget {
  const WebSourceHistory({
    super.key,
    this.controller,
  });

  final ScrollController? controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final api = ref.watch(proxyProvider);

    final scrollController = controller ?? useScrollController();
    final historyProvider = ref.watch(webSourceHistoryProvider);

    return Material(
      child: switch (historyProvider) {
        AsyncValue(value: final history?) when history.isEmpty => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Tooltip(
                  message: 'Supported URLs:\ncubari.moe\nimgur.com',
                  padding: EdgeInsets.all(6),
                  triggerMode: TooltipTriggerMode.tap,
                  child: Wrap(
                    children: [
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
                  onPressed: () => openLinkDialog(context, api),
                  icon: const Icon(
                    Icons.link,
                  ),
                  label: const Text('Open Web Source'),
                ),
              ],
            ),
          ),
        AsyncValue(value: final history?) => Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                child: Row(
                  children: [
                    const Text(
                      'History',
                      style: TextStyle(fontSize: 24),
                    ),
                    const Spacer(),
                    ElevatedButton.icon(
                      style: Styles.buttonStyle(),
                      onPressed: () async {
                        final result = await showDialog<bool>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Clear History'),
                              content: const Text(
                                  'Are you sure you want to remove all history?'),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('No'),
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                ),
                                ElevatedButton(
                                  child: const Text('Yes'),
                                  onPressed: () {
                                    Navigator.of(context).pop(true);
                                  },
                                ),
                              ],
                            );
                          },
                        );

                        if (result == true) {
                          ref.read(webSourceHistoryProvider.notifier).clear();
                        }
                      },
                      icon: const Icon(Icons.clear_all),
                      label: const Text('Clear History'),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                  controller: scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(6),
                  itemCount: history.length,
                  separatorBuilder: (_, __) => const SizedBox(
                    height: 4.0,
                  ),
                  itemBuilder: (context, index) {
                    final item = history.elementAt(index);
                    return ListTile(
                      key: ValueKey(item.hashCode),
                      tileColor: index.isOdd
                          ? theme.colorScheme.surfaceContainer
                          : theme.colorScheme.surfaceContainerHighest,
                      leading: Consumer(
                        builder: (context, refx, child) {
                          final favorited =
                              ref.watch(webSourceFavoritesProvider.select(
                            (value) => switch (value) {
                              AsyncValue(value: final data?) =>
                                data.indexWhere((e) => e.url == item.url) > -1,
                              _ => null,
                            },
                          ));

                          if (favorited == null) {
                            return const CircularProgressIndicator();
                          }

                          return IconButton(
                            tooltip: favorited
                                ? 'Remove from Favorites'
                                : 'Add to Favorites',
                            icon: Icon(favorited
                                ? Icons.favorite
                                : Icons.favorite_border),
                            color: favorited ? theme.colorScheme.primary : null,
                            onPressed: () async {
                              if (favorited) {
                                ref
                                    .read(webSourceFavoritesProvider.notifier)
                                    .remove(item);
                              } else {
                                ref
                                    .read(webSourceFavoritesProvider.notifier)
                                    .add(item);
                              }
                            },
                          );
                        },
                      ),
                      trailing: IconButton(
                        tooltip: 'Remove from History',
                        icon: const Icon(Icons.clear),
                        onPressed: () async {
                          ref
                              .read(webSourceHistoryProvider.notifier)
                              .remove(item);
                        },
                      ),
                      title: Text(item.title),
                      textColor: Colors.blue,
                      onTap: () async {
                        final messenger = ScaffoldMessenger.of(context);
                        final parseResult = await api.handleUrl(
                            url: item.url, context: context);

                        if (!parseResult) {
                          messenger
                            ..removeCurrentSnackBar()
                            ..showSnackBar(const SnackBar(
                              content: Text('Unsupported URL'),
                              backgroundColor: Colors.red,
                            ));
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        AsyncValue(:final error?, :final stackTrace?) =>
          ErrorColumn(error: error, stackTrace: stackTrace),
        _ => const Center(
            child: CircularProgressIndicator(),
          ),
      },
    );
  }
}