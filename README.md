<img align="left" src="/assets/icon.png" width="64" height="64"></img>

# gagaku

![License](https://img.shields.io/github/license/r52/gagaku)

Gagaku is a minimalist, lightweight manga reader with 3 main features: a MangaDex client, a local library reader, and a PB extension host.

Android is the primary supported and tested platform. Windows support is best-effort.

Gagaku is currently a work-in-progress, and many things may not work as intended or may be janky.

### [Downloads](https://github.com/r52/gagaku/releases)

### [Quick-Start Guide](https://r52.github.io/gagaku/)

## Features

- MangaDex client
- Local CBZ/CBT/PDF/EPUB file and image directory support, directory cataloging/scanning
  - PDF and EPUB support is Android only
- Basic PB extension support
  - v0.9 extensions only
- cubari.moe links
- Deep link support
  - Android only, supports mangadex.org/cubari.moe links
  - Must be manually enabled in Default Apps settings in Android 12+
- Server-less automatic [database synchronization](https://r52.github.io/gagaku/database-sync) through user-controlled storage
  - Native directories, synced through external means such as Syncthing or a mounted shared folder
  - Android document provider folders, including Google Drive and any other cloud storage provider that exposes an Android document provider

Gagaku does NOT feature:

- Chapter downloads or offline reading/library management. There are far better clients for this purpose.
- File types such as CBR/CB7 etc.

## Building

Install [Flutter](https://flutter.dev/) and all of its requirements for the platform(s) you wish to build for. Optionally install [Bun](https://bun.com/) to build the extension host.

```bash
# Build extension host (optional)
cd extension/
bun install --frozen-lockfile
bun run deploy
cd ..

# Build the app
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter build <windows/linux/apk etc>
```

## License

MIT license
