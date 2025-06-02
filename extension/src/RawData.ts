import { PaperbackPolyfills } from "./PaperbackPolyfills";

PaperbackPolyfills.arrayBufferToUTF8String = function (
  arrayBuffer: ArrayBuffer
): string {
  return new TextDecoder().decode(arrayBuffer);
};

PaperbackPolyfills.arrayBufferToASCIIString = function (
  arrayBuffer: ArrayBuffer
): string {
  return new TextDecoder("ascii").decode(arrayBuffer);
};

PaperbackPolyfills.arrayBufferToUTF16String = function (
  arrayBuffer: ArrayBuffer
): string {
  return new TextDecoder("utf-16").decode(arrayBuffer);
};
