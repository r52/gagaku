import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gagaku/web/deeplink.dart';
import 'package:go_router/go_router.dart';

void main() {
  testWidgets('configured startup section wins a normal launcher start', (
    tester,
  ) async {
    tester.binding.platformDispatcher.defaultRouteNameTestValue = '/';
    addTearDown(
      tester.binding.platformDispatcher.clearDefaultRouteNameTestValue,
    );

    final router = _createPlatformRouter('/extensions');
    addTearDown(router.dispose);

    await tester.pumpWidget(MaterialApp.router(routerConfig: router));
    await tester.pumpAndSettle();

    expect(find.text('web sources'), findsOneWidget);
    expect(find.text('MangaDex title'), findsNothing);
  });

  testWidgets('cold MangaDex app link wins the configured startup section', (
    tester,
  ) async {
    tester.binding.platformDispatcher.defaultRouteNameTestValue =
        'https://mangadex.org/title/fixture-title';
    addTearDown(
      tester.binding.platformDispatcher.clearDefaultRouteNameTestValue,
    );

    final router = _createPlatformRouter('/extensions');
    addTearDown(router.dispose);

    await tester.pumpWidget(MaterialApp.router(routerConfig: router));
    await tester.pumpAndSettle();

    expect(find.text('MangaDex title'), findsOneWidget);
    expect(find.text('web sources'), findsNothing);
  });

  testWidgets('cold-start Paperback link resumes after root commits', (
    tester,
  ) async {
    final delegate = PBLinkDelegate();
    const action = 'cold-start-test';
    var callbackCount = 0;

    await delegate.addHandler(action, (context, uri, router) async {
      // OAuth handlers are one-shot and remove themselves while dispatching.
      await delegate.removeHandler(action);
      return Block.then(() async {
        callbackCount++;
        await router.push<void>('/handled');
      });
    });
    addTearDown(() => delegate.removeHandler(action));

    final router = _createRouter(
      delegate,
      initialLocation: 'paperback://$action/?value=preserved',
    );
    addTearDown(router.dispose);

    await tester.pumpWidget(MaterialApp.router(routerConfig: router));
    await tester.pumpAndSettle();

    expect(find.text('handled'), findsOneWidget);
    expect(find.text('routing error'), findsNothing);
    expect(callbackCount, 1);
  });

  testWidgets('warm Paperback link still runs exactly once', (tester) async {
    final delegate = PBLinkDelegate();
    const action = 'warm-start-test';
    var callbackCount = 0;

    await delegate.addHandler(action, (context, uri, router) {
      return Block.then(() async {
        callbackCount++;
        await router.push<void>('/handled');
      });
    });
    addTearDown(() => delegate.removeHandler(action));

    final router = _createRouter(delegate);
    addTearDown(router.dispose);

    await tester.pumpWidget(MaterialApp.router(routerConfig: router));
    await tester.pumpAndSettle();
    expect(find.text('root'), findsOneWidget);

    router.go('paperback://$action/');
    await tester.pumpAndSettle();

    expect(find.text('handled'), findsOneWidget);
    expect(find.text('routing error'), findsNothing);
    expect(callbackCount, 1);
  });

  testWidgets('blocked malformed cold-start link recovers to root', (
    tester,
  ) async {
    final delegate = PBLinkDelegate();
    const action = 'malformed-cold-start-test';

    await delegate.addHandler(
      action,
      (context, uri, router) => const Block.stop(),
    );
    addTearDown(() => delegate.removeHandler(action));

    final router = _createRouter(
      delegate,
      initialLocation: 'paperback://$action/',
    );
    addTearDown(router.dispose);

    await tester.pumpWidget(MaterialApp.router(routerConfig: router));
    await tester.pumpAndSettle();

    expect(find.text('root'), findsOneWidget);
    expect(find.text('routing error'), findsNothing);
  });

  testWidgets('non-Paperback blocked initial navigation remains an error', (
    tester,
  ) async {
    final delegate = PBLinkDelegate();
    Exception? pendingError;
    final router = GoRouter(
      initialLocation: 'other://blocked/',
      overridePlatformDefaultLocation: true,
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const Scaffold(body: Text('root')),
        ),
        GoRoute(
          path: '/error',
          builder: (context, state) =>
              const Scaffold(body: Text('routing error')),
        ),
      ],
      onEnter: (context, current, next, router) {
        if (next.uri.scheme == 'other') return const Block.stop();

        if (next.uri.path == '/' && pendingError != null) {
          return Allow(
            then: () {
              final error = pendingError;
              pendingError = null;
              router.go('/error', extra: error);
            },
          );
        }

        return const Allow();
      },
      onException: (context, state, router) {
        if (delegate.recoverInitialNavigation(state, router)) return;
        pendingError = state.error;
        router.go('/');
      },
    );
    addTearDown(router.dispose);

    await tester.pumpWidget(MaterialApp.router(routerConfig: router));
    await tester.pumpAndSettle();

    expect(find.text('routing error'), findsOneWidget);
    expect(find.text('root'), findsNothing);
  });
}

GoRouter _createPlatformRouter(String initialLocation) {
  return GoRouter(
    initialLocation: initialLocation,
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const Scaffold(body: Text('root')),
      ),
      GoRoute(
        path: '/extensions',
        builder: (context, state) => const Scaffold(body: Text('web sources')),
      ),
      GoRoute(
        path: '/title/:mangaId',
        builder: (context, state) =>
            const Scaffold(body: Text('MangaDex title')),
      ),
    ],
  );
}

GoRouter _createRouter(
  PBLinkDelegate delegate, {
  String initialLocation = '/',
}) {
  return GoRouter(
    initialLocation: initialLocation,
    overridePlatformDefaultLocation: true,
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const Scaffold(body: Text('root')),
      ),
      GoRoute(
        path: '/handled',
        builder: (context, state) => const Scaffold(body: Text('handled')),
      ),
      GoRoute(
        path: '/error',
        builder: (context, state) =>
            const Scaffold(body: Text('routing error')),
      ),
    ],
    onEnter: (context, current, next, router) {
      if (next.uri.scheme == PBLinkDelegate.scheme) {
        return delegate.process(context, next, router);
      }
      return delegate.resumePendingAfter(context, next);
    },
    onException: (context, state, router) {
      if (delegate.recoverInitialNavigation(state, router)) return;
      router.go('/error');
    },
  );
}
