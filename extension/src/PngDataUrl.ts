const pngSignature = new Uint8Array([
  0x89, 0x50, 0x4e, 0x47, 0x0d, 0x0a, 0x1a, 0x0a,
]);

let crcTable: Uint32Array | undefined;

function crc32(bytes: Uint8Array): number {
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

  let crc = 0xffffffff;
  for (const byte of bytes) {
    crc = crcTable[(crc ^ byte) & 0xff]! ^ (crc >>> 8);
  }
  return (crc ^ 0xffffffff) >>> 0;
}

function adler32(bytes: Uint8Array): number {
  const mod = 65521;
  let a = 1;
  let b = 0;

  for (const byte of bytes) {
    a = (a + byte) % mod;
    b = (b + a) % mod;
  }

  return ((b << 16) | a) >>> 0;
}

function ascii(value: string): Uint8Array {
  const bytes = new Uint8Array(value.length);
  for (let i = 0; i < value.length; i++) {
    bytes[i] = value.charCodeAt(i);
  }
  return bytes;
}

function concat(parts: Uint8Array[]): Uint8Array {
  const length = parts.reduce((total, part) => total + part.length, 0);
  const result = new Uint8Array(length);
  let offset = 0;

  for (const part of parts) {
    result.set(part, offset);
    offset += part.length;
  }

  return result;
}

function chunk(type: string, data: Uint8Array): Uint8Array {
  const typeBytes = ascii(type);
  const result = new Uint8Array(12 + data.length);
  const view = new DataView(result.buffer);

  view.setUint32(0, data.length, false);
  result.set(typeBytes, 4);
  result.set(data, 8);
  view.setUint32(8 + data.length, crc32(result.subarray(4, 8 + data.length)), false);

  return result;
}

function zlibStore(data: Uint8Array): Uint8Array {
  const maxBlockLength = 0xffff;
  const blockCount = Math.ceil(data.length / maxBlockLength);
  const result = new Uint8Array(2 + blockCount * 5 + data.length + 4);
  const view = new DataView(result.buffer);

  result[0] = 0x78;
  result[1] = 0x01;

  let sourceOffset = 0;
  let targetOffset = 2;

  for (let block = 0; block < blockCount; block++) {
    const blockLength = Math.min(maxBlockLength, data.length - sourceOffset);
    const isFinalBlock = block === blockCount - 1;

    result[targetOffset++] = isFinalBlock ? 0x01 : 0x00;
    view.setUint16(targetOffset, blockLength, true);
    targetOffset += 2;
    view.setUint16(targetOffset, 0xffff ^ blockLength, true);
    targetOffset += 2;
    result.set(data.subarray(sourceOffset, sourceOffset + blockLength), targetOffset);
    sourceOffset += blockLength;
    targetOffset += blockLength;
  }

  view.setUint32(targetOffset, adler32(data), false);

  return result;
}

function rgbaScanlines(
  pixels: Uint8ClampedArray,
  width: number,
  height: number,
): Uint8Array {
  const rowLength = width * 4;
  const scanlines = new Uint8Array(height * (rowLength + 1));

  for (let y = 0; y < height; y++) {
    const sourceOffset = y * rowLength;
    const targetOffset = y * (rowLength + 1);
    scanlines[targetOffset] = 0;
    scanlines.set(
      pixels.subarray(sourceOffset, sourceOffset + rowLength),
      targetOffset + 1,
    );
  }

  return scanlines;
}

function base64Encode(bytes: Uint8Array): string {
  const chunkSize = 8190;
  const parts: string[] = [];

  for (let offset = 0; offset < bytes.length; offset += chunkSize) {
    const chunk = bytes.subarray(offset, offset + chunkSize);
    parts.push(String.fromCharCode(...chunk));
  }

  return btoa(parts.join(""));
}

export function encodePngDataUrl(
  pixels: Uint8ClampedArray,
  width: number,
  height: number,
): string {
  if (width <= 0 || height <= 0) {
    throw new Error("cannot encode PNG with empty dimensions");
  }

  const ihdr = new Uint8Array(13);
  const ihdrView = new DataView(ihdr.buffer);
  ihdrView.setUint32(0, width, false);
  ihdrView.setUint32(4, height, false);
  ihdr[8] = 8;
  ihdr[9] = 6;

  const png = concat([
    pngSignature,
    chunk("IHDR", ihdr),
    chunk("IDAT", zlibStore(rgbaScanlines(pixels, width, height))),
    chunk("IEND", new Uint8Array()),
  ]);

  return `data:image/png;base64,${base64Encode(png)}`;
}
