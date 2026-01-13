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

  /// Login with Google
  Future<Either<Failure, User>> loginWithGoogle();

  /// Login with Apple
  Future<Either<Failure, User>> loginWithApple();

  /// Login with Kakao
  Future<Either<Failure, User>> loginWithKakao();

  /// Logout
  Future<Either<Failure, void>> logout();

  /// Update user profile
  Future<Either<Failure, User>> updateProfile({
    String? name,
    String? photoUrl,
  });

  /// Update user settings
  Future<Either<Failure, User>> updateSettings(UserSettings settings);

  /// Delete account
  Future<Either<Failure, void>> deleteAccount();
}
