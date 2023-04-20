import 'package:flutter/material.dart';
import 'package:gagaku/drawer.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WebGalleryHome extends ConsumerWidget {
  const WebGalleryHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(title: const Text("Web Gallery")),
        drawer: const MainDrawer(),
        body: const Center(child: Text("Web Gallery")));
  }
}
