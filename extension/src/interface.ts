import type { Form, SelectorID } from "@paperback/types";

export interface GagakuInterface {
  readonly defaultUserAgentHeaders: Readonly<
    Record<string, string> & { "user-agent": string }
  >;
  callHandler(handlerName: string, ...args: any[]): any;
}

declare global {
  var gagaku: GagakuInterface;

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
