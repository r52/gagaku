import 'package:material_ui/material_ui.dart';
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
    expect(firstViewport.prepared, [0]);
    expect(firstViewport.jumps, [0]);

    session.reportVisiblePage(2);
    expect(session.currentPage.value, 2);

    session.bindViewport(secondViewport);
    expect(secondViewport.prepared, [2]);
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

  test('ignores page turns on viewports that do not turn pages', () {
    final session = _createSession();
    addTearDown(session.dispose);
    final viewport = _TestViewport(turnsPages: false);
    session.bindViewport(viewport);
    viewport.jumps.clear();

    session.reportVisiblePage(4);
    expect(
      session.turnRight(ReaderDirection.leftToRight),
      ReaderPageTurnResult.handled,
    );
    expect(
      session.turnLeft(ReaderDirection.leftToRight),
      ReaderPageTurnResult.handled,
    );
    expect(viewport.jumps, isEmpty);
  });

  test('delegates scrolling and page size to the bound viewport', () {
    final session = _createSession();
    addTearDown(session.dispose);
    final viewport = _TestViewport(
      scrollResult: ReaderPageTurnResult.closeReader,
    );
    session.bindViewport(viewport);
    session.reportVisiblePage(3);

    expect(session.scrollBy(250), ReaderPageTurnResult.closeReader);
    session.togglePageSize();

    expect(viewport.scrolls, [(250.0, 3)]);
    expect(viewport.pageSizeToggles, [3]);
  });

  test('probes one page before the decoded page size is known', () async {
    final requested = <ImageProvider<Object>>[];
    final pages = _pages(6);
    final scheduler = _TestScheduler();
    final session = ReaderSession(
      pages: pages,
      precacheImage: (provider) async {
        requested.add(provider);
        return 10;
      },
      schedulePostFrame: scheduler.schedule,
      cacheBudgetBytes: () => 1000,
    );
    addTearDown(session.dispose);

    session.updatePrefetchPolicy(const ReaderPrefetchPolicy(forwardCount: 2));
    session.reportVisiblePage(3);
    scheduler.flush();
    expect(requested, [readerImageProvider(pages[4])]);

    await Future<void>.delayed(Duration.zero);
    scheduler.flush();

    expect(requested.skip(1), [
      readerImageProvider(pages[4]),
      readerImageProvider(pages[5]),
      readerImageProvider(pages[0]),
      readerImageProvider(pages[1]),
      readerImageProvider(pages[2]),
    ]);
  });

  test('coalesces prefetch around the latest visible page', () async {
    final requested = <ImageProvider<Object>>[];
    final pages = _pages(8);
    final scheduler = _TestScheduler();
    final session = _measuredSession(pages, requested, scheduler);
    addTearDown(session.dispose);

    session.updatePrefetchPolicy(const ReaderPrefetchPolicy(forwardCount: 1));
    await _settle(scheduler);
    requested.clear();

    session.reportVisiblePage(2);
    session.reportVisiblePage(5);
    scheduler.flush();

    expect(requested, [
      readerImageProvider(pages[6]),
      readerImageProvider(pages[2]),
      readerImageProvider(pages[3]),
      readerImageProvider(pages[4]),
    ]);
  });

  test(
    'requests completed pages again so evicted pages are restored',
    () async {
      final requested = <ImageProvider<Object>>[];
      final pages = _pages(4);
      final scheduler = _TestScheduler();
      final session = _measuredSession(pages, requested, scheduler);
      addTearDown(session.dispose);

      session.updatePrefetchPolicy(const ReaderPrefetchPolicy(forwardCount: 1));
      await _settle(scheduler);

      session.reportVisiblePage(1);
      await _settle(scheduler);
      session.reportVisiblePage(0);
      await _settle(scheduler);

      expect(
        requested
            .where((provider) => provider == readerImageProvider(pages[1]))
            .length,
        greaterThan(1),
      );
    },
  );

  test('limits the prefetch window to the image cache budget', () async {
    final requested = <ImageProvider<Object>>[];
    final pages = _pages(10);
    final scheduler = _TestScheduler();
    final session = ReaderSession(
      pages: pages,
      precacheImage: (provider) async {
        requested.add(provider);
        return 100;
      },
      schedulePostFrame: scheduler.schedule,
      // 75% of 400 bytes fits three 100-byte pages: the current one and two
      // prefetched pages.
      cacheBudgetBytes: () => 400,
    );
    addTearDown(session.dispose);

    session.updatePrefetchPolicy(const ReaderPrefetchPolicy(forwardCount: 9));
    session.reportVisiblePage(3);
    await _settle(scheduler);
    requested.clear();

    session.reportVisiblePage(6);
    scheduler.flush();

    expect(requested, [
      readerImageProvider(pages[7]),
      readerImageProvider(pages[8]),
    ]);
  });

  test('measures again after the decode width changes', () async {
    final requested = <ImageProvider<Object>>[];
    final pages = _pages(6);
    final scheduler = _TestScheduler();
    final session = _measuredSession(pages, requested, scheduler);
    addTearDown(session.dispose);

    session.updatePrefetchPolicy(const ReaderPrefetchPolicy(forwardCount: 3));
    await _settle(scheduler);
    requested.clear();

    session.updatePrefetchPolicy(
      const ReaderPrefetchPolicy(forwardCount: 3, cacheWidth: 256),
    );
    scheduler.flush();

    expect(requested, [readerImageProvider(pages[1], cacheWidth: 256)]);
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

  test('preloads every page only above the largest selectable count', () {
    const max = ReaderPrefetchPolicy.maxPreloadCount;
    expect(ReaderPrefetchPolicy.isUnboundedPreload(max), isFalse);
    expect(ReaderPrefetchPolicy.isUnboundedPreload(max + 1), isTrue);
  });

  test('splits taps into page-turn sides and a center chrome zone', () {
    expect(ReaderTapZone.of(0, 1000), ReaderTapZone.left);
    expect(ReaderTapZone.of(400, 1000), ReaderTapZone.left);
    expect(ReaderTapZone.of(401, 1000), ReaderTapZone.center);
    expect(ReaderTapZone.of(599, 1000), ReaderTapZone.center);
    expect(ReaderTapZone.of(600, 1000), ReaderTapZone.right);
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
    precacheImage: (_) async => null,
    schedulePostFrame: scheduler?.schedule ?? _scheduleImmediately,
  );
}

/// A session whose pages decode to 10 bytes against a large cache, so the
/// prefetch window is bounded only by the policy once measured.
ReaderSession _measuredSession(
  List<ReaderPage> pages,
  List<ImageProvider<Object>> requested,
  _TestScheduler scheduler,
) {
  return ReaderSession(
    pages: pages,
    precacheImage: (provider) async {
      requested.add(provider);
      return 10;
    },
    schedulePostFrame: scheduler.schedule,
    cacheBudgetBytes: () => 1 << 20,
  );
}

Future<void> _settle(_TestScheduler scheduler) async {
  for (var i = 0; i < 3; i++) {
    scheduler.flush();
    await Future<void>.delayed(Duration.zero);
  }
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
  _TestViewport({
    this.turnsPages = true,
    this.scrollResult = ReaderPageTurnResult.handled,
  });

  @override
  final bool turnsPages;
  final ReaderPageTurnResult scrollResult;

  final List<int> prepared = [];
  final List<int> jumps = [];
  final List<(double, int)> scrolls = [];
  final List<int> pageSizeToggles = [];

  @override
  void prepareInitialPage(int page) {
    prepared.add(page);
  }

  @override
  void jumpToPage(int page) {
    jumps.add(page);
  }

  @override
  ReaderPageTurnResult scrollBy(double delta, {required int currentPage}) {
    scrolls.add((delta, currentPage));
    return scrollResult;
  }

  @override
  void togglePageSize(int currentPage) {
    pageSizeToggles.add(currentPage);
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
