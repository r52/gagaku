import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gagaku/mangadex/model.dart';
import 'package:gagaku/util/ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MangaDexLoginWidget extends ConsumerWidget {
  const MangaDexLoginWidget({required this.builder, super.key});

  final Widget Function(BuildContext context, WidgetRef ref) builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authControlProvider);

    switch (auth) {
      case AsyncValue(value: final loggedin?):
        if (loggedin) {
          return builder(context, ref);
        }

        return Center(
          child: ElevatedButton.icon(
            onPressed: () => {} /*ref.read(authControlProvider.notifier).login()*/,
            label: Text('mangadex.login'.tr(context: context)),
            icon: const Icon(
              Icons.https,
            ),
          ),
        );
      case AsyncValue(:final error?, :final stackTrace?):
        return ErrorColumn(
          error: error,
          stackTrace: stackTrace,
          message: "authControlProvider failed",
        );
      case _:
        return const Center(
          child: CircularProgressIndicator(),
        );
    }
  }
}
