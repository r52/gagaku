# Troubleshooting

Start with the context and setup step that failed. Removing app data, clearing all extension state, or reinstalling should not be the first response to a website error.

## Web Sources says “No extensions installed!”

A repository is only a catalog. Open **Extension Manager** and install at least one manga source from **Available**. Check that it appears under **Installed**, then return to Web Sources Home.

If the repository itself is missing, add it in **Manage Repos** and **tap Save** before leaving Repo List, or confirm the maintainer's repository link in Gagaku. See the [manual setup sequence](./web-sources.md#_1-add-and-save-a-repository) or [Android installation links](./web-sources.md#use-an-installation-link-on-android).

## A repository has no available extensions

Check these in order:

1. **Saved list:** your repository appears in Repo List after closing and reopening it.
2. **URL:** the Repo URL field needs the maintainer's published repository base URL, not a GitHub source-code page or a reading website. Remove a trailing `/`. For a `paperback://` installation link, [tap it in your Android browser](./web-sources.md#use-an-installation-link-on-android) instead of pasting it into this field.
3. **Version:** Gagaku supports Paperback **0.9** manga extensions, not older generations or tracker-only extensions.
4. **Connectivity:** check whether the repository's published page loads in a browser, then use **Refresh repos** <GuideIcon name="refresh" /> in Extension Manager.

Repository metadata can load while an individual extension still fails to initialize. Those are separate problems: a working catalog does not prove that its website or extension works.

## An extension or its images will not load

- If **Resolve Cloudflare** is offered, complete the browser verification and tap **Done** after the website has finished loading.
- Check the source's **Extension Settings**, if available; it may need preferences or a source-specific login.
- Use **Open extension website** to see whether the underlying website is reachable.
- Use **Reload extension** after completing website verification or checking for changes from the maintainer.
- If only one extension fails, check the maintainer's issue tracker or support channel. Paperback compatibility does not guarantee every site's behavior.

If the browser session could not be saved, wait for the page to finish loading before trying **Done** again. Verification can expire and need to be repeated.

Do not share passwords, cookies, client secrets, or a live app backup when asking for help. A source name, app version, failing action, and redacted error message are better starting points.

## MangaDex has no chapters in my language

Open **MangaDex Settings → Chapter Language Filter** and select the languages you read, then **Save Settings**. Also check the **Original Language Filter**, **Content Filter**, and any chapter-list filters you have selected.

A title may have no matching uploads, or a chapter may only offer an external-site link. Login does not create missing chapters.

## MangaDex Login stays disabled

The current form requires **Username**, **Password**, **Client ID**, and **Client Secret**. The ID and secret come from a personal API client belonging to the same MangaDex account. Follow the [login instructions](./mangadex.md#sign-in-only-if-you-need-account-features).

You can skip login to browse and read available MangaDex chapters.

## Local Library is empty or cannot read files

- Check **Manga Library Path** in Local Library Settings and **Save Settings** after choosing a folder.
- On Android, check that Gagaku has **All files access** if you are using directory scanning.
- Make sure the folder still exists and contains supported image directories, CBZ/ZIP or CBT/TAR archives, or Android-supported PDF/EPUB files.
- Pull down to refresh after adding or moving files.
- An archive can exist but contain no readable images. Try a known readable file using **Read Archive** to distinguish a file problem from a library-path problem.

For a single PDF or EPUB on Android, use **Read Document** instead of **Read Archive**. PDF/EPUB reading is unavailable on Windows and Linux.

## Reader toolbar disappeared

Tap the center of the page to show it again. If edge taps do nothing, check **Reader Settings → Click/Tap to Turn Page** and your reading direction. In **Long Strip** mode, scroll vertically rather than trying to turn horizontal pages.
