import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/routing/app_router.dart';
import 'core/theme/app_theme.dart';

class MedemyApp extends ConsumerWidget {
  const MedemyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Medemy',
      debugShowCheckedModeBanner: false,
      theme: buildTheme(Brightness.light),
      darkTheme: buildTheme(Brightness.dark),
      routerConfig: ref.watch(routerProvider),
    );
  }
}

/// Shown when the Firebase configuration file has not been generated for this build.
class FirebaseNotConfiguredApp extends StatelessWidget {
  const FirebaseNotConfiguredApp({super.key, required this.detail});
  final String detail;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: buildTheme(Brightness.light),
      home: Scaffold(body: SafeArea(child: Padding(padding: const EdgeInsets.all(Space.xl), child: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
        const Icon(Icons.settings_suggest_outlined, size: 48),
        const SizedBox(height: Space.lg),
        const Text('Firebase is not configured', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600), textAlign: TextAlign.center),
        const SizedBox(height: Space.sm),
        const Text('Run "flutterfire configure --project=medmy-edu" in the app folder, then rebuild.', textAlign: TextAlign.center),
        const SizedBox(height: Space.lg),
        Text(detail, style: const TextStyle(fontSize: 12), textAlign: TextAlign.center),
      ]))))),
    );
  }
}
