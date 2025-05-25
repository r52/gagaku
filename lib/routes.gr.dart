// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i29;
import 'package:flutter/foundation.dart' as _i33;
import 'package:flutter/material.dart' as _i30;
import 'package:gagaku/local/main.dart' as _i5;
import 'package:gagaku/main.dart' as _i23;
import 'package:gagaku/mangadex/chapter_feed.dart' as _i6;
import 'package:gagaku/mangadex/creator_view.dart' as _i8;
import 'package:gagaku/mangadex/edit_list.dart' as _i7;
import 'package:gagaku/mangadex/frontpage.dart' as _i9;
import 'package:gagaku/mangadex/group_view.dart' as _i11;
import 'package:gagaku/mangadex/history_feed.dart' as _i12;
import 'package:gagaku/mangadex/latest_feed.dart' as _i10;
import 'package:gagaku/mangadex/library.dart' as _i14;
import 'package:gagaku/mangadex/list_view.dart' as _i15;
import 'package:gagaku/mangadex/lists.dart' as _i16;
import 'package:gagaku/mangadex/login_password.dart' as _i17;
import 'package:gagaku/mangadex/main.dart' as _i13;
import 'package:gagaku/mangadex/manga_view.dart' as _i18;
import 'package:gagaku/mangadex/model/types.dart' as _i32;
import 'package:gagaku/mangadex/reader.dart' as _i19;
import 'package:gagaku/mangadex/recent_feed.dart' as _i20;
import 'package:gagaku/mangadex/search.dart' as _i21;
import 'package:gagaku/mangadex/tag_view.dart' as _i22;
import 'package:gagaku/settings.dart' as _i1;
import 'package:gagaku/web/favorites.dart' as _i25;
import 'package:gagaku/web/frontpage.dart' as _i2;
import 'package:gagaku/web/history.dart' as _i26;
import 'package:gagaku/web/main.dart' as _i27;
import 'package:gagaku/web/manga_view.dart' as _i24;
import 'package:gagaku/web/model/types.dart' as _i31;
import 'package:gagaku/web/reader.dart' as _i3;
import 'package:gagaku/web/search.dart' as _i4;
import 'package:gagaku/web/updates_feed.dart' as _i28;

/// generated route for
/// [_i1.AppSettingsPage]
class AppSettingsRoute extends _i29.PageRouteInfo<void> {
  const AppSettingsRoute({List<_i29.PageRouteInfo>? children})
    : super(AppSettingsRoute.name, initialChildren: children);

  static const String name = 'AppSettingsRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i1.AppSettingsPage();
    },
  );
}

/// generated route for
/// [_i2.ExtensionHomePage]
class ExtensionHomeRoute extends _i29.PageRouteInfo<ExtensionHomeRouteArgs> {
  ExtensionHomeRoute({
    _i30.Key? key,
    required String sourceId,
    _i31.WebSourceInfo? source,
    List<_i29.PageRouteInfo>? children,
  }) : super(
         ExtensionHomeRoute.name,
         args: ExtensionHomeRouteArgs(
           key: key,
           sourceId: sourceId,
           source: source,
         ),
         rawPathParams: {'sourceId': sourceId},
         initialChildren: children,
       );

  static const String name = 'ExtensionHomeRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<ExtensionHomeRouteArgs>(
        orElse: () =>
            ExtensionHomeRouteArgs(sourceId: pathParams.getString('sourceId')),
      );
      return _i2.ExtensionHomePage(
        key: args.key,
        sourceId: args.sourceId,
        source: args.source,
      );
    },
  );
}

class ExtensionHomeRouteArgs {
  const ExtensionHomeRouteArgs({this.key, required this.sourceId, this.source});

  final _i30.Key? key;

  final String sourceId;

  final _i31.WebSourceInfo? source;

  @override
  String toString() {
    return 'ExtensionHomeRouteArgs{key: $key, sourceId: $sourceId, source: $source}';
  }
}

/// generated route for
/// [_i3.ExtensionReaderPage]
class ExtensionReaderRoute
    extends _i29.PageRouteInfo<ExtensionReaderRouteArgs> {
  ExtensionReaderRoute({
    _i30.Key? key,
    required String sourceId,
    required String mangaId,
    required String chapterId,
    _i31.WebReaderData? readerData,
    List<_i29.PageRouteInfo>? children,
  }) : super(
         ExtensionReaderRoute.name,
         args: ExtensionReaderRouteArgs(
           key: key,
           sourceId: sourceId,
           mangaId: mangaId,
           chapterId: chapterId,
           readerData: readerData,
         ),
         rawPathParams: {
           'sourceId': sourceId,
           'mangaId': mangaId,
           'chapterId': chapterId,
         },
         initialChildren: children,
       );

  static const String name = 'ExtensionReaderRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<ExtensionReaderRouteArgs>(
        orElse: () => ExtensionReaderRouteArgs(
          sourceId: pathParams.getString('sourceId'),
          mangaId: pathParams.getString('mangaId'),
          chapterId: pathParams.getString('chapterId'),
        ),
      );
      return _i3.ExtensionReaderPage(
        key: args.key,
        sourceId: args.sourceId,
        mangaId: args.mangaId,
        chapterId: args.chapterId,
        readerData: args.readerData,
      );
    },
  );
}

class ExtensionReaderRouteArgs {
  const ExtensionReaderRouteArgs({
    this.key,
    required this.sourceId,
    required this.mangaId,
    required this.chapterId,
    this.readerData,
  });

  final _i30.Key? key;

  final String sourceId;

  final String mangaId;

  final String chapterId;

  final _i31.WebReaderData? readerData;

  @override
  String toString() {
    return 'ExtensionReaderRouteArgs{key: $key, sourceId: $sourceId, mangaId: $mangaId, chapterId: $chapterId, readerData: $readerData}';
  }
}

/// generated route for
/// [_i4.ExtensionSearchPage]
class ExtensionSearchRoute
    extends _i29.PageRouteInfo<ExtensionSearchRouteArgs> {
  ExtensionSearchRoute({
    _i30.Key? key,
    required String sourceId,
    _i31.WebSourceInfo? source,
    _i31.SearchQuery? query,
    List<_i29.PageRouteInfo>? children,
  }) : super(
         ExtensionSearchRoute.name,
         args: ExtensionSearchRouteArgs(
           key: key,
           sourceId: sourceId,
           source: source,
           query: query,
         ),
         rawPathParams: {'sourceId': sourceId},
         initialChildren: children,
       );

  static const String name = 'ExtensionSearchRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<ExtensionSearchRouteArgs>(
        orElse: () => ExtensionSearchRouteArgs(
          sourceId: pathParams.getString('sourceId'),
        ),
      );
      return _i4.ExtensionSearchPage(
        key: args.key,
        sourceId: args.sourceId,
        source: args.source,
        query: args.query,
      );
    },
  );
}

class ExtensionSearchRouteArgs {
  const ExtensionSearchRouteArgs({
    this.key,
    required this.sourceId,
    this.source,
    this.query,
  });

  final _i30.Key? key;

  final String sourceId;

  final _i31.WebSourceInfo? source;

  final _i31.SearchQuery? query;

  @override
  String toString() {
    return 'ExtensionSearchRouteArgs{key: $key, sourceId: $sourceId, source: $source, query: $query}';
  }
}

/// generated route for
/// [_i5.LocalLibraryHomeScreen]
class LocalLibraryHomeRoute extends _i29.PageRouteInfo<void> {
  const LocalLibraryHomeRoute({List<_i29.PageRouteInfo>? children})
    : super(LocalLibraryHomeRoute.name, initialChildren: children);

  static const String name = 'LocalLibraryHomeRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i5.LocalLibraryHomeScreen();
    },
  );
}

/// generated route for
/// [_i6.MangaDexChapterFeedPage]
class MangaDexChapterFeedRoute
    extends _i29.PageRouteInfo<MangaDexChapterFeedRouteArgs> {
  MangaDexChapterFeedRoute({
    _i30.Key? key,
    _i30.ScrollController? controller,
    List<_i29.PageRouteInfo>? children,
  }) : super(
         MangaDexChapterFeedRoute.name,
         args: MangaDexChapterFeedRouteArgs(key: key, controller: controller),
         initialChildren: children,
       );

  static const String name = 'MangaDexChapterFeedRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MangaDexChapterFeedRouteArgs>(
        orElse: () => const MangaDexChapterFeedRouteArgs(),
      );
      return _i6.MangaDexChapterFeedPage(
        key: args.key,
        controller: args.controller,
      );
    },
  );
}

class MangaDexChapterFeedRouteArgs {
  const MangaDexChapterFeedRouteArgs({this.key, this.controller});

  final _i30.Key? key;

  final _i30.ScrollController? controller;

  @override
  String toString() {
    return 'MangaDexChapterFeedRouteArgs{key: $key, controller: $controller}';
  }
}

/// generated route for
/// [_i7.MangaDexCreateListScreen]
class MangaDexCreateListRoute extends _i29.PageRouteInfo<void> {
  const MangaDexCreateListRoute({List<_i29.PageRouteInfo>? children})
    : super(MangaDexCreateListRoute.name, initialChildren: children);

  static const String name = 'MangaDexCreateListRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i7.MangaDexCreateListScreen();
    },
  );
}

/// generated route for
/// [_i8.MangaDexCreatorViewPage]
class MangaDexCreatorViewRoute
    extends _i29.PageRouteInfo<MangaDexCreatorViewRouteArgs> {
  MangaDexCreatorViewRoute({
    _i30.Key? key,
    required String creatorId,
    _i32.CreatorType? creator,
    List<_i29.PageRouteInfo>? children,
  }) : super(
         MangaDexCreatorViewRoute.name,
         args: MangaDexCreatorViewRouteArgs(
           key: key,
           creatorId: creatorId,
           creator: creator,
         ),
         rawPathParams: {'creatorId': creatorId},
         initialChildren: children,
       );

  static const String name = 'MangaDexCreatorViewRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<MangaDexCreatorViewRouteArgs>(
        orElse: () => MangaDexCreatorViewRouteArgs(
          creatorId: pathParams.getString('creatorId'),
        ),
      );
      return _i8.MangaDexCreatorViewPage(
        key: args.key,
        creatorId: args.creatorId,
        creator: args.creator,
      );
    },
  );
}

class MangaDexCreatorViewRouteArgs {
  const MangaDexCreatorViewRouteArgs({
    this.key,
    required this.creatorId,
    this.creator,
  });

  final _i30.Key? key;

  final String creatorId;

  final _i32.CreatorType? creator;

  @override
  String toString() {
    return 'MangaDexCreatorViewRouteArgs{key: $key, creatorId: $creatorId, creator: $creator}';
  }
}

/// generated route for
/// [_i8.MangaDexCreatorViewWithNamePage]
class MangaDexCreatorViewWithNameRoute
    extends _i29.PageRouteInfo<MangaDexCreatorViewWithNameRouteArgs> {
  MangaDexCreatorViewWithNameRoute({
    _i30.Key? key,
    required String creatorId,
    String? name,
    List<_i29.PageRouteInfo>? children,
  }) : super(
         MangaDexCreatorViewWithNameRoute.name,
         args: MangaDexCreatorViewWithNameRouteArgs(
           key: key,
           creatorId: creatorId,
           name: name,
         ),
         rawPathParams: {'creatorId': creatorId, 'name': name},
         initialChildren: children,
       );

  static const String name = 'MangaDexCreatorViewWithNameRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<MangaDexCreatorViewWithNameRouteArgs>(
        orElse: () => MangaDexCreatorViewWithNameRouteArgs(
          creatorId: pathParams.getString('creatorId'),
          name: pathParams.optString('name'),
        ),
      );
      return _i8.MangaDexCreatorViewWithNamePage(
        key: args.key,
        creatorId: args.creatorId,
        name: args.name,
      );
    },
  );
}

class MangaDexCreatorViewWithNameRouteArgs {
  const MangaDexCreatorViewWithNameRouteArgs({
    this.key,
    required this.creatorId,
    this.name,
  });

  final _i30.Key? key;

  final String creatorId;

  final String? name;

  @override
  String toString() {
    return 'MangaDexCreatorViewWithNameRouteArgs{key: $key, creatorId: $creatorId, name: $name}';
  }
}

/// generated route for
/// [_i7.MangaDexEditListScreen]
class MangaDexEditListRoute
    extends _i29.PageRouteInfo<MangaDexEditListRouteArgs> {
  MangaDexEditListRoute({
    _i33.Key? key,
    String? listId,
    _i32.CustomList? list,
    List<_i29.PageRouteInfo>? children,
  }) : super(
         MangaDexEditListRoute.name,
         args: MangaDexEditListRouteArgs(key: key, listId: listId, list: list),
         rawPathParams: {'listId': listId},
         initialChildren: children,
       );

  static const String name = 'MangaDexEditListRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<MangaDexEditListRouteArgs>(
        orElse: () =>
            MangaDexEditListRouteArgs(listId: pathParams.optString('listId')),
      );
      return _i7.MangaDexEditListScreen(
        key: args.key,
        listId: args.listId,
        list: args.list,
      );
    },
  );
}

class MangaDexEditListRouteArgs {
  const MangaDexEditListRouteArgs({this.key, this.listId, this.list});

  final _i33.Key? key;

  final String? listId;

  final _i32.CustomList? list;

  @override
  String toString() {
    return 'MangaDexEditListRouteArgs{key: $key, listId: $listId, list: $list}';
  }
}

/// generated route for
/// [_i9.MangaDexFrontPage]
class MangaDexFrontRoute extends _i29.PageRouteInfo<MangaDexFrontRouteArgs> {
  MangaDexFrontRoute({
    _i30.Key? key,
    _i30.ScrollController? controller,
    List<_i29.PageRouteInfo>? children,
  }) : super(
         MangaDexFrontRoute.name,
         args: MangaDexFrontRouteArgs(key: key, controller: controller),
         initialChildren: children,
       );

  static const String name = 'MangaDexFrontRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MangaDexFrontRouteArgs>(
        orElse: () => const MangaDexFrontRouteArgs(),
      );
      return _i9.MangaDexFrontPage(key: args.key, controller: args.controller);
    },
  );
}

class MangaDexFrontRouteArgs {
  const MangaDexFrontRouteArgs({this.key, this.controller});

  final _i30.Key? key;

  final _i30.ScrollController? controller;

  @override
  String toString() {
    return 'MangaDexFrontRouteArgs{key: $key, controller: $controller}';
  }
}

/// generated route for
/// [_i10.MangaDexGlobalFeedPage]
class MangaDexGlobalFeedRoute extends _i29.PageRouteInfo<void> {
  const MangaDexGlobalFeedRoute({List<_i29.PageRouteInfo>? children})
    : super(MangaDexGlobalFeedRoute.name, initialChildren: children);

  static const String name = 'MangaDexGlobalFeedRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i10.MangaDexGlobalFeedPage();
    },
  );
}

/// generated route for
/// [_i11.MangaDexGroupViewPage]
class MangaDexGroupViewRoute
    extends _i29.PageRouteInfo<MangaDexGroupViewRouteArgs> {
  MangaDexGroupViewRoute({
    _i30.Key? key,
    required String groupId,
    _i32.Group? group,
    List<_i29.PageRouteInfo>? children,
  }) : super(
         MangaDexGroupViewRoute.name,
         args: MangaDexGroupViewRouteArgs(
           key: key,
           groupId: groupId,
           group: group,
         ),
         rawPathParams: {'groupId': groupId},
         initialChildren: children,
       );

  static const String name = 'MangaDexGroupViewRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<MangaDexGroupViewRouteArgs>(
        orElse: () => MangaDexGroupViewRouteArgs(
          groupId: pathParams.getString('groupId'),
        ),
      );
      return _i11.MangaDexGroupViewPage(
        key: args.key,
        groupId: args.groupId,
        group: args.group,
      );
    },
  );
}

class MangaDexGroupViewRouteArgs {
  const MangaDexGroupViewRouteArgs({
    this.key,
    required this.groupId,
    this.group,
  });

  final _i30.Key? key;

  final String groupId;

  final _i32.Group? group;

  @override
  String toString() {
    return 'MangaDexGroupViewRouteArgs{key: $key, groupId: $groupId, group: $group}';
  }
}

/// generated route for
/// [_i11.MangaDexGroupViewWithNamePage]
class MangaDexGroupViewWithNameRoute
    extends _i29.PageRouteInfo<MangaDexGroupViewWithNameRouteArgs> {
  MangaDexGroupViewWithNameRoute({
    _i30.Key? key,
    required String groupId,
    String? name,
    List<_i29.PageRouteInfo>? children,
  }) : super(
         MangaDexGroupViewWithNameRoute.name,
         args: MangaDexGroupViewWithNameRouteArgs(
           key: key,
           groupId: groupId,
           name: name,
         ),
         rawPathParams: {'groupId': groupId, 'name': name},
         initialChildren: children,
       );

  static const String name = 'MangaDexGroupViewWithNameRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<MangaDexGroupViewWithNameRouteArgs>(
        orElse: () => MangaDexGroupViewWithNameRouteArgs(
          groupId: pathParams.getString('groupId'),
          name: pathParams.optString('name'),
        ),
      );
      return _i11.MangaDexGroupViewWithNamePage(
        key: args.key,
        groupId: args.groupId,
        name: args.name,
      );
    },
  );
}

class MangaDexGroupViewWithNameRouteArgs {
  const MangaDexGroupViewWithNameRouteArgs({
    this.key,
    required this.groupId,
    this.name,
  });

  final _i30.Key? key;

  final String groupId;

  final String? name;

  @override
  String toString() {
    return 'MangaDexGroupViewWithNameRouteArgs{key: $key, groupId: $groupId, name: $name}';
  }
}

/// generated route for
/// [_i12.MangaDexHistoryFeedPage]
class MangaDexHistoryFeedRoute
    extends _i29.PageRouteInfo<MangaDexHistoryFeedRouteArgs> {
  MangaDexHistoryFeedRoute({
    _i30.Key? key,
    _i30.ScrollController? controller,
    List<_i29.PageRouteInfo>? children,
  }) : super(
         MangaDexHistoryFeedRoute.name,
         args: MangaDexHistoryFeedRouteArgs(key: key, controller: controller),
         initialChildren: children,
       );

  static const String name = 'MangaDexHistoryFeedRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MangaDexHistoryFeedRouteArgs>(
        orElse: () => const MangaDexHistoryFeedRouteArgs(),
      );
      return _i12.MangaDexHistoryFeedPage(
        key: args.key,
        controller: args.controller,
      );
    },
  );
}

class MangaDexHistoryFeedRouteArgs {
  const MangaDexHistoryFeedRouteArgs({this.key, this.controller});

  final _i30.Key? key;

  final _i30.ScrollController? controller;

  @override
  String toString() {
    return 'MangaDexHistoryFeedRouteArgs{key: $key, controller: $controller}';
  }
}

/// generated route for
/// [_i13.MangaDexHomePage]
class MangaDexHomeRoute extends _i29.PageRouteInfo<void> {
  const MangaDexHomeRoute({List<_i29.PageRouteInfo>? children})
    : super(MangaDexHomeRoute.name, initialChildren: children);

  static const String name = 'MangaDexHomeRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i13.MangaDexHomePage();
    },
  );
}

/// generated route for
/// [_i14.MangaDexLibraryPage]
class MangaDexLibraryRoute
    extends _i29.PageRouteInfo<MangaDexLibraryRouteArgs> {
  MangaDexLibraryRoute({
    _i30.Key? key,
    _i30.ScrollController? controller,
    List<_i29.PageRouteInfo>? children,
  }) : super(
         MangaDexLibraryRoute.name,
         args: MangaDexLibraryRouteArgs(key: key, controller: controller),
         initialChildren: children,
       );

  static const String name = 'MangaDexLibraryRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MangaDexLibraryRouteArgs>(
        orElse: () => const MangaDexLibraryRouteArgs(),
      );
      return _i14.MangaDexLibraryPage(
        key: args.key,
        controller: args.controller,
      );
    },
  );
}

class MangaDexLibraryRouteArgs {
  const MangaDexLibraryRouteArgs({this.key, this.controller});

  final _i30.Key? key;

  final _i30.ScrollController? controller;

  @override
  String toString() {
    return 'MangaDexLibraryRouteArgs{key: $key, controller: $controller}';
  }
}

/// generated route for
/// [_i15.MangaDexListViewPage]
class MangaDexListViewRoute
    extends _i29.PageRouteInfo<MangaDexListViewRouteArgs> {
  MangaDexListViewRoute({
    _i30.Key? key,
    required String listId,
    List<_i29.PageRouteInfo>? children,
  }) : super(
         MangaDexListViewRoute.name,
         args: MangaDexListViewRouteArgs(key: key, listId: listId),
         rawPathParams: {'listId': listId},
         initialChildren: children,
       );

  static const String name = 'MangaDexListViewRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<MangaDexListViewRouteArgs>(
        orElse: () =>
            MangaDexListViewRouteArgs(listId: pathParams.getString('listId')),
      );
      return _i15.MangaDexListViewPage(key: args.key, listId: args.listId);
    },
  );
}

class MangaDexListViewRouteArgs {
  const MangaDexListViewRouteArgs({this.key, required this.listId});

  final _i30.Key? key;

  final String listId;

  @override
  String toString() {
    return 'MangaDexListViewRouteArgs{key: $key, listId: $listId}';
  }
}

/// generated route for
/// [_i15.MangaDexListViewWithNamePage]
class MangaDexListViewWithNameRoute
    extends _i29.PageRouteInfo<MangaDexListViewWithNameRouteArgs> {
  MangaDexListViewWithNameRoute({
    _i30.Key? key,
    required String listId,
    String? name,
    List<_i29.PageRouteInfo>? children,
  }) : super(
         MangaDexListViewWithNameRoute.name,
         args: MangaDexListViewWithNameRouteArgs(
           key: key,
           listId: listId,
           name: name,
         ),
         rawPathParams: {'listId': listId, 'name': name},
         initialChildren: children,
       );

  static const String name = 'MangaDexListViewWithNameRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<MangaDexListViewWithNameRouteArgs>(
        orElse: () => MangaDexListViewWithNameRouteArgs(
          listId: pathParams.getString('listId'),
          name: pathParams.optString('name'),
        ),
      );
      return _i15.MangaDexListViewWithNamePage(
        key: args.key,
        listId: args.listId,
        name: args.name,
      );
    },
  );
}

class MangaDexListViewWithNameRouteArgs {
  const MangaDexListViewWithNameRouteArgs({
    this.key,
    required this.listId,
    this.name,
  });

  final _i30.Key? key;

  final String listId;

  final String? name;

  @override
  String toString() {
    return 'MangaDexListViewWithNameRouteArgs{key: $key, listId: $listId, name: $name}';
  }
}

/// generated route for
/// [_i16.MangaDexListsPage]
class MangaDexListsRoute extends _i29.PageRouteInfo<MangaDexListsRouteArgs> {
  MangaDexListsRoute({
    _i30.Key? key,
    _i30.ScrollController? controller,
    List<_i29.PageRouteInfo>? children,
  }) : super(
         MangaDexListsRoute.name,
         args: MangaDexListsRouteArgs(key: key, controller: controller),
         initialChildren: children,
       );

  static const String name = 'MangaDexListsRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MangaDexListsRouteArgs>(
        orElse: () => const MangaDexListsRouteArgs(),
      );
      return _i16.MangaDexListsPage(key: args.key, controller: args.controller);
    },
  );
}

class MangaDexListsRouteArgs {
  const MangaDexListsRouteArgs({this.key, this.controller});

  final _i30.Key? key;

  final _i30.ScrollController? controller;

  @override
  String toString() {
    return 'MangaDexListsRouteArgs{key: $key, controller: $controller}';
  }
}

/// generated route for
/// [_i17.MangaDexLoginScreen]
class MangaDexLoginRoute extends _i29.PageRouteInfo<void> {
  const MangaDexLoginRoute({List<_i29.PageRouteInfo>? children})
    : super(MangaDexLoginRoute.name, initialChildren: children);

  static const String name = 'MangaDexLoginRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i17.MangaDexLoginScreen();
    },
  );
}

/// generated route for
/// [_i18.MangaDexMangaViewPage]
class MangaDexMangaViewRoute
    extends _i29.PageRouteInfo<MangaDexMangaViewRouteArgs> {
  MangaDexMangaViewRoute({
    _i30.Key? key,
    required String mangaId,
    _i32.Manga? manga,
    List<_i29.PageRouteInfo>? children,
  }) : super(
         MangaDexMangaViewRoute.name,
         args: MangaDexMangaViewRouteArgs(
           key: key,
           mangaId: mangaId,
           manga: manga,
         ),
         rawPathParams: {'mangaId': mangaId},
         initialChildren: children,
       );

  static const String name = 'MangaDexMangaViewRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<MangaDexMangaViewRouteArgs>(
        orElse: () => MangaDexMangaViewRouteArgs(
          mangaId: pathParams.getString('mangaId'),
        ),
      );
      return _i18.MangaDexMangaViewPage(
        key: args.key,
        mangaId: args.mangaId,
        manga: args.manga,
      );
    },
  );
}

class MangaDexMangaViewRouteArgs {
  const MangaDexMangaViewRouteArgs({
    this.key,
    required this.mangaId,
    this.manga,
  });

  final _i30.Key? key;

  final String mangaId;

  final _i32.Manga? manga;

  @override
  String toString() {
    return 'MangaDexMangaViewRouteArgs{key: $key, mangaId: $mangaId, manga: $manga}';
  }
}

/// generated route for
/// [_i18.MangaDexMangaViewWithNamePage]
class MangaDexMangaViewWithNameRoute
    extends _i29.PageRouteInfo<MangaDexMangaViewWithNameRouteArgs> {
  MangaDexMangaViewWithNameRoute({
    _i30.Key? key,
    required String mangaId,
    String? name,
    List<_i29.PageRouteInfo>? children,
  }) : super(
         MangaDexMangaViewWithNameRoute.name,
         args: MangaDexMangaViewWithNameRouteArgs(
           key: key,
           mangaId: mangaId,
           name: name,
         ),
         rawPathParams: {'mangaId': mangaId, 'name': name},
         initialChildren: children,
       );

  static const String name = 'MangaDexMangaViewWithNameRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<MangaDexMangaViewWithNameRouteArgs>(
        orElse: () => MangaDexMangaViewWithNameRouteArgs(
          mangaId: pathParams.getString('mangaId'),
          name: pathParams.optString('name'),
        ),
      );
      return _i18.MangaDexMangaViewWithNamePage(
        key: args.key,
        mangaId: args.mangaId,
        name: args.name,
      );
    },
  );
}

class MangaDexMangaViewWithNameRouteArgs {
  const MangaDexMangaViewWithNameRouteArgs({
    this.key,
    required this.mangaId,
    this.name,
  });

  final _i30.Key? key;

  final String mangaId;

  final String? name;

  @override
  String toString() {
    return 'MangaDexMangaViewWithNameRouteArgs{key: $key, mangaId: $mangaId, name: $name}';
  }
}

/// generated route for
/// [_i19.MangaDexReaderPage]
class MangaDexReaderRoute extends _i29.PageRouteInfo<MangaDexReaderRouteArgs> {
  MangaDexReaderRoute({
    _i30.Key? key,
    required String chapterId,
    _i19.ReaderData? readerData,
    List<_i29.PageRouteInfo>? children,
  }) : super(
         MangaDexReaderRoute.name,
         args: MangaDexReaderRouteArgs(
           key: key,
           chapterId: chapterId,
           readerData: readerData,
         ),
         rawPathParams: {'chapterId': chapterId},
         initialChildren: children,
       );

  static const String name = 'MangaDexReaderRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<MangaDexReaderRouteArgs>(
        orElse: () => MangaDexReaderRouteArgs(
          chapterId: pathParams.getString('chapterId'),
        ),
      );
      return _i19.MangaDexReaderPage(
        key: args.key,
        chapterId: args.chapterId,
        readerData: args.readerData,
      );
    },
  );
}

class MangaDexReaderRouteArgs {
  const MangaDexReaderRouteArgs({
    this.key,
    required this.chapterId,
    this.readerData,
  });

  final _i30.Key? key;

  final String chapterId;

  final _i19.ReaderData? readerData;

  @override
  String toString() {
    return 'MangaDexReaderRouteArgs{key: $key, chapterId: $chapterId, readerData: $readerData}';
  }
}

/// generated route for
/// [_i20.MangaDexRecentFeedPage]
class MangaDexRecentFeedRoute
    extends _i29.PageRouteInfo<MangaDexRecentFeedRouteArgs> {
  MangaDexRecentFeedRoute({
    _i30.Key? key,
    _i30.ScrollController? controller,
    List<_i29.PageRouteInfo>? children,
  }) : super(
         MangaDexRecentFeedRoute.name,
         args: MangaDexRecentFeedRouteArgs(key: key, controller: controller),
         initialChildren: children,
       );

  static const String name = 'MangaDexRecentFeedRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MangaDexRecentFeedRouteArgs>(
        orElse: () => const MangaDexRecentFeedRouteArgs(),
      );
      return _i20.MangaDexRecentFeedPage(
        key: args.key,
        controller: args.controller,
      );
    },
  );
}

class MangaDexRecentFeedRouteArgs {
  const MangaDexRecentFeedRouteArgs({this.key, this.controller});

  final _i30.Key? key;

  final _i30.ScrollController? controller;

  @override
  String toString() {
    return 'MangaDexRecentFeedRouteArgs{key: $key, controller: $controller}';
  }
}

/// generated route for
/// [_i21.MangaDexSearchPage]
class MangaDexSearchRoute extends _i29.PageRouteInfo<MangaDexSearchRouteArgs> {
  MangaDexSearchRoute({
    _i30.Key? key,
    bool selectMode = false,
    Set<String>? selectedTitles,
    _i32.MangaSearchParameters? parameters,
    List<_i29.PageRouteInfo>? children,
  }) : super(
         MangaDexSearchRoute.name,
         args: MangaDexSearchRouteArgs(
           key: key,
           selectMode: selectMode,
           selectedTitles: selectedTitles,
           parameters: parameters,
         ),
         initialChildren: children,
       );

  static const String name = 'MangaDexSearchRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MangaDexSearchRouteArgs>(
        orElse: () => const MangaDexSearchRouteArgs(),
      );
      return _i21.MangaDexSearchPage(
        key: args.key,
        selectMode: args.selectMode,
        selectedTitles: args.selectedTitles,
        parameters: args.parameters,
      );
    },
  );
}

class MangaDexSearchRouteArgs {
  const MangaDexSearchRouteArgs({
    this.key,
    this.selectMode = false,
    this.selectedTitles,
    this.parameters,
  });

  final _i30.Key? key;

  final bool selectMode;

  final Set<String>? selectedTitles;

  final _i32.MangaSearchParameters? parameters;

  @override
  String toString() {
    return 'MangaDexSearchRouteArgs{key: $key, selectMode: $selectMode, selectedTitles: $selectedTitles, parameters: $parameters}';
  }
}

/// generated route for
/// [_i22.MangaDexTagViewPage]
class MangaDexTagViewRoute
    extends _i29.PageRouteInfo<MangaDexTagViewRouteArgs> {
  MangaDexTagViewRoute({
    _i30.Key? key,
    required String tagId,
    _i32.Tag? tag,
    List<_i29.PageRouteInfo>? children,
  }) : super(
         MangaDexTagViewRoute.name,
         args: MangaDexTagViewRouteArgs(key: key, tagId: tagId, tag: tag),
         rawPathParams: {'tagId': tagId},
         initialChildren: children,
       );

  static const String name = 'MangaDexTagViewRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<MangaDexTagViewRouteArgs>(
        orElse: () =>
            MangaDexTagViewRouteArgs(tagId: pathParams.getString('tagId')),
      );
      return _i22.MangaDexTagViewPage(
        key: args.key,
        tagId: args.tagId,
        tag: args.tag,
      );
    },
  );
}

class MangaDexTagViewRouteArgs {
  const MangaDexTagViewRouteArgs({this.key, required this.tagId, this.tag});

  final _i30.Key? key;

  final String tagId;

  final _i32.Tag? tag;

  @override
  String toString() {
    return 'MangaDexTagViewRouteArgs{key: $key, tagId: $tagId, tag: $tag}';
  }
}

/// generated route for
/// [_i22.MangaDexTagViewWithNamePage]
class MangaDexTagViewWithNameRoute
    extends _i29.PageRouteInfo<MangaDexTagViewWithNameRouteArgs> {
  MangaDexTagViewWithNameRoute({
    _i30.Key? key,
    required String tagId,
    String? name,
    List<_i29.PageRouteInfo>? children,
  }) : super(
         MangaDexTagViewWithNameRoute.name,
         args: MangaDexTagViewWithNameRouteArgs(
           key: key,
           tagId: tagId,
           name: name,
         ),
         rawPathParams: {'tagId': tagId, 'name': name},
         initialChildren: children,
       );

  static const String name = 'MangaDexTagViewWithNameRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<MangaDexTagViewWithNameRouteArgs>(
        orElse: () => MangaDexTagViewWithNameRouteArgs(
          tagId: pathParams.getString('tagId'),
          name: pathParams.optString('name'),
        ),
      );
      return _i22.MangaDexTagViewWithNamePage(
        key: args.key,
        tagId: args.tagId,
        name: args.name,
      );
    },
  );
}

class MangaDexTagViewWithNameRouteArgs {
  const MangaDexTagViewWithNameRouteArgs({
    this.key,
    required this.tagId,
    this.name,
  });

  final _i30.Key? key;

  final String tagId;

  final String? name;

  @override
  String toString() {
    return 'MangaDexTagViewWithNameRouteArgs{key: $key, tagId: $tagId, name: $name}';
  }
}

/// generated route for
/// [_i23.NotFoundScreen]
class NotFoundRoute extends _i29.PageRouteInfo<NotFoundRouteArgs> {
  NotFoundRoute({
    _i33.Key? key,
    String uri = '',
    List<_i29.PageRouteInfo>? children,
  }) : super(
         NotFoundRoute.name,
         args: NotFoundRouteArgs(key: key, uri: uri),
         rawQueryParams: {'uri': uri},
         initialChildren: children,
       );

  static const String name = 'NotFoundRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final queryParams = data.queryParams;
      final args = data.argsAs<NotFoundRouteArgs>(
        orElse: () => NotFoundRouteArgs(uri: queryParams.getString('uri', '')),
      );
      return _i23.NotFoundScreen(key: args.key, uri: args.uri);
    },
  );
}

class NotFoundRouteArgs {
  const NotFoundRouteArgs({this.key, this.uri = ''});

  final _i33.Key? key;

  final String uri;

  @override
  String toString() {
    return 'NotFoundRouteArgs{key: $key, uri: $uri}';
  }
}

/// generated route for
/// [_i3.ProxyWebSourceReaderPage]
class ProxyWebSourceReaderRoute
    extends _i29.PageRouteInfo<ProxyWebSourceReaderRouteArgs> {
  ProxyWebSourceReaderRoute({
    _i30.Key? key,
    required String proxy,
    required String code,
    required String chapter,
    String? page,
    _i31.WebReaderData? readerData,
    List<_i29.PageRouteInfo>? children,
  }) : super(
         ProxyWebSourceReaderRoute.name,
         args: ProxyWebSourceReaderRouteArgs(
           key: key,
           proxy: proxy,
           code: code,
           chapter: chapter,
           page: page,
           readerData: readerData,
         ),
         rawPathParams: {'proxy': proxy, 'code': code, 'chapter': chapter},
         initialChildren: children,
       );

  static const String name = 'ProxyWebSourceReaderRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<ProxyWebSourceReaderRouteArgs>(
        orElse: () => ProxyWebSourceReaderRouteArgs(
          proxy: pathParams.getString('proxy'),
          code: pathParams.getString('code'),
          chapter: pathParams.getString('chapter'),
        ),
      );
      return _i3.ProxyWebSourceReaderPage(
        key: args.key,
        proxy: args.proxy,
        code: args.code,
        chapter: args.chapter,
        page: args.page,
        readerData: args.readerData,
      );
    },
  );
}

class ProxyWebSourceReaderRouteArgs {
  const ProxyWebSourceReaderRouteArgs({
    this.key,
    required this.proxy,
    required this.code,
    required this.chapter,
    this.page,
    this.readerData,
  });

  final _i30.Key? key;

  final String proxy;

  final String code;

  final String chapter;

  final String? page;

  final _i31.WebReaderData? readerData;

  @override
  String toString() {
    return 'ProxyWebSourceReaderRouteArgs{key: $key, proxy: $proxy, code: $code, chapter: $chapter, page: $page, readerData: $readerData}';
  }
}

/// generated route for
/// [_i24.WebMangaViewPage]
class WebMangaViewRoute extends _i29.PageRouteInfo<WebMangaViewRouteArgs> {
  WebMangaViewRoute({
    _i30.Key? key,
    required String sourceId,
    required String mangaId,
    _i31.SourceHandler? handle,
    List<_i29.PageRouteInfo>? children,
  }) : super(
         WebMangaViewRoute.name,
         args: WebMangaViewRouteArgs(
           key: key,
           sourceId: sourceId,
           mangaId: mangaId,
           handle: handle,
         ),
         rawPathParams: {'sourceId': sourceId, 'mangaId': mangaId},
         initialChildren: children,
       );

  static const String name = 'WebMangaViewRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<WebMangaViewRouteArgs>(
        orElse: () => WebMangaViewRouteArgs(
          sourceId: pathParams.getString('sourceId'),
          mangaId: pathParams.getString('mangaId'),
        ),
      );
      return _i24.WebMangaViewPage(
        key: args.key,
        sourceId: args.sourceId,
        mangaId: args.mangaId,
        handle: args.handle,
      );
    },
  );
}

class WebMangaViewRouteArgs {
  const WebMangaViewRouteArgs({
    this.key,
    required this.sourceId,
    required this.mangaId,
    this.handle,
  });

  final _i30.Key? key;

  final String sourceId;

  final String mangaId;

  final _i31.SourceHandler? handle;

  @override
  String toString() {
    return 'WebMangaViewRouteArgs{key: $key, sourceId: $sourceId, mangaId: $mangaId, handle: $handle}';
  }
}

/// generated route for
/// [_i25.WebSourceFavoritesPage]
class WebSourceFavoritesRoute
    extends _i29.PageRouteInfo<WebSourceFavoritesRouteArgs> {
  WebSourceFavoritesRoute({
    _i30.Key? key,
    _i30.ScrollController? controller,
    List<_i29.PageRouteInfo>? children,
  }) : super(
         WebSourceFavoritesRoute.name,
         args: WebSourceFavoritesRouteArgs(key: key, controller: controller),
         initialChildren: children,
       );

  static const String name = 'WebSourceFavoritesRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<WebSourceFavoritesRouteArgs>(
        orElse: () => const WebSourceFavoritesRouteArgs(),
      );
      return _i25.WebSourceFavoritesPage(
        key: args.key,
        controller: args.controller,
      );
    },
  );
}

class WebSourceFavoritesRouteArgs {
  const WebSourceFavoritesRouteArgs({this.key, this.controller});

  final _i30.Key? key;

  final _i30.ScrollController? controller;

  @override
  String toString() {
    return 'WebSourceFavoritesRouteArgs{key: $key, controller: $controller}';
  }
}

/// generated route for
/// [_i2.WebSourceFrontPage]
class WebSourceFrontRoute extends _i29.PageRouteInfo<WebSourceFrontRouteArgs> {
  WebSourceFrontRoute({
    _i30.Key? key,
    _i30.ScrollController? controller,
    Uri? process,
    List<_i29.PageRouteInfo>? children,
  }) : super(
         WebSourceFrontRoute.name,
         args: WebSourceFrontRouteArgs(
           key: key,
           controller: controller,
           process: process,
         ),
         initialChildren: children,
       );

  static const String name = 'WebSourceFrontRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<WebSourceFrontRouteArgs>(
        orElse: () => const WebSourceFrontRouteArgs(),
      );
      return _i2.WebSourceFrontPage(
        key: args.key,
        controller: args.controller,
        process: args.process,
      );
    },
  );
}

class WebSourceFrontRouteArgs {
  const WebSourceFrontRouteArgs({this.key, this.controller, this.process});

  final _i30.Key? key;

  final _i30.ScrollController? controller;

  final Uri? process;

  @override
  String toString() {
    return 'WebSourceFrontRouteArgs{key: $key, controller: $controller, process: $process}';
  }
}

/// generated route for
/// [_i26.WebSourceHistoryPage]
class WebSourceHistoryRoute
    extends _i29.PageRouteInfo<WebSourceHistoryRouteArgs> {
  WebSourceHistoryRoute({
    _i30.Key? key,
    _i30.ScrollController? controller,
    List<_i29.PageRouteInfo>? children,
  }) : super(
         WebSourceHistoryRoute.name,
         args: WebSourceHistoryRouteArgs(key: key, controller: controller),
         initialChildren: children,
       );

  static const String name = 'WebSourceHistoryRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<WebSourceHistoryRouteArgs>(
        orElse: () => const WebSourceHistoryRouteArgs(),
      );
      return _i26.WebSourceHistoryPage(
        key: args.key,
        controller: args.controller,
      );
    },
  );
}

class WebSourceHistoryRouteArgs {
  const WebSourceHistoryRouteArgs({this.key, this.controller});

  final _i30.Key? key;

  final _i30.ScrollController? controller;

  @override
  String toString() {
    return 'WebSourceHistoryRouteArgs{key: $key, controller: $controller}';
  }
}

/// generated route for
/// [_i27.WebSourceHomePage]
class WebSourceHomeRoute extends _i29.PageRouteInfo<void> {
  const WebSourceHomeRoute({List<_i29.PageRouteInfo>? children})
    : super(WebSourceHomeRoute.name, initialChildren: children);

  static const String name = 'WebSourceHomeRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i27.WebSourceHomePage();
    },
  );
}

/// generated route for
/// [_i28.WebSourceUpdatesPage]
class WebSourceUpdatesRoute
    extends _i29.PageRouteInfo<WebSourceUpdatesRouteArgs> {
  WebSourceUpdatesRoute({
    _i30.Key? key,
    _i30.ScrollController? controller,
    List<_i29.PageRouteInfo>? children,
  }) : super(
         WebSourceUpdatesRoute.name,
         args: WebSourceUpdatesRouteArgs(key: key, controller: controller),
         initialChildren: children,
       );

  static const String name = 'WebSourceUpdatesRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<WebSourceUpdatesRouteArgs>(
        orElse: () => const WebSourceUpdatesRouteArgs(),
      );
      return _i28.WebSourceUpdatesPage(
        key: args.key,
        controller: args.controller,
      );
    },
  );
}

class WebSourceUpdatesRouteArgs {
  const WebSourceUpdatesRouteArgs({this.key, this.controller});

  final _i30.Key? key;

  final _i30.ScrollController? controller;

  @override
  String toString() {
    return 'WebSourceUpdatesRouteArgs{key: $key, controller: $controller}';
  }
}
