import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/model/model.dart';
import 'package:gagaku/web/model/types.dart';

class ExtensionBrowserPage extends StatefulWidget {
  ExtensionBrowserPage({super.key, required this.source})
    : assert(source.baseUrl != null && source.baseUrl!.isNotEmpty);

  final WebSourceInfo source;

  @override
  State<ExtensionBrowserPage> createState() => _ExtensionBrowserPageState();
}

class _ExtensionBrowserPageState extends State<ExtensionBrowserPage> {
  InAppWebViewController? _controller;
  double _progress = 0;
  late String _currentUrl;
  late final InAppWebViewSettings _webViewSettings;

  @override
  void initState() {
    super.initState();
    _currentUrl = widget.source.baseUrl!;
    _webViewSettings = _createSettings();
  }

  InAppWebViewSettings _createSettings() {
    final contentBlockers = <ContentBlocker>[];
    if (defaultTargetPlatform == TargetPlatform.android) {
      for (final filter in GagakuData().blockers) {
        contentBlockers.add(
          ContentBlocker(
            trigger: ContentBlockerTrigger(urlFilter: filter),
            action: ContentBlockerAction(type: ContentBlockerActionType.BLOCK),
          ),
        );
      }
    }

    return InAppWebViewSettings(
      contentBlockers: contentBlockers.isEmpty ? null : contentBlockers,
      browserAcceleratorKeysEnabled: false,
      isInspectable: false,
    );
  }

  void _updateUrl(WebUri? url) {
    if (url == null || !mounted) {
      return;
    }

    setState(() {
      _currentUrl = url.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    final tr = context.t;

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.source.name, overflow: TextOverflow.ellipsis),
            Text(
              _currentUrl,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: tr.webSources.source.reloadWebsite,
            onPressed: () => _controller?.reload(),
          ),
        ],
      ),
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(url: WebUri(widget.source.baseUrl!)),
            initialSettings: _webViewSettings,
            onWebViewCreated: (controller) {
              _controller = controller;
            },
            onLoadStart: (controller, url) => _updateUrl(url),
            onLoadStop: (controller, url) => _updateUrl(url),
            onUpdateVisitedHistory: (controller, url, isReload) {
              _updateUrl(url);
            },
            onProgressChanged: (controller, progress) {
              if (!mounted) {
                return;
              }
              setState(() {
                _progress = progress / 100;
              });
            },
          ),
          if (_progress < 1)
            Align(
              alignment: Alignment.topCenter,
              child: LinearProgressIndicator(
                value: _progress == 0 ? null : _progress,
                minHeight: 2,
              ),
            ),
        ],
      ),
    );
  }
}
