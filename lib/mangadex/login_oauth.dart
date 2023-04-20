import 'package:flutter/material.dart';
import 'package:gagaku/drawer.dart';
import 'package:gagaku/mangadex/model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MangaDexLoginWidget extends ConsumerWidget {
  const MangaDexLoginWidget({required this.builder, super.key});

  final Widget Function(BuildContext context, WidgetRef ref) builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authControlProvider);

    return auth.when(
      data: (loggedIn) {
        if (loggedIn) {
          return builder(context, ref);
        }

        return Scaffold(
            appBar: AppBar(title: const Text("Mangadex")),
            drawer: const MainDrawer(),
            body: Center(
              child: ElevatedButton.icon(
                onPressed: () =>
                    {} /*ref.read(authControlProvider.notifier).login()*/,
                label: const Text('Login to MangaDex'),
                icon: const Icon(
                  Icons.https,
                ),
              ),
            ));
      },
      loading: () => Scaffold(
        appBar: AppBar(title: const Text("Mangadex")),
        drawer: const MainDrawer(),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      error: (err, stack) => Text('Error: $err'),
    );
  }
}
