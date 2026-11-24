import 'package:animations/animations.dart';
import 'package:flutter/widgets.dart';

import 'defaults.dart';

/// Builds an error indicator. [retry] re-fetches the failed page.
typedef PagedErrorBuilder = Widget Function(
  BuildContext context,
  Object error,
  VoidCallback retry,
);

/// Status indicators for paged layouts.
///
/// Every builder defaults to a `material_ui` indicator. The defaults take
/// their text from [retryLabel] and [emptyMessage], because the package has no
/// translations of its own.
@immutable
class PagedStatusBuilders {
  const PagedStatusBuilders({
    required this.retryLabel,
    required this.emptyMessage,
    this.firstProgressBuilder,
    this.nextProgressBuilder,
    this.firstErrorBuilder,
    this.nextErrorBuilder,
    this.emptyBuilder,
    this.endBuilder,
    this.transitionBuilder = defaultPagedTransitionBuilder,
    this.transitionDuration = const Duration(milliseconds: 300),
  });

  /// The default error indicators' retry button label.
  final String retryLabel;

  /// The default empty indicator's message.
  final String emptyMessage;

  /// Shown while nothing is displayed yet.
  final WidgetBuilder? firstProgressBuilder;

  /// Shown after the items while more pages are expected.
  final WidgetBuilder? nextProgressBuilder;

  /// Shown when nothing is displayed and the fetch failed.
  final PagedErrorBuilder? firstErrorBuilder;

  /// Shown after the items when fetching the next page failed.
  final PagedErrorBuilder? nextErrorBuilder;

  /// Shown when there are no items and no more pages.
  final WidgetBuilder? emptyBuilder;

  /// Shown after the items once every page is loaded. Nothing is appended
  /// when null.
  final WidgetBuilder? endBuilder;

  /// Transition between status indicators.
  final PageTransitionSwitcherTransitionBuilder transitionBuilder;

  /// Duration of status transitions, including the fade into the item list.
  final Duration transitionDuration;

  Widget buildFirstProgress(BuildContext context) =>
      firstProgressBuilder?.call(context) ??
      const PagedProgressIndicator(
        padding: PagedProgressIndicator.firstPagePadding,
      );

  Widget buildNextProgress(BuildContext context) =>
      nextProgressBuilder?.call(context) ??
      const PagedProgressIndicator(
        padding: PagedProgressIndicator.nextPagePadding,
      );

  Widget buildFirstError(
    BuildContext context,
    Object error,
    VoidCallback retry,
  ) =>
      firstErrorBuilder?.call(context, error, retry) ??
      PagedErrorIndicator(error: error, onRetry: retry, retryLabel: retryLabel);

  Widget buildNextError(
    BuildContext context,
    Object error,
    VoidCallback retry,
  ) =>
      nextErrorBuilder?.call(context, error, retry) ??
      PagedErrorIndicator(error: error, onRetry: retry, retryLabel: retryLabel);

  Widget buildEmpty(BuildContext context) =>
      emptyBuilder?.call(context) ?? PagedEmptyIndicator(message: emptyMessage);

  PagedStatusBuilders copyWith({
    String? retryLabel,
    String? emptyMessage,
    WidgetBuilder? firstProgressBuilder,
    WidgetBuilder? nextProgressBuilder,
    PagedErrorBuilder? firstErrorBuilder,
    PagedErrorBuilder? nextErrorBuilder,
    WidgetBuilder? emptyBuilder,
    WidgetBuilder? endBuilder,
    PageTransitionSwitcherTransitionBuilder? transitionBuilder,
    Duration? transitionDuration,
  }) => PagedStatusBuilders(
    retryLabel: retryLabel ?? this.retryLabel,
    emptyMessage: emptyMessage ?? this.emptyMessage,
    firstProgressBuilder: firstProgressBuilder ?? this.firstProgressBuilder,
    nextProgressBuilder: nextProgressBuilder ?? this.nextProgressBuilder,
    firstErrorBuilder: firstErrorBuilder ?? this.firstErrorBuilder,
    nextErrorBuilder: nextErrorBuilder ?? this.nextErrorBuilder,
    emptyBuilder: emptyBuilder ?? this.emptyBuilder,
    endBuilder: endBuilder ?? this.endBuilder,
    transitionBuilder: transitionBuilder ?? this.transitionBuilder,
    transitionDuration: transitionDuration ?? this.transitionDuration,
  );
}
