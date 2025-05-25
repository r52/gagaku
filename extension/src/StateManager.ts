import { PaperbackPolyfills } from "./PaperbackPolyfills";

const objectStore: Record<string, any> = {};
const secureObjectStore: Record<string, any> = {};

PaperbackPolyfills.getState = function (key: string): unknown | undefined {
  return objectStore[key];
};

PaperbackPolyfills.setState = function (value: unknown, key: string): void {
  if ("gagaku" in globalThis) {
    if (value === undefined) {
      value = null;
    }

    objectStore[key] = value;
    globalThis.gagaku?.callHandler("setExtensionState", objectStore);
  } else {
    objectStore[key] = value;
  }
};

PaperbackPolyfills.getSecureState = function (
  key: string
): unknown | undefined {
  return secureObjectStore[key];
};

PaperbackPolyfills.resetAllState = function (): void {
  Object.keys(objectStore).forEach((key) => delete objectStore[key]);

  if ("gagaku" in globalThis) {
    globalThis.gagaku?.callHandler("resetAllState");
  }
};

PaperbackPolyfills.setSecureState = function (
  value: unknown,
  key: string
): void {
  if ("gagaku" in globalThis) {
    if (value === undefined) {
      value = null;
    }

    secureObjectStore[key] = value;
    globalThis.gagaku?.callHandler(
      "setExtensionSecureState",
      secureObjectStore
    );
  } else {
    secureObjectStore[key] = value;
  }
};

globalThis.createExtensionState = function (
  state: Record<string, any> | undefined
) {
  console.log(`registering extension state: ${state}`);
  if (state) {
    Object.assign(objectStore, state);
  }
};

globalThis.createExtensionSecureState = function (
  state: Record<string, any> | undefined
) {
  if (state) {
    Object.assign(secureObjectStore, state);
  }
};
