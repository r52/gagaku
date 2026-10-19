# Database Sync

**Database Sync** keeps Gagaku's data in step across your devices by sharing it through a folder you control. It is optional: ordinary reading does not need a sync profile, a cloud account, or another device.

Open the **navigation menu** <GuideIcon name="menu" />, choose **Settings** <GuideIcon name="settings" />, and scroll to **Database Sync**.

<img class="guide-screen" src="/images/database-sync.webp" alt="The Database Sync section in Gagaku Settings, showing filesystem and Android document-provider Create and Join actions, followed by Backup Data, Restore Backup, and Database Directory." width="540" height="1200" />

## What sync includes

Sync copies complete database snapshots, including:

- Web Sources favorites categories and their titles, history, and chapter read markers.
- Repositories, installed extensions, and each extension's settings and saved logins.
- Tracker links.
- App, reader, MangaDex, and Web Sources preferences, plus MangaDex browsing history.

**Some data stays on each device:** MangaDex login, local-library files and paths, Startup Section, caches, tracker updates that have not been sent yet, and this device's own sync setup.

::: warning Keep the sync folder and backups private
Sync data and backups include what extensions store, which can include logins for extension websites and trackers. Only your MangaDex login is left out. Do not publish them or attach them to public bug reports.
:::

## Choose how the shared folder is accessed

| Method | When to use it |
| --- | --- |
| **Filesystem Profile** | A native folder accessible to Gagaku. A separate tool such as Syncthing can carry the folder between devices; an already-mounted share is another option. Gagaku does not configure that tool or connect directly to SMB/WebDAV servers. |
| **Document Provider Profile** | Android's folder picker, for local storage or a provider that exposes a writable document tree. The provider handles access to its storage; Gagaku does not ask for cloud credentials itself. |

Use a dedicated folder for Gagaku's sync profile, not your manga folder or the live database directory. If another tool transports the folder, make sure the complete profile has arrived before joining it on another device. Not every cloud provider exposes a usable folder through Android's picker.

## Create the first profile

1. On the device whose current data you want to start with, make a [backup](./app-settings.md#save-a-backup).
2. In **Database Sync**, choose **Create Filesystem Profile** or, on Android, **Create Document Provider Profile**.
3. Enter a recognizable **Device Name**, such as `Phone`, and tap **Save**. This saves the name for the setup flow; you still need to select storage.
4. Choose an **empty folder**. For a filesystem folder on Android, grant **All files access** if requested. For a document-provider folder, complete the Android folder-access confirmation.
5. Gagaku creates the profile and starts publishing this device's data. Check **Sync Status** and wait for **Synchronized** before setting up another device.

Create the profile once. **Create** is not the way to connect a second device or repair an existing profile.

## Join from another device

::: warning Joining is not a merge
Joining can replace this device's database with the existing profile's snapshot. Export a backup of any data you want to keep first. Gagaku does not combine two independent favorites libraries item by item.
:::

1. Make sure the existing profile is available to this device through the selected storage method.
2. Choose **Join Filesystem Profile** or **Join Document Provider Profile**, not Create.
3. Enter a different, recognizable **Device Name**, then select the folder containing the existing profile and grant access.
4. Check **Sync Status** and wait for **Synchronized**. Configure device-local login and local-library paths separately if needed.

For ordinary use, make changes on one device at a time. Let that device publish and the other device receive the changes before switching; storage-provider or file-transfer delays can otherwise produce competing snapshots.

## Check progress and resolve conflicts

Once configured, the section shows **Sync Status**, changes waiting to be sent, when data was last received and sent, and any error. **Sync Now** requests a pass immediately; **Retry Now** appears when a retry is pending.

Gagaku automatically synchronizes on app startup/resume and after database changes, and flushes pending changes when the app pauses. It is not a promise of continuous background sync while the app is closed. A separate folder-transfer tool or document provider may also need time to deliver files.

- **Storage unavailable; retry pending:** restore connectivity or folder permissions, then use **Retry Now**. Do not create a replacement profile just because storage is temporarily unavailable.
- **Remote profile disappeared; sync paused:** restore the original profile and use **Resume Sync**. If removal was intentional, forget the old configuration before setting up another profile.
- **Conflict requires resolution:** open **Resolve Conflict**. **Export Backup** lets you preserve each candidate before selecting **Use This Snapshot**. This chooses one **complete snapshot**, not a per-title merge; changes present only in another branch can be lost. Creation times are informational, not an automatic winner selection.

## Pause and maintenance controls

| Control | Effect |
| --- | --- |
| **Disable Sync / Resume Sync** | Stop and restart synchronization on this device while keeping its identity, configuration, and remote data. |
| **Forget Sync Configuration** | Available while sync is disabled. Removes this device's saved connection and identity, but leaves remote data; joining again creates a new identity. |
| **Known Devices → Retire Device** | Deletes that device's data from the sync folder. If that device still has sync enabled, it may publish again the next time it runs. |
| **Repair / Clean Remote Files** | After confirmation, deletes damaged snapshots and keeps only the newest two per device. It does not resolve conflicts. |
| **Delete Remote Profile** | Permanently deletes the profile metadata and all Gagaku snapshots in that sync folder. It is not a way to pause sync. |

Keep independent backups: the sync folder's limited snapshot retention is not a long-term backup archive.
