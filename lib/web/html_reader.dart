import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:gagaku/i18n/strings.g.dart';

class HtmlChapterReaderWidget extends StatefulWidget {
  const HtmlChapterReaderWidget({
    super.key,
    required this.html,
    required this.title,
    required this.seriesTitle,
    required this.sourceBaseUrl,
  });

  final String html;
  final String title;
  final String? seriesTitle;
  final String? sourceBaseUrl;

  @override
  State<HtmlChapterReaderWidget> createState() =>
      _HtmlChapterReaderWidgetState();
}

class _HtmlChapterReaderWidgetState extends State<HtmlChapterReaderWidget> {
  InAppWebViewController? _controller;
  double _progress = 0;
  late final InAppWebViewSettings _webViewSettings;

  @override
  void initState() {
    super.initState();
    _webViewSettings = InAppWebViewSettings(
      browserAcceleratorKeysEnabled: false,
      javaScriptEnabled: false,
      supportZoom: true,
      builtInZoomControls: false,
      displayZoomControls: false,
      isInspectable: false,
    );
  }

  WebUri? get _baseUrl {
    final sourceBaseUrl = widget.sourceBaseUrl;
    if (sourceBaseUrl == null || sourceBaseUrl.isEmpty) {
      return null;
    }

    return WebUri(sourceBaseUrl);
  }

  @override
  Widget build(BuildContext context) {
    final tr = context.t;
    final seriesTitle = widget.seriesTitle;

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.title, overflow: TextOverflow.ellipsis),
            if (seriesTitle != null && seriesTitle.isNotEmpty)
              Text(
                seriesTitle,
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
            initialData: InAppWebViewInitialData(
              data: widget.html,
              baseUrl: _baseUrl,
            ),
            initialSettings: _webViewSettings,
            onWebViewCreated: (controller) {
              _controller = controller;
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
