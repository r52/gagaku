import 'package:flutter/widgets.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:paged_slivers/paged_slivers.dart';

/// Gagaku's paged-view status indicators: the package defaults with
/// translated text.
///
/// Screens that need a different indicator override individual builders with
/// [PagedStatusBuilders.copyWith].
PagedStatusBuilders pagedStatusBuilders(BuildContext context) {
  final tr = context.t;
  return PagedStatusBuilders(
    retryLabel: tr.ui.retry,
    emptyMessage: tr.errors.noitems,
  );
}
