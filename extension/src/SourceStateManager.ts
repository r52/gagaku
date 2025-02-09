import { SecureStateManager, SourceStateManager } from "@paperback/types"
import { PaperbackPolyfills } from "./PBPolyfills"

class PolySecureStateManager implements SecureStateManager {
    private objectStore: Record<string, any> = {}

    async store(key: string, value: any) {
        this.objectStore[key] = value
    }

    async retrieve(key: string) {
        return this.objectStore[key]
    }
}

class PolySourceStateManager implements SourceStateManager {
    readonly keychain: SecureStateManager = new PolySecureStateManager()
    private objectStore: Record<string, any> = {}

    async store(key: string, value: any) {
        this.objectStore[key] = value
    }

    async retrieve(key: string) {
        return this.objectStore[key]
    }
}

PaperbackPolyfills.createSourceStateManager = function (): SourceStateManager {
    return new PolySourceStateManager()
}