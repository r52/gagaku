import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gagaku/model.dart';
import 'package:gagaku/version.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class MainDrawer extends ConsumerWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    const appicon = CircleAvatar(
      foregroundImage: AssetImage('assets/icon.png'),
    );

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
                children: [appicon, Text('Gagaku')],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.menu_book),
            title: const Text('MangaDex'),
            onTap: () {
              ref.read(homepageProvider.notifier).state = HomePage.mangadex;
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_album),
            title: const Text('Local Library'),
            onTap: () {
              ref.read(homepageProvider.notifier).state = HomePage.local;
            },
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Web Sources'),
            onTap: () {
              ref.read(homepageProvider.notifier).state = HomePage.web;
            },
          ),
          AboutListTile(
            icon: const Icon(Icons.info),
            applicationIcon: appicon,
            applicationName: 'Gagaku',
            applicationVersion: '1.0.0',
            applicationLegalese: '\u{a9} 2023 r52',
            aboutBoxChildren: [
              const SizedBox(
                height: 4,
              ),
              const Text('Flutter: $kFlutterFrameworkVersion'),
              const SizedBox(
                height: 4,
              ),
              const Text('Dart: $kFlutterDartSdkVersion'),
              const SizedBox(
                height: 4,
              ),
              const Text('Built on: $kBuildTimestamp'),
              const SizedBox(
                height: 4,
              ),
              const Text('License: MIT'),
              const SizedBox(
                height: 4,
              ),
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    const TextSpan(text: 'Source code available at '),
                    TextSpan(
                      style: const TextStyle(color: Colors.blue),
                      text: 'GitHub',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          launchUrl(Uri.parse('https://github.com/r52/gagaku'));
                        },
                    ),
                    const TextSpan(text: '.'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
