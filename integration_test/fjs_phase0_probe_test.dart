import 'dart:convert';

import 'package:fjs/fjs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('fjs phase 0 runtime and bridge probe', () async {
    await LibFjs.init();

    final engine = await JsEngine.create(builtins: JsBuiltinOptions.all());
    await engine.init(
      bridge: (value) async {
        return JsResult.ok(
          JsValue.from({
            'receivedType': value.typeName(),
            'received': value.value,
            'dartBytes': Uint8List.fromList([9, 8, 7]),
          }),
        );
      },
    );

    try {
      final result = await engine.eval(
        source: const JsCode.code(r'''
          const bridgeResult = await fjs.bridge_call({
            action: "phase0",
            message: "hello from JS",
            jsBytes: new Uint8Array([1, 2, 3, 4])
          });

          const encoded = new TextEncoder().encode("abc");
          const response = new Response(new Uint8Array([5, 6, 7]));
          const responseBytes = new Uint8Array(await response.arrayBuffer());

          ({
            bridgeResult,
            builtins: {
              fetch: typeof fetch,
              setTimeout: typeof setTimeout,
              clearTimeout: typeof clearTimeout,
              TextEncoder: typeof TextEncoder,
              TextDecoder: typeof TextDecoder,
              atob: typeof atob,
              btoa: typeof btoa,
              URL: typeof URL,
              Headers: typeof Headers,
              FormData: typeof FormData,
              Blob: typeof Blob,
              Response: typeof Response
            },
            encoded: Array.from(encoded),
            base64: btoa("ok"),
            decoded: atob("b2s="),
            responseBytes: Array.from(responseBytes)
          })
        '''),
        options: JsEvalOptions.withPromise(),
      );

      final modules = await engine.getAvailableModules();
      debugPrint(const JsonEncoder.withIndent('  ').convert(result.value));
      debugPrint('availableModules=${modules.length}');
      debugPrint(modules.take(40).join(','));

      expect(result.value, isA<Map>());
    } finally {
      await engine.close();
    }
  });
}
