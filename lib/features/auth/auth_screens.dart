import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/api/api_failure.dart';
import '../../core/auth/identity_provider.dart';
import '../../core/auth/session.dart';
import '../../core/routing/app_router.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/states.dart';

/// Words for a failure the student can do something about.
String describeFailure(Object error) => switch (error) {
      IdentityFailure(:final message) => message,
      ApiFailure(code: 'IDENTITY_CONFLICT') => 'This email is already registered with a different sign-in method. Use that method instead.',
      ApiFailure(code: 'FIREBASE_UNAVAILABLE') => 'Sign-in is temporarily unavailable. Please try again in a little while.',
      ApiFailure(status: 429, :final retryAfterSeconds) => 'Too many attempts. Try again${retryAfterSeconds == null ? ' shortly' : ' in $retryAfterSeconds seconds'}.',
      ApiFailure(status: 403) => 'This account cannot use the student app.',
      ApiFailure(:final message) => message,
      _ => 'Something went wrong. Please try again.',
    };

const onboardingSeenKey = 'medemy.onboardingSeen';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionProvider);
    return Scaffold(
      body: SafeArea(
        child: session is SessionUnavailable
            ? StatePanel(icon: Icons.wifi_off_outlined, title: 'Cannot reach Medemy', message: session.message, actionLabel: 'Try again',
                onAction: () => ref.read(sessionProvider.notifier).restore())
            : Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
                Text('Medemy', style: context.text.displaySmall?.copyWith(color: context.scheme.primary)),
                const SizedBox(height: Space.sm),
                Text('Learn with clarity. Care with confidence.', style: context.text.bodyMedium, textAlign: TextAlign.center),
                const SizedBox(height: Space.xl),
                const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2, semanticsLabel: 'Loading')),
              ])),
      ),
    );
  }
}

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});
  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  static const _pages = [
    (Icons.account_tree_outlined, 'Your nursing curriculum, organized.', 'Move from semester to subject, unit and topic, and always know where you are.'),
    (Icons.quiz_outlined, 'Practice what matters.', 'Validated questions with clear rationales help you find the topics that need another look.'),
    (Icons.menu_book_outlined, 'Learn, revise, and prepare for exams.', 'Every topic comes in three views built from the same approved content.'),
  ];
  int _page = 0;

  Future<void> _finish() async {
    ref.read(onboardingSeenProvider.notifier).markSeen();
    if (mounted) context.go('/auth/sign-in');
    (await SharedPreferences.getInstance()).setBool(onboardingSeenKey, true);
  }

  @override
  Widget build(BuildContext context) {
    final (icon, title, body) = _pages[_page];
    final last = _page == _pages.length - 1;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Space.xl),
          child: Column(children: [
            Align(alignment: Alignment.centerRight, child: TextButton(onPressed: _finish, child: const Text('Skip'))),
            Expanded(child: SingleChildScrollView(child: Column(children: [
              const SizedBox(height: Space.xxl),
              Icon(icon, size: 72, color: context.scheme.primary),
              const SizedBox(height: Space.xl),
              Text(title, style: context.text.headlineSmall, textAlign: TextAlign.center),
              const SizedBox(height: Space.md),
              Text(body, style: context.text.bodyLarge, textAlign: TextAlign.center),
            ]))),
            Semantics(label: 'Page ${_page + 1} of ${_pages.length}', child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              for (var index = 0; index < _pages.length; index++)
                Container(width: 8, height: 8, margin: const EdgeInsets.all(Space.xs),
                    decoration: BoxDecoration(shape: BoxShape.circle, color: index == _page ? context.scheme.primary : context.colors.border)),
            ])),
            const SizedBox(height: Space.lg),
            Row(children: [
              if (_page > 0) Expanded(child: OutlinedButton(onPressed: () => setState(() => _page--), child: const Text('Back'))),
              if (_page > 0) const SizedBox(width: Space.md),
              Expanded(child: FilledButton(onPressed: last ? _finish : () => setState(() => _page++), child: Text(last ? 'Get started' : 'Next'))),
            ]),
          ]),
        ),
      ),
    );
  }
}

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});
  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final _form = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _creating = false;
  bool _showPassword = false;
  bool _busy = false;
  String? _error;
  String? _notice;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _run(Future<void> Function() action, {String? notice}) async {
    setState(() { _busy = true; _error = null; _notice = null; });
    try {
      await action();
      if (mounted && notice != null) setState(() => _notice = notice);
    } catch (error) {
      if (mounted) setState(() => _error = describeFailure(error));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  void _submit() {
    if (!_form.currentState!.validate()) return;
    final session = ref.read(sessionProvider.notifier);
    final email = _email.text.trim();
    _run(() => _creating ? session.createAccount(email, _password.text) : session.signIn(email, _password.text));
  }

  void _reset() {
    final email = _email.text.trim();
    if (!email.contains('@')) {
      setState(() => _error = 'Enter your email above first, then choose Forgot password.');
      return;
    }
    // The same message whether or not the account exists.
    _run(() => ref.read(identityProvider).sendPasswordReset(email), notice: 'If an account exists for $email, a password reset email is on its way.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(Space.xl),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Form(
                key: _form,
                child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                  Text('Medemy', style: context.text.titleMedium?.copyWith(color: context.scheme.primary)),
                  const SizedBox(height: Space.sm),
                  Text(_creating ? 'Create your account' : 'Welcome to Medemy', style: context.text.headlineSmall),
                  const SizedBox(height: Space.xl),
                  if (_error != null) _Banner(text: _error!, error: true),
                  if (_notice != null) _Banner(text: _notice!, error: false),
                  TextFormField(controller: _email, keyboardType: TextInputType.emailAddress, autofillHints: const [AutofillHints.email],
                      textInputAction: TextInputAction.next, decoration: const InputDecoration(labelText: 'Email'),
                      validator: (value) => (value ?? '').trim().contains('@') ? null : 'Enter a valid email address'),
                  const SizedBox(height: Space.lg),
                  TextFormField(controller: _password, obscureText: !_showPassword,
                      autofillHints: [_creating ? AutofillHints.newPassword : AutofillHints.password], onFieldSubmitted: (_) => _submit(),
                      decoration: InputDecoration(labelText: 'Password', helperText: _creating ? 'At least 8 characters' : null,
                          suffixIcon: IconButton(tooltip: _showPassword ? 'Hide password' : 'Show password',
                              icon: Icon(_showPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                              onPressed: () => setState(() => _showPassword = !_showPassword))),
                      validator: (value) => (value ?? '').length >= (_creating ? 8 : 1) ? null : (_creating ? 'Use at least 8 characters' : 'Enter your password')),
                  if (!_creating) Align(alignment: Alignment.centerRight, child: TextButton(onPressed: _busy ? null : _reset, child: const Text('Forgot password?'))),
                  const SizedBox(height: Space.lg),
                  FilledButton(onPressed: _busy ? null : _submit, child: Text(_busy ? 'Please wait…' : _creating ? 'Create account' : 'Sign in')),
                  const SizedBox(height: Space.sm),
                  TextButton(onPressed: _busy ? null : () => setState(() { _creating = !_creating; _error = null; _notice = null; }),
                      child: Text(_creating ? 'I already have an account' : 'Create an account')),
                  const SizedBox(height: Space.lg),
                  Text('Your password is handled by a secure sign-in service and is never stored by Medemy.', style: context.text.bodyMedium, textAlign: TextAlign.center),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Banner extends StatelessWidget {
  const _Banner({required this.text, required this.error});
  final String text;
  final bool error;

  @override
  Widget build(BuildContext context) {
    final color = error ? context.scheme.error : context.colors.success;
    return Semantics(
      liveRegion: true,
      child: Container(
        margin: const EdgeInsets.only(bottom: Space.lg), padding: const EdgeInsets.all(Space.md),
        decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(Radii.control)),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Icon(error ? Icons.error_outline : Icons.check_circle_outline, color: color, size: 20),
          const SizedBox(width: Space.sm),
          Expanded(child: Text(text, style: context.text.bodyMedium?.copyWith(color: context.scheme.onSurface))),
        ]),
      ),
    );
  }
}

class VerifyEmailScreen extends ConsumerStatefulWidget {
  const VerifyEmailScreen({super.key});
  @override
  ConsumerState<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends ConsumerState<VerifyEmailScreen> {
  static const _cooldown = 60;
  Timer? _timer;
  int _wait = _cooldown;
  bool _busy = false;
  String? _message;
  bool _isError = false;

  @override
  void initState() {
    super.initState();
    _startCooldown();
  }

  void _startCooldown() {
    _timer?.cancel();
    _wait = _cooldown;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted || _wait <= 1) timer.cancel();
      if (mounted) setState(() => _wait--);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _run(Future<String?> Function() action) async {
    setState(() { _busy = true; _message = null; });
    try {
      final message = await action();
      if (mounted) setState(() { _message = message; _isError = false; });
    } catch (error) {
      if (mounted) setState(() { _message = describeFailure(error); _isError = true; });
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final session = ref.watch(sessionProvider);
    final email = session is NeedsEmailVerification ? session.email : 'your email';
    final controller = ref.read(sessionProvider.notifier);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(Space.xl),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                Icon(Icons.mark_email_unread_outlined, size: 56, color: context.scheme.primary),
                const SizedBox(height: Space.lg),
                Text('Verify your email', style: context.text.headlineSmall, textAlign: TextAlign.center),
                const SizedBox(height: Space.sm),
                Text('We sent a verification link to $email. Open it, then come back here.', style: context.text.bodyLarge, textAlign: TextAlign.center),
                const SizedBox(height: Space.xl),
                if (_message != null) _Banner(text: _message!, error: _isError),
                FilledButton(
                  onPressed: _busy ? null : () => _run(() async {
                        if (await controller.confirmVerified()) return null;
                        throw const IdentityFailure('That email is not verified yet. Open the link we sent, then try again.');
                      }),
                  child: Text(_busy ? 'Checking…' : "I've verified my email"),
                ),
                const SizedBox(height: Space.sm),
                OutlinedButton(
                  onPressed: _busy || _wait > 0 ? null : () => _run(() async {
                        await controller.resendVerification();
                        _startCooldown();
                        return 'Verification email sent again.';
                      }),
                  child: Text(_wait > 0 ? 'Resend email in ${_wait}s' : 'Resend email'),
                ),
                TextButton(onPressed: _busy ? null : controller.signOut, child: const Text('Use a different email')),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
