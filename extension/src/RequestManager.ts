import { Cookie, parseURL, Request, RequestInterceptor, Response, ResponseInterceptor, SelectorID, SelectorRegistry } from "@paperback/types";

type RequestManager = Pick<
  typeof Application,
  | 'registerInterceptor'
  | 'unregisterInterceptor'
  | 'scheduleRequest'
  | 'setRedirectHandler'
  | 'getDefaultUserAgent'
>

export class MockRequestManager implements RequestManager {
  private selectorRegistry: SelectorRegistry
  private registeredInterceptors: {
    interceptorId: string
    interceptRequestSelectorId: SelectorID<RequestInterceptor>
    interceptResponseSelectorId: SelectorID<ResponseInterceptor>
  }[]

  private userAgent: string

  constructor(selectorRegistry: SelectorRegistry) {
    this.selectorRegistry = selectorRegistry
    this.registeredInterceptors = []
    this.userAgent = typeof navigator !== 'undefined' ? navigator.userAgent : 'Mozilla/5.0 (Linux; Android 16) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.7680.120 Mobile Safari/537.36'
  }

  registerInterceptor(
    interceptorId: string,
    interceptRequestSelectorId: SelectorID<RequestInterceptor>,
    interceptResponseSelectorId: SelectorID<ResponseInterceptor>
  ): void {
    this.unregisterInterceptor(interceptorId)
    this.registeredInterceptors.push({
      interceptorId,
      interceptRequestSelectorId,
      interceptResponseSelectorId,
    })
  }

  unregisterInterceptor(interceptorId: string): void {
    for (let i = 0; i < this.registeredInterceptors.length; i++) {
      const { interceptorId: registeredInterceptorId } =
        this.registeredInterceptors[i]!

      if (interceptorId == registeredInterceptorId) {
        this.registeredInterceptors.splice(i, 1)
        return
      }
    }
  }

  setRedirectHandler(): void { }

  async getDefaultUserAgent(): Promise<string> {
    return this.userAgent
  }

  async scheduleRequest(request: Request): Promise<[Response, ArrayBuffer]> {
    let finalRequest = request
    for (const interceptor of this.registeredInterceptors) {
      const requestInterceptor = this.selectorRegistry.selector(
        interceptor.interceptRequestSelectorId
      )

      finalRequest = await requestInterceptor(request)
    }

    let requestBody: ArrayBuffer | string | FormData | undefined = undefined
    if (finalRequest.body) {
      const rawBody = finalRequest.body

      switch (typeof rawBody) {
        case 'string': {
          requestBody = rawBody
          break
        }
        case 'object': {
          if (rawBody instanceof ArrayBuffer) {
            requestBody = rawBody
          } else {
            requestBody = Object.keys(rawBody).reduce((formData, key) => {
              const value = (rawBody as Record<string, unknown>)[key]
              if (typeof value === 'string' || value instanceof Blob) {
                formData.append(key, value)
              } else if (value !== undefined && value !== null) {
                formData.append(key, String(value))
              }
              return formData
            }, new FormData())
          }

          break
        }
        default: {
          break
        }
      }
    }

    const requestHeaders = finalRequest.headers ?? {}
    if (finalRequest.cookies) {
      const rawCookies = finalRequest.cookies
      requestHeaders['Cookie'] = Object.keys(finalRequest.cookies)
        .reduce(
          (headerValue, cookieKey) =>
            `${headerValue} ${cookieKey}=${rawCookies[cookieKey]};`,
          ''
        )
        .trim()
    }

    const fetchResponse = await fetch(finalRequest.url, {
      method: finalRequest.method,
      body: requestBody ?? null,
      headers: requestHeaders,
    })

    const responseHeaders: Record<string, string> = {}
    for (const [name, value] of fetchResponse.headers.entries()) {
      responseHeaders[name] = value
    }

    const responseCookies: Cookie[] = []
    for (const cookieString of fetchResponse.headers.getSetCookie()) {
      const properties = cookieString.split(';')
      const [name, value] = properties.shift()!.split('=')
      let domain: string | undefined
      let path: string | undefined
      let expires: Date | undefined
      for (const str of properties) {
        const [name, value] = str.split('=')
        switch (name!.toLowerCase()) {
          case 'expires': {
            expires = new Date(value!)
            continue
          }
          case 'max-age': {
            expires = new Date(Date.now() + Number(value!) * 1000)
            continue
          }
          case 'domain': {
            domain = value!
            continue
          }
          default: {
            continue
          }
        }
      }

      responseCookies.push({
        name: name!,
        value: value!,
        domain: domain ?? parseURL(fetchResponse.url).hostname!,
        path: path ?? '/',
        expires: expires ?? new Date(),
      })
    }

    const finalResponse: Response = {
      url: fetchResponse.url,
      headers: responseHeaders,
      status: fetchResponse.status,
      cookies: responseCookies,
    }

    let finalArrayBuffer = await fetchResponse.arrayBuffer()

    for (let i = this.registeredInterceptors.length - 1; i >= 0; i--) {
      const { interceptResponseSelectorId } = this.registeredInterceptors[i]!
      const responseInterceptor = this.selectorRegistry.selector(
        interceptResponseSelectorId
      )

      finalArrayBuffer = await responseInterceptor(
        finalRequest,
        finalResponse,
        finalArrayBuffer
      )
    }

    return [finalResponse, finalArrayBuffer]
  }
}