import 'package:gagaku/util/riverpod.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/reader/model/config.dart';
import 'package:gagaku/reader/model/session.dart';
import 'package:gagaku/reader/model/types.dart';
import 'package:gagaku/reader/model/viewport_controller.dart';
import 'package:gagaku/reader/widgets/reader_progress_indicator.dart';
import 'package:gagaku/reader/widgets/reader_viewports.dart';
import 'package:gagaku/util/ui.dart';
import 'package:gagaku/util/util.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum LongStripScale {
  small(0.4),
  large(0.8),
  full(1.0);

  const LongStripScale(this.scale);
  final double scale;
}

typedef CtxCallback = void Function(BuildContext);

class ReaderWidget extends StatefulHookConsumerWidget {
  const ReaderWidget({
    super.key,
    required this.pages,
    required this.title,
    this.subtitle,
    this.longstrip = false,
    this.drawerHeader,
    this.onHeaderPressed,
    this.externalUrl,
  });

  final List<ReaderPage> pages;
  final String title;
  final String? subtitle;
  final bool longstrip;
  final String? drawerHeader;
  final CtxCallback? onHeaderPressed;
  final String? externalUrl;

  @override
  ConsumerState<ReaderWidget> createState() => _ReaderWidgetState();
}

class _ReaderWidgetState extends ConsumerState<ReaderWidget> {
  late final ReaderSession session;
  late final HorizontalReaderViewportController horizontalViewport;
  late final LongStripReaderViewportController longStripViewport;

  @override
  void initState() {
    super.initState();
    horizontalViewport = HorizontalReaderViewportController();
    session = ReaderSession(
      pages: widget.pages,
      subtitle: widget.subtitle,
      precacheImage: (provider) => precacheImage(provider, context),
    );
    longStripViewport = LongStripReaderViewportController(
      onVisiblePageChanged: (page) {
        session.reportVisiblePage(page, source: longStripViewport);
      },
    );
  }

  @override
  void didUpdateWidget(ReaderWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.pages != oldWidget.pages ||
        widget.subtitle != oldWidget.subtitle) {
      session.updateContent(pages: widget.pages, subtitle: widget.subtitle);
    }
  }

  @override
  void dispose() {
    horizontalViewport.dispose();
    longStripViewport.dispose();
    session.dispose();
    super.dispose();
  }

  void _saveSetting(ReaderConfig updated) {
    ref.run((tsx) async {
      return tsx.get(readerSettingsProvider.notifier).save(updated);
    });
  }

  LongStripScale toggleLongStripScale(LongStripScale current) {
    return switch (current) {
      LongStripScale.small => LongStripScale.large,
      LongStripScale.large => LongStripScale.full,
      LongStripScale.full => LongStripScale.small,
    };
  }

  KeyEventResult onTapLeft({
    required ReaderConfig settings,
    required ReaderFormat format,
  }) {
    if (format == ReaderFormat.longstrip) return KeyEventResult.handled;

    if (session.turnLeft(settings.direction) ==
        ReaderPageTurnResult.closeReader) {
      context.pop();
    }
    return KeyEventResult.handled;
  }

  KeyEventResult onTapRight({
    required ReaderConfig settings,
    required ReaderFormat format,
  }) {
    if (format == ReaderFormat.longstrip) return KeyEventResult.handled;

    if (session.turnRight(settings.direction) ==
        ReaderPageTurnResult.closeReader) {
      context.pop();
    }
    return KeyEventResult.handled;
  }

  KeyEventResult onTapTop(double offset, {required ReaderFormat format}) {
    if (format == ReaderFormat.longstrip) {
      longStripViewport.scrollBy(-offset);
      return KeyEventResult.handled;
    }

    horizontalViewport.panVertically(session.currentPage.value, offset);
    return KeyEventResult.handled;
  }

  KeyEventResult onTapBottom(double offset, {required ReaderFormat format}) {
    if (format == ReaderFormat.longstrip) {
      if (longStripViewport.isAtChapterEnd(widget.pages.length)) {
        context.pop();
      } else {
        longStripViewport.scrollBy(offset);
      }
      return KeyEventResult.handled;
    }

    horizontalViewport.panVertically(session.currentPage.value, -offset);
    return KeyEventResult.handled;
  }

  @override
  Widget build(BuildContext context) {
    final showUI = useValueListenable(session.chromeVisible);

    useEffect(() {
      if (showUI) {
        SystemChrome.setEnabledSystemUIMode(
          SystemUiMode.manual,
          overlays: SystemUiOverlay.values,
        );
      } else {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      }
      return () => SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual,
        overlays: SystemUiOverlay.values,
      );
    }, [showUI]);

    final tr = context.t;
    final pageCount = widget.pages.length;
    final focusNode = useFocusNode();

    final settings = ref.watch(readerSettingsProvider);
    final theme = Theme.of(context);
    final format = widget.longstrip ? ReaderFormat.longstrip : settings.format;
    final isPortrait = DeviceContext.isPortraitMode(context);
    final longStripScale = useValueNotifier(
      isPortrait ? LongStripScale.full : LongStripScale.small,
    );
    final longStripScaleValue = useValueListenable(longStripScale);
    final longStripDisplayWidth =
        MediaQuery.sizeOf(context).width * longStripScaleValue.scale;
    final longStripCacheWidth =
        (longStripDisplayWidth * MediaQuery.devicePixelRatioOf(context)).ceil();
    final viewport = switch (format) {
      ReaderFormat.single => horizontalViewport,
      ReaderFormat.longstrip => longStripViewport,
    };
    final prefetchPolicy = ReaderPrefetchPolicy.forReader(
      format: format,
      configuredCount: settings.precacheCount,
      pageCount: pageCount,
      longStripCacheWidth: longStripCacheWidth,
    );

    session.bindViewport(viewport);
    useEffect(() {
      session.updatePrefetchPolicy(prefetchPolicy);
      return null;
    }, [prefetchPolicy]);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: SlidingAppBar(
        visible: showUI,
        child: AppBar(
          leading: const BackButton(),
          title: ListTile(
            title: Text(
              widget.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: HookBuilder(
              builder: (_) {
                final value = useValueListenable(session.subtext);
                if (value == null) {
                  return const SizedBox.shrink();
                }

                return Text(value);
              },
            ),
          ),
          actions: [
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () => Scaffold.of(context).openEndDrawer(),
                tooltip: tr.reader.settings,
              ),
            ),
          ],
        ),
      ),
      endDrawer: Drawer(
        width: 320,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10.0,
              children: <Widget>[
                if (widget.onHeaderPressed != null &&
                    widget.drawerHeader != null)
                  TextButton(
                    onPressed: () {
                      // First one pops the drawer
                      context.pop();

                      // Second one pops the reader
                      context.pop();

                      widget.onHeaderPressed!(context);
                    },
                    child: Text(
                      widget.drawerHeader!,
                      style: CommonTextStyles.eighteen,
                    ),
                  ),
                if (widget.drawerHeader != null &&
                    widget.onHeaderPressed == null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      widget.drawerHeader!,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontSize: 18,
                      ),
                    ),
                  ),
                Text(tr.reader.settings, style: CommonTextStyles.twentyBold),
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    for (final f in ReaderFormat.values)
                      ChoiceChip(
                        avatar: Icon(f.icon, color: theme.iconTheme.color),
                        label: Text(tr[f.label]),
                        selected: settings.format == f,
                        onSelected: (widget.longstrip)
                            ? null
                            : (value) {
                                if (value) {
                                  _saveSetting(settings.copyWith(format: f));
                                }
                              },
                      ),
                  ],
                ),
                ListTile(
                  leading: const Icon(Icons.fit_screen),
                  title: Text(tr.reader.togglePageSize),
                  onTap: (format == ReaderFormat.longstrip)
                      ? () {
                          final currentScale = longStripScale.value;
                          final nextScale = toggleLongStripScale(currentScale);
                          longStripScale.value = nextScale;
                          longStripViewport.resize(
                            nextScale.scale / currentScale.scale,
                          );
                        }
                      : () => horizontalViewport.togglePageSize(
                          session.currentPage.value,
                        ),
                ),
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    for (final dir in ReaderDirection.values)
                      ChoiceChip(
                        avatar: Icon(dir.icon, color: theme.iconTheme.color),
                        label: Text(tr[dir.label]),
                        selected: settings.direction == dir,
                        onSelected: (format == ReaderFormat.longstrip)
                            ? null
                            : (value) {
                                if (value) {
                                  _saveSetting(
                                    settings.copyWith(direction: dir),
                                  );
                                }
                              },
                      ),
                  ],
                ),
                SwitchListTile(
                  secondary: const Icon(Icons.donut_small),
                  title: Text(tr.reader.progressBar),
                  value: settings.showProgressBar,
                  onChanged: (value) =>
                      _saveSetting(settings.copyWith(showProgressBar: value)),
                ),
                SwitchListTile(
                  secondary: const Icon(Icons.swipe),
                  title: Text(tr.reader.swipeGestures),
                  value: settings.swipeGestures,
                  onChanged: (format == ReaderFormat.longstrip)
                      ? null
                      : (value) => _saveSetting(
                          settings.copyWith(swipeGestures: value),
                        ),
                ),
                SwitchListTile(
                  secondary: const Icon(Icons.mouse),
                  title: Text(tr.reader.clickToTurn),
                  value: settings.clickToTurn,
                  onChanged: (format == ReaderFormat.longstrip)
                      ? null
                      : (value) =>
                            _saveSetting(settings.copyWith(clickToTurn: value)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 10.0,
                  children: [
                    Text(tr.reader.precacheCount),
                    DropdownMenu<int>(
                      initialSelection: settings.precacheCount,
                      width: 160.0,
                      enableFilter: false,
                      enableSearch: false,
                      requestFocusOnTap: false,
                      inputDecorationTheme: InputDecorationTheme(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 2.0,
                            color: theme.colorScheme.inversePrimary,
                          ),
                        ),
                      ),
                      onSelected: (int? value) {
                        if (value != null) {
                          _saveSetting(settings.copyWith(precacheCount: value));
                        }
                      },
                      dropdownMenuEntries:
                          List<DropdownMenuEntry<int>>.generate(
                            10,
                            (int index) => DropdownMenuEntry<int>(
                              value: index + 1,
                              label: (index + 1 > 9)
                                  ? 'Max (not recommended)'
                                  : (index + 1).toString(),
                            ),
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      endDrawerEnableOpenDragGesture: false,
      body: Focus(
        autofocus: true,
        focusNode: focusNode,
        onKeyEvent: (node, event) {
          // We only care about key down and repeat events.
          if (event is! KeyDownEvent && event is! KeyRepeatEvent) {
            return KeyEventResult.ignored;
          }

          final key = event.physicalKey;

          // Handle horizontal navigation only on the initial key press.
          if (event is KeyDownEvent) {
            switch (key) {
              case PhysicalKeyboardKey.arrowLeft:
                return onTapLeft(settings: settings, format: format);
              case PhysicalKeyboardKey.arrowRight:
                return onTapRight(settings: settings, format: format);
            }
          }

          // Handle vertical navigation on key press and repeat.
          switch (key) {
            case PhysicalKeyboardKey.arrowUp:
              return onTapTop(250, format: format);
            case PhysicalKeyboardKey.arrowDown:
              return onTapBottom(250, format: format);
            case PhysicalKeyboardKey.pageUp:
              return onTapTop(1000, format: format);
            case PhysicalKeyboardKey.pageDown:
              return onTapBottom(1000, format: format);
            default:
              return KeyEventResult.ignored;
          }
        },
        child: switch (widget.pages.isEmpty) {
          true when widget.externalUrl != null => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10.0,
              children: [
                const Text('Read on external site:'),
                ElevatedButton(
                  onPressed: () async {
                    await Styles.tryLaunchUrl(context, widget.externalUrl!);
                  },
                  child: Text(widget.externalUrl!),
                ),
              ],
            ),
          ),
          _ when format == ReaderFormat.longstrip => LongStripReaderView(
            controller: longStripViewport,
            pages: widget.pages,
            displayWidth: longStripDisplayWidth,
            cacheWidth: longStripCacheWidth,
            onCenterTap: session.toggleChrome,
          ),
          _ => HorizontalReaderView(
            controller: horizontalViewport,
            pages: widget.pages,
            settings: settings,
            onTap: (localPosition) {
              focusNode.requestFocus();

              final taploc = localPosition.dx;
              final viewport = MediaQuery.sizeOf(context).width;
              final tapmargin = viewport / 2.5;

              // Tap in the middle 20% (from 40% to 60%).
              if (taploc > tapmargin && taploc < viewport - tapmargin) {
                session.toggleChrome();
                return;
              }

              if (settings.clickToTurn) {
                if (taploc <= tapmargin) {
                  onTapLeft(settings: settings, format: format);
                } else if (taploc >= viewport - tapmargin) {
                  onTapRight(settings: settings, format: format);
                }
              }
            },
            onPageChanged: (page) {
              session.reportVisiblePage(page, source: horizontalViewport);
            },
            onInteraction: () {
              if (!focusNode.hasFocus) {
                focusNode.requestFocus();
              }
            },
          ),
        },
      ),
      // Can't use bottomSheet anymore due to Material 3 specs
      // forcing bottom sheet width to be 640 max
      // https://github.com/flutter/flutter/pull/122445
      extendBody: true,
      bottomNavigationBar: settings.showProgressBar
          ? AnimatedSlide(
              offset: showUI ? Offset.zero : const Offset(0, 1),
              duration: const Duration(milliseconds: 200),
              child: ReaderProgressIndicator(
                reverse:
                    (format != ReaderFormat.longstrip) &&
                    settings.direction == ReaderDirection.rightToLeft,
                currentPage: session.currentPage,
                itemCount: pageCount,
                onPageSelected: session.jumpToPage,
              ),
            )
          : null,
    );
  }
}

class SlidingAppBar extends StatelessWidget implements PreferredSizeWidget {
  final PreferredSizeWidget child;
  final bool visible;

  const SlidingAppBar({super.key, required this.child, required this.visible});

  @override
  Size get preferredSize => child.preferredSize;

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      offset: visible ? Offset.zero : const Offset(0, -1),
      duration: const Duration(milliseconds: 200),
      child: child,
    );
  }
}
