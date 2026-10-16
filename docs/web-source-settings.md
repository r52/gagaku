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

**Delete** removes a category after confirmation; its entries are removed from that favorites list when you save the parent settings. Move titles you want to retain to another category first. Deleting a category is not a chapter-download or local-file operation.

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

This selection controls which favorites are queried for chapter updates. It does not move titles between categories, install sources, mark chapters read, or schedule downloads. Adding or editing categories does not automatically put them in **Categories to Update**; check the selection again after changing your lists.

## Keep categories across devices

Categories, list membership/order, and the saved update-category selection are included in Gagaku's database backups and **Database Sync**. They do not require a MangaDex account and are not MangaDex account lists. See [App settings](./app-settings.md#database-sync) before configuring sync or restoring a backup.

## Do not confuse categories with extension maintenance

**Clear All Extension Settings** clears extensions' persisted settings/state, including their secure state. It is not the way to remove a favorites category and may remove source-specific configuration or login state. **Migrate Extension Data** and **Prune Unused Data** are separate maintenance tools, not part of ordinary category setup. Do not run them just to rearrange your lists.
