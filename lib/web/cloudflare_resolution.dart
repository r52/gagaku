import 'package:flutter/material.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/util/ui.dart';
import 'package:gagaku/web/extension_browser.dart';
import 'package:gagaku/web/model/cloudflare.dart';
import 'package:gagaku/web/model/model.dart';
import 'package:gagaku/web/model/types.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<bool> resolveExtensionCloudflare(
  BuildContext context,
  WidgetRef ref,
  WebSourceInfo source,
) async {
  final browserState = await Navigator.of(context).push<CloudflareBrowserState>(
    SlideTransitionRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          ExtensionBrowserPage(source: source, cloudflareResolution: true),
    ),
  );
  if (browserState == null || !context.mounted) {
    return false;
  }

  // Let the visible platform view finish route teardown before a new runtime
  // consumes the browser state and starts extension work.
  await WidgetsBinding.instance.endOfFrame;
  if (!context.mounted) {
    return false;
  }

  ref
      .read(cloudflareBrowserStatesProvider.notifier)
      .stage(source.id, browserState);

  ref.invalidate(extensionSourceProvider(source.id), asReload: true);
  try {
    await ref.read(extensionSourceProvider(source.id).future);
    return true;
  } catch (_) {
    return false;
  }
}

class CloudflareResolutionButton extends ConsumerStatefulWidget {
  const CloudflareResolutionButton({
    super.key,
    required this.source,
    this.compact = false,
    this.onResolved,
  });

  final WebSourceInfo source;
  final bool compact;
  final VoidCallback? onResolved;

  @override
  ConsumerState<CloudflareResolutionButton> createState() =>
      _CloudflareResolutionButtonState();
}

class _CloudflareResolutionButtonState
    extends ConsumerState<CloudflareResolutionButton> {
  bool _resolving = false;

  Future<void> _resolve() async {
    if (_resolving) {
      return;
    }

    setState(() => _resolving = true);
    final resolved = await resolveExtensionCloudflare(
      context,
      ref,
      widget.source,
    );
    if (!mounted) {
      return;
    }
    setState(() => _resolving = false);
    if (resolved) {
      widget.onResolved?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    final tr = context.t;
    if (widget.compact) {
      return IconButton(
        icon: _resolving
            ? const SizedBox.square(
                dimension: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : const Icon(Icons.security),
        tooltip: tr.webSources.source.cloudflareResolve,
        onPressed: _resolving ? null : _resolve,
      );
    }

    return FilledButton.icon(
      icon: _resolving
          ? const SizedBox.square(
              dimension: 18,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : const Icon(Icons.security),
      label: Text(tr.webSources.source.cloudflareResolve),
      onPressed: _resolving ? null : _resolve,
    );
  }
}
