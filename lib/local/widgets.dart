import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/local/model.dart';
import 'package:gagaku/ui.dart';

typedef LibraryItemTapCallback = void Function(LocalLibraryItem);

class LibraryListWidget extends StatelessWidget {
  const LibraryListWidget({
    super.key,
    required this.title,
    required this.item,
    this.leading = const <Widget>[],
    this.physics,
    this.onTap,
  });

  final Widget title;
  final LocalLibraryItem item;
  final List<Widget> leading;
  final ScrollPhysics? physics;
  final LibraryItemTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      scrollBehavior: MouseTouchScrollBehavior(),
      physics: physics,
      slivers: [
        ...leading,
        SliverToBoxAdapter(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
            child: Row(
              children: [
                if (item.parent != null && onTap != null)
                  BackButton(
                    onPressed: () {
                      onTap!(item.parent!);
                    },
                  ),
                const SizedBox(
                  width: 10,
                ),
                title,
              ],
            ),
          ),
        ),
        SliverGrid.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 256,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 0.7,
          ),
          itemBuilder: (context, index) {
            final i = item.children.elementAt(index);
            return _GridLibraryItem(
              item: i,
              onTap: onTap,
            );
          },
          itemCount: item.children.length,
        ),
      ],
    );
  }
}

class _GridLibraryItem extends HookWidget {
  const _GridLibraryItem({required this.item, this.onTap});

  final LocalLibraryItem item;
  final LibraryItemTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final aniController =
        useAnimationController(duration: const Duration(milliseconds: 100));
    final gradient =
        useAnimation(aniController.drive(Styles.coverArtGradientTween));

    final Widget image = Material(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4.0))),
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
        child: item.thumbnail != null
            ? Image.file(
                File(item.thumbnail!),
                width: 256.0,
              )
            : Icon(
                item.isReadable ? Icons.menu_book : Icons.folder,
                size: 128.0,
              ),
      ),
    );

    return Tooltip(
      message: item.path,
      waitDuration: const Duration(milliseconds: 500),
      child: InkWell(
        onTap: () {
          if (onTap != null) {
            onTap!(item);
          }
        },
        onHover: (hovering) {
          if (hovering) {
            aniController.forward();
          } else {
            aniController.reverse();
          }
        },
        child: GridTile(
          footer: SizedBox(
            height: 80,
            child: Material(
              color: Colors.transparent,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(4)),
              ),
              clipBehavior: Clip.antiAlias,
              child: GridTileBar(
                title: Text(
                  item.name ?? item.path,
                  softWrap: true,
                  style: const TextStyle(
                    overflow: TextOverflow.fade,
                  ),
                ),
              ),
            ),
          ),
          child: image,
        ),
      ),
    );
  }
}
