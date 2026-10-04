# Local Library

Local Library reads files you already have. It does not download manga, copy a collection into a managed library, or require an extension repository.

You can read image directories and **CBZ/ZIP** or **CBT/TAR** archives. On **Android**, PDF and EPUB files are supported too.

## Open one archive without setting up a library

1. Select **Local Library** from the navigation menu.
2. Tap **Read Archive** on the initial screen, or open the **three-dot menu** <GuideIcon name="more_vert" /> → **Read Archive**.
3. Choose a CBZ, ZIP, CBT, or TAR file in the file picker.

The archive should contain readable images. An archive with no supported images cannot be opened as a manga chapter.

## Set up a folder to browse

1. Put your manga files in a folder you can access on the device.
2. Open **Local Library**. On Android, Gagaku may first open the system's **All files access** screen. Enable access for Gagaku if you want it to scan your local directories, then return to the app.
3. Tap **Set Library Directory**, or **Local Library Settings** <GuideIcon name="settings" />.
4. Tap **Manga Library Path** and choose your folder. Grant Android's storage permission if it is requested here.
5. Tap **Save Settings**.
6. Wait for the library scan. Tap a folder to browse it, or a readable image directory/archive to open the reader.

Use a parent folder containing your titles or chapter archives. A folder that directly contains readable images is treated as a readable item, rather than a container to browse further.

After adding files, return to the library and pull down to refresh it. If the list remains empty, check the selected path and storage permission; see [Troubleshooting](./troubleshooting.md#local-library-is-empty-or-cannot-read-files).

::: tip Permission scope
Android's directory scanning uses **All files access**, not just a document-tree grant for one folder. The direct file picker is a separate way to open an archive or document without configuring a scanned library directory.
:::

## PDF and EPUB on Android

In Local Library, open the **three-dot menu → Read Document** and select a PDF or EPUB. You can also open documents discovered in your configured library folder.

The document reader has its own controls; the manga reader's Single/Long Strip settings do not control PDF or EPUB layout. EPUB text-size and paginated/continuous-scrolling preferences can be adjusted in the document reader.

PDF and EPUB entries and the **Read Document** action are not available on Windows or Linux.
