<img align="left" src="/assets/icon.png" width="64" height="64"></img>

# gagaku

![License](https://img.shields.io/github/license/r52/gagaku)

Gagaku is a minimalist, lightweight manga reader with 3 main features: a MangaDex client, a local library reader, and a PB extension host.

Currently supports (and is tested on) Windows and Android.

Gagaku does NOT feature offline library management, chapter downloads, or any similar features.

Gagaku is currently a work-in-progress and many things may not work as intended or is janky.

Gagaku is licensed under the MIT license.

### [Downloads](https://github.com/r52/gagaku/releases)

## Features

- MangaDex client
- Local CBZ/CBT file and image directory support, directory cataloging/scanning
- Basic PB extension support
  - v0.9 extensions only
  - manga source providers only (tracking extensions not supported)
- cubari.moe links
- Deep link support
  - Android only, supports mangadex.org/cubari.moe links
  - Must be manually enabled in Default Apps settings in Android 12+

Gagaku does NOT feature:

- Chapter download, offline reading/library management support. There are far better clients for this purpose.
- File types such as CBR/CB7/PDF/EPUB etc.

## Building

Install [Flutter](https://flutter.dev/) and all of its requirements for the platform(s) you wish to build for. Optionally install [Node.js](https://nodejs.org/) to build the extension host.

```bash
# Build extension host (optional)
cd extension/
npm ci
npm run deploy
cd ..

# Build the app
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter build <windows/linux/apk etc>
```

## License

MIT license
