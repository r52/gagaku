# Trackers

A **tracker extension** sends your Web Sources reading progress to a tracking service such as AniList or MangaUpdates. You link a title to its entry on the tracker once. After that, chapters you finish in Gagaku update your progress on the tracker.

Trackers are optional. They are Paperback 0.9 extensions that you install the same way as manga sources, but they do not provide chapters and do not appear under **Homepages**.

::: info What can be tracked
Only titles you read through Web Sources extensions can be linked. MangaDex and Local Library titles do not show the tracking control.
:::

## 1. Install a tracker

1. Open **Extension Manager** <GuideIcon name="collections_bookmark" /> from the Web Sources toolbar.
2. Expand a repository that publishes tracker extensions. Trackers have a **Tracker** <GuideIcon name="bookmark_added" /> badge.
3. Tap **Install**, as you would for a [manga source](./web-sources.md#_2-install-the-extensions-you-want).

<img class="guide-screen" src="/images/tracker-extension.webp" alt="Extension Manager on Android searched for list, showing the installed AniList extension and its Available entry with a Tracker badge and a Remove button." width="540" height="745" />

The same trust warning applies: a tracker extension runs third-party code and handles your tracker account login.

## 2. Sign in to your tracker account

1. Open **Web Sources Settings** <GuideIcon name="settings" />, then **Trackers** <GuideIcon name="bookmark_added" />.
2. Tap the tracker's card (the **Account settings** <GuideIcon name="manage_accounts" /> icon is on its right).
3. Follow the sign-in form that the tracker provides.

<img class="guide-screen" src="/images/trackers.webp" alt="The Trackers screen on Android, with the Pause tracker updates switch off and an AniList card showing Pending: 0 · Not synced yet, an account settings icon, and Sync now." width="540" height="480" />

The sign-in form and its steps belong to the extension, not to Gagaku. They are separate from Gagaku's MangaDex login. The tracker keeps its login in extension state, which [Database Sync and backups](./database-sync.md#what-sync-includes) include.

## 3. Link a title

1. Open a Web Sources title.
2. Tap **Tracking** <GuideIcon name="bookmark_add" /> on the title's page. The control appears only when at least one tracker is installed.
3. The tracking sheet has one row per installed tracker. Tap **Link** beside the tracker you want.
4. Gagaku searches the tracker for the title's name. Edit the search if needed, then tap the matching entry.

<img class="guide-screen" src="/images/tracking-sheet.webp" alt="The Tracking sheet on Android, with an AniList row marked Not linked, a Link button, and Manage trackers below." width="540" height="225" />

<img class="guide-screen" src="/images/tracker-link-search.webp" alt="The Link on AniList search screen on Android, with the series name in the search field and two similarly named AniList results with covers and Releasing status." width="540" height="500" />

::: tip Check the match
Search shows the tracker's first page of results. For a series with sequels, spin-offs, adaptations, or similar names, compare the cover and title before you pick one. You can tap **Change** later to pick a different entry.
:::

Once linked, the icon changes to <GuideIcon name="bookmark_added" /> with a count of linked trackers. The sheet shows the tracker's entry and your progress there, such as **Ch. 12 · Rating: 8**, or **Not on your list yet** if you have not started it on the tracker.

<img class="guide-screen" src="/images/tracking-sheet-linked.webp" alt="The Tracking sheet on Android with a linked AniList entry showing its cover, title, and chapter and rating progress, followed by Unlink, Change, Edit progress, and Manage trackers." width="540" height="293" />

From the tracking sheet you can also:

- **Edit progress:** open the tracker's own form to change values such as chapter, status, or rating directly on the tracker.
- **Change:** re-link the title to a different tracker entry.
- **Unlink:** stop tracking the title on that tracker. Its updates that have not been sent yet are discarded.
- **Manage trackers** <GuideIcon name="tune" />: open the Trackers screen.

## 4. Read as usual

Nothing else is needed. When a chapter is marked read (about two seconds after you open it in the reader, or when you mark it read in the chapter list), Gagaku sends the highest chapter number you have read to every linked tracker.

- Updates are sent after a short delay, so several chapters read in a row go out together. Updates that have not been sent yet survive an app restart, but are only sent while Gagaku is open.
- Re-reading an earlier chapter is reported too; a tracker may ignore it if your progress there is already ahead.
- Unmarking a chapter does not lower your progress on the tracker. Use **Edit progress** to correct it.

## Check status on the Trackers screen

**Web Sources Settings → Trackers** shows one card per installed tracker:

| Status | Meaning |
| --- | --- |
| **Pending** | Updates waiting to send. |
| **Failed** | Updates that failed ten times in a row and will not be retried automatically. |
| **Last sync** / **Not synced yet** | When a batch last succeeded. This resets when the app restarts, so a fresh start shows **Not synced yet** until the next batch is sent. |
| **Retrying …** | Gagaku is waiting before it tries again after an error. The wait grows with each failure, up to six hours. |
| **Last error** | The most recent error message from the tracker. |

Actions on each card:

- **Sync now** sends pending updates immediately.
- **Retry failed** puts failed updates back in the queue and sends them.
- **Discard failed** deletes failed updates after confirmation. They are never sent.
- **Pause tracker updates** stops reporting reads to every tracker. Chapters you read while it is on are **not** queued for later; turning it off again affects only future reads.

::: warning If Pending keeps growing
Some trackers do not report an error when you are signed out. Their updates stay pending and Gagaku retries them every 15 minutes. If the count keeps growing without a **Last error**, open the tracker's account settings and check that you are still signed in.
:::

## Removing, migrating, and syncing

- **Removing a tracker extension** deletes its pending updates. Your links are kept, so they work again if you reinstall the same tracker. **Prune Unused Data** in Web Sources Settings removes links to trackers that are no longer installed.
- **Migrate Extension Data** carries a title's tracker links and pending updates over to the new manga source.
- **Database Sync and backups** include your tracker links and the tracker's login state. Pending updates stay on the device where you read the chapter.
