# Quick start

Gagaku reads manga from **MangaDex**, **Web Sources**, or files you already have in a **Local Library**. Pick one to start; you do not need to configure all three.

This guide focuses on Android, Gagaku's primary supported platform. Windows support is best-effort. Screenshots show the Android app in English; colors and layouts can differ with your theme, screen size, and app version.

## 1. Install Gagaku

Download an Android **APK** from the [GitHub releases](https://github.com/r52/gagaku/releases) and open it on your device. If Android asks, allow the browser or file manager you used to install this app. GitHub's source-code ZIP and TAR downloads are not installable apps.

For Windows, use the Windows release package instead of the APK. PDF and EPUB reading is Android-only.

## 2. Choose where to read

On a phone, tap the **navigation menu** <GuideIcon name="menu" /> at the top left, then select a context under **Read**:

| Context | Minimum setup | Start here |
| --- | --- | --- |
| **Web Sources** | Add a compatible repository and install a manga extension, or use an extension-installation link. | [Set up Web Sources](./web-sources.md) |
| **MangaDex** | No repository or extension needed. Browse without logging in. | [Read with MangaDex](./mangadex.md) |
| **Local Library** | Open an archive, or choose a folder containing your own files. | [Read local files](./local-library.md) |

<img class="guide-screen" src="/images/navigation.webp" alt="Gagaku's Android navigation panel, with MangaDex, Local Library, and Web Sources under Read." width="540" height="1200" />

On wider screens, the same navigation can appear as a rail beside the content. Expand it to show destination names and the other contexts. Tabs such as **Home**, **Favorites**, and **History** belong to the selected context; they do not switch between MangaDex, local files, and extensions.

::: tip Start here if you want extensions
An empty Web Sources homepage is expected on a fresh installation. Adding a repository makes extensions available to install; it does **not** install them. Follow both setup steps in the [Web Sources guide](./web-sources.md).
:::

## 3. Open your first chapter

Find a title in your chosen context, open its chapter list, and tap a chapter. For a local image directory or archive, opening the item starts the reader directly.

See [Reading & favorites](./reading.md) for the few controls you will need most often.

## Make your preferred context open at startup

Open the navigation panel, choose **Settings**, and change **Startup Section** to **MangaDex**, **Web Sources**, or **Local Library**. This changes the normal startup destination; it does not combine the three libraries.

## Configure and protect your data

- [App settings](./app-settings.md): appearance, app updates, database sync, backup/restore, and database storage.
- [Web Sources settings](./web-source-settings.md): organize favorites categories and choose which lists appear in Latest Updates.

## What Gagaku does not do

Gagaku does not download chapters or maintain an offline manga library. Favorites, reading history, and cached images are not chapter downloads. To read your own files offline, use [Local Library](./local-library.md).
