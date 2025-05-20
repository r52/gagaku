import {
  RequestManager,
  Request,
  Response,
  SourceInterceptor,
} from "@paperback/types";
import { PaperbackPolyfills } from "./PBPolyfills";
import axios, { Method } from "axios";
import { Buffer } from "buffer";

const sleep = function (ms: number): Promise<void> {
  return new Promise((resolve) => setTimeout(resolve, ms));
};

class Mutex {
  private mutex = Promise.resolve();

  lock(): Promise<() => void> {
    return new Promise((resolve) => {
      this.mutex = this.mutex.then(() => new Promise(resolve));
    });
  }
}

class MockRequestManager implements RequestManager {
  requestTimeout: number;
  requestsPerSecond: number;

  private lastRequest: number = Date.now();
  private bufferPerRequest: number;
  private mutex: Mutex;

  constructor(
    public interceptor?: SourceInterceptor,
    requestsPerSecond?: number,
    requestTimeout?: number
  ) {
    this.requestTimeout = requestTimeout ?? 20_000;
    this.requestsPerSecond = requestsPerSecond ?? 2.5;
    this.bufferPerRequest = 1000 / this.requestsPerSecond;

    this.mutex = new Mutex();
  }

  async getDefaultUserAgent() {
    return "";
  }

  async schedule(request: Request, retryCount: number) {
    const unlock = await this.mutex.lock();
    try {
      const timeSinceLastRequest = Date.now() - this.lastRequest;
      if (timeSinceLastRequest <= this.bufferPerRequest) {
        console.log(`rate limit hit, sleeping for ${this.bufferPerRequest}`);
        await sleep(this.bufferPerRequest);
      }
      this.lastRequest = Date.now();
    } finally {
      unlock();
    }

    // Pass this request through the interceptor if one exists
    if (this.interceptor) {
      request = await this.interceptor.interceptRequest(request);
    }

    // Append any cookies into the header properly
    let headers: any = request.headers ?? {};

    let cookieData = "";
    for (let cookie of request.cookies ?? [])
      cookieData += `${cookie.name}=${cookie.value};`;

    headers["cookie"] = cookieData;

    // If no user agent has been supplied, default to a basic Paperback-iOS agent
    // headers['user-agent'] = headers["user-agent"] ?? 'Paperback-iOS'

    // If we are using a urlencoded form data as a post body, we need to decode the request for Axios
    let decodedData = request.data;
    if (typeof decodedData == "object") {
      if (
        headers["content-type"]?.includes("application/x-www-form-urlencoded")
      ) {
        decodedData = "";
        Object.keys(request.data).forEach((attribute) => {
          if (decodedData.length > 0) {
            decodedData += "&";
          }
          decodedData += `${attribute}=${request.data[attribute]}`;
        });
      }
    }

    // We must first get the response object from Axios, and then transcribe it into our own Response type before returning
    let response = await axios(`${request.url}${request.param ?? ""}`, {
      method: <Method>request.method,
      headers: headers,
      data: decodedData,
      timeout: this.requestTimeout || 0,
      responseType: "arraybuffer",
    });

    let responsePacked: Response = {
      rawData: App.createRawData({ byteArray: response.data as Buffer }),
      data: Buffer.from(response.data, "binary").toString(),
      status: response.status,
      headers: response.headers,
      request: request,
    };

    // Pass this through the response interceptor if one exists
    if (this.interceptor) {
      responsePacked = await this.interceptor.interceptResponse(responsePacked);
    }

    return responsePacked;
  }
}

PaperbackPolyfills.createRequestManager = function (info): RequestManager {
  return new MockRequestManager(
    info.interceptor,
    info.requestsPerSecond,
    info.requestTimeout
  );
};
