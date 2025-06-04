// import { RequestManager, Request, Response, SourceInterceptor } from "@paperback/types"

import { Buffer } from "buffer";
import axios, { Method } from "axios";
import { Request, Response } from "@paperback/types";
import { PaperbackPolyfills } from "./PaperbackPolyfills";

const interceptors: Record<
  string,
  [SelectorID<RequestInterceptor>, SelectorID<ResponseInterceptor>]
> = {};

type RequestInterceptor = (request: Request) => Promise<Request>;
type ResponseInterceptor = (
  request: Request,
  response: Response,
  data: ArrayBuffer
) => Promise<ArrayBuffer>;

type RedirectHandler = (
  proposedRequest: Request,
  redirectedResponse: Response
) => Promise<Request | undefined>;

PaperbackPolyfills.registerInterceptor = function (
  interceptorId: string,
  interceptRequestSelectorId: SelectorID<RequestInterceptor>,
  interceptResponseSelectorId: SelectorID<ResponseInterceptor>
): void {
  console.log(`registering interceptor ${interceptorId}`);
  interceptors[interceptorId] = [
    interceptRequestSelectorId,
    interceptResponseSelectorId,
  ];
};

PaperbackPolyfills.unregisterInterceptor = function (
  interceptorId: string
): void {
  delete interceptors[interceptorId];
};

PaperbackPolyfills.setRedirectHandler = function (
  redirectHandlerSelectorId: SelectorID<RedirectHandler>
): void {
  // TODO
};

PaperbackPolyfills.getDefaultUserAgent = async function (): Promise<string> {
  return "";
  // console.log(`Returning user agent`);
  // return "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:138.0) Gecko/20100101 Firefox/138.0";
};

PaperbackPolyfills.scheduleRequest = async function (
  request: Request
): Promise<[Response, ArrayBuffer]> {
  //console.log(`interceptor count: ${Object.keys(interceptors).length}`);
  // Pass this request through the interceptor if any exists
  if (Object.keys(interceptors).length > 0) {
    for (let [_, cep] of Object.entries(interceptors)) {
      let [reqcept, _] = cep;
      let interceptor = Application.SelectorRegistry.selector(reqcept);
      request = await interceptor(request);
    }
  }

  // Append any cookies into the header properly
  let headers: any = request.headers ?? {};

  let cookieData = "";
  for (let [name, value] of Object.entries(request.cookies ?? {}))
    cookieData += `${name}=${value};`;

  headers["cookie"] = cookieData;

  // If no user agent has been supplied, default to a basic Paperback-iOS agent
  // headers['user-agent'] = headers["user-agent"] ?? 'Paperback-iOS'

  // If we are using a urlencoded form data as a post body, we need to decode the request for Axios
  let decodedData = request.body;
  if (typeof decodedData == "object") {
    if (
      headers["content-type"]?.includes("application/x-www-form-urlencoded")
    ) {
      decodedData = "";
      Object.keys(<Object>request.body).forEach((attribute) => {
        if ((<string>decodedData).length > 0) {
          decodedData += "&";
        }
        decodedData += `${attribute}=${
          request!.body![attribute as keyof typeof request.body]
        }`;
      });
    }
  }

  // We must first get the response object from Axios, and then transcribe it into our own Response type before returning
  let response = await axios(`${request.url}`, {
    method: <Method>request.method,
    headers: headers,
    data: decodedData,
    timeout: 10000,
    responseType: "arraybuffer",
  });

  let responsePacked: Response = {
    url: request.url,
    headers: <Record<string, string>>response.headers,
    status: response.status,
    cookies: [], // TODO
  };

  let data = Buffer.from(response.data, "binary").buffer;

  // Pass this through the response interceptor if any exists
  if (Object.keys(interceptors).length > 0) {
    for (let [_, cep] of Object.entries(interceptors)) {
      let [_, respcept] = cep;
      let interceptor = Application.SelectorRegistry.selector(respcept);
      data = await interceptor(request, responsePacked, data);
    }
  }

  return [responsePacked, data];
};
