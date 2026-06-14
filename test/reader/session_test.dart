import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gagaku/reader/model/session.dart';
import 'package:gagaku/reader/model/types.dart';

void main() {
  test('synchronizes page state and a newly bound viewport', () {
    final scheduler = _TestScheduler();
    final session = _createSession(scheduler: scheduler);
    addTearDown(session.dispose);
    final firstViewport = _TestViewport();
    final secondViewport = _TestViewport();

    session.bindViewport(firstViewport);
    scheduler.flush();
    expect(firstViewport.jumps, [0]);

    session.reportVisiblePage(2);
    expect(session.currentPage.value, 2);
    expect(session.subtext.value, 'Page 3');

    session.bindViewport(secondViewport);
    scheduler.flush();
    expect(secondViewport.jumps, [2]);

    session.reportVisiblePage(4, source: firstViewport);
    expect(session.currentPage.value, 2);
  });

  test('maps physical page turns through reading direction', () {
    final session = _createSession();
    addTearDown(session.dispose);
    final viewport = _TestViewport();
    session.bindViewport(viewport);

    session.reportVisiblePage(1);
    expect(
      session.turnLeft(ReaderDirection.leftToRight),
      ReaderPageTurnResult.handled,
    );
    expect(viewport.jumps.last, 0);

    expect(
      session.turnLeft(ReaderDirection.rightToLeft),
      ReaderPageTurnResult.handled,
    );
    expect(viewport.jumps.last, 2);

    session.reportVisiblePage(4);
    expect(
      session.turnRight(ReaderDirection.leftToRight),
      ReaderPageTurnResult.closeReader,
    );
  });

  test('coalesces prefetch around the latest visible page', () {
    final requested = <ImageProvider<Object>>[];
    final pages = _pages(6);
    final scheduler = _TestScheduler();
    final session = ReaderSession(
      pages: pages,
      subtitle: null,
      precacheImage: (provider) async => requested.add(provider),
      schedulePostFrame: scheduler.schedule,
    );
    addTearDown(session.dispose);

    session.updatePrefetchPolicy(const ReaderPrefetchPolicy(forwardCount: 1));
    session.reportVisiblePage(3);
    scheduler.flush();

    expect(requested, [
      pages[4].provider,
      pages[0].provider,
      pages[1].provider,
      pages[2].provider,
    ]);

    session.reportVisiblePage(3);
    scheduler.flush();
    expect(requested, hasLength(4));
  });

  test('builds mode-specific prefetch policies', () {
    expect(
      ReaderPrefetchPolicy.forReader(
        format: ReaderFormat.single,
        configuredCount: 10,
        pageCount: 42,
      ),
      const ReaderPrefetchPolicy(forwardCount: 42),
    );
    expect(
      ReaderPrefetchPolicy.forReader(
        format: ReaderFormat.longstrip,
        configuredCount: 10,
        pageCount: 42,
        longStripCacheWidth: 800,
      ),
      const ReaderPrefetchPolicy(forwardCount: 9, cacheWidth: 800),
    );
  });

  test('retains completed horizontal precaches', () async {
    final requested = <ImageProvider<Object>>[];
    final pages = _pages(4);
    final scheduler = _TestScheduler();
    final session = ReaderSession(
      pages: pages,
      subtitle: null,
      precacheImage: (provider) async => requested.add(provider),
      schedulePostFrame: scheduler.schedule,
    );
    addTearDown(session.dispose);

    session.updatePrefetchPolicy(const ReaderPrefetchPolicy(forwardCount: 1));
    scheduler.flush();
    await Future<void>.delayed(Duration.zero);

    session.reportVisiblePage(1);
    scheduler.flush();
    await Future<void>.delayed(Duration.zero);

    session.reportVisiblePage(0);
    scheduler.flush();
    await Future<void>.delayed(Duration.zero);

    expect(requested.where((provider) => provider == pages[1].provider), [
      pages[1].provider,
    ]);
  });

  test('refreshes state and prefetch after page content changes', () {
    final requested = <ImageProvider<Object>>[];
    final scheduler = _TestScheduler();
    final session = ReaderSession(
      pages: _pages(2),
      subtitle: null,
      precacheImage: (provider) async => requested.add(provider),
      schedulePostFrame: scheduler.schedule,
    );
    addTearDown(session.dispose);
    session.updatePrefetchPolicy(const ReaderPrefetchPolicy(forwardCount: 1));
    scheduler.flush();
    requested.clear();

    final replacement = _pages(3, prefix: 'replacement');
    session.updateContent(pages: replacement, subtitle: 'Chapter');
    scheduler.flush();

    expect(session.subtext.value, 'Chapter');
    expect(requested, [replacement[1].provider]);
  });

  test('owns reader chrome visibility', () {
    final session = _createSession();
    addTearDown(session.dispose);

    expect(session.chromeVisible.value, isFalse);
    session.toggleChrome();
    expect(session.chromeVisible.value, isTrue);
  });
}

ReaderSession _createSession({_TestScheduler? scheduler}) {
  return ReaderSession(
    pages: _pages(5),
    subtitle: null,
    precacheImage: (_) async {},
    schedulePostFrame: scheduler?.schedule ?? _scheduleImmediately,
  );
}

void _scheduleImmediately(VoidCallback callback) {
  callback();
}

List<ReaderPage> _pages(int count, {String prefix = 'page'}) {
  return List.generate(
    count,
    (index) => ReaderPage(
      provider: NetworkImage('https://example.com/$prefix-$index.jpg'),
      sortKey: 'Page ${index + 1}',
    ),
  );
}

class _TestViewport implements ReaderViewportController {
  final List<int> jumps = [];

  @override
  void jumpToPage(int page) {
    jumps.add(page);
  }
}

class _TestScheduler {
  final List<VoidCallback> _callbacks = [];

  void schedule(VoidCallback callback) {
    _callbacks.add(callback);
  }

  void flush() {
    while (_callbacks.isNotEmpty) {
      final callbacks = List<VoidCallback>.of(_callbacks);
      _callbacks.clear();
      for (final callback in callbacks) {
        callback();
      }
    }
  }
}
