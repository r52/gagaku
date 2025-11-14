part of 'package:gagaku/routes.dart';

@TypedGoRoute<LocalLibraryHomeRoute>(path: GagakuRoute.local)
class LocalLibraryHomeRoute extends GoRouteData with $LocalLibraryHomeRoute {
  const LocalLibraryHomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return LocalLibraryHomeScreen();
  }
}
