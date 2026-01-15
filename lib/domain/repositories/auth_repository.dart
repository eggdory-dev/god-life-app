import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import '../entities/user.dart';

/// Authentication repository interface
/// Defines contract for authentication operations
abstract class AuthRepository {
  /// Get current authenticated user
  Future<Either<Failure, User?>> getCurrentUser();

  /// Stream of authentication state changes
  Stream<User?> get authStateChanges;

  /// Sign up with email
  Future<Either<Failure, User>> signUpWithEmail({
    required String email,
    required String password,
    required String name,
  });

  /// Sign in with email
  Future<Either<Failure, User>> signInWithEmail({
    required String email,
    required String password,
  });

  /// Login with Google
  Future<Either<Failure, User>> loginWithGoogle();

  /// Login with Apple
  Future<Either<Failure, User>> loginWithApple();

  /// Login with Kakao
  Future<Either<Failure, User>> loginWithKakao();

  /// Logout
  Future<Either<Failure, void>> logout();

  /// Reset password
  Future<Either<Failure, void>> resetPassword(String email);

  /// Update user profile
  Future<Either<Failure, User>> updateProfile({
    String? name,
    String? photoUrl,
  });

  /// Update user settings
  Future<Either<Failure, User>> updateSettings(UserSettings settings);

  /// Delete account
  Future<Either<Failure, void>> deleteAccount();

  /// Get current profile
  Future<Either<Failure, Map<String, dynamic>?>> getCurrentProfile();

  /// Complete onboarding
  Future<Either<Failure, void>> completeOnboarding({
    required List<String> interests,
    required bool isFaithUser,
    required String coachingStyle,
    required String themeMode,
  });
}
