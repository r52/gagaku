import 'package:gagaku/src/mangadex/api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MangaDexLoginWidget extends StatefulWidget {
  const MangaDexLoginWidget({required this.builder, required this.topScaffold});

  final GlobalKey<ScaffoldState> topScaffold;
  final Widget Function(BuildContext context) builder;

  @override
  _MangaDexLoginState createState() => _MangaDexLoginState();
}

typedef AuthenticatedBuilder = Widget Function(
    BuildContext context, MangaDexClient client);

class _MangaDexLoginState extends State<MangaDexLoginWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MangaDexModel>(builder: (context, mdx, child) {
      if (mdx.loggedIn) {
        return widget.builder(context);
      }

      return Scaffold(
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  widget.topScaffold.currentState!.openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
          title: Text('MangaDex'),
        ),
        body: Center(
          child: ElevatedButton.icon(
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MangaDexLoginScreen(),
                ),
              );
            },
            label: const Text('Login to MangaDex'),
            icon: Icon(
              Icons.https,
            ),
          ),
        ),
      );
    });
  }
}

class MangaDexLoginScreen extends StatefulWidget {
  const MangaDexLoginScreen({Key? key}) : super(key: key);

  @override
  _MangaDexLoginScreenState createState() => _MangaDexLoginScreenState();
}

class _MangaDexLoginScreenState extends State<MangaDexLoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            const SizedBox(height: 80.0),
            Column(
              children: <Widget>[
                const SizedBox(height: 32.0),
                const Text('Login to MangaDex'),
              ],
            ),
            const SizedBox(height: 120.0),
            AutofillGroup(
              child: Column(
                children: [
                  TextFormField(
                    controller: _usernameController,
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
                    controller: _passwordController,
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
                    _usernameController.clear();
                    _passwordController.clear();
                    Navigator.pop(context);
                  },
                ),
                ElevatedButton(
                  child: const Text('LOGIN'),
                  onPressed: () async {
                    if (_usernameController.text.isNotEmpty &&
                        _passwordController.text.isNotEmpty) {
                      final loginSuccess = await Provider.of<MangaDexModel>(
                              context,
                              listen: false)
                          .login(_usernameController.text,
                              _passwordController.text);

                      if (loginSuccess) {
                        Navigator.pop(context);
                        _usernameController.clear();
                        _passwordController.clear();
                      } else {
                        ScaffoldMessenger.of(context)
                          ..removeCurrentSnackBar()
                          ..showSnackBar(SnackBar(
                            content: Text('Failed to login.'),
                            backgroundColor: Colors.red,
                          ));
                      }
                    } else {
                      ScaffoldMessenger.of(context)
                        ..removeCurrentSnackBar()
                        ..showSnackBar(SnackBar(
                          content:
                              Text('Username and Password cannot be empty.'),
                          backgroundColor: Colors.red,
                        ));
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
