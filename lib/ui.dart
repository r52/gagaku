import 'package:animations/animations.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gagaku/config.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/util.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MouseTouchScrollBehavior extends MaterialScrollBehavior {
  const MouseTouchScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
      };
}

class GridExtentSlider extends ConsumerWidget {
  const GridExtentSlider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cfg = ref.watch(gagakuSettingsProvider);
    return MenuAnchor(
      menuChildren: <Widget>[
        Slider(
          value: cfg.gridAlbumExtent.index.toDouble(),
          max: 3,
          divisions: 3,
          label: cfg.gridAlbumExtent.name.capitalize(),
          onChanged: (double value) {
            final c = cfg.copyWith(gridAlbumExtent: GridAlbumExtent.values.elementAt(value.toInt()));
            ref.read(gagakuSettingsProvider.notifier).save(c);
          },
        ),
      ],
      builder: (_, MenuController controller, Widget? child) {
        return IconButton(
          tooltip: 'Grid Size',
          onPressed: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          icon: const Icon(Icons.width_normal),
        );
      },
    );
  }
}

class GridAlbumImage extends StatelessWidget {
  const GridAlbumImage({
    super.key,
    required this.gradient,
    required this.child,
  });

  final AlignmentGeometry gradient;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4.0))),
      clipBehavior: Clip.antiAlias,
      child: ShaderMask(
        shaderCallback: (rect) {
          return LinearGradient(
            begin: gradient,
            end: Alignment.bottomCenter,
            colors: const [Colors.black, Colors.transparent],
          ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
        },
        blendMode: BlendMode.dstIn,
        child: child,
      ),
    );
  }
}

class GridAlbumTextBar extends StatelessWidget {
  const GridAlbumTextBar({
    super.key,
    required this.height,
    this.leading,
    this.backgroundColor,
    required this.text,
    this.bottom = true,
  });

  final double height;
  final Widget? leading;
  final Color? backgroundColor;
  final String text;
  final bool bottom;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Material(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: !bottom ? const Radius.circular(4) : Radius.zero,
            bottom: bottom ? const Radius.circular(4) : Radius.zero,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: GridTileBar(
          leading: leading,
          backgroundColor: backgroundColor,
          title: Text(
            text,
            softWrap: true,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              overflow: TextOverflow.fade,
            ),
          ),
        ),
      ),
    );
  }
}

class KeepAliveImage extends Image {
  const KeepAliveImage({
    super.key,
    required super.image,
    super.frameBuilder,
    super.loadingBuilder,
    super.errorBuilder,
    super.semanticLabel,
    super.excludeFromSemantics = false,
    super.width,
    super.height,
    super.color,
    super.opacity,
    super.colorBlendMode,
    super.fit,
    super.alignment = Alignment.center,
    super.repeat = ImageRepeat.noRepeat,
    super.centerSlice,
    super.matchTextDirection = false,
    super.gaplessPlayback = false,
    super.isAntiAlias = false,
    super.filterQuality = FilterQuality.medium,
  });

  @override
  State<KeepAliveImage> createState() => _KeepAliveImageState();
}

class _KeepAliveImageState extends State<KeepAliveImage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Image(
      image: widget.image,
      frameBuilder: widget.frameBuilder,
      loadingBuilder: widget.loadingBuilder,
      errorBuilder: widget.errorBuilder,
      semanticLabel: widget.semanticLabel,
      excludeFromSemantics: widget.excludeFromSemantics,
      width: widget.width,
      height: widget.height,
      color: widget.color,
      opacity: widget.opacity,
      colorBlendMode: widget.colorBlendMode,
      fit: widget.fit,
      alignment: widget.alignment,
      repeat: widget.repeat,
      centerSlice: widget.centerSlice,
      matchTextDirection: widget.matchTextDirection,
      gaplessPlayback: widget.gaplessPlayback,
      isAntiAlias: widget.isAntiAlias,
      filterQuality: widget.filterQuality,
    );
  }
}

class MultiChildExpansionTile extends StatelessWidget {
  const MultiChildExpansionTile({
    super.key,
    required this.title,
    this.children = const <Widget>[],
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      expandedAlignment: Alignment.centerLeft,
      title: Text(title),
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Wrap(
            spacing: 4.0,
            runSpacing: 4.0,
            children: children,
          ),
        ),
      ],
    );
  }
}

class CountryFlag extends StatelessWidget {
  const CountryFlag({super.key, required this.flag, this.size = 18});

  final String flag;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Text(
      flag,
      style: TextStyle(
        fontFamily: 'Twemoji',
        fontSize: size,
      ),
    );
  }
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

    final style = Styles.buttonStyle(
      backgroundColor: color ?? theme.colorScheme.tertiaryContainer,
      textStyle: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.normal),
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
    );

    return (icon != null)
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
  }
}

class IconTextChip extends StatelessWidget {
  const IconTextChip({
    super.key,
    this.icon,
    required this.text,
    this.style,
    this.color,
    this.onPressed,
  });

  final Widget? icon;
  final String text;
  final TextStyle? style;
  final Color? color;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final child = Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 6.0),
      child: Text.rich(
        style: style,
        overflow: TextOverflow.ellipsis,
        TextSpan(
          children: [
            if (icon != null) WidgetSpan(alignment: PlaceholderAlignment.middle, child: icon!),
            TextSpan(text: '${icon != null ? ' ' : ''}$text'),
          ],
        ),
      ),
    );

    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 24.0),
      child: Material(
        borderRadius: const BorderRadius.all(Radius.circular(6.0)),
        color: color ?? theme.colorScheme.tertiaryContainer,
        child: (onPressed != null)
            ? InkWell(
                onTap: onPressed,
                child: child,
              )
            : child,
      ),
    );
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

  BorderSide? _getBorder(Set<WidgetState> states) {
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
      side: WidgetStateBorderSide.resolveWith(_getBorder),
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
  const SettingCardWidget({
    super.key,
    required this.title,
    this.subtitle,
    required this.builder,
  });

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
          ColoredBox(
            color: Theme.of(context).cardColor,
            child: Center(
              child: builder(context),
            ),
          )
        ],
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
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

class TitleFlexBar extends StatelessWidget {
  const TitleFlexBar({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          shadows: <Shadow>[
            Shadow(
              offset: Offset(1.5, 1.5),
              blurRadius: 0.5,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ],
        ),
      ),
      background: ColoredBox(color: Theme.of(context).colorScheme.primaryContainer),
    );
  }
}

class ErrorColumn extends StatelessWidget {
  final Object error;
  final StackTrace stackTrace;
  final String message;

  const ErrorColumn({
    super.key,
    required this.error,
    required this.stackTrace,
    String? message,
  }) : message = message ?? "Build error";

  @override
  Widget build(BuildContext context) {
    final messenger = ScaffoldMessenger.of(context);
    Styles.showErrorSnackBar(messenger, '$error');
    logger.e(message, error: error, stackTrace: stackTrace);

    return Center(
      child: Column(
        children: [
          Text('$error'),
          Text(stackTrace.toString()),
        ],
      ),
    );
  }
}

class ErrorList extends StatelessWidget {
  final Object error;
  final StackTrace stackTrace;
  final String message;

  const ErrorList({super.key, required this.error, required this.stackTrace, String? message})
      : message = message ?? "Build error";

  @override
  Widget build(BuildContext context) {
    final messenger = ScaffoldMessenger.of(context);
    Styles.showErrorSnackBar(messenger, '$error');
    logger.e(message, error: error, stackTrace: stackTrace);

    return Center(
      child: ScrollConfiguration(
        behavior: const MouseTouchScrollBehavior(),
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            Text('$error'),
            Text(stackTrace.toString()),
          ],
        ),
      ),
    );
  }
}

class LoadingOverlayStack extends StatelessWidget {
  const LoadingOverlayStack({
    super.key,
    this.progress,
  });

  final double? progress;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const ModalBarrier(dismissible: false, color: Colors.black87),
        Center(
          child: CircularProgressIndicator(
            value: progress,
          ),
        )
      ],
    );
  }
}

class ListSpinner extends StatelessWidget {
  const ListSpinner({
    super.key,
    this.progress,
  });

  final double? progress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Center(
        child: CircularProgressIndicator(
          value: progress,
        ),
      ),
    );
  }
}

class Styles {
  static ButtonStyle buttonStyle({
    Color? backgroundColor,
    TextStyle? textStyle,
    EdgeInsetsGeometry? padding,
  }) =>
      ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        textStyle: textStyle,
        padding: padding,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(6.0)),
        ),
      );

  static final coverArtGradientTween = Tween(begin: Alignment.center, end: Alignment.topCenter);

  static const List<Widget> loadingOverlay = [
    ModalBarrier(dismissible: false, color: Colors.black87),
    Center(
      child: CircularProgressIndicator(),
    ),
  ];

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

  static final slideTween =
      Tween(begin: const Offset(0.0, 1.0), end: Offset.zero).chain(CurveTween(curve: Curves.ease));

  static Widget slideTransitionBuilder(
          BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) =>
      SlideTransition(
        position: animation.drive(slideTween),
        child: child,
      );

  static Widget scaledSharedAxisTransitionBuilder(
          BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) =>
      SharedAxisTransition(
        animation: animation,
        secondaryAnimation: secondaryAnimation,
        transitionType: SharedAxisTransitionType.scaled,
        child: child,
      );

  static Widget horizontalSharedAxisTransitionBuilder(
          BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) =>
      SharedAxisTransition(
        animation: animation,
        secondaryAnimation: secondaryAnimation,
        transitionType: SharedAxisTransitionType.horizontal,
        child: child,
      );

  static Widget fadeThroughTransitionBuilder(
          BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) =>
      FadeThroughTransition(
        animation: animation,
        secondaryAnimation: secondaryAnimation,
        child: child,
      );
}

class SlideTransitionRouteBuilder<T> extends PageRouteBuilder<T> {
  SlideTransitionRouteBuilder({
    required super.pageBuilder,
  }) : super(transitionsBuilder: Styles.slideTransitionBuilder);
}

class TransparentOverlay<T> extends ModalRoute<T> {
  TransparentOverlay({
    required this.builder,
  }) : super();

  final WidgetBuilder builder;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => true;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.5);

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return builder(context);
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}
