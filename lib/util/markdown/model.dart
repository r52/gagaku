part of 'markdown_view.dart';

// Immutable block/inline model built once per Markdown input.

@immutable
sealed class _Block {
  const _Block();
}

final class _ParagraphBlock extends _Block {
  const _ParagraphBlock(this.content);

  final _InlineContent content;
}

final class _HeadingBlock extends _Block {
  const _HeadingBlock(this.level, this.content);

  /// 1 through 6.
  final int level;
  final _InlineContent content;
}

final class _ListBlock extends _Block {
  const _ListBlock({
    required this.ordered,
    required this.start,
    required this.items,
  });

  final bool ordered;

  /// The number of the first item of an ordered list.
  final int start;
  final List<_ListItem> items;
}

@immutable
final class _ListItem {
  const _ListItem(this.children);

  final List<_Block> children;
}

final class _TableBlock extends _Block {
  const _TableBlock({
    required this.alignments,
    required this.header,
    required this.rows,
  });

  final List<TextAlign> alignments;
  final List<_InlineContent> header;

  /// Every row has exactly `alignments.length` cells.
  final List<List<_InlineContent>> rows;
}

final class _RuleBlock extends _Block {
  const _RuleBlock();
}

final class _BlockQuoteBlock extends _Block {
  const _BlockQuoteBlock(this.children);

  final List<_Block> children;
}

final class _CodeBlock extends _Block {
  const _CodeBlock(this.text);

  final String text;
}

/// A MangaDex `+++` collapsible block.
final class _DetailsBlock extends _Block {
  const _DetailsBlock(this.summary, this.children);

  final _InlineContent summary;
  final List<_Block> children;
}

/// A link target. Each Markdown link gets its own instance, which identifies
/// its recognizer.
@immutable
final class _Link {
  const _Link({required this.text, required this.href, this.title});

  final String text;
  final String href;
  final String? title;
}

@immutable
final class _InlineStyle {
  const _InlineStyle({
    this.strong = false,
    this.emphasis = false,
    this.strikethrough = false,
    this.code = false,
  });

  static const plain = _InlineStyle();

  final bool strong;
  final bool emphasis;
  final bool strikethrough;
  final bool code;

  _InlineStyle copyWith({
    bool? strong,
    bool? emphasis,
    bool? strikethrough,
    bool? code,
  }) => _InlineStyle(
    strong: strong ?? this.strong,
    emphasis: emphasis ?? this.emphasis,
    strikethrough: strikethrough ?? this.strikethrough,
    code: code ?? this.code,
  );

  @override
  bool operator ==(Object other) =>
      other is _InlineStyle &&
      other.strong == strong &&
      other.emphasis == emphasis &&
      other.strikethrough == strikethrough &&
      other.code == code;

  @override
  int get hashCode => Object.hash(strong, emphasis, strikethrough, code);
}

@immutable
sealed class _InlineRun {
  const _InlineRun({required this.style, this.link});

  final _InlineStyle style;
  final _Link? link;
}

final class _TextRun extends _InlineRun {
  const _TextRun(this.text, {required super.style, super.link});

  final String text;
}

/// An `http`/`https` image. Images with other schemes become alt text runs.
final class _ImageRun extends _InlineRun {
  const _ImageRun({
    required this.src,
    required this.alt,
    required super.style,
    super.link,
  });

  final Uri src;
  final String alt;
}

@immutable
final class _InlineContent {
  const _InlineContent(this.runs, this.links);

  final List<_InlineRun> runs;

  /// Distinct links referenced by [runs], in order.
  final List<_Link> links;

  /// Whether this content has nothing visible (only whitespace text).
  bool get isBlank => runs.every(
    (run) => switch (run) {
      _TextRun(:final text) => text.trim().isEmpty,
      _ImageRun() => false,
    },
  );
}

/// Converts the `package:markdown` AST into the block model.
///
/// Unknown elements degrade to their children, so no text is dropped.
class _AstConverter {
  const _AstConverter();

  /// The `' ?\n *'` boundary of a soft line break, which renders as a line
  /// break with the surrounding spaces trimmed.
  static final _softBreak = RegExp(r' ?\n *');

  static const _blockTags = {
    'p',
    'h1',
    'h2',
    'h3',
    'h4',
    'h5',
    'h6',
    'ul',
    'ol',
    'li',
    'table',
    'thead',
    'tbody',
    'tr',
    'th',
    'td',
    'hr',
    'blockquote',
    'pre',
    'details',
    'summary',
    'section',
    'div',
  };

  List<_Block> blocks(List<md.Node> nodes) {
    final result = <_Block>[];
    final pendingInline = <md.Node>[];

    void flushInline() {
      if (pendingInline.isEmpty) return;
      final content = inline(pendingInline);
      pendingInline.clear();
      if (!content.isBlank) result.add(_ParagraphBlock(content));
    }

    for (final node in nodes) {
      if (node is md.Element && _blockTags.contains(node.tag)) {
        flushInline();
        result.addAll(_block(node));
      } else {
        pendingInline.add(node);
      }
    }
    flushInline();

    return result;
  }

  List<_Block> _block(md.Element element) {
    final children = element.children ?? const <md.Node>[];
    switch (element.tag) {
      case 'p':
        final content = inline(children);
        return content.isBlank ? const [] : [_ParagraphBlock(content)];
      case 'h1' || 'h2' || 'h3' || 'h4' || 'h5' || 'h6':
        final level = int.parse(element.tag.substring(1));
        return [_HeadingBlock(level, inline(children))];
      case 'ul' || 'ol':
        return [
          _ListBlock(
            ordered: element.tag == 'ol',
            start: int.tryParse(element.attributes['start'] ?? '') ?? 1,
            items: [
              for (final item in children)
                _ListItem(blocks(_listItemChildren(item))),
            ],
          ),
        ];
      case 'table':
        return [_table(element)];
      case 'hr':
        return const [_RuleBlock()];
      case 'blockquote':
        return [_BlockQuoteBlock(blocks(children))];
      case 'pre':
        var text = element.textContent;
        if (text.endsWith('\n')) text = text.substring(0, text.length - 1);
        return [_CodeBlock(text)];
      case 'details':
        final summary = children.firstOrNull;
        if (summary is md.Element && summary.tag == 'summary') {
          return [
            _DetailsBlock(
              inline(summary.children ?? const []),
              blocks(children.sublist(1)),
            ),
          ];
        }
        return blocks(children);
      default:
        return blocks(children);
    }
  }

  static List<md.Node> _listItemChildren(md.Node item) => switch (item) {
    md.Element(tag: 'li', :final children) => children ?? const [],
    _ => [item],
  };

  _TableBlock _table(md.Element table) {
    final rows = <md.Element>[
      for (final section in table.children ?? const <md.Node>[])
        if (section is md.Element)
          for (final row in section.children ?? const <md.Node>[])
            if (row is md.Element && row.tag == 'tr') row,
    ];

    List<md.Element> cellsOf(md.Element row) => [
      for (final cell in row.children ?? const <md.Node>[])
        if (cell is md.Element) cell,
    ];

    final headerCells = rows.isEmpty ? const <md.Element>[] : cellsOf(rows[0]);
    final columns = headerCells.length;

    List<_InlineContent> rowContent(List<md.Element> cells) => [
      for (var i = 0; i < columns; i++)
        i < cells.length
            ? inline(cells[i].children ?? const [])
            : const _InlineContent([], []),
    ];

    return _TableBlock(
      alignments: [
        for (final cell in headerCells)
          switch (cell.attributes['align']) {
            'center' => TextAlign.center,
            'right' => TextAlign.end,
            _ => TextAlign.start,
          },
      ],
      header: rowContent(headerCells),
      rows: [for (final row in rows.skip(1)) rowContent(cellsOf(row))],
    );
  }

  _InlineContent inline(List<md.Node> nodes) {
    final runs = <_InlineRun>[];
    final links = <_Link>[];

    void addText(String text, _InlineStyle style, _Link? link) {
      if (text.isEmpty) return;
      final previous = runs.lastOrNull;
      if (previous is _TextRun &&
          previous.style == style &&
          identical(previous.link, link)) {
        runs[runs.length - 1] = _TextRun(
          previous.text + text,
          style: style,
          link: link,
        );
      } else {
        runs.add(_TextRun(text, style: style, link: link));
      }
    }

    void walk(List<md.Node>? nodes, _InlineStyle style, _Link? link) {
      for (final node in nodes ?? const <md.Node>[]) {
        switch (node) {
          case md.Text(:final text):
            addText(
              style.code ? text : text.replaceAll(_softBreak, '\n'),
              style,
              link,
            );
          case md.Element(tag: 'strong'):
            walk(node.children, style.copyWith(strong: true), link);
          case md.Element(tag: 'em'):
            walk(node.children, style.copyWith(emphasis: true), link);
          case md.Element(tag: 'del'):
            walk(node.children, style.copyWith(strikethrough: true), link);
          case md.Element(tag: 'code'):
            addText(node.textContent, style.copyWith(code: true), link);
          case md.Element(tag: 'br'):
            addText('\n', style, link);
          case md.Element(tag: 'a'):
            final target = _Link(
              text: node.textContent,
              href: node.attributes['href'] ?? '',
              title: node.attributes['title'],
            );
            links.add(target);
            walk(node.children, style, target);
          case md.Element(tag: 'img'):
            final alt = node.attributes['alt'] ?? '';
            final src = Uri.tryParse(node.attributes['src'] ?? '');
            if (src != null &&
                (src.isScheme('http') || src.isScheme('https')) &&
                src.host.isNotEmpty) {
              runs.add(_ImageRun(src: src, alt: alt, style: style, link: link));
            } else {
              addText(alt, style, link);
            }
          case md.Element(tag: 'input'):
            // GFM task list checkbox.
            final checked = node.attributes.containsKey('checked');
            addText(checked ? '☑ ' : '☐ ', style, link);
          case md.Element(:final children):
            walk(children, style, link);
          default:
            addText(node.textContent, style, link);
        }
      }
    }

    walk(nodes, _InlineStyle.plain, null);

    return _InlineContent(List.unmodifiable(runs), List.unmodifiable(links));
  }
}
