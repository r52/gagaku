import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/mangadex/model.dart';
import 'package:gagaku/model.dart';
import 'package:gagaku/ui.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MangaDexLoginWidget extends ConsumerWidget {
  const MangaDexLoginWidget({required this.builder, super.key});

  final Widget Function(BuildContext context, WidgetRef ref) builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authControlProvider);

    switch (auth) {
      case AsyncData(value: final loggedin):
        if (loggedin) {
          return builder(context, ref);
        }

        return Center(
          child: ElevatedButton.icon(
            onPressed: () async {
              context.push(GagakuRoute.login);
            },
            label: const Text('Login to MangaDex'),
            icon: const Icon(
              Icons.https,
            ),
          ),
        );
      case AsyncError(:final error, :final stackTrace):
        logger.e("authControlProvider failed",
            error: error, stackTrace: stackTrace);
        return Styles.errorColumn(error, stackTrace);
      case _:
        return const Center(
          child: CircularProgressIndicator(),
        );
    }
  }
}

class MangaDexLoginScreen extends HookConsumerWidget {
  const MangaDexLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usernameController = useTextEditingController();
    final passwordController = useTextEditingController();
    final usernameIsEmpty = useListenableSelector(
        usernameController, () => usernameController.text.isEmpty);
    final passwordIsEmpty = useListenableSelector(
        passwordController, () => passwordController.text.isEmpty);

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Login to MangaDex'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            const SizedBox(height: 200.0),
            AutofillGroup(
              child: Column(
                children: [
                  TextFormField(
                    controller: usernameController,
                    decoration: const InputDecoration(
                      filled: true,
                      labelText: 'Username',
                    ),
                    autofillHints: const [AutofillHints.username],
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (String? value) {
                      return (value == null || value.isEmpty)
                          ? 'Username cannot be empty.'
                          : null;
                    },
                  ),
                  const SizedBox(height: 12.0),
                  TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      filled: true,
                      labelText: 'Password',
                    ),
                    obscureText: true,
                    autofillHints: const [AutofillHints.password],
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (String? value) {
                      return (value == null || value.isEmpty)
                          ? 'Password cannot be empty.'
                          : null;
                    },
                  ),
                ],
              ),
            ),
            ButtonBar(
              children: <Widget>[
                TextButton(
                  child: const Text('CANCEL'),
                  onPressed: () {
                    usernameController.clear();
                    passwordController.clear();
                    context.pop();
                  },
                ),
                ElevatedButton(
                  onPressed: (usernameIsEmpty || passwordIsEmpty)
                      ? null
                      : () async {
                          final router = GoRouter.of(context);
                          final messenger = ScaffoldMessenger.of(context);

                          if (usernameController.text.isNotEmpty &&
                              passwordController.text.isNotEmpty) {
                            var loginSuccess = await ref
                                .read(authControlProvider.notifier)
                                .login(usernameController.text,
                                    passwordController.text);

                            if (loginSuccess) {
                              router.pop();
                              usernameController.clear();
                              passwordController.clear();
                            } else {
                              messenger
                                ..removeCurrentSnackBar()
                                ..showSnackBar(
                                  const SnackBar(
                                    content: Text('Failed to login.'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                            }
                          } else {
                            messenger
                              ..removeCurrentSnackBar()
                              ..showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Username and Password cannot be empty.'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                          }
                        },
                  child: const Text('LOGIN'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
