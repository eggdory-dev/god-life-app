import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../services/auth_service.dart';

/// AuthService Provider
final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

/// 현재 사용자 Provider
final currentUserProvider = StreamProvider<User?>((ref) {
  final authService = ref.watch(authServiceProvider);
  return authService.authStateChanges.map((event) => event.session?.user);
});

/// 로그인 상태 Provider
final isAuthenticatedProvider = Provider<bool>((ref) {
  final user = ref.watch(currentUserProvider);
  return user.when(
    data: (user) => user != null,
    loading: () => false,
    error: (_, __) => false,
  );
});

/// 현재 사용자 프로필 Provider
final currentProfileProvider = FutureProvider<Map<String, dynamic>?>((ref) async {
  final authService = ref.watch(authServiceProvider);
  return await authService.getCurrentProfile();
});

/// 온보딩 완료 여부 Provider
final onboardingCompletedProvider = Provider<bool>((ref) {
  final profile = ref.watch(currentProfileProvider);
  return profile.when(
    data: (profile) => profile?['onboarding_completed'] ?? false,
    loading: () => false,
    error: (_, __) => false,
  );
});
