import {
  parseURL,
  type Cookie,
  type Request,
  type RequestInterceptor,
  type Response,
  type ResponseInterceptor,
  type SelectorID,
  type SelectorRegistry,
} from "@paperback/types";

type RequestManager = Pick<
  typeof Application,
  | "registerInterceptor"
  | "unregisterInterceptor"
  | "scheduleRequest"
  | "setRedirectHandler"
  | "getDefaultUserAgent"
>;

type HeaderMap = Record<string, string>;
type NativeBody = ArrayBuffer | string | undefined;

const nativeFetchTimeoutMs = 30_000;
const maxRedirects = 20;
const redirectStatuses = new Set([301, 302, 303, 307, 308]);
const credentialHeaders = new Set([
  "authorization",
  "cookie",
  "proxy-authorization",
]);
const bodyHeaders = new Set(["content-length", "content-type"]);

export class MockRequestManager implements RequestManager {
  private registeredInterceptors: {
    interceptorId: string;
    interceptRequestSelectorId: SelectorID<RequestInterceptor>;
    interceptResponseSelectorId: SelectorID<ResponseInterceptor>;
  }[] = [];

  private readonly defaultUserAgentHeaders =
    globalThis.gagaku.defaultUserAgentHeaders;
  private nextRequestId = 1;

  constructor(private readonly selectorRegistry: SelectorRegistry) {}

  registerInterceptor(
    interceptorId: string,
    interceptRequestSelectorId: SelectorID<RequestInterceptor>,
    interceptResponseSelectorId: SelectorID<ResponseInterceptor>,
  ): void {
    // Ids are not unique: extensions register several interceptors under one
    // id (AniList: BasicRateLimiter("main") and AniListInterceptor("main")).
    // Selector ids are canonical per (object, method), so only an exact repeat
    // is skipped.
    const alreadyRegistered = this.registeredInterceptors.some(
      (interceptor) =>
        interceptor.interceptorId === interceptorId &&
        interceptor.interceptRequestSelectorId === interceptRequestSelectorId &&
        interceptor.interceptResponseSelectorId === interceptResponseSelectorId,
    );
    if (!alreadyRegistered) {
      this.registeredInterceptors.push({
        interceptorId,
        interceptRequestSelectorId,
        interceptResponseSelectorId,
      });
    }
  }

  /** Removes every interceptor registered under [interceptorId]. */
  unregisterInterceptor(interceptorId: string): void {
    this.registeredInterceptors = this.registeredInterceptors.filter(
      (interceptor) => interceptor.interceptorId !== interceptorId,
    );
  }

  setRedirectHandler(): void {}

  async getDefaultUserAgent(): Promise<string> {
    return this.defaultUserAgentHeaders["user-agent"];
  }

  async scheduleRequest(request: Request): Promise<[Response, ArrayBuffer]> {
    const log = new RequestLog(this.nextRequestId++);
    let stage = "prepare";
    try {
      let finalRequest = request;
      for (const interceptor of this.registeredInterceptors) {
        const requestInterceptor = this.selectorRegistry.selector(
          interceptor.interceptRequestSelectorId,
        );
        finalRequest = await requestInterceptor(finalRequest);
      }
      const headers = buildHeaders(finalRequest, this.defaultUserAgentHeaders);
      const body = await encodeBody(finalRequest.body, headers);
      log.start(finalRequest, headers);

      stage = "nativeFetch";
      const fetchResponse = await fetchFollowingRedirects(finalRequest.url, {
        method: finalRequest.method,
        body,
        headers,
      });
      const response = toPaperbackResponse(fetchResponse);

      stage = "responseBody";
      let responseBody = await fetchResponse.arrayBuffer();
      log.response(finalRequest, response, fetchResponse.headers, responseBody);

      stage = "responseInterceptors";
      for (let i = this.registeredInterceptors.length - 1; i >= 0; i--) {
        const interceptor = this.selectorRegistry.selector(
          this.registeredInterceptors[i]!.interceptResponseSelectorId,
        );
        responseBody = await interceptor(finalRequest, response, responseBody);
      }

      return [response, responseBody];
    } catch (error) {
      log.failed(stage, error);
      throw error;
    }
  }
}

/** Returns the actual key of the header [name] in [headers], ignoring case. */
function headerKey(headers: HeaderMap, name: string): string | undefined {
  const normalizedName = name.toLowerCase();
  return Object.keys(headers).find(
    (key) => key.toLowerCase() === normalizedName,
  );
}

function headerValue(headers: HeaderMap, name: string): string | undefined {
  const key = headerKey(headers, name);
  return key === undefined ? undefined : headers[key];
}

/**
 * Extension headers, then any missing default browser-identity headers, then
 * a Cookie header built from `request.cookies` that replaces any existing one.
 */
function buildHeaders(request: Request, defaults: HeaderMap): HeaderMap {
  const headers = { ...request.headers };
  for (const [name, value] of Object.entries(defaults)) {
    if (headerKey(headers, name) === undefined) {
      headers[name] = value;
    }
  }

  const cookies = Object.entries(request.cookies ?? {});
  if (cookies.length > 0) {
    const existingKey = headerKey(headers, "cookie");
    if (existingKey !== undefined) {
      delete headers[existingKey];
    }
    headers["Cookie"] = cookies
      .map(([name, value]) => `${name}=${value}`)
      .join("; ");
  }

  return headers;
}

/**
 * Plain objects are sent as multipart form data. The multipart Content-Type
 * (with its boundary) is added to [headers] unless the extension set one.
 */
async function encodeBody(
  body: Request["body"],
  headers: HeaderMap,
): Promise<NativeBody> {
  if (!body) {
    return undefined;
  }
  if (typeof body === "string" || body instanceof ArrayBuffer) {
    return body;
  }
  if (typeof body !== "object") {
    return undefined;
  }

  const formData = new FormData();
  for (const [key, value] of Object.entries(body)) {
    if (typeof value === "string" || value instanceof Blob) {
      formData.append(key, value);
    } else if (value !== undefined && value !== null) {
      formData.append(key, String(value));
    }
  }

  const encoded = new globalThis.Response(formData);
  const contentType = encoded.headers.get("content-type");
  if (contentType && headerKey(headers, "content-type") === undefined) {
    headers["Content-Type"] = contentType;
  }
  return encoded.arrayBuffer();
}

function toPaperbackResponse(fetchResponse: globalThis.Response): Response {
  return {
    url: fetchResponse.url,
    headers: Object.fromEntries(fetchResponse.headers.entries()),
    status: fetchResponse.status,
    cookies: fetchResponse.headers
      .getSetCookie()
      .map((header) => parseSetCookie(header, fetchResponse.url)),
    mimeType: fetchResponse.headers
      .get("content-type")
      ?.split(";", 1)[0]
      ?.trim(),
  };
}

function parseSetCookie(header: string, responseUrl: string): Cookie {
  const [nameValue = "", ...attributes] = header.split(";");
  const [name = "", ...value] = nameValue.split("=");
  let domain: string | undefined;
  let path: string | undefined;
  let expires: Date | undefined;
  let maxAge: number | undefined;

  for (const attribute of attributes) {
    const [rawKey = "", ...rawValue] = attribute.split("=");
    const attributeValue = rawValue.join("=").trim();
    switch (rawKey.trim().toLowerCase()) {
      case "expires":
        expires = new Date(attributeValue);
        break;
      case "max-age":
        if (/^-?\d+$/.test(attributeValue)) {
          maxAge = Number(attributeValue);
        }
        break;
      case "domain":
        domain = attributeValue;
        break;
      case "path":
        path = attributeValue;
        break;
    }
  }

  return {
    name: name.trim(),
    value: value.join("="),
    domain: domain ?? parseURL(responseUrl).hostname!,
    path: path ?? "/",
    // Max-Age takes precedence over Expires (RFC 6265 section 5.3).
    expires:
      maxAge === undefined ? expires : new Date(Date.now() + maxAge * 1000),
  };
}

/**
 * Follows redirects in JS instead of LLRT. LLRT parses Location as an
 * absolute URI (relative redirects fail) and only drops Authorization on
 * cross-origin hops; this also drops Cookie and Proxy-Authorization.
 */
async function fetchFollowingRedirects(
  initialUrl: string,
  init: { method: string; body: NativeBody; headers: HeaderMap },
): Promise<globalThis.Response> {
  let url = initialUrl;
  let { method, body, headers } = init;

  for (let redirects = 0; ; redirects++) {
    const response = await fetchWithTimeout(url, {
      method,
      body: body ?? null,
      headers,
      redirect: "manual",
    });
    const location = response.headers.get("location");
    if (location === null || !redirectStatuses.has(response.status)) {
      return response;
    }
    if (redirects === maxRedirects) {
      throw new Error("Too many redirects");
    }

    const nextUrl = new URL(location, url);
    const crossOrigin = nextUrl.origin !== new URL(url).origin;
    const changesToGet =
      response.status === 303 ||
      ((response.status === 301 || response.status === 302) &&
        method.toUpperCase() === "POST");

    headers = Object.fromEntries(
      Object.entries(headers).filter(([name]) => {
        const normalizedName = name.toLowerCase();
        return (
          !(crossOrigin && credentialHeaders.has(normalizedName)) &&
          !(changesToGet && bodyHeaders.has(normalizedName))
        );
      }),
    );
    if (changesToGet) {
      method = "GET";
      body = undefined;
    }
    url = nextUrl.toString();
  }
}

async function fetchWithTimeout(
  url: string,
  init: RequestInit,
): Promise<globalThis.Response> {
  const controller = new AbortController();
  let timer: ReturnType<typeof setTimeout> | undefined;
  const timeout = new Promise<never>((_, reject) => {
    timer = setTimeout(() => {
      controller.abort();
      reject(
        new Error(`Native fetch timed out after ${nativeFetchTimeoutMs}ms`),
      );
    }, nativeFetchTimeoutMs);
  });

  try {
    return await Promise.race([
      fetch(url, { ...init, signal: controller.signal }),
      timeout,
    ]);
  } finally {
    clearTimeout(timer);
  }
}

/**
 * Per-request diagnostic log lines for Cloudflare triage. Nothing parses
 * them, but the user-agent fingerprint must match the Dart logs.
 */
class RequestLog {
  constructor(private readonly id: number) {}

  start(request: Request, headers: HeaderMap): void {
    const cookieNames = uniqueSorted(
      (headerValue(headers, "cookie") ?? "")
        .split(";")
        .map((entry) => entry.split("=", 1)[0]!.trim()),
    );
    const userAgent = headerValue(headers, "user-agent");
    this.log(
      `start method=${request.method} ` +
        `target=${diagnosticTarget(request.url)} ` +
        `cookieNames=${JSON.stringify(cookieNames)} ` +
        `clearancePresent=${cookieNames.includes("cf_clearance")} ` +
        `userAgentFingerprint=${
          userAgent ? diagnosticFingerprint(userAgent) : null
        }`,
    );
  }

  response(
    request: Request,
    response: Response,
    headers: globalThis.Headers,
    body: ArrayBuffer,
  ): void {
    this.log(
      `response status=${response.status} ` +
        `target=${diagnosticTarget(response.url)} ` +
        `redirected=${response.url !== request.url} ` +
        `setCookieNames=${JSON.stringify(
          uniqueSorted(response.cookies.map((cookie) => cookie.name)),
        )} ` +
        `cfMitigated=${headers.get("cf-mitigated")} ` +
        `server=${headers.get("server")} ` +
        `cfRay=${headers.get("cf-ray")} ` +
        `contentType=${response.mimeType ?? null} ` +
        `bodyBytes=${body.byteLength}`,
    );
  }

  failed(stage: string, error: unknown): void {
    const summary =
      error instanceof Error ? `${error.name}:${error.message}` : String(error);
    console.error(this.prefix() + `failed stage=${stage} error=${summary}`);
  }

  private log(message: string): void {
    console.log(this.prefix() + message);
  }

  private prefix(): string {
    return `request[${this.id}] time=${new Date().toISOString()} `;
  }
}

function uniqueSorted(values: string[]): string[] {
  return Array.from(new Set(values.filter(Boolean))).sort();
}

function diagnosticTarget(url: string): string {
  try {
    const parsed = new URL(url);
    const target = `${parsed.protocol}//${parsed.host}${parsed.pathname}`;
    return target.length <= 240 ? target : `${target.slice(0, 237)}...`;
  } catch {
    return "<invalid-url>";
  }
}

// Mirrors diagnosticUserAgentFingerprint in lib/web/model/cloudflare.dart so
// Dart and JS logs correlate; keep the two implementations identical.
function diagnosticFingerprint(value: string): string {
  let hash = 0x811c9dc5;
  for (let i = 0; i < value.length; i++) {
    hash ^= value.charCodeAt(i) & 0xff;
    hash = Math.imul(hash, 0x01000193) >>> 0;
  }
  return `fnv32:${hash.toString(16).padStart(8, "0")}`;
}
