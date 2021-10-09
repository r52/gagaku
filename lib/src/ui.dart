import 'dart:ui';

import 'package:flutter/material.dart';

class MouseTouchScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class IconTextChip extends StatelessWidget {
  const IconTextChip({
    Key? key,
    this.icon,
    required this.text,
    this.color,
  }) : super(key: key);

  final Widget? icon;
  final Widget text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: color ?? theme.canvasColor,
        borderRadius: BorderRadius.circular(6),
      ),
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 6.0),
      alignment: Alignment.center,
      child: Row(
        children: [
          if (icon != null) ...[icon!, SizedBox(width: 5)],
          text,
        ],
      ),
    );
  }
}

class TriStateChip extends StatelessWidget {
  const TriStateChip(
      {Key? key,
      required this.label,
      this.labelStyle,
      this.labelPadding,
      required this.value,
      required this.onChanged,
      this.side,
      this.shape,
      this.clipBehavior = Clip.none,
      this.focusNode,
      this.autofocus = false,
      this.backgroundColor,
      this.padding,
      this.visualDensity,
      this.materialTapTargetSize,
      this.elevation,
      this.shadowColor,
      this.selectedColor,
      this.unselectedColor})
      : assert(onChanged != null),
        assert(elevation == null || elevation >= 0.0),
        super(key: key);

  final Widget label;
  final TextStyle? labelStyle;
  final EdgeInsetsGeometry? labelPadding;
  final BorderSide? side;
  final OutlinedBorder? shape;
  final Clip clipBehavior;
  final FocusNode? focusNode;
  final bool autofocus;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final VisualDensity? visualDensity;
  final MaterialTapTargetSize? materialTapTargetSize;
  final double? elevation;
  final Color? shadowColor;

  final bool? value;
  final ValueChanged<bool?>? onChanged;
  final Color? selectedColor;
  final Color? unselectedColor;

  void _onPressed() {
    switch (value) {
      case null:
        onChanged!(true);
        break;
      case true:
        onChanged!(false);
        break;
      case false:
        onChanged!(null);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));

    Widget? avatar;
    Color? bgColor = backgroundColor;

    switch (value) {
      case null:
        break;
      case true:
        avatar = Icon(Icons.add);
        bgColor = selectedColor;
        break;
      case false:
        avatar = Icon(Icons.remove);
        bgColor = unselectedColor;
        break;
    }

    return RawChip(
      avatar: avatar,
      label: label,
      onPressed: _onPressed,
      labelStyle: labelStyle,
      backgroundColor: bgColor,
      side: side,
      shape: shape,
      clipBehavior: clipBehavior,
      focusNode: focusNode,
      autofocus: autofocus,
      padding: padding,
      visualDensity: visualDensity,
      labelPadding: labelPadding,
      isEnabled: true,
      materialTapTargetSize: materialTapTargetSize,
      elevation: elevation,
      shadowColor: shadowColor,
    );
  }
}

class Styles {
  static Widget slideTransitionBuilder(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    const begin = Offset(0.0, 1.0);
    const end = Offset.zero;
    const curve = Curves.ease;

    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  }

  static Route<T> buildSlideTransitionRoute<T>(RoutePageBuilder builder) {
    return PageRouteBuilder<T>(
      pageBuilder: builder,
      transitionsBuilder: slideTransitionBuilder,
    );
  }

  static Widget buildCenterSpinner() {
    return const Center(
      child: const CircularProgressIndicator(),
    );
  }
}
