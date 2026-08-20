import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/util/exception.dart';
import 'package:gagaku/web/frontpage.dart';
import 'package:gagaku/web/model/model.dart';
import 'package:gagaku/web/model/types.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  testWidgets('Cloudflare homepage errors offer retry without another solve', (
    tester,
  ) async {
    final source = WebSourceInfo(
      id: 'test-source',
      name: 'Test Source',
      repo: 'test-repo',
      baseUrl: 'https://example.com',
      icon: '',
      capabilities: const [SourceIntents.cloudflareBypassRequired],
    );
    late _RetryingExtensionSource notifier;

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          extensionSourceProvider(
            source.id,
          ).overrideWith(() => notifier = _RetryingExtensionSource(source)),
        ],
        child: TranslationProvider(
          child: MaterialApp(
            home: Scaffold(body: ExtensionHomeWidget(source: source)),
          ),
        ),
      ),
    );
    await tester.pump();
    await _flushAsync(tester);

    expect(notifier.calls, 1);
    expect(find.text(t.ui.retry), findsOneWidget);
    expect(find.text(t.webSources.source.cloudflareResolve), findsOneWidget);

    await tester.tap(find.text(t.ui.retry));
    await tester.pump();
    await _flushAsync(tester);

    expect(notifier.calls, 2);
    expect(find.text(t.ui.retry), findsNothing);
    expect(find.text(t.webSources.source.cloudflareResolve), findsNothing);

    await tester.pump(const Duration(seconds: 5));
  });
}

Future<void> _flushAsync(WidgetTester tester) async {
  await tester.runAsync(
    () => Future<void>.delayed(const Duration(milliseconds: 20)),
  );
  await tester.pump();
}

class _RetryingExtensionSource extends ExtensionSource {
  _RetryingExtensionSource(this.source);

  final WebSourceInfo source;
  int calls = 0;

  @override
  Future<WebSourceInfo> build(String sourceId) async => source;

  @override
  Future<List<DiscoverSection>> getDiscoverSections() async {
    calls++;
    if (calls == 1) {
      throw const CloudflareBypassException();
    }
    return const [];
  }
}
