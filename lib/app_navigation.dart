import 'dart:math' as math;
import 'dart:ui' show lerpDouble;

import 'package:material_ui/material_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:gagaku/about.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/model/config.dart';
import 'package:gagaku/model/startup_section.dart';
import 'package:gagaku/routes.dart';
import 'package:gagaku/update_checker.dart';
import 'package:gagaku/util/util.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_navigation.g.dart';

const _collapsedWidth = 96.0;
const _expandedWidth = 320.0;
// Minimum content strip left visible beside a compact modal rail.
const _modalEdgeGap = 56.0;
const _edgeDragWidth = 20.0;
// Indicator insets that keep icon centres at x=48 in both rail states.
const _indicatorInset = 20.0;
const _iconSize = 24.0;
const _iconStart = _collapsedWidth / 2 - _iconSize / 2;
const _expandedLabelStart = _iconStart + _iconSize + 12;
const _expandedLabelEnd = _indicatorInset + 16;
const _collapsedItemHeight = 60.0;
const _collapsedIndicatorTop = 4.0;
const _collapsedIndicatorHeight = 32.0;
const _collapsedLabelTop =
    _collapsedIndicatorTop + _collapsedIndicatorHeight + 4;
const _expandedItemHeight = 56.0;
const _motionDuration = Duration(milliseconds: 250);
const _motionCurve = Curves.easeInOutCubicEmphasized;
const _minFlingVelocity = 365.0;

enum _NavigationLayout {
  compact,
  medium,
  wide;

  static _NavigationLayout fromWidth(double width) =>
      !DeviceContext.useNavigationRailAt(width)
      ? compact
      : DeviceContext.extendNavigationRailAt(width)
      ? wide
      : medium;
}

/// Inline rail expansion on wide layouts, shared by all app contexts.
@Riverpod(keepAlive: true)
class NavigationRailExpanded extends _$NavigationRailExpanded {
  @override
  bool build() => true;

  void toggle() => state = !state;
}

UpdateInfo? _availableUpdate(WidgetRef ref) {
  final enabled = ref.watch(
    gagakuSettingsProvider.select((settings) => settings.checkForUpdates),
  );
  final result = ref.watch(updateCheckerProvider);
  return switch (result) {
    AsyncData(value: UpdateResultAvailable(:final info)) when enabled => info,
    _ => null,
  };
}

class _AppNavigationScope extends InheritedWidget {
  const _AppNavigationScope({
    required this.layout,
    required this.toggle,
    required super.child,
  });

  final _NavigationLayout layout;
  final VoidCallback toggle;

  @override
  bool updateShouldNotify(_AppNavigationScope oldWidget) =>
      layout != oldWidget.layout || toggle != oldWidget.toggle;
}

/// The three contexts share a panel, without sharing their navigation stacks.
///
/// The available parent width selects compact (<=600dp), collapsed rail
/// (>600dp), or standard expanded rail (>=1240dp) presentation. The wide
/// expansion choice is shared across contexts and survives breakpoint changes
/// without remounting [child].
///
/// One rail widget renders every state from a single expansion value: inline
/// on wide layouts, as a modal overlay that grows out of the collapsed rail on
/// medium layouts, and as a modal sheet sliding in from the start edge on
/// compact layouts.
///
/// Collapsed section rails reveal app contexts only when expanded; contexts
/// remain primary navigation when [destinations] is empty. Settings, About,
/// and update feedback stay pinned while destinations scroll.
///
/// Rails preserve destination widget labels, disabled state, padding, and
/// indicator overrides. A null [selectedIndex] leaves rail destinations
/// unselected.
///
/// Compact mode uses the native [NavigationBar] with best-effort adaptation:
/// icons and disabled state are forwarded, while [Text] and [RichText] labels
/// become plain text. Other label widgets have no compact label. Per-destination
/// padding and indicator overrides apply only to rails. The native bar is shown
/// only for two or more destinations and selects the first when [selectedIndex]
/// is null.
class AppNavigationScaffold extends ConsumerStatefulWidget {
  const AppNavigationScaffold({
    super.key,
    required this.section,
    required this.child,
    this.destinations = const [],
    this.selectedIndex,
    this.onDestinationSelected,
    this.restorationId,
  });

  final StartupSection section;
  final Widget child;
  final List<NavigationRailDestination> destinations;
  final int? selectedIndex;
  final ValueChanged<int>? onDestinationSelected;
  final String? restorationId;

  /// Whether root app bars below [context] need an [AppNavigationButton]
  /// because the nearest [AppNavigationScaffold] shows no rail.
  static bool usesMenuButton(BuildContext context) =>
      context
          .dependOnInheritedWidgetOfExactType<_AppNavigationScope>()
          ?.layout ==
      _NavigationLayout.compact;

  @override
  ConsumerState<AppNavigationScaffold> createState() =>
      _AppNavigationScaffoldState();
}

class _AppNavigationScaffoldState extends ConsumerState<AppNavigationScaffold>
    with TickerProviderStateMixin {
  late final AnimationController _rail;
  late final AnimationController _modal;
  late final Listenable _motion;
  final _panelFocus = FocusScopeNode(debugLabel: 'AppNavigation panel');

  // Layout of the latest build, for event handlers.
  _NavigationLayout? _layout;
  // A modal opened in another layout is stale and treated as closed.
  _NavigationLayout? _modalLayout;
  bool _modalOpen = false;
  double _modalExtent = _expandedWidth;

  bool get _modalActive => _modalOpen && _modalLayout == _layout;

  @override
  void initState() {
    super.initState();
    _rail = AnimationController(
      vsync: this,
      duration: _motionDuration,
      value: ref.read(navigationRailExpandedProvider) ? 1 : 0,
    );
    _modal = AnimationController(vsync: this, duration: _motionDuration);
    _motion = Listenable.merge([_rail, _modal]);
    ref.listenManual(navigationRailExpandedProvider, (_, expanded) {
      _rail.animateTo(expanded ? 1 : 0, curve: _motionCurve);
    });
  }

  @override
  void didUpdateWidget(AppNavigationScaffold oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_modalActive &&
        (oldWidget.section != widget.section ||
            oldWidget.selectedIndex != widget.selectedIndex)) {
      // build() follows, so no setState.
      _modalOpen = false;
      _modal.animateBack(0, curve: _motionCurve);
    }
  }

  @override
  void dispose() {
    _rail.dispose();
    _modal.dispose();
    _panelFocus.dispose();
    super.dispose();
  }

  void _toggle() {
    if (_layout == _NavigationLayout.wide) {
      ref.read(navigationRailExpandedProvider.notifier).toggle();
    } else if (_modalActive) {
      _closeModal();
    } else {
      _beginModal();
      _modal.animateTo(1, curve: _motionCurve);
      _panelFocus.requestFocus();
    }
  }

  void _beginModal() {
    if (_modalLayout != _layout) _modal.value = 0;
    setState(() {
      _modalOpen = true;
      _modalLayout = _layout;
    });
  }

  void _closeModal() {
    if (!_modalActive) return;
    setState(() => _modalOpen = false);
    _modal.animateBack(0, curve: _motionCurve);
  }

  void _perform(VoidCallback action) {
    _closeModal();
    action();
  }

  double _dragSign() =>
      Directionality.of(context) == TextDirection.rtl ? -1 : 1;

  void _onDragStart(DragStartDetails details) {
    if (!_modalActive) _beginModal();
    _modal.stop();
  }

  void _onDragUpdate(DragUpdateDetails details) {
    _modal.value += details.primaryDelta! / _modalExtent * _dragSign();
  }

  void _onDragEnd(DragEndDetails details) {
    final velocity = details.primaryVelocity! * _dragSign();
    final open = velocity.abs() >= _minFlingVelocity
        ? velocity > 0
        : _modal.value >= 0.5;
    if (open) {
      _modal.animateTo(1, curve: _motionCurve);
      _panelFocus.requestFocus();
    } else {
      _closeModal();
    }
  }

  Future<bool> _onBackButtonPressed() {
    if (!_modalActive) return SynchronousFuture(false);
    _closeModal();
    return SynchronousFuture(true);
  }

  void _selectContext(StartupSection section) {
    _perform(() {
      if (section == widget.section) return;
      switch (section) {
        case StartupSection.mangaDex:
          const MangaDexFrontRoute().go(context);
        case StartupSection.localLibrary:
          const LocalLibraryHomeRoute().go(context);
        case StartupSection.webSources:
          const WebSourceFrontRoute().go(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final info = _availableUpdate(ref);
    final railExpanded = ref.watch(navigationRailExpandedProvider);
    final theme = Theme.of(context);
    final railBackground =
        NavigationRailTheme.of(context).backgroundColor ??
        theme.colorScheme.surface;
    final dividerColor =
        DividerTheme.of(context).color ?? theme.colorScheme.outlineVariant;
    final barrierLabel = MaterialLocalizations.of(context)
        .modalBarrierDismissLabel;

    return LayoutBuilder(
      builder: (context, constraints) {
        final layout = _NavigationLayout.fromWidth(constraints.maxWidth);
        _layout = layout;
        final compact = layout == _NavigationLayout.compact;
        final modalActive = _modalActive;
        final expandedWidth = _modalExtent = compact
            ? math.max(
                0.0,
                math.min(_expandedWidth, constraints.maxWidth - _modalEdgeGap),
              )
            : _expandedWidth;

        // Visual geometry for the current animation frame.
        ({
          double reserved,
          double panelWidth,
          double hidden,
          double expansion,
          double modal,
        })
        geometry() {
          final modal = _modalLayout == layout ? _modal.value : 0.0;
          final rail = lerpDouble(
            _collapsedWidth,
            _expandedWidth,
            _rail.value,
          )!;
          return switch (layout) {
            _NavigationLayout.wide => (
              reserved: rail,
              panelWidth: rail,
              hidden: 0.0,
              expansion: _rail.value,
              modal: 0.0,
            ),
            _NavigationLayout.medium => (
              reserved: _collapsedWidth,
              panelWidth: lerpDouble(_collapsedWidth, _expandedWidth, modal)!,
              hidden: 0.0,
              expansion: modal,
              modal: modal,
            ),
            _NavigationLayout.compact => (
              reserved: 0.0,
              panelWidth: expandedWidth,
              hidden: 1 - modal,
              expansion: 1.0,
              modal: modal,
            ),
          };
        }

        final drag = compact
            ? (start: _onDragStart, update: _onDragUpdate, end: _onDragEnd)
            : null;

        // The scrim and rail sit above the whole Scaffold so a modal rail
        // also covers and blocks the compact NavigationBar.
        Widget scaffold = PopScope<Object?>(
          // Advertise modal Back ownership to Android predictive Back.
          canPop: !modalActive,
          onPopInvokedWithResult: (didPop, result) {
            if (!didPop) _closeModal();
          },
          child: Stack(
            children: [
              Positioned.fill(
                child: Scaffold(
                  restorationId: widget.restorationId,
                  body: SafeArea(
                    // Horizontal system insets belong outside the rail width,
                    // not inside its icon hit targets (notched phone landscape).
                    top: false,
                    bottom: false,
                    child: AnimatedBuilder(
                      animation: _motion,
                      child: ExcludeFocus(
                        excluding: modalActive,
                        // Isolate the shell route's blocking semantics so
                        // persistent navigation remains accessible.
                        child: Semantics(
                          container: true,
                          explicitChildNodes: true,
                          child: widget.child,
                        ),
                      ),
                      builder: (context, content) => Padding(
                        padding: EdgeInsetsDirectional.only(
                          start: geometry().reserved,
                        ),
                        child: content,
                      ),
                    ),
                  ),
                  bottomNavigationBar:
                      compact && widget.destinations.length >= 2
                      ? NavigationBar(
                          height: 60,
                          labelBehavior: NavigationDestinationLabelBehavior
                              .onlyShowSelected,
                          selectedIndex: widget.selectedIndex ?? 0,
                          onDestinationSelected: widget.onDestinationSelected,
                          destinations: [
                            for (final destination in widget.destinations)
                              NavigationDestination(
                                icon: destination.icon,
                                selectedIcon: destination.selectedIcon,
                                label: _labelText(destination.label) ?? '',
                                enabled: !destination.disabled,
                              ),
                          ],
                        )
                      : null,
                ),
              ),
              Positioned.fill(
                child: AnimatedBuilder(
                  animation: _motion,
                  builder: (context, _) {
                    final scrim = geometry().modal;
                    return scrim > 0
                        ? BlockSemantics(
                            blocking: modalActive,
                            child: GestureDetector(
                              onHorizontalDragStart: drag?.start,
                              onHorizontalDragUpdate: drag?.update,
                              onHorizontalDragEnd: drag?.end,
                              child: ModalBarrier(
                                color: theme.colorScheme.scrim.withValues(
                                  alpha: 0.32 * scrim,
                                ),
                                onDismiss: _closeModal,
                                semanticsLabel: barrierLabel,
                              ),
                            ),
                          )
                        : const SizedBox.shrink();
                  },
                ),
              ),
              Positioned.fill(
                child: SafeArea(
                  top: false,
                  bottom: false,
                  child: AnimatedBuilder(
                    animation: _motion,
                    builder: (context, _) {
                      final g = geometry();
                      return Stack(
                        children: [
                          PositionedDirectional(
                            start: 0,
                            top: 0,
                            bottom: 0,
                            width: _edgeDragWidth,
                            child: compact && !modalActive
                                ? GestureDetector(
                                    behavior: HitTestBehavior.translucent,
                                    excludeFromSemantics: true,
                                    onHorizontalDragStart: _onDragStart,
                                    onHorizontalDragUpdate: _onDragUpdate,
                                    onHorizontalDragEnd: _onDragEnd,
                                  )
                                : const SizedBox.shrink(),
                          ),
                          PositionedDirectional(
                            start: -g.hidden * g.panelWidth,
                            top: 0,
                            bottom: 0,
                            width: g.panelWidth,
                            child: Offstage(
                              offstage: compact && g.modal == 0,
                              child: GestureDetector(
                                onHorizontalDragStart: drag?.start,
                                onHorizontalDragUpdate: drag?.update,
                                onHorizontalDragEnd: drag?.end,
                                child: Material(
                                  color: railBackground,
                                  shape: compact
                                      ? null
                                      : BorderDirectional(
                                          end: BorderSide(color: dividerColor),
                                        ),
                                  child: Actions(
                                    actions: {
                                      DismissIntent:
                                          CallbackAction<DismissIntent>(
                                            onInvoke: (_) {
                                              _closeModal();
                                              return null;
                                            },
                                          ),
                                    },
                                    child: Shortcuts(
                                      shortcuts: modalActive
                                          ? const {
                                              SingleActivator(
                                                LogicalKeyboardKey.escape,
                                              ): DismissIntent(),
                                            }
                                          : const {},
                                      child: FocusScope(
                                        node: _panelFocus,
                                        child: _NavigationPanel(
                                          expansion: g.expansion,
                                          expanded:
                                              layout == _NavigationLayout.wide
                                              ? railExpanded
                                              : modalActive,
                                          expandedWidth: expandedWidth,
                                          section: widget.section,
                                          destinations: widget.destinations,
                                          selectedIndex: widget.selectedIndex,
                                          updateAvailable: info != null,
                                          onToggle: _toggle,
                                          onDestination: (index) => _perform(
                                            () => widget.onDestinationSelected
                                                ?.call(index),
                                          ),
                                          onContext: _selectContext,
                                          onSettings: () => _perform(() {
                                            const AppSettingsRoute().push<void>(
                                              this.context,
                                            );
                                          }),
                                          onAbout: () => _perform(() {
                                            showGagakuAboutDialog(
                                              this.context,
                                              ref,
                                              info,
                                            );
                                          }),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
        if (Router.maybeOf(context)?.backButtonDispatcher != null) {
          // A shell Navigator must not consume Back before the modal rail.
          scaffold = BackButtonListener(
            onBackButtonPressed: _onBackButtonPressed,
            child: scaffold,
          );
        }
        return _AppNavigationScope(
          layout: layout,
          toggle: _toggle,
          child: scaffold,
        );
      },
    );
  }
}

/// Explicit leading control for nested root app bars; never opens an inner
/// Scaffold's drawer or replaces a detail screen's Back button.
///
/// Show it only where [AppNavigationScaffold.usesMenuButton] is true.
class AppNavigationButton extends ConsumerWidget {
  const AppNavigationButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasUpdate = _availableUpdate(ref) != null;
    return IconButton(
      tooltip: hasUpdate
          ? context.t.navigation.menuUpdateAvailable
          : context.t.navigation.openMenu,
      onPressed: () => context
          .getInheritedWidgetOfExactType<_AppNavigationScope>()
          ?.toggle(),
      icon: Badge(isLabelVisible: hasUpdate, child: const Icon(Icons.menu)),
    );
  }
}

// XXX: Replace this with native M3E NavigationRail when it exists
class _NavigationPanel extends StatelessWidget {
  const _NavigationPanel({
    required this.expansion,
    required this.expanded,
    required this.expandedWidth,
    required this.section,
    required this.destinations,
    required this.selectedIndex,
    required this.updateAvailable,
    required this.onToggle,
    required this.onDestination,
    required this.onContext,
    required this.onSettings,
    required this.onAbout,
  });

  /// Visual progress from collapsed (0) to expanded (1).
  final double expansion;

  /// Logical state the toggle control reports.
  final bool expanded;

  /// Panel width at full expansion, used to lay out labels once.
  final double expandedWidth;
  final StartupSection section;
  final List<NavigationRailDestination> destinations;
  final int? selectedIndex;
  final bool updateAvailable;
  final VoidCallback onToggle;
  final ValueChanged<int> onDestination;
  final ValueChanged<StartupSection> onContext;
  final VoidCallback onSettings;
  final VoidCallback onAbout;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final aboutLabel = MaterialLocalizations.of(context)
        .aboutListTileTitle('Gagaku');
    final header = Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(_iconStart, 12, 24, 8),
      child: Semantics(
        header: true,
        child: Text(
          t.navigation.read,
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
    );
    final contexts = [
      _RailItem(
        expansion: expansion,
        expandedWidth: expandedWidth,
        icon: Icon(
          section == StartupSection.mangaDex
              ? Icons.menu_book
              : Icons.menu_book_outlined,
        ),
        label: Text(t.navigation.mangaDex),
        tooltip: t.navigation.mangaDex,
        selected: section == StartupSection.mangaDex,
        onTap: () => onContext(StartupSection.mangaDex),
      ),
      _RailItem(
        expansion: expansion,
        expandedWidth: expandedWidth,
        icon: Icon(
          section == StartupSection.localLibrary
              ? Icons.photo_album
              : Icons.photo_album_outlined,
        ),
        label: Text(t.localLibrary.text),
        tooltip: t.localLibrary.text,
        selected: section == StartupSection.localLibrary,
        onTap: () => onContext(StartupSection.localLibrary),
      ),
      _RailItem(
        expansion: expansion,
        expandedWidth: expandedWidth,
        icon: const Icon(Icons.language),
        label: Text(t.webSources.text),
        tooltip: t.webSources.text,
        selected: section == StartupSection.webSources,
        onTap: () => onContext(StartupSection.webSources),
      ),
    ];

    return SafeArea(
      left: false,
      right: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.only(
              start: _collapsedWidth / 2 - 24,
              top: 16,
              bottom: 16,
            ),
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: IconButton(
                style: const ButtonStyle(
                  minimumSize: WidgetStatePropertyAll(Size.square(48)),
                ),
                tooltip: expanded ? t.navigation.collapse : t.navigation.expand,
                onPressed: onToggle,
                icon: Icon(expanded ? Icons.menu_open : Icons.menu),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              primary: false,
              padding: EdgeInsets.zero,
              children: [
                for (var index = 0; index < destinations.length; index++)
                  _RailItem(
                    expansion: expansion,
                    expandedWidth: expandedWidth,
                    icon: selectedIndex == index
                        ? destinations[index].selectedIcon
                        : destinations[index].icon,
                    label: destinations[index].label,
                    selected: selectedIndex == index,
                    padding: destinations[index].padding,
                    indicatorColor: destinations[index].indicatorColor,
                    indicatorShape: destinations[index].indicatorShape,
                    onTap: destinations[index].disabled
                        ? null
                        : () => onDestination(index),
                  ),
                if (destinations.isEmpty) ...[
                  if (expansion > 0) _Reveal(factor: expansion, child: header),
                  ...contexts,
                ] else if (expansion > 0)
                  _Reveal(
                    factor: expansion,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Divider(
                          indent: _indicatorInset,
                          endIndent: _indicatorInset,
                        ),
                        header,
                        ...contexts,
                      ],
                    ),
                  ),
              ],
            ),
          ),
          // Utilities and update feedback stay visible even in short landscape
          // windows; only the destinations scroll.
          const Divider(indent: _indicatorInset, endIndent: _indicatorInset),
          _RailItem(
            expansion: expansion,
            expandedWidth: expandedWidth,
            icon: const Icon(Icons.settings_outlined),
            label: Text(t.navigation.globalSettings),
            tooltip: t.navigation.globalSettings,
            onTap: onSettings,
          ),
          _RailItem(
            expansion: expansion,
            expandedWidth: expandedWidth,
            icon: const Icon(Icons.info_outline),
            label: Text(aboutLabel),
            tooltip: updateAvailable
                ? '$aboutLabel: ${t.updates.updateAvailableTitle}'
                : aboutLabel,
            badge: updateAvailable,
            onTap: onAbout,
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

String? _labelText(Widget label) => switch (label) {
  Text(:final data, :final textSpan) => data ?? textSpan?.toPlainText(),
  RichText(:final text) => text.toPlainText(),
  _ => null,
};

/// Grows [child] in from the top as [factor] goes from 0 to 1.
class _Reveal extends StatelessWidget {
  const _Reveal({required this.factor, required this.child});

  final double factor;
  final Widget child;

  @override
  Widget build(BuildContext context) => ClipRect(
    child: Align(
      alignment: AlignmentDirectional.topStart,
      heightFactor: factor,
      child: Opacity(opacity: factor, child: child),
    ),
  );
}

/// Draws hover, focus, and splash feedback inside the active indicator while
/// keeping the whole row tappable.
class _IndicatorInkWell extends InkResponse {
  const _IndicatorInkWell({
    required this.indicatorRect,
    super.onTap,
    super.customBorder,
    super.child,
  }) : super(
         containedInkWell: true,
         highlightShape: BoxShape.rectangle,
         excludeFromSemantics: true,
       );

  final Rect Function(Size size) indicatorRect;

  @override
  RectCallback? getRectCallback(RenderBox referenceBox) =>
      () => indicatorRect(referenceBox.size);
}

/// A rail destination laid out for any [expansion] between the collapsed
/// (label below icon) and expanded (label beside icon) states. Icons keep the
/// same position in both, and labels cross-fade between their two placements.
class _RailItem extends StatelessWidget {
  const _RailItem({
    required this.expansion,
    required this.expandedWidth,
    required this.icon,
    required this.label,
    required this.onTap,
    this.tooltip,
    this.selected = false,
    this.badge = false,
    this.padding,
    this.indicatorColor,
    this.indicatorShape,
  });

  final double expansion;
  final double expandedWidth;
  final Widget icon;
  final Widget label;
  final String? tooltip;
  final VoidCallback? onTap;
  final bool selected;
  final bool badge;
  final EdgeInsetsGeometry? padding;
  final Color? indicatorColor;
  final ShapeBorder? indicatorShape;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final railTheme = NavigationRailTheme.of(context);
    final enabled = onTap != null;
    final disabledColor = colors.onSurface.withValues(alpha: 0.38);
    final insets =
        padding?.resolve(Directionality.of(context)) ?? EdgeInsets.zero;
    final t = expansion;

    // Theme overrides apply per selection state; disabled always wins.
    final iconTheme =
        IconThemeData(
              size: _iconSize,
              color: selected
                  ? colors.onSecondaryContainer
                  : colors.onSurfaceVariant,
            )
            .merge(
              selected
                  ? railTheme.selectedIconTheme
                  : railTheme.unselectedIconTheme,
            )
            .merge(enabled ? null : IconThemeData(color: disabledColor));
    final themedLabel = selected
        ? railTheme.selectedLabelTextStyle
        : railTheme.unselectedLabelTextStyle;
    TextStyle labelStyle(TextStyle? base, Color color) {
      final style = (base ?? const TextStyle())
          .copyWith(color: color)
          .merge(themedLabel);
      return enabled ? style : style.copyWith(color: disabledColor);
    }

    final shape =
        indicatorShape ?? railTheme.indicatorShape ?? const StadiumBorder();
    final itemHeight = lerpDouble(
      _collapsedItemHeight,
      _expandedItemHeight,
      t,
    )!;
    final indicatorTop = lerpDouble(_collapsedIndicatorTop, 0, t)!;
    final indicatorHeight = lerpDouble(
      _collapsedIndicatorHeight,
      _expandedItemHeight,
      t,
    )!;
    final excludeLabel = tooltip != null;

    return MergeSemantics(
      child: Semantics(
        selected: selected,
        button: true,
        enabled: enabled,
        label: tooltip,
        onTap: onTap,
        child: Tooltip(
          message: tooltip ?? _labelText(label) ?? '',
          excludeFromSemantics: true,
          child: Material(
            type: MaterialType.transparency,
            child: _IndicatorInkWell(
              onTap: onTap,
              customBorder: shape,
              indicatorRect: (size) {
                final box = insets.deflateRect(Offset.zero & size);
                final left = box.left + _indicatorInset;
                final top = box.top + indicatorTop;
                return Rect.fromLTRB(
                  left,
                  top,
                  math.max(left, box.right - _indicatorInset),
                  top + indicatorHeight,
                );
              },
              child: Padding(
                padding: insets,
                child: SizedBox(
                  height: itemHeight,
                  child: Stack(
                    clipBehavior: Clip.hardEdge,
                    children: [
                      PositionedDirectional(
                        start: _indicatorInset,
                        end: _indicatorInset,
                        top: indicatorTop,
                        height: indicatorHeight,
                        child: Ink(
                          decoration: ShapeDecoration(
                            color: selected
                                ? indicatorColor ??
                                      railTheme.indicatorColor ??
                                      colors.secondaryContainer
                                : Colors.transparent,
                            shape: shape,
                          ),
                        ),
                      ),
                      PositionedDirectional(
                        start: _iconStart,
                        top: indicatorTop + (indicatorHeight - _iconSize) / 2,
                        width: _iconSize,
                        height: _iconSize,
                        child: IconTheme.merge(
                          data: iconTheme,
                          child: Center(
                            child: Badge(isLabelVisible: badge, child: icon),
                          ),
                        ),
                      ),
                      if (t < 1)
                        PositionedDirectional(
                          start: 0,
                          width: math.max(
                            0.0,
                            _collapsedWidth - insets.horizontal,
                          ),
                          top: _collapsedLabelTop,
                          height: _collapsedItemHeight - _collapsedLabelTop,
                          child: Opacity(
                            opacity: (1 - 2 * t).clamp(0.0, 1.0),
                            alwaysIncludeSemantics: true,
                            child: ExcludeSemantics(
                              excluding: excludeLabel || t >= 0.5,
                              child: DefaultTextStyle(
                                style: labelStyle(
                                  theme.textTheme.labelMedium,
                                  selected
                                      ? colors.secondary
                                      : colors.onSurfaceVariant,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                child: Center(child: label),
                              ),
                            ),
                          ),
                        ),
                      if (t > 0)
                        PositionedDirectional(
                          start: _expandedLabelStart,
                          // Fixed at the final width so labels lay out once
                          // and are clipped, not re-wrapped, while morphing.
                          width: math.max(
                            0.0,
                            expandedWidth -
                                insets.horizontal -
                                _expandedLabelStart -
                                _expandedLabelEnd,
                          ),
                          top: 0,
                          bottom: 0,
                          child: Opacity(
                            opacity: (2 * t - 1).clamp(0.0, 1.0),
                            alwaysIncludeSemantics: true,
                            child: ExcludeSemantics(
                              excluding: excludeLabel || t < 0.5,
                              child: DefaultTextStyle(
                                style: labelStyle(
                                  theme.textTheme.labelLarge,
                                  selected
                                      ? colors.onSecondaryContainer
                                      : colors.onSurfaceVariant,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                child: Align(
                                  alignment: AlignmentDirectional.centerStart,
                                  child: label,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
