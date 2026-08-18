import 'dart:async';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/log.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:open_filex/open_filex.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

const _apkMimeType = 'application/vnd.android.package-archive';
const _updateCacheDirectoryName = 'gagaku-updates';
const _updateApkFileName = 'gagaku-update.apk';
const _partialUpdateApkFileName = 'gagaku-update.apk.part';

class AndroidUpdateAsset {
  const AndroidUpdateAsset({
    required this.downloadUrl,
    required this.size,
    required this.sha256Digest,
  });

  final Uri downloadUrl;
  final int size;
  final String sha256Digest;

  static AndroidUpdateAsset? fromReleaseJson(Map<String, dynamic> release) {
    final assets = release['assets'];
    if (assets is! List) {
      return null;
    }

    for (final value in assets) {
      if (value is! Map<String, dynamic> ||
          value['name'] != 'app-release.apk' ||
          value['state'] != 'uploaded' ||
          value['content_type'] != _apkMimeType) {
        continue;
      }

      final rawUrl = value['browser_download_url'];
      final size = value['size'];
      final digest = value['digest'];
      if (rawUrl is! String || size is! int || size <= 0 || digest is! String) {
        continue;
      }

      final uri = Uri.tryParse(rawUrl);
      final digestMatch = RegExp(
        r'^sha256:([0-9a-fA-F]{64})$',
      ).firstMatch(digest);
      if (uri == null ||
          uri.scheme != 'https' ||
          uri.host != 'github.com' ||
          digestMatch == null) {
        continue;
      }

      return AndroidUpdateAsset(
        downloadUrl: uri,
        size: size,
        sha256Digest: digestMatch.group(1)!.toLowerCase(),
      );
    }

    return null;
  }
}

enum UpdateInstallFailure {
  permissionDenied,
  download,
  verification,
  installer,
  notCompleted,
}

class UpdateInstallException implements Exception {
  const UpdateInstallException(this.failure, [this.details]);

  final UpdateInstallFailure failure;
  final Object? details;

  @override
  String toString() => 'UpdateInstallException($failure, $details)';
}

class UpdateApkLaunchResult {
  const UpdateApkLaunchResult.success() : error = null;
  const UpdateApkLaunchResult.failure(this.error);

  final String? error;
  bool get launched => error == null;
}

final updateDownloadClientFactoryProvider = Provider<http.Client Function()>(
  (ref) => http.Client.new,
);

final updateTemporaryDirectoryProvider = Provider<Future<Directory> Function()>(
  (ref) => getTemporaryDirectory,
);

final updateInstallPermissionProvider = Provider<Future<bool> Function()>(
  (ref) => () async {
    final status = await Permission.requestInstallPackages.request();
    return status.isGranted;
  },
);

final updateApkLauncherProvider =
    Provider<Future<UpdateApkLaunchResult> Function(String)>((ref) {
      return (path) async {
        final result = await OpenFilex.open(path, type: _apkMimeType);
        return result.type == ResultType.done
            ? const UpdateApkLaunchResult.success()
            : UpdateApkLaunchResult.failure(result.message);
      };
    });

Future<void> cleanupCachedUpdateFiles({
  Future<Directory> Function()? temporaryDirectory,
}) async {
  if (kIsWeb || defaultTargetPlatform != TargetPlatform.android) {
    return;
  }

  try {
    final cacheRoot = await (temporaryDirectory ?? getTemporaryDirectory)();
    final updateDirectory = Directory(
      p.join(cacheRoot.path, _updateCacheDirectoryName),
    );
    if (await updateDirectory.exists()) {
      await updateDirectory.delete(recursive: true);
    }
  } catch (error, stackTrace) {
    logger.w(
      'Failed to clean cached update files',
      error: error,
      stackTrace: stackTrace,
    );
  }
}

Future<File> downloadAndroidUpdate({
  required AndroidUpdateAsset asset,
  required http.Client client,
  required Directory cacheRoot,
  required void Function(int received, int total) onProgress,
  required VoidCallback onVerifying,
}) async {
  final updateDirectory = Directory(
    p.join(cacheRoot.path, _updateCacheDirectoryName),
  );
  await updateDirectory.create(recursive: true);

  final partialFile = File(
    p.join(updateDirectory.path, _partialUpdateApkFileName),
  );
  final completedFile = File(p.join(updateDirectory.path, _updateApkFileName));
  await _deleteIfPresent(partialFile);
  await _deleteIfPresent(completedFile);

  try {
    final request = http.Request('GET', asset.downloadUrl);
    final response = await client.send(request);
    if (response.statusCode != HttpStatus.ok) {
      throw UpdateInstallException(
        UpdateInstallFailure.download,
        'HTTP ${response.statusCode}',
      );
    }
    if (response.contentLength case final length? when length != asset.size) {
      throw UpdateInstallException(
        UpdateInstallFailure.verification,
        'Expected ${asset.size} bytes but server reported $length',
      );
    }

    final digestSink = _DigestSink();
    final digestInput = sha256.startChunkedConversion(digestSink);
    final fileSink = partialFile.openWrite();
    var received = 0;
    var lastReported = 0;

    try {
      await for (final chunk in response.stream) {
        received += chunk.length;
        if (received > asset.size) {
          throw UpdateInstallException(
            UpdateInstallFailure.verification,
            'Downloaded more than the expected ${asset.size} bytes',
          );
        }
        fileSink.add(chunk);
        digestInput.add(chunk);
        if (received == asset.size || received - lastReported >= 256 * 1024) {
          lastReported = received;
          onProgress(received, asset.size);
        }
      }
    } finally {
      await fileSink.close();
      digestInput.close();
    }

    onVerifying();
    if (received != asset.size) {
      throw UpdateInstallException(
        UpdateInstallFailure.verification,
        'Expected ${asset.size} bytes but downloaded $received',
      );
    }
    if (digestSink.value.toString().toLowerCase() != asset.sha256Digest) {
      throw const UpdateInstallException(
        UpdateInstallFailure.verification,
        'SHA-256 digest mismatch',
      );
    }

    return await partialFile.rename(completedFile.path);
  } on UpdateInstallException {
    await _deleteIfPresent(partialFile);
    await _deleteIfPresent(completedFile);
    rethrow;
  } catch (error) {
    await _deleteIfPresent(partialFile);
    await _deleteIfPresent(completedFile);
    throw UpdateInstallException(UpdateInstallFailure.download, error);
  }
}

Future<void> _deleteIfPresent(File file) async {
  if (await file.exists()) {
    await file.delete();
  }
}

class _DigestSink implements Sink<Digest> {
  Digest? _value;

  Digest get value => _value!;

  @override
  void add(Digest data) {
    _value = data;
  }

  @override
  void close() {}
}

enum _UpdateInstallStage {
  requestingPermission,
  downloading,
  verifying,
  launching,
  waitingForInstaller,
  failed,
}

Future<void> showAndroidUpdateInstallerDialog(
  BuildContext context,
  AndroidUpdateAsset asset,
) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (context) => _AndroidUpdateInstallerDialog(asset: asset),
  );
}

class _AndroidUpdateInstallerDialog extends ConsumerStatefulWidget {
  const _AndroidUpdateInstallerDialog({required this.asset});

  final AndroidUpdateAsset asset;

  @override
  ConsumerState<_AndroidUpdateInstallerDialog> createState() =>
      _AndroidUpdateInstallerDialogState();
}

class _AndroidUpdateInstallerDialogState
    extends ConsumerState<_AndroidUpdateInstallerDialog>
    with WidgetsBindingObserver {
  _UpdateInstallStage _stage = _UpdateInstallStage.requestingPermission;
  UpdateInstallFailure? _failure;
  int _received = 0;
  bool _installerBackgrounded = false;
  File? _downloadedApk;

  bool get _canDismiss => _stage == _UpdateInstallStage.failed;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    unawaited(_run());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_stage != _UpdateInstallStage.launching &&
        _stage != _UpdateInstallStage.waitingForInstaller) {
      return;
    }

    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused ||
        state == AppLifecycleState.hidden) {
      _installerBackgrounded = true;
    } else if (state == AppLifecycleState.resumed && _installerBackgrounded) {
      _fail(UpdateInstallFailure.notCompleted);
    }
  }

  Future<void> _run() async {
    _installerBackgrounded = false;
    _setStage(_UpdateInstallStage.requestingPermission);

    try {
      final permitted = await ref.read(updateInstallPermissionProvider)();
      if (!permitted) {
        throw const UpdateInstallException(
          UpdateInstallFailure.permissionDenied,
        );
      }

      _setStage(_UpdateInstallStage.downloading);
      final cacheRoot = await ref.read(updateTemporaryDirectoryProvider)();
      final client = ref.read(updateDownloadClientFactoryProvider)();
      try {
        _downloadedApk = await downloadAndroidUpdate(
          asset: widget.asset,
          client: client,
          cacheRoot: cacheRoot,
          onProgress: (received, total) {
            if (!mounted) return;
            setState(() => _received = received);
          },
          onVerifying: () => _setStage(_UpdateInstallStage.verifying),
        );
      } finally {
        client.close();
      }

      _setStage(_UpdateInstallStage.launching);
      final result = await ref.read(updateApkLauncherProvider)(
        _downloadedApk!.path,
      );
      if (!result.launched) {
        throw UpdateInstallException(
          UpdateInstallFailure.installer,
          result.error,
        );
      }
      _setStage(_UpdateInstallStage.waitingForInstaller);
    } on UpdateInstallException catch (error, stackTrace) {
      logger.w('Android update failed', error: error, stackTrace: stackTrace);
      _fail(error.failure);
    } catch (error, stackTrace) {
      logger.w('Android update failed', error: error, stackTrace: stackTrace);
      _fail(UpdateInstallFailure.installer);
    }
  }

  void _setStage(_UpdateInstallStage stage) {
    if (!mounted) return;
    setState(() {
      _stage = stage;
      if (stage != _UpdateInstallStage.failed) {
        _failure = null;
      }
    });
  }

  void _fail(UpdateInstallFailure failure) {
    if (!mounted || _stage == _UpdateInstallStage.failed) return;
    setState(() {
      _stage = _UpdateInstallStage.failed;
      _failure = failure;
    });
    unawaited(_deleteDownloadedApk());
  }

  Future<void> _deleteDownloadedApk() async {
    final file = _downloadedApk;
    _downloadedApk = null;
    if (file != null) {
      try {
        await _deleteIfPresent(file);
      } catch (error, stackTrace) {
        logger.w(
          'Failed to remove downloaded update',
          error: error,
          stackTrace: stackTrace,
        );
      }
    }
  }

  Future<void> _retry() async {
    await _deleteDownloadedApk();
    if (!mounted) return;
    setState(() {
      _received = 0;
      _failure = null;
    });
    await _run();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return PopScope(
      canPop: _canDismiss,
      child: AlertDialog(
        title: Text(t.updates.updatingTitle),
        content: switch (_stage) {
          _UpdateInstallStage.requestingPermission => _ProgressMessage(
            message: t.updates.preparingUpdate,
          ),
          _UpdateInstallStage.downloading => Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(t.updates.downloadingUpdate),
              const SizedBox(height: 16),
              LinearProgressIndicator(value: _received / widget.asset.size),
              const SizedBox(height: 8),
              Text(
                t.updates.downloadProgress(
                  downloaded: _formatBytes(_received),
                  total: _formatBytes(widget.asset.size),
                  percent: ((_received / widget.asset.size) * 100).floor(),
                ),
              ),
            ],
          ),
          _UpdateInstallStage.verifying => _ProgressMessage(
            message: t.updates.verifyingUpdate,
          ),
          _UpdateInstallStage.launching ||
          _UpdateInstallStage.waitingForInstaller => _ProgressMessage(
            message: t.updates.updating,
          ),
          _UpdateInstallStage.failed => Text(_failureMessage(t)),
        },
        actions: _canDismiss
            ? [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(t.updates.close),
                ),
                FilledButton(onPressed: _retry, child: Text(t.ui.retry)),
              ]
            : null,
      ),
    );
  }

  String _failureMessage(Translations t) => switch (_failure) {
    UpdateInstallFailure.permissionDenied => t.updates.installPermissionDenied,
    UpdateInstallFailure.download => t.updates.downloadFailed,
    UpdateInstallFailure.verification => t.updates.verificationFailed,
    UpdateInstallFailure.installer => t.updates.installerFailed,
    UpdateInstallFailure.notCompleted => t.updates.installNotCompleted,
    null => t.updates.installerFailed,
  };
}

class _ProgressMessage extends StatelessWidget {
  const _ProgressMessage({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(strokeWidth: 3),
        ),
        const SizedBox(width: 16),
        Flexible(child: Text(message)),
      ],
    );
  }
}

String _formatBytes(int bytes) {
  const mebibyte = 1024 * 1024;
  return '${(bytes / mebibyte).toStringAsFixed(1)} MB';
}
