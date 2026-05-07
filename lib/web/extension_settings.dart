import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/util/ui.dart';
import 'package:gagaku/web/model/extension_bridge.dart';
import 'package:gagaku/web/model/model.dart';
import 'package:gagaku/web/model/types.dart';
import 'package:gagaku/web/deeplink.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:openid_client/openid_client_io.dart' as oidc;
import 'package:url_launcher/url_launcher.dart';

class ExtensionSettingsPage extends HookConsumerWidget {
  const ExtensionSettingsPage({super.key, required this.source});

  final WebSourceInfo source;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tr = context.t;
    final results = useMemoized(() async {
      final form = await ref
          .read(extensionSourceProvider(source.id).notifier)
          .getSettingsForm();

      await form.call('formDidAppear');

      return form;
    }, [source]);
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
        leading: BackButton(
          onPressed: () {
            ExtensionForm? form;
            if (future.data != null) {
              form = future.data!;
            }

            form?.call('formWillDisappear');
            Navigator.maybePop(context);
          },
        ),
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
  final ExtensionForm form;
  final bool isTopLevel;

  @override
  ConsumerState<FormBuilder> createState() => _FormBuilderState();
}

class _FormBuilderState extends ConsumerState<FormBuilder> {
  @override
  void dispose() {
    widget.form.call('formDidDisappear');

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

    return Scaffold(
      appBar: AppBar(
        title: Text(tr.arg_settings(arg: widget.source.name)),
        leading: BackButton(
          onPressed: () {
            widget.form.formDidCancel();
            Navigator.maybePop(context);
          },
        ),
        actions: widget.form.requiresExplicitSubmission
            ? [
                OverflowBar(
                  spacing: 8.0,
                  children: [
                    Tooltip(
                      message: tr.ui.cancel,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          widget.form.formDidCancel();
                          Navigator.maybePop(context);
                        },
                        icon: const Icon(Icons.close),
                        label: Text(tr.ui.cancel),
                      ),
                    ),
                    Tooltip(
                      message: tr.ui.submit,
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          try {
                            await widget.form.formDidSubmit();
                            final result = await widget.form
                                .getSearchQueryMetadata();
                            if (context.mounted) {
                              Navigator.maybePop(context, result);
                            }
                          } catch (e) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.toString())),
                              );
                            }
                          }
                        },
                        icon: const Icon(Icons.check),
                        label: Text(tr.ui.submit),
                      ),
                    ),
                  ],
                ),
              ]
            : null,
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
    this.onDelete,
  });

  final WebSourceInfo source;
  final FormItemElement element;
  final Future<void> Function()? onDelete;

  @override
  Widget build(BuildContext context) {
    Widget child;

    switch (element) {
      case NavigationRowElement():
        child = NavigationRowBuilder(
          source: source,
          element: element as NavigationRowElement,
        );
        break;
      case InputRowElement():
        child = InputRowBuilder(
          source: source,
          element: element as InputRowElement,
        );
        break;
      case ButtonRowElement():
        child = ButtonRowBuilder(
          source: source,
          element: element as ButtonRowElement,
        );
        break;
      case ToggleRowElement():
        child = ToggleRowBuilder(
          source: source,
          element: element as ToggleRowElement,
        );
        break;
      case LabelRowElement():
        child = LabelRowBuilder(
          source: source,
          element: element as LabelRowElement,
        );
        break;
      case StepperRowElement():
        child = StepperRowBuilder(
          source: source,
          element: element as StepperRowElement,
        );
        break;
      case OAuthButtonRowElement():
        child = OAuthButtonRowBuilder(
          source: source,
          element: element as OAuthButtonRowElement,
        );
        break;
      case WebViewRowElement():
        child = UnsupportedRowBuilder(
          source: source,
          element: element as OAuthButtonRowElement,
        );
        break;
    }

    if (onDelete != null) {
      return Dismissible(
        key: Key('${element.id}_dismissible'),
        direction: DismissDirection.endToStart,
        confirmDismiss: (direction) async {
          await onDelete!();
          return false;
          // Return false so we rely on the backend state update instead
          // of removing locally and breaking the index sync
        },
        background: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          child: const Icon(Icons.delete, color: Colors.white),
        ),
        child: child,
      );
    }
    return child;
  }
}

class FormSectionBuilder extends ConsumerWidget {
  const FormSectionBuilder({
    super.key,
    required this.source,
    required this.section,
  });

  final WebSourceInfo source;
  final FormSectionElement section;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listsec = section is ListSectionElement
        ? section as ListSectionElement
        : null;

    return Column(
      children: [
        if (section.header != null || listsec?.allowAddition == true)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (section.header != null)
                Text(section.header!, style: CommonTextStyles.twentyBold),
              if (listsec?.allowAddition == true)
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () async {
                    await _safeCallBinding(
                      context,
                      ref,
                      source.id,
                      listsec!.onAddition!,
                    );
                  },
                ),
            ],
          ),
        if (listsec?.allowReorder == true)
          ReorderableListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            onReorder: (oldIndex, newIndex) async {
              if (oldIndex < newIndex) {
                newIndex -= 1;
              }
              await _safeCallBinding(
                context,
                ref,
                source.id,
                listsec!.onReorder!,
                [oldIndex, newIndex],
              );
            },
            children: [
              for (final item in section.items)
                FormItemDelegateBuilder(
                  key: Key(item.id),
                  source: source,
                  element: item,
                  onDelete: listsec!.onDeletion != null
                      ? () => _safeCallBinding(
                          context,
                          ref,
                          source.id,
                          listsec.onDeletion!,
                          [section.items.indexOf(item)],
                        )
                      : null,
                ),
            ],
          )
        else
          for (final item in section.items)
            FormItemDelegateBuilder(
              key: Key(
                item.id,
              ), // Added to give each item a unique key for deletion UI state
              source: source,
              element: item,
              onDelete: listsec?.onDeletion != null
                  ? () => _safeCallBinding(
                      context,
                      ref,
                      source.id,
                      listsec!.onDeletion!,
                      [section.items.indexOf(item)],
                    )
                  : null,
            ),
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
          await _safeCallBinding(context, ref, source.id, element.onSelect);
        },
      ),
    );
  }
}

class InputRowBuilder extends HookConsumerWidget {
  const InputRowBuilder({
    super.key,
    required this.source,
    required this.element,
  });

  final WebSourceInfo source;
  final InputRowElement element;

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
                if (!context.mounted) return;
                if (debouncedInput != null) {
                  _safeCallBinding(
                    context,
                    ref,
                    source.id,
                    element.onValueChange,
                    [debouncedInput],
                  );
                }
              });
              return null;
            }, [debouncedInput]);

            return TextFormField(
              controller: controller,
              decoration: const InputDecoration(filled: true),
              obscureText: element.isSecureEntry == true,
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
    final theme = Theme.of(context);
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
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (element.value != null) ...[
                Text(
                  element.value!,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.outline,
                  ),
                ),
                const SizedBox(width: 8),
              ],
              const Icon(Icons.arrow_forward_ios, size: 16),
            ],
          ),
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

class LabelRowBuilder extends ConsumerWidget {
  const LabelRowBuilder({
    super.key,
    required this.source,
    required this.element,
  });

  final WebSourceInfo source;
  final LabelRowElement element;

  Color? _getColorForStyle(BuildContext context, RowStyle? style) {
    if (style == null) return null;
    switch (style) {
      case RowStyle.success:
        return Colors.green;
      case RowStyle.error:
        return Colors.red;
      case RowStyle.warning:
        return Colors.orange;
      case RowStyle.tinted:
        return Theme.of(context).colorScheme.primary;
    }
  }

  String? _getSymbol(String? symbol) {
    if (symbol == null) return null;
    switch (symbol) {
      case 'checkmark':
        return '✓';
      case 'xmark':
        return '✕';
      default:
        return symbol;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (element.isHidden) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);
    String? displayValue;
    String? displaySymbol;
    RowStyle? innerStyle;

    if (element.value is String) {
      displayValue = element.value as String;
    } else if (element.value is LabelRowValue) {
      final val = element.value as LabelRowValue;
      displayValue = val.text;
      displaySymbol = val.symbol;
      innerStyle = val.style;
    } else if (element.value is Map) {
      // Fallback for unchecked dynamic map
      final map = element.value as Map;
      displayValue = map['text'] as String?;
      displaySymbol = map['symbol'] as String?;
    }

    final outerColor = _getColorForStyle(context, element.style);
    final innerColor = _getColorForStyle(context, innerStyle);
    final resolvedSymbol = _getSymbol(displaySymbol);
    final trailingText = resolvedSymbol ?? displayValue;

    Widget? trailingWidget;
    if (trailingText != null) {
      trailingWidget = Text(
        trailingText,
        style: TextStyle(
          color: innerColor ?? outerColor ?? theme.colorScheme.outline,
          fontWeight: (innerColor ?? outerColor) != null
              ? FontWeight.bold
              : null,
        ),
      );
    }

    return Card(
      child: ListTile(
        textColor: outerColor,
        iconColor: outerColor,
        title: Text(element.title),
        subtitle: element.subtitle != null ? Text(element.subtitle!) : null,
        trailing: trailingWidget,
        onTap: element.onSelect != null
            ? () {
                _safeCallBinding(context, ref, source.id, element.onSelect!);
              }
            : null,
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

class OAuthButtonRowBuilder extends ConsumerWidget {
  const OAuthButtonRowBuilder({
    super.key,
    required this.source,
    required this.element,
  });

  final WebSourceInfo source;
  final OAuthButtonRowElement element;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (element.isHidden) {
      return const SizedBox.shrink();
    }

    return Card(
      child: ListTile(
        title: Text(element.title),
        subtitle: element.subtitle != null ? Text(element.subtitle!) : null,
        onTap: () async {
          final tokenEndpoint = switch (element.responseType) {
            OAuthTokenResponse() => null,
            OAuthCodeResponse(tokenEndpoint: final te) => te,
            OAuthPKCEResponse(tokenEndpoint: final te) => te,
            _ => null,
          };

          String issuerUrl;
          try {
            final uri = Uri.parse(element.authorizeEndpoint);
            if (uri.hasScheme && uri.hasAuthority) {
              issuerUrl = uri.origin;
            } else {
              issuerUrl = element.authorizeEndpoint;
            }
          } catch (_) {
            issuerUrl = element.authorizeEndpoint;
          }

          final metadata = oidc.OpenIdProviderMetadata.fromJson({
            'issuer': issuerUrl,
            'authorization_endpoint': element.authorizeEndpoint,
            'token_endpoint': tokenEndpoint,
          });

          final issuer = oidc.Issuer(metadata);
          final client = oidc.Client(issuer, element.clientId ?? 'paperback');

          final flow = switch (element.responseType) {
            OAuthTokenResponse() => oidc.Flow.implicit(client),
            OAuthCodeResponse() => oidc.Flow.authorizationCode(client),
            OAuthPKCEResponse() => oidc.Flow.authorizationCodeWithPKCE(client),
            _ => oidc.Flow.implicit(client),
          };

          if (element.scopes?.isNotEmpty == true) {
            flow.scopes.clear();
            flow.scopes.addAll(element.scopes!);
          }

          final redirectUri =
              element.redirectUri ?? 'paperback://${source.id}-login';
          final redirectParsed = Uri.parse(redirectUri);
          flow.redirectUri = redirectParsed;

          final authUrl = flow.authenticationUri;

          PBLinkDelegate().addHandler(redirectParsed.host, (
            context,
            state,
            router,
          ) async {
            PBLinkDelegate().removeHandler(redirectParsed.host);
            return Block.then(() async {
              await showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return HookConsumer(
                    builder: (context, ref, child) {
                      useEffect(() {
                        void process() async {
                          try {
                            final cred = await flow.callback(
                              state.uri.queryParameters,
                            );
                            final tokenResp = await cred.getTokenResponse();

                            await ref
                                .read(
                                  extensionSourceProvider(source.id).notifier,
                                )
                                .callBinding(element.onSuccess, [
                                  tokenResp.refreshToken ?? '',
                                  tokenResp.accessToken ?? '',
                                ]);

                            if (context.mounted) {
                              ScaffoldMessenger.of(context)
                                ..removeCurrentSnackBar()
                                ..showSnackBar(
                                  SnackBar(
                                    content: Text(context.t.auth.loginSuccess),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                              Navigator.of(context).pop();
                            }
                          } catch (e) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context)
                                ..removeCurrentSnackBar()
                                ..showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      context.t.auth.loginFailed(
                                        error: e.toString(),
                                      ),
                                    ),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              Navigator.of(context).pop();
                            }
                          }
                        }

                        process();
                        return null;
                      }, []);

                      return AlertDialog(
                        content: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const CircularProgressIndicator(),
                            const SizedBox(width: 16),
                            Text(context.t.auth.loggingIn),
                          ],
                        ),
                      );
                    },
                  );
                },
              );
            });
          });

          await launchUrl(authUrl, mode: LaunchMode.externalApplication);
        },
      ),
    );
  }
}

Future<void> _safeCallBinding(
  BuildContext context,
  WidgetRef ref,
  String sourceId,
  String bindingId, [
  List<dynamic> args = const [],
]) async {
  try {
    await ref
        .read(extensionSourceProvider(sourceId).notifier)
        .callBinding(bindingId, args);
  } on FormConfirmationException catch (e) {
    if (!context.mounted) return;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm'),
        content: Text(e.message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
    if (confirmed == true && context.mounted) {
      await _safeCallBinding(context, ref, sourceId, e.onConfirmation, []);
    }
  }
}
