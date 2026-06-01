import { SelectorID, SelectorRegistry } from "@paperback/types";

class SelectorRef {
  get value(): any | undefined {
    const value = this.obj[this.key]
    if (typeof value === 'function') {
      return value.bind(this.obj)
    } else {
      return value
    }
  }

  constructor(
    private obj: any,
    private key: string | number | symbol
  ) {}
}

export class MockSelectorRegistry implements SelectorRegistry {
  private registry: Record<string, SelectorRef> = {}

  registerSelector(id: string, obj: any, key: any) {
    this.registry[id] = new SelectorRef(obj, key)
  }

  unregisterSelector(id: string) {
    // eslint-disable-next-line @typescript-eslint/no-dynamic-delete
    delete this.registry[id]
  }

  selector<K>(id: SelectorID<K>): K {
    return this.registry[id as string]?.value
  }

  Selector: typeof Application.Selector = (obj, symbol) => {
    function relative_uuid() {
      return `${Date.now()}-${Math.random().toString().slice(2)}`
    }

    const canonicalId = (function (obj, symbol) {
      const key = `$__selector_${String(symbol)}`
      const existingCanonicalId = (obj as any)[key]

      if (existingCanonicalId) {
        return existingCanonicalId
      } else {
        const id = relative_uuid()
        Object.defineProperty(obj, key, { enumerable: true, value: id })
        return id
      }
    })(obj, symbol)

    this.registerSelector(canonicalId, obj, symbol)
    return canonicalId
  }
}
