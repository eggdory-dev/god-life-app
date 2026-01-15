import 'package:supabase_flutter/supabase_flutter.dart';

/// Remote data source for authentication operations
/// Defines contract for auth data operations
abstract class AuthRemoteDataSource {
  /// Get current authenticated user from Supabase
  User? get currentUser;

  /// Stream of authentication state changes
  Stream<AuthState> get authStateChanges;

  /// Sign up with email and password
  Future<AuthResponse> signUpWithEmail({
    required String email,
    required String password,
    required String name,
  });

  /// Sign in with email and password
  Future<AuthResponse> signInWithEmail({
    required String email,
    required String password,
  });

  /// Sign in with Google (Firebase + Supabase integration)
  Future<AuthResponse> signInWithGoogle();

  /// Sign in with Apple
  Future<AuthResponse> signInWithApple();

  /// Sign out from all services
  Future<void> signOut();

  /// Reset password
  Future<void> resetPassword(String email);

  /// Get current user profile from Supabase profiles table
  Future<Map<String, dynamic>?> getCurrentProfile();

  /// Complete onboarding
  Future<void> completeOnboarding({
    required List<String> interests,
    required bool isFaithUser,
    required String coachingStyle,
    required String themeMode,
  });
}
