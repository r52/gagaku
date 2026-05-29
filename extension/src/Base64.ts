const chunkSize = 8190;

export function bytesToBinaryString(
  bytes: Uint8Array | Uint8ClampedArray,
): string {
  const parts: string[] = [];

  for (let offset = 0; offset < bytes.length; offset += chunkSize) {
    const chunk = bytes.subarray(offset, offset + chunkSize);
    parts.push(String.fromCharCode(...chunk));
  }

  return parts.join("");
}

export function bytesToBase64(bytes: Uint8Array | Uint8ClampedArray): string {
  return btoa(bytesToBinaryString(bytes));
}

export function base64ToBytes(value: string): Uint8Array<ArrayBuffer> {
  const binary = atob(value);
  const bytes = new Uint8Array(new ArrayBuffer(binary.length));

  for (let i = 0; i < binary.length; i++) {
    bytes[i] = binary.charCodeAt(i);
  }

  return bytes;
}
