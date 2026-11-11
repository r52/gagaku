part of 'markdown_view.dart';

/// `ExtensionSet.gitHubFlavored`, with single-tilde strikethrough removed.
///
/// MangaDex descriptions use `~subtitle~` decoratively, so only `~~` strikes
/// through.
final _markdownExtensionSet = md.ExtensionSet(
  const [
    md.FencedCodeBlockSyntax(),
    md.TableSyntax(),
    md.UnorderedListWithCheckboxSyntax(),
    md.OrderedListWithCheckboxSyntax(),
    md.FootnoteDefSyntax(),
  ],
  [
    md.InlineHtmlSyntax(),
    _DoubleTildeStrikethroughSyntax(),
    md.AutolinkExtensionSyntax(),
  ],
);

/// GFM strikethrough that only accepts `~~` delimiters.
class _DoubleTildeStrikethroughSyntax extends md.DelimiterSyntax {
  _DoubleTildeStrikethroughSyntax()
    : super(
        '~+',
        requiresDelimiterRun: true,
        allowIntraWord: true,
        startCharacter: 0x7E, // ~
        tags: [md.DelimiterTag('del', 2)],
      );
}

/// MangaDex `+++` collapsible blocks.
///
/// A line starting with `+++` immediately followed by text opens a block, and
/// the rest of that line is its inline summary. A line that is only `+++`
/// closes it; a block left open at end of input closes implicitly. The body
/// is parsed with the full block parser, so blocks nest.
///
/// Produces `details > summary`, followed by the body blocks.
class _MangaDexDetailsSyntax extends md.BlockSyntax {
  const _MangaDexDetailsSyntax();

  static final _open = RegExp(r'^\+\+\+(?=\S)(.*)$');
  static final _close = RegExp(r'^\+\+\+\s*$');

  @override
  RegExp get pattern => _open;

  @override
  md.Node parse(md.BlockParser parser) {
    final summary = _open.firstMatch(parser.current.content)!.group(1)!;
    parser.advance();

    final childLines = <md.Line>[];
    var depth = 0;
    while (!parser.isDone) {
      final line = parser.current;
      if (_close.hasMatch(line.content)) {
        if (depth == 0) {
          parser.advance();
          break;
        }
        depth--;
      } else if (_open.hasMatch(line.content)) {
        depth++;
      }
      childLines.add(line);
      parser.advance();
    }

    final body = md.BlockParser(
      childLines,
      parser.document,
    ).parseLines(parentSyntax: this);

    return md.Element('details', [
      md.Element('summary', [md.UnparsedContent(summary.trim())]),
      ...body,
    ]);
  }
}
