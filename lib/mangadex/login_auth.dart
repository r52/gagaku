import 'package:flutter/material.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/mangadex/model/model.dart';
import 'package:gagaku/util/ui.dart';

class MangaDexLoginWidget extends StatelessWidget {
  const MangaDexLoginWidget({required this.builder, super.key});

  final Widget Function(BuildContext context) builder;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return DataProviderWhenWidget(
      provider: authControlProvider,
      builder: (context, loggedin) {
        if (loggedin) {
          return builder(context);
        }

        return Center(
          child: ElevatedButton.icon(
            onPressed:
                () => {} /*ref.read(authControlProvider.notifier).login()*/,
            label: Text(t.mangadex.login),
            icon: const Icon(Icons.https),
          ),
        );
      },
      loadingWidget: const Center(child: CircularProgressIndicator()),
    );
  }
}
