import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/mangadex/model.dart';
import 'package:gagaku/model.dart';
import 'package:gagaku/util/ui.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
            onPressed: () async {
              context.push(GagakuRoute.login);
            },
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

class MangaDexLoginScreen extends HookConsumerWidget {
  const MangaDexLoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storage = Hive.box(gagakuBox);
    final user = storage.get('username') as String?;
    final clientId = storage.get('clientId') as String?;
    final clientSecret = storage.get('clientSecret') as String?;

    final usernameController = useTextEditingController(text: user);
    final passwordController = useTextEditingController();
    final clientIdController = useTextEditingController(text: clientId);
    final clientSecretController = useTextEditingController(text: clientSecret);
    final pendingLogin = useState<Future<bool>?>(null);
    final snapshot = useFuture(pendingLogin.value);

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text('mangadex.login'.tr(context: context)),
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
                        decoration: InputDecoration(
                          filled: true,
                          labelText: 'auth.username'.tr(context: context),
                        ),
                        autofillHints: const [AutofillHints.username],
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (String? value) {
                          return (value == null || value.isEmpty)
                              ? 'auth.usernameEmptyWarning'.tr(context: context)
                              : null;
                        },
                      ),
                      const SizedBox(height: 12.0),
                      TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          filled: true,
                          labelText: 'auth.password'.tr(context: context),
                        ),
                        obscureText: true,
                        autofillHints: const [AutofillHints.password],
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (String? value) {
                          return (value == null || value.isEmpty)
                              ? 'auth.passwordEmptyWarning'.tr(context: context)
                              : null;
                        },
                      ),
                      const SizedBox(height: 12.0),
                      TextFormField(
                        controller: clientIdController,
                        decoration: InputDecoration(
                          filled: true,
                          labelText: 'auth.clientId'.tr(context: context),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (String? value) {
                          return (value == null || value.isEmpty)
                              ? 'auth.clientIdEmptyWarning'.tr(context: context)
                              : null;
                        },
                      ),
                      const SizedBox(height: 12.0),
                      TextFormField(
                        controller: clientSecretController,
                        decoration: InputDecoration(
                          filled: true,
                          labelText: 'auth.clientSecret'.tr(context: context),
                        ),
                        obscureText: true,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (String? value) {
                          return (value == null || value.isEmpty)
                              ? 'auth.clientSecretEmptyWarning'.tr(context: context)
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
                        child: Text('ui.cancel'.tr(context: context)),
                        onPressed: () {
                          passwordController.clear();
                          context.pop();
                        },
                      ),
                      HookBuilder(
                        builder: (context) {
                          final usernameIsEmpty =
                              useListenableSelector(usernameController, () => usernameController.text.isEmpty);
                          final passwordIsEmpty =
                              useListenableSelector(passwordController, () => passwordController.text.isEmpty);
                          final clientIdIsEmpty =
                              useListenableSelector(clientIdController, () => clientIdController.text.isEmpty);
                          final clientSecretIsEmpty =
                              useListenableSelector(clientSecretController, () => clientSecretController.text.isEmpty);

                          return ElevatedButton(
                            onPressed: (usernameIsEmpty || passwordIsEmpty || clientIdIsEmpty || clientSecretIsEmpty)
                                ? null
                                : () async {
                                    final router = GoRouter.of(context);
                                    final messenger = ScaffoldMessenger.of(context);

                                    if (usernameController.text.isNotEmpty &&
                                        passwordController.text.isNotEmpty &&
                                        clientIdController.text.isNotEmpty &&
                                        clientSecretController.text.isNotEmpty) {
                                      final loginSuccess = ref.read(authControlProvider.notifier).login(
                                          usernameController.text,
                                          passwordController.text,
                                          clientIdController.text,
                                          clientSecretController.text);

                                      loginSuccess.then((success) {
                                        if (!context.mounted) return;
                                        if (success) {
                                          router.pop();
                                          passwordController.clear();
                                        } else {
                                          messenger
                                            ..removeCurrentSnackBar()
                                            ..showSnackBar(
                                              SnackBar(
                                                content: Text('errors.loginFail'.tr(context: context)),
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
                                          SnackBar(
                                            content: Text('auth.fieldsEmptyWarning'.tr(context: context)),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                    }
                                  },
                            child: Text('auth.login'.tr(context: context)),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (snapshot.connectionState == ConnectionState.waiting) ...Styles.loadingOverlay
        ],
      ),
    );
  }
}
