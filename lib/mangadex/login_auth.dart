import 'package:flutter/material.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/mangadex/model.dart';
import 'package:gagaku/ui.dart';
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
            onPressed: () =>
                {} /*ref.read(authControlProvider.notifier).login()*/,
            label: const Text('Login to MangaDex'),
            icon: const Icon(
              Icons.https,
            ),
          ),
        );
      case AsyncValue(:final error?, :final stackTrace?):
        logger.e("authControlProvider failed",
            error: error, stackTrace: stackTrace);
        return Styles.errorColumn(error, stackTrace);
      case _:
        return const Center(
          child: CircularProgressIndicator(),
        );
    }
  }
}
