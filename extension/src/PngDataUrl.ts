import { bytesToBase64 } from "./Base64";

const pngSignature = new Uint8Array([
  0x89, 0x50, 0x4e, 0x47, 0x0d, 0x0a, 0x1a, 0x0a,
]);
const profileMinElapsedMs = 1;

let crcTable: Uint32Array | undefined;

function now(): number {
  return Date.now();
}

function profilePngOperation(
  label: string,
  startedAt: number,
  details = "",
): void {
  const elapsed = now() - startedAt;
  if (elapsed < profileMinElapsedMs) {
    return;
  }

  console.debug(
    `[gagaku:image] PNG ${label} ${elapsed}ms${details ? ` ${details}` : ""}`,
  );
}

function ensureCrcTable(): Uint32Array {
  if (crcTable == null) {
    crcTable = new Uint32Array(256);
    for (let i = 0; i < crcTable.length; i++) {
      let crc = i;
      for (let j = 0; j < 8; j++) {
        crc = crc & 1 ? 0xedb88320 ^ (crc >>> 1) : crc >>> 1;
      }
      crcTable[i] = crc >>> 0;
    }
  }

  return crcTable;
}

function crc32UpdateByte(crc: number, byte: number): number {
  const table = ensureCrcTable();
  return table[(crc ^ byte) & 0xff]! ^ (crc >>> 8);
}

function crc32Range(bytes: Uint8Array, start: number, end: number): number {
  let crc = 0xffffffff;
  for (let index = start; index < end; index++) {
    crc = crc32UpdateByte(crc, bytes[index]!);
  }
  return (crc ^ 0xffffffff) >>> 0;
}

function writeChunk(
  target: Uint8Array,
  offset: number,
  type: string,
  data: Uint8Array,
  view: DataView,
): number {
  view.setUint32(offset, data.length, false);
  target[offset + 4] = type.charCodeAt(0);
  target[offset + 5] = type.charCodeAt(1);
  target[offset + 6] = type.charCodeAt(2);
  target[offset + 7] = type.charCodeAt(3);
  target.set(data, offset + 8);
  view.setUint32(
    offset + 8 + data.length,
    crc32Range(target, offset + 4, offset + 8 + data.length),
    false,
  );
  return offset + 12 + data.length;
}

function writePng(
  pixels: Uint8ClampedArray,
  width: number,
  height: number,
): Uint8Array {
  const rowLength = width * 4;
  const scanlineLength = rowLength + 1;
  const dataLength = height * scanlineLength;
  const maxBlockLength = 0xffff;
  const blockCount = Math.ceil(dataLength / maxBlockLength);
  const idatLength = 2 + blockCount * 5 + dataLength + 4;
  const png = new Uint8Array(
    pngSignature.length +
      12 + 13 +
      12 + idatLength +
      12,
  );
  const view = new DataView(png.buffer);
  const adlerMod = 65521;
  const adlerChunkLength = 5552;
  let offset = 0;
  let crc = 0xffffffff;
  let adlerA = 1;
  let adlerB = 0;
  let adlerPending = 0;
  const crcLookup = ensureCrcTable();

  function writeCrcByte(byte: number): void {
    png[offset++] = byte;
    crc = crcLookup[(crc ^ byte) & 0xff]! ^ (crc >>> 8);
  }

  function writeAdlerByte(byte: number): void {
    writeCrcByte(byte);
    adlerA += byte;
    adlerB += adlerA;
    adlerPending++;
    if (adlerPending >= adlerChunkLength) {
      adlerA %= adlerMod;
      adlerB %= adlerMod;
      adlerPending = 0;
    }
  }

  function writePixelRange(start: number, end: number): void {
    const length = end - start;
    png.set(pixels.subarray(start, end), offset);
    let index = start;

    while (index < end) {
      const chunkEnd = Math.min(
        end,
        index + adlerChunkLength - adlerPending,
      );
      for (; index < chunkEnd; index++) {
        const byte = pixels[index]!;
        crc = crcLookup[(crc ^ byte) & 0xff]! ^ (crc >>> 8);
        adlerA += byte;
        adlerB += adlerA;
      }
      adlerPending += chunkEnd - start;
      if (adlerPending >= adlerChunkLength) {
        adlerA %= adlerMod;
        adlerB %= adlerMod;
        adlerPending = 0;
      }
      start = chunkEnd;
    }

    offset += length;
  }

  png.set(pngSignature, offset);
  offset += pngSignature.length;

  const ihdr = new Uint8Array(13);
  const ihdrView = new DataView(ihdr.buffer);
  ihdrView.setUint32(0, width, false);
  ihdrView.setUint32(4, height, false);
  ihdr[8] = 8;
  ihdr[9] = 6;
  offset = writeChunk(png, offset, "IHDR", ihdr, view);

  view.setUint32(offset, idatLength, false);
  offset += 4;
  crc = 0xffffffff;
  writeCrcByte(0x49);
  writeCrcByte(0x44);
  writeCrcByte(0x41);
  writeCrcByte(0x54);
  writeCrcByte(0x78);
  writeCrcByte(0x01);

  let scanlineOffset = 0;
  let row = 0;
  let rowOffset = 0;

  for (let block = 0; block < blockCount; block++) {
    const blockLength = Math.min(maxBlockLength, dataLength - scanlineOffset);
    const isFinalBlock = block === blockCount - 1;
    let blockRemaining = blockLength;

    writeCrcByte(isFinalBlock ? 0x01 : 0x00);
    writeCrcByte(blockLength & 0xff);
    writeCrcByte((blockLength >>> 8) & 0xff);
    writeCrcByte((0xffff ^ blockLength) & 0xff);
    writeCrcByte(((0xffff ^ blockLength) >>> 8) & 0xff);

    while (blockRemaining > 0) {
      if (rowOffset === 0) {
        writeAdlerByte(0);
        rowOffset = 1;
        scanlineOffset++;
        blockRemaining--;
        if (rowOffset === scanlineLength) {
          rowOffset = 0;
          row++;
        }
        continue;
      }

      const copyLength = Math.min(blockRemaining, scanlineLength - rowOffset);
      const pixelOffset = row * rowLength + rowOffset - 1;
      writePixelRange(pixelOffset, pixelOffset + copyLength);
      rowOffset += copyLength;
      scanlineOffset += copyLength;
      blockRemaining -= copyLength;
      if (rowOffset === scanlineLength) {
        rowOffset = 0;
        row++;
      }
    }
  }

  adlerA %= adlerMod;
  adlerB %= adlerMod;
  const adler = ((adlerB << 16) | adlerA) >>> 0;
  writeCrcByte((adler >>> 24) & 0xff);
  writeCrcByte((adler >>> 16) & 0xff);
  writeCrcByte((adler >>> 8) & 0xff);
  writeCrcByte(adler & 0xff);
  view.setUint32(offset, (crc ^ 0xffffffff) >>> 0, false);
  offset += 4;

  writeChunk(png, offset, "IEND", new Uint8Array(), view);

  return png;
}

export function encodePngDataUrl(
  pixels: Uint8ClampedArray,
  width: number,
  height: number,
): string {
  if (width <= 0 || height <= 0) {
    throw new Error("cannot encode PNG with empty dimensions");
  }

  const writeStartedAt = now();
  const png = writePng(pixels, width, height);
  profilePngOperation(
    "zlib+chunks",
    writeStartedAt,
    `${png.length} bytes`,
  );

  const base64StartedAt = now();
  const dataUrl = `data:image/png;base64,${bytesToBase64(png)}`;
  profilePngOperation(
    "base64",
    base64StartedAt,
    `${dataUrl.length} chars`,
  );

  return dataUrl;
}
