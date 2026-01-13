import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/entities/user.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../../core/providers/core_providers.dart';
import '../../../core/mocks/repositories/mock_auth_repository.dart';

part 'auth_provider.g.dart';

/// Auth repository provider
@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  // For Week 3-4, use MockAuthRepository
  // In Week 11+, switch to real implementation
  return MockAuthRepository(prefs);
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
