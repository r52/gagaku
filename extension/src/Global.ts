import { PaperbackPolyfills } from "./PaperbackPolyfills";
import { decode } from "html-entities";

PaperbackPolyfills.decodeHTMLEntities = function (str: string): string {
  return decode(str);
};
PaperbackPolyfills.sleep = function (seconds: number): Promise<void> {
  return new Promise((resolve) => setTimeout(resolve, seconds * 1000));
};
