import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/model/model.dart';
import 'package:go_router/go_router.dart';

import 'model/types.dart';

typedef DeepLinkHandlerCallback =
    FutureOr<OnEnterResult> Function(
      BuildContext context,
      Uri uri,
      GoRouter router,
    );

final _defaultHandlers = {'addrepo', 'installextensions'};

class PBLinkDelegate {
  PBLinkDelegate._internal();

  static final PBLinkDelegate _instance = PBLinkDelegate._internal();

  factory PBLinkDelegate() {
    return _instance;
  }

  static const scheme = 'paperback';

  Uri? _pendingUri;
  _DeepLinkExecution? _activeExecution;
  _DeepLinkExecution? _pendingExecution;

  late final Map<String, DeepLinkHandlerCallback> _handlers = {
    'addrepo': handleAddRepo,
    'installextensions': handleInstallExtensions,
  };

  Future<void> addHandler(
    String action,
    DeepLinkHandlerCallback callback,
  ) async {
    if (_handlers.containsKey(action)) {
      throw Exception('Handler for action $action already exists.');
    }

    _handlers[action] = callback;
  }

  Future<void> removeHandler(String action) async {
    if (_defaultHandlers.contains(action)) {
      // Don't remove default actions
      return;
    }

    _handlers.remove(action);
  }

  FutureOr<OnEnterResult> process(
    BuildContext context,
    GoRouterState state,
    GoRouter router,
  ) async {
    final uri = state.uri;
    final result = await _dispatch(context, uri, router);
    final callback = result.then;

    if (callback == null) {
      _activeExecution = null;
      return result;
    }

    // A blocked initial navigation reaches onException before go_router runs
    // this callback. Keep it addressable so recovery can defer this exact
    // execution until the root route has committed.
    final execution = _DeepLinkExecution(uri, callback);
    _activeExecution = execution;

    return switch (result) {
      Allow() => Allow(then: execution.run),
      Block() => Block.then(execution.run),
    };
  }

  FutureOr<OnEnterResult> _dispatch(
    BuildContext context,
    Uri uri,
    GoRouter router,
  ) async {
    final action = uri.host;

    if (_handlers.containsKey(action)) {
      return await _handlers[action]!(context, uri, router);
    }

    return const Allow();
  }

  bool recoverInitialNavigation(GoRouterState state, GoRouter router) {
    if (state.uri.scheme != scheme) return false;

    switch (state.error) {
      case BlockedInitialNavigationException():
        final uri = state.uri;
        final execution = _activeExecution;

        if (execution != null && execution.uri == uri) {
          execution.defer();
          _pendingExecution = execution;
        }

        _pendingUri = uri;
        router.go('/');
        return true;
      default:
        return false;
    }
  }

  OnEnterResult resumePendingAfter(BuildContext context, GoRouterState state) {
    if (state.uri.path != '/' || _pendingUri == null) {
      return const Allow();
    }

    return Allow(
      then: () async {
        // Allow.then runs after `/` is committed, so dialog routes can safely
        // push onto an established navigator stack.
        final execution = _pendingExecution;
        _pendingUri = null;
        _pendingExecution = null;

        if (!context.mounted) return;
        await execution?.runRecovered();
      },
    );
  }

  FutureOr<OnEnterResult> handleAddRepo(
    BuildContext context,
    Uri uri,
    GoRouter router,
  ) async {
    final tr = context.t;
    final data = uri.queryParameters;
    final name = data['displayName'];
    final url = data['url'];

    if (name == null || url == null) {
      return const Block.stop();
    }

    return Block.then(() async {
      final messenger = ScaffoldMessenger.of(context);
      final box = GagakuData().store.box<RepoInfo>();
      final list = box.getAll();

      final result = await router.push(
        '${GagakuRoute.extensionAddRepo}?name=${Uri.encodeComponent(name)}&url=${Uri.encodeComponent(url)}',
      );

      if (result != null && context.mounted) {
        if (!context.mounted) return;

        final exists = list.indexWhere((e) => e.url == url) > -1;

        if (exists) {
          messenger
            ..removeCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(tr.webSources.repo.repoExists),
                backgroundColor: Colors.orange,
              ),
            );
        } else {
          box.put(RepoInfo(name: name, url: url));

          messenger
            ..removeCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(tr.webSources.repo.repoAddOK),
                backgroundColor: Colors.green,
              ),
            );
        }
      }
    });
  }

  FutureOr<OnEnterResult> handleInstallExtensions(
    BuildContext context,
    Uri uri,
    GoRouter router,
  ) async {
    final tr = context.t;
    final data = uri.queryParameters['data'];

    if (data == null || data.isEmpty) {
      return const Block.stop();
    }

    return Block.then(() async {
      final messenger = ScaffoldMessenger.of(context);

      final result = await router.push<int>(
        '${GagakuRoute.extensionInstall}?data=${Uri.encodeComponent(data)}',
      );

      if (result != null && context.mounted) {
        if (!context.mounted) return;

        messenger
          ..removeCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(
                tr.webSources.source.install.success(count: result),
              ),
              backgroundColor: Colors.green,
            ),
          );
      }
    });
  }
}

final class _DeepLinkExecution {
  _DeepLinkExecution(this.uri, this._callback);

  final Uri uri;
  final OnEnterThenCallback _callback;

  bool _deferred = false;
  bool _completed = false;

  void defer() => _deferred = true;

  Future<void> run() async {
    if (_deferred || _completed) return;

    _completed = true;
    await _callback();
  }

  Future<void> runRecovered() async {
    if (_completed) return;

    _completed = true;
    await _callback();
  }
}
