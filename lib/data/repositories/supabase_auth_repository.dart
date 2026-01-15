import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;
import 'package:supabase_flutter/supabase_flutter.dart' as supabase show User;

import '../../core/constants/enums.dart';
import '../../core/errors/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/remote/supabase_auth_datasource.dart';
import '../models/profile_model.dart';

/// Supabase implementation of AuthRepository
/// Wraps SupabaseAuthDataSource and converts to clean architecture pattern
class SupabaseAuthRepository implements AuthRepository {
  final SupabaseAuthDataSource _dataSource;

  SupabaseAuthRepository(this._dataSource);

  @override
  Stream<User?> get authStateChanges {
    return _dataSource.authStateChanges.asyncMap((authState) async {
      final user = authState.session?.user;
      if (user == null) return null;

      try {
        final profile = await _dataSource.getCurrentProfile();
        if (profile == null) return null;

        final profileModel = ProfileModel.fromJson(profile);
        return profileModel.toEntity();
      } catch (e) {
        return null;
      }
    });
  }

  @override
  Future<Either<Failure, User?>> getCurrentUser() async {
    try {
      final supabaseUser = _dataSource.currentUser;
      if (supabaseUser == null) return const Right(null);

      // Fetch profile to get full user data
      final profile = await _dataSource.getCurrentProfile();
      if (profile == null) return const Right(null);

      final profileModel = ProfileModel.fromJson(profile);
      final user = profileModel.toEntity();
      return Right(user);
    } on AuthException catch (e) {
      return Left(Failure.authentication(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> signUpWithEmail({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final response = await _dataSource.signUpWithEmail(
        email: email,
        password: password,
        name: name,
      );

      if (response.user == null) {
        return Left(Failure.authentication(message: 'Signup failed'));
      }

      final profile = await _dataSource.getCurrentProfile();
      final user = _mapProfileToUser(response.user!, profile ?? {});
      return Right(user);
    } on AuthException catch (e) {
      return Left(Failure.authentication(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dataSource.signInWithEmail(
        email: email,
        password: password,
      );

      if (response.user == null) {
        return Left(Failure.authentication(message: 'Login failed'));
      }

      final profile = await _dataSource.getCurrentProfile();
      final user = _mapProfileToUser(response.user!, profile ?? {});
      return Right(user);
    } on AuthException catch (e) {
      return Left(Failure.authentication(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> loginWithGoogle() async {
    try {
      final response = await _dataSource.signInWithGoogle();

      if (response.user == null) {
        return Left(Failure.authentication(message: 'Google login failed'));
      }

      final profile = await _dataSource.getCurrentProfile();
      final user = _mapProfileToUser(response.user!, profile ?? {});
      return Right(user);
    } on AuthException catch (e) {
      return Left(Failure.authentication(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> loginWithApple() async {
    try {
      final response = await _dataSource.signInWithApple();

      if (response.user == null) {
        return Left(Failure.authentication(message: 'Apple login failed'));
      }

      final profile = await _dataSource.getCurrentProfile();
      final user = _mapProfileToUser(response.user!, profile ?? {});
      return Right(user);
    } on AuthException catch (e) {
      return Left(Failure.authentication(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> loginWithKakao() async {
    // TODO: Implement Kakao login when needed
    return Left(Failure.unknown(
      message: 'Kakao login not implemented yet',
    ));
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _dataSource.signOut();
      return const Right(null);
    } on AuthException catch (e) {
      return Left(Failure.authentication(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword(String email) async {
    try {
      await _dataSource.resetPassword(email);
      return const Right(null);
    } on AuthException catch (e) {
      return Left(Failure.authentication(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> updateProfile({
    String? name,
    String? photoUrl,
  }) async {
    try {
      final currentUser = await getCurrentUser();
      if (currentUser.isLeft()) {
        return Left(Failure.authentication(message: 'User not logged in'));
      }

      // Update profile in Supabase
      final supabaseUser = _dataSource.currentUser;
      if (supabaseUser == null) {
        return Left(Failure.authentication(message: 'User not logged in'));
      }

      await Supabase.instance.client.from('profiles').update({
        if (name != null) 'name': name,
        if (photoUrl != null) 'profile_image_url': photoUrl,
      }).eq('id', supabaseUser.id);

      // Fetch updated profile
      final profile = await _dataSource.getCurrentProfile();
      final user = _mapProfileToUser(supabaseUser, profile ?? {});
      return Right(user);
    } on AuthException catch (e) {
      return Left(Failure.authentication(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> updateSettings(UserSettings settings) async {
    try {
      final currentUser = await getCurrentUser();
      if (currentUser.isLeft()) {
        return Left(Failure.authentication(message: 'User not logged in'));
      }

      // Update settings in Supabase
      final supabaseUser = _dataSource.currentUser;
      if (supabaseUser == null) {
        return Left(Failure.authentication(message: 'User not logged in'));
      }

      await Supabase.instance.client.from('profiles').update({
        'theme_mode': settings.theme.name,
        'coaching_style': settings.personality.name,
        'interests': settings.interests,
        'is_faith_user': settings.isFaithUser,
      }).eq('id', supabaseUser.id);

      // Fetch updated profile
      final profile = await _dataSource.getCurrentProfile();
      final user = _mapProfileToUser(supabaseUser, profile ?? {});
      return Right(user);
    } on AuthException catch (e) {
      return Left(Failure.authentication(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAccount() async {
    try {
      final supabaseUser = _dataSource.currentUser;
      if (supabaseUser == null) {
        return Left(Failure.authentication(message: 'User not logged in'));
      }

      // Delete profile
      await Supabase.instance.client
          .from('profiles')
          .delete()
          .eq('id', supabaseUser.id);

      // Sign out
      await _dataSource.signOut();

      return const Right(null);
    } on AuthException catch (e) {
      return Left(Failure.authentication(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>?>> getCurrentProfile() async {
    try {
      final profile = await _dataSource.getCurrentProfile();
      return Right(profile);
    } on AuthException catch (e) {
      return Left(Failure.authentication(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> completeOnboarding({
    required List<String> interests,
    required bool isFaithUser,
    required String coachingStyle,
    required String themeMode,
  }) async {
    try {
      await _dataSource.completeOnboarding(
        interests: interests,
        isFaithUser: isFaithUser,
        coachingStyle: coachingStyle,
        themeMode: themeMode,
      );
      return const Right(null);
    } on AuthException catch (e) {
      return Left(Failure.authentication(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  /// Map Supabase user + profile to domain User entity
  User _mapProfileToUser(
    supabase.User supabaseUser,
    Map<String, dynamic> profile,
  ) {
    // Parse theme
    AppTheme theme = AppTheme.universal;
    final themeMode = profile['theme_mode'];
    if (themeMode != null) {
      try {
        theme = AppTheme.values.firstWhere(
          (e) => e.name == themeMode,
          orElse: () => AppTheme.universal,
        );
      } catch (_) {}
    }

    // Parse personality
    PersonalityType personality = PersonalityType.feeling;
    final coachingStyle = profile['coaching_style'];
    if (coachingStyle != null) {
      try {
        personality = PersonalityType.values.firstWhere(
          (e) => e.name == coachingStyle,
          orElse: () => PersonalityType.feeling,
        );
      } catch (_) {}
    }

    return User(
      id: supabaseUser.id,
      name: profile['name'] ?? supabaseUser.email ?? 'User',
      email: supabaseUser.email,
      photoUrl: profile['profile_image_url'],
      settings: UserSettings(
        theme: theme,
        personality: personality,
        notificationsEnabled: true,
        onboardingCompleted: profile['onboarding_completed'] ?? false,
        interests: (profile['interests'] as List?)?.cast<String>(),
        isFaithUser: profile['is_faith_user'],
        coachingStyle: coachingStyle,
        provider: profile['provider'],
      ),
      createdAt: profile['created_at'] != null
          ? DateTime.parse(profile['created_at'])
          : DateTime.now(),
      lastLoginAt: profile['last_login_at'] != null
          ? DateTime.parse(profile['last_login_at'])
          : null,
    );
  }
}
