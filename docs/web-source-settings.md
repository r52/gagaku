# Web Sources settings

Switch to **Web Sources**, then open **Web Sources Settings** <GuideIcon name="settings" /> in its top toolbar. These settings organize Gagaku's favorites and update feed; they are separate from an individual source's **Extension Settings**.

<img class="guide-screen" src="/images/web-source-settings.webp" alt="Android Web Sources Settings, with Favorite Categories, Categories to Update, and the Save Settings button at the top." width="540" height="1200" />

## Organize favorites categories

Categories are named lists for titles you save in Web Sources. For example, you might use **Reading**, **Plan to read**, and **Finished**. These are example names, not built-in statuses; choose names that suit you.

1. Open **Favorite Categories** <GuideIcon name="library_add" />.
2. Tap **Add New Category** <GuideIcon name="add" />, enter a non-empty name that is not already used, and tap **Add**. Repeat for other lists you want.
3. Use **Rename** (the pencil beside a category) to change its name. On Android, hold and drag a category row to change the list order.
4. Tap **Save** <GuideIcon name="save" /> in the category editor to return to Web Sources Settings.
5. **Tap Save Settings** <GuideIcon name="save" /> on that parent screen to persist the categories and their order.

<img class="guide-screen" src="/images/favorite-categories.webp" alt="Favorite Categories on Android, with example Reading, Plan to read, and Finished rows, Rename and Delete controls, and Add and Save in the toolbar." width="540" height="1200" />

::: warning Both save steps matter
The category editor's **Save** returns your edited list to Web Sources Settings. **Save Settings** writes it to the database. Leaving the parent screen with Back instead can discard your changes.
:::

**Delete** removes a category after confirmation; its titles are removed from that list when you save the parent settings. Move titles you want to keep to another category first.

## Put a title in a category

Open a Web Sources title and tap **Add to Favorites** (the heart control). Check the categories where you want it to appear. A title can belong to more than one category: these are lists, not mutually exclusive reading statuses.

You can also create a category from that title's favorites dialog using **Add New Category**; the title is added to the new category. This is a different flow from the category editor above.

Use the Web Sources **Favorites** tab to browse your saved lists. Adding a title to **Finished** does not mark all its chapters read; category membership and chapter read markers are separate. See [Reading & favorites](./reading.md#web-sources-favorites) for reader controls and history.

## Choose which categories appear in Latest Updates

Saving a favorite does not by itself select its category for the update feed. Use **Categories to Update** to limit the feed to the lists you want to follow.

With no categories selected, a refresh has no titles to check—even if your Favorites lists contain titles.

1. In **Web Sources Settings**, open **Categories to Update** <GuideIcon name="library_add" />.
2. Check the categories you want Gagaku to use when checking for chapter updates. For example, select **Reading** and leave **Finished** unchecked.
3. Tap **Ok** to return to Web Sources Settings.
4. **Tap Save Settings** <GuideIcon name="save" /> to persist the selection.
5. Open the Web Sources **Latest Updates** tab and pull down to refresh. On its initial empty screen, you can also use the displayed update button.

<img class="guide-screen" src="/images/categories-to-update.webp" alt="Categories to Update dialog on Android, with Reading checked, Plan to read and Finished unchecked, and Cancel and Ok buttons." width="540" height="1200" />

This selection only controls which favorites are checked for new chapters. New categories are not added to it automatically, so check the selection again after changing your lists.

## Keep categories across devices

Categories, list membership/order, and the saved update-category selection are included in Gagaku's database backups and **Database Sync**. They do not require a MangaDex account and are not MangaDex account lists. See [App settings](./app-settings.md#database-sync) before configuring sync or restoring a backup.

## Trackers

**Trackers** <GuideIcon name="bookmark_added" /> opens tracker accounts and their pending progress updates. See [Trackers](./trackers.md).

## Extension maintenance tools

The bottom of the screen has maintenance tools. You do not need them for everyday use, and they do not affect your categories.

- **Migrate Extension Data** moves favorites, history, read markers, extension settings, and tracker links from one extension to another, for example when a source is republished under a new extension.
- **Prune Unused Data** removes leftover settings for uninstalled extensions, read markers for titles not in your history, and tracker links to uninstalled extensions. It shows what it will remove before you confirm.
- **Clear All Extension Settings** erases every extension's settings and saved logins, including tracker logins. Use it only as a last resort.
