import axios, {
  AxiosResponse,
  InternalAxiosRequestConfig,
  AxiosHeaders,
} from "axios";
import { Base64 } from "js-base64";

const PROXY_URL = "http://localhost:8527";

const base64UrlEncode = (s: string): string => {
  return Base64.encode(s, true);
};

const UNSAFE_HEADERS = new Set(["user-agent", "referer"]);

const requestInterceptor = (req: InternalAxiosRequestConfig) => {
  if (!("retried" in req)) {
    req.url = `${PROXY_URL}/proxy/${base64UrlEncode(
      req.url + (req.params ?? "")
    )}`;
  }

  UNSAFE_HEADERS.forEach((header) => {
    if (req.headers instanceof AxiosHeaders) {
      req.headers.delete(header);
    }
  });
  return req;
};

const responseInterceptor = (res: AxiosResponse) => {
  return res;
};

const retryInterceptor = (error: any) => {
  if (!error.config.retried) {
    error.config.retried = true;
    return axios.request(error.config);
  }
  return Promise.reject(error);
};

axios.interceptors.request.use(requestInterceptor);
axios.interceptors.response.use(responseInterceptor, retryInterceptor);
