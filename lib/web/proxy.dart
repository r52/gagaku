import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:gagaku/log.dart';
import 'package:image/image.dart' as image;

Map<String, Object> _decodeImagePixels(Uint8List bytes) {
  final decoded = image.decodeImage(bytes);
  if (decoded == null) {
    throw const FormatException('Unsupported image format');
  }

  return {
    'width': decoded.width,
    'height': decoded.height,
    'pixels': decoded.getBytes(order: image.ChannelOrder.rgba),
  };
}

class ProxyServer {
  ProxyServer();

  HttpServer? _server;
  int? get port => _server?.port;

  final HttpClient _client = HttpClient()
    ..autoUncompress = true
    ..connectionTimeout = const Duration(seconds: 15);

  /// Maximum number of pending image completers to keep.
  ///
  /// The map only holds *in-flight* requests (between Dart registering and
  /// JS completing). In sequential reading, there's typically 1-3 concurrent
  /// requests. For bulk-loading scenarios (e.g. `Future.wait` on all pages),
  /// a higher limit prevents eviction of still-pending requests.
  static const int _maxCompleterMapSize = 200;

  /// Completers keyed by URL - created by Dart bridge methods, completed
  /// by JS POST to `/image`. The Dart side awaits `Completer.future`.
  final Map<String, Completer<Uint8List>> _imageCompleters = {};

  static const Set<String> _hopByHopRequestHeaders = {
    HttpHeaders.acceptEncodingHeader,
    HttpHeaders.connectionHeader,
    HttpHeaders.contentLengthHeader,
    HttpHeaders.hostHeader,
    HttpHeaders.transferEncodingHeader,
    'keep-alive',
    'proxy-connection',
    'te',
    'trailer',
    'upgrade',
  };

  /// Start the server. Binds to port 0 for random available port.
  Future<int> start() async {
    _server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    logger.i('Proxy server started on port ${_server!.port}');

    _server!.listen(_handleRequest);
    return _server!.port;
  }

  void _handleRequest(HttpRequest request) async {
    // CORS headers for all responses
    request.response.headers.set('Access-Control-Allow-Origin', '*');
    request.response.headers.set(
      'Access-Control-Allow-Methods',
      'GET, POST, OPTIONS',
    );
    request.response.headers.set(
      'Access-Control-Allow-Headers',
      'Content-Type',
    );

    if (request.method == 'OPTIONS') {
      await request.response.close();
      return;
    }

    final uri = request.uri;

    try {
      if (uri.path == '/fetch' && request.method == 'POST') {
        await _handleFetch(request);
      } else if (uri.path == '/image' && request.method == 'POST') {
        await _handleImagePost(request);
      } else if (uri.path == '/decode-image' && request.method == 'POST') {
        await _handleDecodeImage(request);
      } else {
        request.response.statusCode = 404;
        request.response.write('Not found');
        await request.response.close();
      }
    } catch (e, stack) {
      logger.e('Proxy request handler error', error: e, stackTrace: stack);
      request.response.statusCode = 500;
      request.response.write('Internal error: $e');
      await request.response.close();
    }
  }

  /// Handle POST /fetch - execute request via Dart HttpClient.
  ///
  /// The headers sent by the WebView (cookies, user-agent, etc.) are
  /// forwarded to the remote server via Dart's HttpClient. This is
  /// essential for bypassing Cloudflare and other anti-bot checks that
  /// validate request headers.
  Future<void> _handleFetch(HttpRequest request) async {
    final body = await utf8.decoder.bind(request).join();
    final data = jsonDecode(body) as Map<String, dynamic>;

    final url = data['url'] as String;
    final method = data['method'] as String? ?? 'GET';
    final headers = (data['headers'] as Map<String, dynamic>?)?.map(
      (k, v) => MapEntry(k, v as String),
    );
    final bodyData = data['body'] as String?;

    final client = _client;

    try {
      final uri = Uri.parse(url);
      final HttpClientRequest req;

      switch (method.toUpperCase()) {
        case 'GET':
          req = await client.getUrl(uri);
          break;
        case 'POST':
          req = await client.postUrl(uri);
          break;
        case 'PUT':
          req = await client.putUrl(uri);
          break;
        case 'DELETE':
          req = await client.deleteUrl(uri);
          break;
        case 'HEAD':
          req = await client.headUrl(uri);
          break;
        default:
          req = await client.openUrl(method.toUpperCase(), uri);
      }

      // Copy extension headers before sending, but leave transport details
      // like compression and lengths to HttpClient. Browser Accept-Encoding
      // often includes br/zstd, which dart:io cannot decode for HTML bodies.
      headers?.forEach((name, value) {
        if (!_hopByHopRequestHeaders.contains(name.toLowerCase())) {
          req.headers.set(name, value);
        }
      });

      // Set body if present (base64-encoded from JS)
      if (bodyData != null && bodyData.isNotEmpty) {
        final bytes = base64Decode(bodyData);
        req.add(bytes);
      }

      final response = await req.close();
      logger.d(
        'Proxy /fetch -> ${response.statusCode} ${uri.host}${uri.path}'
        ' (${response.contentLength} bytes)',
      );

      final responseBytes = await consolidateHttpClientResponseBytes(
        response,
        onBytesReceived: (cumulative, total) {},
      );

      // Read response headers
      final respHeaders = <String, String>{};
      response.headers.forEach((name, values) {
        respHeaders[name] = values.join(', ');
      });

      // Read cookies from response.cookies
      final cookies = <Map<String, dynamic>>[];
      for (final cookie in response.cookies) {
        cookies.add({
          'name': cookie.name,
          'value': cookie.value,
          'domain': cookie.domain ?? uri.host,
          'path': cookie.path ?? '/',
          'expires': (cookie.expires ?? DateTime.now()).toIso8601String(),
        });
      }

      final bodyB64 = base64Encode(responseBytes);

      final result = {
        'url': uri.toString(),
        'status': response.statusCode,
        'headers': respHeaders,
        'cookies': cookies,
        'body': bodyB64,
      };

      final jsonResponse = jsonEncode(result);

      request.response
        ..statusCode = 200
        ..headers.set('Content-Type', 'application/json')
        ..write(jsonResponse);
      await request.response.close();
    } catch (e) {
      logger.e('Proxy /fetch error for $url', error: e);
      request.response
        ..statusCode = 500
        ..headers.set('Content-Type', 'application/json')
        ..write(jsonEncode({'error': e.toString()}));
      await request.response.close();
    }
  }

  /// Register a pending image request and return its completer.
  ///
  /// Called by the bridge method (see Step 3). Creates a Completer keyed
  /// by the image URL. The completer is completed when JS POSTs the image
  /// data to `/image`.
  ///
  /// Returns the [Completer] that will be completed by [_handleImagePost].
  /// The caller must await [Completer.future].
  Completer<Uint8List> registerImageRequest(String url) {
    // Evict if map is full (oldest entries first - they've been waiting longest)
    if (_imageCompleters.length >= _maxCompleterMapSize) {
      final oldestKey = _imageCompleters.keys.first;
      _imageCompleters.remove(oldestKey);
      logger.d('Evicted pending image request for $oldestKey');
    }

    final completer = Completer<Uint8List>();
    _imageCompleters[url] = completer;
    logger.d('Registered pending image request for $url');
    return completer;
  }

  /// Cancel a pending image request.
  void cancelImageRequest(String url) {
    _imageCompleters.remove(url);
    logger.d('Cancelled pending image request for $url');
  }

  /// Handle POST /image - decode image data and complete the Dart-side completer.
  ///
  /// This is the signal that completes the [Completer] created by [registerImageRequest].
  Future<void> _handleImagePost(HttpRequest request) async {
    final body = await utf8.decoder.bind(request).join();
    final data = jsonDecode(body) as Map<String, dynamic>;

    final url = data['url'] as String;
    final bodyData = data['body'] as String; // base64-encoded

    final bytes = base64Decode(bodyData);

    final completer = _imageCompleters.remove(url);
    if (completer != null && !completer.isCompleted) {
      completer.complete(bytes);
      logger.d('Completed image request for $url (${bytes.length} bytes)');
    } else {
      logger.w('No pending completer for image URL: $url');
    }

    request.response
      ..statusCode = 200
      ..headers.set('Content-Type', 'application/json')
      ..write(jsonEncode({'stored': true, 'url': url}));
    await request.response.close();
  }

  /// Handle POST /decode-image - decode image bytes to RGBA pixels.
  ///
  /// Used by the extension host's Paperback canvas compatibility layer.
  Future<void> _handleDecodeImage(HttpRequest request) async {
    final body = await utf8.decoder.bind(request).join();
    final data = jsonDecode(body) as Map<String, dynamic>;
    final bodyData = data['body'] as String;

    try {
      final bytes = base64Decode(bodyData);
      final decoded = await compute(_decodeImagePixels, bytes);

      request.response
        ..statusCode = 200
        ..headers.set('Content-Type', 'application/json')
        ..write(
          jsonEncode({
            'width': decoded['width'],
            'height': decoded['height'],
            'pixels': base64Encode(decoded['pixels']! as Uint8List),
          }),
        );
      await request.response.close();
    } catch (e) {
      logger.e('Proxy /decode-image error', error: e);
      request.response
        ..statusCode = 500
        ..headers.set('Content-Type', 'application/json')
        ..write(jsonEncode({'error': e.toString()}));
      await request.response.close();
    }
  }

  /// Stop the server and cancel all pending requests.
  Future<void> stop() async {
    for (final completer in _imageCompleters.values) {
      if (!completer.isCompleted) {
        completer.completeError(Exception('Proxy server stopped'));
      }
    }
    _imageCompleters.clear();
    _client.close(force: true);
    await _server?.close(force: true);
    _server = null;
    logger.i('Proxy server stopped');
  }
}
