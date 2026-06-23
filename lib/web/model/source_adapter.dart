import 'package:dio/dio.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/util/exception.dart';
import 'package:gagaku/web/model/extension_runtime.dart';
import 'package:gagaku/web/model/types.dart';

abstract interface class WebSourceTransport {
  Future<Response<dynamic>> getUri(Uri uri, {bool followRedirects = true});
}

abstract interface class WebSourceAdapter<R extends WebSeriesRef> {
  Future<WebManga?> fetchManga(R series);
}

class ExtensionWebSourceAdapter
    implements WebSourceAdapter<ExtensionSeriesRef> {
  ExtensionWebSourceAdapter({
    required Future<WebManga?> Function(String sourceId, String mangaId)
    fetchManga,
    required Future<ExtensionChapterPages> Function(
      String sourceId,
      Chapter chapter,
    )
    fetchChapterPages,
  }) : _fetchManga = fetchManga,
       _fetchChapterPages = fetchChapterPages;

  final Future<WebManga?> Function(String sourceId, String mangaId) _fetchManga;
  final Future<ExtensionChapterPages> Function(String sourceId, Chapter chapter)
  _fetchChapterPages;

  @override
  Future<WebManga?> fetchManga(ExtensionSeriesRef series) {
    return _fetchManga(series.sourceId, series.mangaId);
  }

  Future<ExtensionChapterPages> fetchChapterPages(
    ExtensionSeriesRef series,
    Chapter chapter,
  ) {
    return _fetchChapterPages(series.sourceId, chapter);
  }
}

class ExtensionChapterPages {
  const ExtensionChapterPages({required this.runtime, required this.links});

  final ExtensionRuntime runtime;
  final List<String> links;
}

class ProxyWebSourceAdapter implements WebSourceAdapter<ProxySeriesRef> {
  ProxyWebSourceAdapter({required WebSourceTransport transport})
    : _transport = transport;

  final WebSourceTransport _transport;

  static const _cubariApiBase = 'https://cubari.moe/read/api';

  @override
  Future<WebManga?> fetchManga(ProxySeriesRef series) async {
    final url = '$_cubariApiBase/${series.proxyId}/series/${series.seriesId}/';
    final response = await _transport.getUri(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = Map<String, dynamic>.from(response.data as Map);
      data['source_type'] = 'cubari';
      return WebManga.fromJson(data);
    }

    logger.d(
      'Failed to download manga data.\n'
      'Server returned response code ${response.statusCode}: '
      '${response.statusMessage}',
    );
    return null;
  }

  Future<dynamic> fetchApiPath(String path) async {
    final response = await _transport.getUri(
      Uri.parse('https://cubari.moe$path'),
    );

    if (response.statusCode == 200) {
      return response.data;
    }

    throw ApiException(
      message: 'Failed to download API data',
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
    );
  }
}
