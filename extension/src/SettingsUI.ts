import { Form } from "@paperback/types";

const forms: Record<string, Form> = {};

// TODO refactor this
globalThis.initializeForm = async function (id: string, form: Form) {
  Object.assign(form, { __underlying_formId: id });
  forms[id] = form;

  if ("gagaku" in globalThis) {
    await globalThis.gagaku?.callHandler("initializeForm", id);
  }

  return id;
};

globalThis.uninitializeForms = function () {
  Object.keys(forms).forEach((key) => delete forms[key]);

  if ("gagaku" in globalThis) {
    globalThis.gagaku?.callHandler("uninitializeForms");
  }
};

globalThis.getForm = function (id: string) {
  return forms[id];
};
