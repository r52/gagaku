import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/model/model.dart';
import 'package:go_router/go_router.dart';

import 'model/types.dart';

typedef DeepLinkHandlerCallback =
    FutureOr<OnEnterResult> Function(
      BuildContext context,
      GoRouterState state,
      GoRouter router,
    );

final _defaultHandlers = {'addrepo'};

class PBLinkDelegate {
  PBLinkDelegate._internal();

  static final PBLinkDelegate _instance = PBLinkDelegate._internal();

  factory PBLinkDelegate() {
    return _instance;
  }

  static const scheme = 'paperback';

  late final Map<String, DeepLinkHandlerCallback> _handlers = {
    'addrepo': handleAddRepo,
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
    final action = uri.host;

    if (_handlers.containsKey(action)) {
      return await _handlers[action]!(context, state, router);
    }

    return const Allow();
  }

  FutureOr<OnEnterResult> handleAddRepo(
    BuildContext context,
    GoRouterState state,
    GoRouter router,
  ) async {
    final tr = context.t;
    final data = state.uri.queryParameters;
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
}
