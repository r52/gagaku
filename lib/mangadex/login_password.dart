import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/mangadex/model/types.dart' show MangaDexCredentials;
import 'package:gagaku/mangadex/widgets.dart';
import 'package:gagaku/routes.gr.dart';
import 'package:gagaku/mangadex/model/model.dart';
import 'package:gagaku/model/model.dart';
import 'package:gagaku/util/ui.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/experimental/mutation.dart';

class MangaDexLoginWidget extends ConsumerWidget {
  const MangaDexLoginWidget({required this.builder, super.key});

  final Widget Function(BuildContext context) builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tr = context.t;
    final meProvider = ref.watch(loggedUserProvider);

    return switch (meProvider) {
      AsyncValue(:final error?, :final stackTrace?) => Center(
        child: CustomScrollView(
          scrollBehavior: const MouseTouchScrollBehavior(),
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            MangaDexSliverAppBar(),
            SliverFillRemaining(
              child: ErrorList(
                error: error,
                stackTrace: stackTrace,
                message: "loggedUserProvider failed",
              ),
            ),
          ],
        ),
      ),
      AsyncValue(hasValue: true, value: final me) when me != null => builder(
        context,
      ),
      AsyncValue(hasValue: true, value: final me) when me == null => Center(
        child: CustomScrollView(
          scrollBehavior: const MouseTouchScrollBehavior(),
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            MangaDexSliverAppBar(title: tr.mangadex.login),
            SliverFillRemaining(
              child: Center(
                child: ElevatedButton.icon(
                  onPressed: () async {
                    AutoRouter.of(context).push(MangaDexLoginRoute());
                  },
                  label: Text(tr.mangadex.login),
                  icon: const Icon(Icons.https),
                ),
              ),
            ),
          ],
        ),
      ),
      AsyncValue(:final progress) => Center(
        child: CustomScrollView(
          scrollBehavior: const MouseTouchScrollBehavior(),
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            MangaDexSliverAppBar(),
            SliverFillRemaining(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 20.0,
                children: [
                  Text(
                    tr.auth.authenticating,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  CircularProgressIndicator(value: progress?.toDouble()),
                ],
              ),
            ),
          ],
        ),
      ),
    };
  }
}

@RoutePage()
class MangaDexLoginScreen extends HookConsumerWidget {
  const MangaDexLoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tr = context.t;
    var messenger = ScaffoldMessenger.of(context);
    final storage = Hive.box(gagakuLocalBox);

    final credstr = storage.get('mangadex_credentials');
    final creds =
        credstr != null
            ? MangaDexCredentials.fromJson(json.decode(credstr))
            : null;

    final user = creds?.username;
    final clientId = creds?.clientId;
    final clientSecret = creds?.clientSecret;

    final usernameController = useTextEditingController(text: user);
    final passwordController = useTextEditingController();
    final clientIdController = useTextEditingController(text: clientId);
    final clientSecretController = useTextEditingController(text: clientSecret);

    final login = ref.watch(authControlLoginMutation);

    if (login is MutationError) {
      Styles.showSnackBar(
        messenger,
        content: tr.errors.loginFail(
          reason: (login as MutationError).error.toString(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(tr.mangadex.login),
      ),
      body: Stack(
        children: [
          SafeArea(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              children: <Widget>[
                const SizedBox(height: 200.0),
                AutofillGroup(
                  child: Column(
                    spacing: 12.0,
                    children: [
                      TextFormField(
                        controller: usernameController,
                        decoration: InputDecoration(
                          filled: true,
                          labelText: tr.auth.username,
                        ),
                        autofillHints: const [AutofillHints.username],
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (String? value) {
                          return (value == null || value.isEmpty)
                              ? tr.auth.usernameEmptyWarning
                              : null;
                        },
                      ),
                      TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          filled: true,
                          labelText: tr.auth.password,
                        ),
                        obscureText: true,
                        autofillHints: const [AutofillHints.password],
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (String? value) {
                          return (value == null || value.isEmpty)
                              ? tr.auth.passwordEmptyWarning
                              : null;
                        },
                      ),
                      TextFormField(
                        controller: clientIdController,
                        decoration: InputDecoration(
                          filled: true,
                          labelText: tr.auth.clientId,
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (String? value) {
                          return (value == null || value.isEmpty)
                              ? tr.auth.clientIdEmptyWarning
                              : null;
                        },
                      ),
                      TextFormField(
                        controller: clientSecretController,
                        decoration: InputDecoration(
                          filled: true,
                          labelText: tr.auth.clientSecret,
                        ),
                        obscureText: true,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (String? value) {
                          return (value == null || value.isEmpty)
                              ? tr.auth.clientSecretEmptyWarning
                              : null;
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: OverflowBar(
                    alignment: MainAxisAlignment.end,
                    spacing: 8.0,
                    children: <Widget>[
                      TextButton(
                        child: Text(tr.ui.cancel),
                        onPressed: () {
                          passwordController.clear();
                          context.maybePop();
                        },
                      ),
                      HookBuilder(
                        builder: (context) {
                          final usernameIsEmpty = useListenableSelector(
                            usernameController,
                            () => usernameController.text.isEmpty,
                          );
                          final passwordIsEmpty = useListenableSelector(
                            passwordController,
                            () => passwordController.text.isEmpty,
                          );
                          final clientIdIsEmpty = useListenableSelector(
                            clientIdController,
                            () => clientIdController.text.isEmpty,
                          );
                          final clientSecretIsEmpty = useListenableSelector(
                            clientSecretController,
                            () => clientSecretController.text.isEmpty,
                          );

                          return ElevatedButton(
                            onPressed:
                                (usernameIsEmpty ||
                                        passwordIsEmpty ||
                                        clientIdIsEmpty ||
                                        clientSecretIsEmpty ||
                                        login is MutationPending)
                                    ? null
                                    : () async {
                                      final router = AutoRouter.of(context);
                                      final messenger = ScaffoldMessenger.of(
                                        context,
                                      );

                                      if (usernameController.text.isNotEmpty &&
                                          passwordController.text.isNotEmpty &&
                                          clientIdController.text.isNotEmpty &&
                                          clientSecretController
                                              .text
                                              .isNotEmpty) {
                                        final loginSuccess =
                                            authControlLoginMutation.run(ref, (
                                              ref,
                                            ) async {
                                              return await ref
                                                  .get(
                                                    authControlProvider
                                                        .notifier,
                                                  )
                                                  .login(
                                                    usernameController.text,
                                                    passwordController.text,
                                                    clientIdController.text,
                                                    clientSecretController.text,
                                                  );
                                            });

                                        loginSuccess.then((success) {
                                          if (!context.mounted) return;
                                          if (success) {
                                            router.maybePop();
                                            passwordController.clear();
                                          }
                                        });
                                      } else {
                                        messenger
                                          ..removeCurrentSnackBar()
                                          ..showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                tr.auth.fieldsEmptyWarning,
                                              ),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                      }
                                    },
                            child: Text(tr.auth.login),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (login is MutationPending) ...Styles.loadingOverlay,
        ],
      ),
    );
  }
}
