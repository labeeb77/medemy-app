import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/academic/learn_screens.dart';
import '../../features/auth/auth_screens.dart';
import '../../features/practice/models.dart';
import '../../features/practice/practice_screens.dart';
import '../../features/profile/setup_screens.dart';
import '../../features/shell/shell_screens.dart';
import '../../features/topic/models.dart';
import '../../features/topic/topic_screens.dart';
import '../auth/session.dart';

/// Where a session state belongs. Returns null when [location] is already acceptable for [session].
/// Kept free of widgets so every branch can be unit tested.
String? redirectFor(SessionState session, String location, {required bool onboardingSeen}) {
  bool at(String prefix) => location == prefix || location.startsWith('$prefix/');
  switch (session) {
    case SessionUnknown() || SessionUnavailable():
      return at('/splash') ? null : '/splash';
    case SignedOut():
      if (!onboardingSeen) return at('/onboarding') ? null : '/onboarding';
      return at('/auth/sign-in') || at('/onboarding') ? null : '/auth/sign-in';
    case NeedsEmailVerification():
      return at('/auth/verify') ? null : '/auth/verify';
    case NeedsSetup():
      return at('/setup') ? null : '/setup/profile';
    case SessionReady():
      // Signed in: anything from the entry flow goes to Home; everything else, including a deep link, stands.
      return at('/splash') || at('/onboarding') || at('/auth') || at('/setup') ? '/home' : null;
  }
}

class _SessionListenable extends ChangeNotifier {
  void changed() => notifyListeners();
}

/// Whether the first-run introduction has been shown on this device. Seeded from preferences at launch.
class OnboardingSeen extends Notifier<bool> {
  OnboardingSeen([this._initial = false]);
  final bool _initial;

  @override
  bool build() => _initial;
  void markSeen() => state = true;
}

final onboardingSeenProvider = NotifierProvider<OnboardingSeen, bool>(OnboardingSeen.new);

final routerProvider = Provider<GoRouter>((ref) {
  final listenable = _SessionListenable();
  ref.listen(sessionProvider, (_, _) => listenable.changed());
  ref.onDispose(listenable.dispose);
  String? title(GoRouterState state) => state.extra is String ? state.extra as String : null;

  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: listenable,
    redirect: (context, state) => redirectFor(ref.read(sessionProvider), state.matchedLocation, onboardingSeen: ref.read(onboardingSeenProvider)),
    routes: [
      GoRoute(path: '/splash', builder: (_, _) => const SplashScreen()),
      GoRoute(path: '/onboarding', builder: (_, _) => const OnboardingScreen()),
      GoRoute(path: '/auth/sign-in', builder: (_, _) => const SignInScreen()),
      GoRoute(path: '/auth/verify', builder: (_, _) => const VerifyEmailScreen()),
      GoRoute(path: '/setup/profile', builder: (_, _) => const ProfileSetupScreen()),
      GoRoute(path: '/setup/semester', builder: (_, _) => const SemesterSelectionScreen()),
      GoRoute(path: '/topics/:id', builder: (_, state) => TopicOverviewScreen(topicPlacementId: state.pathParameters['id']!, title: title(state)), routes: [
        GoRoute(path: ':mode', builder: (_, state) => TopicContentScreen(topicPlacementId: state.pathParameters['id']!,
            mode: ContentMode.fromPath(state.pathParameters['mode']), title: title(state))),
      ]),
      // A session runs full screen, without the tab bar, so a stray tap cannot leave it.
      GoRoute(path: '/practice/setup', builder: (_, state) => PracticeSetupScreen(
          setup: state.extra is PracticeSetup ? state.extra as PracticeSetup : const PracticeSetup(category: PracticeCategory.highYield))),
      GoRoute(path: '/practice/sessions/:sessionId', builder: (_, state) => PracticeSessionScreen(sessionId: state.pathParameters['sessionId']!, notice: title(state)), routes: [
        GoRoute(path: 'results', builder: (_, state) => PracticeResultsScreen(sessionId: state.pathParameters['sessionId']!)),
        GoRoute(path: 'review', builder: (_, state) => PracticeReviewScreen(sessionId: state.pathParameters['sessionId']!)),
      ]),
      StatefulShellRoute.indexedStack(
        builder: (_, _, navigationShell) => AppShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(routes: [GoRoute(path: '/home', builder: (_, _) => const HomeScreen())]),
          StatefulShellBranch(routes: [GoRoute(path: '/learn', builder: (_, _) => const LearnScreen(), routes: [
            GoRoute(path: 'subjects/:subjectId', builder: (_, state) => SubjectScreen(subjectId: state.pathParameters['subjectId']!, title: title(state))),
          ])]),
          StatefulShellBranch(routes: [GoRoute(path: '/practice', builder: (_, _) => const PracticeHubScreen(), routes: [
            GoRoute(path: 'history', builder: (_, _) => const PracticeHistoryScreen()),
          ])]),
          StatefulShellBranch(routes: [GoRoute(path: '/progress', builder: (_, _) => const ComingTab(title: 'Progress',
              message: 'Your completion and the topics that need revision will appear here.'))]),
          StatefulShellBranch(routes: [GoRoute(path: '/profile', builder: (_, _) => const ProfileScreen(), routes: [
            GoRoute(path: 'semester', builder: (_, _) => const SemesterSelectionScreen(firstRun: false)),
          ])]),
        ],
      ),
    ],
  );
});
