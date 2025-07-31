import { Form } from "@paperback/types";

export class FormManager {
  private _forms: Record<string, Form> = {}

  async initializeForm(id: string, form: Form): Promise<String> {
    Object.assign(form, { __underlying_formId: id });
    this._forms[id] = form;

    if ("gagaku" in globalThis) {
      await globalThis.gagaku?.callHandler("initializeForm", id);
    }

    return id;
  }

  uninitializeForms(): void {
    Object.keys(this._forms).forEach((key) => delete this._forms[key]);

    if ("gagaku" in globalThis) {
      globalThis.gagaku?.callHandler("uninitializeForms");
    }
  }

  getForm(id: string): Form | undefined {
    return this._forms[id];
  }
}
