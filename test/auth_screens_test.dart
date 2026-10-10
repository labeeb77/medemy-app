import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medemy_app/core/auth/identity_provider.dart';
import 'package:medemy_app/core/auth/session.dart';
import 'package:medemy_app/core/auth/token_store.dart';
import 'package:medemy_app/core/theme/app_theme.dart';
import 'package:medemy_app/features/academic/academic_repository.dart';
import 'package:medemy_app/features/academic/models.dart';
import 'package:medemy_app/features/auth/auth_screens.dart';
import 'package:medemy_app/features/profile/setup_screens.dart';

import 'support/fakes.dart';

void main() {
  late FakeIdentity identity;
  late FakeServer server;
  late InMemoryTokenStore tokens;

  Widget app(Widget child, {List<Object?> extra = const []}) => ProviderScope(retry: (_, _) => null, overrides: [
        tokenStoreProvider.overrideWithValue(tokens),
        identityProvider.overrideWithValue(identity),
        apiClientProvider.overrideWith((ref) => fakeApi(server, tokens)),
        ...extra.cast(),
      ], child: MaterialApp(theme: buildTheme(Brightness.light), home: child));

  setUp(() {
    identity = FakeIdentity();
    tokens = InMemoryTokenStore();
    server = FakeServer((request) async => request.path.endsWith('/auth/firebase') ? ok(sessionJson(semesterId: 'semester-3'))
        : ok({'displayName': 'Ananya Joseph', 'currentSemesterId': (request.data as Map?)?['currentSemesterId'], 'avatarUrl': null}));
  });

  ProviderContainer containerOf(WidgetTester tester) => ProviderScope.containerOf(tester.element(find.byType(MaterialApp)));

  testWidgets('sign-in validates before calling anyone, then signs in', (tester) async {
    await tester.pumpWidget(app(const SignInScreen()));
    await tester.tap(find.widgetWithText(FilledButton, 'Sign in'));
    await tester.pump();
    expect(find.text('Enter a valid email address'), findsOneWidget);
    expect(find.text('Enter your password'), findsOneWidget);
    expect(server.requests, isEmpty);

    await tester.enterText(find.widgetWithText(TextFormField, 'Email'), ' ananya@example.com ');
    await tester.enterText(find.widgetWithText(TextFormField, 'Password'), 'secret-password');
    await tester.tap(find.widgetWithText(FilledButton, 'Sign in'));
    await tester.pumpAndSettle();
    expect(identity.currentEmail, 'ananya@example.com');
    expect(containerOf(tester).read(sessionProvider), isA<SessionReady>());
  });

  testWidgets('sign-in failures are explained in plain words', (tester) async {
    identity.failWith = const IdentityFailure('That email and password do not match.');
    await tester.pumpWidget(app(const SignInScreen()));
    await tester.enterText(find.widgetWithText(TextFormField, 'Email'), 'ananya@example.com');
    await tester.enterText(find.widgetWithText(TextFormField, 'Password'), 'wrong');
    await tester.tap(find.widgetWithText(FilledButton, 'Sign in'));
    await tester.pumpAndSettle();
    expect(find.text('That email and password do not match.'), findsOneWidget);

    identity.failWith = null;
    server.handler = (_) async => failure(409, 'IDENTITY_CONFLICT');
    await tester.tap(find.widgetWithText(FilledButton, 'Sign in'));
    await tester.pumpAndSettle();
    expect(find.textContaining('already registered with a different sign-in method'), findsOneWidget);
  });

  testWidgets('creating an account requires a longer password and sends a verification email', (tester) async {
    await tester.pumpWidget(app(const SignInScreen()));
    await tester.tap(find.text('Create an account'));
    await tester.pump();
    await tester.enterText(find.widgetWithText(TextFormField, 'Email'), 'new@example.com');
    await tester.enterText(find.widgetWithText(TextFormField, 'Password'), 'short');
    await tester.tap(find.widgetWithText(FilledButton, 'Create account'));
    await tester.pump();
    expect(find.text('Use at least 8 characters'), findsOneWidget);

    await tester.enterText(find.widgetWithText(TextFormField, 'Password'), 'long-enough-password');
    await tester.tap(find.widgetWithText(FilledButton, 'Create account'));
    await tester.pumpAndSettle();
    expect(identity.verificationEmails, 1);
    expect(containerOf(tester).read(sessionProvider), isA<NeedsEmailVerification>());
  });

  testWidgets('forgot password never reveals whether an account exists', (tester) async {
    await tester.pumpWidget(app(const SignInScreen()));
    await tester.tap(find.text('Forgot password?'));
    await tester.pump();
    expect(find.textContaining('Enter your email above first'), findsOneWidget);
    await tester.enterText(find.widgetWithText(TextFormField, 'Email'), 'anyone@example.com');
    await tester.tap(find.text('Forgot password?'));
    await tester.pumpAndSettle();
    expect(identity.resets, ['anyone@example.com']);
    expect(find.textContaining('If an account exists for anyone@example.com'), findsOneWidget);
  });

  testWidgets('verify email explains when the link has not been opened, then continues once it has', (tester) async {
    identity = FakeIdentity(email: 'new@example.com', verified: false);
    await tester.pumpWidget(app(const VerifyEmailScreen()));
    expect(find.textContaining('Resend email in'), findsOneWidget);
    await tester.tap(find.text("I've verified my email"));
    await tester.pumpAndSettle(const Duration(milliseconds: 50));
    expect(find.textContaining('not verified yet'), findsOneWidget);

    identity.verified = true;
    await tester.tap(find.text("I've verified my email"));
    await tester.pump(const Duration(milliseconds: 50));
    await tester.pump(const Duration(milliseconds: 50));
    expect(containerOf(tester).read(sessionProvider), isA<SessionReady>());
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('semester selection saves the chosen semester', (tester) async {
    const semesters = [Semester(id: 'semester-1', semesterNumber: 1), Semester(id: 'semester-3', semesterNumber: 3)];
    await tester.pumpWidget(app(const SemesterSelectionScreen(), extra: [semestersProvider.overrideWith((ref) async => semesters)]));
    final container = containerOf(tester);
    // Real async work must run outside the test's fake clock.
    await tester.runAsync(() => container.read(sessionProvider.notifier).signIn('ananya@example.com', 'secret-password'));
    await tester.pumpAndSettle();
    expect(tester.widget<FilledButton>(find.widgetWithText(FilledButton, 'Start learning')).onPressed, isNotNull, reason: 'the current semester is preselected');

    await tester.tap(find.text('Semester 1'));
    await tester.pump();
    await tester.tap(find.widgetWithText(FilledButton, 'Start learning'));
    await tester.pumpAndSettle();
    expect((server.requests.last.data as Map)['currentSemesterId'], 'semester-1');
    expect((container.read(sessionProvider) as SessionReady).student.profile!.currentSemesterId, 'semester-1');
  });
}
