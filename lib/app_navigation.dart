import 'dart:math' as math;

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

enum _NavigationLayout { compact, medium, wide }

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

/// The three contexts share a panel, without sharing their navigation stacks.
///
/// The available parent width selects compact (<=600dp), collapsed rail
/// (>600dp), or standard expanded rail (>=1240dp) presentation. Explicit wide
/// expansion choices survive breakpoint changes without remounting [child].
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
/// padding and indicator overrides apply only to rails. The native bar requires
/// at least two destinations and selects the first when [selectedIndex] is null.
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

  @override
  ConsumerState<AppNavigationScaffold> createState() =>
      _AppNavigationScaffoldState();
}

class _AppNavigationScaffoldState extends ConsumerState<AppNavigationScaffold> {
  static const _collapsedWidth = 96.0;
  static const _expandedWidth = 320.0;
  static const _resizeDuration = Duration(milliseconds: 250);
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  _NavigationLayout? _layout;
  bool? _expandedPreference;
  bool _drawerOpen = false;
  VoidCallback? _afterDismiss;

  void _updateLayout(BuildContext context) {
    final layout = !DeviceContext.useNavigationRail(context)
        ? _NavigationLayout.compact
        : DeviceContext.extendNavigationRail(context)
        ? _NavigationLayout.wide
        : _NavigationLayout.medium;
    if (_layout != layout) {
      _layout = layout;
      _afterDismiss = null;
      // Release the old drawer's history entry without remounting the content.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _dismiss();
      });
    }
  }

  @override
  void didUpdateWidget(AppNavigationScaffold oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.section != widget.section ||
        oldWidget.selectedIndex != widget.selectedIndex) {
      _afterDismiss = null;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _scaffoldKey.currentState?.closeDrawer();
      });
    }
  }

  void _toggle() {
    if (_layout == _NavigationLayout.wide) {
      setState(() => _expandedPreference = !(_expandedPreference ?? true));
    } else {
      setState(() => _drawerOpen = true);
      _scaffoldKey.currentState?.openDrawer();
    }
  }

  void _dismiss() => _scaffoldKey.currentState?.closeDrawer();

  void _perform(VoidCallback action) {
    if (_drawerOpen) {
      _afterDismiss = action;
      _dismiss();
    } else {
      action();
    }
  }

  void _onDrawerChanged(bool open) {
    if (_drawerOpen != open) setState(() => _drawerOpen = open);
    if (open) return;
    final action = _afterDismiss;
    _afterDismiss = null;
    if (action != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) action();
      });
    }
  }

  Future<bool> _onBackButtonPressed() {
    if (!_drawerOpen) return SynchronousFuture(false);
    _dismiss();
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
    final mediaQuery = MediaQuery.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.biggest;
        return MediaQuery(
          // App bars and the rail must use the same actual window constraints.
          data: size == mediaQuery.size
              ? mediaQuery
              : mediaQuery.copyWith(size: size),
          child: Builder(
            builder: (context) {
              _updateLayout(context);
              final compact = _layout == _NavigationLayout.compact;
              final inlineExpanded =
                  _layout == _NavigationLayout.wide &&
                  (_expandedPreference ?? true);

              Widget scaffold = PopScope<Object?>(
                // Advertise modal Back ownership to Android predictive Back.
                canPop: !_drawerOpen,
                onPopInvokedWithResult: (didPop, result) {
                  if (!didPop && _drawerOpen) _dismiss();
                },
                child: Scaffold(
                  key: _scaffoldKey,
                  restorationId: widget.restorationId,
                  drawerEnableOpenDragGesture: compact,
                  onDrawerChanged: _onDrawerChanged,
                  // Keep history/focus ownership mounted across breakpoints.
                  drawer: Drawer(
                    width: math.min(_expandedWidth, size.width - 56),
                    child: Actions(
                      actions: {
                        DismissIntent: CallbackAction<DismissIntent>(
                          onInvoke: (_) {
                            _dismiss();
                            return null;
                          },
                        ),
                      },
                      child: Shortcuts(
                        shortcuts: const {
                          SingleActivator(LogicalKeyboardKey.escape):
                              DismissIntent(),
                        },
                        child: SafeArea(
                          top: false,
                          bottom: false,
                          child: _NavigationPanel(
                            expanded: true,
                            section: widget.section,
                            destinations: widget.destinations,
                            selectedIndex: widget.selectedIndex,
                            updateAvailable: info != null,
                            onToggle: _dismiss,
                            onDestination: (index) => _perform(
                              () => widget.onDestinationSelected?.call(index),
                            ),
                            onContext: _selectContext,
                            onSettings: () => _perform(() {
                              const AppSettingsRoute().push<void>(context);
                            }),
                            onAbout: () => _perform(() {
                              showGagakuAboutDialog(context, ref, info);
                            }),
                          ),
                        ),
                      ),
                    ),
                  ),
                  body: SafeArea(
                    // Horizontal system insets belong outside the rail width,
                    // not inside its icon hit targets (notched phone landscape).
                    top: false,
                    bottom: false,
                    child: Row(
                      children: [
                        AnimatedSize(
                          duration: _resizeDuration,
                          curve: Curves.easeOutCubic,
                          alignment: AlignmentDirectional.centerStart,
                          child: SizedBox(
                            width: compact
                                ? 0
                                : inlineExpanded
                                ? _expandedWidth
                                : _collapsedWidth,
                            child: compact
                                ? null
                                : Material(
                                    color:
                                        NavigationRailTheme.of(context)
                                            .backgroundColor ??
                                        Theme.of(context).colorScheme.surface,
                                    child: _NavigationPanel(
                                      expanded: inlineExpanded,
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
                                          context,
                                        );
                                      }),
                                      onAbout: () => _perform(() {
                                        showGagakuAboutDialog(
                                          context,
                                          ref,
                                          info,
                                        );
                                      }),
                                    ),
                                  ),
                          ),
                        ),
                        SizedBox(
                          width: compact ? 0 : 1,
                          child: compact
                              ? null
                              : const VerticalDivider(thickness: 1, width: 1),
                        ),
                        Expanded(
                          // Isolate the shell route's blocking semantics so
                          // persistent navigation remains accessible.
                          child: Semantics(
                            container: true,
                            explicitChildNodes: true,
                            child: widget.child,
                          ),
                        ),
                      ],
                    ),
                  ),
                  bottomNavigationBar: compact && widget.destinations.isNotEmpty
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
              );
              if (Router.maybeOf(context)?.backButtonDispatcher != null) {
                // A shell Navigator must not consume Back before the modal rail.
                scaffold = BackButtonListener(
                  onBackButtonPressed: _onBackButtonPressed,
                  child: scaffold,
                );
              }
              return scaffold;
            },
          ),
        );
      },
    );
  }
}

/// Explicit leading control for nested root app bars; never opens an inner
/// Scaffold's drawer or replaces a detail screen's Back button.
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
          .findAncestorStateOfType<_AppNavigationScaffoldState>()
          ?._toggle(),
      icon: Badge(isLabelVisible: hasUpdate, child: const Icon(Icons.menu)),
    );
  }
}

// XXX: Replace this with native M3E NavigationRail when it exists
class _NavigationPanel extends StatelessWidget {
  const _NavigationPanel({
    required this.expanded,
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

  final bool expanded;
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

    return SafeArea(
      left: false,
      right: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: expanded ? 16 : 24,
                vertical: 16,
              ),
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
            child: CustomScrollView(
              primary: false,
              slivers: [
                SliverList.list(
                  children: [
                    for (var index = 0; index < destinations.length; index++)
                      _PanelItem(
                        expanded: expanded,
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
                    if (expanded || destinations.isEmpty) ...[
                      if (destinations.isNotEmpty)
                        const Divider(indent: 12, endIndent: 12),
                      if (expanded)
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                            24,
                            12,
                            24,
                            8,
                          ),
                          child: Semantics(
                            header: true,
                            child: Text(
                              t.navigation.read,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ),
                        ),
                      _PanelItem(
                        expanded: expanded,
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
                      _PanelItem(
                        expanded: expanded,
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
                      _PanelItem(
                        expanded: expanded,
                        icon: const Icon(Icons.language),
                        label: Text(t.webSources.text),
                        tooltip: t.webSources.text,
                        selected: section == StartupSection.webSources,
                        onTap: () => onContext(StartupSection.webSources),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          // Utilities and update feedback stay visible even in short landscape
          // windows; only the destinations scroll.
          const Divider(indent: 12, endIndent: 12),
          _PanelItem(
            expanded: expanded,
            icon: const Icon(Icons.settings_outlined),
            label: Text(t.navigation.globalSettings),
            tooltip: t.navigation.globalSettings,
            onTap: onSettings,
          ),
          _PanelItem(
            expanded: expanded,
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

class _PanelItem extends StatelessWidget {
  const _PanelItem({
    required this.expanded,
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

  final bool expanded;
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
    final railTheme = NavigationRailTheme.of(context);
    final foreground = onTap == null
        ? theme.disabledColor
        : selected
        ? theme.colorScheme.onSecondaryContainer
        : theme.colorScheme.onSurfaceVariant;
    final iconTheme = selected
        ? railTheme.selectedIconTheme
        : railTheme.unselectedIconTheme;
    final labelStyle = selected
        ? railTheme.selectedLabelTextStyle
        : railTheme.unselectedLabelTextStyle;
    final shape =
        indicatorShape ?? railTheme.indicatorShape ?? const StadiumBorder();

    return MergeSemantics(
      child: Semantics(
        selected: selected,
        button: true,
        enabled: onTap != null,
        label: tooltip,
        onTap: onTap,
        child: Tooltip(
          message: tooltip ?? _labelText(label) ?? '',
          excludeFromSemantics: true,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              excludeFromSemantics: true,
              customBorder: shape,
              // Keep the whole row tappable, including indicator gutters.
              child: Padding(
                padding:
                    padding ??
                    EdgeInsets.symmetric(
                      horizontal: expanded ? 12 : 8,
                      vertical: 4,
                    ),
                child: Ink(
                  decoration: ShapeDecoration(
                    color: selected
                        ? indicatorColor ??
                              railTheme.indicatorColor ??
                              theme.colorScheme.secondaryContainer
                        : Colors.transparent,
                    shape: shape,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: expanded ? 56 : 48),
                    child: IconTheme.merge(
                      data: IconThemeData(
                        color: foreground,
                        size: 24,
                      ).merge(iconTheme),
                      child: DefaultTextStyle(
                        style:
                            labelStyle ??
                            theme.textTheme.labelLarge!.copyWith(
                              color: foreground,
                            ),
                        child: expanded
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                child: Row(
                                  children: [
                                    icon,
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: ExcludeSemantics(
                                        excluding: tooltip != null,
                                        child: label,
                                      ),
                                    ),
                                    if (badge) ...[
                                      const SizedBox(width: 12),
                                      const Badge(),
                                    ],
                                  ],
                                ),
                              )
                            : Stack(
                                alignment: Alignment.center,
                                children: [
                                  Badge(isLabelVisible: badge, child: icon),
                                  SizedBox.shrink(
                                    child: ExcludeSemantics(
                                      excluding: tooltip != null,
                                      child: Visibility.maintain(
                                        visible: false,
                                        child: label,
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
          ),
        ),
      ),
    );
  }
}
