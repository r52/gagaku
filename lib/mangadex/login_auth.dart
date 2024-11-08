import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gagaku/mangadex/model.dart';
import 'package:gagaku/util/ui.dart';

class MangaDexLoginWidget extends StatelessWidget {
  const MangaDexLoginWidget({required this.builder, super.key});

  final Widget Function(BuildContext context) builder;

  @override
  Widget build(BuildContext context) {
    return DataProviderWhenWidget(
      provider: authControlProvider,
      builder: (context, loggedin) {
        if (loggedin) {
          return builder(context);
        }

        return Center(
          child: ElevatedButton.icon(
            onPressed: () => {} /*ref.read(authControlProvider.notifier).login()*/,
            label: Text('mangadex.login'.tr(context: context)),
            icon: const Icon(
              Icons.https,
            ),
          ),
        );
      },
      loadingWidget: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
