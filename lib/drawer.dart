import 'package:flutter/material.dart';
import 'package:gagaku/model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MainDrawer extends ConsumerWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
            ),
            child: const Center(
              child: Column(
                children: [
                  CircleAvatar(
                    foregroundImage: AssetImage('assets/icon.png'),
                  ),
                  Text('Gagaku')
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.menu_book),
            title: const Text('MangaDex'),
            onTap: () {
              ref.read(homepageProvider.notifier).state = HomePage.mangadex;
              //Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_album),
            title: const Text('Local Library'),
            onTap: () {
              ref.read(homepageProvider.notifier).state = HomePage.local;
              //Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Web Sources'),
            onTap: () {
              ref.read(homepageProvider.notifier).state = HomePage.web;
              //Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About'),
            onTap: () {
              ref.read(homepageProvider.notifier).state = HomePage.about;
            },
          ),
        ],
      ),
    );
  }
}
