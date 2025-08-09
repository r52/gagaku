import { Form, SelectorID } from "@paperback/types";

export interface WebViewInterface {
  callHandler(handlerName: String, ...args: any[]): any;
}

declare global {
  // WebView interface
  var gagaku: WebViewInterface | undefined;


  namespace Application {
    // binding
    function callBinding<K>(id: SelectorID<K>, ...args: any[]): Promise<any>;

    // State
    function createExtensionState(state: Record<string, any> | undefined): void;
    function createExtensionSecureState(state: Record<string, any> | undefined): void;

    // Form
    function initializeForm(id: string, form: Form): Promise<string>;
    function uninitializeForms(): void;
    function getForm(id: string): Form | undefined;
  }
}
