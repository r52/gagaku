import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:material_ui/material_ui.dart';

// Temporary compatibility hooks pending upstream flutter_hooks support for the
// standalone material_ui package. The SDK Material controllers returned by
// flutter_hooks are different Dart types; the compatibility bridge cannot adapt
// them. Remove these hooks when upstream provides material_ui-typed controllers.

/// Creates a Material UI tab controller, disposed automatically by the hook.
///
/// Initial values are read once; change [keys] to recreate the controller and its
/// ticker together, for example when the number of tabs changes.
TabController useMaterialTabController({
  required int initialLength,
  int initialIndex = 0,
  List<Object?>? keys,
}) {
  final vsync = useSingleTickerProvider(keys: keys);
  return use(
    _MaterialTabControllerHook(
      length: initialLength,
      initialIndex: initialIndex,
      vsync: vsync,
      keys: keys,
    ),
  );
}

class _MaterialTabControllerHook extends Hook<TabController> {
  const _MaterialTabControllerHook({
    required this.length,
    required this.initialIndex,
    required this.vsync,
    super.keys,
  });

  final int length;
  final int initialIndex;
  final TickerProvider vsync;

  @override
  HookState<TabController, _MaterialTabControllerHook> createState() =>
      _MaterialTabControllerHookState();
}

class _MaterialTabControllerHookState
    extends HookState<TabController, _MaterialTabControllerHook> {
  late final controller = TabController(
    length: hook.length,
    initialIndex: hook.initialIndex,
    vsync: hook.vsync,
  );

  @override
  TabController build(BuildContext context) => controller;

  @override
  void dispose() => controller.dispose();

  @override
  String get debugLabel => 'useMaterialTabController';
}

/// Creates a Material UI search controller, disposed automatically by the hook.
SearchController useMaterialSearchController({List<Object?>? keys}) {
  return use(_MaterialSearchControllerHook(keys: keys));
}

class _MaterialSearchControllerHook extends Hook<SearchController> {
  const _MaterialSearchControllerHook({super.keys});

  @override
  HookState<SearchController, _MaterialSearchControllerHook> createState() =>
      _MaterialSearchControllerHookState();
}

class _MaterialSearchControllerHookState
    extends HookState<SearchController, _MaterialSearchControllerHook> {
  final controller = SearchController();

  @override
  SearchController build(BuildContext context) => controller;

  @override
  void dispose() => controller.dispose();

  @override
  String get debugLabel => 'useMaterialSearchController';
}
