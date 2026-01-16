import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants/app_constants.dart';
import 'auth_remote_datasource.dart';

/// Supabase Auth Data Source
/// Implements Supabase native OAuth for authentication
class SupabaseAuthDataSource implements AuthRemoteDataSource {
  final SupabaseClient _supabase = Supabase.instance.client;

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
      debugPrint('🔵 Google login started (Supabase OAuth Flow)');

      // 1. Start OAuth flow with in-app WebView
      final bool success = await _supabase.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: kIsWeb ? null : 'com.eggdory.godlifeapp://login-callback',
        // Use in-app browser for seamless experience
        authScreenLaunchMode: LaunchMode.platformDefault,
      );

      if (!success) {
        debugPrint('⚠️ Google OAuth flow failed to start');
        throw Exception('Google login was cancelled');
      }

      debugPrint('✅ OAuth flow initiated, waiting for auth state change...');

      // 2. Wait for auth state change (login completion)
      final completer = Completer<AuthResponse>();
      StreamSubscription<AuthState>? subscription;

      subscription = _supabase.auth.onAuthStateChange.listen(
        (event) {
          debugPrint('🔔 Auth State Changed: ${event.event}');

          if (event.event == AuthChangeEvent.signedIn && event.session != null) {
            debugPrint('✅ User signed in: ${event.session!.user.email}');

            if (!completer.isCompleted) {
              completer.complete(AuthResponse(
                session: event.session,
                user: event.session!.user,
              ));
            }
            subscription?.cancel();
          } else if (event.event == AuthChangeEvent.signedOut) {
            debugPrint('⚠️ Sign out detected during login');
          }
        },
        onError: (error) {
          debugPrint('🔴 Auth state change error: $error');
          if (!completer.isCompleted) {
            completer.completeError(error);
          }
          subscription?.cancel();
        },
      );

      // 3. Wait for login to complete (with timeout)
      final authResponse = await completer.future.timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          subscription?.cancel();
          throw Exception('Google 로그인 시간 초과. 다시 시도해주세요.');
        },
      );

      debugPrint('✅ Supabase login success: ${authResponse.user?.email}');

      // 4. Ensure profile exists
      if (authResponse.user != null) {
        final metadata = authResponse.user!.userMetadata ?? {};
        final name = metadata['full_name'] ??
                     metadata['name'] ??
                     authResponse.user!.email?.split('@').first ??
                     'Google User';

        await _ensureProfileExists(
          userId: authResponse.user!.id,
          email: authResponse.user!.email!,
          name: name,
          provider: 'google',
          profileImageUrl: metadata['avatar_url'] as String?,
        );
      }

      return authResponse;
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
