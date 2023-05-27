import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gagaku/drawer.dart';
import 'package:gagaku/version.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Gagaku'),
      ),
      drawer: const MainDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Gagaku v1.0.0',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text('Flutter: $kFlutterFrameworkVersion'),
            const SizedBox(
              height: 4,
            ),
            const Text('Dart: $kFlutterDartSdkVersion'),
            const SizedBox(
              height: 4,
            ),
            const Text('Built on: $kBuildTimestamp'),
            const SizedBox(
              height: 4,
            ),
            const Text('License: MIT'),
            const SizedBox(
              height: 4,
            ),
            RichText(
              text: TextSpan(
                text: 'GitHub',
                style: const TextStyle(color: Colors.blue),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    launchUrl(Uri.parse('https://github.com/r52/gagaku'));
                  },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
