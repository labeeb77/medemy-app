import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'core/auth/session.dart';
import 'core/routing/app_router.dart';
import 'features/auth/auth_screens.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  } catch (error) {
    runApp(FirebaseNotConfiguredApp(detail: '$error'));
    return;
  }
  final preferences = await SharedPreferences.getInstance();
  // Riverpod would otherwise retry a failed load by itself; a 404 or an offline error should be shown, and retried when asked.
  final container = ProviderContainer(retry: (_, _) => null, overrides: [
    onboardingSeenProvider.overrideWith(() => OnboardingSeen(preferences.getBool(onboardingSeenKey) ?? false)),
  ]);
  // Resolve the session in the background; the splash screen shows until it settles.
  container.read(sessionProvider.notifier).restore();
  runApp(UncontrolledProviderScope(container: container, child: const MedemyApp()));
}
