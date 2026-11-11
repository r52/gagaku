/// Read-only Markdown renderer for MangaDex descriptions, creator biographies,
/// and Paperback synopses.
///
/// Parses with `package:markdown` (GitHub-flavored, minus single-tilde
/// strikethrough, plus MangaDex `+++` collapsible blocks), converts the AST to an immutable block model once per
/// input, and builds widgets from that model. Styling comes from the
/// `material_ui` [Theme]. This library must never import SDK
/// `material.dart` or `cupertino.dart`.
library;

import 'package:cached_network_image_ce/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/util/cached_network_image.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:material_ui/material_ui.dart';

part 'model.dart';
part 'syntax.dart';
part 'widgets.dart';

/// Signature of [MarkdownView.onTapLink]: the link's text content, its
/// destination, and its optional title.
typedef MarkdownTapLinkCallback = void Function(
  String text,
  String href,
  String? title,
);

/// Renders [data] as Markdown.
class MarkdownView extends HookWidget {
  const MarkdownView({super.key, required this.data, this.onTapLink});

  /// The Markdown source. CRLF and CR line endings are accepted.
  ///
  /// MangaDex `+++` collapsible blocks are always recognized, so text from a
  /// Paperback MangaDex extension renders like the native client.
  final String data;

  /// Called when a link (text or image) is tapped.
  final MarkdownTapLinkCallback? onTapLink;

  @override
  Widget build(BuildContext context) {
    final blocks = useMemoized(() => _parseMarkdown(data), [data]);

    return _MarkdownScope(
      onTapLink: onTapLink,
      // A new block model remounts the subtree, which resets collapsible
      // block state and disposes every link recognizer of the old model.
      child: KeyedSubtree(
        key: ObjectKey(blocks),
        child: _MarkdownBlocks(blocks: blocks),
      ),
    );
  }
}

int _debugLiveLinkRecognizers = 0;

/// The number of link recognizers currently owned by [MarkdownView]s.
///
/// Only tracked in debug builds; always `0` in release builds.
@visibleForTesting
int get debugLiveMarkdownLinkRecognizers => _debugLiveLinkRecognizers;

List<_Block> _parseMarkdown(String data) {
  final normalized = data.replaceAll('\r\n', '\n').replaceAll('\r', '\n');
  final document = md.Document(
    blockSyntaxes: const [_MangaDexDetailsSyntax()],
    extensionSet: _markdownExtensionSet,
    encodeHtml: false,
  );
  return const _AstConverter().blocks(document.parse(normalized));
}
