///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations implements BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	late final TranslationsUiEn ui = TranslationsUiEn.internal(_root);
	late final TranslationsErrorsEn errors = TranslationsErrorsEn.internal(_root);
	late final TranslationsAuthEn auth = TranslationsAuthEn.internal(_root);
	late final TranslationsSortEn sort = TranslationsSortEn.internal(_root);
	String get library => 'Library';
	late final TranslationsHistoryEn history = TranslationsHistoryEn.internal(_root);
	late final TranslationsLocalLibraryEn localLibrary = TranslationsLocalLibraryEn.internal(_root);
	late final TranslationsWebSourcesEn webSources = TranslationsWebSourcesEn.internal(_root);
	late final TranslationsSearchEn search = TranslationsSearchEn.internal(_root);
	String get settings => 'Settings';
	String arg_settings({required Object arg}) => '${arg} ${_root.settings}';
	String get saveSettings => 'Save Settings';
	String num_manga({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} Manga',
		other: '${n} Manga',
	);
	String get titles => 'Titles';
	String num_titles({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} Title',
		other: '${n} Titles',
	);
	String get feed => 'Feed';
	String num_items({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} item',
		other: '${n} items',
	);
	late final TranslationsThemeEn theme = TranslationsThemeEn.internal(_root);
	late final TranslationsReaderEn reader = TranslationsReaderEn.internal(_root);
	late final TranslationsMangadexEn mangadex = TranslationsMangadexEn.internal(_root);
	late final TranslationsMangaViewEn mangaView = TranslationsMangaViewEn.internal(_root);
	late final TranslationsReadingStatusEn readingStatus = TranslationsReadingStatusEn.internal(_root);
	late final TranslationsMangaStatusEn mangaStatus = TranslationsMangaStatusEn.internal(_root);
	late final TranslationsMangaActionsEn mangaActions = TranslationsMangaActionsEn.internal(_root);
	late final TranslationsMangaRelationsEn mangaRelations = TranslationsMangaRelationsEn.internal(_root);
	late final TranslationsTrackingEn tracking = TranslationsTrackingEn.internal(_root);
	late final TranslationsContentRatingEn contentRating = TranslationsContentRatingEn.internal(_root);
	late final TranslationsLanguageEn language = TranslationsLanguageEn.internal(_root);
	late final TranslationsColorsEn colors = TranslationsColorsEn.internal(_root);
	late final TranslationsCacheEn cache = TranslationsCacheEn.internal(_root);
	late final TranslationsBackupEn backup = TranslationsBackupEn.internal(_root);
	late final TranslationsChapterFeedEn chapterFeed = TranslationsChapterFeedEn.internal(_root);
}

// Path: ui
class TranslationsUiEn {
	TranslationsUiEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get add => 'Add';
	String get addNew => 'Add New';
	String get go => 'Go';
	String get ok => 'Ok';
	String get cancel => 'Cancel';
	String get yes => 'Yes';
	String get no => 'No';
	String get on => 'On';
	String get off => 'Off';
	String get none => 'None';
	String get block => 'Block';
	String get unblock => 'Unblock';
	String get follow => 'Follow';
	String get unfollow => 'Unfollow';
	String get create => 'Create';
	String get browse => 'Browse';
	String get manage => 'Manage';
	String get edit => 'Edit';
	String get save => 'Save';
	String get delete => 'Delete';
	String get rename => 'Rename';
	String get clear => 'Clear';
	String get gridView => 'Grid view';
	String get listView => 'List view';
	String get detailedView => 'Detailed view';
	String get gridSize => 'Grid Size';
	String get loadingDot => 'Loading...';
	String get copyClipboard => 'Copied to clipboard!';
	String get pasteClipboard => 'Paste from Clipboard';
	String get dragHint => 'Hint: Drag to reorder';
	String get makeDefault => 'Make Default';
	String get retry => 'Retry';
	String get irreversibleWarning => 'NOTE: THIS ACTION IS IRREVERSIBLE';
}

// Path: errors
class TranslationsErrorsEn {
	TranslationsErrorsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get noresults => 'No results';
	String get notitles => 'No titles';
	String get nomanga => 'No manga';
	String get nolists => 'No lists';
	String get norepos => 'No repos';
	String get noitems => 'No items';
	String get unsupportedUrl => 'Unsupported URL';
	String loginFail({required Object reason}) => 'Failed to login: ${reason}';
	String get notLoggedIn => 'Operation failed. User not logged in';
	String get unsupportedSource => 'Unsupported extension type';
	String unknownSourceID({required Object id}) => 'Unknown source ID ${id}';
	String get fetchFail => 'Something went wrong while fetching a new page';
	String get pageNotFound => 'Page Not Found';
	String pageNotFoundArg({required Object url}) => 'Can\'t find a page for: ${url}';
}

// Path: auth
class TranslationsAuthEn {
	TranslationsAuthEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get login => 'Login';
	String get logout => 'Logout';
	String get username => 'Username';
	String get password => 'Password';
	String get usernameEmptyWarning => 'Username cannot be empty';
	String get passwordEmptyWarning => 'Password cannot be empty';
	String get clientId => 'Client ID';
	String get clientSecret => 'Client Secret';
	String get clientIdEmptyWarning => 'Client ID cannot be empty';
	String get clientSecretEmptyWarning => 'Client Secret cannot be empty';
	String get fieldsEmptyWarning => 'Username/Password/Client ID/Client Secret cannot be empty';
	String loggedInAs({required Object user}) => 'Logged in as: ${user}';
	String get authenticating => 'Authenticating...';
}

// Path: sort
class TranslationsSortEn {
	TranslationsSortEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get desc => 'Descending';
	String get asc => 'Ascending';
}

// Path: history
class TranslationsHistoryEn {
	TranslationsHistoryEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get text => 'History';
	String get clear => 'Clear History';
	String get clearWarning => 'Are you sure you want to remove all history?';
}

// Path: localLibrary
class TranslationsLocalLibraryEn {
	TranslationsLocalLibraryEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get text => 'Local Library';
	String get extractingArchive => 'Extracting archive...';
	String get loadingDir => 'Loading directory...';
	String get archiveUnreadableWarning => 'This archive contains no readable images!';
	String get dirUnreadableWarning => 'This directory contains no readable images!';
	late final TranslationsLocalLibrarySettingsEn settings = TranslationsLocalLibrarySettingsEn.internal(_root);
	String get readArchive => 'Read Archive';
	String get noPathWarning => 'No library directory set!';
	String get setPath => 'Set Library Directory';
	String get scanning => 'Scanning library...';
	late final TranslationsLocalLibraryErrorsEn errors = TranslationsLocalLibraryErrorsEn.internal(_root);
	late final TranslationsLocalLibrarySortEn sort = TranslationsLocalLibrarySortEn.internal(_root);
}

// Path: webSources
class TranslationsWebSourcesEn {
	TranslationsWebSourcesEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get text => 'Web Sources';
	String get home => 'Home';
	String get homepages => 'Homepages';
	String get openUrl => 'Open URL';
	String get openLink => 'Open Link';
	late final TranslationsWebSourcesSupportedUrlEn supportedUrl = TranslationsWebSourcesSupportedUrlEn.internal(_root);
	late final TranslationsWebSourcesSettingsEn settings = TranslationsWebSourcesSettingsEn.internal(_root);
	late final TranslationsWebSourcesRepoEn repo = TranslationsWebSourcesRepoEn.internal(_root);
	late final TranslationsWebSourcesSourceEn source = TranslationsWebSourcesSourceEn.internal(_root);
	String get noSourcesWarning => 'No extensions installed!';
	String get sourceSearch => 'Source Search';
	String get resetRead => 'Reset Read Markers';
	String get resetReadWarning => 'Are you sure you want to reset all read markers for this manga?';
	String get resetAllRead => 'Reset all Read Markers';
	String get resetAllReadWarning => 'Are you sure you want to reset all read markers?';
	String get favorites => 'Favorites';
}

// Path: search
class TranslationsSearchEn {
	TranslationsSearchEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get text => 'Search';
	String arg({required Object arg}) => 'Search ${arg}';
	String get filters => 'Search Filters';
	String get resetFilters => 'Reset Filters';
	String get applyFilters => 'Apply Filters';
	String get selectedTagFilters => 'Selected Tag Filters';
	String get filterTags => 'Filter tags';
	String get otherOptions => 'Other Options';
	String get inclusion => 'Inclusion Mode';
	String get exclusion => 'Exclusion Mode';
	String get any => 'Any';
}

// Path: theme
class TranslationsThemeEn {
	TranslationsThemeEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get mode => 'Theme Mode';
	String get color => 'Theme Color';
	String get light => 'Light';
	String get dark => 'Dark';
	String get system => 'System Defined';
}

// Path: reader
class TranslationsReaderEn {
	TranslationsReaderEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsReaderDirectionEn direction = TranslationsReaderDirectionEn.internal(_root);
	late final TranslationsReaderFormatEn format = TranslationsReaderFormatEn.internal(_root);
	String get settings => 'Reader Settings';
	String get togglePageSize => 'Toggle Page Size';
	String get progressBar => 'Progress Bar';
	String get swipeGestures => 'Swipe Gestures';
	String get clickToTurn => 'Click/Tap to Turn Page';
	String get precacheCount => 'Page Preload';
}

// Path: mangadex
class TranslationsMangadexEn {
	TranslationsMangadexEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get home => 'Home';
	String get myFeed => 'My Feed';
	String get myLists => 'My Lists';
	String get followedLists => 'Followed Lists';
	String get popularNewTitles => 'Popular New Titles';
	String get staffPicks => 'Staff Picks';
	String get seasonal => 'Seasonal';
	String get recentlyAdded => 'Recently Added';
	String get byChapter => 'By Chapter';
	String get byManga => 'By Manga';
	String get localHistory => 'Reading History (local)';
	String get noFollowsMsg => 'Find some manga to follow!';
	String get noHistoryMsg => 'No reading history';
	String get createNewList => 'Create New List';
	String get createNewListBtn => '+ ${_root.mangadex.createNewList}';
	String get listName => 'List Name';
	String get listFeed => 'List Feed';
	String get listNameEmptyWarning => 'List name cannot be empty';
	String listNotExistError({required Object id}) => 'List with ID ${id} does not exist!';
	String get editList => '${_root.ui.edit} List';
	String editListError({required Object error}) => 'Failed to edit list: ${error}';
	String get createList => '${_root.ui.create} List';
	String get deleteList => '${_root.ui.delete} List';
	String get deleteListOk => 'List deleted';
	String deleteListError({required Object error}) => 'Failed to delete list: ${error}';
	String deleteListWarning({required Object list}) => 'Are you sure you want to permanently delete \'${list}\'?';
	String get privateList => 'Private list';
	String get newList => 'New List';
	String get newListOk => 'New list created';
	String newListError({required Object error}) => 'Failed to create list: ${error}';
	String get officialPub => 'Official Publisher';
	String get noGroup => 'No Group';
	String get groupDesc => 'Group Description';
	String get groupFeed => 'Group Feed';
	String get groupTitles => 'Group Titles';
	String get login => 'Login to MangaDex';
	String get contentRating => 'Content Rating';
	String get demographic => 'Demographic';
	String get pubStatus => 'Publication Status';
	String get trendingThisYear => 'Trending this year';
	String get byPopularity => 'By Popularity';
	String tagTitles({required Object tag}) => 'Browse all ${tag} titles';
	late final TranslationsMangadexCreatorEn creator = TranslationsMangadexCreatorEn.internal(_root);
	String get visibility => 'Visibility';
	late final TranslationsMangadexListVisibilityEn listVisibility = TranslationsMangadexListVisibilityEn.internal(_root);
	String get addTitles => '${_root.ui.add} ${_root.titles}';
	late final TranslationsMangadexSettingsEn settings = TranslationsMangadexSettingsEn.internal(_root);
	late final TranslationsMangadexSortEn sort = TranslationsMangadexSortEn.internal(_root);
	List<String> get ratings => [
		'Remove Rating',
		'(1) Appalling',
		'(2) Horrible',
		'(3) Very Bad',
		'(4) Bad',
		'(5) Average',
		'(6) Fine',
		'(7) Good',
		'(8) Very Good',
		'(9) Great',
		'(10) Masterpiece',
	];
}

// Path: mangaView
class TranslationsMangaViewEn {
	TranslationsMangaViewEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get altTitles => 'Alt. Titles';
	String get synopsis => 'Synopsis';
	String get info => 'Info';
	String get author => 'Author';
	String get artist => 'Artist';
	String get demographic => 'Demographics';
	String get genre => 'Genres';
	String get theme => 'Themes';
	String get format => 'Format';
	String get track => 'Track';
	String openOn({required Object arg}) => 'Open on ${arg}';
	String get chapters => 'Chapters';
	String get art => 'Art';
	String get related => 'Related';
	String get relatedTitles => 'Related Titles';
	String volume({required Object n}) => 'Volume ${n}';
	String get noVolume => 'No Volume';
	String chapter({required Object n}) => 'Chapter ${n}';
	String get officialRaw => 'Official Raw';
	String get finalChapter => 'Final Volume/Chapter';
	String markAllVisibleAs({required Object arg}) => 'Mark all visible as ${arg}';
	String markAllAs({required Object arg}) => 'Mark all as ${arg}';
	String get read => 'read';
	String get unread => 'unread';
	String markAllWarning({required Object arg}) => 'Are you sure you want to mark all visible chapters as ${arg}?';
	String get noChaptersMsg => 'No Chapters';
	String markAs({required Object arg}) => 'Mark as ${arg}';
}

// Path: readingStatus
class TranslationsReadingStatusEn {
	TranslationsReadingStatusEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get remove => 'Remove';
	String get reading => 'Reading';
	String get on_hold => 'On Hold';
	String get plan_to_read => 'Plan to Read';
	String get dropped => 'Dropped';
	String get re_reading => 'Re-reading';
	String get completed => 'Completed';
}

// Path: mangaStatus
class TranslationsMangaStatusEn {
	TranslationsMangaStatusEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get completed => 'Completed';
	String get ongoing => 'Ongoing';
	String get cancelled => 'Cancelled';
	String get hiatus => 'Hiatus';
}

// Path: mangaActions
class TranslationsMangaActionsEn {
	TranslationsMangaActionsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get addToLibrary => 'Add to Library';
	String get follow => 'Follow Manga';
	String get unfollow => 'Unfollow Manga';
	String get favorite => 'Add to Favorites';
	String get unfavorite => 'Remove from Favorites';
	String get removeHistory => 'Remove from History';
}

// Path: mangaRelations
class TranslationsMangaRelationsEn {
	TranslationsMangaRelationsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get monochrome => 'Monochrome';
	String get main_story => 'Main Story';
	String get adapted_from => 'Adapted from';
	String get based_on => 'Based on';
	String get prequel => 'Prequel';
	String get side_story => 'Side story';
	String get doujinshi => 'Doujinshi';
	String get same_franchise => 'Same franchise';
	String get shared_universe => 'Shared universe';
	String get sequel => 'Sequel';
	String get spin_off => 'Spinoff';
	String get alternate_story => 'Alternate story';
	String get alternate_version => 'Alternate version';
	String get preserialization => 'Pre-serialization';
	String get colored => 'Colored';
	String get serialization => 'Serialization';
}

// Path: tracking
class TranslationsTrackingEn {
	TranslationsTrackingEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get links => 'Links';
	String get discord => 'Discord';
	String get website => 'Website';
	String get nothing => 'Nothing here!';
}

// Path: contentRating
class TranslationsContentRatingEn {
	TranslationsContentRatingEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get safe => 'Safe';
	String get suggestive => 'Suggestive';
	String get erotica => 'Erotica';
	String get pornographic => 'Pornographic';
}

// Path: language
class TranslationsLanguageEn {
	TranslationsLanguageEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get en => 'English';
	String get ar => 'Arabic';
	String get az => 'Azerbaijani';
	String get bn => 'Bengali';
	String get bg => 'Bulgarian';
	String get my => 'Burmese';
	String get ca => 'Catalan';
	String get zh => 'Chinese (Simp.)';
	String get zh_hk => 'Chinese (Trad.)';
	String get hr => 'Croatian';
	String get cs => 'Czech';
	String get da => 'Danish';
	String get nl => 'Dutch';
	String get eo => 'Esperanto';
	String get et => 'Estonian';
	String get tl => 'Filipino';
	String get fi => 'Finnish';
	String get fr => 'French';
	String get ka => 'Georgian';
	String get de => 'German';
	String get el => 'Greek';
	String get he => 'Hebrew';
	String get hi => 'Hindi';
	String get hu => 'Hungarian';
	String get id => 'Indonesian';
	String get it => 'Italian';
	String get ja => 'Japanese';
	String get kk => 'Kazakh';
	String get ko => 'Korean';
	String get la => 'Latin';
	String get lt => 'Lithuanian';
	String get ms => 'Malay';
	String get mn => 'Mongolian';
	String get ne => 'Nepali';
	String get no => 'Norwegian';
	String get fa => 'Persian';
	String get pl => 'Polish';
	String get pt_br => 'Portuguese (BR)';
	String get pt => 'Portuguese';
	String get ro => 'Romanian';
	String get ru => 'Russian';
	String get sr => 'Serbian';
	String get sk => 'Slovak';
	String get es => 'Spanish';
	String get es_la => 'Spanish (LATAM)';
	String get sv => 'Swedish';
	String get ta => 'Tamil';
	String get th => 'Thai';
	String get tr => 'Turkish';
	String get uk => 'Ukrainian';
	String get vi => 'Vietnam';
	String get ja_ro => 'Japanese (Romanized)';
	String get ko_ro => 'Korean (Romanized)';
	String get zh_ro => 'Chinese (Romanized)';
	String get other => 'Other';
}

// Path: colors
class TranslationsColorsEn {
	TranslationsColorsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get lime => 'Lime';
	String get grey => 'Grey';
	String get amber => 'Amber';
	String get blue => 'Blue';
	String get teal => 'Teal';
	String get green => 'Green';
	String get lightgreen => 'Light Green';
	String get red => 'Red';
	String get orange => 'Orange';
	String get yellow => 'Yellow';
	String get purple => 'Purple';
}

// Path: cache
class TranslationsCacheEn {
	TranslationsCacheEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get clear => 'Clear Cache';
	String get clearSub => 'Deletes all cached data. ONLY DO THIS IF YOU KNOW WHAT YOU ARE DOING!';
	String get clearWarning => 'Are you sure you want to delete all cached data?';
	String get clearSuccess => 'Cache cleared';
}

// Path: backup
class TranslationsBackupEn {
	TranslationsBackupEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get data => 'Backup Data';
	String get dataSub => 'Backup all gagaku data and settings (excludes MangaDex login, local library files)\nNOTE: when restoring, restart the app for changes to take effect';
	String get restore => 'Restore Backup';
	String get restoreWarning => 'Restoring data from a backup file will overwrite all existing data. Are you sure you want to continue?';
	String get toFile => 'Backup Data to File';
	String get fromFile => 'Restore Data from File';
	String get success => 'Backup saved';
	String get restoreSuccess => 'Backup restored. Restart gagaku for changes to take effect';
	String get cancelled => 'Backup cancelled';
	String get restoreCancelled => 'Backup restore cancelled';
	String get restoreFail => 'Backup restore failed';
	String get dataLocation => 'Database Directory';
	String get dataLocSub => 'Changes the directory where gagaku reads and stores its database.\nRequires app restart to take effect.';
	String get dataLocDefault => 'Default';
}

// Path: chapterFeed
class TranslationsChapterFeedEn {
	TranslationsChapterFeedEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get latestUpdates => 'Latest Updates';
	String get updates => 'Updates';
}

// Path: localLibrary.settings
class TranslationsLocalLibrarySettingsEn {
	TranslationsLocalLibrarySettingsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get libraryPath => 'Manga Library Path';
	String get libraryPathDesc => 'Choose where to search for your manga library';
}

// Path: localLibrary.errors
class TranslationsLocalLibraryErrorsEn {
	TranslationsLocalLibraryErrorsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get permissionDenied => 'Permissions denied';
	String get emptyLibrary => 'Library is empty!';
	String get pathNotSet => 'Library directory not set!';
}

// Path: localLibrary.sort
class TranslationsLocalLibrarySortEn {
	TranslationsLocalLibrarySortEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get name_desc => 'Name descending';
	String get name_asc => 'Name ascending';
	String get modified_desc => 'Modified descending';
	String get modified_asc => 'Modified ascending';
}

// Path: webSources.supportedUrl
class TranslationsWebSourcesSupportedUrlEn {
	TranslationsWebSourcesSupportedUrlEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get text => 'Supported URLs';
	String arg({required Object arg}) => '${_root.webSources.supportedUrl.text}:${arg}';
}

// Path: webSources.settings
class TranslationsWebSourcesSettingsEn {
	TranslationsWebSourcesSettingsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get repos => 'Repos';
	String get reposDesc => 'Configure source repos';
	String get categories => 'Favorite Categories';
	String get categoriesDesc => 'Set up favourite list categories';
	String get newCategory => '${_root.ui.addNew} Category';
	String get addCategory => '${_root.ui.add} Category';
	String get renameCategory => '${_root.ui.rename} Category';
	String get categoryName => 'Category name';
	String get emptyCategoryWarning => 'Category name cannot be empty';
	String get usedCategoryWarning => 'Category name already used';
	String get categoriesToUpdate => 'Categories to Update';
	String get categoriesToUpdateDesc => 'Select categories which manga will be updated in Updates view';
}

// Path: webSources.repo
class TranslationsWebSourcesRepoEn {
	TranslationsWebSourcesRepoEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get list => 'Repo List';
	String get newRepo => '${_root.ui.addNew} Repo';
	String get browser => 'View in browser';
	String get add => '${_root.ui.add} Repo';
	String addConfirm({required Object repo}) => 'Are you sure you want to add the repo ${repo}?';
	String get addWarning => 'Ensure that you are only adding trusted sources!';
	String get urlHint => 'Repo URL';
	String get nameHint => 'Repo Name';
	String get urlEmptyWarning => 'URL cannot be empty';
	String get nameEmptyWarning => 'Name cannot be empty';
	String get urlInvalidWarning => 'Must be a valid URL';
	String get repoAddOK => 'Repo added';
	String get repoExists => 'Repo already exists';
	String get missingRepo => 'Missing Repo';
}

// Path: webSources.source
class TranslationsWebSourcesSourceEn {
	TranslationsWebSourcesSourceEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get settings => 'Extension Settings';
	String get manager => 'Extension Manager';
	String get noDataWarning => 'No repos nor extensions installed!';
	String get refresh => 'Refresh repos';
	String delete({required Object arg}) => '${_root.ui.delete} ${arg}';
	String add({required Object arg}) => '${_root.ui.add} ${arg}';
	String update({required Object arg}) => 'Update/Replace ${arg}';
	String get sourceDeleteOK => 'Extension disabled';
	String get sourceUpdateOK => 'Extension updated';
	String get sourceAddOK => 'Extension enabled';
	String installedVersion({required Object version}) => ' (installed: v${version})';
	String get noTagsWarning => 'This extension provides no filter options';
}

// Path: reader.direction
class TranslationsReaderDirectionEn {
	TranslationsReaderDirectionEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get leftToRight => 'Left to Right';
	String get rightToLeft => 'Right to Left';
}

// Path: reader.format
class TranslationsReaderFormatEn {
	TranslationsReaderFormatEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get single => 'Single';
	String get longstrip => 'Long Strip';
}

// Path: mangadex.creator
class TranslationsMangadexCreatorEn {
	TranslationsMangadexCreatorEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get biography => 'Biography';
	String get follow => 'Follow';
	String get works => 'Works';
}

// Path: mangadex.listVisibility
class TranslationsMangadexListVisibilityEn {
	TranslationsMangadexListVisibilityEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get private => 'Private';
	String get public => 'Public';
}

// Path: mangadex.settings
class TranslationsMangadexSettingsEn {
	TranslationsMangadexSettingsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get translatedLanguages => 'Chapter Language Filter';
	String get translatedLanguagesDesc => 'Show only chapters from these languages';
	String get originalLanguage => 'Original Language Filter';
	String get originalLanguageDesc => 'Only show titles originally published in these languages. If no languages are selected, no filter will be applied';
	String get contentRating => 'Content Filter';
	String get dataSaver => 'Data Saver';
	String get groupBlacklist => 'Blocked Groups';
	String get selectLanguages => 'Select Languages';
	String get selectContentFilters => 'Select Content Filters';
}

// Path: mangadex.sort
class TranslationsMangadexSortEn {
	TranslationsMangadexSortEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get relevance_asc => 'Worst Match';
	String get relevance_desc => 'Best Match';
	String get followedCount_asc => 'Fewest Follows';
	String get followedCount_desc => 'Most Follows';
	String get latestUploadedChapter_asc => 'Oldest Upload';
	String get latestUploadedChapter_desc => 'Latest Upload';
	String get updatedAt_asc => 'Oldest Update';
	String get updatedAt_desc => 'Latest Update';
	String get createdAt_asc => 'Oldest Added';
	String get createdAt_desc => 'Recently Added';
	String get year_asc => 'Year Ascending';
	String get year_desc => 'Year Descending';
	String get title_asc => 'Title Ascending';
	String get title_desc => 'Title Descending';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on Translations {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'ui.add': return 'Add';
			case 'ui.addNew': return 'Add New';
			case 'ui.go': return 'Go';
			case 'ui.ok': return 'Ok';
			case 'ui.cancel': return 'Cancel';
			case 'ui.yes': return 'Yes';
			case 'ui.no': return 'No';
			case 'ui.on': return 'On';
			case 'ui.off': return 'Off';
			case 'ui.none': return 'None';
			case 'ui.block': return 'Block';
			case 'ui.unblock': return 'Unblock';
			case 'ui.follow': return 'Follow';
			case 'ui.unfollow': return 'Unfollow';
			case 'ui.create': return 'Create';
			case 'ui.browse': return 'Browse';
			case 'ui.manage': return 'Manage';
			case 'ui.edit': return 'Edit';
			case 'ui.save': return 'Save';
			case 'ui.delete': return 'Delete';
			case 'ui.rename': return 'Rename';
			case 'ui.clear': return 'Clear';
			case 'ui.gridView': return 'Grid view';
			case 'ui.listView': return 'List view';
			case 'ui.detailedView': return 'Detailed view';
			case 'ui.gridSize': return 'Grid Size';
			case 'ui.loadingDot': return 'Loading...';
			case 'ui.copyClipboard': return 'Copied to clipboard!';
			case 'ui.pasteClipboard': return 'Paste from Clipboard';
			case 'ui.dragHint': return 'Hint: Drag to reorder';
			case 'ui.makeDefault': return 'Make Default';
			case 'ui.retry': return 'Retry';
			case 'ui.irreversibleWarning': return 'NOTE: THIS ACTION IS IRREVERSIBLE';
			case 'errors.noresults': return 'No results';
			case 'errors.notitles': return 'No titles';
			case 'errors.nomanga': return 'No manga';
			case 'errors.nolists': return 'No lists';
			case 'errors.norepos': return 'No repos';
			case 'errors.noitems': return 'No items';
			case 'errors.unsupportedUrl': return 'Unsupported URL';
			case 'errors.loginFail': return ({required Object reason}) => 'Failed to login: ${reason}';
			case 'errors.notLoggedIn': return 'Operation failed. User not logged in';
			case 'errors.unsupportedSource': return 'Unsupported extension type';
			case 'errors.unknownSourceID': return ({required Object id}) => 'Unknown source ID ${id}';
			case 'errors.fetchFail': return 'Something went wrong while fetching a new page';
			case 'errors.pageNotFound': return 'Page Not Found';
			case 'errors.pageNotFoundArg': return ({required Object url}) => 'Can\'t find a page for: ${url}';
			case 'auth.login': return 'Login';
			case 'auth.logout': return 'Logout';
			case 'auth.username': return 'Username';
			case 'auth.password': return 'Password';
			case 'auth.usernameEmptyWarning': return 'Username cannot be empty';
			case 'auth.passwordEmptyWarning': return 'Password cannot be empty';
			case 'auth.clientId': return 'Client ID';
			case 'auth.clientSecret': return 'Client Secret';
			case 'auth.clientIdEmptyWarning': return 'Client ID cannot be empty';
			case 'auth.clientSecretEmptyWarning': return 'Client Secret cannot be empty';
			case 'auth.fieldsEmptyWarning': return 'Username/Password/Client ID/Client Secret cannot be empty';
			case 'auth.loggedInAs': return ({required Object user}) => 'Logged in as: ${user}';
			case 'auth.authenticating': return 'Authenticating...';
			case 'sort.desc': return 'Descending';
			case 'sort.asc': return 'Ascending';
			case 'library': return 'Library';
			case 'history.text': return 'History';
			case 'history.clear': return 'Clear History';
			case 'history.clearWarning': return 'Are you sure you want to remove all history?';
			case 'localLibrary.text': return 'Local Library';
			case 'localLibrary.extractingArchive': return 'Extracting archive...';
			case 'localLibrary.loadingDir': return 'Loading directory...';
			case 'localLibrary.archiveUnreadableWarning': return 'This archive contains no readable images!';
			case 'localLibrary.dirUnreadableWarning': return 'This directory contains no readable images!';
			case 'localLibrary.settings.libraryPath': return 'Manga Library Path';
			case 'localLibrary.settings.libraryPathDesc': return 'Choose where to search for your manga library';
			case 'localLibrary.readArchive': return 'Read Archive';
			case 'localLibrary.noPathWarning': return 'No library directory set!';
			case 'localLibrary.setPath': return 'Set Library Directory';
			case 'localLibrary.scanning': return 'Scanning library...';
			case 'localLibrary.errors.permissionDenied': return 'Permissions denied';
			case 'localLibrary.errors.emptyLibrary': return 'Library is empty!';
			case 'localLibrary.errors.pathNotSet': return 'Library directory not set!';
			case 'localLibrary.sort.name_desc': return 'Name descending';
			case 'localLibrary.sort.name_asc': return 'Name ascending';
			case 'localLibrary.sort.modified_desc': return 'Modified descending';
			case 'localLibrary.sort.modified_asc': return 'Modified ascending';
			case 'webSources.text': return 'Web Sources';
			case 'webSources.home': return 'Home';
			case 'webSources.homepages': return 'Homepages';
			case 'webSources.openUrl': return 'Open URL';
			case 'webSources.openLink': return 'Open Link';
			case 'webSources.supportedUrl.text': return 'Supported URLs';
			case 'webSources.supportedUrl.arg': return ({required Object arg}) => '${_root.webSources.supportedUrl.text}:${arg}';
			case 'webSources.settings.repos': return 'Repos';
			case 'webSources.settings.reposDesc': return 'Configure source repos';
			case 'webSources.settings.categories': return 'Favorite Categories';
			case 'webSources.settings.categoriesDesc': return 'Set up favourite list categories';
			case 'webSources.settings.newCategory': return '${_root.ui.addNew} Category';
			case 'webSources.settings.addCategory': return '${_root.ui.add} Category';
			case 'webSources.settings.renameCategory': return '${_root.ui.rename} Category';
			case 'webSources.settings.categoryName': return 'Category name';
			case 'webSources.settings.emptyCategoryWarning': return 'Category name cannot be empty';
			case 'webSources.settings.usedCategoryWarning': return 'Category name already used';
			case 'webSources.settings.categoriesToUpdate': return 'Categories to Update';
			case 'webSources.settings.categoriesToUpdateDesc': return 'Select categories which manga will be updated in Updates view';
			case 'webSources.repo.list': return 'Repo List';
			case 'webSources.repo.newRepo': return '${_root.ui.addNew} Repo';
			case 'webSources.repo.browser': return 'View in browser';
			case 'webSources.repo.add': return '${_root.ui.add} Repo';
			case 'webSources.repo.addConfirm': return ({required Object repo}) => 'Are you sure you want to add the repo ${repo}?';
			case 'webSources.repo.addWarning': return 'Ensure that you are only adding trusted sources!';
			case 'webSources.repo.urlHint': return 'Repo URL';
			case 'webSources.repo.nameHint': return 'Repo Name';
			case 'webSources.repo.urlEmptyWarning': return 'URL cannot be empty';
			case 'webSources.repo.nameEmptyWarning': return 'Name cannot be empty';
			case 'webSources.repo.urlInvalidWarning': return 'Must be a valid URL';
			case 'webSources.repo.repoAddOK': return 'Repo added';
			case 'webSources.repo.repoExists': return 'Repo already exists';
			case 'webSources.repo.missingRepo': return 'Missing Repo';
			case 'webSources.source.settings': return 'Extension Settings';
			case 'webSources.source.manager': return 'Extension Manager';
			case 'webSources.source.noDataWarning': return 'No repos nor extensions installed!';
			case 'webSources.source.refresh': return 'Refresh repos';
			case 'webSources.source.delete': return ({required Object arg}) => '${_root.ui.delete} ${arg}';
			case 'webSources.source.add': return ({required Object arg}) => '${_root.ui.add} ${arg}';
			case 'webSources.source.update': return ({required Object arg}) => 'Update/Replace ${arg}';
			case 'webSources.source.sourceDeleteOK': return 'Extension disabled';
			case 'webSources.source.sourceUpdateOK': return 'Extension updated';
			case 'webSources.source.sourceAddOK': return 'Extension enabled';
			case 'webSources.source.installedVersion': return ({required Object version}) => ' (installed: v${version})';
			case 'webSources.source.noTagsWarning': return 'This extension provides no filter options';
			case 'webSources.noSourcesWarning': return 'No extensions installed!';
			case 'webSources.sourceSearch': return 'Source Search';
			case 'webSources.resetRead': return 'Reset Read Markers';
			case 'webSources.resetReadWarning': return 'Are you sure you want to reset all read markers for this manga?';
			case 'webSources.resetAllRead': return 'Reset all Read Markers';
			case 'webSources.resetAllReadWarning': return 'Are you sure you want to reset all read markers?';
			case 'webSources.favorites': return 'Favorites';
			case 'search.text': return 'Search';
			case 'search.arg': return ({required Object arg}) => 'Search ${arg}';
			case 'search.filters': return 'Search Filters';
			case 'search.resetFilters': return 'Reset Filters';
			case 'search.applyFilters': return 'Apply Filters';
			case 'search.selectedTagFilters': return 'Selected Tag Filters';
			case 'search.filterTags': return 'Filter tags';
			case 'search.otherOptions': return 'Other Options';
			case 'search.inclusion': return 'Inclusion Mode';
			case 'search.exclusion': return 'Exclusion Mode';
			case 'search.any': return 'Any';
			case 'settings': return 'Settings';
			case 'arg_settings': return ({required Object arg}) => '${arg} ${_root.settings}';
			case 'saveSettings': return 'Save Settings';
			case 'num_manga': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: '${n} Manga',
				other: '${n} Manga',
			);
			case 'titles': return 'Titles';
			case 'num_titles': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: '${n} Title',
				other: '${n} Titles',
			);
			case 'feed': return 'Feed';
			case 'num_items': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: '${n} item',
				other: '${n} items',
			);
			case 'theme.mode': return 'Theme Mode';
			case 'theme.color': return 'Theme Color';
			case 'theme.light': return 'Light';
			case 'theme.dark': return 'Dark';
			case 'theme.system': return 'System Defined';
			case 'reader.direction.leftToRight': return 'Left to Right';
			case 'reader.direction.rightToLeft': return 'Right to Left';
			case 'reader.format.single': return 'Single';
			case 'reader.format.longstrip': return 'Long Strip';
			case 'reader.settings': return 'Reader Settings';
			case 'reader.togglePageSize': return 'Toggle Page Size';
			case 'reader.progressBar': return 'Progress Bar';
			case 'reader.swipeGestures': return 'Swipe Gestures';
			case 'reader.clickToTurn': return 'Click/Tap to Turn Page';
			case 'reader.precacheCount': return 'Page Preload';
			case 'mangadex.home': return 'Home';
			case 'mangadex.myFeed': return 'My Feed';
			case 'mangadex.myLists': return 'My Lists';
			case 'mangadex.followedLists': return 'Followed Lists';
			case 'mangadex.popularNewTitles': return 'Popular New Titles';
			case 'mangadex.staffPicks': return 'Staff Picks';
			case 'mangadex.seasonal': return 'Seasonal';
			case 'mangadex.recentlyAdded': return 'Recently Added';
			case 'mangadex.byChapter': return 'By Chapter';
			case 'mangadex.byManga': return 'By Manga';
			case 'mangadex.localHistory': return 'Reading History (local)';
			case 'mangadex.noFollowsMsg': return 'Find some manga to follow!';
			case 'mangadex.noHistoryMsg': return 'No reading history';
			case 'mangadex.createNewList': return 'Create New List';
			case 'mangadex.createNewListBtn': return '+ ${_root.mangadex.createNewList}';
			case 'mangadex.listName': return 'List Name';
			case 'mangadex.listFeed': return 'List Feed';
			case 'mangadex.listNameEmptyWarning': return 'List name cannot be empty';
			case 'mangadex.listNotExistError': return ({required Object id}) => 'List with ID ${id} does not exist!';
			case 'mangadex.editList': return '${_root.ui.edit} List';
			case 'mangadex.editListError': return ({required Object error}) => 'Failed to edit list: ${error}';
			case 'mangadex.createList': return '${_root.ui.create} List';
			case 'mangadex.deleteList': return '${_root.ui.delete} List';
			case 'mangadex.deleteListOk': return 'List deleted';
			case 'mangadex.deleteListError': return ({required Object error}) => 'Failed to delete list: ${error}';
			case 'mangadex.deleteListWarning': return ({required Object list}) => 'Are you sure you want to permanently delete \'${list}\'?';
			case 'mangadex.privateList': return 'Private list';
			case 'mangadex.newList': return 'New List';
			case 'mangadex.newListOk': return 'New list created';
			case 'mangadex.newListError': return ({required Object error}) => 'Failed to create list: ${error}';
			case 'mangadex.officialPub': return 'Official Publisher';
			case 'mangadex.noGroup': return 'No Group';
			case 'mangadex.groupDesc': return 'Group Description';
			case 'mangadex.groupFeed': return 'Group Feed';
			case 'mangadex.groupTitles': return 'Group Titles';
			case 'mangadex.login': return 'Login to MangaDex';
			case 'mangadex.contentRating': return 'Content Rating';
			case 'mangadex.demographic': return 'Demographic';
			case 'mangadex.pubStatus': return 'Publication Status';
			case 'mangadex.trendingThisYear': return 'Trending this year';
			case 'mangadex.byPopularity': return 'By Popularity';
			case 'mangadex.tagTitles': return ({required Object tag}) => 'Browse all ${tag} titles';
			case 'mangadex.creator.biography': return 'Biography';
			case 'mangadex.creator.follow': return 'Follow';
			case 'mangadex.creator.works': return 'Works';
			case 'mangadex.visibility': return 'Visibility';
			case 'mangadex.listVisibility.private': return 'Private';
			case 'mangadex.listVisibility.public': return 'Public';
			case 'mangadex.addTitles': return '${_root.ui.add} ${_root.titles}';
			case 'mangadex.settings.translatedLanguages': return 'Chapter Language Filter';
			case 'mangadex.settings.translatedLanguagesDesc': return 'Show only chapters from these languages';
			case 'mangadex.settings.originalLanguage': return 'Original Language Filter';
			case 'mangadex.settings.originalLanguageDesc': return 'Only show titles originally published in these languages. If no languages are selected, no filter will be applied';
			case 'mangadex.settings.contentRating': return 'Content Filter';
			case 'mangadex.settings.dataSaver': return 'Data Saver';
			case 'mangadex.settings.groupBlacklist': return 'Blocked Groups';
			case 'mangadex.settings.selectLanguages': return 'Select Languages';
			case 'mangadex.settings.selectContentFilters': return 'Select Content Filters';
			case 'mangadex.sort.relevance_asc': return 'Worst Match';
			case 'mangadex.sort.relevance_desc': return 'Best Match';
			case 'mangadex.sort.followedCount_asc': return 'Fewest Follows';
			case 'mangadex.sort.followedCount_desc': return 'Most Follows';
			case 'mangadex.sort.latestUploadedChapter_asc': return 'Oldest Upload';
			case 'mangadex.sort.latestUploadedChapter_desc': return 'Latest Upload';
			case 'mangadex.sort.updatedAt_asc': return 'Oldest Update';
			case 'mangadex.sort.updatedAt_desc': return 'Latest Update';
			case 'mangadex.sort.createdAt_asc': return 'Oldest Added';
			case 'mangadex.sort.createdAt_desc': return 'Recently Added';
			case 'mangadex.sort.year_asc': return 'Year Ascending';
			case 'mangadex.sort.year_desc': return 'Year Descending';
			case 'mangadex.sort.title_asc': return 'Title Ascending';
			case 'mangadex.sort.title_desc': return 'Title Descending';
			case 'mangadex.ratings.0': return 'Remove Rating';
			case 'mangadex.ratings.1': return '(1) Appalling';
			case 'mangadex.ratings.2': return '(2) Horrible';
			case 'mangadex.ratings.3': return '(3) Very Bad';
			case 'mangadex.ratings.4': return '(4) Bad';
			case 'mangadex.ratings.5': return '(5) Average';
			case 'mangadex.ratings.6': return '(6) Fine';
			case 'mangadex.ratings.7': return '(7) Good';
			case 'mangadex.ratings.8': return '(8) Very Good';
			case 'mangadex.ratings.9': return '(9) Great';
			case 'mangadex.ratings.10': return '(10) Masterpiece';
			case 'mangaView.altTitles': return 'Alt. Titles';
			case 'mangaView.synopsis': return 'Synopsis';
			case 'mangaView.info': return 'Info';
			case 'mangaView.author': return 'Author';
			case 'mangaView.artist': return 'Artist';
			case 'mangaView.demographic': return 'Demographics';
			case 'mangaView.genre': return 'Genres';
			case 'mangaView.theme': return 'Themes';
			case 'mangaView.format': return 'Format';
			case 'mangaView.track': return 'Track';
			case 'mangaView.openOn': return ({required Object arg}) => 'Open on ${arg}';
			case 'mangaView.chapters': return 'Chapters';
			case 'mangaView.art': return 'Art';
			case 'mangaView.related': return 'Related';
			case 'mangaView.relatedTitles': return 'Related Titles';
			case 'mangaView.volume': return ({required Object n}) => 'Volume ${n}';
			case 'mangaView.noVolume': return 'No Volume';
			case 'mangaView.chapter': return ({required Object n}) => 'Chapter ${n}';
			case 'mangaView.officialRaw': return 'Official Raw';
			case 'mangaView.finalChapter': return 'Final Volume/Chapter';
			case 'mangaView.markAllVisibleAs': return ({required Object arg}) => 'Mark all visible as ${arg}';
			case 'mangaView.markAllAs': return ({required Object arg}) => 'Mark all as ${arg}';
			case 'mangaView.read': return 'read';
			case 'mangaView.unread': return 'unread';
			case 'mangaView.markAllWarning': return ({required Object arg}) => 'Are you sure you want to mark all visible chapters as ${arg}?';
			case 'mangaView.noChaptersMsg': return 'No Chapters';
			case 'mangaView.markAs': return ({required Object arg}) => 'Mark as ${arg}';
			case 'readingStatus.remove': return 'Remove';
			case 'readingStatus.reading': return 'Reading';
			case 'readingStatus.on_hold': return 'On Hold';
			case 'readingStatus.plan_to_read': return 'Plan to Read';
			case 'readingStatus.dropped': return 'Dropped';
			case 'readingStatus.re_reading': return 'Re-reading';
			case 'readingStatus.completed': return 'Completed';
			case 'mangaStatus.completed': return 'Completed';
			case 'mangaStatus.ongoing': return 'Ongoing';
			case 'mangaStatus.cancelled': return 'Cancelled';
			case 'mangaStatus.hiatus': return 'Hiatus';
			case 'mangaActions.addToLibrary': return 'Add to Library';
			case 'mangaActions.follow': return 'Follow Manga';
			case 'mangaActions.unfollow': return 'Unfollow Manga';
			case 'mangaActions.favorite': return 'Add to Favorites';
			case 'mangaActions.unfavorite': return 'Remove from Favorites';
			case 'mangaActions.removeHistory': return 'Remove from History';
			case 'mangaRelations.monochrome': return 'Monochrome';
			case 'mangaRelations.main_story': return 'Main Story';
			case 'mangaRelations.adapted_from': return 'Adapted from';
			case 'mangaRelations.based_on': return 'Based on';
			case 'mangaRelations.prequel': return 'Prequel';
			case 'mangaRelations.side_story': return 'Side story';
			case 'mangaRelations.doujinshi': return 'Doujinshi';
			case 'mangaRelations.same_franchise': return 'Same franchise';
			case 'mangaRelations.shared_universe': return 'Shared universe';
			case 'mangaRelations.sequel': return 'Sequel';
			case 'mangaRelations.spin_off': return 'Spinoff';
			case 'mangaRelations.alternate_story': return 'Alternate story';
			case 'mangaRelations.alternate_version': return 'Alternate version';
			case 'mangaRelations.preserialization': return 'Pre-serialization';
			case 'mangaRelations.colored': return 'Colored';
			case 'mangaRelations.serialization': return 'Serialization';
			case 'tracking.links': return 'Links';
			case 'tracking.discord': return 'Discord';
			case 'tracking.website': return 'Website';
			case 'tracking.nothing': return 'Nothing here!';
			case 'contentRating.safe': return 'Safe';
			case 'contentRating.suggestive': return 'Suggestive';
			case 'contentRating.erotica': return 'Erotica';
			case 'contentRating.pornographic': return 'Pornographic';
			case 'language.en': return 'English';
			case 'language.ar': return 'Arabic';
			case 'language.az': return 'Azerbaijani';
			case 'language.bn': return 'Bengali';
			case 'language.bg': return 'Bulgarian';
			case 'language.my': return 'Burmese';
			case 'language.ca': return 'Catalan';
			case 'language.zh': return 'Chinese (Simp.)';
			case 'language.zh_hk': return 'Chinese (Trad.)';
			case 'language.hr': return 'Croatian';
			case 'language.cs': return 'Czech';
			case 'language.da': return 'Danish';
			case 'language.nl': return 'Dutch';
			case 'language.eo': return 'Esperanto';
			case 'language.et': return 'Estonian';
			case 'language.tl': return 'Filipino';
			case 'language.fi': return 'Finnish';
			case 'language.fr': return 'French';
			case 'language.ka': return 'Georgian';
			case 'language.de': return 'German';
			case 'language.el': return 'Greek';
			case 'language.he': return 'Hebrew';
			case 'language.hi': return 'Hindi';
			case 'language.hu': return 'Hungarian';
			case 'language.id': return 'Indonesian';
			case 'language.it': return 'Italian';
			case 'language.ja': return 'Japanese';
			case 'language.kk': return 'Kazakh';
			case 'language.ko': return 'Korean';
			case 'language.la': return 'Latin';
			case 'language.lt': return 'Lithuanian';
			case 'language.ms': return 'Malay';
			case 'language.mn': return 'Mongolian';
			case 'language.ne': return 'Nepali';
			case 'language.no': return 'Norwegian';
			case 'language.fa': return 'Persian';
			case 'language.pl': return 'Polish';
			case 'language.pt_br': return 'Portuguese (BR)';
			case 'language.pt': return 'Portuguese';
			case 'language.ro': return 'Romanian';
			case 'language.ru': return 'Russian';
			case 'language.sr': return 'Serbian';
			case 'language.sk': return 'Slovak';
			case 'language.es': return 'Spanish';
			case 'language.es_la': return 'Spanish (LATAM)';
			case 'language.sv': return 'Swedish';
			case 'language.ta': return 'Tamil';
			case 'language.th': return 'Thai';
			case 'language.tr': return 'Turkish';
			case 'language.uk': return 'Ukrainian';
			case 'language.vi': return 'Vietnam';
			case 'language.ja_ro': return 'Japanese (Romanized)';
			case 'language.ko_ro': return 'Korean (Romanized)';
			case 'language.zh_ro': return 'Chinese (Romanized)';
			case 'language.other': return 'Other';
			case 'colors.lime': return 'Lime';
			case 'colors.grey': return 'Grey';
			case 'colors.amber': return 'Amber';
			case 'colors.blue': return 'Blue';
			case 'colors.teal': return 'Teal';
			case 'colors.green': return 'Green';
			case 'colors.lightgreen': return 'Light Green';
			case 'colors.red': return 'Red';
			case 'colors.orange': return 'Orange';
			case 'colors.yellow': return 'Yellow';
			case 'colors.purple': return 'Purple';
			case 'cache.clear': return 'Clear Cache';
			case 'cache.clearSub': return 'Deletes all cached data. ONLY DO THIS IF YOU KNOW WHAT YOU ARE DOING!';
			case 'cache.clearWarning': return 'Are you sure you want to delete all cached data?';
			case 'cache.clearSuccess': return 'Cache cleared';
			case 'backup.data': return 'Backup Data';
			case 'backup.dataSub': return 'Backup all gagaku data and settings (excludes MangaDex login, local library files)\nNOTE: when restoring, restart the app for changes to take effect';
			case 'backup.restore': return 'Restore Backup';
			case 'backup.restoreWarning': return 'Restoring data from a backup file will overwrite all existing data. Are you sure you want to continue?';
			case 'backup.toFile': return 'Backup Data to File';
			case 'backup.fromFile': return 'Restore Data from File';
			case 'backup.success': return 'Backup saved';
			case 'backup.restoreSuccess': return 'Backup restored. Restart gagaku for changes to take effect';
			case 'backup.cancelled': return 'Backup cancelled';
			case 'backup.restoreCancelled': return 'Backup restore cancelled';
			case 'backup.restoreFail': return 'Backup restore failed';
			case 'backup.dataLocation': return 'Database Directory';
			case 'backup.dataLocSub': return 'Changes the directory where gagaku reads and stores its database.\nRequires app restart to take effect.';
			case 'backup.dataLocDefault': return 'Default';
			case 'chapterFeed.latestUpdates': return 'Latest Updates';
			case 'chapterFeed.updates': return 'Updates';
			default: return null;
		}
	}
}

