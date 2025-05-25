import { PaperbackPolyfills } from "./PaperbackPolyfills";
import "./RawData";
import "./RequestManager";
import "./StateManager";
import "./Global";
import "./Selector";
import "./SettingsUI";
// import * as cheerio from "cheerio";

// @ts-ignore
globalThis.Application = new Proxy(PaperbackPolyfills, {
  get(target, p) {
    // @ts-ignore
    if (target[p]) {
      // @ts-ignore
      return target[p];
    }

    if (typeof p === "string" && p.startsWith("create")) {
      return (anyProps: any) => anyProps;
    }

    return undefined;
  },
});

// @ts-ignore
// globalThis.cheerio = cheerio;
