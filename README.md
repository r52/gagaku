<img align="left" src="/assets/icon.png" width="64" height="64"></img>

# gagaku

![License](https://img.shields.io/github/license/r52/gagaku)

Gagaku is a minimalist, lightweight manga reader with 3 main features: a MangaDex client, a local library reader, and a PB extension host.

Android is the primary supported and tested platform. Windows support is best-effort.

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
- Automatic database synchronization through user-controlled storage
  - Native directories, synced through external means such as Syncthing or mounted shared folder
  - Android document provider folders, including Google Drive and any other cloud storage providers that exposes an Android Document provider

Gagaku does NOT feature:

- Chapter download, offline reading/library management support. There are far better clients for this purpose.
- File types such as CBR/CB7/PDF/EPUB etc.

### Database synchronization

Database Sync exchanges complete snapshots of Gagaku's database without requiring account registrations or hosted servers. Browsing/history data, favorites, read markers, extension configuration/state, installed sources, and other database records are included. Device-local settings, credentials, local-library paths, caches, and the live database file are not.

Two storage transports are supported:

- **Filesystem directory:** for external syncing such as Syncthing, an already-mounted Samba/NAS shared folder, or another tool that exposes a normal filesystem path. Gagaku does not implement raw `smb://` access.
- **Android document tree:** for folders exposed through Android's Storage Access Framework. This includes Google Drive and other installed document providers and does not require broad storage permission.

Create a profile on the device whose current data should become authoritative, wait for the storage provider to propagate it, then join that profile from each other device. Normal publication and pulling are automatic. Use only one device at a time and allow the sync provider to propagate changes before editing on another device. If two devices do diverge, Gagaku preserves both complete branches and asks which snapshot should be used.

Each active device retains at most two validated remote snapshots during normal operation. Cloud document providers can still expose temporary delay or garbage while file creates and deletes propagate. Gagaku performs retries for provider-neutral loading behavior, but cannot guarantee a vendor's cloud latency or consistency.

The separate **Database Directory** setting relocates the live database. It is retained for compatibility and must not be used for concurrent multi-device file synchronization; use **Database Sync** instead.

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
