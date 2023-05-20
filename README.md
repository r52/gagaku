<img align="left" src="/assets/icon.png" width="64" height="64"></img>

# gagaku

![License](https://img.shields.io/github/license/r52/gagaku)

Gagaku is a minimalist, lightweight manga reader optimized for desktop OSes with touchscreen support. Currently supports (and is tested on) Windows and Android.

Gagaku is currently a work-in-progress and many things may not work as intended or is janky.

Gagaku is licensed under the MIT license.

## Features

- MangaDex client
- CBZ/CBT file support
- Local directory catalog/scanning (desktop only)
- cubari.moe links (currently supports gist/imgur proxies only)

Gagaku does NOT feature:

- Chapter download support. There are far better clients for this purpose.
- File types such as CBR/CB7/PDF/EPUB etc.

## Building

Install [Flutter](https://flutter.dev/) and all of its requirements for the platform(s) you wish to build for

```bash
flutter pub get
flutter build <windows/linux/apk etc>
```

## License

MIT license
