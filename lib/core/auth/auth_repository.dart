import '../api/api_client.dart';
import 'identity_provider.dart';
import 'student.dart';
import 'token_store.dart';

/// Turns a provider sign-in into a Medemy session and keeps the stored tokens in step with it.
class AuthRepository {
  AuthRepository({required this.identity, required this.api, required this.tokens});

  final IdentityProvider identity;
  final ApiClient api;
  final TokenStore tokens;

  /// Exchanges the provider's ID token for Medemy tokens (decision D-06) and returns the student.
  Future<Student> exchange({bool forceRefresh = false, String? displayName}) async {
    final idToken = await identity.idToken(forceRefresh: forceRefresh);
    final data = await api.post('/auth/firebase', {'idToken': idToken, if (displayName != null && displayName.isNotEmpty) 'displayName': displayName})
        as Map<String, dynamic>;
    await tokens.write(TokenPair.fromJson(data));
    return Student.fromJson(data['user'] as Map<String, dynamic>);
  }

  Future<Student> me() async => Student.fromJson(await api.get('/me') as Map<String, dynamic>);

  Future<StudentProfile> updateProfile({String? displayName, String? currentSemesterId}) async {
    final data = await api.patch('/me/profile', {'displayName': ?displayName, 'currentSemesterId': ?currentSemesterId});
    return StudentProfile.fromJson(data as Map<String, dynamic>);
  }

  Future<void> signOut() async {
    final current = await tokens.read();
    await tokens.clear();
    // Revoking the refresh token is best effort: the device is signed out either way.
    if (current != null) {
      try {
        await api.post('/auth/logout', {'refreshToken': current.refreshToken});
      } catch (_) {}
    }
    await identity.signOut();
  }
}
