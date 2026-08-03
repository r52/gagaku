import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/sync/coordinator.dart';
import 'package:gagaku/sync/metadata.dart';
import 'package:gagaku/sync/protocol.dart';
import 'package:gagaku/sync/service.dart';
import 'package:gagaku/util/ui.dart';

final class SyncSettingsSection extends StatefulWidget {
  const SyncSettingsSection({super.key, this.service});

  final GagakuSyncService? service;

  @override
  State<SyncSettingsSection> createState() => _SyncSettingsSectionState();
}

final class _SyncSettingsSectionState extends State<SyncSettingsSection> {
  late final GagakuSyncService _service = widget.service ?? GagakuSyncService();
  SyncLocalState? _state;
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    _service.addListener(_reload);
    _reload();
  }

  @override
  void dispose() {
    _service.removeListener(_reload);
    super.dispose();
  }

  Future<void> _reload() async {
    final state = await _service.readState();
    if (mounted) setState(() => _state = state);
  }

  Future<void> _run(Future<void> Function() action) async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      await action();
      await _reload();
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(context.t.sync.operationFailed(error: '$error')),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<String?> _askDeviceName() async {
    var value = _state?.deviceName.isNotEmpty == true
        ? _state!.deviceName
        : context.t.sync.defaultDeviceName;
    return showDialog<String>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(context.t.sync.deviceName),
        content: TextFormField(
          initialValue: value,
          autofocus: true,
          maxLength: 80,
          decoration: InputDecoration(labelText: context.t.sync.deviceName),
          onChanged: (newValue) => value = newValue,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(context.t.ui.cancel),
          ),
          FilledButton(
            onPressed: () {
              final trimmed = value.trim();
              if (trimmed.isNotEmpty) Navigator.pop(dialogContext, trimmed);
            },
            child: Text(context.t.sync.save),
          ),
        ],
      ),
    );
  }

  Future<String?> _pickDirectory() async {
    final dialogTitle = context.t.sync.directoryRequired;
    if (Platform.isAndroid) {
      final permission = await Permission.manageExternalStorage.request();
      if (!permission.isGranted) return null;
    }
    return FilePicker.getDirectoryPath(dialogTitle: dialogTitle);
  }

  Future<void> _configure(SyncProfileMode mode) async {
    final deviceName = await _askDeviceName();
    if (deviceName == null || !mounted) return;
    final directory = await _pickDirectory();
    if (directory == null) return;
    await _run(() async {
      await _service.configureFilesystem(
        rootPath: directory,
        mode: mode,
        deviceName: deviceName,
      );
    });
  }

  Future<bool> _confirm(String title, String message) async =>
      (await showDialog<bool>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: Text(context.t.ui.cancel),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: Text(context.t.ui.yes),
            ),
          ],
        ),
      )) ==
      true;

  Future<void> _showConflict() async {
    final heads = _service.status.forkHeads;
    if (heads.isEmpty) return;
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(context.t.sync.conflict),
        content: SizedBox(
          width: 520,
          child: ListView(
            shrinkWrap: true,
            children: [
              Text(context.t.sync.conflictSub),
              const SizedBox(height: 12),
              for (final head in heads)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.t.sync.branchDevice(
                            device: _deviceName(head),
                          ),
                        ),
                        Text(context.t.sync.deviceId(id: head.deviceId)),
                        Text(
                          context.t.sync.branchRevision(
                            revision: head.revisionId,
                          ),
                        ),
                        Text(
                          context.t.sync.branchCreated(
                            time: _formatTime(head.createdAt),
                          ),
                        ),
                        Text(
                          context.t.sync.branchHash(hash: head.payloadHash),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Wrap(
                          spacing: 8,
                          children: [
                            TextButton.icon(
                              onPressed: () => _exportBranch(head),
                              icon: const Icon(Icons.save_alt),
                              label: Text(context.t.sync.exportBranch),
                            ),
                            FilledButton(
                              onPressed: () async {
                                final confirmed = await _confirm(
                                  context.t.sync.useBranch,
                                  context.t.sync.useBranchConfirm,
                                );
                                if (!confirmed || !mounted) return;
                                if (dialogContext.mounted) {
                                  Navigator.pop(dialogContext);
                                }
                                await _run(() => _service.resolveFork(head));
                              },
                              child: Text(context.t.sync.useBranch),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(context.t.ui.cancel),
          ),
        ],
      ),
    );
  }

  Future<void> _exportBranch(SyncSnapshot head) async {
    final data = {'version': 2, ...head.payload};
    final result = await FilePicker.saveFile(
      dialogTitle: context.t.sync.exportBranch,
      fileName: 'gagaku_conflict-${head.revisionId}.json',
      allowedExtensions: const ['json'],
      bytes: utf8.encode(jsonEncode(data)),
    );
    if (result != null && mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(context.t.sync.exportSuccess)));
    }
  }

  Future<void> _showDevices() async {
    final discovery = await _service.discover();
    if (discovery == null || !mounted) return;
    final localDevice = _state?.deviceId;
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(context.t.sync.devices),
        content: SizedBox(
          width: 480,
          child: ListView(
            shrinkWrap: true,
            children: [
              for (final head in discovery.deviceHeads.values)
                ListTile(
                  title: Text(
                    head.deviceId == localDevice &&
                            _state?.deviceName.isNotEmpty == true
                        ? _state!.deviceName
                        : _deviceName(head),
                  ),
                  subtitle: Text(
                    head.deviceId == localDevice
                        ? '${context.t.sync.thisDevice}\n${head.deviceId}'
                        : '${head.deviceId}\n${_formatTime(head.createdAt)}',
                  ),
                  isThreeLine: true,
                  trailing: IconButton(
                    tooltip: context.t.sync.retire,
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () async {
                      final t = context.t;
                      final confirmed = await _confirm(
                        t.sync.retire,
                        t.sync.retireConfirm,
                      );
                      if (!confirmed) return;
                      if (dialogContext.mounted) Navigator.pop(dialogContext);
                      await _run(() async {
                        final failures = await _service.retireDevice(
                          head.deviceId,
                        );
                        if (failures.isNotEmpty) {
                          throw StateError(
                            t.sync.failureCount(count: failures.length),
                          );
                        }
                      });
                    },
                  ),
                ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(context.t.ui.cancel),
          ),
        ],
      ),
    );
  }

  Future<void> _repair() async {
    if (!await _confirm(context.t.sync.repair, context.t.sync.repairConfirm)) {
      return;
    }
    await _run(() async {
      final result = await _service.repairRemote();
      if (!mounted) return;
      final message = result.failures.isEmpty
          ? context.t.sync.deletedCount(count: result.deleted.length)
          : context.t.sync.failureCount(count: result.failures.length);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    });
  }

  Future<void> _reset() async {
    final t = context.t;
    if (!await _confirm(t.sync.reset, t.sync.resetConfirm)) {
      return;
    }
    await _run(() async {
      final result = await _service.resetRemote();
      if (result.failures.isNotEmpty) {
        throw StateError(t.sync.failureCount(count: result.failures.length));
      }
    });
  }

  String _formatTime(DateTime? value) => value == null
      ? context.t.sync.never
      : DateFormat.yMd().add_jm().format(value.toLocal());

  String _deviceName(SyncSnapshot snapshot) {
    final name = snapshot.extra['deviceName'];
    return name is String && name.trim().isNotEmpty
        ? name.trim()
        : snapshot.deviceId;
  }

  SettingTile _profileTile(SyncLocalState state) => SettingTile(
    title: Text(context.t.sync.filesystem),
    subtitle: Text(
      '${context.t.sync.location(path: state.locator)}\n'
      '${context.t.sync.profileId(id: state.profileId)}',
    ),
    trailing: const Icon(Icons.folder_outlined),
  );

  SettingTile _deviceTile(SyncLocalState state) => SettingTile(
    title: Text(context.t.sync.deviceName),
    subtitle: Text(
      '${state.deviceName.isEmpty ? context.t.sync.defaultDeviceName : state.deviceName}\n'
      '${context.t.sync.deviceId(id: state.deviceId)}',
    ),
    trailing: const Icon(Icons.edit_outlined),
    onTap: _busy
        ? null
        : () async {
            final name = await _askDeviceName();
            if (name != null) {
              await _run(() => _service.renameDevice(name));
            }
          },
  );

  String _statusText(SyncCoordinatorPhase phase) => switch (phase) {
    SyncCoordinatorPhase.disabled => context.t.sync.statusDisabled,
    SyncCoordinatorPhase.initializing => context.t.sync.statusInitializing,
    SyncCoordinatorPhase.clean => context.t.sync.statusClean,
    SyncCoordinatorPhase.pending => context.t.sync.statusPending,
    SyncCoordinatorPhase.publishing => context.t.sync.statusPublishing,
    SyncCoordinatorPhase.pulling => context.t.sync.statusPulling,
    SyncCoordinatorPhase.offline => context.t.sync.statusOffline,
    SyncCoordinatorPhase.incompatible => context.t.sync.statusIncompatible,
    SyncCoordinatorPhase.noValidSnapshot =>
      context.t.sync.statusNoValidSnapshot,
    SyncCoordinatorPhase.forked => context.t.sync.statusForked,
    SyncCoordinatorPhase.cleanupWarning => context.t.sync.statusCleanupWarning,
    SyncCoordinatorPhase.disposed => context.t.sync.statusDisposed,
  };

  @override
  Widget build(BuildContext context) {
    final state = _state;
    const titleStyle = CommonTextStyles.twentyBold;
    if (state == null) {
      return const Center(child: CircularProgressIndicator());
    }
    final status = _service.status;
    final pending = state.dirtyGeneration - state.lastPublishedGeneration;
    final hasConfiguration = state.hasConfiguration;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ListTile(
          title: Text(context.t.sync.title, style: titleStyle),
          subtitle: Text(context.t.sync.description),
          leading: const Icon(Icons.sync),
          trailing: _busy
              ? const SizedBox.square(
                  dimension: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(
                  state.enabled
                      ? context.t.sync.configured
                      : context.t.sync.disabled,
                ),
        ),
        if (!state.enabled && !hasConfiguration) ...[
          SettingTile(
            title: Text(context.t.sync.create),
            subtitle: Text(context.t.sync.createSub),
            trailing: const Icon(Icons.create_new_folder_outlined),
            onTap: _busy ? null : () => _configure(SyncProfileMode.create),
          ),
          SettingTile(
            title: Text(context.t.sync.join),
            subtitle: Text(context.t.sync.joinSub),
            trailing: const Icon(Icons.folder_open),
            onTap: _busy ? null : () => _configure(SyncProfileMode.join),
          ),
        ] else if (!state.enabled) ...[
          SettingTile(
            title: Text(context.t.sync.resume),
            subtitle: Text(context.t.sync.resumeSub),
            trailing: const Icon(Icons.sync),
            onTap: _busy ? null : () => _run(_service.enable),
          ),
          _profileTile(state),
          _deviceTile(state),
          SettingTile(
            title: Text(context.t.sync.forget),
            subtitle: Text(context.t.sync.forgetSub),
            trailing: const Icon(Icons.link_off),
            onTap: _busy
                ? null
                : () async {
                    if (await _confirm(
                      context.t.sync.forget,
                      context.t.sync.forgetConfirm,
                    )) {
                      await _run(_service.forgetConfiguration);
                    }
                  },
          ),
        ] else ...[
          SettingTile(
            title: Text(context.t.sync.status),
            subtitle: Text(
              [
                _statusText(status.phase),
                context.t.sync.pending(count: pending < 0 ? 0 : pending),
                context.t.sync.lastPull(time: _formatTime(state.lastAppliedAt)),
                context.t.sync.lastPublish(
                  time: _formatTime(state.lastPublishedAt),
                ),
                if (state.lastError != null)
                  context.t.sync.error(message: state.lastError!),
              ].join('\n'),
            ),
            trailing: Icon(
              status.phase == SyncCoordinatorPhase.clean
                  ? Icons.cloud_done_outlined
                  : status.phase == SyncCoordinatorPhase.forked
                  ? Icons.call_split
                  : Icons.sync_problem,
            ),
            onTap: status.phase == SyncCoordinatorPhase.forked
                ? _showConflict
                : null,
          ),
          _profileTile(state),
          _deviceTile(state),
          if (status.phase == SyncCoordinatorPhase.forked)
            SettingTile(
              title: Text(context.t.sync.conflict),
              subtitle: Text(context.t.sync.conflictSub),
              trailing: const Icon(Icons.call_split),
              onTap: _showConflict,
            ),
          SettingTile(
            title: Text(
              state.retryPending
                  ? context.t.sync.retryNow
                  : context.t.sync.syncNow,
            ),
            trailing: const Icon(Icons.sync),
            onTap: _busy ? null : () => _run(_service.syncNow),
          ),
          SettingTile(
            title: Text(context.t.sync.devices),
            trailing: const Icon(Icons.devices),
            onTap: _busy ? null : _showDevices,
          ),
          SettingTile(
            title: Text(context.t.sync.repair),
            trailing: const Icon(Icons.build_outlined),
            onTap: _busy ? null : _repair,
          ),
          SettingTile(
            title: Text(context.t.sync.disable),
            subtitle: Text(context.t.sync.disableSub),
            trailing: const Icon(Icons.sync_disabled),
            onTap: _busy
                ? null
                : () async {
                    if (await _confirm(
                      context.t.sync.disable,
                      context.t.sync.disableConfirm,
                    )) {
                      await _run(_service.disable);
                    }
                  },
          ),
          SettingTile(
            title: Text(
              context.t.sync.reset,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
            trailing: Icon(
              Icons.delete_forever,
              color: Theme.of(context).colorScheme.error,
            ),
            onTap: _busy ? null : _reset,
          ),
        ],
        const Divider(),
      ],
    );
  }
}
