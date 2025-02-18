import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gagaku/util/default_scroll_controller.dart';
import 'package:gagaku/util/ui.dart';
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
    final defaultCategory = ref.watch(webConfigProvider.select((cfg) => cfg.defaultCategory));

    final scrollController = DefaultScrollController.maybeOf(context) ?? controller;
    final historyProvider = ref.watch(webSourceHistoryProvider);

    // Pre-initialize sources
    final _ = ref.watch(extensionInfoListProvider);

    return Material(
      child: switch (historyProvider) {
        AsyncValue(value: final history?) when history.isEmpty => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10.0,
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
                ElevatedButton.icon(
                  onPressed: () => openLinkDialog(context, api),
                  icon: const Icon(
                    Icons.link,
                  ),
                  label: const Text('Open Link'),
                ),
              ],
            ),
          ),
        AsyncValue(value: final history?) => WebMangaListWidget(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: scrollController,
            leading: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                title: Text(
                  'history.text'.tr(context: context),
                  style: TextStyle(fontSize: 24),
                ),
                actions: [
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
                        ref.read(webSourceHistoryProvider.clear)();
                      }
                    },
                    icon: const Icon(Icons.clear_all),
                    label: const Text('Clear History'),
                  ),
                ],
              ),
            ],
            children: [
              WebMangaListViewSliver(
                items: history.toList(),
                favoritesKey: defaultCategory,
                removeFromAll: true,
              ),
            ],
          ),
        AsyncValue(:final error?, :final stackTrace?) => ErrorList(error: error, stackTrace: stackTrace),
        _ => const Center(
            child: CircularProgressIndicator(),
          ),
      },
    );
  }
}
