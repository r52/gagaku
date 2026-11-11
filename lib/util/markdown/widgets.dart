part of 'markdown_view.dart';

const double _blockSpacing = 8.0;

/// Table cell padding. `flutter_markdown_plus`'s
/// 16 px horizontal default is too wide on small screens.
const _tableCellPadding = EdgeInsets.all(8.0);

/// Provides the current [MarkdownView.onTapLink] to link recognizers and
/// image links. Read at tap time, so it never needs to notify dependents.
class _MarkdownScope extends InheritedWidget {
  const _MarkdownScope({required this.onTapLink, required super.child});

  final MarkdownTapLinkCallback? onTapLink;

  static void tapLink(BuildContext context, _Link link) {
    final scope = context.getInheritedWidgetOfExactType<_MarkdownScope>();
    scope?.onTapLink?.call(link.text, link.href, link.title);
  }

  @override
  bool updateShouldNotify(_MarkdownScope oldWidget) => false;
}

/// Theme-derived text styles.
@immutable
class _MarkdownStyles {
  factory _MarkdownStyles.of(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    final body = textTheme.bodyMedium ?? const TextStyle();

    return _MarkdownStyles._(
      body: body,
      headings: [
        textTheme.titleLarge ?? body,
        textTheme.titleMedium ?? body,
        textTheme.titleSmall ?? body,
        for (var i = 0; i < 3; i++)
          (textTheme.bodyLarge ?? body).copyWith(fontWeight: FontWeight.bold),
      ],
      link: colorScheme.primary,
      codeBackground: colorScheme.surfaceContainer,
      outline: colorScheme.outlineVariant,
    );
  }

  const _MarkdownStyles._({
    required this.body,
    required this.headings,
    required this.link,
    required this.codeBackground,
    required this.outline,
  });

  final TextStyle body;

  /// `h1` through `h6`.
  final List<TextStyle> headings;
  final Color link;
  final Color codeBackground;
  final Color outline;

  static const _monospace = TextStyle(
    fontFamily: 'monospace',
    fontFamilyFallback: ['RobotoMono', 'Menlo', 'Courier New'],
  );

  TextStyle heading(int level) => headings[(level - 1).clamp(0, 5)];

  TextStyle get code => body.merge(_monospace);

  /// The style applied on top of a block's base style for an inline run.
  TextStyle inline(_InlineStyle style, {required bool isLink}) {
    final decorations = [
      if (isLink) TextDecoration.underline,
      if (style.strikethrough) TextDecoration.lineThrough,
    ];
    return TextStyle(
      fontWeight: style.strong ? FontWeight.bold : null,
      fontStyle: style.emphasis ? FontStyle.italic : null,
      color: isLink ? link : null,
      decoration: decorations.isEmpty
          ? null
          : TextDecoration.combine(decorations),
      decorationColor: isLink ? link : null,
      backgroundColor: style.code ? codeBackground : null,
    ).merge(style.code ? _monospace : null);
  }
}

/// A vertical run of blocks separated by the block gap.
class _MarkdownBlocks extends StatelessWidget {
  const _MarkdownBlocks({required this.blocks});

  final List<_Block> blocks;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: _blockSpacing,
      children: [for (final block in blocks) _MarkdownBlock(block: block)],
    );
  }
}

/// Dispatches one block to its widget.
class _MarkdownBlock extends StatelessWidget {
  const _MarkdownBlock({required this.block});

  final _Block block;

  @override
  Widget build(BuildContext context) {
    final styles = _MarkdownStyles.of(context);

    return switch (block) {
      _ParagraphBlock(:final content) => _MarkdownParagraph(
        content: content,
        style: styles.body,
      ),
      _HeadingBlock(:final level, :final content) => Semantics(
        header: true,
        child: _MarkdownParagraph(
          content: content,
          style: styles.heading(level),
        ),
      ),
      final _ListBlock list => _MarkdownList(list: list),
      final _TableBlock table => _MarkdownTable(table: table),
      _RuleBlock() => const _MarkdownRule(),
      _BlockQuoteBlock(:final children) => _MarkdownBlockQuote(
        children: children,
      ),
      _CodeBlock(:final text) => _MarkdownCodeBlock(text: text),
      final _DetailsBlock details => _MarkdownDetails(details: details),
    };
  }
}

/// A recognizer for one link, tracked in debug builds for leak tests.
class _LinkRecognizer extends TapGestureRecognizer {
  _LinkRecognizer() {
    assert(() {
      _debugLiveLinkRecognizers++;
      return true;
    }());
  }

  @override
  void dispose() {
    assert(() {
      _debugLiveLinkRecognizers--;
      return true;
    }());
    super.dispose();
  }
}

/// Rich text for one inline content run: paragraphs, headings, list item
/// text, table cells, and collapsible summaries.
///
/// Owns one recognizer per link of [content], recreated when [content]
/// changes and disposed with the widget.
class _MarkdownParagraph extends HookWidget {
  const _MarkdownParagraph({
    required this.content,
    required this.style,
    this.textAlign = TextAlign.start,
  });

  final _InlineContent content;
  final TextStyle style;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    final styles = _MarkdownStyles.of(context);
    final recognizers = useMemoized(
      () => {
        for (final link in content.links)
          link: _LinkRecognizer()
            ..onTap = () => _MarkdownScope.tapLink(context, link),
      },
      [content],
    );
    useEffect(
      () => () {
        for (final recognizer in recognizers.values) {
          recognizer.dispose();
        }
      },
      [recognizers],
    );

    return Text.rich(
      TextSpan(
        style: style,
        children: [
          for (final run in content.runs)
            switch (run) {
              _TextRun(:final text, style: final inline, :final link) =>
                TextSpan(
                  text: text,
                  style: styles.inline(inline, isLink: link != null),
                  recognizer: link == null ? null : recognizers[link],
                ),
              final _ImageRun image => WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: _MarkdownImage(image: image, altStyle: style),
              ),
            },
        ],
      ),
      textAlign: textAlign,
    );
  }
}

/// An `http`/`https` image, loaded through the shared image cache. Falls back
/// to its alt text when loading fails, and is tappable inside a link.
class _MarkdownImage extends ConsumerWidget {
  const _MarkdownImage({required this.image, required this.altStyle});

  final _ImageRun image;
  final TextStyle altStyle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cacheManager = ref.watch(extensionImageCacheProvider);
    final link = image.link;

    Widget child = CachedNetworkImage(
      cacheManager: cacheManager,
      imageUrl: image.src.toString(),
      errorBuilder: (context, error, stackTrace) => image.alt.isEmpty
          ? const SizedBox.shrink()
          : Text(image.alt, style: altStyle),
    );

    if (image.alt.isNotEmpty) {
      child = Semantics(image: true, label: image.alt, child: child);
    }

    if (link != null) {
      child = MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _MarkdownScope.tapLink(context, link),
          child: child,
        ),
      );
    }

    return child;
  }
}

/// Bullet or numbered list with a fixed-width marker column.
class _MarkdownList extends StatelessWidget {
  const _MarkdownList({required this.list});

  final _ListBlock list;

  @override
  Widget build(BuildContext context) {
    final style = _MarkdownStyles.of(context).body;

    return Table(
      columnWidths: const {0: IntrinsicColumnWidth(), 1: FlexColumnWidth()},
      defaultVerticalAlignment: TableCellVerticalAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        for (final (index, item) in list.items.indexed)
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 4.0),
                // At least 24 px wide, as flutter_markdown_plus laid out
                // markers; wider numbers grow the column.
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: 24.0),
                  child: Text(
                    list.ordered ? '${list.start + index}.' : '•',
                    style: style,
                    textAlign: list.ordered ? TextAlign.end : TextAlign.center,
                  ),
                ),
              ),
              // Items are separated by the block gap, as other blocks are.
              Padding(
                padding: EdgeInsets.only(
                  bottom: index == list.items.length - 1 ? 0.0 : _blockSpacing,
                ),
                child: _MarkdownBlocks(blocks: item.children),
              ),
            ],
          ),
      ],
    );
  }
}

/// A table whose cells wrap instead of scrolling horizontally.
class _MarkdownTable extends StatelessWidget {
  const _MarkdownTable({required this.table});

  final _TableBlock table;

  @override
  Widget build(BuildContext context) {
    if (table.alignments.isEmpty) return const SizedBox.shrink();

    final styles = _MarkdownStyles.of(context);
    final headerStyle = styles.body.copyWith(fontWeight: FontWeight.bold);

    return Table(
      border: TableBorder.all(color: styles.outline),
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      children: [
        TableRow(
          children: [
            for (final (column, cell) in table.header.indexed)
              Padding(
                padding: _tableCellPadding,
                child: _MarkdownParagraph(
                  content: cell,
                  style: headerStyle,
                  textAlign: table.alignments[column],
                ),
              ),
          ],
        ),
        for (final row in table.rows)
          TableRow(
            children: [
              for (final (column, cell) in row.indexed)
                Padding(
                  padding: _tableCellPadding,
                  child: _MarkdownParagraph(
                    content: cell,
                    style: styles.body,
                    textAlign: table.alignments[column],
                  ),
                ),
            ],
          ),
      ],
    );
  }
}

/// A 1 px horizontal rule.
class _MarkdownRule extends StatelessWidget {
  const _MarkdownRule();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1.0,
      child: ColoredBox(color: _MarkdownStyles.of(context).outline),
    );
  }
}

class _MarkdownBlockQuote extends StatelessWidget {
  const _MarkdownBlockQuote({required this.children});

  final List<_Block> children;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: BorderDirectional(
          start: BorderSide(
            color: _MarkdownStyles.of(context).outline,
            width: 4.0,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.only(start: 12.0),
        child: _MarkdownBlocks(blocks: children),
      ),
    );
  }
}

/// A fenced or indented code block. Lines wrap rather than scroll.
class _MarkdownCodeBlock extends StatelessWidget {
  const _MarkdownCodeBlock({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final styles = _MarkdownStyles.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: styles.codeBackground,
        borderRadius: const BorderRadius.all(Radius.circular(4.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(text, style: styles.code),
      ),
    );
  }
}

/// A MangaDex `+++` collapsible block, collapsed by default.
class _MarkdownDetails extends HookWidget {
  const _MarkdownDetails({required this.details});

  final _DetailsBlock details;

  static const _duration = Duration(milliseconds: 200);

  @override
  Widget build(BuildContext context) {
    final expanded = useState(false);
    final styles = _MarkdownStyles.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Semantics(
          button: true,
          expanded: expanded.value,
          child: InkWell(
            onTap: () => expanded.value = !expanded.value,
            child: Row(
              children: [
                AnimatedRotation(
                  turns: expanded.value ? 0.25 : 0.0,
                  duration: _duration,
                  child: Icon(
                    Icons.arrow_right,
                    size: 24.0,
                    color: styles.body.color,
                  ),
                ),
                Expanded(
                  child: _MarkdownParagraph(
                    content: details.summary,
                    style: styles.body,
                  ),
                ),
              ],
            ),
          ),
        ),
        AnimatedSize(
          duration: _duration,
          alignment: AlignmentDirectional.topStart,
          child: expanded.value
              ? Padding(
                  padding: const EdgeInsetsDirectional.only(
                    start: 24.0,
                    top: _blockSpacing,
                  ),
                  child: _MarkdownBlocks(blocks: details.children),
                )
              : const SizedBox(width: double.infinity),
        ),
      ],
    );
  }
}
