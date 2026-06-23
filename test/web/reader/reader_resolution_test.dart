import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gagaku/model/cache.dart';
import 'package:gagaku/web/model/model.dart';
import 'package:gagaku/web/model/source_adapter.dart';
import 'package:gagaku/web/model/types.dart';
import 'package:gagaku/web/reader.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  test('direct Imgur ingress resolves typed pages and releases them', () async {
    final transport = _StaticTransport([
      {'description': 'Page 1', 'src': 'https://example.com/1.jpg'},
      {'description': 'Page 2', 'src': 'https://example.com/2.jpg'},
    ]);
    final broker = WebSourceBroker(
      cache: _MemoryCacheManager(),
      proxyAdapter: ProxyWebSourceAdapter(transport: transport),
      extensionAdapter: ExtensionWebSourceAdapter(
        fetchManga: (_, _) => throw UnimplementedError(),
        fetchChapterPages: (_, _) => throw UnimplementedError(),
      ),
    );
    final container = ProviderContainer(
      overrides: [webSourceBrokerProvider.overrideWithValue(broker)],
    );
    final chapter = const WebChapterRef(
      series: WebSeriesRef.proxy(proxyId: 'imgur', seriesId: 'album-1'),
      chapterId: '1',
    );

    final resolved = await container.read(
      resolveWebChapterProvider(chapter).future,
    );

    expect(resolved.chapter, chapter);
    expect(resolved.title, 'album-1');
    expect(resolved.seriesTitle, isNull);
    expect(resolved.readMarkerKey, '1');
    expect(resolved.pages.map((page) => (page.provider as NetworkImage).url), [
      'https://example.com/1.jpg',
      'https://example.com/2.jpg',
    ]);
    expect(
      transport.requested,
      Uri.parse('https://cubari.moe/read/api/imgur/chapter/album-1'),
    );

    container.dispose();
    expect(resolved.pages, isEmpty);
  });
}

class _StaticTransport implements WebSourceTransport {
  _StaticTransport(this.data);

  final Object data;
  Uri? requested;

  @override
  Future<Response<dynamic>> getUri(
    Uri uri, {
    bool followRedirects = true,
  }) async {
    requested = uri;
    return Response<dynamic>(
      requestOptions: RequestOptions(path: uri.toString()),
      statusCode: 200,
      data: data,
    );
  }
}

class _MemoryCacheManager implements CacheManager {
  final Map<String, Object?> values = {};

  @override
  Future<bool> exists(String key) async => values.containsKey(key);

  @override
  T get<T>(String key, [UnserializeCallback? unserializer]) => values[key] as T;

  @override
  Future<T> put<T>(
    String key,
    String data,
    T reference, {
    Duration expiry = const Duration(minutes: 15),
    UnserializeCallback? unserializer,
  }) async {
    values[key] = reference;
    return reference;
  }

  @override
  Future<void> remove(String key) async {
    values.remove(key);
  }

  @override
  Future<void> invalidateAll(String startsWith) async {
    values.removeWhere((key, _) => key.startsWith(startsWith));
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
