import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/routes.gr.dart';
import 'package:gagaku/model/model.dart';
import 'package:gagaku/version.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class MainDrawer extends ConsumerWidget {
  const MainDrawer({super.key});

  static int _calculateSelectedIndex(BuildContext context) {
    final route = Uri.parse(AutoRouter.of(context).currentUrl);
    final path = route.path;

    if (path.startsWith(GagakuRoute.web) ||
        path.startsWith(GagakuRoute.extension)) {
      return 2;
    }

    switch (path) {
      case GagakuRoute.local:
        return 1;
      case GagakuRoute.config:
        return 3;
      case '/':
      case '/${GagakuRoute.chapterfeed}':
      case '/${GagakuRoute.library}':
      case '/${GagakuRoute.lists}':
      case '/${GagakuRoute.history}':
      default:
        return 0;
    }
  }

  void _onItemTapped(int index, BuildContext context) {
    Navigator.pop(context);

    switch (index) {
      case 0:
        AutoRouter.of(context).navigate(MangaDexHomeRoute());
        break;
      case 1:
        AutoRouter.of(context).navigate(LocalLibraryHomeRoute());
        break;
      case 2:
        AutoRouter.of(context).navigate(WebSourceHomeRoute());
        break;
      case 3:
        AutoRouter.of(context).navigate(AppSettingsRoute());
        break;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
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
          decoration: BoxDecoration(color: theme.colorScheme.primaryContainer),
          child: const Center(
            child: Column(
              children: [
                appicon,
                Text(
                  'Gagaku',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(1.0, 1.0),
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const NavigationDrawerDestination(
          icon: Icon(Icons.menu_book_outlined),
          selectedIcon: Icon(Icons.menu_book),
          label: Text('MangaDex'),
        ),
        NavigationDrawerDestination(
          icon: Icon(Icons.photo_album_outlined),
          selectedIcon: Icon(Icons.photo_album),
          label: Text(t.localLibrary.text),
        ),
        NavigationDrawerDestination(
          icon: Icon(Icons.language_outlined),
          selectedIcon: Icon(Icons.language),
          label: Text(t.webSources.text),
        ),
        NavigationDrawerDestination(
          icon: Icon(Icons.settings_outlined),
          selectedIcon: Icon(Icons.settings),
          label: Text(t.settings),
        ),
        const Divider(),
        AboutListTile(
          icon: const Icon(Icons.info),
          applicationIcon: appicon,
          applicationName: kPackageName,
          applicationVersion: kPackageVersion,
          applicationLegalese: '\u{a9} 2025 r52',
          aboutBoxChildren: [
            const SizedBox(height: 4),
            const Text('Flutter: $kFlutterFrameworkVersion'),
            const SizedBox(height: 4),
            const Text('Dart: $kFlutterDartSdkVersion'),
            const SizedBox(height: 4),
            const Text('Built on: $kBuildTimestamp'),
            const SizedBox(height: 4),
            const Text('License: MIT'),
            const SizedBox(height: 4),
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
    );
  }
}
