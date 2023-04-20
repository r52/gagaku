import 'package:flutter/material.dart';
import 'package:gagaku/drawer.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LocalLibraryHome extends ConsumerWidget {
  const LocalLibraryHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(title: const Text("Local Library")),
        drawer: const MainDrawer(),
        body: const Center(child: Text("Local Library")));
  }
}
