import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_readium/flutter_readium.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/local/document_reader.dart';
import 'package:gagaku/local/model/document_session.dart';
import 'package:gagaku/log.dart';
import 'package:logger/logger.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  LocaleSettings.useDeviceLocale();
  logger = Logger(level: Level.off);

  test('recognizes local document formats case-insensitively', () {
    expect(
      localDocumentFormatFromPath('/books/Novel.PDF'),
      LocalDocumentFormat.pdf,
    );
    expect(
      localDocumentFormatFromPath('/books/Novel.EpUb'),
      LocalDocumentFormat.epub,
    );
    expect(localDocumentFormatFromPath('/books/Novel.epub.zip'), isNull);
  });

  group('LocalDocumentSessionController', () {
    test('closes an obsolete open completion exactly once', () async {
      final api = _FakeReadium()..deferOpen();
      final controller = LocalDocumentSessionController(
        descriptor: _descriptor(LocalDocumentFormat.pdf),
        readium: api,
        coordinator: LocalDocumentSessionCoordinator(),
      );

      final opening = controller.open();
      await api.openStarted.future;
      final closing = controller.close();
      api.completeOpen(_publication(LocalDocumentFormat.pdf));

      await Future.wait([opening, closing]);
      expect(api.closeCalls, 1);
      expect(controller.state.phase, LocalDocumentSessionPhase.closed);
      controller.dispose();
    });

    test('duplicate close is idempotent', () async {
      final api = _FakeReadium();
      final controller = LocalDocumentSessionController(
        descriptor: _descriptor(LocalDocumentFormat.pdf),
        readium: api,
        coordinator: LocalDocumentSessionCoordinator(),
      );

      await controller.open();
      await Future.wait([controller.close(), controller.close()]);

      expect(api.closeCalls, 1);
      controller.dispose();
    });

    test('an obsolete controller cannot close its replacement', () async {
      final coordinator = LocalDocumentSessionCoordinator();
      final firstApi = _FakeReadium();
      final secondApi = _FakeReadium();
      final first = LocalDocumentSessionController(
        descriptor: _descriptor(LocalDocumentFormat.pdf),
        readium: firstApi,
        coordinator: coordinator,
      );
      final second = LocalDocumentSessionController(
        descriptor: _descriptor(LocalDocumentFormat.epub),
        readium: secondApi,
        coordinator: coordinator,
      );

      await first.open();
      await second.open();
      expect(firstApi.closeCalls, 1);
      expect(first.state.phase, LocalDocumentSessionPhase.closed);
      expect(second.state.phase, LocalDocumentSessionPhase.ready);

      await first.close();
      expect(secondApi.closeCalls, 0);

      await second.close();
      expect(secondApi.closeCalls, 1);
      first.dispose();
      second.dispose();
    });

    test('maps PDF page jumps to native progression', () async {
      final api = _FakeReadium();
      final controller = LocalDocumentSessionController(
        descriptor: _descriptor(LocalDocumentFormat.pdf),
        readium: api,
        coordinator: LocalDocumentSessionCoordinator(),
      );

      await controller.open();
      api.locators.add(
        const Locator(
          href: 'book.pdf',
          type: 'application/pdf',
          locations: Locations(position: 1),
        ),
      );
      await Future<void>.delayed(Duration.zero);
      expect(await controller.goToPdfPage(7), isTrue);

      expect(api.lastProgression, closeTo(6 / 9, 0.0001));
      await controller.close();
      controller.dispose();
    });

    test(
      'applies EPUB font size and scroll as one preference cohort',
      () async {
        final api = _FakeReadium();
        final controller = LocalDocumentSessionController(
          descriptor: _descriptor(LocalDocumentFormat.epub),
          readium: api,
          coordinator: LocalDocumentSessionCoordinator(),
        );

        await controller.open();
        await controller.increaseEpubFontSize();
        await controller.toggleEpubScroll();

        expect(api.lastEpubPreferences?.fontSize, closeTo(1.1, 0.0001));
        expect(api.lastEpubPreferences?.scroll, isTrue);
        await controller.resetEpubFontSize();
        expect(api.lastEpubPreferences?.fontSize, 1.0);
        expect(api.lastEpubPreferences?.scroll, isTrue);
        await controller.close();
        controller.dispose();
      },
    );

    test(
      'restores, reapplies, and reports persistent EPUB preferences',
      () async {
        final api = _FakeReadium();
        final saved = <({double fontSize, bool scroll})>[];
        final coordinator = LocalDocumentSessionCoordinator();
        final controller = LocalDocumentSessionController(
          descriptor: _descriptor(LocalDocumentFormat.epub),
          readium: api,
          coordinator: coordinator,
          initialEpubFontSize: 1.4,
          initialEpubScroll: true,
          epubBackgroundColor: Colors.black,
          epubTextColor: Colors.white,
          onEpubPreferencesChanged: (fontSize, scroll) {
            saved.add((fontSize: fontSize, scroll: scroll));
          },
        );

        await controller.open();
        expect(controller.state.readerReady, isFalse);
        expect(api.epubPreferences, isEmpty);

        api.statuses.add(ReadiumReaderStatus.ready);
        await _flushEvents();
        expect(controller.state.readerReady, isTrue);
        expect(api.lastEpubPreferences?.fontSize, 1.4);
        expect(api.lastEpubPreferences?.scroll, isTrue);
        expect(api.lastEpubPreferences?.backgroundColor, Colors.black);
        expect(api.lastEpubPreferences?.textColor, Colors.white);
        expect(saved, isEmpty);

        api.statuses.add(ReadiumReaderStatus.loading);
        await _flushEvents();
        expect(controller.state.readerReady, isFalse);
        api.statuses.add(ReadiumReaderStatus.ready);
        await _flushEvents();
        expect(controller.state.readerReady, isTrue);
        expect(api.epubPreferences, hasLength(2));

        await controller.increaseEpubFontSize();
        expect(saved, [(fontSize: 1.5, scroll: true)]);
        await controller.close();
        controller.dispose();

        final reopenedApi = _FakeReadium();
        final reopened = LocalDocumentSessionController(
          descriptor: _descriptor(LocalDocumentFormat.epub),
          readium: reopenedApi,
          coordinator: coordinator,
          initialEpubFontSize: saved.single.fontSize,
          initialEpubScroll: saved.single.scroll,
        );
        await reopened.open();
        reopenedApi.statuses.add(ReadiumReaderStatus.ready);
        await _flushEvents();
        expect(reopenedApi.lastEpubPreferences?.fontSize, 1.5);
        expect(reopenedApi.lastEpubPreferences?.scroll, isTrue);
        await reopened.close();
        reopened.dispose();
      },
    );

    test('does not revive controls from an obsolete ready event', () async {
      final api = _FakeReadium()..deferEpubPreferences();
      final controller = LocalDocumentSessionController(
        descriptor: _descriptor(LocalDocumentFormat.epub),
        readium: api,
        coordinator: LocalDocumentSessionCoordinator(),
      );

      await controller.open();
      api.statuses.add(ReadiumReaderStatus.ready);
      await _flushEvents();
      api.statuses.add(ReadiumReaderStatus.loading);
      await _flushEvents();
      api.completeEpubPreferences();
      await _flushEvents();

      expect(controller.state.readerReady, isFalse);
      api.statuses.add(ReadiumReaderStatus.ready);
      await _flushEvents();
      expect(controller.state.readerReady, isTrue);
      await controller.close();
      controller.dispose();
    });
  });

  testWidgets('shows a recoverable error when a document cannot open', (
    tester,
  ) async {
    final api = _FakeReadium()..openError = Exception('protected document');
    final controller = LocalDocumentSessionController(
      descriptor: _descriptor(LocalDocumentFormat.pdf),
      readium: api,
      coordinator: LocalDocumentSessionCoordinator(),
    );

    await tester.pumpWidget(
      TranslationProvider(
        child: MaterialApp(
          home: LocalDocumentReaderScreen(
            descriptor: controller.descriptor,
            controller: controller,
          ),
        ),
      ),
    );
    await tester.pump();
    await tester.pump();

    expect(controller.state.phase, LocalDocumentSessionPhase.failure);
    expect(find.text('This document could not be opened.'), findsOneWidget);
    expect(find.byType(ReadiumReaderWidget), findsNothing);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
  });

  testWidgets('chrome overlays a stable viewport and ignores double tap', (
    tester,
  ) async {
    final api = _FakeReadium();
    final controller = LocalDocumentSessionController(
      descriptor: _descriptor(LocalDocumentFormat.epub),
      readium: api,
      coordinator: LocalDocumentSessionCoordinator(),
    );

    await tester.pumpWidget(
      TranslationProvider(
        child: MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(
              size: Size(800, 600),
              padding: EdgeInsets.only(top: 24, bottom: 16),
            ),
            child: LocalDocumentReaderScreen(
              descriptor: controller.descriptor,
              controller: controller,
              readerBuilder: (context, publication) => const ColoredBox(
                key: ValueKey('reader-surface'),
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pump();
    await tester.pump();
    api.statuses.add(ReadiumReaderStatus.ready);
    await tester.pump();
    await tester.pump();

    final initialSize = tester.getSize(
      find.byKey(const ValueKey('reader-surface')),
    );
    expect(find.byIcon(Icons.text_increase), findsOneWidget);
    expect(find.byIcon(Icons.view_day), findsOneWidget);
    expect(
      tester
          .getSize(find.byKey(const ValueKey('document-side-controls')))
          .height,
      lessThan(initialSize.height),
    );
    expect(
      tester.getCenter(find.byKey(const ValueKey('document-side-controls'))).dy,
      tester.getCenter(find.byKey(const ValueKey('reader-surface'))).dy,
    );
    expect(
      tester
          .getSize(find.byKey(const ValueKey('document-bottom-controls')))
          .height,
      lessThan(60),
    );
    final bottomControlXs = [
      Icons.arrow_back_ios_new,
      Icons.skip_previous,
      Icons.toc,
      Icons.skip_next,
      Icons.arrow_forward_ios,
    ].map((icon) => tester.getCenter(find.byIcon(icon)).dx).toList();
    expect(bottomControlXs, orderedEquals([...bottomControlXs]..sort()));
    expect(
      tester.getTopLeft(find.byKey(const ValueKey('reader-surface'))).dy,
      24,
    );
    expect(
      initialSize.height,
      tester.getSize(find.byType(Scaffold)).height - 40,
    );

    await tester.tap(find.byIcon(Icons.linear_scale));
    await tester.pumpAndSettle();
    expect(
      tester.widget<BottomSheet>(find.byType(BottomSheet)).backgroundColor?.a,
      1,
    );
    expect(
      tester
          .getSize(find.byKey(const ValueKey('document-progression-sheet')))
          .height,
      lessThan(300),
    );
    expect(find.text('Position in current section: 0%'), findsOneWidget);
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.toc));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('document-toc-sheet')), findsOneWidget);
    expect(
      tester.widget<BottomSheet>(find.byType(BottomSheet)).backgroundColor?.a,
      1,
    );
    await tester.tap(find.text('Chapter'));
    await tester.pumpAndSettle();

    final readerCenter = tester.getCenter(
      find.byKey(const ValueKey('reader-surface')),
    );
    await tester.tapAt(readerCenter);
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pump();
    final opacity = tester.widget<AnimatedOpacity>(
      find.byKey(const ValueKey('local-document-chrome')),
    );
    expect(opacity.opacity, 0);
    expect(
      tester.getSize(find.byKey(const ValueKey('reader-surface'))),
      initialSize,
    );

    await tester.tapAt(readerCenter);
    await tester.tapAt(readerCenter);
    await tester.pump(const Duration(milliseconds: 350));
    await tester.pump();
    final afterDoubleTap = tester.widget<AnimatedOpacity>(
      find.byKey(const ValueKey('local-document-chrome')),
    );
    expect(afterDoubleTap.opacity, 0);
    expect(
      tester.getSize(find.byKey(const ValueKey('reader-surface'))),
      initialSize,
    );

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
  });

  testWidgets('PDF controls use a bottom bar and Cupertino page picker', (
    tester,
  ) async {
    final api = _FakeReadium();
    final controller = LocalDocumentSessionController(
      descriptor: _descriptor(LocalDocumentFormat.pdf),
      readium: api,
      coordinator: LocalDocumentSessionCoordinator(),
    );

    await tester.pumpWidget(
      TranslationProvider(
        child: MaterialApp(
          home: LocalDocumentReaderScreen(
            descriptor: controller.descriptor,
            controller: controller,
            readerBuilder: (context, publication) =>
                const ColoredBox(color: Colors.white),
          ),
        ),
      ),
    );
    await tester.pump();
    await tester.pump();
    api.statuses.add(ReadiumReaderStatus.ready);
    await tester.pump();
    await tester.pump();

    expect(find.byKey(const ValueKey('document-side-controls')), findsNothing);
    expect(
      tester
          .getSize(find.byKey(const ValueKey('document-bottom-controls')))
          .height,
      lessThan(60),
    );
    final bottomControlXs = [
      Icons.arrow_back_ios_new,
      Icons.find_in_page,
      Icons.arrow_forward_ios,
    ].map((icon) => tester.getCenter(find.byIcon(icon)).dx).toList();
    expect(bottomControlXs, orderedEquals([...bottomControlXs]..sort()));

    await tester.tap(find.byIcon(Icons.find_in_page));
    await tester.pumpAndSettle();
    expect(
      find.byKey(const ValueKey('document-pdf-page-picker')),
      findsOneWidget,
    );
    expect(
      tester.widget<BottomSheet>(find.byType(BottomSheet)).backgroundColor?.a,
      1,
    );
    tester
        .widget<CupertinoPicker>(find.byType(CupertinoPicker))
        .onSelectedItemChanged!(2);
    await tester.pump();
    expect(tester.takeException(), isNull);
    expect(api.lastProgression, closeTo(2 / 9, 0.0001));

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
  });
}

LocalDocumentDescriptor _descriptor(LocalDocumentFormat format) =>
    LocalDocumentDescriptor(
      path: '/tmp/book.${format.name}',
      title: 'Book',
      format: format,
    );

Publication _publication(LocalDocumentFormat format) => Publication(
  metadata: Metadata(
    localizedTitle: LocalizedString.fromString('Book'),
    numberOfPages: format == LocalDocumentFormat.pdf ? 10 : null,
  ),
  readingOrder: [
    Link(
      href: format == LocalDocumentFormat.pdf ? 'book.pdf' : 'chapter.xhtml',
      type: format == LocalDocumentFormat.pdf
          ? 'application/pdf'
          : 'application/xhtml+xml',
    ),
  ],
  tableOfContents: format == LocalDocumentFormat.epub
      ? const [
          Link(
            href: 'chapter.xhtml',
            type: 'application/xhtml+xml',
            title: 'Chapter',
          ),
        ]
      : const [],
);

Future<void> _flushEvents() async {
  await Future<void>.delayed(Duration.zero);
  await Future<void>.delayed(Duration.zero);
}

class _FakeReadium implements LocalDocumentReadium {
  final statuses = StreamController<ReadiumReaderStatus>.broadcast();
  final locators = StreamController<Locator>.broadcast();
  final errors = StreamController<ReadiumError>.broadcast();
  final openStarted = Completer<void>();

  Completer<Publication>? _deferredOpen;
  Completer<void>? _deferredEpubPreferences;
  Object? openError;
  int closeCalls = 0;
  Locator? lastLocator;
  double? lastProgression;
  EPUBPreferences? lastEpubPreferences;
  final epubPreferences = <EPUBPreferences>[];

  void deferOpen() => _deferredOpen = Completer<Publication>();
  void completeOpen(Publication publication) =>
      _deferredOpen!.complete(publication);
  void deferEpubPreferences() => _deferredEpubPreferences = Completer<void>();
  void completeEpubPreferences() {
    final deferred = _deferredEpubPreferences;
    _deferredEpubPreferences = null;
    deferred!.complete();
  }

  @override
  Stream<ReadiumReaderStatus> get onReaderStatusChanged => statuses.stream;
  @override
  Stream<Locator> get onTextLocatorChanged => locators.stream;
  @override
  Stream<ReadiumError> get onErrorEvent => errors.stream;

  @override
  Future<Publication> openPublication(String uri) {
    if (!openStarted.isCompleted) openStarted.complete();
    final error = openError;
    if (error != null) return Future<Publication>.error(error);
    return _deferredOpen?.future ??
        Future<Publication>.value(
          _publication(
            uri.endsWith('.pdf')
                ? LocalDocumentFormat.pdf
                : LocalDocumentFormat.epub,
          ),
        );
  }

  @override
  Future<void> closePublication() async {
    closeCalls++;
  }

  @override
  Future<void> goBackward() async {}
  @override
  Future<void> goForward() async {}
  @override
  Future<bool> goToLocator(Locator locator) async {
    lastLocator = locator;
    return true;
  }

  @override
  Future<bool> goToProgression(double progression) async {
    lastProgression = progression;
    return true;
  }

  @override
  Future<void> setEPUBPreferences(EPUBPreferences preferences) async {
    lastEpubPreferences = preferences;
    epubPreferences.add(preferences);
    final deferred = _deferredEpubPreferences;
    if (deferred != null) await deferred.future;
  }
}
