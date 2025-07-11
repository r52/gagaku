import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/util/default_scroll_controller.dart';
import 'package:gagaku/util/ui.dart';
import 'package:gagaku/web/model/model.dart';
import 'package:gagaku/web/ui.dart';
import 'package:gagaku/web/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class WebSourceHistoryPage extends HookConsumerWidget {
  const WebSourceHistoryPage({super.key, this.controller});

  final ScrollController? controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tr = context.t;
    final api = ref.watch(proxyProvider);

    final scrollController =
        DefaultScrollController.maybeOf(context, 'WebSourceHistoryPage') ??
        controller ??
        useScrollController();
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
              Tooltip(
                message: tr.webSources.supportedUrl.arg(
                  arg: '\ncubari.moe\nimgur.com',
                ),
                padding: EdgeInsets.all(6),
                triggerMode: TooltipTriggerMode.tap,
                child: Wrap(
                  children: [
                    Text(tr.webSources.supportedUrl.text),
                    Icon(Icons.help, size: 20),
                  ],
                ),
              ),
              ElevatedButton.icon(
                onPressed: () => openLinkDialog(context, api),
                icon: const Icon(Icons.link),
                label: Text(tr.webSources.openLink),
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
              title: Text(tr.history.text, style: TextStyle(fontSize: 24)),
              actions: [
                ElevatedButton.icon(
                  style: Styles.buttonStyle(),
                  onPressed: () async {
                    final result = await showDialog<bool>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(tr.history.clear),
                          content: Text(tr.history.clearWarning),
                          actions: <Widget>[
                            TextButton(
                              child: Text(tr.ui.no),
                              onPressed: () {
                                Navigator.of(context).pop(false);
                              },
                            ),
                            ElevatedButton(
                              child: Text(tr.ui.yes),
                              onPressed: () {
                                Navigator.of(context).pop(true);
                              },
                            ),
                          ],
                        );
                      },
                    );

                    if (result == true) {
                      webSourceHistoryMutation.run(ref, (ref) async {
                        return await ref
                            .get(webSourceHistoryProvider.notifier)
                            .clear();
                      });
                    }
                  },
                  icon: const Icon(Icons.clear_all),
                  label: Text(tr.history.clear),
                ),
              ],
            ),
          ],
          children: [WebMangaListViewSliver(items: history.toList())],
        ),
        AsyncValue(:final error?, :final stackTrace?) => ErrorList(
          error: error,
          stackTrace: stackTrace,
        ),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}
