import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/model/model.dart';
import 'package:gagaku/util/ui.dart';
import 'package:gagaku/web/model/model.dart';
import 'package:gagaku/web/model/types.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ExtensionSettings extends HookConsumerWidget {
  const ExtensionSettings({super.key, required this.source});

  final SourceIdentifier source;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final results =
        useMemoized(() => ref.read(extensionSourceProvider(source.internal.id).notifier).getSourceMenu(), [source]);
    final future = useFuture(results);

    Widget body = Center(
      child: CircularProgressIndicator(),
    );

    if (future.hasError) {
      body = ErrorList(error: future.error!, stackTrace: future.stackTrace!);
    }

    if (future.connectionState == ConnectionState.waiting || !future.hasData) {
      body = Center(
        child: CircularProgressIndicator(),
      );
    }

    if (future.data != null) {
      final data = future.data!;
      body = DUIDelegateBuilder(source: source, element: data);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('arg_settings'.tr(context: context, args: [source.external.name])),
        leading: BackButton(
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go(GagakuRoute.extensionHome);
            }
          },
        ),
      ),
      body: SafeArea(child: body),
    );
  }
}

class DUIDelegateBuilder extends StatelessWidget {
  const DUIDelegateBuilder({super.key, required this.source, required this.element});

  final SourceIdentifier source;
  final DUIType element;

  @override
  Widget build(BuildContext context) {
    switch (element) {
      case DUISection():
        return DUISectionBuilder(
          source: source,
          element: element as DUISection,
        );
      case DUINavigationButton():
        return DUINavigationButtonBuilder(
          source: source,
          element: element as DUINavigationButton,
        );
      case DUISelect():
        return DUISelectBuilder(
          source: source,
          element: element as DUISelect,
        );
      case DUIInputField():
        return DUIInputFieldBuilder(
          source: source,
          element: element as DUIInputField,
        );
      case DUIButton():
        return DUIButtonBuilder(
          source: source,
          element: element as DUIButton,
        );
      case DUISwitch():
        return DUISwitchBuilder(
          source: source,
          element: element as DUISwitch,
        );
      case DUIForm():
        return DUIFormBuilder(
          source: source,
          element: element as DUIForm,
          parent: element,
        );
      default:
        return Text("Invalid DUI type");
    }
  }
}

class DUISectionBuilder extends StatelessWidget {
  const DUISectionBuilder({super.key, required this.source, required this.element});

  final SourceIdentifier source;
  final DUISection element;

  @override
  Widget build(BuildContext context) {
    if (element.isHidden) {
      return SizedBox.shrink();
    }

    return Column(
      children: [
        if (element.header != null)
          Text(
            element.header!,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        for (final row in element.rows) DUIDelegateBuilder(source: source, element: row),
        if (element.footer != null) Text(element.footer!),
      ],
    );
  }
}

class DUIButtonBuilder extends ConsumerWidget {
  const DUIButtonBuilder({super.key, required this.source, required this.element});

  final SourceIdentifier source;
  final DUIButton element;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: ListTile(
        title: Text(element.label),
        onTap: () async {
          await ref.read(extensionSourceProvider(source.internal.id).notifier).callBinding(element.id);
        },
      ),
    );
  }
}

class DUISelectBuilder extends HookConsumerWidget {
  const DUISelectBuilder({super.key, required this.source, required this.element});

  final SourceIdentifier source;
  final DUISelect element;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final initFuture = useMemoized(
        () => ref.read(extensionSourceProvider(source.internal.id).notifier).callBinding('${element.id}.get'));
    final initial = useFuture(initFuture);

    if (initial.connectionState == ConnectionState.waiting) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    final data = useState(
        initial.hasData ? (initial.data != null ? List<String>.from(initial.data! as List) : <String>[]) : <String>[]);

    return SettingCardWidget(
      title: Text(element.label),
      builder: (context) {
        return HookBuilder(
          builder: (context) {
            if (!element.allowsMultiselect) {
              return Center(
                child: DropdownMenu<String>(
                  initialSelection: data.value.isNotEmpty ? data.value.first : null,
                  requestFocusOnTap: false,
                  enableSearch: false,
                  enableFilter: false,
                  dropdownMenuEntries: [
                    for (final MapEntry(key: option, value: label) in element.labels.entries)
                      DropdownMenuEntry(value: option, label: label)
                  ],
                  onSelected: (String? value) {
                    if (value != null) {
                      ref.read(extensionSourceProvider(source.internal.id).notifier).callBinding('${element.id}.set', [
                        [value]
                      ]);

                      data.value = [value];
                    }
                  },
                ),
              );
            } else {
              return Center(
                child: MenuAnchor(
                  builder: (context, controller, child) => SizedBox(
                    width: double.infinity,
                    child: Material(
                      color: theme.colorScheme.surfaceContainerHighest,
                      borderRadius: const BorderRadius.all(Radius.circular(6.0)),
                      child: InkWell(
                        onTap: () {
                          if (controller.isOpen) {
                            controller.close();
                          } else {
                            controller.open();
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: child,
                        ),
                      ),
                    ),
                  ),
                  menuChildren: List.generate(
                    element.labels.entries.length,
                    (index) => Builder(
                      builder: (_) {
                        final option = element.labels.entries.elementAt(index);
                        return CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          title: Text(option.value),
                          value: data.value.contains(option.key),
                          onChanged: (bool? value) async {
                            if (value == true) {
                              data.value = [...data.value, option.key];
                            } else {
                              data.value = [...data.value..remove(option.key)];
                            }

                            ref
                                .read(extensionSourceProvider(source.internal.id).notifier)
                                .callBinding('${element.id}.set', [data.value]);
                          },
                        );
                      },
                    ),
                  ),
                  child: Column(
                    children: [
                      Wrap(
                        spacing: 2.0,
                        runSpacing: 2.0,
                        children: [
                          for (final option in data.value)
                            ElevatedButton.icon(
                              onPressed: () {
                                data.value = [...data.value..remove(option)];
                                ref
                                    .read(extensionSourceProvider(source.internal.id).notifier)
                                    .callBinding('${element.id}.set', [data.value]);
                              },
                              icon: const Icon(Icons.close),
                              label: Text(element.labels[option]!),
                            ),
                        ],
                      ),
                      const Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }
}

class DUIInputFieldBuilder extends HookConsumerWidget {
  const DUIInputFieldBuilder({super.key, required this.source, required this.element});

  final SourceIdentifier source;
  final DUIInputField element;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initFuture = useMemoized(
        () => ref.read(extensionSourceProvider(source.internal.id).notifier).callBinding('${element.id}.get'));
    final initial = useFuture(initFuture);

    if (initial.connectionState == ConnectionState.waiting) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    final data = useState(initial.hasData ? (initial.data != null ? initial.data! as String : null) : null);

    return SettingCardWidget(
      title: Text(element.label),
      builder: (context) {
        return HookBuilder(
          builder: (context) {
            final controller = useTextEditingController(text: data.value);
            final settingText = useListenableSelector(controller, () => controller.text);
            final debouncedInput = useDebounced(
              settingText,
              const Duration(milliseconds: 500),
            );

            useEffect(() {
              Future.delayed(Duration.zero, () {
                if (debouncedInput != null) {
                  ref
                      .read(extensionSourceProvider(source.internal.id).notifier)
                      .callBinding('${element.id}.set', [debouncedInput]);
                }
              });
              return null;
            }, [debouncedInput]);

            return TextFormField(
              controller: controller,
              decoration: const InputDecoration(
                filled: true,
              ),
            );
          },
        );
      },
    );
  }
}

class DUINavigationButtonBuilder extends StatelessWidget {
  const DUINavigationButtonBuilder({super.key, required this.source, required this.element});

  final SourceIdentifier source;
  final DUINavigationButton element;

  @override
  Widget build(BuildContext context) {
    final nav = Navigator.of(context);

    return Card(
      child: ListTile(
        title: Text(element.label),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () => nav.push(SlideTransitionRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => DUIFormBuilder(
            source: source,
            element: element.form,
            parent: element,
          ),
        )),
      ),
    );
  }
}

class DUISwitchBuilder extends HookConsumerWidget {
  const DUISwitchBuilder({super.key, required this.source, required this.element});

  final SourceIdentifier source;
  final DUISwitch element;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initFuture = useMemoized(
        () => ref.read(extensionSourceProvider(source.internal.id).notifier).callBinding('${element.id}.get'));
    final initial = useFuture(initFuture);

    if (initial.connectionState == ConnectionState.waiting) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    final data = useState(initial.hasData ? (initial.data != null ? initial.data! as bool : false) : false);

    return SettingCardWidget(
      title: Text(element.label),
      builder: (context) {
        return Switch(
          value: data.value,
          onChanged: (value) {
            ref.read(extensionSourceProvider(source.internal.id).notifier).callBinding('${element.id}.set', [value]);
            data.value = value;
          },
        );
      },
    );
  }
}

class DUIFormBuilder extends StatelessWidget {
  const DUIFormBuilder({super.key, required this.source, required this.element, required this.parent});

  final SourceIdentifier source;
  final DUIForm element;
  final DUIType parent;

  @override
  Widget build(BuildContext context) {
    // TODO submit

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go(GagakuRoute.extensionHome);
            }
          },
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            for (final sec in element.sections) DUISectionBuilder(source: source, element: sec),
          ],
        ),
      ),
    );
  }
}
