Partial implementation of the Paperback iOS extension API, adapted from @paperback/runtime-polyfills

The host runs inside Gagaku's fjs runtime. Before evaluating this bundle, Dart
installs `globalThis.gagaku` with `callHandler` and a complete, immutable
`defaultUserAgentHeaders` map. The request manager retains that identity and
uses it for missing request headers; explicit extension headers take precedence.
Direct calls to native `fetch` do not receive these defaults automatically.

Identity is captured from the existing source-startup browser, or reused from
manual Cloudflare resolution, before extension code executes. Missing browser
metadata uses the Android WebView/Windows WebView2 synthesis baseline. Captures
containing fallback values are not guaranteed-authoritative metadata.

When native default-UA lookup is unavailable (notably Windows), the first
complete browser identity also seeds the global HTTP identity. Promotion requires
a nonempty captured UA plus either supported UA synthesis or all three captured
client hints. Empty, failed, or unsupported partial captures leave it unresolved;
subsequent captures do not replace an established identity. The static fallback
remains in use until an eligible capture arrives. Per-runtime captures still use
best-effort fallback for missing metadata.

Startup failure policy is shared by all source types:

| Failure | Non-CF source | CF-capable source |
| --- | --- | --- |
| HTTP/navigation failure or document-load timeout | Continue with diagnostic state and fallback metadata | Fail; request manual resolution if a challenge was observed |
| Preparation, native setup, or document-inspection failure/deadline | Fail with `infrastructureFailed` | Fail with `infrastructureFailed`, even after a challenge |
| Cleanup failure | Fail with `infrastructureFailed` if no primary failure exists | Same |

Unavailable ancillary UA metadata/local storage still uses its fallback; it is
not itself an infrastructure failure. A stalled inspection is an infrastructure
failure. HTTP failure evidence is retained even when the response is a challenge
and the source has not declared Cloudflare capability. Setup deadlines cannot
publish late readiness; native creation that finishes late retains cleanup
ownership. Cleanup errors are logged without replacing an existing failure.
Each document start retains its matching early HTTP response and discards
preempted response evidence, so an abandoned navigation cannot block the newer
document's completion. History-only URL changes do not discard failure evidence.

CF-capable sources require a loaded, non-challenge document for startup readiness.
A rotated clearance cookie alone cannot resolve an active challenge or unfinished
navigation. Once a challenge has been observed, readiness also requires a new
clearance cookie; an unresolved challenge requires manual resolution. Metadata capture cannot
override failure evidence, and navigation changes invalidate pending captures.

The same runtime identity supplies extension cover/image HTTP defaults. A
successful image-host Cloudflare solve replaces the request identity together
with its clearance cookies using metadata from that solver's existing browser.
No separate startup identity-probe WebView is created.