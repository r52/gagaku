import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'page_controller.dart';

/// Pager position and the transforms of currently mounted gallery pages.
///
/// Page controllers live as long as their page is built, so they do not
/// accumulate as the reader moves through a chapter.
class ComicGalleryController {
  ComicGalleryController({int initialPage = 0})
    : pageController = PageController(initialPage: initialPage);

  final PageController pageController;
  final Map<int, ComicPageController> _pages = {};

  /// The transform of page [index], or null when it is not mounted.
  ComicPageController? pageAt(int index) => _pages[index];

  /// Indices of the pages currently mounted.
  Iterable<int> get mountedPages => _pages.keys;

  void jumpToPage(int page) {
    if (pageController.hasClients) pageController.jumpToPage(page);
  }

  @internal
  void registerPage(int index, ComicPageController controller) {
    _pages[index] = controller;
  }

  @internal
  void unregisterPage(int index, ComicPageController controller) {
    if (identical(_pages[index], controller)) _pages.remove(index);
  }

  void dispose() {
    _pages.clear();
    pageController.dispose();
  }
}
