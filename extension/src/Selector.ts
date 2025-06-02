import { PaperbackPolyfills } from "./PaperbackPolyfills";
import {} from "@paperback/types";

class SelectorRef {
  private objRef: WeakRef<any>;

  get value(): any | undefined {
    const obj = this.objRef.deref();
    if (!obj) {
      return undefined;
    }

    const value = obj[this.key];
    if (typeof value === "function") {
      return value.bind(obj);
    } else {
      return value;
    }
  }

  constructor(obj: any, private key: string | number | symbol) {
    this.objRef = new WeakRef(obj);
  }
}

PaperbackPolyfills.SelectorRegistry = class {
  private static registry: Record<string, SelectorRef> = {};

  static registerSelector(id: string, obj: any, key: any) {
    this.registry[id] = new SelectorRef(obj, key);
  }

  static unregisterSelector(id: string) {
    delete this.registry[id];
  }

  static selector<K>(id: SelectorID<K>): K {
    return this.registry[id as string]?.value;
  }
};

PaperbackPolyfills.Selector = function (obj, symbol) {
  // This is good enough, we need to generate ids that are relatively unique to each other per instance
  function relative_uuid() {
    return `${Date.now()}-${Math.random().toString().slice(2)}`;
  }

  const canonicalId = (function (obj: any, symbol: string) {
    const key = `$__selector_${symbol}`;
    if (obj[key]) {
      return obj[key];
    } else {
      const id = relative_uuid();
      Object.defineProperty(obj, key, { enumerable: true, value: id });
      return id;
    }
  })(obj, symbol as string);

  Application.SelectorRegistry.registerSelector(
    canonicalId,
    obj,
    symbol as any
  );
  return canonicalId;
};

globalThis.callBinding = async function <K>(id: SelectorID<K>, ...args: any[]) {
  console.log(`Calling binding ${id}`);
  let binding = Application.SelectorRegistry.selector(id);
  // @ts-ignore
  return await binding(...args);
};
