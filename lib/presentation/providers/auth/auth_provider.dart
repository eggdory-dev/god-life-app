import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/datasources/remote/supabase_auth_datasource.dart';
import '../../../data/repositories/supabase_auth_repository.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../../core/providers/core_providers.dart';

part 'auth_provider.g.dart';

/// Auth repository provider
/// Uses real Supabase implementation
@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  final dataSource = SupabaseAuthDataSource();
  return SupabaseAuthRepository(dataSource);
}

/// Auth state provider
/// Manages current user authentication state
@riverpod
class Auth extends _$Auth {
  @override
  Future<User?> build() async {
    final repo = ref.watch(authRepositoryProvider);
    final result = await repo.getCurrentUser();

    return result.fold(
      (failure) => null,
      (user) => user,
    );
  }

  /// Sign up with email
  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required String name,
  }) async {
    state = const AsyncLoading();

    final repo = ref.read(authRepositoryProvider);
    final result = await repo.signUpWithEmail(
      email: email,
      password: password,
      name: name,
    );

    result.fold(
      (failure) {
        state = AsyncError(failure, StackTrace.current);
      },
      (user) {
        state = AsyncData(user);
      },
    );
  }

  /// Sign in with email
  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();

    final repo = ref.read(authRepositoryProvider);
    final result = await repo.signInWithEmail(
      email: email,
      password: password,
    );

    result.fold(
      (failure) {
        state = AsyncError(failure, StackTrace.current);
      },
      (user) {
        state = AsyncData(user);
      },
    );
  }

  /// Login with Google
  Future<void> loginWithGoogle() async {
    state = const AsyncLoading();

    final repo = ref.read(authRepositoryProvider);
    final result = await repo.loginWithGoogle();

    result.fold(
      (failure) {
        state = AsyncError(failure, StackTrace.current);
      },
      (user) {
        state = AsyncData(user);
      },
    );
  }

  /// Login with Apple
  Future<void> loginWithApple() async {
    state = const AsyncLoading();

    final repo = ref.read(authRepositoryProvider);
    final result = await repo.loginWithApple();

    result.fold(
      (failure) {
        state = AsyncError(failure, StackTrace.current);
      },
      (user) {
        state = AsyncData(user);
      },
    );
  }

  /// Login with Kakao
  Future<void> loginWithKakao() async {
    state = const AsyncLoading();

    final repo = ref.read(authRepositoryProvider);
    final result = await repo.loginWithKakao();

    result.fold(
      (failure) {
        state = AsyncError(failure, StackTrace.current);
      },
      (user) {
        state = AsyncData(user);
      },
    );
  }

  /// Logout
  Future<void> logout() async {
    final repo = ref.read(authRepositoryProvider);
    final result = await repo.logout();

    result.fold(
      (failure) {
        // Handle error but still clear state
        state = const AsyncData(null);
      },
      (_) {
        state = const AsyncData(null);
      },
    );
  }

  /// Update user profile
  Future<void> updateProfile({String? name, String? photoUrl}) async {
    final repo = ref.read(authRepositoryProvider);
    final result = await repo.updateProfile(name: name, photoUrl: photoUrl);

    result.fold(
      (failure) {
        state = AsyncError(failure, StackTrace.current);
      },
      (user) {
        state = AsyncData(user);
      },
    );
  }

  /// Update user settings
  Future<void> updateSettings(UserSettings settings) async {
    final repo = ref.read(authRepositoryProvider);
    final result = await repo.updateSettings(settings);

    result.fold(
      (failure) {
        state = AsyncError(failure, StackTrace.current);
      },
      (user) {
        state = AsyncData(user);

        // Update theme provider when settings change
        if (user.settings.theme != ref.read(themeModeProvider)) {
          ref.read(themeModeProvider.notifier).setTheme(user.settings.theme);
        }
      },
    );
  }
}

/// Stream provider for auth state changes
@riverpod
Stream<User?> authStateChanges(AuthStateChangesRef ref) {
  final repo = ref.watch(authRepositoryProvider);
  return repo.authStateChanges;
}

/// Current user stream provider
@riverpod
Stream<User?> currentUserStream(CurrentUserStreamRef ref) {
  return ref.watch(authStateChangesProvider);
}

/// Is authenticated provider
@riverpod
bool isAuthenticated(IsAuthenticatedRef ref) {
  final userAsync = ref.watch(authProvider);
  return userAsync.when(
    data: (user) => user != null,
    loading: () => false,
    error: (_, __) => false,
  );
}

/// Current profile provider
@riverpod
Future<Map<String, dynamic>?> currentProfile(CurrentProfileRef ref) async {
  final repo = ref.watch(authRepositoryProvider);
  final result = await repo.getCurrentProfile();
  return result.fold(
    (failure) => null,
    (profile) => profile,
  );
}

/// Onboarding completed provider
@riverpod
Future<bool> onboardingCompleted(OnboardingCompletedRef ref) async {
  final profile = await ref.watch(currentProfileProvider.future);
  return profile?['onboarding_completed'] ?? false;
}
