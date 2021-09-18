class ReaderSettings {
  /// If true, the reader fits the page to widget width, otherwise
  /// it is contrained to widget height (default)
  final bool fitWidth;

  /// If true, page increments right to left, otherwise
  /// it increments left to right (default)
  final bool rightToLeft;

  /// Displays progress bar if true (default false)
  final bool showProgressBar;

  ReaderSettings(
      {this.fitWidth = false,
      this.rightToLeft = false,
      this.showProgressBar = false});

  ReaderSettings copyWith({
    bool? fitWidth,
    bool? rightToLeft,
    bool? showProgressBar,
  }) {
    return ReaderSettings(
      fitWidth: fitWidth ?? this.fitWidth,
      rightToLeft: rightToLeft ?? this.rightToLeft,
      showProgressBar: showProgressBar ?? this.showProgressBar,
    );
  }
}
