import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gagaku/web/model/fjs_extension_runtime.dart';
import 'package:gagaku/web/model/types.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('fjs runtime bootstraps the extension host and source body', () async {
    dynamic storedState;
    dynamic storedSecureState;
    var decodeImageRequests = 0;
    final receivedRequests = <Map<String, String?>>[];
    final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    addTearDown(() => server.close(force: true));
    server.listen((request) async {
      if (request.uri.path == '/decode-image') {
        decodeImageRequests++;
        await utf8.decoder.bind(request).join();
        request.response
          ..statusCode = 200
          ..headers.contentType = ContentType.json
          ..write(
            jsonEncode({
              'width': 1,
              'height': 1,
              'pixels': base64Encode([11, 22, 33, 255]),
            }),
          );
        await request.response.close();
        return;
      }

      if (request.uri.path == '/phase5') {
        request.response
          ..statusCode = 200
          ..headers.contentType = ContentType.binary
          ..add([1, 2, 3]);
        await request.response.close();
        return;
      }

      if (request.uri.path == '/phase4') {
        final body = await utf8.decoder.bind(request).join();
        receivedRequests.add({
          'method': request.method,
          'x-phase': request.headers.value('x-phase'),
          'cookie': request.headers.value(HttpHeaders.cookieHeader),
          'body': body,
        });

        request.response
          ..statusCode = 201
          ..headers.contentType = ContentType.html
          ..headers.set('x-phase-response', 'native')
          ..cookies.add(
            Cookie('phase4', 'cookie-value')
              ..path = '/'
              ..expires = DateTime.now().add(const Duration(hours: 1)),
          )
          ..write('<html>phase4:$body</html>');
        await request.response.close();
        return;
      }

      request.response
        ..statusCode = 200
        ..headers.contentType = ContentType.html
        ..cookies.add(
          Cookie('cf_clearance', 'startup-clearance')
            ..path = '/'
            ..expires = DateTime.now().add(const Duration(hours: 1)),
        )
        ..write('<html>startup</html>');
      await request.response.close();
    });

    final runtime = FjsExtensionRuntime(
      sourceId: 'phase2source',
      extensionHost: await rootBundle.loadString(
        'assets/extensionhost/bundle.js',
      ),
      onResetAllState: (_) {},
      onSetExtensionState: (_, state) {
        final typedState = state as Map<String, dynamic>;
        jsonEncode(typedState);
        storedState = typedState;
      },
      onSetExtensionSecureState: (_, state) {
        final typedState = state as Map<String, dynamic>;
        jsonEncode(typedState);
        storedSecureState = typedState;
      },
      getExtensionState: (_) => {'existing': 'state'},
      getExtensionSecureState: (_) => {'existing': 'secure-state'},
    );

    addTearDown(runtime.dispose);

    await runtime.init(
      WebSourceInfo(
        id: 'phase2source',
        name: 'Phase 2 Source',
        repo: 'phase2',
        baseUrl: 'http://127.0.0.1:${server.port}/',
        icon: '',
        capabilities: const [
          SourceIntents.mangaChapters,
          SourceIntents.mangaSearch,
          SourceIntents.settingsUI,
          SourceIntents.cloudflareBypassRequired,
        ],
      ),
      r'''
globalThis.source ??= {};
let savedCloudflareCookies = [];
const settingsForm = {
  requiresExplicitSubmission: true,
  formWillAppear: () => {
    Application.setState("appeared", "phase2-appeared");
  },
  getSections: () => [],
  formDidSubmit: async () => {
    Application.setState("submitted", "phase2-submitted");
  },
  getSearchQueryMetadata: async () => ({ from: "settings" })
};

const bindingTarget = {
  run: async (value) => ({
    value,
    initialized: Application.getState("phase2")
  })
};

globalThis.phase2BindingId = Application.Selector(bindingTarget, "run");
globalThis.phase7EphemeralBindingId = (() => {
  const target = {
    run: async () => "retained"
  };

  return Application.Selector(target, "run");
})();

const requestInterceptorTarget = {
  run: async (request) => {
    Application.setState("yes", "phase4RequestSeen");
    return {
      ...request,
      headers: {
        ...(request.headers ?? {}),
        "X-Phase": "intercepted"
      }
    };
  }
};

const responseInterceptorTarget = {
  run: async (request, response, body) => {
    if (request.url.includes("/phase5")) {
      const bytes = new Uint8Array(body);
      return new Uint8Array([7, ...bytes, 9]).buffer;
    }

    const text = Application.arrayBufferToUTF8String(body);
    Application.setState(`${response.status}:${text}`, "phase4ResponseSeen");
    return new TextEncoder().encode(`${text}::intercepted`).buffer;
  }
};

const requestBindingTarget = {
  run: async (url) => {
    const [response, body] = await Application.scheduleRequest({
      url,
      method: "POST",
      headers: { "X-Phase": "original" },
      cookies: { session: "abc" },
      body: "hello from fjs"
    });

    return {
      url: response.url,
      status: response.status,
      headers: response.headers,
      cookies: response.cookies.map((cookie) => ({
        name: cookie.name,
        value: cookie.value,
        domain: cookie.domain,
        path: cookie.path,
        expires: cookie.expires?.toISOString?.() ?? String(cookie.expires)
      })),
      text: Application.arrayBufferToUTF8String(body),
      requestSeen: Application.getState("phase4RequestSeen"),
      responseSeen: Application.getState("phase4ResponseSeen")
    };
  }
};

globalThis.phase4RequestBindingId =
  Application.Selector(requestBindingTarget, "run");

const executeInWebViewBindingTarget = {
  run: async () => {
    return await Application.executeInWebView({
      source: {
        html: "<html><body><span id=\"value\">from-dom</span></body></html>",
        baseUrl: "https://phase6.example/",
        loadCSS: false,
        loadImages: false
      },
      inject: `
        document.cookie = "phase6_out=out; path=/";
        return {
          text: document.querySelector("#value").textContent,
          cookie: document.cookie
        };
      `,
      storage: {
        cookies: [
          {
            name: "phase6_in",
            value: "in",
            domain: "phase6.example",
            path: "/",
            expires: new Date(Date.now() + 60_000).toISOString()
          }
        ]
      }
    });
  }
};

globalThis.phase6ExecuteBindingId =
  Application.Selector(executeInWebViewBindingTarget, "run");

globalThis.source.phase2source = {
  initialise: async () => {
    Application.setState("initialized", "phase2");
    Application.setState(
      savedCloudflareCookies.some((cookie) => cookie.name === "cf_clearance"),
      "phase6CloudflareSavedBeforeInit"
    );
    Application.setState(
      savedCloudflareCookies.map((cookie) => cookie.name).join(","),
      "phase6CloudflareCookieNames"
    );
    Application.setSecureState("secure-initialized", "phase2");
    Application.setState(
      { nested: [new Date("2026-05-30T12:34:56.789Z")] },
      "phase7DateState"
    );
    Application.setState(
      { nullable: null, omitted: undefined },
      "phase7BridgeState"
    );
    Application.setSecureState(
      new Date("2026-05-30T12:34:56.789Z"),
      "phase7SecureDateState"
    );
    Application.registerInterceptor(
      "phase4",
      Application.Selector(requestInterceptorTarget, "run"),
      Application.Selector(responseInterceptorTarget, "run")
    );
  },
  saveCloudflareBypassCookies: async (cookies) => {
    savedCloudflareCookies = cookies;
  },
  getSettingsForm: async () => settingsForm,
  getAdvancedSearchForm: async () => ({}),
  getSortingOptions: async () => [],
  getMangaDetails: async (mangaId) => ({
    mangaId,
    mangaInfo: {
      thumbnailUrl: "https://example.com/cover.jpg",
      synopsis: "Phase 7 manga details",
      primaryTitle: "Phase 7 Manga",
      secondaryTitles: ["Phase 7 Manga"],
      contentRating: "SAFE",
      status: undefined,
      artist: null
    }
  }),
  getChapters: async (sourceManga) => [
    {
      chapterId: "chapter-2",
      sourceManga,
      langCode: "en",
      chapNum: 2,
      title: undefined,
      publishDate: new Date("2026-05-29T12:34:56.789Z")
    },
    {
      chapterId: "chapter-10",
      sourceManga,
      langCode: "en",
      chapNum: 10,
      publishDate: new Date("2026-05-30T12:34:56.789Z")
    }
  ],
  getChapterDetails: async (chapter) => ({
    id: chapter.chapterId,
    mangaId: chapter.sourceManga.mangaId,
    pages: [
      `https://example.com/${chapter.chapterId}/1.jpg`,
      `https://example.com/${chapter.chapterId}/2.jpg`
    ]
  })
};
''',
    );

    expect(FjsExtensionRuntime.activeRuntimeCount, 1);
    expect(runtime.hasAdvancedSearchForm, true);
    expect(runtime.hasSortOps, true);
    expect(storedState, {
      'existing': 'state',
      'phase2': 'initialized',
      'phase6CloudflareSavedBeforeInit': true,
      'phase6CloudflareCookieNames': 'cf_clearance',
      'phase7DateState': {
        'nested': ['2026-05-30T12:34:56.789Z'],
      },
      'phase7BridgeState': {'nullable': null},
    });
    expect(storedSecureState, {
      'existing': 'secure-state',
      'phase2': 'secure-initialized',
      'phase7SecureDateState': '2026-05-30T12:34:56.789Z',
    });
    expect(storedState['phase7DateState'], isA<Map<String, dynamic>>());
    expect(
      runtime.getCookies(),
      contains(
        isA<Object>().having(
          (cookie) => (cookie as dynamic).name,
          'name',
          'cf_clearance',
        ),
      ),
    );

    final firstScopedEval = await runtime.evalForForm(
      'const scopedValue = "first"; return scopedValue;',
    );
    final secondScopedEval = await runtime.evalForForm(
      'const scopedValue = "second"; return scopedValue;',
    );
    expect(firstScopedEval.value, 'first');
    expect(secondScopedEval.value, 'second');
    expect(await runtime.evalForTesting('typeof scopedValue'), 'undefined');
    expect(
      await runtime.evalForTesting(
        r'JSON.stringify({ text: "\ud800", omitted: undefined, items: [undefined] })',
      ),
      r'{"text":"\ud800","items":[null]}',
    );
    expect(
      await runtime.evalForTesting('typeof globalThis.__gagaku_json_stringify'),
      'undefined',
    );
    await runtime.evalForTesting(
      'globalThis.__gagaku_proxy_port = ${server.port}',
    );
    expect(
      await runtime.evalForTesting(r'''
(async () => {
  console.log("phase7 console bridge", { nested: true });
  const image = new Image();
  await new Promise((resolve, reject) => {
    image.onload = resolve;
    image.onerror = reject;
    image.src = "data:image/png;base64,AQID";
  });
  const canvas = new HTMLCanvasElement();
  canvas.width = 1;
  canvas.height = 1;
  const context = canvas.getContext("2d");
  context.drawImage(image, 0, 0);
  return {
    pixels: Array.from(context.getImageData(0, 0, 1, 1).data),
    dataUrl: canvas.toDataURL().startsWith("data:image/png;base64,"),
    imageDataLength: new ImageData(1, 1).data.length
  };
})()
'''),
      {
        'pixels': [11, 22, 33, 255],
        'dataUrl': true,
        'imageDataLength': 4,
      },
    );
    expect(decodeImageRequests, 1);

    final bindingId = await runtime.evalForTesting(
      'globalThis.phase2BindingId',
    );
    final bindingResult = await runtime.callBinding(bindingId, ['from-dart']);
    expect(bindingResult, {'value': 'from-dart', 'initialized': 'initialized'});

    final ephemeralBindingId = await runtime.evalForTesting(
      'globalThis.phase7EphemeralBindingId',
    );
    expect(await runtime.callBinding(ephemeralBindingId), 'retained');

    final form = await runtime.getSettingsForm(
      WebSourceInfo(
        id: 'phase2source',
        name: 'Phase 2 Source',
        repo: 'phase2',
        baseUrl: 'https://example.com',
        icon: '',
        capabilities: const [SourceIntents.settingsUI],
      ),
    );
    expect(await form.sections, isEmpty);
    expect(form.requiresExplicitSubmission, true);
    await form.formDidSubmit();
    expect(await form.getSearchQueryMetadata(), {'from': 'settings'});
    expect(storedState, {
      'existing': 'state',
      'phase2': 'initialized',
      'phase6CloudflareSavedBeforeInit': true,
      'phase6CloudflareCookieNames': 'cf_clearance',
      'phase7DateState': {
        'nested': ['2026-05-30T12:34:56.789Z'],
      },
      'phase7BridgeState': {'nullable': null},
      'phase2-appeared': 'appeared',
      'phase2-submitted': 'submitted',
    });

    final requestBindingId = await runtime.evalForTesting(
      'globalThis.phase4RequestBindingId',
    );
    final requestResult = await runtime.callBinding(requestBindingId, [
      'http://127.0.0.1:${server.port}/phase4',
    ]);

    expect(receivedRequests, hasLength(1));
    expect(receivedRequests.single['method'], 'POST');
    expect(receivedRequests.single['x-phase'], 'intercepted');
    expect(receivedRequests.single['cookie'], contains('session=abc'));
    expect(receivedRequests.single['body'], 'hello from fjs');
    expect(requestResult['status'], 201);
    expect(
      requestResult['headers'],
      containsPair('x-phase-response', 'native'),
    );
    expect(
      requestResult['text'],
      '<html>phase4:hello from fjs</html>::intercepted',
    );
    expect(requestResult['requestSeen'], 'yes');
    expect(
      requestResult['responseSeen'],
      '201:<html>phase4:hello from fjs</html>',
    );
    expect(
      requestResult['cookies'],
      contains(
        isA<Map>()
            .having((cookie) => cookie['name'], 'name', 'phase4')
            .having((cookie) => cookie['value'], 'value', 'cookie-value'),
      ),
    );

    final imageBytes = await runtime.processImageRequest(
      'http://127.0.0.1:${server.port}/phase5',
    );
    expect(imageBytes, Uint8List.fromList([7, 1, 2, 3, 9]));

    final executeBindingId = await runtime.evalForTesting(
      'globalThis.phase6ExecuteBindingId',
    );
    final executeResult = await runtime.callBinding(executeBindingId);
    expect(executeResult['result']['text'], 'from-dom');
    expect(executeResult['result']['cookie'], contains('phase6_in=in'));
    expect(executeResult['result']['cookie'], contains('phase6_out=out'));
    expect(
      executeResult['storage']['cookies'],
      contains(
        isA<Map>()
            .having((cookie) => cookie['name'], 'name', 'phase6_out')
            .having((cookie) => cookie['value'], 'value', 'out'),
      ),
    );

    final manga = await runtime.getManga('phase7-manga');
    expect(manga, isA<WebMangaExtension>());
    expect(manga!.title, 'Phase 7 Manga');
    final chapters = (manga as WebMangaExtension).chaptersList;
    expect(chapters.map((chapter) => chapter.chapterId), [
      'chapter-10',
      'chapter-2',
    ]);
    expect(
      chapters.first.publishDate,
      DateTime.parse('2026-05-30T12:34:56.789Z'),
    );
    expect(await runtime.getChapterPages(chapters.first), [
      'https://example.com/chapter-10/1.jpg',
      'https://example.com/chapter-10/2.jpg',
    ]);

    await FjsExtensionRuntime.disposeAll();
    expect(FjsExtensionRuntime.activeRuntimeCount, 0);
  });
}
