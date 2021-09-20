import 'package:shared_preferences/shared_preferences.dart';

class ReaderSettings {
  /// If true, the reader fits the page to widget width, otherwise
  /// it is contrained to widget height (default)
  final bool fitWidth;
  static const _fitWidthKey = 'reader.fitWidth';

  /// If true, page increments right to left, otherwise
  /// it increments left to right (default)
  final bool rightToLeft;
  static const _rightToLeftKey = 'reader.rightToLeft';

  /// Displays progress bar if true (default false)
  final bool showProgressBar;
  static const _showProgressBarKey = 'reader.showProgressBar';

  /// Whether swiping left or right changes the page (default false)
  // final bool swipeToChangePage;
  // static const _swipeToChangePage = 'reader.swipeToChangePage';

  ReaderSettings({
    this.fitWidth = false,
    this.rightToLeft = false,
    this.showProgressBar = false,
    // this.swipeToChangePage = false,
  });

  ReaderSettings copyWith({
    bool? fitWidth,
    bool? rightToLeft,
    bool? showProgressBar,
    bool? swipeToChangePage,
  }) {
    return ReaderSettings(
      fitWidth: fitWidth ?? this.fitWidth,
      rightToLeft: rightToLeft ?? this.rightToLeft,
      showProgressBar: showProgressBar ?? this.showProgressBar,
      // swipeToChangePage: swipeToChangePage ?? this.swipeToChangePage,
    );
  }

  static Future<ReaderSettings> load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool fitWidth = prefs.getBool(_fitWidthKey) ?? false;
    bool rightToLeft = prefs.getBool(_rightToLeftKey) ?? false;
    bool showProgressBar = prefs.getBool(_showProgressBarKey) ?? false;
    // bool swipeToChangePage = prefs.getBool(_swipeToChangePage) ?? false;

    return ReaderSettings(
      fitWidth: fitWidth,
      rightToLeft: rightToLeft,
      showProgressBar: showProgressBar,
      // swipeToChangePage: swipeToChangePage,
    );
  }

  Future<void> save() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_fitWidthKey, fitWidth);
    await prefs.setBool(_rightToLeftKey, rightToLeft);
    await prefs.setBool(_showProgressBarKey, showProgressBar);
    // await prefs.setBool(_swipeToChangePage, swipeToChangePage);
  }
}
