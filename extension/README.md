Partial implementation of the Paperback iOS extension API, adapted from @paperback/runtime-polyfills

The host runs inside Gagaku's fjs runtime. Before evaluating this bundle, Dart
installs `globalThis.gagaku` with `callHandler` and a complete, immutable
`defaultUserAgentHeaders` map. The request manager retains that identity and
uses it for missing request headers; explicit extension headers take precedence.
Direct calls to native `fetch` do not receive these defaults automatically.

Identity is captured from the existing source-startup browser, or reused from
manual Cloudflare resolution, before extension code executes. Missing browser
metadata uses the Android WebView/Windows WebView2 synthesis baseline; absent
or failed startup browsers retain the complete fallback. Captures containing
fallback values are not guaranteed-authoritative metadata.

The same runtime identity supplies extension cover/image HTTP defaults. A
successful image-host Cloudflare solve replaces the request identity together
with its clearance cookies using metadata from that solver's existing browser.
No separate startup identity-probe WebView is created.