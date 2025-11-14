import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gagaku/local/main.dart';
import 'package:gagaku/mangadex/chapter_feed.dart';
import 'package:gagaku/mangadex/creator_view.dart';
import 'package:gagaku/mangadex/edit_list.dart';
import 'package:gagaku/mangadex/frontpage.dart';
import 'package:gagaku/mangadex/group_view.dart';
import 'package:gagaku/mangadex/history_feed.dart';
import 'package:gagaku/mangadex/latest_feed.dart';
import 'package:gagaku/mangadex/library.dart';
import 'package:gagaku/mangadex/list_view.dart';
import 'package:gagaku/mangadex/lists.dart';
import 'package:gagaku/mangadex/login_password.dart';
import 'package:gagaku/mangadex/main.dart';
import 'package:gagaku/mangadex/manga_view.dart';
import 'package:gagaku/mangadex/model/types.dart';
import 'package:gagaku/mangadex/reader.dart';
import 'package:gagaku/mangadex/recent_feed.dart';
import 'package:gagaku/mangadex/search.dart';
import 'package:gagaku/mangadex/tag_view.dart';
import 'package:gagaku/model/model.dart';
import 'package:gagaku/settings.dart';
import 'package:gagaku/util/ui.dart';
import 'package:gagaku/web/favorites.dart';
import 'package:gagaku/web/frontpage.dart';
import 'package:gagaku/web/history.dart';
import 'package:gagaku/web/main.dart';
import 'package:gagaku/web/manga_view.dart';
import 'package:gagaku/web/model/types.dart' hide Tag;
import 'package:gagaku/web/reader.dart';
import 'package:gagaku/web/repo_list.dart';
import 'package:gagaku/web/search.dart';
import 'package:gagaku/web/updates_feed.dart';
import 'package:go_router/go_router.dart';

part 'routes.g.dart';
part 'local/routes.dart';
part 'mangadex/routes.dart';
part 'web/routes.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

@TypedGoRoute<AppSettingsRoute>(path: GagakuRoute.config)
class AppSettingsRoute extends GoRouteData with $AppSettingsRoute {
  const AppSettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AppSettingsPage();
  }
}
