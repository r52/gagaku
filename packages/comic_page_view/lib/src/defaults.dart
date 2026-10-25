import 'package:material_ui/material_ui.dart';

/// Default placeholder shown while a page image loads.
class ComicDefaultLoading extends StatelessWidget {
  const ComicDefaultLoading({super.key, this.event});

  final ImageChunkEvent? event;

  @override
  Widget build(BuildContext context) {
    final expected = event?.expectedTotalBytes;
    final loaded = event?.cumulativeBytesLoaded;

    return Center(
      child: SizedBox.square(
        dimension: 20,
        child: CircularProgressIndicator(
          value: expected != null && loaded != null ? loaded / expected : null,
        ),
      ),
    );
  }
}

/// Default placeholder shown when a page image fails to load.
class ComicDefaultError extends StatelessWidget {
  const ComicDefaultError({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Icon(Icons.broken_image, color: Colors.grey[400], size: 40),
    );
  }
}
