import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/mangadex/model.dart';
import 'package:gagaku/model.dart';
import 'package:gagaku/ui.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
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
  const MangaDexLoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usernameController = useTextEditingController();
    final passwordController = useTextEditingController();
    final clientIdController = useTextEditingController();
    final clientSecretController = useTextEditingController();
    final usernameIsEmpty = useListenableSelector(
        usernameController, () => usernameController.text.isEmpty);
    final passwordIsEmpty = useListenableSelector(
        passwordController, () => passwordController.text.isEmpty);
    final clientIdIsEmpty = useListenableSelector(
        clientIdController, () => clientIdController.text.isEmpty);
    final clientSecretIsEmpty = useListenableSelector(
        clientSecretController, () => clientSecretController.text.isEmpty);
    final pendingLogin = useState<Future<bool>?>(null);
    final snapshot = useFuture(pendingLogin.value);

    final storage = Hive.box(gagakuBox);
    final user = storage.get('username') as String?;
    final clientId = storage.get('clientId') as String?;
    final clientSecret = storage.get('clientSecret') as String?;

    usernameController.text = user ?? '';
    clientIdController.text = clientId ?? '';
    clientSecretController.text = clientSecret ?? '';

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Login to MangaDex'),
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
                      const SizedBox(height: 12.0),
                      TextFormField(
                        controller: clientIdController,
                        decoration: const InputDecoration(
                          filled: true,
                          labelText: 'Client ID',
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (String? value) {
                          return (value == null || value.isEmpty)
                              ? 'Client ID cannot be empty.'
                              : null;
                        },
                      ),
                      const SizedBox(height: 12.0),
                      TextFormField(
                        controller: clientSecretController,
                        decoration: const InputDecoration(
                          filled: true,
                          labelText: 'Client Secret',
                        ),
                        obscureText: true,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (String? value) {
                          return (value == null || value.isEmpty)
                              ? 'Client Secret cannot be empty.'
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
                        passwordController.clear();
                        context.pop();
                      },
                    ),
                    ElevatedButton(
                      onPressed: (usernameIsEmpty ||
                              passwordIsEmpty ||
                              clientIdIsEmpty ||
                              clientSecretIsEmpty)
                          ? null
                          : () async {
                              final router = GoRouter.of(context);
                              final messenger = ScaffoldMessenger.of(context);

                              if (usernameController.text.isNotEmpty &&
                                  passwordController.text.isNotEmpty &&
                                  clientIdController.text.isNotEmpty &&
                                  clientSecretController.text.isNotEmpty) {
                                final loginSuccess = ref
                                    .read(authControlProvider.notifier)
                                    .login(
                                        usernameController.text,
                                        passwordController.text,
                                        clientIdController.text,
                                        clientSecretController.text);

                                loginSuccess.then((success) {
                                  if (success) {
                                    router.pop();
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
                                });

                                pendingLogin.value = loginSuccess;
                              } else {
                                messenger
                                  ..removeCurrentSnackBar()
                                  ..showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Username/Password/Client ID/Client Secret cannot be empty.'),
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
          if (snapshot.connectionState == ConnectionState.waiting)
            ...Styles.loadingOverlay
        ],
      ),
    );
  }
}
