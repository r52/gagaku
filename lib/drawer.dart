import 'package:cached_network_image_ce/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/mangadex/model/model.dart';
import 'package:gagaku/mangadex/model/types.dart';
import 'package:gagaku/model/model.dart';
import 'package:gagaku/model/update_metadata.dart';
import 'package:gagaku/routes.dart';
import 'package:gagaku/update_checker.dart';
import 'package:gagaku/util/cached_network_image.dart';
import 'package:gagaku/version.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class MainDrawer extends ConsumerStatefulWidget {
  const MainDrawer({super.key});

  @override
  ConsumerState<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends ConsumerState<MainDrawer> {
  static int _calculateSelectedIndex(BuildContext context) {
    final route = GoRouterState.of(context).uri;
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
      case GagakuRoute.chapterfeed:
      case GagakuRoute.library:
      case GagakuRoute.lists:
      case GagakuRoute.history:
      default:
        return 0;
    }
  }

  void _onItemTapped(int index) {
    Navigator.pop(context);

    switch (index) {
      case 0:
        const MangaDexFrontRoute().go(context);
        break;
      case 1:
        const LocalLibraryHomeRoute().go(context);
        break;
      case 2:
        const WebSourceFrontRoute().go(context);
        break;
      case 3:
        const AppSettingsRoute().go(context);
        break;
    }
  }

  Future<void> _recordUpdateCheck() async {
    await ref
        .read(updateMetadataStoreProvider)
        .recordUpdateCheck(ref.read(updateCheckerNowProvider)());
  }

  void _showAvailableUpdateDialog(UpdateInfo info) {
    final navContext = rootNavigatorKey.currentContext;
    if (navContext != null && navContext.mounted) {
      showUpdateDialog(
        navContext,
        info,
        onNotNow: _recordUpdateCheck,
        onDownload: _recordUpdateCheck,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final theme = Theme.of(context);
    final index = _calculateSelectedIndex(context);
    final me = ref.watch(loggedUserProvider).value;
    final imageCache = ref.watch(extensionImageCacheProvider);
    final avatarUrl = me?.getUserAvatar(quality: CoverArtQuality.small);
    final updateInfo = switch (ref.watch(updateCheckerProvider)) {
      AsyncData(value: UpdateResultAvailable(:final info)) => info,
      _ => null,
    };
    const appicon = CircleAvatar(
      foregroundImage: AssetImage('assets/icon.png'),
    );

    return NavigationDrawer(
      onDestinationSelected: (index) => _onItemTapped(index),
      selectedIndex: index,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(color: theme.colorScheme.primaryContainer),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: me != null
                ? Center(
                    key: const ValueKey('user'),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          foregroundImage: avatarUrl != null
                              ? CachedNetworkImageProvider(
                                  avatarUrl,
                                  cacheManager: imageCache,
                                )
                              : null,
                          child: const Icon(Icons.person, size: 30),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          me.attributes?.username ?? '',
                          style: const TextStyle(
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
                  )
                : Center(
                    key: const ValueKey('branding'),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        appicon,
                        const Text(
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
          icon: updateInfo == null
              ? const Icon(Icons.info)
              : const Badge(child: Icon(Icons.info)),
          applicationIcon: appicon,
          applicationName: kPackageName,
          applicationVersion: kPackageVersion,
          applicationLegalese: '\u{a9} 2025 r52',
          aboutBoxChildren: [
            if (updateInfo != null) ...[
              Builder(
                builder: (dialogContext) {
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: FilledButton.tonalIcon(
                      onPressed: () {
                        Navigator.of(dialogContext).pop();
                        _showAvailableUpdateDialog(updateInfo);
                      },
                      icon: const Icon(Icons.system_update),
                      label: Text(t.updates.updateAvailableTitle),
                    ),
                  );
                },
              ),
              const SizedBox(height: 4),
            ],
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
