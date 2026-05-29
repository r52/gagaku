import { base64ToBytes, bytesToBase64 } from "./Base64";
import { encodePngDataUrl } from "./PngDataUrl";

interface DecodedImage {
  width: number;
  height: number;
  pixels: string;
}

type ImageLoadHandler = ((event: Event) => void) | null;

function parseDataUrl(value: string): Uint8ClampedArray<ArrayBuffer> | null {
  const match = /^data:[^,]*;base64,(.*)$/i.exec(value);
  if (match == null) {
    return null;
  }

  return new Uint8ClampedArray(base64ToBytes(match[1]!).buffer);
}

function flipRows(
  data: Uint8ClampedArray,
  width: number,
  height: number,
): Uint8ClampedArray<ArrayBuffer> {
  const stride = width * 4;
  const flipped = new Uint8ClampedArray(new ArrayBuffer(data.length));

  for (let y = 0; y < height; y++) {
    flipped.set(
      data.subarray(y * stride, (y + 1) * stride),
      (height - 1 - y) * stride,
    );
  }

  return flipped;
}

function copyRegion(
  source: Uint8ClampedArray,
  sourceWidth: number,
  sourceX: number,
  sourceY: number,
  target: Uint8ClampedArray,
  targetWidth: number,
  targetX: number,
  targetY: number,
  width: number,
  height: number,
): void {
  const rowBytes = width * 4;

  for (let y = 0; y < height; y++) {
    const sourceOffset = ((sourceY + y) * sourceWidth + sourceX) * 4;
    const targetOffset = ((targetY + y) * targetWidth + targetX) * 4;
    target.set(source.subarray(sourceOffset, sourceOffset + rowBytes), targetOffset);
  }
}

function createEvent(type: string): Event {
  if (typeof Event === "function") {
    return new Event(type);
  }

  return { type } as Event;
}

class PaperbackImage {
  onload: ImageLoadHandler = null;
  onerror: ((event: Event | string) => void) | null = null;

  complete = false;
  naturalWidth = 0;
  naturalHeight = 0;
  width = 0;
  height = 0;

  pixels = new Uint8ClampedArray();

  private _src = "";

  get src(): string {
    return this._src;
  }

  set src(value: string) {
    this._src = value;
    this.complete = false;
    void this.load(value);
  }

  private async load(value: string): Promise<void> {
    try {
      const bytes = parseDataUrl(value);
      if (bytes == null) {
        throw new Error("Paperback image polyfill only supports data URLs");
      }

      const response = await fetch(
        `http://127.0.0.1:${window.__gagaku_proxy_port}/decode-image`,
        {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({ body: bytesToBase64(bytes) }),
        },
      );
      const decoded = (await response.json()) as DecodedImage & {
        error?: string;
      };

      if (decoded.error != null) {
        throw new Error(decoded.error);
      }

      this.naturalWidth = decoded.width;
      this.naturalHeight = decoded.height;
      this.width = decoded.width;
      this.height = decoded.height;
      this.pixels = new Uint8ClampedArray(base64ToBytes(decoded.pixels).buffer);
      this.complete = true;
      this.onload?.(createEvent("load"));
    } catch (error) {
      this.onerror?.(
        error instanceof Error ? error.message : String(error),
      );
    }
  }
}

class PaperbackCanvasRenderingContext2D {
  constructor(private readonly canvas: PaperbackCanvas) {}

  drawImage(
    image: PaperbackImage,
    dx: number,
    dy: number,
    dw?: number,
    dh?: number,
  ): void {
    const width = Math.min(
      Math.trunc(dw ?? image.naturalWidth),
      image.naturalWidth,
      this.canvas.width - dx,
    );
    const height = Math.min(
      Math.trunc(dh ?? image.naturalHeight),
      image.naturalHeight,
      this.canvas.height - dy,
    );

    if (width <= 0 || height <= 0) {
      return;
    }

    copyRegion(
      image.pixels,
      image.naturalWidth,
      0,
      0,
      this.canvas.pixels,
      this.canvas.width,
      Math.trunc(dx),
      Math.trunc(dy),
      width,
      height,
    );
  }

  getImageData(sx: number, sy: number, sw: number, sh: number): ImageData {
    const width = Math.trunc(sw);
    const height = Math.trunc(sh);
    const pixels = new Uint8ClampedArray(new ArrayBuffer(width * height * 4));

    copyRegion(
      this.canvas.pixels,
      this.canvas.width,
      Math.trunc(sx),
      Math.trunc(sy),
      pixels,
      width,
      0,
      0,
      width,
      height,
    );

    return new ImageData(flipRows(pixels, width, height), width, height);
  }

  putImageData(imageData: ImageData, dx: number, dy: number): void {
    const pixels = flipRows(imageData.data, imageData.width, imageData.height);

    copyRegion(
      pixels,
      imageData.width,
      0,
      0,
      this.canvas.pixels,
      this.canvas.width,
      Math.trunc(dx),
      Math.trunc(dy),
      imageData.width,
      imageData.height,
    );
  }
}

class PaperbackCanvas {
  private _width = 300;
  private _height = 150;
  private _context: PaperbackCanvasRenderingContext2D | undefined;

  pixels = new Uint8ClampedArray(new ArrayBuffer(this._width * this._height * 4));

  get width(): number {
    return this._width;
  }

  set width(value: number) {
    this._width = Math.max(0, Math.trunc(value));
    this.resize();
  }

  get height(): number {
    return this._height;
  }

  set height(value: number) {
    this._height = Math.max(0, Math.trunc(value));
    this.resize();
  }

  getContext(contextId: string): PaperbackCanvasRenderingContext2D | null {
    if (contextId !== "2d") {
      return null;
    }

    this._context ??= new PaperbackCanvasRenderingContext2D(this);
    return this._context;
  }

  toDataURL(): string {
    return encodePngDataUrl(this.pixels, this.width, this.height);
  }

  private resize(): void {
    this.pixels = new Uint8ClampedArray(
      new ArrayBuffer(this.width * this.height * 4),
    );
  }
}

function canConstructNativeCanvas(): boolean {
  try {
    new globalThis.HTMLCanvasElement();
    return true;
  } catch {
    return false;
  }
}

export function installPaperbackCanvasPolyfill(): void {
  if (
    typeof document === "undefined" ||
    typeof globalThis.HTMLCanvasElement === "undefined" ||
    typeof globalThis.ImageData === "undefined" ||
    canConstructNativeCanvas()
  ) {
    return;
  }

  Object.defineProperty(globalThis, "HTMLCanvasElement", {
    value: PaperbackCanvas,
    configurable: true,
    writable: true,
  });

  Object.defineProperty(globalThis, "Image", {
    value: PaperbackImage,
    configurable: true,
    writable: true,
  });
}
