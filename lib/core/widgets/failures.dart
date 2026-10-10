import '../api/api_failure.dart';
import '../auth/identity_provider.dart';

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
