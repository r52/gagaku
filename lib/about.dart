import 'package:flutter/material.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/routes.dart';
import 'package:gagaku/model/update_metadata.dart';
import 'package:gagaku/update_checker.dart';
import 'package:gagaku/version.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

void showGagakuAboutDialog(
  BuildContext context,
  WidgetRef ref,
  UpdateInfo? updateInfo,
) {
  final t = context.t;
  // Capture services before the dialog opens: its originating shell may later
  // be disposed while the root navigator still owns the dialog.
  final metadata = ref.read(updateMetadataStoreProvider);
  final now = ref.read(updateCheckerNowProvider);
  Future<void> recordUpdateCheck() => metadata.recordUpdateCheck(now());

  showAboutDialog(
    context: context,
    applicationIcon: const CircleAvatar(
      foregroundImage: AssetImage('assets/icon.png'),
    ),
    applicationName: kPackageName,
    applicationVersion: kPackageVersion,
    applicationLegalese: '\u{a9} 2025 r52',
    children: [
      if (updateInfo != null) ...[
        Builder(
          builder: (dialogContext) => Align(
            alignment: AlignmentDirectional.centerStart,
            child: FilledButton.tonalIcon(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                final navContext = rootNavigatorKey.currentContext;
                if (navContext != null && navContext.mounted) {
                  showUpdateDialog(
                    navContext,
                    updateInfo,
                    onNotNow: recordUpdateCheck,
                    onDownload: recordUpdateCheck,
                  );
                }
              },
              icon: const Icon(Icons.system_update),
              label: Text(t.updates.updateAvailableTitle),
            ),
          ),
        ),
        const SizedBox(height: 4),
      ],
      const SizedBox(height: 4),
      Text(t.about.flutter(version: kFlutterFrameworkVersion)),
      const SizedBox(height: 4),
      Text(t.about.dart(version: kFlutterDartSdkVersion)),
      const SizedBox(height: 4),
      Text(t.about.builtOn(timestamp: kBuildTimestamp)),
      const SizedBox(height: 4),
      Text(t.about.license),
      const SizedBox(height: 4),
      Align(
        alignment: AlignmentDirectional.centerStart,
        child: TextButton(
          onPressed: () =>
              launchUrl(Uri.parse('https://github.com/r52/gagaku')),
          child: Text(t.about.sourceCode),
        ),
      ),
    ],
  );
}
