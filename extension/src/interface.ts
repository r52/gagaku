import type { Form, SelectorID } from "@paperback/types";

export interface WebViewInterface {
  callHandler(handlerName: string, ...args: any[]): any;
}

declare global {
  // WebView interface
  var gagaku: WebViewInterface | undefined;

  interface Window {
    __gagaku_proxy_port: number;
  }

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
    function uninitializeForms(): void;
    function getForm(id: string): Form | undefined;

    // Process an image request and return pre-processed data to Dart.
    function processImageRequest(url: string): Promise<{
      url: string;
      method?: string;
      headers?: Record<string, string>;
      body?: ArrayBuffer | string | FormData;
    }>;
  }
}
