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

	/// en: 'Library'
	String get library => 'Library';

	late final TranslationsHistoryEn history = TranslationsHistoryEn.internal(_root);
	late final TranslationsLocalLibraryEn localLibrary = TranslationsLocalLibraryEn.internal(_root);
	late final TranslationsWebSourcesEn webSources = TranslationsWebSourcesEn.internal(_root);
	late final TranslationsSearchEn search = TranslationsSearchEn.internal(_root);

	/// en: 'Settings'
	String get settings => 'Settings';

	/// en: '$arg Settings'
	String arg_settings({required Object arg}) => '${arg} ${_root.settings}';

	/// en: 'Save Settings'
	String get saveSettings => 'Save Settings';

	/// en: '(one) {$n Manga} (other) {$n Manga}'
	String num_manga({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} Manga',
		other: '${n} Manga',
	);

	/// en: 'Titles'
	String get titles => 'Titles';

	/// en: '(one) {$n Title} (other) {$n Titles}'
	String num_titles({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} Title',
		other: '${n} Titles',
	);

	/// en: 'Feed'
	String get feed => 'Feed';

	/// en: '(one) {$n item} (other) {$n items}'
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
	late final TranslationsPermissionsEn permissions = TranslationsPermissionsEn.internal(_root);
}

// Path: ui
class TranslationsUiEn {
	TranslationsUiEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Add'
	String get add => 'Add';

	/// en: 'Add New'
	String get addNew => 'Add New';

	/// en: 'Go'
	String get go => 'Go';

	/// en: 'Ok'
	String get ok => 'Ok';

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Yes'
	String get yes => 'Yes';

	/// en: 'No'
	String get no => 'No';

	/// en: 'On'
	String get on => 'On';

	/// en: 'Off'
	String get off => 'Off';

	/// en: 'None'
	String get none => 'None';

	/// en: 'Block'
	String get block => 'Block';

	/// en: 'Unblock'
	String get unblock => 'Unblock';

	/// en: 'Follow'
	String get follow => 'Follow';

	/// en: 'Unfollow'
	String get unfollow => 'Unfollow';

	/// en: 'Create'
	String get create => 'Create';

	/// en: 'Browse'
	String get browse => 'Browse';

	/// en: 'Manage'
	String get manage => 'Manage';

	/// en: 'Edit'
	String get edit => 'Edit';

	/// en: 'Save'
	String get save => 'Save';

	/// en: 'Delete'
	String get delete => 'Delete';

	/// en: 'Rename'
	String get rename => 'Rename';

	/// en: 'Clear'
	String get clear => 'Clear';

	/// en: 'Grid view'
	String get gridView => 'Grid view';

	/// en: 'List view'
	String get listView => 'List view';

	/// en: 'Detailed view'
	String get detailedView => 'Detailed view';

	/// en: 'Grid Size'
	String get gridSize => 'Grid Size';

	/// en: 'Loading...'
	String get loadingDot => 'Loading...';

	/// en: 'Copied to clipboard!'
	String get copyClipboard => 'Copied to clipboard!';

	/// en: 'Paste from Clipboard'
	String get pasteClipboard => 'Paste from Clipboard';

	/// en: 'Hint: Drag to reorder'
	String get dragHint => 'Hint: Drag to reorder';

	/// en: 'Make Default'
	String get makeDefault => 'Make Default';

	/// en: 'Retry'
	String get retry => 'Retry';

	/// en: 'NOTE: THIS ACTION IS IRREVERSIBLE'
	String get irreversibleWarning => 'NOTE: THIS ACTION IS IRREVERSIBLE';

	/// en: 'Filter Items'
	String get filterItems => 'Filter Items';

	/// en: 'Are you sure you want to continue?'
	String get sureContinue => 'Are you sure you want to continue?';
}

// Path: errors
class TranslationsErrorsEn {
	TranslationsErrorsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'No results'
	String get noresults => 'No results';

	/// en: 'No titles'
	String get notitles => 'No titles';

	/// en: 'No manga'
	String get nomanga => 'No manga';

	/// en: 'No lists'
	String get nolists => 'No lists';

	/// en: 'No repos'
	String get norepos => 'No repos';

	/// en: 'No items'
	String get noitems => 'No items';

	/// en: 'Unsupported URL'
	String get unsupportedUrl => 'Unsupported URL';

	/// en: 'Failed to login: $reason'
	String loginFail({required Object reason}) => 'Failed to login: ${reason}';

	/// en: 'Operation failed. User not logged in'
	String get notLoggedIn => 'Operation failed. User not logged in';

	/// en: 'Unsupported extension type'
	String get unsupportedSource => 'Unsupported extension type';

	/// en: 'Unknown source ID $id'
	String unknownSourceID({required Object id}) => 'Unknown source ID ${id}';

	/// en: 'Something went wrong while fetching a new page'
	String get fetchFail => 'Something went wrong while fetching a new page';

	/// en: 'Page Not Found'
	String get pageNotFound => 'Page Not Found';

	/// en: 'Can't find a page for: $url'
	String pageNotFoundArg({required Object url}) => 'Can\'t find a page for: ${url}';

	/// en: 'Failed to launch $url'
	String failedLaunchUrl({required Object url}) => 'Failed to launch ${url}';
}

// Path: auth
class TranslationsAuthEn {
	TranslationsAuthEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Login'
	String get login => 'Login';

	/// en: 'Logout'
	String get logout => 'Logout';

	/// en: 'Username'
	String get username => 'Username';

	/// en: 'Password'
	String get password => 'Password';

	/// en: 'Username cannot be empty'
	String get usernameEmptyWarning => 'Username cannot be empty';

	/// en: 'Password cannot be empty'
	String get passwordEmptyWarning => 'Password cannot be empty';

	/// en: 'Client ID'
	String get clientId => 'Client ID';

	/// en: 'Client Secret'
	String get clientSecret => 'Client Secret';

	/// en: 'Client ID cannot be empty'
	String get clientIdEmptyWarning => 'Client ID cannot be empty';

	/// en: 'Client Secret cannot be empty'
	String get clientSecretEmptyWarning => 'Client Secret cannot be empty';

	/// en: 'Username/Password/Client ID/Client Secret cannot be empty'
	String get fieldsEmptyWarning => 'Username/Password/Client ID/Client Secret cannot be empty';

	/// en: 'Logged in as: $user'
	String loggedInAs({required Object user}) => 'Logged in as: ${user}';

	/// en: 'Authenticating...'
	String get authenticating => 'Authenticating...';
}

// Path: sort
class TranslationsSortEn {
	TranslationsSortEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Descending'
	String get desc => 'Descending';

	/// en: 'Ascending'
	String get asc => 'Ascending';
}

// Path: history
class TranslationsHistoryEn {
	TranslationsHistoryEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'History'
	String get text => 'History';

	/// en: 'Clear History'
	String get clear => 'Clear History';

	/// en: 'Are you sure you want to remove all history?'
	String get clearWarning => 'Are you sure you want to remove all history?';
}

// Path: localLibrary
class TranslationsLocalLibraryEn {
	TranslationsLocalLibraryEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Local Library'
	String get text => 'Local Library';

	/// en: 'Extracting archive...'
	String get extractingArchive => 'Extracting archive...';

	/// en: 'Loading directory...'
	String get loadingDir => 'Loading directory...';

	/// en: 'This archive contains no readable images!'
	String get archiveUnreadableWarning => 'This archive contains no readable images!';

	/// en: 'This directory contains no readable images!'
	String get dirUnreadableWarning => 'This directory contains no readable images!';

	late final TranslationsLocalLibrarySettingsEn settings = TranslationsLocalLibrarySettingsEn.internal(_root);

	/// en: 'Read Archive'
	String get readArchive => 'Read Archive';

	/// en: 'No library directory set!'
	String get noPathWarning => 'No library directory set!';

	/// en: 'Set Library Directory'
	String get setPath => 'Set Library Directory';

	/// en: 'Scanning library...'
	String get scanning => 'Scanning library...';

	late final TranslationsLocalLibraryErrorsEn errors = TranslationsLocalLibraryErrorsEn.internal(_root);
	late final TranslationsLocalLibrarySortEn sort = TranslationsLocalLibrarySortEn.internal(_root);
}

// Path: webSources
class TranslationsWebSourcesEn {
	TranslationsWebSourcesEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Web Sources'
	String get text => 'Web Sources';

	/// en: 'Home'
	String get home => 'Home';

	/// en: 'Homepages'
	String get homepages => 'Homepages';

	/// en: 'Open URL'
	String get openUrl => 'Open URL';

	/// en: 'Open Link'
	String get openLink => 'Open Link';

	late final TranslationsWebSourcesSupportedUrlEn supportedUrl = TranslationsWebSourcesSupportedUrlEn.internal(_root);
	late final TranslationsWebSourcesSettingsEn settings = TranslationsWebSourcesSettingsEn.internal(_root);
	late final TranslationsWebSourcesRepoEn repo = TranslationsWebSourcesRepoEn.internal(_root);
	late final TranslationsWebSourcesSourceEn source = TranslationsWebSourcesSourceEn.internal(_root);

	/// en: 'Source ${id} Unavailable'
	String sourceUnavailable({required Object id}) => 'Source ${id} Unavailable';

	/// en: 'No extensions installed!'
	String get noSourcesWarning => 'No extensions installed!';

	/// en: 'No searchable extensions installed!'
	String get noSearchableSourcesWarning => 'No searchable extensions installed!';

	/// en: 'Extension Search'
	String get sourceSearch => 'Extension Search';

	/// en: 'Reset Read Markers'
	String get resetRead => 'Reset Read Markers';

	/// en: 'Are you sure you want to reset all read markers for this manga?'
	String get resetReadWarning => 'Are you sure you want to reset all read markers for this manga?';

	/// en: 'Reset all Read Markers'
	String get resetAllRead => 'Reset all Read Markers';

	/// en: 'Are you sure you want to reset all read markers?'
	String get resetAllReadWarning => 'Are you sure you want to reset all read markers?';

	/// en: 'Favorites'
	String get favorites => 'Favorites';

	/// en: 'Error loading installed sources'
	String get loadInstalledSourcesError => 'Error loading installed sources';

	/// en: 'Search with extensions'
	String get searchWithExt => 'Search with extensions';

	/// en: 'Your manga browsing history appears here'
	String get historyHere => 'Your manga browsing history appears here';

	/// en: 'Save History?'
	String get saveHistory => 'Save History?';
}

// Path: search
class TranslationsSearchEn {
	TranslationsSearchEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Search'
	String get text => 'Search';

	/// en: 'Search $arg'
	String arg({required Object arg}) => 'Search ${arg}';

	/// en: 'Search Filters'
	String get filters => 'Search Filters';

	/// en: 'Reset Filters'
	String get resetFilters => 'Reset Filters';

	/// en: 'Apply Filters'
	String get applyFilters => 'Apply Filters';

	/// en: 'Selected Tag Filters'
	String get selectedTagFilters => 'Selected Tag Filters';

	/// en: 'Filter tags'
	String get filterTags => 'Filter tags';

	/// en: 'Other Options'
	String get otherOptions => 'Other Options';

	/// en: 'Inclusion Mode'
	String get inclusion => 'Inclusion Mode';

	/// en: 'Exclusion Mode'
	String get exclusion => 'Exclusion Mode';

	/// en: 'Any'
	String get any => 'Any';
}

// Path: theme
class TranslationsThemeEn {
	TranslationsThemeEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Theme Mode'
	String get mode => 'Theme Mode';

	/// en: 'Theme Color'
	String get color => 'Theme Color';

	/// en: 'Light'
	String get light => 'Light';

	/// en: 'Dark'
	String get dark => 'Dark';

	/// en: 'System Defined'
	String get system => 'System Defined';
}

// Path: reader
class TranslationsReaderEn {
	TranslationsReaderEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsReaderDirectionEn direction = TranslationsReaderDirectionEn.internal(_root);
	late final TranslationsReaderFormatEn format = TranslationsReaderFormatEn.internal(_root);

	/// en: 'Reader Settings'
	String get settings => 'Reader Settings';

	/// en: 'Toggle Page Size'
	String get togglePageSize => 'Toggle Page Size';

	/// en: 'Progress Bar'
	String get progressBar => 'Progress Bar';

	/// en: 'Swipe Gestures'
	String get swipeGestures => 'Swipe Gestures';

	/// en: 'Click/Tap to Turn Page'
	String get clickToTurn => 'Click/Tap to Turn Page';

	/// en: 'Page Preload'
	String get precacheCount => 'Page Preload';
}

// Path: mangadex
class TranslationsMangadexEn {
	TranslationsMangadexEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Home'
	String get home => 'Home';

	/// en: 'My Feed'
	String get myFeed => 'My Feed';

	/// en: 'My Lists'
	String get myLists => 'My Lists';

	/// en: 'Followed Lists'
	String get followedLists => 'Followed Lists';

	/// en: 'Popular New Titles'
	String get popularNewTitles => 'Popular New Titles';

	/// en: 'Staff Picks'
	String get staffPicks => 'Staff Picks';

	/// en: 'Seasonal'
	String get seasonal => 'Seasonal';

	/// en: 'Recently Added'
	String get recentlyAdded => 'Recently Added';

	/// en: 'By Chapter'
	String get byChapter => 'By Chapter';

	/// en: 'By Manga'
	String get byManga => 'By Manga';

	/// en: 'Reading History (local)'
	String get localHistory => 'Reading History (local)';

	/// en: 'Find some manga to follow!'
	String get noFollowsMsg => 'Find some manga to follow!';

	/// en: 'No reading history'
	String get noHistoryMsg => 'No reading history';

	/// en: 'Create New List'
	String get createNewList => 'Create New List';

	/// en: '+ Create New List'
	String get createNewListBtn => '+ ${_root.mangadex.createNewList}';

	/// en: 'List Name'
	String get listName => 'List Name';

	/// en: 'List Feed'
	String get listFeed => 'List Feed';

	/// en: 'List name cannot be empty'
	String get listNameEmptyWarning => 'List name cannot be empty';

	/// en: 'List with ID $id does not exist!'
	String listNotExistError({required Object id}) => 'List with ID ${id} does not exist!';

	/// en: 'Edit List'
	String get editList => '${_root.ui.edit} List';

	/// en: 'Failed to edit list: $error'
	String editListError({required Object error}) => 'Failed to edit list: ${error}';

	/// en: 'Create List'
	String get createList => '${_root.ui.create} List';

	/// en: 'Delete List'
	String get deleteList => '${_root.ui.delete} List';

	/// en: 'List deleted'
	String get deleteListOk => 'List deleted';

	/// en: 'Failed to delete list: $error'
	String deleteListError({required Object error}) => 'Failed to delete list: ${error}';

	/// en: 'Are you sure you want to permanently delete '$list'?'
	String deleteListWarning({required Object list}) => 'Are you sure you want to permanently delete \'${list}\'?';

	/// en: 'Private list'
	String get privateList => 'Private list';

	/// en: 'New List'
	String get newList => 'New List';

	/// en: 'New list created'
	String get newListOk => 'New list created';

	/// en: 'Failed to create list: $error'
	String newListError({required Object error}) => 'Failed to create list: ${error}';

	/// en: 'Official Publisher'
	String get officialPub => 'Official Publisher';

	/// en: 'No Group'
	String get noGroup => 'No Group';

	/// en: 'Group Description'
	String get groupDesc => 'Group Description';

	/// en: 'Group Feed'
	String get groupFeed => 'Group Feed';

	/// en: 'Group Titles'
	String get groupTitles => 'Group Titles';

	/// en: 'Login to MangaDex'
	String get login => 'Login to MangaDex';

	/// en: 'Content Rating'
	String get contentRating => 'Content Rating';

	/// en: 'Demographic'
	String get demographic => 'Demographic';

	/// en: 'Publication Status'
	String get pubStatus => 'Publication Status';

	/// en: 'Trending this year'
	String get trendingThisYear => 'Trending this year';

	/// en: 'By Popularity'
	String get byPopularity => 'By Popularity';

	/// en: 'Browse all $tag titles'
	String tagTitles({required Object tag}) => 'Browse all ${tag} titles';

	late final TranslationsMangadexCreatorEn creator = TranslationsMangadexCreatorEn.internal(_root);

	/// en: 'Visibility'
	String get visibility => 'Visibility';

	late final TranslationsMangadexListVisibilityEn listVisibility = TranslationsMangadexListVisibilityEn.internal(_root);

	/// en: 'Add Titles'
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

	/// en: 'Alt. Titles'
	String get altTitles => 'Alt. Titles';

	/// en: 'Synopsis'
	String get synopsis => 'Synopsis';

	/// en: 'Info'
	String get info => 'Info';

	/// en: 'Author'
	String get author => 'Author';

	/// en: 'Artist'
	String get artist => 'Artist';

	/// en: 'Demographics'
	String get demographic => 'Demographics';

	/// en: 'Genres'
	String get genre => 'Genres';

	/// en: 'Themes'
	String get theme => 'Themes';

	/// en: 'Format'
	String get format => 'Format';

	/// en: 'Track'
	String get track => 'Track';

	/// en: 'Open on $arg'
	String openOn({required Object arg}) => 'Open on ${arg}';

	/// en: 'Chapters'
	String get chapters => 'Chapters';

	/// en: 'Art'
	String get art => 'Art';

	/// en: 'Related'
	String get related => 'Related';

	/// en: 'Related Titles'
	String get relatedTitles => 'Related Titles';

	/// en: 'Volume $n'
	String volume({required Object n}) => 'Volume ${n}';

	/// en: 'No Volume'
	String get noVolume => 'No Volume';

	/// en: 'Chapter $n'
	String chapter({required Object n}) => 'Chapter ${n}';

	/// en: 'Official Raw'
	String get officialRaw => 'Official Raw';

	/// en: 'Final Volume/Chapter'
	String get finalChapter => 'Final Volume/Chapter';

	/// en: 'Mark all visible as $arg'
	String markAllVisibleAs({required Object arg}) => 'Mark all visible as ${arg}';

	/// en: 'Mark all as $arg'
	String markAllAs({required Object arg}) => 'Mark all as ${arg}';

	/// en: 'read'
	String get read => 'read';

	/// en: 'unread'
	String get unread => 'unread';

	/// en: 'Are you sure you want to mark all visible chapters as ${arg}?'
	String markAllWarning({required Object arg}) => 'Are you sure you want to mark all visible chapters as ${arg}?';

	/// en: 'No Chapters'
	String get noChaptersMsg => 'No Chapters';

	/// en: 'Mark as $arg'
	String markAs({required Object arg}) => 'Mark as ${arg}';

	/// en: 'Copy gagaku link'
	String get copyLink => 'Copy gagaku link';
}

// Path: readingStatus
class TranslationsReadingStatusEn {
	TranslationsReadingStatusEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Remove'
	String get remove => 'Remove';

	/// en: 'Reading'
	String get reading => 'Reading';

	/// en: 'On Hold'
	String get on_hold => 'On Hold';

	/// en: 'Plan to Read'
	String get plan_to_read => 'Plan to Read';

	/// en: 'Dropped'
	String get dropped => 'Dropped';

	/// en: 'Re-reading'
	String get re_reading => 'Re-reading';

	/// en: 'Completed'
	String get completed => 'Completed';
}

// Path: mangaStatus
class TranslationsMangaStatusEn {
	TranslationsMangaStatusEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Completed'
	String get completed => 'Completed';

	/// en: 'Ongoing'
	String get ongoing => 'Ongoing';

	/// en: 'Cancelled'
	String get cancelled => 'Cancelled';

	/// en: 'Hiatus'
	String get hiatus => 'Hiatus';
}

// Path: mangaActions
class TranslationsMangaActionsEn {
	TranslationsMangaActionsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Add to Library'
	String get addToLibrary => 'Add to Library';

	/// en: 'Follow Manga'
	String get follow => 'Follow Manga';

	/// en: 'Unfollow Manga'
	String get unfollow => 'Unfollow Manga';

	/// en: 'Add to Favorites'
	String get favorite => 'Add to Favorites';

	/// en: 'Remove from Favorites'
	String get unfavorite => 'Remove from Favorites';

	/// en: 'Remove from History'
	String get removeHistory => 'Remove from History';
}

// Path: mangaRelations
class TranslationsMangaRelationsEn {
	TranslationsMangaRelationsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Monochrome'
	String get monochrome => 'Monochrome';

	/// en: 'Main Story'
	String get main_story => 'Main Story';

	/// en: 'Adapted from'
	String get adapted_from => 'Adapted from';

	/// en: 'Based on'
	String get based_on => 'Based on';

	/// en: 'Prequel'
	String get prequel => 'Prequel';

	/// en: 'Side story'
	String get side_story => 'Side story';

	/// en: 'Doujinshi'
	String get doujinshi => 'Doujinshi';

	/// en: 'Same franchise'
	String get same_franchise => 'Same franchise';

	/// en: 'Shared universe'
	String get shared_universe => 'Shared universe';

	/// en: 'Sequel'
	String get sequel => 'Sequel';

	/// en: 'Spinoff'
	String get spin_off => 'Spinoff';

	/// en: 'Alternate story'
	String get alternate_story => 'Alternate story';

	/// en: 'Alternate version'
	String get alternate_version => 'Alternate version';

	/// en: 'Pre-serialization'
	String get preserialization => 'Pre-serialization';

	/// en: 'Colored'
	String get colored => 'Colored';

	/// en: 'Serialization'
	String get serialization => 'Serialization';
}

// Path: tracking
class TranslationsTrackingEn {
	TranslationsTrackingEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Links'
	String get links => 'Links';

	/// en: 'Discord'
	String get discord => 'Discord';

	/// en: 'Website'
	String get website => 'Website';

	/// en: 'Nothing here!'
	String get nothing => 'Nothing here!';
}

// Path: contentRating
class TranslationsContentRatingEn {
	TranslationsContentRatingEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Safe'
	String get safe => 'Safe';

	/// en: 'Suggestive'
	String get suggestive => 'Suggestive';

	/// en: 'Erotica'
	String get erotica => 'Erotica';

	/// en: 'Pornographic'
	String get pornographic => 'Pornographic';
}

// Path: language
class TranslationsLanguageEn {
	TranslationsLanguageEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'English'
	String get en => 'English';

	/// en: 'Arabic'
	String get ar => 'Arabic';

	/// en: 'Azerbaijani'
	String get az => 'Azerbaijani';

	/// en: 'Bengali'
	String get bn => 'Bengali';

	/// en: 'Bulgarian'
	String get bg => 'Bulgarian';

	/// en: 'Burmese'
	String get my => 'Burmese';

	/// en: 'Catalan'
	String get ca => 'Catalan';

	/// en: 'Chinese (Simp.)'
	String get zh => 'Chinese (Simp.)';

	/// en: 'Chinese (Trad.)'
	String get zh_hk => 'Chinese (Trad.)';

	/// en: 'Croatian'
	String get hr => 'Croatian';

	/// en: 'Czech'
	String get cs => 'Czech';

	/// en: 'Danish'
	String get da => 'Danish';

	/// en: 'Dutch'
	String get nl => 'Dutch';

	/// en: 'Esperanto'
	String get eo => 'Esperanto';

	/// en: 'Estonian'
	String get et => 'Estonian';

	/// en: 'Filipino'
	String get tl => 'Filipino';

	/// en: 'Finnish'
	String get fi => 'Finnish';

	/// en: 'French'
	String get fr => 'French';

	/// en: 'Georgian'
	String get ka => 'Georgian';

	/// en: 'German'
	String get de => 'German';

	/// en: 'Greek'
	String get el => 'Greek';

	/// en: 'Hebrew'
	String get he => 'Hebrew';

	/// en: 'Hindi'
	String get hi => 'Hindi';

	/// en: 'Hungarian'
	String get hu => 'Hungarian';

	/// en: 'Indonesian'
	String get id => 'Indonesian';

	/// en: 'Italian'
	String get it => 'Italian';

	/// en: 'Japanese'
	String get ja => 'Japanese';

	/// en: 'Kazakh'
	String get kk => 'Kazakh';

	/// en: 'Korean'
	String get ko => 'Korean';

	/// en: 'Latin'
	String get la => 'Latin';

	/// en: 'Lithuanian'
	String get lt => 'Lithuanian';

	/// en: 'Malay'
	String get ms => 'Malay';

	/// en: 'Mongolian'
	String get mn => 'Mongolian';

	/// en: 'Nepali'
	String get ne => 'Nepali';

	/// en: 'Norwegian'
	String get no => 'Norwegian';

	/// en: 'Persian'
	String get fa => 'Persian';

	/// en: 'Polish'
	String get pl => 'Polish';

	/// en: 'Portuguese (BR)'
	String get pt_br => 'Portuguese (BR)';

	/// en: 'Portuguese'
	String get pt => 'Portuguese';

	/// en: 'Romanian'
	String get ro => 'Romanian';

	/// en: 'Russian'
	String get ru => 'Russian';

	/// en: 'Serbian'
	String get sr => 'Serbian';

	/// en: 'Slovak'
	String get sk => 'Slovak';

	/// en: 'Spanish'
	String get es => 'Spanish';

	/// en: 'Spanish (LATAM)'
	String get es_la => 'Spanish (LATAM)';

	/// en: 'Swedish'
	String get sv => 'Swedish';

	/// en: 'Tamil'
	String get ta => 'Tamil';

	/// en: 'Thai'
	String get th => 'Thai';

	/// en: 'Turkish'
	String get tr => 'Turkish';

	/// en: 'Ukrainian'
	String get uk => 'Ukrainian';

	/// en: 'Vietnam'
	String get vi => 'Vietnam';

	/// en: 'Japanese (Romanized)'
	String get ja_ro => 'Japanese (Romanized)';

	/// en: 'Korean (Romanized)'
	String get ko_ro => 'Korean (Romanized)';

	/// en: 'Chinese (Romanized)'
	String get zh_ro => 'Chinese (Romanized)';

	/// en: 'Other'
	String get other => 'Other';
}

// Path: colors
class TranslationsColorsEn {
	TranslationsColorsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Lime'
	String get lime => 'Lime';

	/// en: 'Grey'
	String get grey => 'Grey';

	/// en: 'Amber'
	String get amber => 'Amber';

	/// en: 'Blue'
	String get blue => 'Blue';

	/// en: 'Teal'
	String get teal => 'Teal';

	/// en: 'Green'
	String get green => 'Green';

	/// en: 'Light Green'
	String get lightgreen => 'Light Green';

	/// en: 'Red'
	String get red => 'Red';

	/// en: 'Orange'
	String get orange => 'Orange';

	/// en: 'Yellow'
	String get yellow => 'Yellow';

	/// en: 'Purple'
	String get purple => 'Purple';
}

// Path: cache
class TranslationsCacheEn {
	TranslationsCacheEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Clear Cache'
	String get clear => 'Clear Cache';

	/// en: 'Deletes all cached data. ONLY DO THIS IF YOU KNOW WHAT YOU ARE DOING!'
	String get clearSub => 'Deletes all cached data. ONLY DO THIS IF YOU KNOW WHAT YOU ARE DOING!';

	/// en: 'Are you sure you want to delete all cached data?'
	String get clearWarning => 'Are you sure you want to delete all cached data?';

	/// en: 'Cache cleared'
	String get clearSuccess => 'Cache cleared';
}

// Path: backup
class TranslationsBackupEn {
	TranslationsBackupEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Backup Data'
	String get data => 'Backup Data';

	/// en: 'Backup all gagaku data and settings (excludes MangaDex login, local library files) NOTE: when restoring, restart the app for changes to take effect'
	String get dataSub => 'Backup all gagaku data and settings (excludes MangaDex login, local library files)\nNOTE: when restoring, restart the app for changes to take effect';

	/// en: 'Restore Backup'
	String get restore => 'Restore Backup';

	/// en: 'Restoring data from a backup file will overwrite all existing data. Are you sure you want to continue?'
	String get restoreWarning => 'Restoring data from a backup file will overwrite all existing data. Are you sure you want to continue?';

	/// en: 'Backup Data to File'
	String get toFile => 'Backup Data to File';

	/// en: 'Restore Data from File'
	String get fromFile => 'Restore Data from File';

	/// en: 'Backup saved'
	String get success => 'Backup saved';

	/// en: 'Backup restored. Restart gagaku for changes to take effect'
	String get restoreSuccess => 'Backup restored. Restart gagaku for changes to take effect';

	/// en: 'Backup cancelled'
	String get cancelled => 'Backup cancelled';

	/// en: 'Backup restore cancelled'
	String get restoreCancelled => 'Backup restore cancelled';

	/// en: 'Backup restore failed'
	String get restoreFail => 'Backup restore failed';

	/// en: 'Database Directory'
	String get dataLocation => 'Database Directory';

	/// en: 'Changes the directory where gagaku reads and stores its database. Requires app restart to take effect.'
	String get dataLocSub => 'Changes the directory where gagaku reads and stores its database.\nRequires app restart to take effect.';

	/// en: 'Default'
	String get dataLocDefault => 'Default';
}

// Path: chapterFeed
class TranslationsChapterFeedEn {
	TranslationsChapterFeedEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Latest Updates'
	String get latestUpdates => 'Latest Updates';

	/// en: 'Updates'
	String get updates => 'Updates';

	/// en: 'Updating Feed'
	String get updatingFeed => 'Updating Feed';

	/// en: 'Updating: $item'
	String updatingItem({required Object item}) => 'Updating: ${item}';

	/// en: 'Update complete!'
	String get done => 'Update complete!';

	/// en: 'Stop Update'
	String get stop => 'Stop Update';

	/// en: 'Stopping Update...'
	String get stopping => 'Stopping Update...';

	/// en: 'Update required! No feed data or data out of date'
	String get updateRequired => 'Update required! No feed data or data out of date';
}

// Path: permissions
class TranslationsPermissionsEn {
	TranslationsPermissionsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Permissions Needed'
	String get needed => 'Permissions Needed';

	/// en: 'Extra permissions are required to update your feed in the background.'
	String get request => 'Extra permissions are required to update your feed in the background.';
}

// Path: localLibrary.settings
class TranslationsLocalLibrarySettingsEn {
	TranslationsLocalLibrarySettingsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Manga Library Path'
	String get libraryPath => 'Manga Library Path';

	/// en: 'Choose where to search for your manga library'
	String get libraryPathDesc => 'Choose where to search for your manga library';
}

// Path: localLibrary.errors
class TranslationsLocalLibraryErrorsEn {
	TranslationsLocalLibraryErrorsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Permissions denied'
	String get permissionDenied => 'Permissions denied';

	/// en: 'Library is empty!'
	String get emptyLibrary => 'Library is empty!';

	/// en: 'Library directory not set!'
	String get pathNotSet => 'Library directory not set!';
}

// Path: localLibrary.sort
class TranslationsLocalLibrarySortEn {
	TranslationsLocalLibrarySortEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Name descending'
	String get name_desc => 'Name descending';

	/// en: 'Name ascending'
	String get name_asc => 'Name ascending';

	/// en: 'Modified descending'
	String get modified_desc => 'Modified descending';

	/// en: 'Modified ascending'
	String get modified_asc => 'Modified ascending';
}

// Path: webSources.supportedUrl
class TranslationsWebSourcesSupportedUrlEn {
	TranslationsWebSourcesSupportedUrlEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Supported URLs'
	String get text => 'Supported URLs';

	/// en: 'Supported URLs:$arg'
	String arg({required Object arg}) => '${_root.webSources.supportedUrl.text}:${arg}';
}

// Path: webSources.settings
class TranslationsWebSourcesSettingsEn {
	TranslationsWebSourcesSettingsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Repos'
	String get repos => 'Repos';

	/// en: 'Configure source repos'
	String get reposDesc => 'Configure source repos';

	/// en: 'Favorite Categories'
	String get categories => 'Favorite Categories';

	/// en: 'Set up favourite list categories'
	String get categoriesDesc => 'Set up favourite list categories';

	/// en: 'Add New Category'
	String get newCategory => '${_root.ui.addNew} Category';

	/// en: 'Add Category'
	String get addCategory => '${_root.ui.add} Category';

	/// en: 'Rename Category'
	String get renameCategory => '${_root.ui.rename} Category';

	/// en: 'Category name'
	String get categoryName => 'Category name';

	/// en: 'Category name cannot be empty'
	String get emptyCategoryWarning => 'Category name cannot be empty';

	/// en: 'Category name already used'
	String get usedCategoryWarning => 'Category name already used';

	/// en: 'Categories to Update'
	String get categoriesToUpdate => 'Categories to Update';

	/// en: 'Select categories which manga will be updated in Updates view'
	String get categoriesToUpdateDesc => 'Select categories which manga will be updated in Updates view';

	/// en: 'Delete Category'
	String get categoryDelete => '${_root.ui.delete} Category';

	/// en: 'Deleting a category will remove all items in it'
	String get categoryDeleteWarn => 'Deleting a category will remove all items in it';

	/// en: 'Clear All Extension Settings'
	String get clearAll => 'Clear All Extension Settings';

	/// en: 'Clears all extension settings. Recommended when replacing or upgrading extensions.'
	String get clearAllDesc => 'Clears all extension settings. Recommended when replacing or upgrading extensions.';

	/// en: 'Are you sure you want to delete all extension settings?'
	String get clearAllWarning => 'Are you sure you want to delete all extension settings?';

	/// en: 'Clear Settings'
	String get clearSettings => 'Clear Settings';

	/// en: 'Settings Cleared'
	String get clearSuccess => 'Settings Cleared';
}

// Path: webSources.repo
class TranslationsWebSourcesRepoEn {
	TranslationsWebSourcesRepoEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Repo List'
	String get list => 'Repo List';

	/// en: 'Add New Repo'
	String get newRepo => '${_root.ui.addNew} Repo';

	/// en: 'View in browser'
	String get browser => 'View in browser';

	/// en: 'Add Repo'
	String get add => '${_root.ui.add} Repo';

	/// en: 'Are you sure you want to add the repo ${repo}?'
	String addConfirm({required Object repo}) => 'Are you sure you want to add the repo ${repo}?';

	/// en: 'Ensure that you are only adding trusted sources!'
	String get addWarning => 'Ensure that you are only adding trusted sources!';

	/// en: 'Repo URL'
	String get urlHint => 'Repo URL';

	/// en: 'Repo Name'
	String get nameHint => 'Repo Name';

	/// en: 'URL cannot be empty'
	String get urlEmptyWarning => 'URL cannot be empty';

	/// en: 'Name cannot be empty'
	String get nameEmptyWarning => 'Name cannot be empty';

	/// en: 'Must be a valid URL'
	String get urlInvalidWarning => 'Must be a valid URL';

	/// en: 'Repo added'
	String get repoAddOK => 'Repo added';

	/// en: 'Repo already exists'
	String get repoExists => 'Repo already exists';

	/// en: 'Missing Repo'
	String get missingRepo => 'Missing Repo';
}

// Path: webSources.source
class TranslationsWebSourcesSourceEn {
	TranslationsWebSourcesSourceEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Extension Settings'
	String get settings => 'Extension Settings';

	/// en: 'Extension Manager'
	String get manager => 'Extension Manager';

	/// en: 'No repos nor extensions installed!'
	String get noDataWarning => 'No repos nor extensions installed!';

	/// en: 'Refresh repos'
	String get refresh => 'Refresh repos';

	/// en: 'Delete $arg'
	String delete({required Object arg}) => '${_root.ui.delete} ${arg}';

	/// en: 'Add $arg'
	String add({required Object arg}) => '${_root.ui.add} ${arg}';

	/// en: 'Update/Replace $arg'
	String update({required Object arg}) => 'Update/Replace ${arg}';

	/// en: 'Extension disabled'
	String get sourceDeleteOK => 'Extension disabled';

	/// en: 'Extension updated'
	String get sourceUpdateOK => 'Extension updated';

	/// en: 'Extension enabled'
	String get sourceAddOK => 'Extension enabled';

	/// en: ' (installed: v${version})'
	String installedVersion({required Object version}) => ' (installed: v${version})';

	/// en: 'This extension provides no filter options'
	String get noTagsWarning => 'This extension provides no filter options';
}

// Path: reader.direction
class TranslationsReaderDirectionEn {
	TranslationsReaderDirectionEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Left to Right'
	String get leftToRight => 'Left to Right';

	/// en: 'Right to Left'
	String get rightToLeft => 'Right to Left';
}

// Path: reader.format
class TranslationsReaderFormatEn {
	TranslationsReaderFormatEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Single'
	String get single => 'Single';

	/// en: 'Long Strip'
	String get longstrip => 'Long Strip';
}

// Path: mangadex.creator
class TranslationsMangadexCreatorEn {
	TranslationsMangadexCreatorEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Biography'
	String get biography => 'Biography';

	/// en: 'Follow'
	String get follow => 'Follow';

	/// en: 'Works'
	String get works => 'Works';
}

// Path: mangadex.listVisibility
class TranslationsMangadexListVisibilityEn {
	TranslationsMangadexListVisibilityEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Private'
	String get private => 'Private';

	/// en: 'Public'
	String get public => 'Public';
}

// Path: mangadex.settings
class TranslationsMangadexSettingsEn {
	TranslationsMangadexSettingsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Chapter Language Filter'
	String get translatedLanguages => 'Chapter Language Filter';

	/// en: 'Show only chapters from these languages'
	String get translatedLanguagesDesc => 'Show only chapters from these languages';

	/// en: 'Original Language Filter'
	String get originalLanguage => 'Original Language Filter';

	/// en: 'Only show titles originally published in these languages. If no languages are selected, no filter will be applied'
	String get originalLanguageDesc => 'Only show titles originally published in these languages. If no languages are selected, no filter will be applied';

	/// en: 'Content Filter'
	String get contentRating => 'Content Filter';

	/// en: 'Data Saver'
	String get dataSaver => 'Data Saver';

	/// en: 'Blocked Groups'
	String get groupBlacklist => 'Blocked Groups';

	/// en: 'Select Languages'
	String get selectLanguages => 'Select Languages';

	/// en: 'Select Content Filters'
	String get selectContentFilters => 'Select Content Filters';
}

// Path: mangadex.sort
class TranslationsMangadexSortEn {
	TranslationsMangadexSortEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Worst Match'
	String get relevance_asc => 'Worst Match';

	/// en: 'Best Match'
	String get relevance_desc => 'Best Match';

	/// en: 'Fewest Follows'
	String get followedCount_asc => 'Fewest Follows';

	/// en: 'Most Follows'
	String get followedCount_desc => 'Most Follows';

	/// en: 'Oldest Upload'
	String get latestUploadedChapter_asc => 'Oldest Upload';

	/// en: 'Latest Upload'
	String get latestUploadedChapter_desc => 'Latest Upload';

	/// en: 'Oldest Update'
	String get updatedAt_asc => 'Oldest Update';

	/// en: 'Latest Update'
	String get updatedAt_desc => 'Latest Update';

	/// en: 'Oldest Added'
	String get createdAt_asc => 'Oldest Added';

	/// en: 'Recently Added'
	String get createdAt_desc => 'Recently Added';

	/// en: 'Year Ascending'
	String get year_asc => 'Year Ascending';

	/// en: 'Year Descending'
	String get year_desc => 'Year Descending';

	/// en: 'Title Ascending'
	String get title_asc => 'Title Ascending';

	/// en: 'Title Descending'
	String get title_desc => 'Title Descending';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
/// Note: We use a HashMap because Dart seems to be unable to compile large switch statements.
Map<String, dynamic>? _map;

extension on Translations {
	dynamic _flatMapFunction(String path) {
		final map = _map ?? _initFlatMap();
		return map[path];
	}

	/// Initializes the flat map and returns it.
	Map<String, dynamic> _initFlatMap() {
		final map = <String, dynamic>{};
		map['ui.add'] = 'Add';
		map['ui.addNew'] = 'Add New';
		map['ui.go'] = 'Go';
		map['ui.ok'] = 'Ok';
		map['ui.cancel'] = 'Cancel';
		map['ui.yes'] = 'Yes';
		map['ui.no'] = 'No';
		map['ui.on'] = 'On';
		map['ui.off'] = 'Off';
		map['ui.none'] = 'None';
		map['ui.block'] = 'Block';
		map['ui.unblock'] = 'Unblock';
		map['ui.follow'] = 'Follow';
		map['ui.unfollow'] = 'Unfollow';
		map['ui.create'] = 'Create';
		map['ui.browse'] = 'Browse';
		map['ui.manage'] = 'Manage';
		map['ui.edit'] = 'Edit';
		map['ui.save'] = 'Save';
		map['ui.delete'] = 'Delete';
		map['ui.rename'] = 'Rename';
		map['ui.clear'] = 'Clear';
		map['ui.gridView'] = 'Grid view';
		map['ui.listView'] = 'List view';
		map['ui.detailedView'] = 'Detailed view';
		map['ui.gridSize'] = 'Grid Size';
		map['ui.loadingDot'] = 'Loading...';
		map['ui.copyClipboard'] = 'Copied to clipboard!';
		map['ui.pasteClipboard'] = 'Paste from Clipboard';
		map['ui.dragHint'] = 'Hint: Drag to reorder';
		map['ui.makeDefault'] = 'Make Default';
		map['ui.retry'] = 'Retry';
		map['ui.irreversibleWarning'] = 'NOTE: THIS ACTION IS IRREVERSIBLE';
		map['ui.filterItems'] = 'Filter Items';
		map['ui.sureContinue'] = 'Are you sure you want to continue?';
		map['errors.noresults'] = 'No results';
		map['errors.notitles'] = 'No titles';
		map['errors.nomanga'] = 'No manga';
		map['errors.nolists'] = 'No lists';
		map['errors.norepos'] = 'No repos';
		map['errors.noitems'] = 'No items';
		map['errors.unsupportedUrl'] = 'Unsupported URL';
		map['errors.loginFail'] = ({required Object reason}) => 'Failed to login: ${reason}';
		map['errors.notLoggedIn'] = 'Operation failed. User not logged in';
		map['errors.unsupportedSource'] = 'Unsupported extension type';
		map['errors.unknownSourceID'] = ({required Object id}) => 'Unknown source ID ${id}';
		map['errors.fetchFail'] = 'Something went wrong while fetching a new page';
		map['errors.pageNotFound'] = 'Page Not Found';
		map['errors.pageNotFoundArg'] = ({required Object url}) => 'Can\'t find a page for: ${url}';
		map['errors.failedLaunchUrl'] = ({required Object url}) => 'Failed to launch ${url}';
		map['auth.login'] = 'Login';
		map['auth.logout'] = 'Logout';
		map['auth.username'] = 'Username';
		map['auth.password'] = 'Password';
		map['auth.usernameEmptyWarning'] = 'Username cannot be empty';
		map['auth.passwordEmptyWarning'] = 'Password cannot be empty';
		map['auth.clientId'] = 'Client ID';
		map['auth.clientSecret'] = 'Client Secret';
		map['auth.clientIdEmptyWarning'] = 'Client ID cannot be empty';
		map['auth.clientSecretEmptyWarning'] = 'Client Secret cannot be empty';
		map['auth.fieldsEmptyWarning'] = 'Username/Password/Client ID/Client Secret cannot be empty';
		map['auth.loggedInAs'] = ({required Object user}) => 'Logged in as: ${user}';
		map['auth.authenticating'] = 'Authenticating...';
		map['sort.desc'] = 'Descending';
		map['sort.asc'] = 'Ascending';
		map['library'] = 'Library';
		map['history.text'] = 'History';
		map['history.clear'] = 'Clear History';
		map['history.clearWarning'] = 'Are you sure you want to remove all history?';
		map['localLibrary.text'] = 'Local Library';
		map['localLibrary.extractingArchive'] = 'Extracting archive...';
		map['localLibrary.loadingDir'] = 'Loading directory...';
		map['localLibrary.archiveUnreadableWarning'] = 'This archive contains no readable images!';
		map['localLibrary.dirUnreadableWarning'] = 'This directory contains no readable images!';
		map['localLibrary.settings.libraryPath'] = 'Manga Library Path';
		map['localLibrary.settings.libraryPathDesc'] = 'Choose where to search for your manga library';
		map['localLibrary.readArchive'] = 'Read Archive';
		map['localLibrary.noPathWarning'] = 'No library directory set!';
		map['localLibrary.setPath'] = 'Set Library Directory';
		map['localLibrary.scanning'] = 'Scanning library...';
		map['localLibrary.errors.permissionDenied'] = 'Permissions denied';
		map['localLibrary.errors.emptyLibrary'] = 'Library is empty!';
		map['localLibrary.errors.pathNotSet'] = 'Library directory not set!';
		map['localLibrary.sort.name_desc'] = 'Name descending';
		map['localLibrary.sort.name_asc'] = 'Name ascending';
		map['localLibrary.sort.modified_desc'] = 'Modified descending';
		map['localLibrary.sort.modified_asc'] = 'Modified ascending';
		map['webSources.text'] = 'Web Sources';
		map['webSources.home'] = 'Home';
		map['webSources.homepages'] = 'Homepages';
		map['webSources.openUrl'] = 'Open URL';
		map['webSources.openLink'] = 'Open Link';
		map['webSources.supportedUrl.text'] = 'Supported URLs';
		map['webSources.supportedUrl.arg'] = ({required Object arg}) => '${_root.webSources.supportedUrl.text}:${arg}';
		map['webSources.settings.repos'] = 'Repos';
		map['webSources.settings.reposDesc'] = 'Configure source repos';
		map['webSources.settings.categories'] = 'Favorite Categories';
		map['webSources.settings.categoriesDesc'] = 'Set up favourite list categories';
		map['webSources.settings.newCategory'] = '${_root.ui.addNew} Category';
		map['webSources.settings.addCategory'] = '${_root.ui.add} Category';
		map['webSources.settings.renameCategory'] = '${_root.ui.rename} Category';
		map['webSources.settings.categoryName'] = 'Category name';
		map['webSources.settings.emptyCategoryWarning'] = 'Category name cannot be empty';
		map['webSources.settings.usedCategoryWarning'] = 'Category name already used';
		map['webSources.settings.categoriesToUpdate'] = 'Categories to Update';
		map['webSources.settings.categoriesToUpdateDesc'] = 'Select categories which manga will be updated in Updates view';
		map['webSources.settings.categoryDelete'] = '${_root.ui.delete} Category';
		map['webSources.settings.categoryDeleteWarn'] = 'Deleting a category will remove all items in it';
		map['webSources.settings.clearAll'] = 'Clear All Extension Settings';
		map['webSources.settings.clearAllDesc'] = 'Clears all extension settings. Recommended when replacing or upgrading extensions.';
		map['webSources.settings.clearAllWarning'] = 'Are you sure you want to delete all extension settings?';
		map['webSources.settings.clearSettings'] = 'Clear Settings';
		map['webSources.settings.clearSuccess'] = 'Settings Cleared';
		map['webSources.repo.list'] = 'Repo List';
		map['webSources.repo.newRepo'] = '${_root.ui.addNew} Repo';
		map['webSources.repo.browser'] = 'View in browser';
		map['webSources.repo.add'] = '${_root.ui.add} Repo';
		map['webSources.repo.addConfirm'] = ({required Object repo}) => 'Are you sure you want to add the repo ${repo}?';
		map['webSources.repo.addWarning'] = 'Ensure that you are only adding trusted sources!';
		map['webSources.repo.urlHint'] = 'Repo URL';
		map['webSources.repo.nameHint'] = 'Repo Name';
		map['webSources.repo.urlEmptyWarning'] = 'URL cannot be empty';
		map['webSources.repo.nameEmptyWarning'] = 'Name cannot be empty';
		map['webSources.repo.urlInvalidWarning'] = 'Must be a valid URL';
		map['webSources.repo.repoAddOK'] = 'Repo added';
		map['webSources.repo.repoExists'] = 'Repo already exists';
		map['webSources.repo.missingRepo'] = 'Missing Repo';
		map['webSources.source.settings'] = 'Extension Settings';
		map['webSources.source.manager'] = 'Extension Manager';
		map['webSources.source.noDataWarning'] = 'No repos nor extensions installed!';
		map['webSources.source.refresh'] = 'Refresh repos';
		map['webSources.source.delete'] = ({required Object arg}) => '${_root.ui.delete} ${arg}';
		map['webSources.source.add'] = ({required Object arg}) => '${_root.ui.add} ${arg}';
		map['webSources.source.update'] = ({required Object arg}) => 'Update/Replace ${arg}';
		map['webSources.source.sourceDeleteOK'] = 'Extension disabled';
		map['webSources.source.sourceUpdateOK'] = 'Extension updated';
		map['webSources.source.sourceAddOK'] = 'Extension enabled';
		map['webSources.source.installedVersion'] = ({required Object version}) => ' (installed: v${version})';
		map['webSources.source.noTagsWarning'] = 'This extension provides no filter options';
		map['webSources.sourceUnavailable'] = ({required Object id}) => 'Source ${id} Unavailable';
		map['webSources.noSourcesWarning'] = 'No extensions installed!';
		map['webSources.noSearchableSourcesWarning'] = 'No searchable extensions installed!';
		map['webSources.sourceSearch'] = 'Extension Search';
		map['webSources.resetRead'] = 'Reset Read Markers';
		map['webSources.resetReadWarning'] = 'Are you sure you want to reset all read markers for this manga?';
		map['webSources.resetAllRead'] = 'Reset all Read Markers';
		map['webSources.resetAllReadWarning'] = 'Are you sure you want to reset all read markers?';
		map['webSources.favorites'] = 'Favorites';
		map['webSources.loadInstalledSourcesError'] = 'Error loading installed sources';
		map['webSources.searchWithExt'] = 'Search with extensions';
		map['webSources.historyHere'] = 'Your manga browsing history appears here';
		map['webSources.saveHistory'] = 'Save History?';
		map['search.text'] = 'Search';
		map['search.arg'] = ({required Object arg}) => 'Search ${arg}';
		map['search.filters'] = 'Search Filters';
		map['search.resetFilters'] = 'Reset Filters';
		map['search.applyFilters'] = 'Apply Filters';
		map['search.selectedTagFilters'] = 'Selected Tag Filters';
		map['search.filterTags'] = 'Filter tags';
		map['search.otherOptions'] = 'Other Options';
		map['search.inclusion'] = 'Inclusion Mode';
		map['search.exclusion'] = 'Exclusion Mode';
		map['search.any'] = 'Any';
		map['settings'] = 'Settings';
		map['arg_settings'] = ({required Object arg}) => '${arg} ${_root.settings}';
		map['saveSettings'] = 'Save Settings';
		map['num_manga'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: '${n} Manga',
				other: '${n} Manga',
			);
		map['titles'] = 'Titles';
		map['num_titles'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: '${n} Title',
				other: '${n} Titles',
			);
		map['feed'] = 'Feed';
		map['num_items'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: '${n} item',
				other: '${n} items',
			);
		map['theme.mode'] = 'Theme Mode';
		map['theme.color'] = 'Theme Color';
		map['theme.light'] = 'Light';
		map['theme.dark'] = 'Dark';
		map['theme.system'] = 'System Defined';
		map['reader.direction.leftToRight'] = 'Left to Right';
		map['reader.direction.rightToLeft'] = 'Right to Left';
		map['reader.format.single'] = 'Single';
		map['reader.format.longstrip'] = 'Long Strip';
		map['reader.settings'] = 'Reader Settings';
		map['reader.togglePageSize'] = 'Toggle Page Size';
		map['reader.progressBar'] = 'Progress Bar';
		map['reader.swipeGestures'] = 'Swipe Gestures';
		map['reader.clickToTurn'] = 'Click/Tap to Turn Page';
		map['reader.precacheCount'] = 'Page Preload';
		map['mangadex.home'] = 'Home';
		map['mangadex.myFeed'] = 'My Feed';
		map['mangadex.myLists'] = 'My Lists';
		map['mangadex.followedLists'] = 'Followed Lists';
		map['mangadex.popularNewTitles'] = 'Popular New Titles';
		map['mangadex.staffPicks'] = 'Staff Picks';
		map['mangadex.seasonal'] = 'Seasonal';
		map['mangadex.recentlyAdded'] = 'Recently Added';
		map['mangadex.byChapter'] = 'By Chapter';
		map['mangadex.byManga'] = 'By Manga';
		map['mangadex.localHistory'] = 'Reading History (local)';
		map['mangadex.noFollowsMsg'] = 'Find some manga to follow!';
		map['mangadex.noHistoryMsg'] = 'No reading history';
		map['mangadex.createNewList'] = 'Create New List';
		map['mangadex.createNewListBtn'] = '+ ${_root.mangadex.createNewList}';
		map['mangadex.listName'] = 'List Name';
		map['mangadex.listFeed'] = 'List Feed';
		map['mangadex.listNameEmptyWarning'] = 'List name cannot be empty';
		map['mangadex.listNotExistError'] = ({required Object id}) => 'List with ID ${id} does not exist!';
		map['mangadex.editList'] = '${_root.ui.edit} List';
		map['mangadex.editListError'] = ({required Object error}) => 'Failed to edit list: ${error}';
		map['mangadex.createList'] = '${_root.ui.create} List';
		map['mangadex.deleteList'] = '${_root.ui.delete} List';
		map['mangadex.deleteListOk'] = 'List deleted';
		map['mangadex.deleteListError'] = ({required Object error}) => 'Failed to delete list: ${error}';
		map['mangadex.deleteListWarning'] = ({required Object list}) => 'Are you sure you want to permanently delete \'${list}\'?';
		map['mangadex.privateList'] = 'Private list';
		map['mangadex.newList'] = 'New List';
		map['mangadex.newListOk'] = 'New list created';
		map['mangadex.newListError'] = ({required Object error}) => 'Failed to create list: ${error}';
		map['mangadex.officialPub'] = 'Official Publisher';
		map['mangadex.noGroup'] = 'No Group';
		map['mangadex.groupDesc'] = 'Group Description';
		map['mangadex.groupFeed'] = 'Group Feed';
		map['mangadex.groupTitles'] = 'Group Titles';
		map['mangadex.login'] = 'Login to MangaDex';
		map['mangadex.contentRating'] = 'Content Rating';
		map['mangadex.demographic'] = 'Demographic';
		map['mangadex.pubStatus'] = 'Publication Status';
		map['mangadex.trendingThisYear'] = 'Trending this year';
		map['mangadex.byPopularity'] = 'By Popularity';
		map['mangadex.tagTitles'] = ({required Object tag}) => 'Browse all ${tag} titles';
		map['mangadex.creator.biography'] = 'Biography';
		map['mangadex.creator.follow'] = 'Follow';
		map['mangadex.creator.works'] = 'Works';
		map['mangadex.visibility'] = 'Visibility';
		map['mangadex.listVisibility.private'] = 'Private';
		map['mangadex.listVisibility.public'] = 'Public';
		map['mangadex.addTitles'] = '${_root.ui.add} ${_root.titles}';
		map['mangadex.settings.translatedLanguages'] = 'Chapter Language Filter';
		map['mangadex.settings.translatedLanguagesDesc'] = 'Show only chapters from these languages';
		map['mangadex.settings.originalLanguage'] = 'Original Language Filter';
		map['mangadex.settings.originalLanguageDesc'] = 'Only show titles originally published in these languages. If no languages are selected, no filter will be applied';
		map['mangadex.settings.contentRating'] = 'Content Filter';
		map['mangadex.settings.dataSaver'] = 'Data Saver';
		map['mangadex.settings.groupBlacklist'] = 'Blocked Groups';
		map['mangadex.settings.selectLanguages'] = 'Select Languages';
		map['mangadex.settings.selectContentFilters'] = 'Select Content Filters';
		map['mangadex.sort.relevance_asc'] = 'Worst Match';
		map['mangadex.sort.relevance_desc'] = 'Best Match';
		map['mangadex.sort.followedCount_asc'] = 'Fewest Follows';
		map['mangadex.sort.followedCount_desc'] = 'Most Follows';
		map['mangadex.sort.latestUploadedChapter_asc'] = 'Oldest Upload';
		map['mangadex.sort.latestUploadedChapter_desc'] = 'Latest Upload';
		map['mangadex.sort.updatedAt_asc'] = 'Oldest Update';
		map['mangadex.sort.updatedAt_desc'] = 'Latest Update';
		map['mangadex.sort.createdAt_asc'] = 'Oldest Added';
		map['mangadex.sort.createdAt_desc'] = 'Recently Added';
		map['mangadex.sort.year_asc'] = 'Year Ascending';
		map['mangadex.sort.year_desc'] = 'Year Descending';
		map['mangadex.sort.title_asc'] = 'Title Ascending';
		map['mangadex.sort.title_desc'] = 'Title Descending';
		map['mangadex.ratings.0'] = 'Remove Rating';
		map['mangadex.ratings.1'] = '(1) Appalling';
		map['mangadex.ratings.2'] = '(2) Horrible';
		map['mangadex.ratings.3'] = '(3) Very Bad';
		map['mangadex.ratings.4'] = '(4) Bad';
		map['mangadex.ratings.5'] = '(5) Average';
		map['mangadex.ratings.6'] = '(6) Fine';
		map['mangadex.ratings.7'] = '(7) Good';
		map['mangadex.ratings.8'] = '(8) Very Good';
		map['mangadex.ratings.9'] = '(9) Great';
		map['mangadex.ratings.10'] = '(10) Masterpiece';
		map['mangaView.altTitles'] = 'Alt. Titles';
		map['mangaView.synopsis'] = 'Synopsis';
		map['mangaView.info'] = 'Info';
		map['mangaView.author'] = 'Author';
		map['mangaView.artist'] = 'Artist';
		map['mangaView.demographic'] = 'Demographics';
		map['mangaView.genre'] = 'Genres';
		map['mangaView.theme'] = 'Themes';
		map['mangaView.format'] = 'Format';
		map['mangaView.track'] = 'Track';
		map['mangaView.openOn'] = ({required Object arg}) => 'Open on ${arg}';
		map['mangaView.chapters'] = 'Chapters';
		map['mangaView.art'] = 'Art';
		map['mangaView.related'] = 'Related';
		map['mangaView.relatedTitles'] = 'Related Titles';
		map['mangaView.volume'] = ({required Object n}) => 'Volume ${n}';
		map['mangaView.noVolume'] = 'No Volume';
		map['mangaView.chapter'] = ({required Object n}) => 'Chapter ${n}';
		map['mangaView.officialRaw'] = 'Official Raw';
		map['mangaView.finalChapter'] = 'Final Volume/Chapter';
		map['mangaView.markAllVisibleAs'] = ({required Object arg}) => 'Mark all visible as ${arg}';
		map['mangaView.markAllAs'] = ({required Object arg}) => 'Mark all as ${arg}';
		map['mangaView.read'] = 'read';
		map['mangaView.unread'] = 'unread';
		map['mangaView.markAllWarning'] = ({required Object arg}) => 'Are you sure you want to mark all visible chapters as ${arg}?';
		map['mangaView.noChaptersMsg'] = 'No Chapters';
		map['mangaView.markAs'] = ({required Object arg}) => 'Mark as ${arg}';
		map['mangaView.copyLink'] = 'Copy gagaku link';
		map['readingStatus.remove'] = 'Remove';
		map['readingStatus.reading'] = 'Reading';
		map['readingStatus.on_hold'] = 'On Hold';
		map['readingStatus.plan_to_read'] = 'Plan to Read';
		map['readingStatus.dropped'] = 'Dropped';
		map['readingStatus.re_reading'] = 'Re-reading';
		map['readingStatus.completed'] = 'Completed';
		map['mangaStatus.completed'] = 'Completed';
		map['mangaStatus.ongoing'] = 'Ongoing';
		map['mangaStatus.cancelled'] = 'Cancelled';
		map['mangaStatus.hiatus'] = 'Hiatus';
		map['mangaActions.addToLibrary'] = 'Add to Library';
		map['mangaActions.follow'] = 'Follow Manga';
		map['mangaActions.unfollow'] = 'Unfollow Manga';
		map['mangaActions.favorite'] = 'Add to Favorites';
		map['mangaActions.unfavorite'] = 'Remove from Favorites';
		map['mangaActions.removeHistory'] = 'Remove from History';
		map['mangaRelations.monochrome'] = 'Monochrome';
		map['mangaRelations.main_story'] = 'Main Story';
		map['mangaRelations.adapted_from'] = 'Adapted from';
		map['mangaRelations.based_on'] = 'Based on';
		map['mangaRelations.prequel'] = 'Prequel';
		map['mangaRelations.side_story'] = 'Side story';
		map['mangaRelations.doujinshi'] = 'Doujinshi';
		map['mangaRelations.same_franchise'] = 'Same franchise';
		map['mangaRelations.shared_universe'] = 'Shared universe';
		map['mangaRelations.sequel'] = 'Sequel';
		map['mangaRelations.spin_off'] = 'Spinoff';
		map['mangaRelations.alternate_story'] = 'Alternate story';
		map['mangaRelations.alternate_version'] = 'Alternate version';
		map['mangaRelations.preserialization'] = 'Pre-serialization';
		map['mangaRelations.colored'] = 'Colored';
		map['mangaRelations.serialization'] = 'Serialization';
		map['tracking.links'] = 'Links';
		map['tracking.discord'] = 'Discord';
		map['tracking.website'] = 'Website';
		map['tracking.nothing'] = 'Nothing here!';
		map['contentRating.safe'] = 'Safe';
		map['contentRating.suggestive'] = 'Suggestive';
		map['contentRating.erotica'] = 'Erotica';
		map['contentRating.pornographic'] = 'Pornographic';
		map['language.en'] = 'English';
		map['language.ar'] = 'Arabic';
		map['language.az'] = 'Azerbaijani';
		map['language.bn'] = 'Bengali';
		map['language.bg'] = 'Bulgarian';
		map['language.my'] = 'Burmese';
		map['language.ca'] = 'Catalan';
		map['language.zh'] = 'Chinese (Simp.)';
		map['language.zh_hk'] = 'Chinese (Trad.)';
		map['language.hr'] = 'Croatian';
		map['language.cs'] = 'Czech';
		map['language.da'] = 'Danish';
		map['language.nl'] = 'Dutch';
		map['language.eo'] = 'Esperanto';
		map['language.et'] = 'Estonian';
		map['language.tl'] = 'Filipino';
		map['language.fi'] = 'Finnish';
		map['language.fr'] = 'French';
		map['language.ka'] = 'Georgian';
		map['language.de'] = 'German';
		map['language.el'] = 'Greek';
		map['language.he'] = 'Hebrew';
		map['language.hi'] = 'Hindi';
		map['language.hu'] = 'Hungarian';
		map['language.id'] = 'Indonesian';
		map['language.it'] = 'Italian';
		map['language.ja'] = 'Japanese';
		map['language.kk'] = 'Kazakh';
		map['language.ko'] = 'Korean';
		map['language.la'] = 'Latin';
		map['language.lt'] = 'Lithuanian';
		map['language.ms'] = 'Malay';
		map['language.mn'] = 'Mongolian';
		map['language.ne'] = 'Nepali';
		map['language.no'] = 'Norwegian';
		map['language.fa'] = 'Persian';
		map['language.pl'] = 'Polish';
		map['language.pt_br'] = 'Portuguese (BR)';
		map['language.pt'] = 'Portuguese';
		map['language.ro'] = 'Romanian';
		map['language.ru'] = 'Russian';
		map['language.sr'] = 'Serbian';
		map['language.sk'] = 'Slovak';
		map['language.es'] = 'Spanish';
		map['language.es_la'] = 'Spanish (LATAM)';
		map['language.sv'] = 'Swedish';
		map['language.ta'] = 'Tamil';
		map['language.th'] = 'Thai';
		map['language.tr'] = 'Turkish';
		map['language.uk'] = 'Ukrainian';
		map['language.vi'] = 'Vietnam';
		map['language.ja_ro'] = 'Japanese (Romanized)';
		map['language.ko_ro'] = 'Korean (Romanized)';
		map['language.zh_ro'] = 'Chinese (Romanized)';
		map['language.other'] = 'Other';
		map['colors.lime'] = 'Lime';
		map['colors.grey'] = 'Grey';
		map['colors.amber'] = 'Amber';
		map['colors.blue'] = 'Blue';
		map['colors.teal'] = 'Teal';
		map['colors.green'] = 'Green';
		map['colors.lightgreen'] = 'Light Green';
		map['colors.red'] = 'Red';
		map['colors.orange'] = 'Orange';
		map['colors.yellow'] = 'Yellow';
		map['colors.purple'] = 'Purple';
		map['cache.clear'] = 'Clear Cache';
		map['cache.clearSub'] = 'Deletes all cached data. ONLY DO THIS IF YOU KNOW WHAT YOU ARE DOING!';
		map['cache.clearWarning'] = 'Are you sure you want to delete all cached data?';
		map['cache.clearSuccess'] = 'Cache cleared';
		map['backup.data'] = 'Backup Data';
		map['backup.dataSub'] = 'Backup all gagaku data and settings (excludes MangaDex login, local library files)\nNOTE: when restoring, restart the app for changes to take effect';
		map['backup.restore'] = 'Restore Backup';
		map['backup.restoreWarning'] = 'Restoring data from a backup file will overwrite all existing data. Are you sure you want to continue?';
		map['backup.toFile'] = 'Backup Data to File';
		map['backup.fromFile'] = 'Restore Data from File';
		map['backup.success'] = 'Backup saved';
		map['backup.restoreSuccess'] = 'Backup restored. Restart gagaku for changes to take effect';
		map['backup.cancelled'] = 'Backup cancelled';
		map['backup.restoreCancelled'] = 'Backup restore cancelled';
		map['backup.restoreFail'] = 'Backup restore failed';
		map['backup.dataLocation'] = 'Database Directory';
		map['backup.dataLocSub'] = 'Changes the directory where gagaku reads and stores its database.\nRequires app restart to take effect.';
		map['backup.dataLocDefault'] = 'Default';
		map['chapterFeed.latestUpdates'] = 'Latest Updates';
		map['chapterFeed.updates'] = 'Updates';
		map['chapterFeed.updatingFeed'] = 'Updating Feed';
		map['chapterFeed.updatingItem'] = ({required Object item}) => 'Updating: ${item}';
		map['chapterFeed.done'] = 'Update complete!';
		map['chapterFeed.stop'] = 'Stop Update';
		map['chapterFeed.stopping'] = 'Stopping Update...';
		map['chapterFeed.updateRequired'] = 'Update required! No feed data or data out of date';
		map['permissions.needed'] = 'Permissions Needed';
		map['permissions.request'] = 'Extra permissions are required to update your feed in the background.';

		_map = map;
		return map;
	}
}

