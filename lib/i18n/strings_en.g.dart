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
			case 'ui.filterItems': return 'Filter Items';
			case 'ui.sureContinue': return 'Are you sure you want to continue?';
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
			case 'errors.failedLaunchUrl': return ({required Object url}) => 'Failed to launch ${url}';
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
			case 'webSources.settings.categoryDelete': return '${_root.ui.delete} Category';
			case 'webSources.settings.categoryDeleteWarn': return 'Deleting a category will remove all items in it';
			case 'webSources.settings.clearAll': return 'Clear All Extension Settings';
			case 'webSources.settings.clearAllDesc': return 'Clears all extension settings. Recommended when replacing or upgrading extensions.';
			case 'webSources.settings.clearAllWarning': return 'Are you sure you want to delete all extension settings?';
			case 'webSources.settings.clearSettings': return 'Clear Settings';
			case 'webSources.settings.clearSuccess': return 'Settings Cleared';
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
			case 'webSources.noSearchableSourcesWarning': return 'No searchable extensions installed!';
			case 'webSources.sourceSearch': return 'Extension Search';
			case 'webSources.resetRead': return 'Reset Read Markers';
			case 'webSources.resetReadWarning': return 'Are you sure you want to reset all read markers for this manga?';
			case 'webSources.resetAllRead': return 'Reset all Read Markers';
			case 'webSources.resetAllReadWarning': return 'Are you sure you want to reset all read markers?';
			case 'webSources.favorites': return 'Favorites';
			case 'webSources.loadInstalledSourcesError': return 'Error loading installed sources';
			case 'webSources.searchWithExt': return 'Search with extensions';
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
			case 'mangaView.copyLink': return 'Copy gagaku link';
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
			case 'chapterFeed.updatingFeed': return 'Updating Feed';
			case 'chapterFeed.updatingItem': return ({required Object item}) => 'Updating: ${item}';
			case 'chapterFeed.done': return 'Update complete!';
			case 'chapterFeed.stop': return 'Stop Update';
			case 'chapterFeed.stopping': return 'Stopping Update...';
			case 'chapterFeed.updateRequired': return 'Update required! No feed data or data out of date';
			case 'permissions.needed': return 'Permissions Needed';
			case 'permissions.request': return 'Extra permissions are required to update your feed in the background.';
			default: return null;
		}
	}
}

