import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants/app_constants.dart';
import 'auth_remote_datasource.dart';

/// Supabase + Firebase Auth Data Source
/// Implements Firebase Auth + Supabase integration for authentication
class SupabaseAuthDataSource implements AuthRemoteDataSource {
  final SupabaseClient _supabase = Supabase.instance.client;
  final firebase_auth.FirebaseAuth _firebaseAuth =
      firebase_auth.FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  SupabaseAuthDataSource() {
    // Listen to auth state changes and persist session
    _supabase.auth.onAuthStateChange.listen((event) {
      if (event.event == AuthChangeEvent.signedIn ||
          event.event == AuthChangeEvent.tokenRefreshed) {
        _persistSession(event.session);
      } else if (event.event == AuthChangeEvent.signedOut) {
        _clearSession();
      }
    });
  }

  @override
  User? get currentUser => _supabase.auth.currentUser;

  @override
  Stream<AuthState> get authStateChanges => _supabase.auth.onAuthStateChange;

  @override
  Future<AuthResponse> signUpWithEmail({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: {'name': name},
      );

      if (response.user != null) {
        // Create profile
        await _createProfile(
          userId: response.user!.id,
          email: email,
          name: name,
          provider: 'email',
        );
      }

      return response;
    } catch (e) {
      debugPrint('Email signup failed: $e');
      rethrow;
    }
  }

  @override
  Future<AuthResponse> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      return await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      debugPrint('Email login failed: $e');
      rethrow;
    }
  }

  @override
  Future<AuthResponse> signInWithGoogle() async {
    try {
      debugPrint('🔵 Google login started (Firebase + Supabase)');

      // 1. Google Sign-In
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        debugPrint('⚠️ Google login cancelled');
        throw Exception('Google login was cancelled');
      }

      debugPrint('🟢 Google Sign-In success: ${googleUser.email}');

      // 2. Get Google auth credentials
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final String? accessToken = googleAuth.accessToken;
      final String? idToken = googleAuth.idToken;

      if (idToken == null) {
        debugPrint('🔴 Cannot get ID Token');
        throw Exception('Cannot get Google ID token');
      }

      debugPrint('🎫 ID Token obtained');

      // 3. Sign in with Firebase Auth
      final firebase_auth.OAuthCredential credential =
          firebase_auth.GoogleAuthProvider.credential(
        accessToken: accessToken,
        idToken: idToken,
      );

      final firebase_auth.UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      debugPrint('🔥 Firebase login success: ${userCredential.user?.email}');

      // 4. Sign in to Supabase with ID token
      final response = await _supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );

      debugPrint('✅ Supabase login success: ${response.user?.email}');

      // 5. Ensure profile exists
      if (response.user != null) {
        await _ensureProfileExists(
          userId: response.user!.id,
          email: response.user!.email!,
          name: googleUser.displayName ?? 'Google User',
          provider: 'google',
          profileImageUrl: googleUser.photoUrl,
        );
      }

      return response;
    } catch (e, stackTrace) {
      debugPrint('🔴 Google login failed: $e');
      debugPrint('Stack trace: $stackTrace');
      rethrow;
    }
  }

  @override
  Future<AuthResponse> signInWithApple() async {
    try {
      // Apple Sign-In process
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final String? idToken = credential.identityToken;

      if (idToken == null) {
        throw Exception('Cannot get Apple ID token');
      }

      // Sign in to Supabase with Apple token
      final response = await _supabase.auth.signInWithIdToken(
        provider: OAuthProvider.apple,
        idToken: idToken,
      );

      if (response.user != null) {
        // Handle name (Apple provides name only on first login)
        String name = 'Apple User';
        if (credential.givenName != null || credential.familyName != null) {
          name =
              '${credential.familyName ?? ''}${credential.givenName ?? ''}'.trim();
          if (name.isEmpty) name = 'Apple User';
        }

        // Ensure profile exists
        await _ensureProfileExists(
          userId: response.user!.id,
          email: response.user!.email ??
              'apple_${response.user!.id}@privaterelay.appleid.com',
          name: name,
          provider: 'apple',
        );
      }

      return response;
    } catch (e) {
      debugPrint('Apple login failed: $e');
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      // Google Sign-Out
      await _googleSignIn.signOut();

      // Firebase Sign-Out
      await _firebaseAuth.signOut();

      // Supabase Sign-Out
      await _supabase.auth.signOut();

      debugPrint('✅ Sign out complete');
    } catch (e) {
      debugPrint('Sign out failed: $e');
      rethrow;
    }
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      await _supabase.auth.resetPasswordForEmail(email);
    } catch (e) {
      debugPrint('Password reset failed: $e');
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>?> getCurrentProfile() async {
    try {
      if (currentUser == null) return null;

      final response = await _supabase
          .from('profiles')
          .select()
          .eq('id', currentUser!.id)
          .single();

      return response;
    } catch (e) {
      debugPrint('Get profile failed: $e');
      return null;
    }
  }

  @override
  Future<void> completeOnboarding({
    required List<String> interests,
    required bool isFaithUser,
    required String coachingStyle,
    required String themeMode,
  }) async {
    try {
      if (currentUser == null) throw Exception('Login required');

      await _supabase.from('profiles').update({
        'interests': interests,
        'is_faith_user': isFaithUser,
        'coaching_style': coachingStyle,
        'theme_mode': themeMode,
        'onboarding_completed': true,
      }).eq('id', currentUser!.id);
    } catch (e) {
      debugPrint('Complete onboarding failed: $e');
      rethrow;
    }
  }

  /// Create profile
  Future<void> _createProfile({
    required String userId,
    required String email,
    required String name,
    required String provider,
    String? profileImageUrl,
  }) async {
    try {
      await _supabase.from('profiles').insert({
        'id': userId,
        'email': email,
        'name': name,
        'provider': provider,
        'profile_image_url': profileImageUrl,
        'onboarding_completed': false,
        'created_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      debugPrint('Create profile failed: $e');
      // Ignore profile creation failure (profile may already exist)
    }
  }

  /// Ensure profile exists
  Future<void> _ensureProfileExists({
    required String userId,
    required String email,
    required String name,
    required String provider,
    String? profileImageUrl,
  }) async {
    try {
      // Check if profile exists
      final response = await _supabase
          .from('profiles')
          .select()
          .eq('id', userId)
          .maybeSingle();

      if (response == null) {
        // Create profile if it doesn't exist
        await _createProfile(
          userId: userId,
          email: email,
          name: name,
          provider: provider,
          profileImageUrl: profileImageUrl,
        );
      }
    } catch (e) {
      debugPrint('Profile check failed: $e');
    }
  }

  /// Persist session to SharedPreferences
  Future<void> _persistSession(Session? session) async {
    if (session == null) return;

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(StorageKeys.accessToken, session.accessToken);
      await prefs.setString(
        StorageKeys.refreshToken,
        session.refreshToken ?? '',
      );
      await prefs.setString(StorageKeys.userId, session.user.id);
      debugPrint('✅ Session persisted');
    } catch (e) {
      debugPrint('Session persist failed: $e');
    }
  }

  /// Clear session from SharedPreferences
  Future<void> _clearSession() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(StorageKeys.accessToken);
      await prefs.remove(StorageKeys.refreshToken);
      await prefs.remove(StorageKeys.userId);
      debugPrint('✅ Session cleared');
    } catch (e) {
      debugPrint('Session clear failed: $e');
    }
  }
}
