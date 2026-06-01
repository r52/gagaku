import { Form } from "@paperback/types";

type GagakuForm = Form & {
  __gagaku_formInstanceId?: string;
};

export class FormManager {
  private _forms: Record<string, Form> = {}
  private _nextFormInstanceId = 0;

  async initializeForm(id: string, form: Form): Promise<string> {
    const instanceId = String(++this._nextFormInstanceId);
    Object.assign(form, {
      __underlying_formId: id,
      __gagaku_formInstanceId: instanceId,
    });
    this._forms[id] = form;

    if ("gagaku" in globalThis) {
      await globalThis.gagaku?.callHandler("initializeForm", id, instanceId);
    }

    return id;
  }

  uninitializeForm(id: string, instanceId: string): void {
    const form = this.getForm(id, instanceId);
    if (form === undefined) {
      return;
    }

    delete this._forms[id];

    if ("gagaku" in globalThis) {
      globalThis.gagaku?.callHandler("uninitializeForm", id, instanceId);
    }
  }

  uninitializeForms(): void {
    Object.keys(this._forms).forEach((key) => delete this._forms[key]);

    if ("gagaku" in globalThis) {
      globalThis.gagaku?.callHandler("uninitializeForms");
    }
  }

  getForm(id: string, instanceId?: string): Form | undefined {
    const form = this._forms[id] as GagakuForm | undefined;
    if (
      instanceId !== undefined &&
      form?.__gagaku_formInstanceId !== instanceId
    ) {
      return undefined;
    }

    return form;
  }
}
