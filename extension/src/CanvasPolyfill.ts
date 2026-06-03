import { encodePngDataUrl } from "./PngDataUrl";

type ImageLoadHandler = ((event: Event) => void) | null;

const profileMinElapsedMs = 1;

function now(): number {
  return Date.now();
}

function profileImageOperation(
  label: string,
  startedAt: number,
  details = "",
): void {
  const elapsed = now() - startedAt;
  if (elapsed < profileMinElapsedMs) {
    return;
  }

  console.debug(
    `[gagaku:image] ${label} ${elapsed}ms${details ? ` ${details}` : ""}`,
  );
}

class PaperbackImageData {
  readonly data: Uint8ClampedArray<ArrayBuffer>;
  readonly width: number;
  readonly height: number;
  readonly colorSpace = "srgb";

  constructor(
    dataOrWidth: Uint8ClampedArray<ArrayBuffer> | number,
    widthOrHeight: number,
    height?: number,
  ) {
    if (typeof dataOrWidth === "number") {
      this.width = Math.trunc(dataOrWidth);
      this.height = Math.trunc(widthOrHeight);
      this.data = new Uint8ClampedArray(
        new ArrayBuffer(this.width * this.height * 4),
      );
      return;
    }

    this.width = Math.trunc(widthOrHeight);
    const resolvedHeight = height ?? dataOrWidth.length / (this.width * 4);
    if (!Number.isInteger(resolvedHeight)) {
      throw new RangeError("ImageData pixel length does not match width");
    }

    this.height = Math.trunc(resolvedHeight);
    if (dataOrWidth.length !== this.width * this.height * 4) {
      throw new RangeError("ImageData pixel length does not match dimensions");
    }
    this.data = dataOrWidth;
  }
}

function isBase64DataUrl(value: string): boolean {
  const comma = value.indexOf(",");
  return comma > 0 && /;base64/i.test(value.slice(0, comma));
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

function copyRegionToFlippedRows(
  source: Uint8ClampedArray,
  sourceWidth: number,
  sourceX: number,
  sourceY: number,
  target: Uint8ClampedArray,
  targetWidth: number,
  targetHeight: number,
  targetX: number,
  targetY: number,
  width: number,
  height: number,
): void {
  const rowBytes = width * 4;

  for (let y = 0; y < height; y++) {
    const sourceOffset = ((sourceY + y) * sourceWidth + sourceX) * 4;
    const flippedTargetY = targetHeight - 1 - (targetY + y);
    const targetOffset = (flippedTargetY * targetWidth + targetX) * 4;
    target.set(source.subarray(sourceOffset, sourceOffset + rowBytes), targetOffset);
  }
}

function copyRegionFromFlippedRows(
  source: Uint8ClampedArray,
  sourceWidth: number,
  sourceHeight: number,
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
    const flippedSourceY = sourceHeight - 1 - (sourceY + y);
    const sourceOffset = (flippedSourceY * sourceWidth + sourceX) * 4;
    const targetOffset = ((targetY + y) * targetWidth + targetX) * 4;
    target.set(source.subarray(sourceOffset, sourceOffset + rowBytes), targetOffset);
  }
}

function clipCopyRegion(
  sourceWidth: number,
  sourceHeight: number,
  sourceX: number,
  sourceY: number,
  targetWidth: number,
  targetHeight: number,
  targetX: number,
  targetY: number,
  width: number,
  height: number,
):
  | {
      sourceX: number;
      sourceY: number;
      targetX: number;
      targetY: number;
      width: number;
      height: number;
    }
  | undefined {
  let clippedSourceX = Math.trunc(sourceX);
  let clippedSourceY = Math.trunc(sourceY);
  let clippedTargetX = Math.trunc(targetX);
  let clippedTargetY = Math.trunc(targetY);
  let clippedWidth = Math.trunc(width);
  let clippedHeight = Math.trunc(height);

  if (clippedSourceX < 0) {
    clippedWidth += clippedSourceX;
    clippedTargetX -= clippedSourceX;
    clippedSourceX = 0;
  }
  if (clippedSourceY < 0) {
    clippedHeight += clippedSourceY;
    clippedTargetY -= clippedSourceY;
    clippedSourceY = 0;
  }
  if (clippedTargetX < 0) {
    clippedWidth += clippedTargetX;
    clippedSourceX -= clippedTargetX;
    clippedTargetX = 0;
  }
  if (clippedTargetY < 0) {
    clippedHeight += clippedTargetY;
    clippedSourceY -= clippedTargetY;
    clippedTargetY = 0;
  }

  clippedWidth = Math.min(
    clippedWidth,
    sourceWidth - clippedSourceX,
    targetWidth - clippedTargetX,
  );
  clippedHeight = Math.min(
    clippedHeight,
    sourceHeight - clippedSourceY,
    targetHeight - clippedTargetY,
  );

  if (clippedWidth <= 0 || clippedHeight <= 0) {
    return undefined;
  }

  return {
    sourceX: clippedSourceX,
    sourceY: clippedSourceY,
    targetX: clippedTargetX,
    targetY: clippedTargetY,
    width: clippedWidth,
    height: clippedHeight,
  };
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
    const startedAt = now();
    try {
      if (!isBase64DataUrl(value)) {
        throw new Error("Paperback image polyfill only supports data URLs");
      }

      if (globalThis.gagaku == null) {
        throw new Error("Paperback image decoding is unavailable");
      }
      const decoded = await globalThis.gagaku.decodeImage(value);

      this.naturalWidth = decoded.width;
      this.naturalHeight = decoded.height;
      this.width = decoded.width;
      this.height = decoded.height;
      this.pixels = new Uint8ClampedArray(decoded.pixels);
      this.complete = true;
      profileImageOperation(
        "Image.src decode",
        startedAt,
        `${this.width}x${this.height} ${this.pixels.length} rgba bytes`,
      );
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
    const startedAt = now();
    if (!image.complete) {
      return;
    }

    const region = clipCopyRegion(
      image.naturalWidth,
      image.naturalHeight,
      0,
      0,
      this.canvas.width,
      this.canvas.height,
      Math.trunc(dx),
      Math.trunc(dy),
      Math.trunc(dw ?? image.naturalWidth),
      Math.trunc(dh ?? image.naturalHeight),
    );

    if (region == null) {
      return;
    }

    copyRegion(
      image.pixels,
      image.naturalWidth,
      region.sourceX,
      region.sourceY,
      this.canvas.pixels,
      this.canvas.width,
      region.targetX,
      region.targetY,
      region.width,
      region.height,
    );
    profileImageOperation(
      "CanvasRenderingContext2D.drawImage",
      startedAt,
      `${region.width}x${region.height}`,
    );
  }

  getImageData(sx: number, sy: number, sw: number, sh: number): ImageData {
    const startedAt = now();
    const width = Math.trunc(sw);
    const height = Math.trunc(sh);
    const pixels = new Uint8ClampedArray(new ArrayBuffer(width * height * 4));
    const region = clipCopyRegion(
      this.canvas.width,
      this.canvas.height,
      Math.trunc(sx),
      Math.trunc(sy),
      width,
      height,
      0,
      0,
      width,
      height,
    );

    if (region != null) {
      copyRegionToFlippedRows(
        this.canvas.pixels,
        this.canvas.width,
        region.sourceX,
        region.sourceY,
        pixels,
        width,
        height,
        region.targetX,
        region.targetY,
        region.width,
        region.height,
      );
    }

    const imageData = new ImageData(pixels, width, height);
    profileImageOperation(
      "CanvasRenderingContext2D.getImageData",
      startedAt,
      `${width}x${height}`,
    );
    return imageData;
  }

  putImageData(imageData: ImageData, dx: number, dy: number): void {
    const startedAt = now();
    const region = clipCopyRegion(
      imageData.width,
      imageData.height,
      0,
      0,
      this.canvas.width,
      this.canvas.height,
      Math.trunc(dx),
      Math.trunc(dy),
      imageData.width,
      imageData.height,
    );

    if (region == null) {
      return;
    }

    copyRegionFromFlippedRows(
      imageData.data,
      imageData.width,
      imageData.height,
      region.sourceX,
      region.sourceY,
      this.canvas.pixels,
      this.canvas.width,
      region.targetX,
      region.targetY,
      region.width,
      region.height,
    );
    profileImageOperation(
      "CanvasRenderingContext2D.putImageData",
      startedAt,
      `${region.width}x${region.height}`,
    );
  }
}

class PaperbackCanvas {
  private _width = 300;
  private _height = 150;
  private _context: PaperbackCanvasRenderingContext2D | undefined;
  private _pixels: Uint8ClampedArray<ArrayBuffer> | undefined;

  get pixels(): Uint8ClampedArray<ArrayBuffer> {
    this._pixels ??= new Uint8ClampedArray(
      new ArrayBuffer(this._width * this._height * 4),
    );
    return this._pixels;
  }

  set pixels(value: Uint8ClampedArray<ArrayBuffer>) {
    this._pixels = value;
  }

  get width(): number {
    return this._width;
  }

  set width(value: number) {
    const width = Math.max(0, Math.trunc(value));
    if (width === this._width) {
      return;
    }
    this._width = width;
    this.resize();
  }

  get height(): number {
    return this._height;
  }

  set height(value: number) {
    const height = Math.max(0, Math.trunc(value));
    if (height === this._height) {
      return;
    }
    this._height = height;
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
    const startedAt = now();
    const dataUrl = encodePngDataUrl(this.pixels, this.width, this.height);
    profileImageOperation(
      "HTMLCanvasElement.toDataURL",
      startedAt,
      `${this.width}x${this.height} ${dataUrl.length} chars`,
    );
    return dataUrl;
  }

  private resize(): void {
    this._pixels = undefined;
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
  if (canConstructNativeCanvas()) {
    return;
  }

  if (typeof globalThis.ImageData === "undefined") {
    Object.defineProperty(globalThis, "ImageData", {
      value: PaperbackImageData,
      configurable: true,
      writable: true,
    });
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
