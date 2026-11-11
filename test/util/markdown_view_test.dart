import 'package:cached_network_image_ce/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gagaku/util/cached_network_image.dart';
import 'package:gagaku/util/markdown/markdown_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

// All fixtures are fictional.

/// A cache manager that never touches the network or disk: every load fails,
/// so images fall back to their alt text.
class _OfflineCacheManager extends Fake implements BaseCacheManager {
  final requested = <String>[];

  @override
  Stream<FileResponse> getFileStream(
    String url, {
    String? key,
    Map<String, String>? headers,
    bool withProgress = false,
  }) {
    requested.add(url);
    return Stream.error(StateError('offline: $url'));
  }
}

typedef _Tap = ({String text, String href, String? title});

class _Harness {
  final cache = _OfflineCacheManager();
  final taps = <_Tap>[];

  Widget build(String data) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: MarkdownView(
            data: data,
            onTapLink: (text, href, title) =>
                taps.add((text: text, href: href, title: title)),
          ),
        ),
      ),
    );
  }

  Future<void> pump(WidgetTester tester, String data) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [extensionImageCacheProvider.overrideWithValue(cache)],
        child: build(data),
      ),
    );
    await tester.pump();
  }
}

Finder get _markdownTexts =>
    find.descendant(of: find.byType(MarkdownView), matching: find.byType(Text));

/// Plain text of every `Text` under the view, in tree order. Image
/// placeholders appear as U+FFFC.
List<String> _texts(WidgetTester tester) => [
  for (final text in tester.widgetList<Text>(_markdownTexts))
    text.textSpan?.toPlainText() ?? text.data ?? '',
];

String _allText(WidgetTester tester) => _texts(tester).join('\n');

Finder _privateType(String name) =>
    find.byWidgetPredicate((widget) => widget.runtimeType.toString() == name);

/// The innermost `TextSpan` whose own text contains [needle].
TextSpan _spanContaining(WidgetTester tester, String needle) {
  TextSpan? found;
  for (final text in tester.widgetList<Text>(_markdownTexts)) {
    text.textSpan?.visitChildren((span) {
      if (span is TextSpan && (span.text?.contains(needle) ?? false)) {
        found = span;
        return false;
      }
      return true;
    });
    if (found != null) break;
  }
  expect(found, isNotNull, reason: 'no span containing "$needle"');
  return found!;
}

/// The effective style of [span]: the `Text` widget's base style merged
/// with the span's own style (one level of nesting, as the view builds it).
TextStyle _effectiveStyle(WidgetTester tester, String needle) {
  final span = _spanContaining(tester, needle);
  for (final text in tester.widgetList<Text>(_markdownTexts)) {
    final root = text.textSpan;
    if (root is! TextSpan) continue;
    if (identical(root, span)) return root.style ?? const TextStyle();
    if (root.children?.any((child) => identical(child, span)) ?? false) {
      return (root.style ?? const TextStyle()).merge(span.style);
    }
  }
  fail('span "$needle" is not a direct child of a Text root');
}

ThemeData _theme(WidgetTester tester) =>
    Theme.of(tester.element(find.byType(MarkdownView)));

Future<void> _tapText(WidgetTester tester, String text) async {
  await tester.tapOnText(find.textRange.ofSubstring(text));
  await tester.pumpAndSettle();
}

void main() {
  group('corpus constructs', () {
    testWidgets('soft breaks render as line breaks with spaces trimmed', (
      tester,
    ) async {
      final harness = _Harness();
      await harness.pump(
        tester,
        '__Given name:__ ミナト \n  __Family name:__ 星野\n一行目。\n二行目。',
      );

      expect(_texts(tester), ['Given name: ミナト\nFamily name: 星野\n一行目。\n二行目。']);
    });

    testWidgets('hard breaks render as line breaks', (tester) async {
      final harness = _Harness();
      await harness.pump(tester, 'first  \nsecond\\\nthird');

      expect(_texts(tester), ['first\nsecond\nthird']);
    });

    testWidgets('strong and emphasis nest', (tester) async {
      final harness = _Harness();
      await harness.pump(
        tester,
        '***both*** then **bold _inner_ tail** and *plain em*',
      );

      final both = _effectiveStyle(tester, 'both');
      expect(both.fontWeight, FontWeight.bold);
      expect(both.fontStyle, FontStyle.italic);

      final inner = _effectiveStyle(tester, 'inner');
      expect(inner.fontWeight, FontWeight.bold);
      expect(inner.fontStyle, FontStyle.italic);

      final tail = _effectiveStyle(tester, ' tail');
      expect(tail.fontWeight, FontWeight.bold);
      expect(tail.fontStyle, isNot(FontStyle.italic));

      final em = _effectiveStyle(tester, 'plain em');
      expect(em.fontWeight, isNot(FontWeight.bold));
      expect(em.fontStyle, FontStyle.italic);
    });

    testWidgets('links in paragraphs, list items, and table cells', (
      tester,
    ) async {
      final harness = _Harness();
      await harness.pump(tester, '''
Read the [Paragraph link](https://example.com/p "Para title") here.

- [List link](https://example.com/li)

| Name | Where |
|:---|:---|
| Alpha | [Cell link](http://example.com/cell) |
''');

      final link = _effectiveStyle(tester, 'Paragraph link');
      expect(link.color, _theme(tester).colorScheme.primary);
      expect(link.decoration, TextDecoration.underline);

      await _tapText(tester, 'Paragraph link');
      await _tapText(tester, 'List link');
      await _tapText(tester, 'Cell link');

      expect(harness.taps, [
        (
          text: 'Paragraph link',
          href: 'https://example.com/p',
          title: 'Para title',
        ),
        (text: 'List link', href: 'https://example.com/li', title: null),
        (text: 'Cell link', href: 'http://example.com/cell', title: null),
      ]);
    });

    testWidgets('bullet and numbered lists honor start', (tester) async {
      final harness = _Harness();
      await harness.pump(tester, '''
- apple
- pear

3. three
4. four
''');

      expect(_texts(tester), [
        '•',
        'apple',
        '•',
        'pear',
        '3.',
        'three',
        '4.',
        'four',
      ]);
    });

    testWidgets('rules come from --- and ___ (including CRLF)', (tester) async {
      final harness = _Harness();
      await harness.pump(tester, 'above\n\n---\n\nmiddle\r\n___\r\nbelow');

      expect(_privateType('_MarkdownRule'), findsNWidgets(2));
      expect(_texts(tester), ['above', 'middle', 'below']);
    });

    testWidgets('~~double tilde~~ strikes through', (tester) async {
      final harness = _Harness();
      await harness.pump(tester, 'keep ~~struck~~ keep');

      expect(_texts(tester), ['keep struck keep']);
      expect(
        _effectiveStyle(tester, 'struck').decoration,
        TextDecoration.lineThrough,
      );
    });

    testWidgets('a link-wrapped image loads http(s) and is tappable', (
      tester,
    ) async {
      final harness = _Harness();
      await harness.pump(
        tester,
        'Gallery: [![Sketch](https://img.example.com/sketch.png)]'
        '(https://example.com/gallery)',
      );
      await tester.pumpAndSettle();

      expect(find.byType(CachedNetworkImage), findsOneWidget);
      expect(harness.cache.requested, ['https://img.example.com/sketch.png']);

      // The offline cache fails, so the image falls back to its alt text,
      // which stays inside the link's tap target.
      await tester.tap(find.text('Sketch'));
      await tester.pumpAndSettle();

      expect(harness.taps, [
        (text: '', href: 'https://example.com/gallery', title: null),
      ]);
    });

    testWidgets('a two-column aligned table', (tester) async {
      final harness = _Harness();
      await harness.pump(tester, '''
| Left | Right |
|:---|---:|
| a1 | b1 |
| a2 | b2 |
''');

      final table = tester.widget<Table>(find.byType(Table));
      expect(table.children, hasLength(3));
      expect(table.children.every((row) => row.children.length == 2), isTrue);

      Text cell(String text) => tester.widget<Text>(find.text(text));
      expect(cell('Left').textAlign, TextAlign.start);
      expect(cell('Right').textAlign, TextAlign.end);
      expect(cell('b2').textAlign, TextAlign.end);
      expect(_effectiveStyle(tester, 'Left').fontWeight, FontWeight.bold);
    });
  });

  group('headings', () {
    testWidgets('ATX h1-h6 use the theme heading styles', (tester) async {
      final harness = _Harness();
      await harness.pump(
        tester,
        '# One\n## Two\n### Three\n#### Four\n##### Five\n###### Six',
      );

      final textTheme = _theme(tester).textTheme;
      expect(_texts(tester), ['One', 'Two', 'Three', 'Four', 'Five', 'Six']);
      expect(
        _effectiveStyle(tester, 'One').fontSize,
        textTheme.titleLarge!.fontSize,
      );
      expect(
        _effectiveStyle(tester, 'Two').fontSize,
        textTheme.titleMedium!.fontSize,
      );
      expect(
        _effectiveStyle(tester, 'Three').fontSize,
        textTheme.titleSmall!.fontSize,
      );
      for (final level in ['Four', 'Five', 'Six']) {
        final style = _effectiveStyle(tester, level);
        expect(style.fontSize, textTheme.bodyLarge!.fontSize);
        expect(style.fontWeight, FontWeight.bold);
      }
    });

    testWidgets('setext headings, and text above --- is an h2', (tester) async {
      final harness = _Harness();
      await harness.pump(tester, 'Big title\n===\n\nSub title\n---\n\nbody');

      final textTheme = _theme(tester).textTheme;
      expect(_texts(tester), ['Big title', 'Sub title', 'body']);
      expect(_privateType('_MarkdownRule'), findsNothing);
      expect(
        _effectiveStyle(tester, 'Big title').fontSize,
        textTheme.titleLarge!.fontSize,
      );
      expect(
        _effectiveStyle(tester, 'Sub title').fontSize,
        textTheme.titleMedium!.fontSize,
      );
    });

    testWidgets('links inside a heading are tappable', (tester) async {
      final harness = _Harness();
      await harness.pump(tester, '## Read [the site](https://example.com/h)');

      expect(
        _effectiveStyle(tester, 'the site').color,
        _theme(tester).colorScheme.primary,
      );
      await _tapText(tester, 'the site');
      expect(harness.taps.single.href, 'https://example.com/h');
    });
  });

  group('+++ collapsible blocks', () {
    const volumes = '''
Intro line.

+++**Volume 1**
1. [Chapter 1](https://example.com/c1)
2. [Chapter 2](https://example.com/c2)
+++
+++[Volume 2](https://example.com/v2)
1. Chapter 3 by Somebody+++
+++
''';

    testWidgets('collapsed by default, expanding on summary tap', (
      tester,
    ) async {
      final harness = _Harness();
      await harness.pump(tester, volumes);

      expect(find.text('Volume 1'), findsOneWidget);
      expect(find.text('Chapter 1'), findsNothing);

      await _tapText(tester, 'Volume 1');

      expect(find.text('Chapter 1'), findsOneWidget);
      expect(find.text('Chapter 2'), findsOneWidget);
      expect(find.text('1.'), findsOneWidget);
      expect(find.text('Chapter 3 by Somebody+++'), findsNothing);

      await _tapText(tester, 'Volume 1');
      expect(find.text('Chapter 1'), findsNothing);
    });

    testWidgets('bold or linked summary, list body, consecutive blocks', (
      tester,
    ) async {
      final harness = _Harness();
      await harness.pump(tester, volumes);

      expect(_privateType('_MarkdownDetails'), findsNWidgets(2));
      expect(_effectiveStyle(tester, 'Volume 1').fontWeight, FontWeight.bold);
      expect(
        _effectiveStyle(tester, 'Volume 2').color,
        _theme(tester).colorScheme.primary,
      );
      expect(_allText(tester), isNot(contains('+++')));

      // The summary row (not the link text) toggles the block.
      await tester.tap(find.byIcon(Icons.arrow_right).last);
      await tester.pumpAndSettle();

      // A trailing `text+++` stays literal inside the body.
      expect(find.text('Chapter 3 by Somebody+++'), findsOneWidget);

      // Volume 1 is still collapsed.
      expect(find.text('Chapter 1'), findsNothing);
    });

    testWidgets('CRLF close lines', (tester) async {
      final harness = _Harness();
      await harness.pump(tester, volumes.replaceAll('\n', '\r\n'));

      expect(_privateType('_MarkdownDetails'), findsNWidgets(2));
      expect(_allText(tester), isNot(contains('+++')));

      await _tapText(tester, 'Volume 1');
      expect(find.text('Chapter 2'), findsOneWidget);
    });

    testWidgets('an unclosed block closes at end of input', (tester) async {
      final harness = _Harness();
      await harness.pump(tester, 'Before\n\n+++Extras\n- one\n- two');

      expect(find.text('one'), findsNothing);
      await _tapText(tester, 'Extras');
      expect(find.text('one'), findsOneWidget);
      expect(find.text('two'), findsOneWidget);
    });

    testWidgets('a lone +++ with no open block stays literal', (tester) async {
      final harness = _Harness();
      await harness.pump(tester, 'Before\n\n+++\n\nAfter');

      expect(_privateType('_MarkdownDetails'), findsNothing);
      expect(_texts(tester), ['Before', '+++', 'After']);
    });

    testWidgets('blocks nest', (tester) async {
      final harness = _Harness();
      await harness.pump(tester, '''
+++Outer
+++Inner
inner body
+++
outer body
+++
after
''');

      expect(find.text('after'), findsOneWidget);
      expect(find.text('Inner'), findsNothing);

      await _tapText(tester, 'Outer');
      expect(find.text('Inner'), findsOneWidget);
      expect(find.text('outer body'), findsOneWidget);
      expect(find.text('inner body'), findsNothing);

      await _tapText(tester, 'Inner');
      expect(find.text('inner body'), findsOneWidget);
    });

    testWidgets('+++ followed by a space or mid-line stays literal', (
      tester,
    ) async {
      final harness = _Harness();
      await harness.pump(tester, '+++ spaced\n\nmid+++line\n\nC+++ and C++');

      expect(_privateType('_MarkdownDetails'), findsNothing);
      expect(_texts(tester), ['+++ spaced', 'mid+++line', 'C+++ and C++']);
    });

    testWidgets('expansion resets when data changes', (tester) async {
      final harness = _Harness();
      await harness.pump(tester, volumes);
      await _tapText(tester, 'Volume 1');
      expect(find.text('Chapter 1'), findsOneWidget);

      await harness.pump(tester, '$volumes\nMore.');
      expect(find.text('Chapter 1'), findsNothing);
    });
  });

  testWidgets('CRLF input', (tester) async {
    final harness = _Harness();
    await harness.pump(tester, 'one\r\ntwo\r\n\r\n- a\r\n- b\r\n\r\nend\rline');

    expect(_texts(tester), ['one\ntwo', '•', 'a', '•', 'b', 'end\nline']);
    expect(_allText(tester), isNot(contains('\r')));
  });

  testWidgets('unobserved GFM constructs degrade without dropping text', (
    tester,
  ) async {
    final harness = _Harness();
    await harness.pump(tester, '''
> quoted *text*

Some `inline code` here.

```dart
final code = 1;
```

- outer
  - nested
    - deeper

- [ ] open task
- [x] done task

Raw <b>html</b> stays.
''');

    final all = _allText(tester);
    expect(all, contains('quoted text'));
    expect(all, contains('Some inline code here.'));
    expect(all, contains('final code = 1;'));
    expect(all, contains('outer'));
    expect(all, contains('nested'));
    expect(all, contains('deeper'));
    expect(all, contains('☐ open task'));
    expect(all, contains('☑ done task'));
    expect(all, contains('Raw <b>html</b> stays.'));

    expect(_privateType('_MarkdownBlockQuote'), findsOneWidget);
    expect(_privateType('_MarkdownCodeBlock'), findsOneWidget);
    expect(
      _effectiveStyle(tester, 'inline code').fontFamily,
      contains('monospace'),
    );

    // Nested lists indent one level per depth.
    final outer = tester.getTopLeft(find.text('outer')).dx;
    final nested = tester.getTopLeft(find.text('nested')).dx;
    final deeper = tester.getTopLeft(find.text('deeper')).dx;
    expect(nested, greaterThan(outer));
    expect(deeper, greaterThan(nested));
  });

  testWidgets('single ~ stays literal', (tester) async {
    final harness = _Harness();
    await harness.pump(tester, '~ある日の物語~ and ~one~~ and ~~two~~');

    expect(_texts(tester), ['~ある日の物語~ and ~one~~ and two']);
    expect(
      _effectiveStyle(tester, '~ある日').decoration,
      isNot(TextDecoration.lineThrough),
    );
  });

  testWidgets('non-http(s) image URIs do not load', (tester) async {
    final harness = _Harness();
    await harness.pump(
      tester,
      '![data alt](data:image/png;base64,iVBORw0KGgo=) '
      '![file alt](file:///sdcard/a.png) '
      '![relative alt](images/a.png) '
      '![resource alt](resource:assets/a.png) '
      '[![linked alt](ftp://example.com/a.png)](https://example.com/l)',
    );
    await tester.pumpAndSettle();

    expect(find.byType(CachedNetworkImage), findsNothing);
    expect(find.byType(Image), findsNothing);
    expect(harness.cache.requested, isEmpty);
    expect(_texts(tester), [
      'data alt file alt relative alt resource alt linked alt',
    ]);

    await _tapText(tester, 'linked alt');
    expect(harness.taps, [
      (text: '', href: 'https://example.com/l', title: null),
    ]);
  });

  testWidgets('link recognizers are disposed when data changes', (
    tester,
  ) async {
    final baseline = debugLiveMarkdownLinkRecognizers;
    final harness = _Harness();

    await harness.pump(
      tester,
      '[a](https://example.com/a) [b](https://example.com/b)\n\n'
      '- [c](https://example.com/c)',
    );
    expect(debugLiveMarkdownLinkRecognizers, baseline + 3);

    // Rebuilding with the same data keeps the recognizers.
    await harness.pump(
      tester,
      '[a](https://example.com/a) [b](https://example.com/b)\n\n'
      '- [c](https://example.com/c)',
    );
    expect(debugLiveMarkdownLinkRecognizers, baseline + 3);

    await harness.pump(tester, 'Only [d](https://example.com/d)');
    expect(debugLiveMarkdownLinkRecognizers, baseline + 1);

    // Recognizers inside collapsed blocks are only created when expanded.
    await harness.pump(
      tester,
      '+++[e](https://example.com/e)\n[f](https://example.com/f)\n+++',
    );
    expect(debugLiveMarkdownLinkRecognizers, baseline + 1);
    await tester.tap(find.byIcon(Icons.arrow_right));
    await tester.pumpAndSettle();
    expect(debugLiveMarkdownLinkRecognizers, baseline + 2);

    await tester.pumpWidget(const SizedBox());
    expect(debugLiveMarkdownLinkRecognizers, baseline);
  });

  testWidgets('a new onTapLink is used without recreating recognizers', (
    tester,
  ) async {
    final first = _Harness();
    await first.pump(tester, '[go](https://example.com/go)');
    final recognizer = _spanContaining(tester, 'go').recognizer;
    expect(recognizer, isA<TapGestureRecognizer>());

    final second = _Harness();
    await second.pump(tester, '[go](https://example.com/go)');
    expect(_spanContaining(tester, 'go').recognizer, same(recognizer));

    await _tapText(tester, 'go');
    expect(first.taps, isEmpty);
    expect(second.taps.single.href, 'https://example.com/go');
  });
}
