import {
  DUIFormRow,
  DUISection,
  Source,
  DUIButton,
  DUINavigationButton,
  DUIBinding,
  DUIForm,
  DUISelect,
  DUIInputField,
  DUISwitch,
} from "@paperback/types";
import { PaperbackPolyfills } from "./PBPolyfills";

export interface CType {
  readonly type: string;
}

export interface CSection extends DUISection, CType {
  readonly type: "DUISection";
  id: string;
  header?: string;
  footer?: string;
  isHidden: boolean;
  rows: () => Promise<DUIFormRow[]>;
}

export type RDUISection = Omit<CSection, "rows" | "_rows"> & {
  rows: DUIFormRow[];
};

export interface CForm extends DUIForm, CType {
  readonly type: "DUIForm";
  sections: () => Promise<DUISection[]>;
  onSubmit?: (arg0: Record<any, any>) => Promise<void>;
}

export type RDUIForm = Pick<CForm, "type"> & {
  sections: RDUISection[];
  hasSubmit: boolean;
};

export interface CSelect extends DUISelect, CType {
  readonly type: "DUISelect";
  id: string;
  label: string;
  options: string[];
  value: DUIBinding;
  allowsMultiselect: boolean;
  labelResolver: (arg0: string) => Promise<string>;
}

export type RDUISelect = Omit<CSelect, "labelResolver" | "value"> & {
  labels: Record<string, string>;
};

export interface CInputField extends DUIInputField, CType {
  readonly type: "DUIInputField";
  id: string;
  label: string;
  value: DUIBinding;
}

export type RDUIInputField = Omit<CInputField, "value">;

export interface CButton extends DUIButton, CType {
  readonly type: "DUIButton";
  id: string;
  label: string;
  onTap: () => Promise<void>;
}

export type RDUIButton = Omit<CButton, "onTap">;

export interface CNavigationButton extends DUINavigationButton, CType {
  readonly type: "DUINavigationButton";
  id: string;
  label: string;
  form: DUIForm;
}

export type RDUINavigationButton = Omit<CNavigationButton, "form"> & {
  form: RDUIForm;
};

export interface CSwitch extends DUISwitch {
  readonly type: "DUISwitch";
  id: string;
  label: string;
  value: DUIBinding;
}

export type RDUISwitch = Omit<CSwitch, "value">;

export const bindingMap: Record<string, Function> = {};

function registerBinding(id: string, binding: DUIBinding | Function) {
  if (typeof binding === "function") {
    console.log(`Registering binding ${id} to function ${binding.name}`);
    bindingMap[id] = binding;
    console.log(`Successfully saved binding?: ${id in bindingMap}`);
  } else {
    console.log(`Registering DUIBinding ${id}.get and ${id}.set`);
    bindingMap[`${id}.get`] = binding.get;
    bindingMap[`${id}.set`] = binding.set;
    console.log(`Successfully saved binding?: ${`${id}.get` in bindingMap}`);
  }
}

PaperbackPolyfills.createDUISection = function (info): CSection {
  return {
    type: "DUISection",
    _rows: info.rows,
    ...info,
  };
};

PaperbackPolyfills.createDUIForm = function (info): CForm {
  return {
    type: "DUIForm",
    ...info,
  };
};

PaperbackPolyfills.createDUIButton = function (info): CButton {
  return {
    type: "DUIButton",
    ...info,
  };
};

PaperbackPolyfills.createDUISelect = function (info): CSelect {
  return {
    type: "DUISelect",
    ...info,
  };
};

PaperbackPolyfills.createDUIInputField = function (info): CInputField {
  return {
    type: "DUIInputField",
    ...info,
  };
};

PaperbackPolyfills.createDUINavigationButton = function (
  info
): CNavigationButton {
  return {
    type: "DUINavigationButton",
    ...info,
  };
};

PaperbackPolyfills.createDUISwitch = function (info): CSwitch {
  return {
    type: "DUISwitch",
    ...info,
  };
};

async function processDUIForm(element: DUIForm): Promise<RDUIForm> {
  let c = element as CForm;
  let sections = await c.sections();

  let resolved_sections = await Promise.all(
    sections.map(async (e) => {
      return await processSectionElement(e);
    })
  );

  return {
    type: c.type,
    sections: resolved_sections,
    hasSubmit: "onSubmit" in c,
  };
}

async function processDUIButton(element: DUIFormRow): Promise<RDUIButton> {
  let c = element as CButton;

  registerBinding(c.id, c.onTap);

  return {
    ...c,
  };
}

async function processDUINavigationButton(
  element: DUIFormRow
): Promise<RDUINavigationButton> {
  let c = element as CNavigationButton;

  let form = await processDUIForm(c.form);

  if ("onSubmit" in c.form) {
    registerBinding(c.id, c.form.onSubmit!);
  }

  return {
    type: c.type,
    id: c.id,
    label: c.label,
    form: form,
  };
}

async function processDUIInputField(
  element: DUIFormRow
): Promise<RDUIInputField> {
  let c = element as CInputField;

  registerBinding(c.id, c.value);

  return {
    ...c,
  };
}

async function processDUISelect(element: DUIFormRow): Promise<RDUISelect> {
  let c = element as CSelect;
  let labels: Record<string, string> = {};

  for await (const op of c.options) {
    labels[op] = await c.labelResolver(op);
  }

  registerBinding(c.id, c.value);

  return {
    ...c,
    labels: labels,
  };
}

async function processDUISwitch(
  element: DUIFormRow
): Promise<RDUISwitch> {
  let c = element as CSwitch;

  registerBinding(c.id, c.value);

  return {
    ...c,
  };
}

async function processMenuElement(element: DUIFormRow): Promise<DUIFormRow> {
  let type = (element as unknown as CType).type;

  switch (type) {
    case "DUIButton":
      return await processDUIButton(element);
    case "DUINavigationButton":
      return await processDUINavigationButton(element);
    case "DUIInputField":
      return await processDUIInputField(element);
    case "DUISelect":
      return await processDUISelect(element);
    case "DUISwitch":
      return await processDUISwitch(element);
    default:
      return element;
  }
}

async function processSectionElement(
  element: DUISection
): Promise<RDUISection> {
  let compat = element as CSection;
  let rows = await compat.rows();

  let resolved_rows = await Promise.all(
    rows.map(async (e) => {
      return await processMenuElement(e);
    })
  );

  return {
    type: "DUISection",
    id: compat.id,
    header: compat.header,
    footer: compat.footer,
    isHidden: compat.isHidden,
    rows: resolved_rows,
  };
}

globalThis.processSourceMenu = async function (source: Source) {
  let menu = await source.getSourceMenu?.();

  if (typeof menu !== "undefined") {
    return await processSectionElement(menu);
  }

  throw Error("No menu");
};

globalThis.callBinding = async function (id: string, ...args: any[]) {
  if (id in bindingMap) {
    let f = bindingMap[id];
    return await f(...args);
  } else {
    console.log(`Binding ${id} not found`);
  }
};
