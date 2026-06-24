import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart'
    show CookieManager, WebUri;
import 'package:gagaku/model/model.dart';
import 'package:gagaku/util/exception.dart';
import 'package:gagaku/web/model/fjs_extension_runtime.dart';
import 'package:gagaku/web/model/types.dart';
import 'package:image/image.dart' as img;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('fjs runtime bootstraps the extension host and source body', () async {
    dynamic storedState;
    dynamic storedSecureState;
    final gdat = GagakuData();
    gdat.dynamicUserAgentHeaders = {
      'user-agent': 'Phase Test Browser/123',
      'sec-ch-ua': '"Phase Test Browser";v="123"',
      'sec-ch-ua-mobile': '?0',
      'sec-ch-ua-platform': '"Linux"',
      'sec-ch-ua-full-version-list': '"Phase Test Browser";v="123.4.5.6"',
    };
    addTearDown(() {
      gdat.dynamicUserAgentHeaders = {};
    });
    final receivedRequests = <Map<String, String?>>[];
    String? receivedFormDataContentType;
    String? receivedFormDataBody;
    String? receivedCrossOriginCookie;
    var activeImageRequests = 0;
    var maxActiveImageRequests = 0;
    final largePayload = Uint8List.fromList(
      List.generate(2 * 1024 * 1024, (index) => index % 251),
    );
    final crossOriginServer = await HttpServer.bind(
      InternetAddress.loopbackIPv4,
      0,
    );
    addTearDown(() => crossOriginServer.close(force: true));
    crossOriginServer.listen((request) async {
      receivedCrossOriginCookie = request.headers.value(
        HttpHeaders.cookieHeader,
      );
      request.response
        ..statusCode = 200
        ..headers.contentType = ContentType.text
        ..write('cross-origin');
      await request.response.close();
    });
    final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    final baseUrl = 'http://127.0.0.1:${server.port}/';
    final baseWebUri = WebUri(baseUrl);
    var startupChallengeRequests = 0;
    var startupChallengeSolved = false;
    addTearDown(() => server.close(force: true));
    addTearDown(
      () => CookieManager.instance().deleteCookie(
        url: baseWebUri,
        name: 'cf_clearance',
      ),
    );
    server.listen((request) async {
      if (request.uri.path == '/phase5') {
        request.response
          ..statusCode = 200
          ..headers.contentType = ContentType('image', 'webp')
          ..add([1, 2, 3]);
        await request.response.close();
        return;
      }

      if (request.uri.path == '/phase8-redirect') {
        request.response
          ..statusCode = HttpStatus.found
          ..headers.set(HttpHeaders.locationHeader, '/phase8-redirect-target');
        await request.response.close();
        return;
      }

      if (request.uri.path == '/phase8-redirect-target') {
        request.response
          ..statusCode = 200
          ..headers.contentType = ContentType.text
          ..write('redirected');
        await request.response.close();
        return;
      }

      if (request.uri.path == '/phase8-cross-origin-redirect') {
        request.response
          ..statusCode = HttpStatus.found
          ..headers.set(
            HttpHeaders.locationHeader,
            'http://127.0.0.1:${crossOriginServer.port}/target',
          );
        await request.response.close();
        return;
      }

      if (request.uri.path == '/phase8-gzip') {
        request.response
          ..statusCode = 200
          ..headers.contentType = ContentType.text
          ..headers.set(HttpHeaders.contentEncodingHeader, 'gzip')
          ..add(gzip.encode(utf8.encode('compressed')));
        await request.response.close();
        return;
      }

      if (request.uri.path == '/phase8-form-data') {
        receivedFormDataContentType = request.headers.value(
          HttpHeaders.contentTypeHeader,
        );
        receivedFormDataBody = await utf8.decoder.bind(request).join();
        request.response
          ..statusCode = 200
          ..headers.contentType = ContentType.text
          ..write('form-received');
        await request.response.close();
        return;
      }

      if (request.uri.path == '/phase8-large-binary') {
        request.response
          ..statusCode = 200
          ..headers.contentType = ContentType.binary
          ..add(largePayload);
        await request.response.close();
        return;
      }

      if (request.uri.path.startsWith('/phase10-serialized-image/')) {
        activeImageRequests++;
        maxActiveImageRequests = max(
          maxActiveImageRequests,
          activeImageRequests,
        );
        try {
          await Future<void>.delayed(const Duration(milliseconds: 100));
          request.response
            ..statusCode = 200
            ..headers.contentType = ContentType.binary
            ..add([int.parse(request.uri.pathSegments.last)]);
          await request.response.close();
        } finally {
          activeImageRequests--;
        }
        return;
      }

      if (request.uri.path == '/phase4') {
        final body = await utf8.decoder.bind(request).join();
        receivedRequests.add({
          'method': request.method,
          'x-phase': request.headers.value('x-phase'),
          'user-agent': request.headers.value(HttpHeaders.userAgentHeader),
          'sec-ch-ua': request.headers.value('sec-ch-ua'),
          'sec-ch-ua-mobile': request.headers.value('sec-ch-ua-mobile'),
          'sec-ch-ua-platform': request.headers.value('sec-ch-ua-platform'),
          'sec-ch-ua-full-version-list': request.headers.value(
            'sec-ch-ua-full-version-list',
          ),
          'origin': request.headers.value('origin'),
          'referer': request.headers.value('referer'),
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
          ..cookies.add(Cookie('phase4-session', 'session-cookie')..path = '/')
          ..headers.add(
            HttpHeaders.setCookieHeader,
            'phase4-precedence=cookie-value; Max-Age=3600; '
            'Expires=Thu, 01 Jan 1970 00:00:00 GMT; Path=/',
          )
          ..write('<html>phase4:$body</html>');
        await request.response.close();
        return;
      }

      if (request.uri.path == '/') {
        final cookie = request.headers.value(HttpHeaders.cookieHeader);
        if (request.uri.queryParameters.containsKey('__cf_chl_rt_tk')) {
          startupChallengeSolved = true;
          request.response
            ..statusCode = HttpStatus.found
            ..headers.set(HttpHeaders.locationHeader, '/')
            ..cookies.add(
              Cookie('cf_clearance', 'startup-clearance')
                ..path = '/'
                ..expires = DateTime.now().add(const Duration(hours: 1)),
            );
          await request.response.close();
          return;
        }

        if (!startupChallengeSolved &&
            cookie?.contains('cf_clearance=startup-clearance') != true) {
          startupChallengeRequests++;
          request.response
            ..statusCode = HttpStatus.found
            ..headers.set(
              HttpHeaders.locationHeader,
              '/?__cf_chl_rt_tk=startup-test',
            );
          await request.response.close();
          return;
        }
      }

      request.response
        ..statusCode = 200
        ..headers.contentType = ContentType.html
        ..write(
          '<html><title>Startup</title><script>'
          'localStorage.setItem("phase6", "startup-storage");'
          '</script>startup</html>',
        );
      await request.response.close();
    });

    await CookieManager.instance().setCookie(
      url: baseWebUri,
      name: 'cf_clearance',
      value: 'stale-clearance',
    );

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

    final source = WebSourceInfo(
      id: 'phase2source',
      name: 'Phase 2 Source',
      repo: 'phase2',
      baseUrl: baseUrl,
      icon: '',
      capabilities: const [
        SourceIntents.mangaChapters,
        SourceIntents.mangaSearch,
        SourceIntents.settingsUI,
        SourceIntents.cloudflareBypassRequired,
        SourceIntents.discoverSections,
      ],
    );

    await runtime.init(source, r'''
globalThis.source ??= {};
let savedCloudflareCookies = [];
let cloudflareRequest;
let cloudflareLocalStorage = {};
let legacyCloudflareCallbackCalled = false;
let settingsNestedFormVersion = 0;
const createSettingsNestedForm = () => {
  const version = ++settingsNestedFormVersion;
  return {
    requiresExplicitSubmission: true,
    getSections: () => [],
    formDidSubmit: async () => {
      Application.setState(
        (Application.getState("phase2-nested-submit-count") ?? 0) + 1,
        "phase2-nested-submit-count"
      );
      Application.setState(version, "phase2-nested-submit-version");
    }
  };
};
const settingsNestedRow = {
  id: "phase2-nested",
  type: "navigationRow",
  isHidden: false,
  title: "Nested",
  form: createSettingsNestedForm()
};
const settingsForm = {
  requiresExplicitSubmission: true,
  formWillAppear: () => {
    Application.setState("appeared", "phase2-appeared");
  },
  getSections: () => [
    {
      id: "phase2-settings",
      type: "flowSection",
      items: [settingsNestedRow]
    }
  ],
  formDidSubmit: async () => {
    Application.setState("submitted", "phase2-submitted");
  },
  getSearchQueryMetadata: async () => ({ from: "settings" })
};
const advancedSearchForm = {
  requiresExplicitSubmission: false,
  formWillAppear: () => {},
  formDidSubmit: async () => {
    await Application.sleep(0.01);
  },
  formDidDisappear: async () => {
    await Application.sleep(0.01);
    Application.setState("yes", "phase9AdvancedSearchDidDisappear");
  },
  getSections: () => [],
  getSearchQueryMetadata: async () => ({ genre: "action" })
};
let phase9SearchRequestCount = 0;
globalThis.phase9SearchRequestCount = () => phase9SearchRequestCount;
globalThis.phase9SortingQueryHasMetadata = null;

const bindingTarget = {
  run: async (value) => ({
    value,
    initialized: Application.getState("phase2"),
    nested: { value }
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
      if (!response.mimeType?.startsWith("image/")) return body;
      const bytes = new Uint8Array(body);
      return new Uint8Array([7, ...bytes, 9]).buffer;
    }

    if (request.url.includes("/phase8-large-binary")) {
      return body;
    }

    if (request.url.includes("/phase10-serialized-image/")) {
      return body;
    }

    const text = Application.arrayBufferToUTF8String(body);
    Application.setState(`${response.status}:${text}`, "phase4ResponseSeen");
    return new TextEncoder().encode(`${text}::intercepted`).buffer;
  }
};

const requestBindingTarget = {
  run: async (url) => {
    await Application.scheduleRequest({
      url,
      method: "GET",
      headers: { "X-Phase": "no-referer" }
    });

    await Application.scheduleRequest({
      url,
      method: "GET",
      headers: {
        "X-Phase": "explicit-origin",
        "Referer": "https://reader.example/explicit",
        "Origin": "https://extension.example"
      }
    });

    const [response, body] = await Application.scheduleRequest({
      url,
      method: "POST",
      headers: {
        "X-Phase": "original",
        "Referer": "https://reader.example/chapter/1?token=abc"
      },
      cookies: { session: "abc" },
      body: "hello from fjs"
    });

    return {
      defaultUserAgent: await Application.getDefaultUserAgent(),
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

const phase8FetchBindingTarget = {
  run: async (
    redirectUrl,
    crossOriginRedirectUrl,
    gzipUrl,
    formDataUrl,
    largeBinaryUrl
  ) => {
    const [, redirectBody] = await Application.scheduleRequest({
      url: redirectUrl,
      method: "GET"
    });
    const [, crossOriginRedirectBody] = await Application.scheduleRequest({
      url: crossOriginRedirectUrl,
      method: "GET",
      cookies: { secret: "do-not-forward" }
    });
    const [, gzipBody] = await Application.scheduleRequest({
      url: gzipUrl,
      method: "GET"
    });
    const [, formDataBody] = await Application.scheduleRequest({
      url: formDataUrl,
      method: "POST",
      body: { alpha: "one", count: 2 }
    });
    const [, largeBinaryBody] = await Application.scheduleRequest({
      url: largeBinaryUrl,
      method: "GET"
    });
    const largeBinaryBytes = new Uint8Array(largeBinaryBody);

    return {
      redirect: Application.arrayBufferToUTF8String(redirectBody),
      crossOriginRedirect:
        Application.arrayBufferToUTF8String(crossOriginRedirectBody),
      gzip: Application.arrayBufferToUTF8String(gzipBody),
      formData: Application.arrayBufferToUTF8String(formDataBody),
      largeBinary: {
        length: largeBinaryBytes.length,
        first: largeBinaryBytes[0],
        middle: largeBinaryBytes[1024 * 1024],
        last: largeBinaryBytes[largeBinaryBytes.length - 1]
      }
    };
  }
};

globalThis.phase8FetchBindingId =
  Application.Selector(phase8FetchBindingTarget, "run");

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
    Application.setState(
      savedCloudflareCookies.find((cookie) => cookie.name === "cf_clearance")
        ?.value,
      "phase6CloudflareClearance"
    );
    Application.setState(
      `${cloudflareRequest.method}:${cloudflareRequest.url}`,
      "phase6CloudflareRequest"
    );
    Application.setState(
      cloudflareLocalStorage.phase6,
      "phase6CloudflareLocalStorage"
    );
    Application.setState(
      legacyCloudflareCallbackCalled,
      "phase6LegacyCloudflareCallbackCalled"
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
  cloudflareBypassCompleted: async (request, cookies, localStorage) => {
    cloudflareRequest = request;
    savedCloudflareCookies = cookies;
    cloudflareLocalStorage = localStorage;
  },
  saveCloudflareBypassCookies: async (cookies) => {
    legacyCloudflareCallbackCalled = true;
    savedCloudflareCookies = cookies;
  },
  getSettingsForm: async () => settingsForm,
  getAdvancedSearchForm: async () => advancedSearchForm,
  getSortingOptions: async (query) => {
    globalThis.phase9SortingQueryHasMetadata = "metadata" in query;
    return [{ id: "latest", label: "Latest" }];
  },
  getDiscoverSections: async () => [
    {
      id: "updates",
      title: "Updates",
      subtitle: undefined,
      type: 3
    }
  ],
  getDiscoverSectionItems: async (section, metadata) => {
    await Application.sleep(0.01);
    return {
      items: [
        {
          type: "chapterUpdatesCarouselItem",
          mangaId: "phase9-discover-manga",
          chapterId: "phase9-discover-chapter",
          imageUrl: "https://example.com/discover.jpg",
          title: section.title,
          subtitle: undefined,
          publishDate: new Date("2026-05-31T12:34:56.789Z")
        }
      ],
      metadata: { page: (metadata?.page ?? 0) + 1 }
    };
  },
  getSearchResults: async (query, metadata, sortOp) => {
    phase9SearchRequestCount++;
    return {
      items: [
        {
          mangaId: "phase9-search-manga",
          title: query.title,
          imageUrl: "https://example.com/search.jpg",
          subtitle: undefined,
          metadata: {
            queryHasMetadata: "metadata" in query,
            sortId: sortOp?.id ?? null
          }
        }
      ],
      metadata: { page: (metadata?.page ?? 0) + 1 }
    };
  },
  getMangaShareUrl: async (mangaId) => {
    if (mangaId === "throws") {
      throw new Error("share URL unavailable");
    }
    return `https://example.com/manga/${mangaId}`;
  },
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
''');

    expect(startupChallengeRequests, greaterThan(0));
    expect(runtime.hasAdvancedSearchForm, true);
    expect(runtime.hasSortOps, true);
    expect(storedState, {
      'existing': 'state',
      'phase2': 'initialized',
      'phase6CloudflareSavedBeforeInit': true,
      'phase6CloudflareCookieNames': 'cf_clearance',
      'phase6CloudflareClearance': 'startup-clearance',
      'phase6CloudflareRequest': 'GET:http://127.0.0.1:${server.port}/',
      'phase6CloudflareLocalStorage': 'startup-storage',
      'phase6LegacyCloudflareCallbackCalled': false,
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
    expect(
      await runtime.evalForTesting(r'''
(async () => {
  try {
    await fjs.bridge_call("{");
    return "accepted";
  } catch (error) {
    return String(error);
  }
})()
'''),
      isNot('accepted'),
    );
    final canvasResult = await runtime.evalForTesting(r'''
(async () => {
  console.log("phase7 console bridge", { nested: true });
  const image = new Image();
  await new Promise((resolve, reject) => {
    image.onload = resolve;
    image.onerror = reject;
    image.src = "data:image/bmp;base64,Qk06AAAAAAAAADYAAAAoAAAAAQAAAAEAAAABABgAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAD/AA==";
  });
  const canvas = new HTMLCanvasElement();
  canvas.width = 1;
  canvas.height = 1;
  const context = canvas.getContext("2d");
  context.drawImage(image, 0, 0);
  const nativeImageData = new ImageData(new Uint8ClampedArray(8), 1);
  nativeImageData.data[0] = 5;
  nativeImageData.data[1] = 260;
  nativeImageData.data[2] = -20;
  nativeImageData.data[3] = 7;
  return {
    pixels: Array.from(context.getImageData(0, 0, 1, 1).data),
    dataUrl: canvas.toDataURL(),
    imageDataLength: new ImageData(1, 1).data.length,
    inferredImageDataHeight:
      new ImageData(new Uint8ClampedArray(8), 1).height,
    nativeImageDataProbe:
      globalThis.gagaku?.nativeCanvas?.inspectImageData(nativeImageData)
  };
})()
''');
    expect(canvasResult, isA<Map<String, dynamic>>());
    final canvasData = canvasResult as Map<String, dynamic>;
    expect(canvasData['pixels'], [255, 0, 0, 255]);
    expect(canvasData['imageDataLength'], 4);
    expect(canvasData['inferredImageDataHeight'], 2);
    expect(canvasData['nativeImageDataProbe'], {
      'width': 1,
      'height': 2,
      'length': 8,
      'checksum': 267,
      'first': 5,
      'second': 255,
      'third': 0,
      'fourth': 7,
    });
    final dataUrl = canvasData['dataUrl'] as String;
    expect(dataUrl, startsWith('data:image/png;base64,'));
    final pngComma = dataUrl.indexOf(',');
    final png = img.decodePng(base64Decode(dataUrl.substring(pngComma + 1)));
    expect(png, isNotNull);
    expect(png!.width, 1);
    expect(png.height, 1);
    final pngPixel = png.getPixel(0, 0);
    expect([pngPixel.r, pngPixel.g, pngPixel.b, pngPixel.a], [255, 0, 0, 255]);
    final bindingId = await runtime.evalForTesting(
      'globalThis.phase2BindingId',
    );
    final bindingResult = await runtime.callBinding(bindingId, ['from-dart']);
    expect(bindingResult, isA<Map<String, dynamic>>());
    expect(bindingResult['nested'], isA<Map<String, dynamic>>());
    expect(bindingResult, {
      'value': 'from-dart',
      'initialized': 'initialized',
      'nested': {'value': 'from-dart'},
    });

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
    final settingsSections = await form.sections;
    expect(settingsSections, hasLength(1));
    final settingsNavRow =
        settingsSections.single.items.single as NavigationRowElement;
    expect(settingsNavRow.form, 'phase2-nested');
    expect(form.requiresExplicitSubmission, true);
    final nestedForm = await runtime.getForm(source, settingsNavRow.form);
    await nestedForm.formDidSubmit();
    expect(storedState['phase2-nested-submit-count'], 1);
    expect(storedState['phase2-nested-submit-version'], 1);
    await form.reloadForm();
    await form.sections;
    final reloadedNestedForm = await runtime.getForm(
      source,
      settingsNavRow.form,
    );
    await reloadedNestedForm.formDidSubmit();
    expect(storedState['phase2-nested-submit-count'], 2);
    expect(storedState['phase2-nested-submit-version'], 1);
    await form.formDidSubmit();
    expect(await form.getSearchQueryMetadata(), {'from': 'settings'});
    expect(storedState, {
      'existing': 'state',
      'phase2': 'initialized',
      'phase6CloudflareSavedBeforeInit': true,
      'phase6CloudflareCookieNames': 'cf_clearance',
      'phase6CloudflareClearance': 'startup-clearance',
      'phase6CloudflareRequest': 'GET:http://127.0.0.1:${server.port}/',
      'phase6CloudflareLocalStorage': 'startup-storage',
      'phase6LegacyCloudflareCallbackCalled': false,
      'phase7DateState': {
        'nested': ['2026-05-30T12:34:56.789Z'],
      },
      'phase7BridgeState': {'nullable': null},
      'phase2-appeared': 'appeared',
      'phase2-nested-submit-count': 2,
      'phase2-nested-submit-version': 1,
      'phase2-submitted': 'submitted',
    });

    final requestBindingId = await runtime.evalForTesting(
      'globalThis.phase4RequestBindingId',
    );
    final requestResult = await runtime.callBinding(requestBindingId, [
      'http://127.0.0.1:${server.port}/phase4',
    ]);

    expect(receivedRequests, hasLength(3));
    final noRefererRequest = receivedRequests[0];
    final explicitOriginRequest = receivedRequests[1];
    final requestWithReferer = receivedRequests[2];

    expect(noRefererRequest['origin'], isNull);
    expect(noRefererRequest['referer'], isNull);
    expect(explicitOriginRequest['origin'], 'https://extension.example');
    expect(explicitOriginRequest['referer'], 'https://reader.example/explicit');
    expect(requestWithReferer['method'], 'POST');
    expect(requestWithReferer['x-phase'], 'intercepted');
    expect(requestWithReferer['user-agent'], 'Phase Test Browser/123');
    expect(requestWithReferer['sec-ch-ua'], '"Phase Test Browser";v="123"');
    expect(requestWithReferer['sec-ch-ua-mobile'], '?0');
    expect(requestWithReferer['sec-ch-ua-platform'], '"Linux"');
    expect(
      requestWithReferer['sec-ch-ua-full-version-list'],
      '"Phase Test Browser";v="123.4.5.6"',
    );
    expect(requestWithReferer['origin'], 'https://reader.example');
    expect(
      requestWithReferer['referer'],
      'https://reader.example/chapter/1?token=abc',
    );
    expect(requestWithReferer['cookie'], contains('session=abc'));
    expect(requestWithReferer['body'], 'hello from fjs');
    expect(requestResult['defaultUserAgent'], 'Phase Test Browser/123');
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
    expect(
      requestResult['cookies'],
      contains(
        isA<Map>()
            .having((cookie) => cookie['name'], 'name', 'phase4-session')
            .having((cookie) => cookie['expires'], 'expires', 'undefined'),
      ),
    );
    expect(
      requestResult['cookies'],
      contains(
        isA<Map>()
            .having((cookie) => cookie['name'], 'name', 'phase4-precedence')
            .having(
              (cookie) => DateTime.parse(
                cookie['expires'] as String,
              ).isAfter(DateTime.now()),
              'expires',
              isTrue,
            ),
      ),
    );

    final phase8FetchBindingId = await runtime.evalForTesting(
      'globalThis.phase8FetchBindingId',
    );
    final phase8FetchResult = await runtime.callBinding(phase8FetchBindingId, [
      'http://127.0.0.1:${server.port}/phase8-redirect',
      'http://127.0.0.1:${server.port}/phase8-cross-origin-redirect',
      'http://127.0.0.1:${server.port}/phase8-gzip',
      'http://127.0.0.1:${server.port}/phase8-form-data',
      'http://127.0.0.1:${server.port}/phase8-large-binary',
    ]);
    expect(phase8FetchResult['redirect'], 'redirected::intercepted');
    expect(
      phase8FetchResult['crossOriginRedirect'],
      'cross-origin::intercepted',
    );
    expect(receivedCrossOriginCookie, isNull);
    expect(phase8FetchResult['gzip'], 'compressed::intercepted');
    expect(phase8FetchResult['formData'], 'form-received::intercepted');
    expect(receivedFormDataContentType, startsWith('multipart/form-data;'));
    expect(receivedFormDataBody, contains('name="alpha"'));
    expect(receivedFormDataBody, contains('one'));
    expect(receivedFormDataBody, contains('name="count"'));
    expect(receivedFormDataBody, contains('2'));
    expect(phase8FetchResult['largeBinary'], {
      'length': largePayload.length,
      'first': largePayload.first,
      'middle': largePayload[1024 * 1024],
      'last': largePayload.last,
    });

    final imageBytes = await runtime.processImageRequest(
      'http://127.0.0.1:${server.port}/phase5',
    );
    expect(imageBytes, Uint8List.fromList([7, 1, 2, 3, 9]));
    final largeImageBytes = await runtime.processImageRequest(
      'http://127.0.0.1:${server.port}/phase8-large-binary',
    );
    expect(largeImageBytes, largePayload);
    final serializedImageBytes = await Future.wait([
      runtime.processImageRequest(
        'http://127.0.0.1:${server.port}/phase10-serialized-image/1',
      ),
      runtime.processImageRequest(
        'http://127.0.0.1:${server.port}/phase10-serialized-image/2',
      ),
    ]);
    expect(serializedImageBytes, [
      Uint8List.fromList([1]),
      Uint8List.fromList([2]),
    ]);
    expect(maxActiveImageRequests, 1);
    await runtime.evalForTesting('''
globalThis.phase11ActiveEvals = 0;
globalThis.phase11MaxActiveEvals = 0;
''');
    final serializedEvals = await Future.wait([
      runtime.evalForTesting('''
globalThis.phase11ActiveEvals++;
globalThis.phase11MaxActiveEvals = Math.max(
  globalThis.phase11MaxActiveEvals,
  globalThis.phase11ActiveEvals
);
await new Promise((resolve) => setTimeout(resolve, 100));
globalThis.phase11ActiveEvals--;
"first";
'''),
      runtime.evalForTesting('''
globalThis.phase11ActiveEvals++;
globalThis.phase11MaxActiveEvals = Math.max(
  globalThis.phase11MaxActiveEvals,
  globalThis.phase11ActiveEvals
);
await new Promise((resolve) => setTimeout(resolve, 100));
globalThis.phase11ActiveEvals--;
"second";
'''),
    ]);
    expect(serializedEvals, ['first', 'second']);
    expect(await runtime.evalForTesting('globalThis.phase11MaxActiveEvals'), 1);

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

    final emptySearch = await runtime.searchManga(
      const SearchQuery(title: ''),
      null,
    );
    expect(emptySearch.items, isEmpty);
    expect(
      await runtime.evalForTesting('globalThis.phase9SearchRequestCount()'),
      0,
    );

    final sortingOptions = await runtime.getSortingOptions(
      const SearchQuery(title: 'sort'),
    );
    expect(sortingOptions, [
      const SortingOption(id: 'latest', label: 'Latest'),
    ]);
    expect(
      await runtime.evalForTesting('globalThis.phase9SortingQueryHasMetadata'),
      false,
    );

    final advancedSearchForm = await runtime.getAdvancedSearchForm(
      const SearchQuery(title: ''),
    );
    expect(advancedSearchForm, isNotNull);
    expect(await advancedSearchForm!.sections, isEmpty);
    final advancedSearchMetadata = await advancedSearchForm
        .getSearchQueryMetadata();
    expect(advancedSearchMetadata, {'genre': 'action'});
    final reopenedAdvancedSearchForm = await runtime.getAdvancedSearchForm(
      const SearchQuery(title: ''),
    );
    expect(reopenedAdvancedSearchForm, isNotNull);
    await advancedSearchForm.uninitialize();
    await runtime.evalForTesting('true');
    expect(await reopenedAdvancedSearchForm!.sections, isEmpty);
    await reopenedAdvancedSearchForm.formDidSubmit();
    final submittedAdvancedSearchMetadata = await reopenedAdvancedSearchForm
        .getSearchQueryMetadata();
    expect(submittedAdvancedSearchMetadata, {'genre': 'action'});
    await reopenedAdvancedSearchForm.call('formDidDisappear');
    await reopenedAdvancedSearchForm.uninitialize();
    expect(
      await runtime.evalForTesting(
        'globalThis.Application.getState("phase9AdvancedSearchDidDisappear")',
      ),
      'yes',
    );

    final firstSearch = await runtime.searchManga(
      const SearchQuery(title: 'Phase 9 Search'),
      null,
    );
    expect(firstSearch.metadata, {'page': 1});
    expect(firstSearch.items.single.title, 'Phase 9 Search');
    expect(firstSearch.items.single.metadata, {
      'queryHasMetadata': false,
      'sortId': null,
    });

    final sortedSearch = await runtime.searchManga(
      SearchQuery(
        title: 'Phase 9 Search',
        metadata: submittedAdvancedSearchMetadata,
      ),
      {'page': 4},
      sortOp: sortingOptions!.single,
    );
    expect(sortedSearch.metadata, {'page': 5});
    expect(sortedSearch.items.single.metadata, {
      'queryHasMetadata': true,
      'sortId': 'latest',
    });

    final discoverSections = await runtime.getDiscoverSections(source);
    expect(discoverSections, hasLength(1));
    expect(discoverSections.single.title, 'Updates');
    expect(discoverSections.single.type, DiscoverSectionType.chapterUpdates);
    final discoverItems = await runtime.getDiscoverSectionItems(
      source,
      discoverSections.single,
      null,
    );
    expect(discoverItems.metadata, {'page': 1});
    final discoverItem =
        discoverItems.items.single as ChapterUpdatesCarouselItem;
    expect(discoverItem.title, 'Updates');
    expect(
      discoverItem.publishDate,
      DateTime.parse('2026-05-31T12:34:56.789Z'),
    );
    expect(
      await Future.wait(
        List.generate(
          4,
          (_) => runtime.getDiscoverSectionItems(
            source,
            discoverSections.single,
            null,
          ),
        ),
      ),
      everyElement(
        isA<PagedResults<DiscoverSectionItem>>().having(
          (items) => items.metadata,
          'metadata',
          {'page': 1},
        ),
      ),
    );

    expect(
      await runtime.getMangaURL('phase9-share'),
      'https://example.com/manga/phase9-share',
    );
    expect(await runtime.getMangaURL(''), isNull);
    expect(await runtime.getMangaURL('throws'), isNull);
    await runtime.evalForTesting(
      'delete globalThis.phase2source.getMangaShareUrl',
    );
    expect(await runtime.getMangaURL('missing'), isNull);

    Future<FjsExtensionRuntime> initializeDisposalProbe(String sourceId) async {
      final disposalProbe = FjsExtensionRuntime(
        sourceId: sourceId,
        extensionHost: await rootBundle.loadString(
          'assets/extensionhost/bundle.js',
        ),
        onResetAllState: (_) {},
        onSetExtensionState: (_, _) {},
        onSetExtensionSecureState: (_, _) {},
        getExtensionState: (_) => {},
        getExtensionSecureState: (_) => {},
      );
      addTearDown(disposalProbe.dispose);

      final disposalSource = WebSourceInfo(
        id: sourceId,
        name: sourceId,
        repo: 'phase9',
        icon: '',
        capabilities: const [SourceIntents.settingsUI],
      );
      await disposalProbe.init(disposalSource, '''
globalThis.source ??= {};
const settingsForm = {
  requiresExplicitSubmission: false,
  getSections: () => []
};
globalThis.source.$sourceId = {
  initialise: async () => {},
  getSettingsForm: async () => settingsForm
};
''');
      final form = await disposalProbe.getSettingsForm(disposalSource);
      expect(await form.sections, isEmpty);
      return disposalProbe;
    }

    final drainingProbe = await initializeDisposalProbe('phase11drain');
    final acceptedEval = drainingProbe.evalForTesting('''
await new Promise((resolve) => setTimeout(() => resolve("drained"), 100));
''');
    final drainingDispose = drainingProbe.dispose();
    await expectLater(
      drainingProbe.evalForTesting('"rejected"'),
      throwsStateError,
    );
    expect(await acceptedEval, 'drained');
    await drainingDispose;
    await drainingProbe.dispose();
  });

  test(
    'fjs runtime preserves an existing valid Cloudflare clearance',
    () async {
      final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
      final baseUrl = 'http://127.0.0.1:${server.port}/';
      final baseWebUri = WebUri(baseUrl);
      var basePageRequests = 0;
      Map<String, dynamic>? storedState;

      addTearDown(() => server.close(force: true));
      addTearDown(
        () => CookieManager.instance().deleteCookie(
          url: baseWebUri,
          name: 'cf_clearance',
        ),
      );
      server.listen((request) async {
        if (request.uri.path == '/') {
          basePageRequests++;
        }
        request.response
          ..statusCode = HttpStatus.ok
          ..headers.contentType = ContentType.html
          ..write('<html><title>Ready</title><body>ready</body></html>');
        await request.response.close();
      });

      await CookieManager.instance().setCookie(
        url: baseWebUri,
        name: 'cf_clearance',
        value: 'known-good-clearance',
      );

      final runtime = FjsExtensionRuntime(
        sourceId: 'knownGoodSource',
        extensionHost: await rootBundle.loadString(
          'assets/extensionhost/bundle.js',
        ),
        onResetAllState: (_) {},
        onSetExtensionState: (_, state) {
          storedState = Map<String, dynamic>.from(state as Map);
        },
        onSetExtensionSecureState: (_, _) {},
        getExtensionState: (_) => {},
        getExtensionSecureState: (_) => {},
      );
      addTearDown(runtime.dispose);

      final source = WebSourceInfo(
        id: 'knownGoodSource',
        name: 'Known Good Source',
        repo: 'phase6',
        baseUrl: baseUrl,
        icon: '',
        capabilities: const [SourceIntents.cloudflareBypassRequired],
      );
      await runtime.init(source, r'''
globalThis.source ??= {};
globalThis.source.knownGoodSource = {
  cloudflareBypassCompleted: async (request, cookies) => {
    Application.setState(
      cookies.find((cookie) => cookie.name === "cf_clearance")?.value,
      "clearance"
    );
  },
  initialise: async () => {}
};
''');

      expect(storedState, {'clearance': 'known-good-clearance'});
      expect(basePageRequests, 1);
    },
  );

  test(
    'fjs runtime reports a Cloudflare challenge without clearance',
    () async {
      final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
      final baseUrl = 'http://127.0.0.1:${server.port}/';
      final baseWebUri = WebUri(baseUrl);
      var challengeServed = false;

      addTearDown(() => server.close(force: true));
      addTearDown(
        () => CookieManager.instance().deleteCookie(
          url: baseWebUri,
          name: 'cf_clearance',
        ),
      );
      await CookieManager.instance().deleteCookie(
        url: baseWebUri,
        name: 'cf_clearance',
      );
      server.listen((request) async {
        if (!challengeServed) {
          challengeServed = true;
          request.response
            ..statusCode = HttpStatus.found
            ..headers.set(
              HttpHeaders.locationHeader,
              '/?__cf_chl_rt_tk=startup-test',
            );
        } else {
          request.response
            ..statusCode = HttpStatus.ok
            ..headers.contentType = ContentType.html
            ..write('<html><title>Ready</title><body>ready</body></html>');
        }
        await request.response.close();
      });

      final runtime = FjsExtensionRuntime(
        sourceId: 'manualCloudflareSource',
        extensionHost: await rootBundle.loadString(
          'assets/extensionhost/bundle.js',
        ),
        onResetAllState: (_) {},
        onSetExtensionState: (_, _) {},
        onSetExtensionSecureState: (_, _) {},
        getExtensionState: (_) => {},
        getExtensionSecureState: (_) => {},
        startupBrowserTimeout: const Duration(milliseconds: 500),
      );
      addTearDown(runtime.dispose);

      final source = WebSourceInfo(
        id: 'manualCloudflareSource',
        name: 'Manual Cloudflare Source',
        repo: 'phase6',
        baseUrl: baseUrl,
        icon: '',
        capabilities: const [SourceIntents.cloudflareBypassRequired],
      );

      await expectLater(
        runtime.init(source, r'''
globalThis.source ??= {};
globalThis.source.manualCloudflareSource = {
  initialise: async () => {}
};
'''),
        throwsA(isA<CloudflareBypassException>()),
      );
    },
  );
}
