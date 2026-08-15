import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_readium/flutter_readium.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/local/model/config.dart';
import 'package:gagaku/local/model/document_session.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/util/ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

typedef LocalDocumentReaderBuilder =
    Widget Function(BuildContext context, Publication publication);

class LocalDocumentReaderRouteBuilder<T>
    extends SlideTransitionRouteBuilder<T> {
  LocalDocumentReaderRouteBuilder({required LocalDocumentDescriptor descriptor})
    : super(
        pageBuilder: (context, animation, secondaryAnimation) =>
            LocalDocumentReaderScreen(descriptor: descriptor),
      );
}

class LocalDocumentReaderScreen extends StatefulWidget {
  const LocalDocumentReaderScreen({
    required this.descriptor,
    this.controller,
    this.readerBuilder,
    super.key,
  });

  final LocalDocumentDescriptor descriptor;
  final LocalDocumentSessionController? controller;
  final LocalDocumentReaderBuilder? readerBuilder;

  @override
  State<LocalDocumentReaderScreen> createState() =>
      _LocalDocumentReaderScreenState();
}

class _LocalDocumentReaderScreenState extends State<LocalDocumentReaderScreen> {
  late final LocalDocumentSessionController _controller;
  bool _initialized = false;
  bool _chromeVisible = true;
  bool _allowPop = false;
  bool _popRequested = false;

  Timer? _pendingSingleTap;
  Offset? _pointerDownPosition;
  bool _pointerMoved = false;
  bool _suppressPointerUp = false;
  int _pointerCount = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialized) return;
    _initialized = true;
    final providedController = widget.controller;
    if (providedController != null) {
      _controller = providedController;
    } else {
      final container = ProviderScope.containerOf(context, listen: false);
      final config = container.read(localConfigProvider);
      final colors = Theme.of(context).colorScheme;
      _controller = LocalDocumentSessionController(
        descriptor: widget.descriptor,
        initialEpubFontSize: config.epubFontSize,
        initialEpubScroll: config.epubScroll,
        epubBackgroundColor: colors.surface,
        epubTextColor: colors.onSurface,
        onEpubPreferencesChanged: (fontSize, scroll) => container
            .read(localConfigProvider.notifier)
            .saveEpubPreferences(fontSize: fontSize, scroll: scroll),
      );
    }
    _controller
      ..addListener(_onControllerChanged)
      ..open();
  }

  void _onControllerChanged() {
    if (mounted) setState(() {});
  }

  Future<void> _requestPop() async {
    if (_allowPop || _popRequested) return;
    _popRequested = true;
    await _controller.close();
    if (!mounted) return;

    setState(() => _allowPop = true);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) Navigator.of(context).pop();
    });
  }

  void _blockExternalLink(String link) {
    logger.w('Local document reader blocked external link: $link');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(context.t.localLibrary.documentExternalLinkBlocked),
      ),
    );
  }

  void _onPointerDown(PointerDownEvent event) {
    _pointerCount++;
    if (_pendingSingleTap?.isActive ?? false) {
      _pendingSingleTap?.cancel();
      _suppressPointerUp = true;
    }
    if (_pointerCount > 1) {
      _pointerMoved = true;
      _suppressPointerUp = true;
    } else {
      _pointerDownPosition = event.localPosition;
      _pointerMoved = false;
    }
  }

  void _onPointerMove(PointerMoveEvent event) {
    final origin = _pointerDownPosition;
    if (origin != null && (event.localPosition - origin).distance > 8) {
      _pointerMoved = true;
    }
  }

  void _onPointerUp(PointerUpEvent event, double width) {
    _pointerCount = (_pointerCount - 1).clamp(0, 10);
    if (_pointerCount > 0) return;

    final suppress = _suppressPointerUp;
    _suppressPointerUp = false;
    final moved = _pointerMoved;
    _pointerMoved = false;
    _pointerDownPosition = null;
    if (suppress || moved) return;

    const edgeWidth = 70.0;
    final x = event.localPosition.dx;
    if (x < edgeWidth || width - x < edgeWidth) return;

    _pendingSingleTap?.cancel();
    _pendingSingleTap = Timer(const Duration(milliseconds: 350), () {
      if (mounted) setState(() => _chromeVisible = !_chromeVisible);
    });
  }

  void _onPointerCancel(PointerCancelEvent event) {
    _pointerCount = 0;
    _pointerMoved = false;
    _suppressPointerUp = false;
    _pointerDownPosition = null;
  }

  Widget _buildReader(BuildContext context, Publication publication) {
    final customBuilder = widget.readerBuilder;
    if (customBuilder != null) return customBuilder(context, publication);

    return ReadiumReaderWidget(
      publication: publication,
      allowedDefaultActions: const {},
      onExternalLinkActivated: _blockExternalLink,
      onTextSelected: (event) {
        logger.d(
          'Local document reader selected text '
          '(${event.selectedText?.length ?? 0} characters)',
        );
      },
    );
  }

  Widget _buildBody(BuildContext context) {
    final state = _controller.state;
    return switch (state.phase) {
      LocalDocumentSessionPhase.loading => const Center(
        child: CircularProgressIndicator(),
      ),
      LocalDocumentSessionPhase.failure => Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            context.t.localLibrary.documentOpenFailed,
            textAlign: TextAlign.center,
          ),
        ),
      ),
      LocalDocumentSessionPhase.closed => const SizedBox.shrink(),
      LocalDocumentSessionPhase.ready => LayoutBuilder(
        builder: (context, constraints) => Listener(
          behavior: HitTestBehavior.translucent,
          onPointerDown: _onPointerDown,
          onPointerMove: _onPointerMove,
          onPointerUp: (event) => _onPointerUp(event, constraints.maxWidth),
          onPointerCancel: _onPointerCancel,
          child: _buildReader(context, state.publication!),
        ),
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _allowPop,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) unawaited(_requestPop());
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SafeArea(
          child: Stack(
            fit: StackFit.expand,
            children: [
              _buildBody(context),
              _DocumentChrome(
                visible: _chromeVisible,
                descriptor: widget.descriptor,
                controller: _controller,
                onBack: _requestPop,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pendingSingleTap?.cancel();
    _controller
      ..removeListener(_onControllerChanged)
      ..dispose();
    super.dispose();
  }
}

class _DocumentChrome extends StatelessWidget {
  const _DocumentChrome({
    required this.visible,
    required this.descriptor,
    required this.controller,
    required this.onBack,
  });

  final bool visible;
  final LocalDocumentDescriptor descriptor;
  final LocalDocumentSessionController controller;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final enabled = controller.state.readerReady;
    return AnimatedOpacity(
      key: const ValueKey('local-document-chrome'),
      opacity: visible ? 1 : 0,
      duration: const Duration(milliseconds: 180),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: IgnorePointer(
              ignoring: !visible,
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Material(
                    color: Theme.of(
                      context,
                    ).colorScheme.surfaceContainer.withValues(alpha: 0.86),
                    borderRadius: BorderRadius.circular(24),
                    clipBehavior: Clip.antiAlias,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: onBack,
                          tooltip: MaterialLocalizations.of(
                            context,
                          ).backButtonTooltip,
                          icon: const Icon(Icons.arrow_back),
                        ),
                        Expanded(
                          child: Text(
                            descriptor.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 16),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (descriptor.format == LocalDocumentFormat.epub)
            Positioned(
              top: 0,
              right: 8,
              bottom: 0,
              child: Center(
                child: IgnorePointer(
                  ignoring: !visible,
                  child: Material(
                    key: const ValueKey('document-side-controls'),
                    color: Theme.of(
                      context,
                    ).colorScheme.surfaceContainer.withValues(alpha: 0.78),
                    borderRadius: BorderRadius.circular(28),
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _ProgressionButton(
                          controller: controller,
                          enabled: enabled,
                        ),
                        const Divider(height: 1),
                        IconButton(
                          onPressed: enabled
                              ? controller.decreaseEpubFontSize
                              : null,
                          tooltip: context.t.localLibrary.documentDecreaseText,
                          icon: const Icon(Icons.text_decrease),
                        ),
                        IconButton(
                          onPressed: enabled
                              ? controller.resetEpubFontSize
                              : null,
                          tooltip: context.t.localLibrary.documentResetText,
                          icon: const Icon(Icons.text_fields),
                        ),
                        IconButton(
                          onPressed: enabled
                              ? controller.increaseEpubFontSize
                              : null,
                          tooltip: context.t.localLibrary.documentIncreaseText,
                          icon: const Icon(Icons.text_increase),
                        ),
                        IconButton(
                          onPressed: enabled
                              ? controller.toggleEpubScroll
                              : null,
                          tooltip: controller.epubScroll
                              ? context.t.localLibrary.documentPaginatedMode
                              : context.t.localLibrary.documentScrollMode,
                          icon: Icon(
                            controller.epubScroll
                                ? Icons.view_carousel
                                : Icons.view_day,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          Positioned(
            left: 8,
            right: 8,
            bottom: 8,
            child: Center(
              child: IgnorePointer(
                ignoring: !visible,
                child: Material(
                  key: const ValueKey('document-bottom-controls'),
                  color: Theme.of(
                    context,
                  ).colorScheme.surfaceContainer.withValues(alpha: 0.82),
                  borderRadius: BorderRadius.circular(28),
                  clipBehavior: Clip.antiAlias,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: enabled ? controller.goBackward : null,
                        tooltip: context.t.localLibrary.documentPrevious,
                        icon: const Icon(Icons.arrow_back_ios_new),
                      ),
                      if (descriptor.format == LocalDocumentFormat.pdf)
                        _PdfJumpButton(controller: controller, enabled: enabled)
                      else ...[
                        IconButton(
                          onPressed: enabled
                              ? () => controller.goToAdjacentToc(-1)
                              : null,
                          tooltip:
                              context.t.localLibrary.documentPreviousChapter,
                          icon: const Icon(Icons.skip_previous),
                        ),
                        _TocButton(controller: controller, enabled: enabled),
                        IconButton(
                          onPressed: enabled
                              ? () => controller.goToAdjacentToc(1)
                              : null,
                          tooltip: context.t.localLibrary.documentNextChapter,
                          icon: const Icon(Icons.skip_next),
                        ),
                      ],
                      IconButton(
                        onPressed: enabled ? controller.goForward : null,
                        tooltip: context.t.localLibrary.documentNext,
                        icon: const Icon(Icons.arrow_forward_ios),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PdfJumpButton extends StatelessWidget {
  const _PdfJumpButton({required this.controller, required this.enabled});

  final LocalDocumentSessionController controller;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final state = controller.state;
    final current = state.locator?.locations?.position;
    final total = state.publication?.metadata.numberOfPages;
    return IconButton(
      onPressed: !enabled || total == null || total < 1
          ? null
          : () => _showPdfPagePicker(context, current ?? 1, total),
      tooltip: current == null || total == null
          ? context.t.localLibrary.documentJumpPage
          : context.t.localLibrary.documentPage(current: current, total: total),
      icon: const Icon(Icons.find_in_page),
    );
  }

  Future<void> _showPdfPagePicker(
    BuildContext context,
    int current,
    int total,
  ) async {
    final theme = Theme.of(context);
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: theme.colorScheme.surfaceContainerHigh.withValues(
        alpha: 1,
      ),
      showDragHandle: true,
      builder: (context) => SafeArea(
        top: false,
        child: SizedBox(
          key: const ValueKey('document-pdf-page-picker'),
          height: 250,
          child: Column(
            children: [
              Text(
                context.t.localLibrary.documentJumpPage,
                style: theme.textTheme.titleMedium,
              ),
              Expanded(
                child: CupertinoPicker(
                  scrollController: FixedExtentScrollController(
                    initialItem: (current - 1).clamp(0, total - 1),
                  ),
                  itemExtent: 40,
                  changeReportingBehavior: ChangeReportingBehavior.onScrollEnd,
                  onSelectedItemChanged: (index) {
                    unawaited(controller.goToPdfPage(index + 1));
                  },
                  children: List.generate(
                    total,
                    (index) => Center(child: Text('${index + 1}')),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TocButton extends StatelessWidget {
  const _TocButton({required this.controller, required this.enabled});

  final LocalDocumentSessionController controller;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final toc = controller.state.publication?.tocFlattened ?? const <Link>[];
    return IconButton(
      onPressed: !enabled || toc.isEmpty ? null : () => _showToc(context, toc),
      tooltip: context.t.localLibrary.documentContents,
      icon: const Icon(Icons.toc),
    );
  }

  Future<void> _showToc(BuildContext context, List<Link> toc) async {
    final sheetColor = Theme.of(
      context,
    ).colorScheme.surfaceContainerHigh.withValues(alpha: 1);
    final link = await showModalBottomSheet<Link>(
      context: context,
      backgroundColor: sheetColor,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: ListView.builder(
          key: const ValueKey('document-toc-sheet'),
          itemCount: toc.length,
          itemBuilder: (context, index) {
            final link = toc[index];
            return ListTile(
              title: Text(
                link.title ??
                    context.t.localLibrary.documentChapter(number: index + 1),
              ),
              onTap: () => Navigator.of(context).pop(link),
            );
          },
        ),
      ),
    );
    if (link != null) await controller.goToTocLink(link);
  }
}

class _ProgressionButton extends StatelessWidget {
  const _ProgressionButton({required this.controller, required this.enabled});

  final LocalDocumentSessionController controller;
  final bool enabled;

  @override
  Widget build(BuildContext context) => IconButton(
    onPressed: enabled ? () => _showProgression(context) : null,
    tooltip: context.t.localLibrary.documentJumpSection,
    icon: const Icon(Icons.linear_scale),
  );

  Future<void> _showProgression(BuildContext context) async {
    var progression =
        controller.state.locator?.locations?.progression?.clamp(0.0, 1.0) ?? 0;
    final sheetColor = Theme.of(
      context,
    ).colorScheme.surfaceContainerHigh.withValues(alpha: 1);
    final selected = await showModalBottomSheet<double>(
      context: context,
      backgroundColor: sheetColor,
      showDragHandle: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setSheetState) => SafeArea(
          top: false,
          child: Padding(
            key: const ValueKey('document-progression-sheet'),
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  context.t.localLibrary.documentJumpSection,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  context.t.localLibrary.documentSectionProgress(
                    percent: (progression * 100).round(),
                  ),
                ),
                Slider(
                  value: progression,
                  divisions: 100,
                  label: '${(progression * 100).round()}%',
                  onChanged: (value) =>
                      setSheetState(() => progression = value),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(context.t.ui.cancel),
                    ),
                    const SizedBox(width: 8),
                    FilledButton(
                      onPressed: () => Navigator.of(context).pop(progression),
                      child: Text(context.t.ui.go),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
    if (selected != null) await controller.goToProgression(selected);
  }
}
