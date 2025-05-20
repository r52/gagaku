import { SecureStateManager, SourceStateManager } from "@paperback/types";
import { PaperbackPolyfills } from "./PBPolyfills";
import "./interface";

class GagakuSecureStateManager implements SecureStateManager {
  private objectStore: Record<string, any> = {};

  async store(key: string, value: any) {
    if ("gagaku" in globalThis) {
      if (value === undefined) {
        value = null;
      }
      globalThis.gagaku?.callHandler("setSecureState", key, value);
    } else {
      this.objectStore[key] = value;
    }
  }

  async retrieve(key: string) {
    if ("gagaku" in globalThis) {
      return globalThis.gagaku?.callHandler("getSecureState", key);
    } else {
      return this.objectStore[key];
    }
  }
}

class GagakuSourceStateManager implements SourceStateManager {
  readonly keychain: SecureStateManager = new GagakuSecureStateManager();
  private objectStore: Record<string, any> = {};

  async store(key: string, value: any) {
    if ("gagaku" in globalThis) {
      if (value === undefined) {
        value = null;
      }
      globalThis.gagaku?.callHandler("setState", key, value);
    } else {
      this.objectStore[key] = value;
    }
  }

  async retrieve(key: string) {
    if ("gagaku" in globalThis) {
      return globalThis.gagaku?.callHandler("getState", key);
    } else {
      return this.objectStore[key];
    }
  }
}

PaperbackPolyfills.createSourceStateManager = function (): SourceStateManager {
  return new GagakuSourceStateManager();
};
