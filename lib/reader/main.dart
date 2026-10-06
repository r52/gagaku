import 'package:gagaku/util/riverpod.dart';

import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/reader/model/config.dart';
import 'package:gagaku/reader/model/session.dart';
import 'package:gagaku/reader/model/types.dart';
import 'package:gagaku/reader/model/viewport_controller.dart';
import 'package:gagaku/reader/widgets/long_strip_page_image.dart';
import 'package:gagaku/reader/widgets/reader_progress_indicator.dart';
import 'package:gagaku/reader/widgets/reader_viewports.dart';
import 'package:gagaku/util/ui.dart';
import 'package:gagaku/util/util.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

typedef CtxCallback = void Function(BuildContext);

class ReaderWidget extends StatelessWidget {
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
  Widget build(BuildContext context) {
    // A new page list is a new chapter: start a fresh session and viewport
    // state instead of carrying positions and zoom across content.
    return _ReaderView(key: ObjectKey(pages), reader: this);
  }
}

class _ReaderView extends StatefulHookConsumerWidget {
  const _ReaderView({super.key, required this.reader});

  final ReaderWidget reader;

  @override
  ConsumerState<_ReaderView> createState() => _ReaderViewState();
}

class _ReaderViewState extends ConsumerState<_ReaderView> {
  late final ReaderSession session;
  late final HorizontalReaderViewportController horizontalViewport;
  late final LongStripReaderViewportController longStripViewport;

  ReaderWidget get reader => widget.reader;

  @override
  void initState() {
    super.initState();
    horizontalViewport = HorizontalReaderViewportController();
    session = ReaderSession(
      pages: reader.pages,
      precacheImage: (provider) =>
          precacheReaderImage(provider, createLocalImageConfiguration(context)),
    );
    longStripViewport = LongStripReaderViewportController(
      onVisiblePageChanged: (page) {
        session.reportVisiblePage(page, source: longStripViewport);
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    longStripViewport.applyDefaultScale(
      portrait: DeviceContext.isPortraitMode(context),
    );
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

  KeyEventResult _handleTurn(ReaderPageTurnResult result) {
    if (result == ReaderPageTurnResult.closeReader) {
      context.pop();
    }
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
    final pages = reader.pages;
    final pageCount = pages.length;
    final focusNode = useFocusNode();

    final settings = ref.watch(readerSettingsProvider);
    final theme = Theme.of(context);
    final format = reader.longstrip ? ReaderFormat.longstrip : settings.format;
    final longStripScale = useValueListenable(longStripViewport.scale);
    final longStripDisplayWidth =
        MediaQuery.sizeOf(context).width * longStripScale.scale;
    final cacheWidth = longStripCacheWidth(
      longStripDisplayWidth * MediaQuery.devicePixelRatioOf(context),
    );
    final viewport = switch (format) {
      ReaderFormat.single => horizontalViewport,
      ReaderFormat.longstrip => longStripViewport,
    };
    final prefetchPolicy = ReaderPrefetchPolicy.forReader(
      format: format,
      configuredCount: settings.precacheCount,
      pageCount: pageCount,
      longStripCacheWidth: cacheWidth,
    );

    // Runs during this build, before the viewport's widget builds, so the
    // viewport can prepare its initial page.
    useEffect(() {
      session.bindViewport(viewport);
      return null;
    }, [viewport]);
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
              reader.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: HookBuilder(
              builder: (_) {
                final page = useValueListenable(session.currentPage);
                final value =
                    reader.subtitle ??
                    (page < pages.length ? pages[page].sortKey : null);
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
                if (reader.onHeaderPressed != null &&
                    reader.drawerHeader != null)
                  TextButton(
                    onPressed: () {
                      // First one pops the drawer
                      context.pop();

                      // Second one pops the reader
                      context.pop();

                      reader.onHeaderPressed!(context);
                    },
                    child: Text(
                      reader.drawerHeader!,
                      style: CommonTextStyles.eighteen,
                    ),
                  ),
                if (reader.drawerHeader != null &&
                    reader.onHeaderPressed == null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      reader.drawerHeader!,
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
                        onSelected: (reader.longstrip)
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
                  onTap: session.togglePageSize,
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
                return _handleTurn(session.turnLeft(settings.direction));
              case PhysicalKeyboardKey.arrowRight:
                return _handleTurn(session.turnRight(settings.direction));
            }
          }

          // Handle vertical navigation on key press and repeat.
          switch (key) {
            case PhysicalKeyboardKey.arrowUp:
              return _handleTurn(session.scrollBy(-250));
            case PhysicalKeyboardKey.arrowDown:
              return _handleTurn(session.scrollBy(250));
            case PhysicalKeyboardKey.pageUp:
              return _handleTurn(session.scrollBy(-1000));
            case PhysicalKeyboardKey.pageDown:
              return _handleTurn(session.scrollBy(1000));
            default:
              return KeyEventResult.ignored;
          }
        },
        child: switch (pages.isEmpty) {
          true when reader.externalUrl != null => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10.0,
              children: [
                const Text('Read on external site:'),
                ElevatedButton(
                  onPressed: () async {
                    await Styles.tryLaunchUrl(context, reader.externalUrl!);
                  },
                  child: Text(reader.externalUrl!),
                ),
              ],
            ),
          ),
          _ when format == ReaderFormat.longstrip => LongStripReaderView(
            controller: longStripViewport,
            pages: pages,
            displayWidth: longStripDisplayWidth,
            cacheWidth: cacheWidth,
            onCenterTap: session.toggleChrome,
          ),
          _ => HorizontalReaderView(
            controller: horizontalViewport,
            pages: pages,
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
                  _handleTurn(session.turnLeft(settings.direction));
                } else if (taploc >= viewport - tapmargin) {
                  _handleTurn(session.turnRight(settings.direction));
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
