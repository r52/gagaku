import type { Form, SelectorID } from "@paperback/types";

export interface GagakuInterface {
  callHandler(handlerName: string, ...args: any[]): any;
  decodeImage(bytesOrDataUrl: Uint8ClampedArray | string): Promise<DecodedImage>;
  nativeImage?: FjsNativeImageInterface;
}

export interface DecodedImage {
  width: number;
  height: number;
  pixels: Uint8Array;
}

export interface FjsNativeImageInterface {
  encodePngDataUrl(
    pixels: Uint8Array | Uint8ClampedArray | ArrayBuffer,
    width: number,
    height: number,
  ): string;
}

declare global {
  var gagaku: GagakuInterface | undefined;

  namespace Application {
    // binding
    function callBinding<K>(id: SelectorID<K>, ...args: any[]): Promise<any>;

    // State
    function createExtensionState(state: Record<string, any> | undefined): void;
    function createExtensionSecureState(
      state: Record<string, any> | undefined,
    ): void;

    // Form
    function initializeForm(id: string, form: Form): Promise<string>;
    function uninitializeForm(id: string, instanceId: string): void;
    function uninitializeForms(): void;
    function getForm(id: string, instanceId?: string): Form | undefined;
  }
}
