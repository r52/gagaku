# App settings

Open the **navigation menu** <GuideIcon name="menu" /> in any context, then choose **Settings** <GuideIcon name="settings" />. This opens **Gagaku Settings**. The settings icon in a context's toolbar instead opens that context's settings.

## Startup, appearance, and updates

| Option | What it changes |
| --- | --- |
| **Startup Section** | The context opened on a normal launch: MangaDex, Web Sources, or Local Library. |
| **Theme Mode** | Light, Dark, or System Defined. |
| **Theme Color** | The app's accent color. |
| **Check for Updates** | Whether Gagaku checks for new app versions on startup. |
| **Update Channel** | Stable or Beta app releases. Choose Stable unless you want to try prereleases. |
| **Check Frequency** | How often to check for app updates: hourly, daily, weekly, or monthly. |

These choices save when you select them; there is no global **Save Settings** button.

<img class="guide-screen" src="/images/app-settings.webp" alt="Gagaku Settings on Android, showing Startup Section, Theme Mode, Theme Color, and app-update preferences." width="540" height="1200" />

**Clear Cache** removes temporarily cached data after confirmation. Your favorites and settings are kept. It is rarely the fix for an extension or website problem, so try [Troubleshooting](./troubleshooting.md) first.

## Database Sync

**Database Sync** keeps your favorites, history, extensions, and settings in step across devices through a folder you control. It is optional. See [Database Sync](./database-sync.md) to set it up.

## Backup and restore

### Save a backup

1. Open **Gagaku Settings → Backup Data** <GuideIcon name="save" />.
2. Choose a destination in the system save dialog and save the suggested `gagaku_backup-….json` file.
3. Wait for **Backup saved**. Keep a dated copy outside the app, especially before restoring, joining a sync profile, or changing database storage.

The backup contains your settings, favorites, history, read markers, repositories, installed extensions, extension settings and logins, and tracker links. It does **not** include MangaDex login, local manga files or library paths, Database Directory, Startup Section, or sync setup. Keep it private: it can contain logins that extensions store. Only your MangaDex login is left out.

### Restore a backup

::: warning Restore overwrites data
Make a backup of the current data first. **Restore Backup** replaces existing data; it does not merge favorites with the file. If [Database Sync](./database-sync.md) is configured, disable it before restoring and decide which database you want to keep before resuming: a restore can become a synchronized change or conflict.
:::

1. Open **Gagaku Settings → Restore Backup**.
2. Read the overwrite warning and tap **Yes** only when ready. **No** cancels without opening a backup file.
3. Select your Gagaku JSON backup in the file picker.
4. Wait for **Backup restored**, then check your favorites and settings. On a new installation, configure MangaDex login and local-library paths separately.

<img class="guide-screen" src="/images/restore-warning.webp" alt="Android Restore Backup confirmation stating that existing data will be overwritten and the action is irreversible, with No and Yes buttons." width="540" height="1200" />

## Database Directory is not sync

**Database Directory** sets where Gagaku keeps its database, starting from the next launch. It is not your manga folder, and most people never need to change it.

Changing it does not move your existing data. After a restart with a new, empty location, your favorites and settings will appear to be missing. Make a backup first, restore it after the change, and keep the old location until you have checked the result.

**Do not copy or sync the database folder (`data.mdb`) between devices with another tool.** Use [Database Sync](./database-sync.md) instead.
