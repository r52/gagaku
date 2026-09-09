import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/model/config.dart';
import 'package:gagaku/model/update_metadata.dart';
import 'package:gagaku/update_installer.dart';
import 'package:gagaku/util/http.dart';
import 'package:gagaku/version.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:pub_semver/pub_semver.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

part 'update_checker.g.dart';

// ---------------------------------------------------------------------------
// Data model
// ---------------------------------------------------------------------------

/// Information about an available update.
class UpdateInfo {
  const UpdateInfo({
    required this.version,
    this.commitSha,
    required this.releaseUrl,
    required this.publishedAt,
    this.androidAsset,
  });

  final String version;
  final String? commitSha;
  final String releaseUrl;
  final DateTime publishedAt;
  final AndroidUpdateAsset? androidAsset;
}

/// Result of an update check.
sealed class UpdateResult {
  const UpdateResult();
}

class UpdateResultUpToDate extends UpdateResult {
  const UpdateResultUpToDate({this.checked = false});

  final bool checked;
}

class UpdateResultAvailable extends UpdateResult {
  final UpdateInfo info;
  const UpdateResultAvailable(this.info);
}

class UpdateResultIgnored extends UpdateResult {
  final UpdateInfo info;
  const UpdateResultIgnored(this.info);
}

// ---------------------------------------------------------------------------
// Constants
// ---------------------------------------------------------------------------

const _githubApiBase = 'https://api.github.com';
const _githubRepo = 'r52/gagaku';

final updateCheckerHttpClientFactoryProvider = Provider<http.Client Function()>(
  (ref) => RateLimitedClient.new,
);

final updateCheckerNowProvider = Provider<DateTime Function()>(
  (ref) => DateTime.now,
);

final updateCheckerIsReleaseBuildProvider = Provider<bool>(
  (ref) => kReleaseMode,
);

// ---------------------------------------------------------------------------
// Provider
// ---------------------------------------------------------------------------

@riverpod
class UpdateChecker extends _$UpdateChecker {
  @override
  FutureOr<UpdateResult> build() async {
    return _checkForUpdates();
  }

  Future<UpdateResult> _checkForUpdates() async {
    final settings = ref.read(gagakuSettingsProvider);

    // If checking is disabled, skip.
    if (!settings.checkForUpdates) {
      return const UpdateResultUpToDate();
    }

    if (!ref.read(updateCheckerIsReleaseBuildProvider)) {
      return const UpdateResultUpToDate();
    }

    // Check cooldown.
    final now = ref.read(updateCheckerNowProvider)();
    final metadata = ref.read(updateMetadataStoreProvider);
    final lastCheck = metadata.lastUpdateCheck;
    if (lastCheck != null) {
      final elapsed = now.difference(lastCheck);
      final cooldown = Duration(hours: settings.updateCheckCooldownHours);
      if (elapsed < cooldown) {
        logger.d(
          'Update check skipped: cooldown not elapsed (${elapsed.inMinutes}m / ${settings.updateCheckCooldownHours}h)',
        );
        return const UpdateResultUpToDate();
      }
    }

    // Fetch latest release from GitHub.
    final UpdateInfo? info;
    try {
      info = await _fetchLatestRelease(settings.updateChannel);
    } catch (e, st) {
      logger.w('Update check failed', error: e, stackTrace: st);
      return const UpdateResultUpToDate();
    }

    if (info == null) {
      return const UpdateResultUpToDate();
    }

    // Compare with current version.
    final bool isUpdateAvailable;
    try {
      isUpdateAvailable = _isUpdateAvailable(settings.updateChannel, info);
    } catch (e, st) {
      logger.w('Version comparison failed', error: e, stackTrace: st);
      return const UpdateResultUpToDate();
    }

    if (!isUpdateAvailable) {
      return const UpdateResultUpToDate(checked: true);
    }

    // Check if ignored.
    final isIgnored = metadata.ignoredUpdates.contains(
      settings.updateChannel == 'beta' ? info.commitSha : info.version,
    );

    return isIgnored ? UpdateResultIgnored(info) : UpdateResultAvailable(info);
  }

  /// Fetch the latest release from GitHub based on the selected channel.
  Future<UpdateInfo?> _fetchLatestRelease(String channel) async {
    final client = ref.read(updateCheckerHttpClientFactoryProvider)();
    try {
      if (channel == 'stable') {
        return await _fetchStableRelease(client);
      } else {
        return await _fetchBetaRelease(client);
      }
    } finally {
      client.close();
    }
  }

  /// Fetch the latest stable (non-prerelease) release.
  Future<UpdateInfo?> _fetchStableRelease(http.Client client) async {
    final uri = Uri.https(
      _githubApiBase.replaceFirst('https://', ''),
      '/repos/$_githubRepo/releases/latest',
    );

    final response = await client.get(
      uri,
      headers: {'Accept': 'application/vnd.github.v3+json'},
    );

    if (response.statusCode != 200) {
      logger.w(
        'Failed to fetch latest stable release: HTTP ${response.statusCode}',
      );
      return null;
    }

    final data = json.decode(response.body) as Map<String, dynamic>;
    final tagName = normalizeStableVersion(data['tag_name'] as String);
    final htmlUrl = data['html_url'] as String;
    final publishedAt = DateTime.parse(data['published_at'] as String);

    return UpdateInfo(
      version: tagName,
      releaseUrl: htmlUrl,
      publishedAt: publishedAt,
      androidAsset: AndroidUpdateAsset.fromReleaseJson(data),
    );
  }

  /// Fetch the latest beta (dev-preview) release.
  Future<UpdateInfo?> _fetchBetaRelease(http.Client client) async {
    final uri = Uri.https(
      _githubApiBase.replaceFirst('https://', ''),
      '/repos/$_githubRepo/releases',
    );

    final response = await client.get(
      uri,
      headers: {'Accept': 'application/vnd.github.v3+json'},
    );

    if (response.statusCode != 200) {
      logger.w('Failed to fetch beta releases: HTTP ${response.statusCode}');
      return null;
    }

    final List<dynamic> releases = json.decode(response.body) as List;

    UpdateInfo? devPreview;
    for (final release in releases) {
      final data = release as Map<String, dynamic>;
      if (data['tag_name'] == 'dev-preview') {
        final body = data['body'] as String? ?? '';
        final shaMatch = RegExp(
          r'Built from commit ([0-9a-f]{40})',
        ).firstMatch(body);
        final commitSha = shaMatch?.group(1);

        devPreview = UpdateInfo(
          version: data['name'] as String? ?? 'Dev Preview',
          commitSha: commitSha,
          releaseUrl: data['html_url'] as String,
          publishedAt: DateTime.parse(data['published_at'] as String),
          androidAsset: AndroidUpdateAsset.fromReleaseJson(data),
        );
        break;
      }
    }

    if (devPreview == null) {
      logger.w('No dev-preview release found');
      return null;
    }

    if (devPreview.commitSha == null) {
      logger.w('dev-preview release body has no commit SHA');
      return null;
    }

    return devPreview;
  }

  /// Compare the latest release with the current app version.
  bool _isUpdateAvailable(String channel, UpdateInfo info) {
    if (channel == 'stable') {
      return isStableUpdateAvailable(remoteVersion: info.version);
    } else {
      // Beta: compare commit SHA.
      if (kCommitSha == 'unknown' || info.commitSha == null) {
        return false;
      }
      return kCommitSha != info.commitSha;
    }
  }
}

bool shouldRecordUpdateCheck(UpdateResult result) => switch (result) {
  UpdateResultUpToDate(checked: true) || UpdateResultIgnored() => true,
  _ => false,
};

bool isStableUpdateAvailable({
  String currentVersion = kPackageVersion,
  required String remoteVersion,
}) {
  final current = parseStableVersionForPrecedence(currentVersion);
  final remote = parseStableVersionForPrecedence(remoteVersion);
  return remote > current;
}

Version parseStableVersionForPrecedence(String version) {
  final normalized = normalizeStableVersion(version);
  return Version.parse(normalized.split('+').first);
}

String normalizeStableVersion(String version) {
  return version.trim().replaceFirst(RegExp(r'^[vV]'), '');
}

// ---------------------------------------------------------------------------
// Dialog
// ---------------------------------------------------------------------------

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showUpdateSnackBar(
  BuildContext context,
  UpdateInfo info, {
  FutureOr<void> Function()? onDismissed,
  FutureOr<void> Function()? onNotNow,
  FutureOr<void> Function()? onDownload,
}) {
  final t = context.t;
  final messenger = ScaffoldMessenger.of(context);

  final controller = messenger.showSnackBar(
    SnackBar(
      content: Text(t.updates.updateAvailableSnack),
      action: SnackBarAction(
        label: t.updates.viewUpdate,
        onPressed: () {
          showUpdateDialog(
            context,
            info,
            onNotNow: onNotNow,
            onDownload: onDownload,
          );
        },
      ),
    ),
  );

  unawaited(
    controller.closed.then((reason) async {
      if (reason != SnackBarClosedReason.action) {
        await onDismissed?.call();
      }
    }),
  );

  return controller;
}

/// Show the update available dialog.
void showUpdateDialog(
  BuildContext context,
  UpdateInfo info, {
  FutureOr<void> Function()? onNotNow,
  FutureOr<void> Function()? onDownload,
}) {
  final t = context.t;
  final canInstallDirectly =
      !kIsWeb &&
      defaultTargetPlatform == TargetPlatform.android &&
      info.androidAsset != null;

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Text(t.updates.updateAvailableTitle),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (info.commitSha != null)
                Text(
                  t.updates.updateAvailableBetaBody(
                    currentVersion: _shortSha(kCommitSha),
                    latestVersion:
                        '${_shortSha(info.commitSha!)} (${info.version})',
                  ),
                )
              else
                Text(
                  t.updates.updateAvailableBody(
                    currentVersion: kPackageVersion,
                    newVersion: info.version,
                  ),
                ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              await onNotNow?.call();
              if (dialogContext.mounted) {
                Navigator.of(dialogContext).pop();
              }
            },
            child: Text(t.updates.notNow),
          ),
          Consumer(
            builder: (context, ref, child) {
              return TextButton(
                onPressed: () async {
                  await ref
                      .read(updateMetadataStoreProvider)
                      .ignoreUpdate(
                        info.commitSha ?? info.version,
                        ref.read(updateCheckerNowProvider)(),
                      );
                  if (dialogContext.mounted) {
                    Navigator.of(dialogContext).pop();
                  }
                },
                child: child!,
              );
            },
            child: Text(t.updates.ignoreThisVersion),
          ),
          FilledButton(
            onPressed: () async {
              if (canInstallDirectly) {
                await onDownload?.call();
                if (dialogContext.mounted) {
                  Navigator.of(dialogContext).pop();
                }
                if (context.mounted) {
                  unawaited(
                    showAndroidUpdateInstallerDialog(
                      context,
                      info.androidAsset!,
                    ),
                  );
                }
                return;
              }

              final uri = Uri.parse(info.releaseUrl);
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              }
              await onDownload?.call();
              if (dialogContext.mounted) {
                Navigator.of(dialogContext).pop();
              }
            },
            child: Text(
              canInstallDirectly
                  ? t.updates.downloadAndUpdate
                  : t.updates.download,
            ),
          ),
        ],
      );
    },
  );
}

/// Shorten a commit SHA to its first 7 characters.
String _shortSha(String sha) {
  return sha.length > 7 ? sha.substring(0, 7) : sha;
}
