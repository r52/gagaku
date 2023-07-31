import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/reader/main.dart';
import 'package:gagaku/reader/types.dart';
import 'package:gagaku/ui.dart';
import 'package:gagaku/web/model.dart';
import 'package:gagaku/web/types.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'reader.g.dart';

Route createWebSourceReaderRoute(
  String src, {
  String? title,
  WebManga? manga,
  Widget? link,
  VoidCallback? onLinkPressed,
}) {
  return Styles.buildSlideTransitionRoute(
    (context, animation, secondaryAnimation) => WebSourceReaderWidget(
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
  final api = ref.watch(proxyProvider);
  final pages = await api.getChapter(code);

  return pages
      .map((e) => ReaderPage(
            provider: ExtendedNetworkImageProvider(e),
          ))
      .toList();
}

class WebSourceReaderWidget extends ConsumerWidget {
  const WebSourceReaderWidget({
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

    final pages = ref.watch(_getPagesProvider(source));

    switch (pages) {
      case AsyncValue(:final error?, :final stackTrace?):
        final messenger = ScaffoldMessenger.of(context);
        Styles.showErrorSnackBar(messenger, '$error');
        logger.e("_getPagesProvider($source) failed",
            error: error, stackTrace: stackTrace);

        return Scaffold(
          appBar: AppBar(
            leading: const BackButton(),
          ),
          body: Styles.errorColumn(error, stackTrace),
        );
      case AsyncValue(:final value?):
        return ReaderWidget(
          pages: value,
          pageCount: value.length,
          title: name,
          isLongStrip: false, // TODO longstrip
          link: link,
          onLinkPressed: onLinkPressed,
        );
      case _:
        return const Center(
          child: CircularProgressIndicator(),
        );
    }
  }
}
