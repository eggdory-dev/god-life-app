import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// 인증 서비스
/// Firebase Auth + Supabase를 사용한 사용자 인증 관리
class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;
  final firebase_auth.FirebaseAuth _firebaseAuth = firebase_auth.FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  /// 현재 로그인한 사용자
  User? get currentUser => _supabase.auth.currentUser;

  /// 로그인 상태 스트림
  Stream<AuthState> get authStateChanges => _supabase.auth.onAuthStateChange;

  /// 이메일 회원가입
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
        // 프로필 생성
        await _createProfile(
          userId: response.user!.id,
          email: email,
          name: name,
          provider: 'email',
        );
      }

      return response;
    } catch (e) {
      debugPrint('이메일 회원가입 실패: $e');
      rethrow;
    }
  }

  /// 이메일 로그인
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
      debugPrint('이메일 로그인 실패: $e');
      rethrow;
    }
  }

  /// Google 로그인
  /// Firebase Auth + Supabase 통합
  Future<AuthResponse> signInWithGoogle() async {
    try {
      debugPrint('🔵 Google 로그인 시작 (Firebase + Supabase)');

      // 1. Google Sign-In
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        debugPrint('⚠️ Google 로그인 취소됨');
        throw Exception('Google 로그인이 취소되었습니다');
      }

      debugPrint('🟢 Google Sign-In 성공: ${googleUser.email}');

      // 2. Google 인증 정보 가져오기
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final String? accessToken = googleAuth.accessToken;
      final String? idToken = googleAuth.idToken;

      if (idToken == null) {
        debugPrint('🔴 ID Token을 가져올 수 없음');
        throw Exception('Google ID 토큰을 가져올 수 없습니다');
      }

      debugPrint('🎫 ID Token 획득');

      // 3. Firebase Auth로 로그인
      final firebase_auth.OAuthCredential credential =
          firebase_auth.GoogleAuthProvider.credential(
        accessToken: accessToken,
        idToken: idToken,
      );

      final firebase_auth.UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      debugPrint('🔥 Firebase 로그인 성공: ${userCredential.user?.email}');

      // 4. Supabase에 토큰으로 로그인
      final response = await _supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );

      debugPrint('✅ Supabase 로그인 성공: ${response.user?.email}');

      // 5. 프로필 확인 및 생성
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
      debugPrint('🔴 Google 로그인 실패: $e');
      debugPrint('Stack trace: $stackTrace');
      rethrow;
    }
  }

  /// Apple 로그인
  Future<AuthResponse> signInWithApple() async {
    try {
      // Apple Sign-In 프로세스
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final String? idToken = credential.identityToken;

      if (idToken == null) {
        throw Exception('Apple ID 토큰을 가져올 수 없습니다');
      }

      // Supabase Auth에 Apple 토큰 전달
      final response = await _supabase.auth.signInWithIdToken(
        provider: OAuthProvider.apple,
        idToken: idToken,
      );

      if (response.user != null) {
        // 이름 처리 (Apple은 첫 로그인 시에만 이름 제공)
        String name = 'Apple User';
        if (credential.givenName != null || credential.familyName != null) {
          name =
              '${credential.familyName ?? ''}${credential.givenName ?? ''}'.trim();
          if (name.isEmpty) name = 'Apple User';
        }

        // 프로필 확인 및 생성
        await _ensureProfileExists(
          userId: response.user!.id,
          email: response.user!.email ?? 'apple_${response.user!.id}@privaterelay.appleid.com',
          name: name,
          provider: 'apple',
        );
      }

      return response;
    } catch (e) {
      debugPrint('Apple 로그인 실패: $e');
      rethrow;
    }
  }

  /// 로그아웃
  Future<void> signOut() async {
    try {
      // Google Sign-Out
      await _googleSignIn.signOut();

      // Firebase Sign-Out
      await _firebaseAuth.signOut();

      // Supabase 로그아웃
      await _supabase.auth.signOut();

      debugPrint('✅ 로그아웃 완료');
    } catch (e) {
      debugPrint('로그아웃 실패: $e');
      rethrow;
    }
  }

  /// 비밀번호 재설정 이메일 전송
  Future<void> resetPassword(String email) async {
    try {
      await _supabase.auth.resetPasswordForEmail(email);
    } catch (e) {
      debugPrint('비밀번호 재설정 실패: $e');
      rethrow;
    }
  }

  /// 프로필 생성
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
      debugPrint('프로필 생성 실패: $e');
      // 프로필 생성 실패는 무시 (이미 존재하는 경우)
    }
  }

  /// 프로필 존재 여부 확인 및 생성
  Future<void> _ensureProfileExists({
    required String userId,
    required String email,
    required String name,
    required String provider,
    String? profileImageUrl,
  }) async {
    try {
      // 프로필 존재 여부 확인
      final response = await _supabase
          .from('profiles')
          .select()
          .eq('id', userId)
          .maybeSingle();

      if (response == null) {
        // 프로필이 없으면 생성
        await _createProfile(
          userId: userId,
          email: email,
          name: name,
          provider: provider,
          profileImageUrl: profileImageUrl,
        );
      }
    } catch (e) {
      debugPrint('프로필 확인 실패: $e');
    }
  }

  /// 현재 사용자 프로필 조회
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
      debugPrint('프로필 조회 실패: $e');
      return null;
    }
  }

  /// 온보딩 완료 처리
  Future<void> completeOnboarding({
    required List<String> interests,
    required bool isFaithUser,
    required String coachingStyle,
    required String themeMode,
  }) async {
    try {
      if (currentUser == null) throw Exception('로그인이 필요합니다');

      await _supabase.from('profiles').update({
        'interests': interests,
        'is_faith_user': isFaithUser,
        'coaching_style': coachingStyle,
        'theme_mode': themeMode,
        'onboarding_completed': true,
      }).eq('id', currentUser!.id);
    } catch (e) {
      debugPrint('온보딩 완료 처리 실패: $e');
      rethrow;
    }
  }
}
