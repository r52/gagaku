import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/model/config.dart';
import 'package:gagaku/local/model/model.dart';
import 'package:gagaku/util/ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

typedef LibraryItemTapCallback = void Function(LocalLibraryItem);

class LibraryListWidget extends ConsumerWidget {
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
    final gridExtent = ref.watch(
      gagakuSettingsProvider.select((c) => c.gridAlbumExtent),
    );
    return CustomScrollView(
      scrollBehavior: const MouseTouchScrollBehavior(),
      physics: physics,
      slivers: [
        ...leading,
        SliverAppBar(
          pinned: true,
          leading: (item.parent != null && onTap != null)
              ? BackButton(
                  onPressed: () {
                    onTap!(item.parent!);
                  },
                )
              : const SizedBox.shrink(),
          title: title,
          actions: [
            const GridExtentSlider(),
            Consumer(
              builder: (context, ref, child) {
                final theme = Theme.of(context);
                final initial = ref.watch(librarySortTypeProvider);

                return DropdownMenu<LibrarySort>(
                  initialSelection: initial,
                  width: 200.0,
                  enableFilter: false,
                  enableSearch: false,
                  requestFocusOnTap: false,
                  inputDecorationTheme: InputDecorationTheme(
                    filled: true,
                    fillColor: theme.colorScheme.surface.withAlpha(200),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 2.0,
                        color: theme.colorScheme.inversePrimary,
                      ),
                    ),
                  ),
                  onSelected: (LibrarySort? sort) async {
                    if (sort != null) {
                      ref.read(librarySortTypeProvider.notifier).state = sort;
                    }
                  },
                  dropdownMenuEntries:
                      List<DropdownMenuEntry<LibrarySort>>.generate(
                        LibrarySort.values.length,
                        (int index) => DropdownMenuEntry<LibrarySort>(
                          value: LibrarySort.values[index],
                          label: context.t[LibrarySort.values[index].label],
                        ),
                      ),
                );
              },
            ),
          ],
        ),
        SliverGrid.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: gridExtent.grid,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 0.7,
          ),
          findChildIndexCallback: (key) {
            final valueKey = key as ValueKey<int>;
            final val = item.children.indexWhere((i) => i.id == valueKey.value);
            return val >= 0 ? val : null;
          },
          itemBuilder: (context, index) {
            final i = item.children[index];
            return _GridLibraryItem(key: ValueKey(i.id), item: i, onTap: onTap);
          },
          itemCount: item.children.length,
        ),
      ],
    );
  }
}

class _GridLibraryItem extends HookWidget {
  const _GridLibraryItem({super.key, required this.item, this.onTap});

  final LocalLibraryItem item;
  final LibraryItemTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive();
    final aniController = useAnimationController(
      duration: const Duration(milliseconds: 100),
    );
    final gradient = useAnimation(
      aniController.drive(Styles.coverArtGradientTween),
    );

    final image = GridAlbumImage(
      gradient: gradient,
      child: item.thumbnail != null
          ? Image.file(File(item.thumbnail!), width: 256.0, fit: BoxFit.cover)
          : Icon(item.isReadable ? Icons.menu_book : Icons.folder, size: 128.0),
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
          footer: GridAlbumTextBar(height: 80, text: item.name ?? item.path),
          child: image,
        ),
      ),
    );
  }
}
