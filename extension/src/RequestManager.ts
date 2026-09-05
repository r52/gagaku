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

export class MockRequestManager implements RequestManager {
  private static readonly nativeFetchTimeoutMs = 30_000;

  private selectorRegistry: SelectorRegistry;
  private registeredInterceptors: {
    interceptorId: string;
    interceptRequestSelectorId: SelectorID<RequestInterceptor>;
    interceptResponseSelectorId: SelectorID<ResponseInterceptor>;
  }[];

  private readonly defaultUserAgentHeaders: typeof gagaku.defaultUserAgentHeaders;
  private nextRequestId = 1;

  constructor(selectorRegistry: SelectorRegistry) {
    this.selectorRegistry = selectorRegistry;
    this.registeredInterceptors = [];
    this.defaultUserAgentHeaders = globalThis.gagaku.defaultUserAgentHeaders;
  }

  registerInterceptor(
    interceptorId: string,
    interceptRequestSelectorId: SelectorID<RequestInterceptor>,
    interceptResponseSelectorId: SelectorID<ResponseInterceptor>,
  ): void {
    this.unregisterInterceptor(interceptorId);
    this.registeredInterceptors.push({
      interceptorId,
      interceptRequestSelectorId,
      interceptResponseSelectorId,
    });
  }

  unregisterInterceptor(interceptorId: string): void {
    for (let i = 0; i < this.registeredInterceptors.length; i++) {
      const { interceptorId: registeredInterceptorId } =
        this.registeredInterceptors[i]!;

      if (interceptorId == registeredInterceptorId) {
        this.registeredInterceptors.splice(i, 1);
        return;
      }
    }
  }

  setRedirectHandler(): void {}

  async getDefaultUserAgent(): Promise<string> {
    return this.defaultUserAgentHeaders["user-agent"];
  }

  private diagnosticFingerprint(value: string): string {
    let hash = 0x811c9dc5;
    for (let i = 0; i < value.length; i++) {
      hash ^= value.charCodeAt(i) & 0xff;
      hash = Math.imul(hash, 0x01000193) >>> 0;
    }
    return `fnv32:${hash.toString(16).padStart(8, "0")}`;
  }

  private diagnosticTarget(url: string): string {
    try {
      const parsed = new URL(url);
      const target = `${parsed.protocol}//${parsed.host}${parsed.pathname}`;
      return target.length <= 240 ? target : `${target.slice(0, 237)}...`;
    } catch {
      return "<invalid-url>";
    }
  }

  private requestCookieNames(headers: Record<string, string>): string[] {
    const cookieHeader = this.headerValue(headers, "cookie");
    if (!cookieHeader) {
      return [];
    }
    return Array.from(
      new Set(
        cookieHeader
          .split(";")
          .map((entry) => entry.split("=", 1)[0]?.trim())
          .filter((name): name is string => Boolean(name)),
      ),
    ).sort();
  }

  private errorSummary(error: unknown): string {
    if (error instanceof Error) {
      return `${error.name}:${error.message}`;
    }
    return String(error);
  }


  private hasHeader(headers: Record<string, string>, name: string): boolean {
    const normalizedName = name.toLowerCase();
    return Object.keys(headers).some(
      (headerName) => headerName.toLowerCase() === normalizedName,
    );
  }

  private headerValue(
    headers: Record<string, string>,
    name: string,
  ): string | undefined {
    const normalizedName = name.toLowerCase();
    for (const [headerName, value] of Object.entries(headers)) {
      if (headerName.toLowerCase() === normalizedName) {
        return value;
      }
    }

    return undefined;
  }

  private mergeDefaultUserAgentHeaders(
    headers: Record<string, string>,
  ): Record<string, string> {
    const mergedHeaders = { ...headers };

    for (const [name, value] of Object.entries(this.defaultUserAgentHeaders)) {
      if (!this.hasHeader(mergedHeaders, name)) {
        mergedHeaders[name] = value;
      }
    }

    return mergedHeaders;
  }

  private applyRefererOriginHeader(headers: Record<string, string>): void {
    if (this.hasHeader(headers, "origin")) {
      return;
    }

    const referer = this.headerValue(headers, "referer");
    if (!referer) {
      return;
    }

    try {
      const origin = new URL(referer).origin;
      if (origin !== "null") {
        headers["Origin"] = origin;
      }
    } catch {
      // Extensions may provide malformed Referer values. Leave them untouched.
    }
  }

  private async prepareRequest(request: Request): Promise<{
    finalRequest: Request;
    requestBody: ArrayBuffer | string | FormData | undefined;
    requestHeaders: Record<string, string>;
  }> {
    let finalRequest = request;
    for (const interceptor of this.registeredInterceptors) {
      const requestInterceptor = this.selectorRegistry.selector(
        interceptor.interceptRequestSelectorId,
      );

      finalRequest = await requestInterceptor(finalRequest);
    }

    let requestBody: ArrayBuffer | string | FormData | undefined;
    if (finalRequest.body) {
      const rawBody = finalRequest.body;

      switch (typeof rawBody) {
        case "string": {
          requestBody = rawBody;
          break;
        }
        case "object": {
          if (rawBody instanceof ArrayBuffer) {
            requestBody = rawBody;
          } else {
            requestBody = Object.keys(rawBody).reduce((formData, key) => {
              const value = (rawBody as Record<string, unknown>)[key];
              if (typeof value === "string" || value instanceof Blob) {
                formData.append(key, value);
              } else if (value !== undefined && value !== null) {
                formData.append(key, String(value));
              }
              return formData;
            }, new FormData());
          }

          break;
        }
        default: {
          break;
        }
      }
    }

    const requestHeaders = this.mergeDefaultUserAgentHeaders({
      ...(finalRequest.headers ?? {}),
    });
    this.applyRefererOriginHeader(requestHeaders);
    if (finalRequest.cookies) {
      const rawCookies = finalRequest.cookies;
      requestHeaders["Cookie"] = Object.keys(finalRequest.cookies)
        .reduce(
          (headerValue, cookieKey) =>
            `${headerValue} ${cookieKey}=${rawCookies[cookieKey]};`,
          "",
        )
        .trim();
    }

    return { finalRequest, requestBody, requestHeaders };
  }

  private async encodeFormDataBody(
    body: FormData,
    headers: Record<string, string>,
  ): Promise<ArrayBuffer> {
    const response = new globalThis.Response(body);
    const contentType = response.headers.get("content-type");
    if (
      contentType &&
      !Object.keys(headers).some((key) => key.toLowerCase() === "content-type")
    ) {
      headers["Content-Type"] = contentType;
    }

    return response.arrayBuffer();
  }

  private responseCookies(fetchResponse: globalThis.Response): Cookie[] {
    const responseHeaders = fetchResponse.headers as Headers & {
      getSetCookie?: () => string[];
    };
    const cookieStrings =
      responseHeaders.getSetCookie?.() ??
      (responseHeaders.get("set-cookie")
        ? [responseHeaders.get("set-cookie")!]
        : []);

    return cookieStrings.map((cookieString) => {
      const properties = cookieString.split(";");
      const [rawName, ...rawValue] = properties.shift()!.split("=");
      const name = rawName!.trim();
      const value = rawValue.join("=");
      let domain: string | undefined;
      let path: string | undefined;
      let expires: Date | undefined;
      let maxAge: number | undefined;

      for (const property of properties) {
        const [rawPropertyName, ...rawPropertyValue] = property.split("=");
        const propertyName = rawPropertyName!.trim().toLowerCase();
        const propertyValue = rawPropertyValue.join("=").trim();
        switch (propertyName) {
          case "expires": {
            expires = new Date(propertyValue);
            continue;
          }
          case "max-age": {
            if (/^-?\d+$/.test(propertyValue)) {
              const parsedMaxAge = Number(propertyValue);
              if (Number.isFinite(parsedMaxAge)) {
                maxAge = parsedMaxAge;
              }
            }
            continue;
          }
          case "domain": {
            domain = propertyValue;
            continue;
          }
          case "path": {
            path = propertyValue;
            continue;
          }
          default: {
            continue;
          }
        }
      }

      return {
        name,
        value,
        domain: domain ?? parseURL(fetchResponse.url).hostname!,
        path: path ?? "/",
        expires:
          maxAge === undefined
            ? expires
            : new Date(Date.now() + maxAge * 1000),
      };
    });
  }

  private async applyResponseInterceptors(
    finalRequest: Request,
    finalResponse: Response,
    responseBody: ArrayBuffer,
  ): Promise<ArrayBuffer> {
    let finalArrayBuffer = responseBody;
    for (let i = this.registeredInterceptors.length - 1; i >= 0; i--) {
      const { interceptResponseSelectorId } = this.registeredInterceptors[i]!;
      const responseInterceptor = this.selectorRegistry.selector(
        interceptResponseSelectorId,
      );

      finalArrayBuffer = await responseInterceptor(
        finalRequest,
        finalResponse,
        finalArrayBuffer,
      );
    }

    return finalArrayBuffer;
  }

  async scheduleRequest(request: Request): Promise<[Response, ArrayBuffer]> {
    const requestId = this.nextRequestId++;
    let stage = "prepare";
    try {
      const { finalRequest, requestBody, requestHeaders } =
        await this.prepareRequest(request);
      const userAgent = this.headerValue(requestHeaders, "user-agent");
      const cookieNames = this.requestCookieNames(requestHeaders);
      console.log(
        `request[${requestId}] time=${new Date().toISOString()} ` +
          `start method=${finalRequest.method} ` +
          `target=${this.diagnosticTarget(finalRequest.url)} ` +
          `cookieNames=${JSON.stringify(cookieNames)} ` +
          `clearancePresent=${cookieNames.includes("cf_clearance")} ` +
          `userAgentFingerprint=${
            userAgent ? this.diagnosticFingerprint(userAgent) : null
          }`,
      );

      stage = "encodeBody";
      const nativeRequestBody =
        requestBody instanceof FormData
          ? await this.encodeFormDataBody(requestBody, requestHeaders)
          : requestBody;

      stage = "nativeFetch";
      const fetchResponse = await this.fetchNativeFollowingRedirects(
        finalRequest.url,
        finalRequest.method,
        nativeRequestBody,
        requestHeaders,
      );

      const responseHeaders: Record<string, string> = {};
      for (const [name, value] of fetchResponse.headers.entries()) {
        responseHeaders[name] = value;
      }
      const responseCookies = this.responseCookies(fetchResponse);
      const finalResponse: Response = {
        url: fetchResponse.url,
        headers: responseHeaders,
        status: fetchResponse.status,
        cookies: responseCookies,
        mimeType: fetchResponse.headers
          .get("content-type")
          ?.split(";", 1)[0]
          ?.trim(),
      };

      stage = "responseBody";
      const responseBody = await fetchResponse.arrayBuffer();
      console.log(
        `request[${requestId}] time=${new Date().toISOString()} ` +
          `response status=${fetchResponse.status} ` +
          `target=${this.diagnosticTarget(fetchResponse.url)} ` +
          `redirected=${fetchResponse.url !== finalRequest.url} ` +
          `setCookieNames=${JSON.stringify(
            Array.from(new Set(responseCookies.map((cookie) => cookie.name))).sort(),
          )} cfMitigated=${fetchResponse.headers.get("cf-mitigated")} ` +
          `server=${fetchResponse.headers.get("server")} ` +
          `cfRay=${fetchResponse.headers.get("cf-ray")} ` +
          `contentType=${finalResponse.mimeType ?? null} ` +
          `bodyBytes=${responseBody.byteLength}`,
      );

      stage = "responseInterceptors";
      const finalBody = await this.applyResponseInterceptors(
        finalRequest,
        finalResponse,
        responseBody,
      );
      console.log(
        `request[${requestId}] time=${new Date().toISOString()} ` +
          `success finalBodyBytes=${finalBody.byteLength}`,
      );
      return [finalResponse, finalBody];
    } catch (error) {
      console.error(
        `request[${requestId}] time=${new Date().toISOString()} ` +
          `failed stage=${stage} ` +
          `error=${this.errorSummary(error)}`,
      );
      throw error;
    }
  }

  private async fetchNativeFollowingRedirects(
    initialUrl: string,
    initialMethod: string,
    initialBody: ArrayBuffer | string | FormData | undefined,
    initialHeaders: Record<string, string>,
  ): Promise<globalThis.Response> {
    let url = initialUrl;
    let method = initialMethod;
    let body = initialBody;
    let headers = initialHeaders;

    for (let redirectCount = 0; redirectCount <= 20; redirectCount++) {
      const response = await this.fetchNativeWithTimeout(url, {
        method,
        body: body ?? null,
        headers,
        redirect: "manual",
      });
      const location = response.headers.get("location");

      if (
        location === null ||
        ![301, 302, 303, 307, 308].includes(response.status)
      ) {
        return response;
      }

      if (redirectCount === 20) {
        throw new Error("Too many redirects");
      }

      const redirectedUrl = new URL(location, url);
      const changesOrigin = new URL(url).origin !== redirectedUrl.origin;
      const changesToGet =
        response.status === 303 ||
        ((response.status === 301 || response.status === 302) &&
          method.toUpperCase() === "POST");

      url = redirectedUrl.toString();
      headers = Object.fromEntries(
        Object.entries(headers).filter(([name]) => {
          const normalizedName = name.toLowerCase();

          if (
            changesOrigin &&
            ["authorization", "cookie", "proxy-authorization"].includes(
              normalizedName,
            )
          ) {
            return false;
          }

          return (
            !changesToGet ||
            (normalizedName !== "content-length" &&
              normalizedName !== "content-type")
          );
        }),
      );

      if (changesToGet) {
        method = "GET";
        body = undefined;
      }
    }

    throw new Error("Too many redirects");
  }

  private async fetchNativeWithTimeout(
    url: string,
    init: RequestInit,
  ): Promise<globalThis.Response> {
    const controller =
      typeof AbortController === "function" ? new AbortController() : undefined;
    let timeout: ReturnType<typeof setTimeout> | undefined;

    try {
      return await Promise.race([
        fetch(url, {
          ...init,
          ...(controller ? { signal: controller.signal } : {}),
        }),
        new Promise<never>((_, reject) => {
          timeout = setTimeout(() => {
            controller?.abort();
            reject(
              new Error(
                `Native fetch timed out after ${MockRequestManager.nativeFetchTimeoutMs}ms`,
              ),
            );
          }, MockRequestManager.nativeFetchTimeoutMs);
        }),
      ]);
    } finally {
      if (timeout !== undefined) {
        clearTimeout(timeout);
      }
    }
  }

}
