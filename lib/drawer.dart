import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gagaku/model.dart';
import 'package:gagaku/version.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:go_router/go_router.dart';

class MainDrawer extends ConsumerWidget {
  const MainDrawer({super.key});

  static int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();

    if (location.startsWith(GagakuRoute.web)) {
      return 2;
    }

    switch (location) {
      case GagakuRoute.local:
        return 1;
      case GagakuRoute.config:
        return 3;
      case '/':
      case GagakuRoute.chapterfeed:
      case GagakuRoute.library:
      case GagakuRoute.lists:
      case GagakuRoute.history:
      default:
        return 0;
    }
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        GoRouter.of(context).go('/');
        break;
      case 1:
        GoRouter.of(context).go(GagakuRoute.local);
        break;
      case 2:
        GoRouter.of(context).go(GagakuRoute.web);
        break;
      case 3:
        GoRouter.of(context).go(GagakuRoute.config);
        break;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final index = _calculateSelectedIndex(context);
    const appicon = CircleAvatar(
      foregroundImage: AssetImage('assets/icon.png'),
    );

    return NavigationDrawer(
      onDestinationSelected: (index) {
        _onItemTapped(index, context);
      },
      selectedIndex: index,
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
        const NavigationDrawerDestination(
          icon: Icon(Icons.menu_book_outlined),
          selectedIcon: Icon(Icons.menu_book),
          label: Text('MangaDex'),
        ),
        const NavigationDrawerDestination(
          icon: Icon(Icons.photo_album_outlined),
          selectedIcon: Icon(Icons.photo_album),
          label: Text('Local Library'),
        ),
        const NavigationDrawerDestination(
          icon: Icon(Icons.language_outlined),
          selectedIcon: Icon(Icons.language),
          label: Text('Web Sources'),
        ),
        const NavigationDrawerDestination(
          icon: Icon(Icons.settings_outlined),
          selectedIcon: Icon(Icons.settings),
          label: Text('Settings'),
        ),
        const Divider(),
        FutureBuilder(
          future: PackageInfo.fromPlatform(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return AboutListTile(
                icon: const Icon(Icons.info),
                applicationIcon: appicon,
                applicationName: snapshot.data!.appName,
                applicationVersion: snapshot.data!.version,
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
                              launchUrl(
                                  Uri.parse('https://github.com/r52/gagaku'));
                            },
                        ),
                        const TextSpan(text: '.'),
                      ],
                    ),
                  ),
                ],
              );
            }

            return const ListTile(
              leading: Icon(Icons.info),
              title: Text('About gagaku'),
            );
          },
        ),
      ],
    );
  }
}
