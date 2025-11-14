import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/util/ui.dart';
import 'package:gagaku/web/model/model.dart';
import 'package:gagaku/web/model/types.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ExtensionSettingsPage extends HookConsumerWidget {
  const ExtensionSettingsPage({super.key, required this.source});

  final WebSourceInfo source;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tr = context.t;
    final results = useMemoized(
      () => ref
          .read(extensionSourceProvider(source.id).notifier)
          .getSettingsForm(),
      [source],
    );
    final future = useFuture(results);

    Widget body = Center(child: CircularProgressIndicator());

    if (future.hasError) {
      body = ErrorList(error: future.error!, stackTrace: future.stackTrace!);
    } else if (future.connectionState == ConnectionState.waiting ||
        !future.hasData) {
      body = Center(child: CircularProgressIndicator());
    }

    if (future.data != null) {
      final data = future.data!;
      return FormBuilder(source: source, form: data, isTopLevel: true);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(tr.arg_settings(arg: source.name)),
        leading: const BackButton(),
      ),
      body: SafeArea(child: body),
    );
  }
}

class FormBuilder extends StatefulHookConsumerWidget {
  const FormBuilder({
    super.key,
    required this.source,
    required this.form,
    required this.isTopLevel,
  });

  final WebSourceInfo source;
  final SettingsForm form;
  final bool isTopLevel;

  @override
  ConsumerState<FormBuilder> createState() => _FormBuilderState();
}

class _FormBuilderState extends ConsumerState<FormBuilder> {
  @override
  void dispose() {
    if (widget.isTopLevel) {
      widget.form.uninitialize();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tr = context.t;
    final form = useListenable(widget.form);
    final future = useFuture(form.sections);

    Widget body = Center(child: CircularProgressIndicator());

    if (future.hasError) {
      body = ErrorList(error: future.error!, stackTrace: future.stackTrace!);
    } else if (future.connectionState == ConnectionState.waiting ||
        !future.hasData) {
      body = Center(child: CircularProgressIndicator());
    }

    if (future.data != null) {
      final data = future.data!;

      body = ListView.separated(
        itemCount: data.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          return FormSectionBuilder(
            source: widget.source,
            section: data[index],
          );
        },
      );
    }

    // TODO submit button support?

    return Scaffold(
      appBar: AppBar(
        title: Text(tr.arg_settings(arg: widget.source.name)),
        leading: const BackButton(),
      ),
      body: SafeArea(child: body),
    );
  }
}

class FormItemDelegateBuilder extends StatelessWidget {
  const FormItemDelegateBuilder({
    super.key,
    required this.source,
    required this.element,
  });

  final WebSourceInfo source;
  final FormItemElement element;

  @override
  Widget build(BuildContext context) {
    switch (element) {
      case NavigationRowElement():
        return NavigationRowBuilder(
          source: source,
          element: element as NavigationRowElement,
        );
      case SelectRowElement():
        return SelectRowBuilder(
          source: source,
          element: element as SelectRowElement,
        );
      case InputRowElement():
        return InputRowBuilder(
          source: source,
          element: element as InputRowElement,
          secure: false,
        );
      case ButtonRowElement():
        return ButtonRowBuilder(
          source: source,
          element: element as ButtonRowElement,
        );
      case ToggleRowElement():
        return ToggleRowBuilder(
          source: source,
          element: element as ToggleRowElement,
        );
      case LabelRowElement():
        return LabelRowBuilder(
          source: source,
          element: element as LabelRowElement,
        );
      case StepperRowElement():
        return StepperRowBuilder(
          source: source,
          element: element as StepperRowElement,
        );
      case OAuthButtonRowElement():
        // TODO: support this?
        return UnsupportedRowBuilder(
          source: source,
          element: element as OAuthButtonRowElement,
        );
      case WebViewRowElement():
        return UnsupportedRowBuilder(
          source: source,
          element: element as OAuthButtonRowElement,
        );
    }
  }
}

class FormSectionBuilder extends StatelessWidget {
  const FormSectionBuilder({
    super.key,
    required this.source,
    required this.section,
  });

  final WebSourceInfo source;
  final FormSectionElement section;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (section.header != null)
          Text(section.header!, style: CommonTextStyles.twentyBold),
        for (final item in section.items)
          FormItemDelegateBuilder(source: source, element: item),
        if (section.footer != null) Text(section.footer!),
      ],
    );
  }
}

class ButtonRowBuilder extends ConsumerWidget {
  const ButtonRowBuilder({
    super.key,
    required this.source,
    required this.element,
  });

  final WebSourceInfo source;
  final ButtonRowElement element;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (element.isHidden) {
      return const SizedBox.shrink();
    }

    return Card(
      child: ListTile(
        title: Text(element.title),
        onTap: () async {
          await ref
              .read(extensionSourceProvider(source.id).notifier)
              .callBinding(element.onSelect);
        },
      ),
    );
  }
}

class SelectRowBuilder extends HookConsumerWidget {
  const SelectRowBuilder({
    super.key,
    required this.source,
    required this.element,
  });

  final WebSourceInfo source;
  final SelectRowElement element;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final data = useState(element.value);

    return SettingCardWidget(
      title: Text(element.title),
      subtitle: element.subtitle != null ? Text(element.subtitle!) : null,
      builder: (context) {
        return HookBuilder(
          builder: (context) {
            if (element.maxItemCount == 1) {
              return Center(
                child: DropdownMenu<String>(
                  initialSelection: data.value.isNotEmpty
                      ? data.value.first
                      : null,
                  requestFocusOnTap: false,
                  enableSearch: false,
                  enableFilter: false,
                  dropdownMenuEntries: [
                    for (final option in element.options)
                      DropdownMenuEntry(value: option.id, label: option.title),
                  ],
                  onSelected: (String? value) {
                    if (value != null) {
                      data.value = [value];
                      ref
                          .read(extensionSourceProvider(source.id).notifier)
                          .callBinding(element.onValueChange, [
                            [data.value],
                          ]);
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
                      borderRadius: const BorderRadius.all(
                        Radius.circular(6.0),
                      ),
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
                  menuChildren: [
                    for (final option in element.options)
                      CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(option.title),
                        value: data.value.contains(option.id),
                        onChanged: (bool? value) async {
                          if (value == true) {
                            if (element.maxItemCount != null &&
                                data.value.length == element.maxItemCount) {
                              return;
                            }

                            data.value = [...data.value, option.id];
                          } else {
                            if (data.value.length == element.minItemCount) {
                              return;
                            }
                            data.value = [...data.value..remove(option.id)];
                          }

                          ref
                              .read(extensionSourceProvider(source.id).notifier)
                              .callBinding(element.onValueChange, [data.value]);
                        },
                      ),
                  ],
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
                                    .read(
                                      extensionSourceProvider(
                                        source.id,
                                      ).notifier,
                                    )
                                    .callBinding(element.onValueChange, [
                                      data.value,
                                    ]);
                              },
                              icon: const Icon(Icons.close),
                              label: Text(
                                element.options
                                    .firstWhere((e) => e.id == option)
                                    .title,
                              ),
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

class InputRowBuilder extends HookConsumerWidget {
  const InputRowBuilder({
    super.key,
    required this.source,
    required this.element,
    this.secure = false,
  });

  final WebSourceInfo source;
  final InputRowElement element;
  final bool secure;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (element.isHidden) {
      return const SizedBox.shrink();
    }

    return SettingCardWidget(
      title: Text(element.title),
      builder: (context) {
        return HookBuilder(
          builder: (context) {
            final controller = useTextEditingController(text: element.value);
            final settingText = useListenableSelector(
              controller,
              () => controller.text,
            );
            final debouncedInput = useDebounced(
              settingText,
              const Duration(milliseconds: 500),
            );

            useEffect(() {
              Future.delayed(Duration.zero, () {
                if (debouncedInput != null) {
                  ref
                      .read(extensionSourceProvider(source.id).notifier)
                      .callBinding(element.onValueChange, [debouncedInput]);
                }
              });
              return null;
            }, [debouncedInput]);

            return TextFormField(
              controller: controller,
              decoration: const InputDecoration(filled: true),
              obscureText: secure,
            );
          },
        );
      },
    );
  }
}

class NavigationRowBuilder extends HookConsumerWidget {
  const NavigationRowBuilder({
    super.key,
    required this.source,
    required this.element,
  });

  final WebSourceInfo source;
  final NavigationRowElement element;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nav = Navigator.of(context);
    final results = useMemoized(
      () => ref
          .read(extensionSourceProvider(source.id).notifier)
          .getForm(element.form),
      [source],
    );
    final future = useFuture(results);

    Widget body = Center(child: CircularProgressIndicator());

    if (future.hasError) {
      body = ErrorList(error: future.error!, stackTrace: future.stackTrace!);
    } else if (future.connectionState == ConnectionState.waiting ||
        !future.hasData) {
      body = Center(child: CircularProgressIndicator());
    }

    if (future.data != null) {
      final data = future.data!;

      body = Card(
        child: ListTile(
          title: Text(element.title),
          subtitle: element.subtitle != null ? Text(element.subtitle!) : null,
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () => nav.push(
            PageTransitionRouteBuilder(
              pageTransitionsBuilder:
                  const FadeForwardsPageTransitionsBuilder(),
              pageBuilder: (context, animation, secondaryAnimation) =>
                  FormBuilder(source: source, form: data, isTopLevel: false),
            ),
          ),
        ),
      );
    }

    return body;
  }
}

class ToggleRowBuilder extends HookConsumerWidget {
  const ToggleRowBuilder({
    super.key,
    required this.source,
    required this.element,
  });

  final WebSourceInfo source;
  final ToggleRowElement element;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (element.isHidden) {
      return const SizedBox.shrink();
    }

    final currentVal = useState(element.value);

    return SettingCardWidget(
      title: Text(element.title),
      builder: (context) {
        return Switch(
          value: currentVal.value,
          onChanged: (value) {
            ref.read(extensionSourceProvider(source.id).notifier).callBinding(
              element.onValueChange,
              [value],
            );
            currentVal.value = value;
          },
        );
      },
    );
  }
}

class StepperRowBuilder extends HookConsumerWidget {
  const StepperRowBuilder({
    super.key,
    required this.source,
    required this.element,
  });

  final WebSourceInfo source;
  final StepperRowElement element;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentVal = useState(element.value);

    return SettingCardWidget(
      title: Text(element.title),
      builder: (context) {
        return SpinBox(
          value: currentVal.value.toDouble(),
          min: element.minValue.toDouble(),
          max: element.maxValue.toDouble(),
          step: element.stepValue.toDouble(),
          onChanged: (value) {
            ref.read(extensionSourceProvider(source.id).notifier).callBinding(
              element.onValueChange,
              [value],
            );
            currentVal.value = value;
          },
        );
      },
    );
  }
}

class LabelRowBuilder extends StatelessWidget {
  const LabelRowBuilder({
    super.key,
    required this.source,
    required this.element,
  });

  final WebSourceInfo source;
  final LabelRowElement element;

  @override
  Widget build(BuildContext context) {
    if (element.isHidden) {
      return const SizedBox.shrink();
    }

    return Card(
      child: ListTile(
        title: Text(element.title),
        subtitle: element.subtitle != null ? Text(element.subtitle!) : null,
      ),
    );
  }
}

class UnsupportedRowBuilder extends ConsumerWidget {
  const UnsupportedRowBuilder({
    super.key,
    required this.source,
    required this.element,
  });

  final WebSourceInfo source;
  final FormItemElement element;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (element.isHidden) {
      return const SizedBox.shrink();
    }

    return Card(
      child: ListTile(title: Text("Unsupported element"), enabled: false),
    );
  }
}
