import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../api/api_client.dart';
import '../api/api_failure.dart';
import '../config/env.dart';
import 'auth_repository.dart';
import 'identity_provider.dart';
import 'student.dart';
import 'token_store.dart';

/// Where the student is on the way into the app. The router sends each state to its screen.
sealed class SessionState {
  const SessionState();
}

class SessionUnknown extends SessionState {
  const SessionUnknown();
}

/// The session could not be checked (offline or server down). Splash offers a retry.
class SessionUnavailable extends SessionState {
  const SessionUnavailable(this.message);
  final String message;
}

class SignedOut extends SessionState {
  const SignedOut();
}

class NeedsEmailVerification extends SessionState {
  const NeedsEmailVerification(this.email);
  final String email;
}

/// Signed in but has not chosen a semester yet.
class NeedsSetup extends SessionState {
  const NeedsSetup(this.student);
  final Student student;
}

class SessionReady extends SessionState {
  const SessionReady(this.student);
  final Student student;
}

final tokenStoreProvider = Provider<TokenStore>((ref) => SecureTokenStore());
final identityProvider = Provider<IdentityProvider>((ref) => FirebaseIdentityProvider());

final apiClientProvider = Provider<ApiClient>((ref) => ApiClient.create(
      baseUrl: apiBaseUrl,
      tokens: ref.watch(tokenStoreProvider),
      onSessionExpired: () => ref.read(sessionProvider.notifier).expire(),
    ));

final authRepositoryProvider = Provider<AuthRepository>((ref) =>
    AuthRepository(identity: ref.watch(identityProvider), api: ref.watch(apiClientProvider), tokens: ref.watch(tokenStoreProvider)));

final sessionProvider = NotifierProvider<SessionController, SessionState>(SessionController.new);

class SessionController extends Notifier<SessionState> {
  @override
  SessionState build() => const SessionUnknown();

  AuthRepository get _auth => ref.read(authRepositoryProvider);
  SessionState _forStudent(Student student) => student.profile?.currentSemesterId == null ? NeedsSetup(student) : SessionReady(student);

  /// Called at launch: works out where a returning student should land.
  Future<void> restore() async {
    state = const SessionUnknown();
    try {
      if (await _auth.tokens.read() != null) {
        state = _forStudent(await _auth.me());
        return;
      }
      final email = _auth.identity.currentEmail;
      state = email == null ? const SignedOut() : await _afterProviderSignIn(email);
    } on ApiFailure catch (failure) {
      state = failure.isUnauthorized ? const SignedOut() : SessionUnavailable(failure.message);
    } on IdentityFailure catch (failure) {
      state = SessionUnavailable(failure.message);
    }
  }

  Future<void> signIn(String email, String password) async {
    await _auth.identity.signIn(email, password);
    state = await _afterProviderSignIn(email);
  }

  Future<void> createAccount(String email, String password) async {
    await _auth.identity.createAccount(email, password);
    await _auth.identity.sendVerificationEmail();
    state = NeedsEmailVerification(email);
  }

  Future<void> resendVerification() => _auth.identity.sendVerificationEmail();

  /// Returns false when the email is still unverified, so the screen can say so.
  Future<bool> confirmVerified() async {
    if (!await _auth.identity.reloadAndCheckVerified()) return false;
    // The ID token issued before verification still says "unverified", so it must be refreshed before the exchange.
    state = _forStudent(await _auth.exchange(forceRefresh: true));
    return true;
  }

  Future<void> saveDisplayName(String displayName) async {
    final current = _student;
    if (current == null) return;
    final profile = await _auth.updateProfile(displayName: displayName);
    state = _forStudent(current.copyWith(profile: profile));
  }

  Future<void> chooseSemester(String semesterId) async {
    final current = _student;
    if (current == null) return;
    final profile = await _auth.updateProfile(currentSemesterId: semesterId);
    state = _forStudent(current.copyWith(profile: profile));
  }

  Future<void> signOut() async {
    await _auth.signOut();
    state = const SignedOut();
  }

  /// The refresh token stopped working: drop the session without another server call.
  Future<void> expire() async {
    await _auth.tokens.clear();
    await _auth.identity.signOut();
    state = const SignedOut();
  }

  Student? get _student => switch (state) { NeedsSetup(:final student) || SessionReady(:final student) => student, _ => null };

  Future<SessionState> _afterProviderSignIn(String email) async {
    try {
      return _forStudent(await _auth.exchange());
    } on ApiFailure catch (failure) {
      if (failure.code == 'EMAIL_NOT_VERIFIED') return NeedsEmailVerification(email);
      await _auth.identity.signOut();
      rethrow;
    }
  }
}

/// The signed-in student, for screens that are only reachable once there is one.
final studentProvider = Provider<Student?>((ref) => switch (ref.watch(sessionProvider)) {
      NeedsSetup(:final student) || SessionReady(:final student) => student,
      _ => null,
    });
