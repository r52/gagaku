import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_readium/flutter_readium.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/local/document_reader.dart';
import 'package:gagaku/local/model/document_session.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  LocaleSettings.useDeviceLocale();

  testWidgets('opens, rotates, closes, and reopens PDF and EPUB', (
    tester,
  ) async {
    expect(Platform.isAndroid, isTrue);

    final fixtureDirectory = await Directory.systemTemp.createTemp(
      'gagaku-readium-probe-',
    );
    addTearDown(() async {
      await tester.binding.setSurfaceSize(null);
      if (await fixtureDirectory.exists()) {
        await fixtureDirectory.delete(recursive: true);
      }
    });

    final pdf = File('${fixtureDirectory.path}/PDF probe [volume 1].pdf');
    final longPdf = File(
      '${fixtureDirectory.path}/Long novel-style PDF probe.pdf',
    );
    final epub = File('${fixtureDirectory.path}/EPUB probe {volume 1}.epub');
    await pdf.writeAsBytes(_minimalPdf());
    await longPdf.writeAsBytes(_minimalPdf(pageCount: 80));
    await epub.writeAsBytes(_minimalEpub());

    final readium = FlutterReadium();
    addTearDown(readium.closePublication);

    for (final path in [pdf.path, epub.path, longPdf.path, pdf.path]) {
      final publication = await readium.openPublication(
        Uri.file(path).toString(),
      );
      if (path == longPdf.path) {
        expect(publication.metadata.numberOfPages, 80);
      }
      final ready = readium.onReaderStatusChanged
          .firstWhere((status) => status.isReady)
          .timeout(const Duration(seconds: 30));

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReadiumReaderWidget(
              publication: publication,
              allowedDefaultActions: const {},
            ),
          ),
        ),
      );
      await tester.pump();
      await tester.runAsync(() => ready);

      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
      await tester.pump();
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      await tester.pumpAndSettle();

      await tester.binding.setSurfaceSize(const Size(1000, 600));
      await tester.pumpAndSettle();
      await tester.binding.setSurfaceSize(const Size(600, 1000));
      await tester.pumpAndSettle();

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pumpAndSettle();
      await readium.closePublication();
    }
  });

  testWidgets('rejects malformed PDF and EPUB without wedging teardown', (
    tester,
  ) async {
    expect(Platform.isAndroid, isTrue);

    final fixtureDirectory = await Directory.systemTemp.createTemp(
      'gagaku-readium-invalid-',
    );
    addTearDown(() async {
      if (await fixtureDirectory.exists()) {
        await fixtureDirectory.delete(recursive: true);
      }
    });

    final readium = FlutterReadium();
    for (final extension in ['pdf', 'epub']) {
      final file = File('${fixtureDirectory.path}/invalid.$extension');
      await file.writeAsString('not a publication');

      await expectLater(
        readium
            .openPublication(Uri.file(file.path).toString())
            .timeout(const Duration(seconds: 30)),
        throwsA(isA<Exception>()),
      );
      await readium.closePublication();
    }

    final protected = File('${fixtureDirectory.path}/protected.pdf');
    await protected.writeAsBytes(base64Decode(_protectedPdfBase64));
    await expectLater(
      readium
          .openPublication(Uri.file(protected.path).toString())
          .timeout(const Duration(seconds: 30)),
      throwsA(isA<Exception>()),
    );
    await readium.closePublication();
  });

  testWidgets('production shell exposes EPUB font and scroll controls', (
    tester,
  ) async {
    expect(Platform.isAndroid, isTrue);

    final fixtureDirectory = await Directory.systemTemp.createTemp(
      'gagaku-readium-shell-',
    );
    addTearDown(() async {
      if (await fixtureDirectory.exists()) {
        await fixtureDirectory.delete(recursive: true);
      }
    });
    final epub = File('${fixtureDirectory.path}/EPUB production shell.epub');
    await epub.writeAsBytes(_minimalEpub());

    final controller = LocalDocumentSessionController(
      descriptor: LocalDocumentDescriptor(
        path: epub.path,
        title: 'EPUB production shell',
        format: LocalDocumentFormat.epub,
      ),
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
    await _pumpUntil(
      tester,
      () => controller.state.readerReady,
      const Duration(seconds: 30),
    );

    expect(find.byType(ReadiumReaderWidget), findsOneWidget);
    expect(find.byIcon(Icons.text_increase), findsOneWidget);
    expect(find.byIcon(Icons.view_day), findsOneWidget);

    await controller.goBackward();
    await controller.goForward();
    expect(await controller.goToProgression(0.5), isTrue);
    final toc = controller.state.publication!.tocFlattened;
    expect(toc, hasLength(2));
    expect(await controller.goToTocLink(toc.last), isTrue);

    await tester.tap(find.byIcon(Icons.text_increase));
    await tester.pumpAndSettle();
    expect(controller.epubFontSize, closeTo(1.1, 0.0001));

    await tester.tap(find.byIcon(Icons.view_day));
    await tester.pumpAndSettle();
    expect(controller.epubScroll, isTrue);
    expect(find.byIcon(Icons.view_carousel), findsOneWidget);

    await tester.binding.setSurfaceSize(const Size(1000, 600));
    await tester.pumpAndSettle();
    expect(controller.epubScroll, isTrue);
    await tester.binding.setSurfaceSize(const Size(600, 1000));
    await tester.pumpAndSettle();

    await tester.pumpWidget(const SizedBox.shrink());
    await controller.close();
    await tester.binding.setSurfaceSize(null);
  });
}

Future<void> _pumpUntil(
  WidgetTester tester,
  bool Function() condition,
  Duration timeout,
) async {
  final deadline = DateTime.now().add(timeout);
  while (!condition()) {
    if (DateTime.now().isAfter(deadline)) {
      throw TimeoutException('Condition was not met within $timeout');
    }
    await tester.pump(const Duration(milliseconds: 100));
  }
}

List<int> _minimalPdf({int pageCount = 1}) {
  assert(pageCount > 0);
  final pageObjectIds = List.generate(pageCount, (index) => index + 3);
  final contentObjectIds = List.generate(
    pageCount,
    (index) => index + 3 + pageCount,
  );
  final fontObjectId = 3 + pageCount * 2;
  final objects = <String>[
    '<< /Type /Catalog /Pages 2 0 R >>',
    '<< /Type /Pages /Kids [${pageObjectIds.map((id) => '$id 0 R').join(' ')}] '
        '/Count $pageCount >>',
    for (var index = 0; index < pageCount; index++)
      '<< /Type /Page /Parent 2 0 R /MediaBox [0 0 612 792] '
          '/Resources << /Font << /F1 $fontObjectId 0 R >> >> '
          '/Contents ${contentObjectIds[index]} 0 R >>',
    for (var index = 0; index < pageCount; index++)
      _pdfStreamObject(
        'BT /F1 12 Tf 54 738 Td '
        '(Gagaku novel PDF probe page ${index + 1} of $pageCount) Tj '
        '0 -24 Td (A generated vector text page for Readium validation.) Tj ET',
      ),
    '<< /Type /Font /Subtype /Type1 /BaseFont /Helvetica >>',
  ];

  final output = StringBuffer('%PDF-1.4\n');
  final offsets = <int>[0];
  for (var index = 0; index < objects.length; index++) {
    offsets.add(latin1.encode(output.toString()).length);
    output.write('${index + 1} 0 obj\n${objects[index]}\nendobj\n');
  }

  final xrefOffset = latin1.encode(output.toString()).length;
  output
    ..write('xref\n0 ${objects.length + 1}\n')
    ..write('0000000000 65535 f \n');
  for (final offset in offsets.skip(1)) {
    output.write('${offset.toString().padLeft(10, '0')} 00000 n \n');
  }
  output
    ..write('trailer\n<< /Size ${objects.length + 1} /Root 1 0 R >>\n')
    ..write('startxref\n$xrefOffset\n%%EOF\n');
  return latin1.encode(output.toString());
}

String _pdfStreamObject(String stream) =>
    '<< /Length ${latin1.encode(stream).length} >>\n'
    'stream\n$stream\nendstream';

List<int> _minimalEpub() {
  final archive = Archive()
    ..addFile(
      ArchiveFile.noCompress(
        'mimetype',
        'application/epub+zip'.length,
        utf8.encode('application/epub+zip'),
      ),
    )
    ..addFile(
      ArchiveFile.string(
        'META-INF/container.xml',
        '''<?xml version="1.0" encoding="UTF-8"?>
<container version="1.0" xmlns="urn:oasis:names:tc:opendocument:xmlns:container">
  <rootfiles>
    <rootfile full-path="OEBPS/content.opf" media-type="application/oebps-package+xml"/>
  </rootfiles>
</container>''',
      ),
    )
    ..addFile(
      ArchiveFile.string(
        'OEBPS/content.opf',
        '''<?xml version="1.0" encoding="UTF-8"?>
<package xmlns="http://www.idpf.org/2007/opf" version="3.0" unique-identifier="book-id">
  <metadata xmlns:dc="http://purl.org/dc/elements/1.1/">
    <dc:identifier id="book-id">gagaku-readium-probe</dc:identifier>
    <dc:title>Gagaku Readium EPUB probe</dc:title>
    <dc:language>en</dc:language>
    <meta property="dcterms:modified">2026-08-12T00:00:00Z</meta>
  </metadata>
  <manifest>
    <item id="chapter" href="chapter.xhtml" media-type="application/xhtml+xml"/>
    <item id="chapter-2" href="chapter-2.xhtml" media-type="application/xhtml+xml"/>
    <item id="nav" href="nav.xhtml" media-type="application/xhtml+xml" properties="nav"/>
    <item id="style" href="style.css" media-type="text/css"/>
    <item id="illustration" href="illustration.svg" media-type="image/svg+xml"/>
  </manifest>
  <spine><itemref idref="chapter"/><itemref idref="chapter-2"/></spine>
</package>''',
      ),
    )
    ..addFile(
      ArchiveFile.string(
        'OEBPS/chapter.xhtml',
        '''<?xml version="1.0" encoding="UTF-8"?>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
  <head><title>Probe chapter</title><link rel="stylesheet" href="style.css"/></head>
  <body>
    <h1>Readium EPUB probe</h1>
    <img src="illustration.svg" alt="Generated probe illustration"/>
    <p>This is a local reflowable publication.</p>
    <p><a href="chapter-2.xhtml#target">Continue to the internal target</a></p>
  </body>
</html>''',
      ),
    )
    ..addFile(
      ArchiveFile.string(
        'OEBPS/chapter-2.xhtml',
        '''<?xml version="1.0" encoding="UTF-8"?>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
  <head><title>Second probe chapter</title><link rel="stylesheet" href="style.css"/></head>
  <body><h1 id="target">Internal EPUB target</h1><p>Second reflowable chapter.</p></body>
</html>''',
      ),
    )
    ..addFile(
      ArchiveFile.string(
        'OEBPS/style.css',
        'body { font-family: serif; } img { max-width: 40%; }',
      ),
    )
    ..addFile(
      ArchiveFile.string(
        'OEBPS/illustration.svg',
        '''<svg xmlns="http://www.w3.org/2000/svg" width="120" height="80">
  <rect width="120" height="80" fill="#6750a4"/>
  <circle cx="60" cy="40" r="24" fill="#ffffff"/>
</svg>''',
      ),
    )
    ..addFile(
      ArchiveFile.string(
        'OEBPS/nav.xhtml',
        '''<?xml version="1.0" encoding="UTF-8"?>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:epub="http://www.idpf.org/2007/ops">
  <head><title>Contents</title></head>
  <body><nav epub:type="toc"><ol>
    <li><a href="chapter.xhtml">Probe chapter</a></li>
    <li><a href="chapter-2.xhtml">Second probe chapter</a></li>
  </ol></nav></body>
</html>''',
      ),
    );
  return ZipEncoder().encode(archive);
}

const _protectedPdfBase64 =
    'JVBERi0xLjcKJb/3ov4KMSAwIG9iago8PCAvRXh0ZW5zaW9ucyA8PCAvQURCRSA8PCAvQmFzZVZlcnNpb24gLzEuNyAvRXh0ZW5zaW9uTGV2ZWwgOCA+PiA+PiAvUGFnZXMgMiAwIFIgL1R5cGUgL0NhdGFsb2cgPj4KZW5kb2JqCjIgMCBvYmoKPDwgL0NvdW50IDEgL0tpZHMgWyAzIDAgUiBdIC9UeXBlIC9QYWdlcyA+PgplbmRvYmoKMyAwIG9iago8PCAvQ29udGVudHMgNCAwIFIgL01lZGlhQm94IFsgMCAwIDYxMiA3OTIgXSAvUGFyZW50IDIgMCBSIC9SZXNvdXJjZXMgPDwgL0ZvbnQgPDwgL0YxIDUgMCBSID4+ID4+IC9UeXBlIC9QYWdlID4+CmVuZG9iago0IDAgb2JqCjw8IC9MZW5ndGggODAgL0ZpbHRlciAvRmxhdGVEZWNvZGUgPj4Kc3RyZWFtCmmTwty+TT9U9mS+HCexD1Ce9ivN6EkPXzBKD1rLgmOMvS56xfSJXwDn2pDO0IjxBOk1PfFe50OtHqOhTQMgSgrYtBHiya/2vT+y0y04HDt4ZW5kc3RyZWFtCmVuZG9iago1IDAgb2JqCjw8IC9CYXNlRm9udCAvSGVsdmV0aWNhIC9TdWJ0eXBlIC9UeXBlMSAvVHlwZSAvRm9udCA+PgplbmRvYmoKNiAwIG9iago8PCAvQ0YgPDwgL1N0ZENGIDw8IC9BdXRoRXZlbnQgL0RvY09wZW4gL0NGTSAvQUVTVjMgL0xlbmd0aCAzMiA+PiA+PiAvRmlsdGVyIC9TdGFuZGFyZCAvTGVuZ3RoIDI1NiAvTyA8ODYyZjQ3YjBjYzc0ZDg5ZTNlYzRiYTJmOGIwMzRkODYzNTcyZjA0ZDJiZThjZGIzYWFiZDM1YzEzYjQ3ZjgyMmVkNzA2ODVjYjQzYWI0MTA4YzVhMWY4NWVlMjA2YTY1PiAvT0UgPGJmMmVlYTFjMDBjZTBjMWIyOTVhNTQyZmMyMWJmZjIxZDdkOWJjYWM0MjQ1MzllNTU1NjMzMTIwZDFkYjE2ODg+IC9QIC0zMzkyIC9QZXJtcyA8Mjk5ZWYzMWRhZTRkM2M2ODc0OTcwMzNiZjRkNDNkMjU+IC9SIDYgL1N0bUYgL1N0ZENGIC9TdHJGIC9TdGRDRiAvVSA8YmFkMDc4ODUzOGNlMmVkZWQ0NTNmZGRjNGI0NTEyOWY3YWI5MzQxMmI2NjZmYjI1YmNjZjY3YmRiMjA2M2I5NjM2ZjU1MjI3NTdhYWMwYmI4ZjIzMDM3NGMxMzM5MjE3PiAvVUUgPGUyMzBiMTY2NzY5NTBlOGY1NTJjYzY5NzViYjY0YzczODc5YjkzNGY2MjZhZTQ3MzlhOWM2NWU3NDVkZWM0ODU+IC9WIDUgPj4KZW5kb2JqCnhyZWYKMCA3CjAwMDAwMDAwMDAgNjU1MzUgZiAKMDAwMDAwMDAxNSAwMDAwMCBuIAowMDAwMDAwMTMwIDAwMDAwIG4gCjAwMDAwMDAxODkgMDAwMDAgbiAKMDAwMDAwMDMxNyAwMDAwMCBuIAowMDAwMDAwNDY3IDAwMDAwIG4gCjAwMDAwMDA1MzcgMDAwMDAgbiAKdHJhaWxlciA8PCAvUm9vdCAxIDAgUiAvU2l6ZSA3IC9JRCBbPDVmODk1MTM1M2I2MDViNzNiNTFjZjc2MzJmZWY3ZDZjPjw1Zjg5NTEzNTNiNjA1YjczYjUxY2Y3NjMyZmVmN2Q2Yz5dIC9FbmNyeXB0IDYgMCBSID4+CnN0YXJ0eHJlZgoxMDg3CiUlRU9GCg==';
