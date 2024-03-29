import 'package:animations/animations.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/util.dart';

class MouseTouchScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad
      };
}

class ButtonChip extends StatelessWidget {
  const ButtonChip({
    super.key,
    this.icon,
    required this.text,
    this.color,
    this.onPressed,
  });

  final Widget? icon;
  final Widget text;
  final Color? color;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final style = ElevatedButton.styleFrom(
      backgroundColor: color ?? theme.colorScheme.tertiaryContainer,
      textStyle:
          theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.normal),
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(6.0)),
      ),
    );

    final btn = icon != null
        ? ElevatedButton.icon(
            style: style,
            onPressed: onPressed,
            icon: icon!,
            label: text,
          )
        : ElevatedButton(
            style: style,
            onPressed: onPressed,
            child: text,
          );

    return btn;
  }
}

class IconTextChip extends HookWidget {
  const IconTextChip({
    super.key,
    this.icon,
    required this.text,
    this.color,
    this.onPressed,
  });

  final Widget? icon;
  final Widget text;
  final Color? color;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bgColor = color ?? theme.colorScheme.tertiaryContainer;
    final hoverColor = theme.colorScheme.primary.withOpacity(0.08);
    final hover = useState(false);

    Widget chip = UnconstrainedBox(
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: const BorderRadius.all(Radius.circular(6.0)),
        ),
        foregroundDecoration:
            hover.value ? BoxDecoration(color: hoverColor) : null,
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

    if (onPressed != null) {
      chip = InkWell(
        onTap: onPressed,
        onHover: (value) => hover.value = value,
        child: chip,
      );
    }

    return chip;
  }
}

class TriStateChip extends StatelessWidget {
  const TriStateChip({
    super.key,
    required this.label,
    this.labelStyle,
    this.labelPadding,
    required this.value,
    required this.onChanged,
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
  })  : assert(onChanged != null),
        assert(elevation == null || elevation >= 0.0);

  final Widget label;
  final TextStyle? labelStyle;
  final EdgeInsetsGeometry? labelPadding;
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

  BorderSide? _getBorder(Set<MaterialState> states) {
    if (selectedColor == null) {
      return null;
    }

    if (value == false) {
      return BorderSide(color: selectedColor!);
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));

    Widget? avatar;
    bool selected = false;

    switch (value) {
      case null:
        break;
      case true:
        selected = true;
        break;
      case false:
        avatar = const Icon(Icons.remove);
        selected = false;
        break;
    }

    return RawChip(
      avatar: avatar,
      label: label,
      onPressed: _onPressed,
      labelStyle: labelStyle,
      selectedColor: selectedColor,
      side: MaterialStateBorderSide.resolveWith(_getBorder),
      shape: shape,
      clipBehavior: clipBehavior,
      focusNode: focusNode,
      autofocus: autofocus,
      padding: padding,
      visualDensity: visualDensity,
      labelPadding: labelPadding,
      isEnabled: true,
      selected: selected,
      backgroundColor: backgroundColor,
      materialTapTargetSize: materialTapTargetSize,
      elevation: elevation,
      shadowColor: shadowColor,
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
  static const List<Widget> loadingOverlay = [
    Opacity(
      opacity: 0.75,
      child: ModalBarrier(dismissible: false, color: Colors.black),
    ),
    Center(
      child: CircularProgressIndicator(),
    ),
  ];

  static const listSpinner = Padding(
    padding: EdgeInsets.symmetric(vertical: 5.0),
    child: Center(
      child: CircularProgressIndicator(),
    ),
  );

  static Widget errorColumn(Object err, StackTrace stack) => Center(
        child: Column(
          children: [
            Text('Error: $err'),
            Text(stack.toString()),
          ],
        ),
      );

  static Widget errorList(Object err, StackTrace stack) => Center(
        child: ScrollConfiguration(
          behavior: MouseTouchScrollBehavior(),
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              Text('Error: $err'),
              Text(stack.toString()),
            ],
          ),
        ),
      );

  static Widget titleFlexBar({
    required BuildContext context,
    required String title,
  }) =>
      FlexibleSpaceBar(
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            shadows: <Shadow>[
              Shadow(
                offset: Offset(2.0, 2.0),
                blurRadius: 1.0,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ],
          ),
        ),
        background: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
        ),
      );

  static void showErrorSnackBar(ScaffoldMessengerState state, String content) {
    Future.delayed(
      Duration.zero,
      () => state
        ..removeCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(content),
            backgroundColor: Colors.red,
          ),
        ),
    );
  }

  static Widget slideTransitionBuilder(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    const begin = Offset(0.0, 1.0);
    const end = Offset.zero;
    const curve = Curves.ease;

    final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  }

  static Widget scaledSharedAxisTransitionBuilder(
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child) =>
      SharedAxisTransition(
        fillColor: Theme.of(context).cardColor,
        animation: animation,
        secondaryAnimation: secondaryAnimation,
        transitionType: SharedAxisTransitionType.scaled,
        child: child,
      );

  static Widget horizontalSharedAxisTransitionBuilder(
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child) =>
      SharedAxisTransition(
        fillColor: Theme.of(context).cardColor,
        animation: animation,
        secondaryAnimation: secondaryAnimation,
        transitionType: SharedAxisTransitionType.horizontal,
        child: child,
      );

  static Route<T> buildSlideTransitionRoute<T>(RoutePageBuilder builder) {
    return PageRouteBuilder<T>(
      pageBuilder: builder,
      transitionsBuilder: slideTransitionBuilder,
    );
  }

  static Route<T> buildSharedAxisTransitionRoute<T>(
      RoutePageBuilder builder, SharedAxisTransitionType transitionType) {
    return PageRouteBuilder<T>(
      pageBuilder: builder,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SharedAxisTransition(
          fillColor: Theme.of(context).cardColor,
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          transitionType: transitionType,
          child: child,
        );
      },
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
        child: const Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Icon(Icons.error),
            Text(
              "Image load failed",
              textAlign: TextAlign.center,
            ),
          ],
        ),
        // onTap: () {
        //   state.reLoadImage();
        // },
      );
  }
}
