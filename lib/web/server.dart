import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/util/http.dart';
import 'package:path/path.dart' as p;
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart' as shelf_router;
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';

Codec<String, String> b64 = utf8.fuse(base64Url);

const _unwantedHeaders = ['set-cookie'];
const port = 8527;
const host = '127.0.0.1';

Future<void> runExtensionHostServer() async {
  final cascade = Cascade().add(_assetHandler).add(_router.call);

  final server = await shelf_io.serve(
    logRequests().addHandler(cascade.handler),
    host,
    port,
  );

  logger.i('Serving at http://${server.address.host}:${server.port}');
}

final _assetHandler = createAssetHandler(
  rootPath: 'assets/extensionhost/',
  defaultDocument: 'index.html',
);

final _router = shelf_router.Router()..get('/proxy/<url|.*>', _proxyHandler);

Future<Response> _proxyHandler(Request request, String url) async {
  final norm = base64Url.normalize(url);
  final uri = b64.decode(norm);

  debugPrint('Proxying: $uri');

  final nonNullClient = baseGagakuClient;

  final requestUrl = Uri.parse(uri);
  final clientRequest =
      http.StreamedRequest(request.method, requestUrl)
        ..followRedirects = false
        ..headers.addAll(request.headers)
        ..headers['Host'] = requestUrl.authority;

  request
      .read()
      .forEach(clientRequest.sink.add)
      .catchError(clientRequest.sink.addError)
      .whenComplete(clientRequest.sink.close)
      .ignore();
  final clientResponse = await nonNullClient.send(clientRequest);

  /// TODO: remove for pb0.9
  for (final hed in _unwantedHeaders) {
    clientResponse.headers.remove(hed);
  }

  // Remove the transfer-encoding since the body has already been decoded by
  // [client].
  clientResponse.headers.remove('transfer-encoding');

  // If the original response was gzipped, it will be decoded by [client]
  // and we'll have no way of knowing its actual content-length.
  if (clientResponse.headers['content-encoding'] == 'gzip') {
    clientResponse.headers.remove('content-encoding');
    clientResponse.headers.remove('content-length');
  }

  // Make sure the Location header is pointing to the proxy server rather
  // than the destination server, if possible.
  if (clientResponse.isRedirect &&
      clientResponse.headers.containsKey('location')) {
    final encoded = b64.encode(clientResponse.headers['location']!);
    final location = 'http://$host:$port/proxy/$encoded';

    clientResponse.headers['location'] = location;
  }

  return Response(
    clientResponse.statusCode,
    body: clientResponse.stream,
    headers: clientResponse.headers,
  );
}

final _defaultMimeTypeResolver = MimeTypeResolver();

Handler createAssetHandler({
  String? defaultDocument,
  String rootPath = 'assets',
  MimeTypeResolver? contentTypeResolver,
}) {
  final mimeResolver = contentTypeResolver ?? _defaultMimeTypeResolver;

  return (Request request) async {
    final segments = [rootPath, ...request.url.pathSegments];

    String key = p.joinAll(segments);

    Uint8List? body;

    body = await _loadResource(key);

    if (body == null && defaultDocument != null) {
      key = p.join(key, defaultDocument);

      body = await _loadResource(key);
    }

    if (body == null) {
      return Response.notFound('Not Found');
    }

    final contentType = mimeResolver.lookup(key);

    final headers = {
      HttpHeaders.contentLengthHeader: '${body.length}',
      if (contentType != null) HttpHeaders.contentTypeHeader: contentType,
    };

    return Response.ok(
      (request.method == 'HEAD') ? null : body,
      headers: headers,
    );
  };
}

Future<Uint8List?> _loadResource(String key) async {
  try {
    final byteData = await rootBundle.load(key);

    return byteData.buffer.asUint8List();
  } catch (_) {}

  return null;
}
