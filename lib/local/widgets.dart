import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gagaku/local/model.dart';
import 'package:gagaku/ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

typedef LibraryItemTapCallback = void Function(LocalLibraryItem);

class LibraryListWidget extends HookConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
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
        SliverGrid.extent(
          maxCrossAxisExtent: 256,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 0.7,
          children: item.children
              .map((item) => _GridLibraryItem(
                    item: item,
                    onTap: onTap,
                  ))
              .toList(),
        ),
      ],
    );
  }
}

class _GridLibraryItem extends StatelessWidget {
  const _GridLibraryItem({required this.item, this.onTap});

  final LocalLibraryItem item;
  final LibraryItemTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final Widget image = Material(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      clipBehavior: Clip.antiAlias,
      child: item.thumbnail != null
          ? Image.file(
              File(item.thumbnail!),
              width: 256.0,
            )
          : Icon(
              item.isReadable ? Icons.menu_book : Icons.folder,
              size: 128.0,
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
        child: GridTile(
          footer: SizedBox(
            height: 60,
            child: Material(
              color: Colors.transparent,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(4)),
              ),
              clipBehavior: Clip.antiAlias,
              child: GridTileBar(
                backgroundColor: Colors.black45,
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