import 'dart:io';

import 'package:flutter/services.dart';

import 'package:gagaku/sync/store.dart';

final class SafTreeSelection {
  const SafTreeSelection({required this.uri, required this.displayName});

  final String uri;
  final String displayName;
}

class SafSyncStoreException implements Exception {
  const SafSyncStoreException(this.code, this.message);

  final String code;
  final String message;

  @override
  String toString() => message;
}

final class SafPermissionException extends SafSyncStoreException {
  const SafPermissionException(String message)
    : super('permissionDenied', message);
}

/// Android document-tree transport backed by the system Storage Access
/// Framework. The native side owns all ContentResolver interaction so callers
/// retain the same immutable-object contract as other [SyncStore]s.
final class SafSyncStore implements SyncStore {
  SafSyncStore(String treeUri) : treeUri = _validateTreeUri(treeUri);

  static const MethodChannel channel = MethodChannel('r52.gagaku/saf_sync');

  final String treeUri;

  static Future<SafTreeSelection?> pickTree() async {
    if (!Platform.isAndroid) {
      throw UnsupportedError('Document-tree sync is only available on Android');
    }
    final value = await channel.invokeMapMethod<String, dynamic>('pickTree');
    if (value == null) return null;
    final uri = value['uri'];
    final displayName = value['displayName'];
    if (uri is! String || displayName is! String) {
      throw const SafSyncStoreException(
        'invalidResponse',
        'The document provider returned an invalid folder selection',
      );
    }
    return SafTreeSelection(
      uri: _validateTreeUri(uri),
      displayName: displayName,
    );
  }

  Future<void> checkAccess() => _invoke<void>('checkAccess');

  @override
  Future<void> create(String key, List<int> bytes) =>
      _invoke<void>('create', key: key, bytes: Uint8List.fromList(bytes));

  @override
  Future<void> delete(String key) => _invoke<void>('delete', key: key);

  @override
  Future<List<SyncObject>> list(String prefix) async {
    final values = await _invoke<List<dynamic>>('list', prefix: prefix);
    final result = <SyncObject>[];
    for (final value in values) {
      if (value case {'key': final String key, 'length': final int length}) {
        result.add(SyncObject(key: key, length: length));
      } else {
        throw const SafSyncStoreException(
          'invalidResponse',
          'The document provider returned an invalid directory listing',
        );
      }
    }
    result.sort((left, right) => left.key.compareTo(right.key));
    return List.unmodifiable(result);
  }

  @override
  Future<List<int>> read(String key) async {
    final value = await _invoke<Uint8List>('read', key: key);
    return List<int>.of(value);
  }

  Future<T> _invoke<T>(
    String method, {
    String? key,
    String? prefix,
    Uint8List? bytes,
  }) async {
    try {
      final value = await channel.invokeMethod<T>(method, {
        'treeUri': treeUri,
        'key': ?key,
        'prefix': ?prefix,
        'bytes': ?bytes,
      });
      return value as T;
    } on PlatformException catch (error) {
      switch (error.code) {
        case 'NOT_FOUND':
          throw SyncObjectNotFoundException(key ?? treeUri);
        case 'ALREADY_EXISTS':
          throw SyncObjectAlreadyExistsException(key ?? treeUri);
        case 'PERMISSION_DENIED':
          throw SafPermissionException(
            error.message ??
                'Access to the selected document tree has been revoked',
          );
        default:
          throw SafSyncStoreException(
            error.code,
            error.message ?? 'Document provider operation failed',
          );
      }
    }
  }

  static String _validateTreeUri(String value) {
    final uri = Uri.tryParse(value.trim());
    if (uri == null || uri.scheme != 'content' || uri.authority.isEmpty) {
      throw ArgumentError.value(value, 'treeUri', 'must be a content URI');
    }
    return uri.toString();
  }
}
