import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/mangadex/model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MangaDexLoginWidget extends ConsumerWidget {
  const MangaDexLoginWidget({required this.builder, super.key});

  final Widget Function(BuildContext context, WidgetRef ref) builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nav = Navigator.of(context);
    final auth = ref.watch(authControlProvider);

    return auth.when(
      data: (loggedIn) {
        if (loggedIn) {
          return builder(context, ref);
        }

        return Center(
          child: ElevatedButton.icon(
            onPressed: () async {
              nav.push(
                MaterialPageRoute(
                  builder: (context) => const MangaDexLoginScreen(),
                ),
              );
            },
            label: const Text('Login to MangaDex'),
            icon: const Icon(
              Icons.https,
            ),
          ),
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (err, stack) => Text('Error: $err'),
    );
  }
}

class MangaDexLoginScreen extends HookConsumerWidget {
  const MangaDexLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nav = Navigator.of(context);
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
                    nav.pop();
                  },
                ),
                ElevatedButton(
                  onPressed: (usernameIsEmpty || passwordIsEmpty)
                      ? null
                      : () async {
                          final messenger = ScaffoldMessenger.of(context);

                          if (usernameController.text.isNotEmpty &&
                              passwordController.text.isNotEmpty) {
                            var loginSuccess = await ref
                                .read(authControlProvider.notifier)
                                .login(usernameController.text,
                                    passwordController.text);

                            if (loginSuccess) {
                              nav.pop();
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
