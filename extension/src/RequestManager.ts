import type {
  Cookie,
  Request,
  RequestInterceptor,
  Response,
  ResponseInterceptor,
  SelectorID,
  SelectorRegistry,
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

    const response = new globalThis.Response(body);
    const contentType = response.headers.get("content-type");
    if (
      contentType &&
      !Object.keys(headers).some((key) => key.toLowerCase() === "content-type")
    ) {
      headers["Content-Type"] = contentType;
    }

    return Application.base64Encode(
      await response.arrayBuffer(),
    ) as unknown as string;
  }

  async scheduleRequest(request: Request): Promise<[Response, ArrayBuffer]> {
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

    // POST to proxy /fetch endpoint (Dart HttpClient bypasses CORS)
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

    // Build response object
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

    // Convert body from base64 to ArrayBuffer
    let finalArrayBuffer: ArrayBuffer;
    if (proxyData.body) {
      finalArrayBuffer = base64ToBytes(proxyData.body).buffer as ArrayBuffer;
    } else {
      finalArrayBuffer = new ArrayBuffer(0);
    }

    // Run response interceptors (unchanged)
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

    return [finalResponse, finalArrayBuffer];
  }
}
