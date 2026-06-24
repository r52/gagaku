import 'package:gagaku/log.dart';
import 'package:gagaku/web/model/types.dart';

abstract interface class WebLinkRedirectTransport {
  Future<Uri?> resolveRedirect(Uri uri);
}

class WebLinkResolver {
  WebLinkResolver({
    required Future<bool> Function(String sourceId) extensionExists,
    required WebLinkRedirectTransport redirectTransport,
  }) : _extensionExists = extensionExists,
       _redirectTransport = redirectTransport;

  final Future<bool> Function(String sourceId) _extensionExists;
  final WebLinkRedirectTransport _redirectTransport;

  static const _imgurHost = 'imgur.com';
  static const _cubariHost = 'cubari.moe';

  Future<ResolvedWebLink?> resolve(String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) {
      return null;
    }

    if (uri.host == _imgurHost) {
      return _resolveImgur(uri);
    }

    if (uri.host == _cubariHost) {
      return _resolveCubari(uri);
    }

    return _resolveExtension(uri);
  }

  Future<HistoryLink> resolveHistoryLink(HistoryLink link) async {
    if (link.series != null) {
      return link;
    }

    final resolved = await resolve(link.url);
    if (resolved == null) {
      logger.w('Failed to process url ${link.url}');
      return link;
    }

    return link.copyWith(series: resolved.series);
  }

  ResolvedWebLink? _resolveImgur(Uri uri) {
    final parts = uri.pathSegments.where((part) => part.isNotEmpty).toList();
    if (parts.length != 2 || parts.first != 'a') {
      return null;
    }

    return ResolvedWebLink(
      series: WebSeriesRef.proxy(proxyId: 'imgur', seriesId: parts[1]),
      initialChapterId: '1',
    );
  }

  Future<ResolvedWebLink?> _resolveCubari(Uri uri) async {
    if (!_isCubariReadPath(uri)) {
      final redirect = await _redirectTransport.resolveRedirect(uri);
      if (redirect == null ||
          (redirect.hasAuthority && redirect.host != _cubariHost) ||
          !_isCubariReadPath(redirect)) {
        return null;
      }
      uri = redirect;
    }

    final parts = uri.pathSegments.where((part) => part.isNotEmpty).toList();
    if (parts.length < 3) {
      return null;
    }

    return ResolvedWebLink(
      series: WebSeriesRef.proxy(proxyId: parts[1], seriesId: parts[2]),
      initialChapterId: parts.length >= 4 ? parts[3] : null,
    );
  }

  bool _isCubariReadPath(Uri uri) {
    final parts = uri.pathSegments.where((part) => part.isNotEmpty).toList();
    return parts.length >= 3 && parts.first == 'read';
  }

  Future<ResolvedWebLink?> _resolveExtension(Uri uri) async {
    if (uri.hasAuthority) {
      return null;
    }

    final parts = uri.pathSegments.where((part) => part.isNotEmpty).toList();
    if (parts.length != 2) {
      logger.w('Invalid extension url ${uri.toString()}');
      return null;
    }

    final sourceId = parts[0];
    if (!await _extensionExists(sourceId)) {
      logger.w('Extension not found. url: ${uri.toString()}');
      return null;
    }

    return ResolvedWebLink(
      series: WebSeriesRef.extension(sourceId: sourceId, mangaId: parts[1]),
    );
  }
}
