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
import { base64ToBytes } from "./Base64";

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

  private userAgent: string;

  constructor(selectorRegistry: SelectorRegistry) {
    this.selectorRegistry = selectorRegistry;
    this.registeredInterceptors = [];
    this.userAgent =
      typeof navigator !== "undefined"
        ? navigator.userAgent
        : "Mozilla/5.0 (Linux; Android 16) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.7778.121 Mobile Safari/537.36";
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
    return this.userAgent;
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

    const requestHeaders = { ...(finalRequest.headers ?? {}) };
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

  private async encodeRequestBody(
    body: ArrayBuffer | string | FormData | undefined,
    headers: Record<string, string>,
  ): Promise<string | undefined> {
    if (body === undefined) {
      return undefined;
    }

    if (typeof body === "string") {
      return Application.base64Encode(
        new TextEncoder().encode(body).buffer,
      ) as unknown as string;
    }

    if (body instanceof ArrayBuffer) {
      return Application.base64Encode(body) as unknown as string;
    }

    return Application.base64Encode(
      await this.encodeFormDataBody(body, headers),
    ) as unknown as string;
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
            expires = new Date(Date.now() + Number(propertyValue) * 1000);
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
        expires: expires ?? new Date(),
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

  private async scheduleNativeFetchRequest(
    request: Request,
  ): Promise<[Response, ArrayBuffer]> {
    const { finalRequest, requestBody, requestHeaders } =
      await this.prepareRequest(request);
    const nativeRequestBody =
      requestBody instanceof FormData
        ? await this.encodeFormDataBody(requestBody, requestHeaders)
        : requestBody;

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

    const finalResponse: Response = {
      url: fetchResponse.url,
      headers: responseHeaders,
      status: fetchResponse.status,
      cookies: this.responseCookies(fetchResponse),
    };

    const responseBody = await fetchResponse.arrayBuffer();

    return [
      finalResponse,
      await this.applyResponseInterceptors(
        finalRequest,
        finalResponse,
        responseBody,
      ),
    ];
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

  private async scheduleProxyRequest(
    request: Request,
  ): Promise<[Response, ArrayBuffer]> {
    const { finalRequest, requestBody, requestHeaders } =
      await this.prepareRequest(request);

    const proxyUrl = `http://127.0.0.1:${(window as any).__gagaku_proxy_port}/fetch`;
    const proxyResponse = await fetch(proxyUrl, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        url: finalRequest.url,
        method: finalRequest.method,
        headers: requestHeaders,
        body: await this.encodeRequestBody(
          requestBody,
          requestHeaders,
        ),
      }),
    });

    const proxyData = (await proxyResponse.json()) as {
      url?: string;
      status?: number;
      headers?: Record<string, string>;
      cookies?: Array<{
        name: string;
        value: string;
        domain: string;
        path: string;
        expires: string;
      }>;
      body?: string;
      error?: string;
    };

    if (proxyData.error) {
      throw new Error(`Proxy fetch error: ${proxyData.error}`);
    }

    const responseHeaders: Record<string, string> = proxyData.headers ?? {};
    const responseCookies: Cookie[] = (proxyData.cookies ?? []).map((c) => ({
      name: c.name,
      value: c.value,
      domain: c.domain,
      path: c.path,
      expires: new Date(c.expires),
    }));

    const finalResponse: Response = {
      url: proxyData.url ?? finalRequest.url,
      headers: responseHeaders,
      status: proxyData.status ?? 0,
      cookies: responseCookies,
    };

    let finalArrayBuffer: ArrayBuffer;
    if (proxyData.body) {
      finalArrayBuffer = base64ToBytes(proxyData.body).buffer as ArrayBuffer;
    } else {
      finalArrayBuffer = new ArrayBuffer(0);
    }

    return [
      finalResponse,
      await this.applyResponseInterceptors(
        finalRequest,
        finalResponse,
        finalArrayBuffer,
      ),
    ];
  }

  async scheduleRequest(request: Request): Promise<[Response, ArrayBuffer]> {
    if ((globalThis as any).__gagaku_use_native_fetch === true) {
      return this.scheduleNativeFetchRequest(request);
    }

    return this.scheduleProxyRequest(request);
  }
}
