# MangaDex

The built-in MangaDex client works without an extension repository. **You can browse titles and read available chapters without signing in.**

## Find a title and chapter

1. Select **MangaDex** from the navigation menu.
2. Browse **Home**, or use **Search MangaDex** <GuideIcon name="search" /> in the top toolbar.
3. Open a title, then choose a chapter from its chapter list.

Titles and chapters are different: a title can exist on MangaDex without having readable chapters in your selected language.

## Choose your chapter languages

Open **MangaDex Settings** <GuideIcon name="settings" /> in the toolbar. Set **Chapter Language Filter** to the languages you read, then tap **Save Settings**.

**Original Language Filter** filters titles by the language they were originally published in; it is not the chapter translation filter. The **Content Filter** also affects what you see.

If chapters seem to be missing, check these preferences before assuming the title is unavailable. **Data Saver** is available here if you prefer MangaDex's lower-bandwidth image option.

## Sign in only if you need account features

Account features such as **My Feed**, **Library**, and **My Lists** require your MangaDex login. It is not necessary for your first chapter.

Gagaku's current login form needs all four fields:

- **Username** and **Password** for your MangaDex account.
- **Client ID** and **Client Secret** from your MangaDex **personal API client**.

Follow [MangaDex's personal-client instructions](https://api.mangadex.org/docs/02-authentication/personal-clients/) to create a client under the API clients section of your MangaDex account settings. The client must belong to the same account you use to sign in. Copy its ID and secret into Gagaku's **Login** screen, fill in your username and password, then tap **Login**.

Keep your password and client secret private. If you do not want to create a personal client, skip login and continue browsing and reading anonymously.

## Keep track of titles

When signed in, use **Add to Library** on a title to choose its reading status and whether to follow it. The MangaDex **Library** and **My Feed** use your MangaDex account; they are separate from Web Sources favorites and your local files.

For page controls, see [Reading & favorites](./reading.md).
