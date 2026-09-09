import 'dart:math' as math;

import 'package:flutter/material.dart';
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
  static const _collapsedWidth = 80.0;
  static const _expandedWidth = 320.0;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  _NavigationLayout? _layout;
  bool _expanded = true;
  VoidCallback? _afterDismiss;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final layout = !DeviceContext.useNavigationRail(context)
        ? _NavigationLayout.compact
        : DeviceContext.extendNavigationRail(context)
        ? _NavigationLayout.wide
        : _NavigationLayout.medium;
    if (_layout != layout) {
      _layout = layout;
      _expanded = layout == _NavigationLayout.wide;
      _afterDismiss = null;
      // The old drawer must release its LocalHistoryEntry and focus before the
      // new layout takes over. Keep the content subtree mounted throughout.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _scaffoldKey.currentState?.closeDrawer();
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
      setState(() => _expanded = !_expanded);
    } else {
      _scaffoldKey.currentState?.openDrawer();
    }
  }

  void _dismiss() => _scaffoldKey.currentState?.closeDrawer();

  void _perform(VoidCallback action) {
    if (_scaffoldKey.currentState?.isDrawerOpen ?? false) {
      _afterDismiss = action;
      _dismiss();
    } else {
      action();
    }
  }

  void _onDrawerChanged(bool open) {
    if (open) return;
    final action = _afterDismiss;
    _afterDismiss = null;
    if (action != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) action();
      });
    }
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
    final compact = _layout == _NavigationLayout.compact;
    final inlineExpanded = _layout == _NavigationLayout.wide && _expanded;
    final info = _availableUpdate(ref);

    return Scaffold(
      key: _scaffoldKey,
      restorationId: widget.restorationId,
      drawerEnableOpenDragGesture: compact,
      onDrawerChanged: _onDrawerChanged,
      // Keep the controller mounted across breakpoints so closing releases
      // both Scaffold's open state and the route's LocalHistoryEntry.
      drawer: Drawer(
        width: math.min(_expandedWidth, MediaQuery.sizeOf(context).width - 56),
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
              SingleActivator(LogicalKeyboardKey.escape): DismissIntent(),
            },
            child: _NavigationPanel(
              expanded: true,
              section: widget.section,
              destinations: widget.destinations,
              selectedIndex: widget.selectedIndex,
              updateAvailable: info != null,
              onToggle: _dismiss,
              onDestination: (index) =>
                  _perform(() => widget.onDestinationSelected?.call(index)),
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
      body: Row(
        children: [
          SizedBox(
            width: compact
                ? 0
                : inlineExpanded
                ? _expandedWidth
                : _collapsedWidth,
            child: compact
                ? null
                : Material(
                    color: Theme.of(context).colorScheme.surface,
                    child: _NavigationPanel(
                      expanded: inlineExpanded,
                      section: widget.section,
                      destinations: widget.destinations,
                      selectedIndex: widget.selectedIndex,
                      updateAvailable: info != null,
                      onToggle: _toggle,
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
          SizedBox(
            width: compact ? 0 : 1,
            child: compact
                ? null
                : const VerticalDivider(thickness: 1, width: 1),
          ),
          Expanded(
            // A shell Navigator's route blocks earlier semantics in its own
            // container. Isolate it so the persistent rail remains accessible.
            child: Semantics(
              container: true,
              explicitChildNodes: true,
              child: widget.child,
            ),
          ),
        ],
      ),
      bottomNavigationBar: compact && widget.destinations.isNotEmpty
          ? NavigationBar(
              height: 60,
              labelBehavior:
                  NavigationDestinationLabelBehavior.onlyShowSelected,
              selectedIndex: widget.selectedIndex!,
              onDestinationSelected: widget.onDestinationSelected,
              destinations: [
                for (final destination in widget.destinations)
                  NavigationDestination(
                    icon: destination.icon,
                    selectedIcon: destination.selectedIcon,
                    label: (destination.label as Text).data!,
                  ),
              ],
            )
          : null,
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
    final aboutLabel = MaterialLocalizations.of(
      context,
    ).aboutListTileTitle('Gagaku');

    return SafeArea(
      child: CustomScrollView(
        primary: false,
        slivers: [
          SliverToBoxAdapter(
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: IconButton(
                  tooltip: expanded
                      ? t.navigation.collapse
                      : t.navigation.expand,
                  onPressed: onToggle,
                  icon: Icon(expanded ? Icons.menu_open : Icons.menu),
                ),
              ),
            ),
          ),
          SliverList.list(
            children: [
              for (var index = 0; index < destinations.length; index++)
                _PanelItem(
                  expanded: expanded,
                  icon: selectedIndex == index
                      ? destinations[index].selectedIcon
                      : destinations[index].icon,
                  label: destinations[index].label,
                  tooltip: (destinations[index].label as Text).data!,
                  selected: selectedIndex == index,
                  onTap: () => onDestination(index),
                ),
              if (destinations.isNotEmpty)
                const Divider(indent: 12, endIndent: 12),
              if (expanded)
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(24, 12, 24, 8),
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
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
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
          ),
        ],
      ),
    );
  }
}

class _PanelItem extends StatelessWidget {
  const _PanelItem({
    required this.expanded,
    required this.icon,
    required this.label,
    required this.tooltip,
    required this.onTap,
    this.selected = false,
    this.badge = false,
  });

  final bool expanded;
  final Widget icon;
  final Widget label;
  final String tooltip;
  final VoidCallback onTap;
  final bool selected;
  final bool badge;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final foreground = selected
        ? theme.colorScheme.onSecondaryContainer
        : theme.colorScheme.onSurfaceVariant;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: expanded ? 12 : 8, vertical: 4),
      child: Semantics(
        selected: selected,
        button: true,
        label: tooltip,
        onTap: onTap,
        excludeSemantics: true,
        child: Tooltip(
          message: tooltip,
          excludeFromSemantics: true,
          child: Material(
            color: selected
                ? theme.colorScheme.secondaryContainer
                : Colors.transparent,
            shape: const StadiumBorder(),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: onTap,
              child: ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 48),
                child: IconTheme.merge(
                  data: IconThemeData(color: foreground),
                  child: DefaultTextStyle(
                    style: theme.textTheme.labelLarge!.copyWith(
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
                                Expanded(child: label),
                                if (badge) ...[
                                  const SizedBox(width: 12),
                                  const Badge(),
                                ],
                              ],
                            ),
                          )
                        : Center(
                            child: Badge(isLabelVisible: badge, child: icon),
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
