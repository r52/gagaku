import 'package:extended_image/extended_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gagaku/util.dart';

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

    return UnconstrainedBox(
      child: Container(
        decoration: BoxDecoration(
          color: color ?? theme.canvasColor,
          borderRadius: BorderRadius.circular(6),
        ),
        padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 6.0),
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[icon!, const SizedBox(width: 5)],
            text,
          ],
        ),
      ),
    );
  }
}

class SettingCardWidget extends StatelessWidget {
  const SettingCardWidget(
      {super.key, required this.title, this.subtitle, required this.builder});

  final Widget title;
  final Widget? subtitle;
  final Widget Function(BuildContext context) builder;

  @override
  Widget build(BuildContext context) {
    final bool screenSizeSmall = DeviceContext.screenWidthSmall(context);

    if (screenSizeSmall) {
      return ExpansionTile(
        title: title,
        subtitle: subtitle,
        children: [
          Container(
            color: Theme.of(context).cardColor,
            child: Center(
              child: builder(context),
            ),
          )
        ],
      );
    }

    return Card(
      margin: const EdgeInsets.all(6),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  title,
                  SizedBox(
                    height: (subtitle != null ? 10 : 0),
                  ),
                  subtitle ?? const SizedBox(),
                ],
              ),
            ),
            Expanded(child: builder(context))
          ],
        ),
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

  static Route<T> buildSlideTransitionRoute<T>(RoutePageBuilder builder) {
    return PageRouteBuilder<T>(
      pageBuilder: builder,
      transitionsBuilder: slideTransitionBuilder,
    );
  }
}

Widget? extendedImageLoadStateHandler(ExtendedImageState state) {
  switch (state.extendedImageLoadState) {
    case LoadState.loading:
      return const Center(
        child: CircularProgressIndicator(),
      );
    case LoadState.completed:
      return null;
    case LoadState.failed:
      return GestureDetector(
        child: Stack(
          fit: StackFit.expand,
          children: const <Widget>[
            Icon(Icons.error),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Text(
                "Image load failed",
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
        // onTap: () {
        //   state.reLoadImage();
        // },
      );
  }
}
