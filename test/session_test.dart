import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medemy_app/core/api/api_failure.dart';
import 'package:medemy_app/core/auth/identity_provider.dart';
import 'package:medemy_app/core/auth/session.dart';
import 'package:medemy_app/core/auth/student.dart';
import 'package:medemy_app/core/auth/token_store.dart';
import 'package:medemy_app/core/routing/app_router.dart';

import 'support/fakes.dart';

void main() {
  late FakeIdentity identity;
  late InMemoryTokenStore tokens;
  late FakeServer server;
  late ProviderContainer container;
  String? semesterId;

  setUp(() {
    semesterId = null;
    identity = FakeIdentity();
    tokens = InMemoryTokenStore();
    server = FakeServer((request) async {
      if (request.path.endsWith('/auth/firebase')) {
        return (request.data as Map)['idToken'] == 'id-token-verified' ? ok(sessionJson(semesterId: semesterId)) : failure(403, 'EMAIL_NOT_VERIFIED');
      }
      if (request.path.endsWith('/me/profile')) {
        final body = request.data as Map;
        semesterId = body['currentSemesterId'] as String? ?? semesterId;
        return ok({'displayName': body['displayName'] ?? 'Ananya Joseph', 'currentSemesterId': semesterId, 'avatarUrl': null});
      }
      if (request.path.endsWith('/me')) return ok(studentJson(semesterId: semesterId));
      return ok(null, 204);
    });
    container = ProviderContainer(overrides: [
      tokenStoreProvider.overrideWithValue(tokens),
      identityProvider.overrideWithValue(identity),
      apiClientProvider.overrideWith((ref) => fakeApi(server, tokens, onSessionExpired: () => ref.read(sessionProvider.notifier).expire())),
    ]);
    addTearDown(container.dispose);
  });

  SessionController controller() => container.read(sessionProvider.notifier);
  SessionState state() => container.read(sessionProvider);

  test('a first launch with nobody signed in lands signed out', () async {
    await controller().restore();
    expect(state(), isA<SignedOut>());
  });

  test('signing in exchanges the token and asks a new student for setup, then is ready', () async {
    await controller().signIn('ananya@example.com', 'secret-password');
    expect(state(), isA<NeedsSetup>());
    expect((await tokens.read())!.accessToken, 'access-1');
    await controller().saveDisplayName('Ananya J.');
    expect((state() as NeedsSetup).student.profile!.displayName, 'Ananya J.');
    await controller().chooseSemester('semester-3');
    expect((state() as SessionReady).student.profile!.currentSemesterId, 'semester-3');
  });

  test('a returning student with a semester goes straight in', () async {
    semesterId = 'semester-3';
    await tokens.write(const TokenPair(accessToken: 'a', refreshToken: 'r'));
    await controller().restore();
    expect(state(), isA<SessionReady>());
  });

  test('a new account must verify its email, and the token is refreshed before the exchange', () async {
    await controller().createAccount('new@example.com', 'secret-password');
    expect((state() as NeedsEmailVerification).email, 'new@example.com');
    expect(identity.verificationEmails, 1);
    expect(await tokens.read(), isNull);

    expect(await controller().confirmVerified(), isFalse);
    expect(state(), isA<NeedsEmailVerification>());
    identity.verified = true;
    expect(await controller().confirmVerified(), isTrue);
    expect(identity.tokenRequests.last, isTrue, reason: 'the pre-verification token would still be rejected');
    expect(state(), isA<NeedsSetup>());
  });

  test('signing in with an unverified email leads to verification, not an error', () async {
    identity.verified = false;
    await controller().signIn('new@example.com', 'secret-password');
    expect(state(), isA<NeedsEmailVerification>());
    // Reopening the app in that state resumes verification.
    await controller().restore();
    expect(state(), isA<NeedsEmailVerification>());
  });

  test('a rejected sign-in leaves nobody signed in and reports why', () async {
    identity.failWith = const IdentityFailure('That email and password do not match.');
    await expectLater(controller().signIn('a@b.co', 'wrong'), throwsA(isA<IdentityFailure>()));
    expect(state(), isA<SessionUnknown>());

    identity.failWith = null;
    server.handler = (_) async => failure(409, 'IDENTITY_CONFLICT');
    await expectLater(controller().signIn('a@b.co', 'right'), throwsA(isA<ApiFailure>().having((failure) => failure.code, 'code', 'IDENTITY_CONFLICT')));
    expect(identity.currentEmail, isNull, reason: 'the provider session is dropped when the exchange is refused');
  });

  test('restore distinguishes an expired session from an unreachable server', () async {
    await tokens.write(const TokenPair(accessToken: 'a', refreshToken: 'r'));
    server.handler = (_) async => failure(401, 'UNAUTHORIZED');
    await controller().restore();
    expect(state(), isA<SignedOut>());

    await tokens.write(const TokenPair(accessToken: 'a', refreshToken: 'r'));
    server.offline = true;
    await controller().restore();
    expect(state(), isA<SessionUnavailable>());
    expect(await tokens.read(), isNotNull, reason: 'being offline must not sign the student out');
  });

  test('signing out revokes the refresh token and clears everything', () async {
    semesterId = 'semester-3';
    await controller().signIn('ananya@example.com', 'secret-password');
    await controller().signOut();
    expect(state(), isA<SignedOut>());
    expect(await tokens.read(), isNull);
    expect(identity.currentEmail, isNull);
    expect((server.requests.last.data as Map)['refreshToken'], 'refresh-1');
  });

  group('redirectFor', () {
    final student = Student.fromJson(studentJson(semesterId: 'semester-3'));
    test('sends each state to its screen and leaves correct locations alone', () {
      const unknown = SessionUnknown();
      expect(redirectFor(unknown, '/home', onboardingSeen: true), '/splash');
      expect(redirectFor(unknown, '/splash', onboardingSeen: true), isNull);
      expect(redirectFor(const SessionUnavailable('x'), '/learn', onboardingSeen: true), '/splash');

      expect(redirectFor(const SignedOut(), '/splash', onboardingSeen: false), '/onboarding');
      expect(redirectFor(const SignedOut(), '/splash', onboardingSeen: true), '/auth/sign-in');
      expect(redirectFor(const SignedOut(), '/topics/abc/learn', onboardingSeen: true), '/auth/sign-in');
      expect(redirectFor(const SignedOut(), '/auth/sign-in', onboardingSeen: true), isNull);
      expect(redirectFor(const SignedOut(), '/onboarding', onboardingSeen: false), isNull);

      expect(redirectFor(const NeedsEmailVerification('a@b.co'), '/home', onboardingSeen: true), '/auth/verify');
      expect(redirectFor(const NeedsEmailVerification('a@b.co'), '/auth/verify', onboardingSeen: true), isNull);

      expect(redirectFor(NeedsSetup(student), '/home', onboardingSeen: true), '/setup/profile');
      expect(redirectFor(NeedsSetup(student), '/setup/semester', onboardingSeen: true), isNull);

      // Once ready, the entry flow leads home, while a deep link into content is kept.
      for (final entry in ['/splash', '/onboarding', '/auth/sign-in', '/auth/verify', '/setup/semester']) {
        expect(redirectFor(SessionReady(student), entry, onboardingSeen: true), '/home', reason: entry);
      }
      expect(redirectFor(SessionReady(student), '/topics/abc/learn', onboardingSeen: true), isNull);
      expect(redirectFor(SessionReady(student), '/profile/semester', onboardingSeen: true), isNull);
    });
  });
}
