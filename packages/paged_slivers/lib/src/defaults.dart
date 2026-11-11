import 'package:animations/animations.dart';
import 'package:material_ui/material_ui.dart';

/// A centered [CircularProgressIndicator].
class PagedProgressIndicator extends StatelessWidget {
  const PagedProgressIndicator({super.key, required this.padding});

  /// Padding for the first page.
  static const firstPagePadding = EdgeInsets.all(32);

  /// Padding for subsequent pages.
  static const nextPagePadding = EdgeInsets.symmetric(vertical: 16);

  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}

/// A centered message shown when there are no items.
class PagedEmptyIndicator extends StatelessWidget {
  const PagedEmptyIndicator({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}

/// Displays a paging error verbatim with a retry button.
class PagedErrorIndicator extends StatelessWidget {
  const PagedErrorIndicator({
    super.key,
    required this.error,
    required this.onRetry,
    required this.retryLabel,
  });

  final Object error;
  final VoidCallback onRetry;
  final String retryLabel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SelectionArea(child: Text('$error')),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: Text(retryLabel),
          ),
        ],
      ),
    );
  }
}

/// Material fade-through without a painted fill.
///
/// [FadeThroughTransition] otherwise paints `Theme.canvasColor` behind the
/// incoming child, covering whatever surface the paged view sits on.
Widget defaultPagedTransitionBuilder(
  Widget child,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
) => FadeThroughTransition(
  animation: animation,
  secondaryAnimation: secondaryAnimation,
  fillColor: Colors.transparent,
  child: child,
);
