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
        color: (color != null ? color : theme.canvasColor),
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

  static Route buildSlideTransitionRoute(RoutePageBuilder builder) {
    return PageRouteBuilder(
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
