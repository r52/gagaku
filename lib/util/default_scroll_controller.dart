// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// A clone of [PrimaryScrollController] in order to sidestep ModalRoute inheritance

library;

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

typedef DefaultScrollControllerSet = Map<String, ScrollController>;

extension DefaultScrollControllerExt on DefaultScrollControllerSet {
  ScrollController? get(String path) {
    return containsKey(path) ? this[path] : null;
  }
}

/// Associates a [ScrollController] with a subtree.
class DefaultScrollController extends InheritedWidget {
  /// Creates a widget that associates a [ScrollController] with a subtree.
  const DefaultScrollController({
    super.key,
    required DefaultScrollControllerSet this.controllers,
    required super.child,
  });

  /// Creates a subtree without an associated [ScrollController].
  const DefaultScrollController.none({super.key, required super.child})
    : controllers = null;

  /// The [ScrollController] associated with the subtree.
  ///
  /// See also:
  ///
  ///  * [ScrollView.controller], which discusses the purpose of specifying a
  ///    scroll controller.
  final DefaultScrollControllerSet? controllers;

  /// Returns true if this DefaultScrollController is configured to be
  /// automatically inherited.
  static bool shouldInherit(BuildContext context, Axis scrollDirection) {
    final DefaultScrollController? result =
        context.findAncestorWidgetOfExactType<DefaultScrollController>();
    if (result == null) {
      return false;
    }

    return true;
  }

  /// Returns the [ScrollController] most closely associated with the given
  /// context.
  ///
  /// Returns null if there is no [ScrollController] associated with the given
  /// context.
  ///
  /// Calling this method will create a dependency on the closest
  /// [DefaultScrollController] in the [context], if there is one.
  ///
  /// See also:
  ///
  /// * [DefaultScrollController.of], which is similar to this method, but
  ///   asserts if no [DefaultScrollController] ancestor is found.
  static ScrollController? maybeOf(BuildContext context, String path) {
    final DefaultScrollController? result =
        context.dependOnInheritedWidgetOfExactType<DefaultScrollController>();
    return result?.controllers?.get(path);
  }

  /// Returns the [ScrollController] most closely associated with the given
  /// context.
  ///
  /// If no ancestor is found, this method will assert in debug mode, and throw
  /// an exception in release mode.
  ///
  /// Calling this method will create a dependency on the closest
  /// [DefaultScrollController] in the [context].
  ///
  /// See also:
  ///
  /// * [DefaultScrollController.maybeOf], which is similar to this method, but
  ///   returns null if no [DefaultScrollController] ancestor is found.
  static ScrollController of(BuildContext context, String path) {
    final ScrollController? controller = maybeOf(context, path);
    assert(() {
      if (controller == null) {
        throw FlutterError(
          'DefaultScrollController.of() was called with a context that does not contain a '
          'DefaultScrollController widget.\n'
          'No DefaultScrollController widget ancestor could be found starting from the '
          'context that was passed to DefaultScrollController.of(). This can happen '
          'because you are using a widget that looks for a DefaultScrollController '
          'ancestor, but no such ancestor exists.\n'
          'The context used was:\n'
          '  $context',
        );
      }
      return true;
    }());
    return controller!;
  }

  @override
  bool updateShouldNotify(DefaultScrollController oldWidget) =>
      controllers != oldWidget.controllers;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      DiagnosticsProperty<DefaultScrollControllerSet>(
        'controllers',
        controllers,
        ifNull: 'no controllers',
        showName: false,
      ),
    );
  }
}
