/// Paged sliver lists and grids.
///
/// A [PagedController] fetches pages through a [PageFetcher] whose
/// [PageResult] carries the next key. Layouts consume a [PagedView], which is
/// either the controller itself or a projection created with
/// [PagedViewProjection.project].
library;

export 'src/defaults.dart'
    show
        PagedEmptyIndicator,
        PagedErrorIndicator,
        PagedProgressIndicator,
        defaultPagedTransitionBuilder;
export 'src/page_result.dart';
export 'src/paged_controller.dart';
export 'src/paged_sliver_grid.dart';
export 'src/paged_sliver_list.dart';
export 'src/paged_state.dart' hide PagedStateTransitions;
export 'src/paged_view.dart';
export 'src/status_builders.dart';
