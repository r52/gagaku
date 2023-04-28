import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:gagaku/reader/main.dart';
import 'package:gagaku/reader/types.dart';
import 'package:gagaku/ui.dart';
import 'package:gagaku/web/model.dart';
import 'package:gagaku/web/types.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'reader.g.dart';

Route createWebGalleryReaderRoute(
  String src, {
  String? title,
  WebManga? manga,
  Widget? link,
  VoidCallback? onLinkPressed,
}) {
  return Styles.buildSlideTransitionRoute(
    (context, animation, secondaryAnimation) => WebGalleryReaderWidget(
      source: src,
      title: title,
      manga: manga,
      link: link,
      onLinkPressed: onLinkPressed,
    ),
  );
}

@riverpod
Future<List<ReaderPage>> _getPages(_GetPagesRef ref, String code) async {
  final pages = await ref.read(getImgurPagesProvider(code).future);

  return pages
      .map((e) => ReaderPage(
            provider: ExtendedNetworkImageProvider(e.src),
          ))
      .toList();
}

class WebGalleryReaderWidget extends ConsumerWidget {
  const WebGalleryReaderWidget({
    super.key,
    required this.source,
    this.title,
    this.manga,
    this.link,
    this.onLinkPressed,
  });

  final String source;
  final String? title;
  final WebManga? manga;
  final Widget? link;
  final VoidCallback? onLinkPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String name = source;

    if (title != null) {
      name = title!;
    }

    final results = ref.watch(_getPagesProvider(source));

    return results.when(
      data: (pages) {
        return ReaderWidget(
          pages: pages,
          pageCount: pages.length,
          title: name,
          isLongStrip: false, // TODO figure this out
          link: link,
          onLinkPressed: onLinkPressed,
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (err, stackTrace) {
        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(SnackBar(
            content: Text('$err'),
            backgroundColor: Colors.red,
          ));

        return Text('Error: $err');
      },
    );
  }
}
