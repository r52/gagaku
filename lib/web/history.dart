import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/ui.dart';
import 'package:gagaku/web/model/config.dart';
import 'package:gagaku/web/model/model.dart';
import 'package:gagaku/web/ui.dart';
import 'package:gagaku/web/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WebSourceHistoryWidget extends HookConsumerWidget {
  const WebSourceHistoryWidget({
    super.key,
    this.controller,
  });

  final ScrollController? controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final api = ref.watch(proxyProvider);
    final cfg = ref.watch(webConfigProvider);

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
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
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
                              content: const Text('Are you sure you want to remove all history?'),
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
                child: WebMangaListWidget(
                  physics: const AlwaysScrollableScrollPhysics(),
                  controller: scrollController,
                  children: [
                    WebMangaListViewSliver(
                      items: history.toList(),
                      favoritesKey: cfg.defaultCategory,
                    ),
                  ],
                ),
              ),
            ],
          ),
        AsyncValue(:final error?, :final stackTrace?) => ErrorColumn(error: error, stackTrace: stackTrace),
        _ => const Center(
            child: CircularProgressIndicator(),
          ),
      },
    );
  }
}
