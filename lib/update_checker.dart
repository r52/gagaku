import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/model/config.dart';
import 'package:gagaku/util/http.dart';
import 'package:gagaku/version.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
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
  });

  final String version;
  final String? commitSha;
  final String releaseUrl;
  final DateTime publishedAt;
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

    // Check cooldown.
    final now = DateTime.now();
    final lastCheck = settings.lastUpdateCheck;
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
    final isIgnored = settings.ignoredUpdates.contains(
      settings.updateChannel == 'beta' ? info.commitSha : info.version,
    );

    return isIgnored ? UpdateResultIgnored(info) : UpdateResultAvailable(info);
  }

  /// Fetch the latest release from GitHub based on the selected channel.
  Future<UpdateInfo?> _fetchLatestRelease(String channel) async {
    final client = RateLimitedClient();
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
    final tagName = (data['tag_name'] as String).replaceAll('v', '');
    final htmlUrl = data['html_url'] as String;
    final publishedAt = DateTime.parse(data['published_at'] as String);

    return UpdateInfo(
      version: tagName,
      releaseUrl: htmlUrl,
      publishedAt: publishedAt,
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
      return _compareStable(info.version) > 0;
    } else {
      // Beta: compare commit SHA.
      if (kCommitSha == 'unknown' || info.commitSha == null) {
        return false;
      }
      return kCommitSha != info.commitSha;
    }
  }

  /// Compare two semver strings.
  /// Returns positive if [remote] is newer, negative if [local] is newer, 0 if equal.
  int _compareStable(String remote) {
    final localParts = _parseSemver(kPackageVersion);
    final remoteParts = _parseSemver(remote);

    final length = math.max(localParts.length, remoteParts.length);

    for (var i = 0; i < length; i++) {
      final l = localParts.length > i ? localParts[i] : 0;
      final r = remoteParts.length > i ? remoteParts[i] : 0;
      if (r > l) return 1;
      if (r < l) return -1;
    }
    return 0;
  }

  List<int> _parseSemver(String version) {
    // Strip pre-release suffix for basic comparison.
    final base = version.split('-').first;
    return base.split('.').map((part) => int.tryParse(part) ?? 0).toList();
  }
}

// ---------------------------------------------------------------------------
// Dialog
// ---------------------------------------------------------------------------

/// Show the update available dialog.
void showUpdateDialog(BuildContext context, UpdateInfo info) {
  final t = context.t;

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
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(t.updates.notNow),
          ),
          Consumer(
            builder: (context, ref, child) {
              return TextButton(
                onPressed: () async {
                  final cfg = ref.read(gagakuSettingsProvider);
                  final updated = cfg.copyWith(
                    ignoredUpdates: [
                      ...cfg.ignoredUpdates,
                      info.commitSha ?? info.version,
                    ],
                  );
                  ref.read(gagakuSettingsProvider.notifier).save(updated);
                  Navigator.of(dialogContext).pop();
                },
                child: child!,
              );
            },
            child: Text(t.updates.ignoreThisVersion),
          ),
          FilledButton(
            onPressed: () async {
              final uri = Uri.parse(info.releaseUrl);
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              }
              if (dialogContext.mounted) {
                Navigator.of(dialogContext).pop();
              }
            },
            child: Text(t.updates.download),
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
