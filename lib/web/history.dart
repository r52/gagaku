import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/model/model.dart';
import 'package:gagaku/objectbox.g.dart';
import 'package:gagaku/util/default_scroll_controller.dart';
import 'package:gagaku/util/ui.dart';
import 'package:gagaku/web/model/model.dart';
import 'package:gagaku/web/model/types.dart';
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
    // final historyProvider = ref.watch(webSourceHistoryProvider);

    final query = useMemoized(() {
      final builder = GagakuData().store.box<HistoryLink>().query();
      builder.backlinkMany(
        WebFavoritesList_.list,
        WebFavoritesList_.id.equals(historyListUUID),
      );
      return builder
          .order(HistoryLink_.lastAccessed, flags: Order.descending)
          .watch(triggerImmediately: true)
          .map((query) => query.find());
    }, []);
    final stream = useStream(query);

    // Pre-initialize sources
    final _ = ref.watch(extensionInfoListProvider);

    return Material(
      child: switch (stream.connectionState) {
        // AsyncValue(value: final history?) when history.list.isEmpty =>
        ConnectionState.active
            when stream.data == null || stream.data!.isEmpty =>
          Center(
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
        // AsyncValue(value: final history?) =>
        ConnectionState.active when stream.hasError == false =>
          WebMangaListWidget(
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
                        WebHistoryManager().clear();
                      }
                    },
                    icon: const Icon(Icons.clear_all),
                    label: Text(tr.history.clear),
                  ),
                ],
              ),
            ],
            children: [WebMangaListViewSliver(items: stream.data!)],
          ),
        // AsyncValue(:final error?, :final stackTrace?) =>
        _ when stream.hasError => ErrorList(
          error: stream.error!,
          stackTrace: stream.stackTrace!,
        ),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}
