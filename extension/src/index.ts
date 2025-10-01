import { MockDiscoverSectionManager } from "./DiscoverSectionManager";
import { MockSearchFilterManager } from "./SearchFilterManager";
import { MockSelectorRegistry } from "./Selector";
import { MockRequestManager } from "./RequestManager";
import { FormManager } from "./FormManager";

import { decodeHTMLStrict } from "entities";
import { SelectorID } from "@paperback/types";

export function ApplicationPolyfill(): typeof Application {
  let stateStorage: Record<string, unknown> = {}
  const secureStateStorage: Record<string, unknown> = {}

  const selectorRegistry = new MockSelectorRegistry()
  const requestManager = new MockRequestManager(selectorRegistry)

  // unused
  // TODO support this?
  const discoverSectionManager = new MockDiscoverSectionManager(
    selectorRegistry
  )
  const searchFilterManager = new MockSearchFilterManager()
  // <!-- unused

  const formManager = new FormManager();

  return {
    decodeHTMLEntities: decodeHTMLStrict,

    sleep: function (seconds) {
      return new Promise((resolve) => {
        setTimeout(resolve, seconds * 1000)
      })
    },

    registerDiscoverSection:
      discoverSectionManager.registerDiscoverSection.bind(
        discoverSectionManager
      ),
    unregisterDiscoverSection:
      discoverSectionManager.unregisterDiscoverSection.bind(
        discoverSectionManager
      ),
    registeredDiscoverSections:
      discoverSectionManager.registeredDiscoverSections.bind(
        discoverSectionManager
      ),
    invalidateDiscoverSections:
      discoverSectionManager.invalidateDiscoverSections.bind(
        discoverSectionManager
      ),

    registerSearchFilter:
      searchFilterManager.registerSearchFilter.bind(searchFilterManager),
    unregisterSearchFilter:
      searchFilterManager.unregisterSearchFilter.bind(searchFilterManager),
    registeredSearchFilters:
      searchFilterManager.registeredSearchFilters.bind(searchFilterManager),
    invalidateSearchFilters:
      searchFilterManager.invalidateSearchFilters.bind(searchFilterManager),

    registerInterceptor:
      requestManager.registerInterceptor.bind(requestManager),
    unregisterInterceptor:
      requestManager.unregisterInterceptor.bind(requestManager),
    setRedirectHandler: requestManager.setRedirectHandler.bind(requestManager),
    getDefaultUserAgent:
      requestManager.getDefaultUserAgent.bind(requestManager),
    scheduleRequest: requestManager.scheduleRequest.bind(requestManager),

    arrayBufferToUTF8String: function (arrayBuffer) {
      return new TextDecoder('utf-8').decode(arrayBuffer)
    },
    arrayBufferToASCIIString: function (arrayBuffer) {
      return new TextDecoder('ascii').decode(arrayBuffer)
    },
    arrayBufferToUTF16String: function (arrayBuffer) {
      return new TextDecoder('utf-16').decode(arrayBuffer)
    },

    base64Encode: function (value) {
      if (typeof value === 'string') {
        return Buffer.from(value, 'utf-8').toString('base64') as typeof value
      } else {
        const bytes = new Uint8Array(value)
        const binary = bytes.reduce(
          (str, byte) => str + String.fromCharCode(byte),
          ''
        )

        const base64String = btoa(binary) // Base64-encoded string

        // Now convert that string to an ArrayBuffer (binary representation of base64 string)
        const base64Buffer = new Uint8Array(base64String.length)
        for (let i = 0; i < base64String.length; i++) {
          base64Buffer[i] = base64String.charCodeAt(i)
        }

        return base64Buffer.buffer as typeof value
      }
    },
    base64Decode: function (value) {
      if (typeof value === 'string') {
        return Buffer.from(value, 'base64').toString('utf-8') as typeof value
      } else {
        const base64Bytes = new Uint8Array(value)
        const base64String = String.fromCharCode(...base64Bytes)

        const binaryString = atob(base64String)
        const decodedBytes = new Uint8Array(binaryString.length)
        for (let i = 0; i < binaryString.length; i++) {
          decodedBytes[i] = binaryString.charCodeAt(i)
        }

        return decodedBytes.buffer as typeof value
      }
    },

    getSecureState: function (key) {
      return secureStateStorage[key]
    },

    setSecureState: function (value, key) {
      if ("gagaku" in globalThis) {
        if (value === undefined) {
          value = null;
        }

        secureStateStorage[key] = value;
        globalThis.gagaku?.callHandler(
          "setExtensionSecureState",
          secureStateStorage
        );
      } else {
        secureStateStorage[key] = value;
      }
    },

    getState: function (key) {
      return stateStorage[key]
    },

    setState: function (value, key) {
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

    resetAllState: function () {
      stateStorage = {}

      if ("gagaku" in globalThis) {
        globalThis.gagaku?.callHandler("resetAllState");
      }
    },

    executeInWebView: function () {
      throw new Error('Not Implemented')
    },

    // gagaku
    createExtensionState: function (
      state: Record<string, any> | undefined
    ) {
      console.log(`registering extension state: ${state}`);
      if (state) {
        Object.assign(stateStorage, state);
      }
    },

    createExtensionSecureState: function (
      state: Record<string, any> | undefined
    ) {
      if (state) {
        Object.assign(secureStateStorage, state);
      }
    },

    callBinding: async function <K>(id: SelectorID<K>, ...args: any[]) {
      console.log(`Calling binding ${id}`);
      let binding = selectorRegistry.selector(id);
      // @ts-ignore
      return await binding(...args);
    },

    // @ts-expect-error
    formDidChange: function (formId: string) {
      if ("gagaku" in globalThis) {
        globalThis.gagaku?.callHandler("formDidChange", formId);
      }
    },

    initializeForm: formManager.initializeForm.bind(formManager),
    uninitializeForms: formManager.uninitializeForms.bind(formManager),
    getForm: formManager.getForm.bind(formManager),

    isResourceLimited: false,
    filterAdultTitles: false,
    filterMatureTitles: false,

    Selector: selectorRegistry.Selector.bind(selectorRegistry),
    SelectorRegistry: selectorRegistry,
  }
}

globalThis.Application = ApplicationPolyfill();
