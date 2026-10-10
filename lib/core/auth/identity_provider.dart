import 'package:firebase_auth/firebase_auth.dart';

/// A sign-in problem the student can act on, already worded for display.
class IdentityFailure implements Exception {
  const IdentityFailure(this.message);
  final String message;
  @override
  String toString() => message;
}

/// The identity provider behind sign-in. Firebase in the app; a fake in tests.
abstract class IdentityProvider {
  /// The signed-in account's email, or null when nobody is signed in with the provider.
  String? get currentEmail;
  Future<void> signIn(String email, String password);
  Future<void> createAccount(String email, String password);
  Future<void> sendVerificationEmail();
  /// Re-reads the account from the provider and reports whether its email is now verified.
  Future<bool> reloadAndCheckVerified();
  /// A fresh ID token to exchange with the Medemy API.
  Future<String> idToken({bool forceRefresh = false});
  Future<void> sendPasswordReset(String email);
  Future<void> signOut();
}

class FirebaseIdentityProvider implements IdentityProvider {
  FirebaseIdentityProvider([FirebaseAuth? auth]) : _auth = auth ?? FirebaseAuth.instance;
  final FirebaseAuth _auth;

  @override
  String? get currentEmail => _auth.currentUser?.email;

  @override
  Future<void> signIn(String email, String password) => _guard(() => _auth.signInWithEmailAndPassword(email: email, password: password));

  @override
  Future<void> createAccount(String email, String password) => _guard(() => _auth.createUserWithEmailAndPassword(email: email, password: password));

  @override
  Future<void> sendVerificationEmail() => _guard(() async => _auth.currentUser?.sendEmailVerification());

  @override
  Future<bool> reloadAndCheckVerified() => _guard(() async {
        await _auth.currentUser?.reload();
        return _auth.currentUser?.emailVerified ?? false;
      });

  @override
  Future<String> idToken({bool forceRefresh = false}) => _guard(() async {
        final token = await _auth.currentUser?.getIdToken(forceRefresh);
        if (token == null) throw const IdentityFailure('Please sign in again.');
        return token;
      });

  @override
  Future<void> sendPasswordReset(String email) => _guard(() => _auth.sendPasswordResetEmail(email: email));

  @override
  Future<void> signOut() => _auth.signOut();

  Future<T> _guard<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on FirebaseAuthException catch (error) {
      throw IdentityFailure(_message(error.code));
    }
  }

  // Wrong email and wrong password share one message so the screen never confirms that an account exists.
  static String _message(String code) => switch (code) {
        'invalid-credential' || 'wrong-password' || 'user-not-found' || 'invalid-email' => 'That email and password do not match.',
        'email-already-in-use' => 'An account with this email already exists. Try signing in instead.',
        'weak-password' => 'Choose a longer password, at least 8 characters.',
        'too-many-requests' => 'Too many attempts. Please wait a few minutes and try again.',
        'network-request-failed' => 'You appear to be offline. Check your connection and try again.',
        'user-disabled' => 'This account has been disabled. Contact support.',
        _ => 'Sign-in failed. Please try again.',
      };
}
