# Web Sources

Web Sources lets you read through third-party **Paperback-compatible manga extensions**. Before it can work, you need both:

- A **repository**: a published catalog from an extension maintainer.
- An **installed extension**: the adapter for a particular reading website.

Gagaku supports **Paperback 0.9** manga-source extensions. Older extension generations and tracker-only extensions are not supported. You do not need the Paperback app or a MangaDex account to configure this context.

When no extensions are installed, the homepage looks like this. Use **Extension Manager** <GuideIcon name="collections_bookmark" /> in the top toolbar to get started.

<img class="guide-screen" src="/images/web-sources-empty.webp" alt="The Android Web Sources homepage showing Homepages and No extensions installed!, with Extension Manager in the top toolbar." width="540" height="1200" />

## Before you start: find a repository

Find a trusted maintainer's **Paperback 0.9 repository**. They may publish a repository URL, an installation link, or both. For manual setup, use the published repository URL—not the manga website's address or the GitHub page containing the extension's source code. If the maintainer publishes several generations, choose 0.9.

An [independent community directory](https://paperbackextensionrepo.xyz/) can help you find maintainers and their published repositories; select **0.9 only**. It is a third-party directory, not a list vetted or operated by Gagaku. You can copy a repository URL for manual entry, or open a maintainer's installation link as described below.

::: warning Install only extensions you trust
Extensions run third-party code and make requests to their source websites. Review the repository and maintainer before adding it. Compatibility with Paperback 0.9 is not a guarantee that every extension or website will work.
:::

## Use an installation link on Android

Gagaku handles **`paperback://` repository and extension-installation links**. If a maintainer offers an **Add repository** or **Install extensions** link for Paperback 0.9, tap it in your Android browser and open it with Gagaku if Android asks which app to use.

- **Repository link** (`paperback://addRepo…`): review the repository name and address, then tap **Yes**. This saves the repository directly; there is no separate Repo List **Save** step. Open **Extension Manager** and [install the extensions you want](#_2-install-the-extensions-you-want).
- **Extension-installation link** (`paperback://installExtensions…`): review the listed extensions and tap **Add** to install them. Gagaku also adds their repositories if they are missing. Return to Web Sources Home to use the installed sources.

Both flows ask for confirmation; opening a link alone does not install anything. Only approve repositories and extensions you trust. Do not paste a `paperback://` link into **Repo URL**—that field needs the published repository address.

If you have a repository URL rather than an installation link, follow the manual steps below.

## 1. Add and save a repository

1. Switch to **Web Sources** using the navigation menu <GuideIcon name="menu" />.
2. Open **Extension Manager** <GuideIcon name="collections_bookmark" /> from the top toolbar—the stacked-bookmarks icon.
3. Tap **Manage Repos** <GuideIcon name="library_add" />, then **Add New Repo** <GuideIcon name="add" />.
4. Enter a **Repo Name**. This is your label for the repository; it does not have to match the maintainer's name.
5. Enter the maintainer's published address in **Repo URL**, or use **Paste from Clipboard**. Use the repository's base URL without a trailing `/`.
6. Tap **Add**. You will return to **Repo List**, with the new entry visible.
7. **Tap Save** <GuideIcon name="save" /> at the top right to save the list and return to Extension Manager.

<img class="guide-screen" src="/images/add-repo.webp" alt="The Add Repo dialog on Android, with Repo Name, Repo URL, Paste from Clipboard, and Add controls." width="540" height="1200" />

::: warning Do not skip Save
When editing Repo List manually, **Add** adds the entry to the open list. **Save** persists the list. Leaving Repo List with Back instead of Save does not save your edits.
:::

## 2. Install the extensions you want

1. In **Extension Manager**, wait for the repository catalog to load. Use **Refresh repos** <GuideIcon name="refresh" /> if needed.
2. Expand your repository under **Available**.
3. Find a manga source you want to use and tap **Install**. You can install more than one.
4. Confirm that it appears under **Installed**. Its available entry changes to **Remove**.
5. Go back to the Web Sources homepage.

A repository entry without installed extensions is not enough: the homepage will still say **No extensions installed!**

<img class="guide-screen" src="/images/extension-manager.webp" alt="Extension Manager on Android with the Inkdex Extensions (0.9) repository expanded under Available, a scan search filter, and Install buttons beside several extensions." width="540" height="1200" />

This example uses the manager's search box to show a few catalog entries. Expand your repository under **Available**, then tap **Install** beside the extension you want. The screenshot is an example, not a recommendation or a guarantee that those sources work.

The yellow warning triangle beside **Install** means that source requires Cloudflare bypass; it is not the unsupported-extension indicator. See [browser verification](#if-a-source-needs-browser-verification) if the source will not load.

Tracker-only or otherwise unsupported entries show an error indicator instead of an Install button. If an extension with the same identifier is already installed from another repository, the button says **Replace**; that switches which repository supplies the extension.

## 3. Find a title and read

Installed extensions appear under **Homepages** on the Web Sources homepage.

- Tap an extension's name to browse its discovery page, if it offers one.
- Use the **search icon beside an extension** <GuideIcon name="search" /> to search that source, if it supports search.
- The toolbar's **Extension Search** <GuideIcon name="search" /> opens the search screen for your searchable installed extensions.

Open a title, then select a chapter from its chapter list. Some sources offer search but no discovery page, so a source name that cannot be tapped does not necessarily mean installation failed.

If the source needs its own preferences or login, open the source's **overflow menu** <GuideIcon name="more_vert" /> and choose **Extension Settings**, when offered. Settings and authentication requirements belong to that extension; they are separate from Gagaku's MangaDex login.

## If a source needs browser verification

When Gagaku shows **Manual Cloudflare verification is required**, use **Resolve Cloudflare**. Complete the verification in the browser that Gagaku opens, wait for the website to finish loading, then tap **Done**.

For other website checks, the source's overflow menu may offer **Open extension website**. After completing a website login or verification, return to Gagaku and use **Reload extension** if necessary.

Verification can expire, and some websites or browser-only extensions may still fail. See [Troubleshooting](./troubleshooting.md#an-extension-or-its-images-will-not-load) before removing your saved data.

## Keep a title for later

Use the **heart / Add to Favorites** control on a title to choose a category, or create one with **Add New Category**. Your saved titles are in the Web Sources **Favorites** tab. See [Reading & favorites](./reading.md#web-sources-favorites) for the distinction between favorites and downloads.

To rename or reorder categories, or choose which ones are checked in **Latest Updates**, see [Web Sources settings](./web-source-settings.md). Category-management edits need **Save** in the editor and **Save Settings** on the parent screen.
