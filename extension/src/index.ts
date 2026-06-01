import { MockDiscoverSectionManager } from "./DiscoverSectionManager";
import { MockSelectorRegistry } from "./Selector";
import { MockRequestManager } from "./RequestManager";
import { FormManager } from "./FormManager";
import { installPaperbackCanvasPolyfill } from "./CanvasPolyfill";
import { base64ToBytes, bytesToBase64, bytesToBinaryString } from "./Base64";

import { decodeHTMLStrict } from "entities";
import type { Request, SelectorID } from "@paperback/types";
import md5 from "md5";

installPaperbackCanvasPolyfill();

export function ApplicationPolyfill(): typeof Application {
  let stateStorage: Record<string, unknown> = {};
  const secureStateStorage: Record<string, unknown> = {};

  const selectorRegistry = new MockSelectorRegistry();
  const requestManager = new MockRequestManager(selectorRegistry);

  // unused
  // TODO support this?
  const discoverSectionManager = new MockDiscoverSectionManager(
    selectorRegistry,
  );
  // <!-- unused

  const formManager = new FormManager();

  return {
    decodeHTMLEntities: decodeHTMLStrict,

    sleep: (seconds) =>
      new Promise((resolve) => {
        setTimeout(resolve, seconds * 1000);
      }),

    registerDiscoverSection:
      discoverSectionManager.registerDiscoverSection.bind(
        discoverSectionManager,
      ),
    unregisterDiscoverSection:
      discoverSectionManager.unregisterDiscoverSection.bind(
        discoverSectionManager,
      ),
    registeredDiscoverSections:
      discoverSectionManager.registeredDiscoverSections.bind(
        discoverSectionManager,
      ),
    invalidateDiscoverSections:
      discoverSectionManager.invalidateDiscoverSections.bind(
        discoverSectionManager,
      ),

    registerInterceptor:
      requestManager.registerInterceptor.bind(requestManager),
    unregisterInterceptor:
      requestManager.unregisterInterceptor.bind(requestManager),
    setRedirectHandler: requestManager.setRedirectHandler.bind(requestManager),
    getDefaultUserAgent:
      requestManager.getDefaultUserAgent.bind(requestManager),
    scheduleRequest: requestManager.scheduleRequest.bind(requestManager),

    arrayBufferToUTF8String: (arrayBuffer) =>
      new TextDecoder("utf-8").decode(arrayBuffer),
    arrayBufferToASCIIString: (arrayBuffer) =>
      new TextDecoder("ascii").decode(arrayBuffer),
    arrayBufferToUTF16String: (arrayBuffer) =>
      new TextDecoder("utf-16").decode(arrayBuffer),

    base64Encode: (value) => {
      if (typeof value === "string") {
        return btoa(value) as typeof value;
      } else {
        return bytesToBase64(new Uint8Array(value)) as unknown as typeof value;
      }
    },
    base64Decode: (value) => {
      if (typeof value === "string") {
        return atob(value) as typeof value;
      } else {
        const base64Bytes = new Uint8Array(value);
        const base64String = bytesToBinaryString(base64Bytes);
        return base64ToBytes(base64String).buffer as typeof value;
      }
    },

    crypto_md5Hash: (value: string | ArrayBuffer) => {
      let data: Uint8Array | string;
      if (typeof value === "string") {
        data = value;
      } else {
        data = new Uint8Array(value);
      }

      return md5(data);
    },

    getSecureState: (key) => secureStateStorage[key],

    setSecureState: (value, key) => {
      if ("gagaku" in globalThis) {
        if (value === undefined) {
          value = null;
        }

        secureStateStorage[key] = value;
        globalThis.gagaku?.callHandler(
          "setExtensionSecureState",
          secureStateStorage,
        );
      } else {
        secureStateStorage[key] = value;
      }
    },

    getState: (key) => stateStorage[key],

    setState: (value, key) => {
      if ("gagaku" in globalThis) {
        if (value === undefined) {
          value = null;
        }

        stateStorage[key] = value;
        globalThis.gagaku?.callHandler("setExtensionState", stateStorage);
      } else {
        stateStorage[key] = value;
      }
    },

    resetAllState: () => {
      stateStorage = {};

      if ("gagaku" in globalThis) {
        globalThis.gagaku?.callHandler("resetAllState");
      }
    },

    executeInWebView: (context) => {
      if ("gagaku" in globalThis) {
        return globalThis.gagaku?.callHandler("executeInWebView", context);
      }

      throw new Error("`executeInWebView` is not available in this context.");
    },

    // gagaku
    createExtensionState: (state: Record<string, any> | undefined) => {
      console.log(`registering extension state: ${state}`);
      if (state) {
        Object.assign(stateStorage, state);
      }
    },

    createExtensionSecureState: (state: Record<string, any> | undefined) => {
      if (state) {
        Object.assign(secureStateStorage, state);
      }
    },

    callBinding: async <K>(id: SelectorID<K>, ...args: any[]) => {
      console.log(`Calling binding ${id}`);
      const binding = selectorRegistry.selector(id);
      try {
        // @ts-expect-error
        return await binding(...args);
      } catch (e: any) {
        if (e?.type === "confirmationError") {
          return {
            __isFormConfirmationError: true,
            message: e.message,
            onConfirmation: e.onConfirmation,
          };
        }
        throw e;
      }
    },

    // @ts-expect-error
    formDidChange: (formId: string) => {
      if ("gagaku" in globalThis) {
        globalThis.gagaku?.callHandler("formDidChange", formId);
      }
    },

    initializeForm: formManager.initializeForm.bind(formManager),
    uninitializeForm: formManager.uninitializeForm.bind(formManager),
    uninitializeForms: formManager.uninitializeForms.bind(formManager),
    getForm: formManager.getForm.bind(formManager),

    isResourceLimited: false,
    filterAdultTitles: false,
    filterMatureTitles: false,

    Selector: selectorRegistry.Selector.bind(selectorRegistry),
    SelectorRegistry: selectorRegistry,

    processImageRequest: async (url: string) => {
      // 1. Execute the request through the proxy (handles CORS + interceptors)
      const request: Request = { url: url, method: "GET" };
      const [, body] = await requestManager.scheduleRequest(request);

      // 2. Store the image data via the proxy (Dart-side completer)
      const proxyUrl = `http://127.0.0.1:${window.__gagaku_proxy_port}/image`;
      await fetch(proxyUrl, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          url: url,
          body: Application.base64Encode(body),
        }),
      });

      return { stored: true, url: url };
    },
  };
}

globalThis.Application = ApplicationPolyfill();
