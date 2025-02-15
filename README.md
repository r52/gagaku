<img align="left" src="/assets/icon.png" width="64" height="64"></img>

# gagaku

![License](https://img.shields.io/github/license/r52/gagaku)

Gagaku is a minimalist, super lightweight MangaDex client (with a few extra features). Currently supports (and is tested on) Windows and Android.

Gagaku does NOT feature offline library management, chapter downloads, or any similar features.

Gagaku is currently a work-in-progress and many things may not work as intended or is janky.

Gagaku is licensed under the MIT license.

## Features

- MangaDex client
- Local CBZ/CBT file support, directory cataloging/scanning
- Basic Paperback extension support
- cubari.moe links
- Deep link support
  - Android only, supports mangadex.org/cubari.moe links
  - Must be manually enabled in Default Apps settings in Android 12+

Gagaku does NOT feature:

- Chapter download, offline reading/library management support. There are far better clients for this purpose.
- File types such as CBR/CB7/PDF/EPUB etc.

## Building

Install [Flutter](https://flutter.dev/) and all of its requirements for the platform(s) you wish to build for

```bash
cd extension/
npm ci
npm run deploy
cd ..
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter build <windows/linux/apk etc>
```

## License

MIT license
