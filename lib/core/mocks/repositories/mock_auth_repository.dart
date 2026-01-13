import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/errors/failures.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../data/mock_users.dart';

/// Mock implementation of AuthRepository
/// Used for development before real API is ready
class MockAuthRepository implements AuthRepository {
  final SharedPreferences _prefs;
  final _authStateController = StreamController<User?>.broadcast();

  static const String _userIdKey = 'mock_user_id';
  static const String _userDataKey = 'mock_user_data';

  MockAuthRepository(this._prefs) {
    // Emit initial state
    _loadUser().then((user) {
      _authStateController.add(user);
    });
  }

  @override
  Stream<User?> get authStateChanges => _authStateController.stream;

  @override
  Future<Either<Failure, User?>> getCurrentUser() async {
    try {
      final user = await _loadUser();
      return Right(user);
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> loginWithGoogle() async {
    return _performMockLogin('Google');
  }

  @override
  Future<Either<Failure, User>> loginWithApple() async {
    return _performMockLogin('Apple');
  }

  @override
  Future<Either<Failure, User>> loginWithKakao() async {
    return _performMockLogin('Kakao');
  }

  Future<Either<Failure, User>> _performMockLogin(String provider) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      // Get default mock user
      final userModel = MockUsers.defaultUser;
      final user = userModel.toEntity();

      // Save to SharedPreferences
      await _saveUser(user);

      // Emit state change
      _authStateController.add(user);

      return Right(user);
    } catch (e) {
      return Left(Failure.server(message: 'Login with $provider failed: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));

      // Clear SharedPreferences
      await _prefs.remove(_userIdKey);
      await _prefs.remove(_userDataKey);

      // Emit state change
      _authStateController.add(null);

      return const Right(null);
    } catch (e) {
      return Left(Failure.server(message: 'Logout failed: $e'));
    }
  }

  @override
  Future<Either<Failure, User>> updateProfile({
    String? name,
    String? photoUrl,
  }) async {
    try {
      final currentUser = await _loadUser();
      if (currentUser == null) {
        return Left(Failure.authentication(message: 'User not logged in'));
      }

      final updatedUser = currentUser.copyWith(
        name: name ?? currentUser.name,
        photoUrl: photoUrl ?? currentUser.photoUrl,
      );

      await _saveUser(updatedUser);
      _authStateController.add(updatedUser);

      return Right(updatedUser);
    } catch (e) {
      return Left(Failure.server(message: 'Update profile failed: $e'));
    }
  }

  @override
  Future<Either<Failure, User>> updateSettings(UserSettings settings) async {
    try {
      final currentUser = await _loadUser();
      if (currentUser == null) {
        return Left(Failure.authentication(message: 'User not logged in'));
      }

      final updatedUser = currentUser.copyWith(settings: settings);

      await _saveUser(updatedUser);
      _authStateController.add(updatedUser);

      return Right(updatedUser);
    } catch (e) {
      return Left(Failure.server(message: 'Update settings failed: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAccount() async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));

      await _prefs.remove(_userIdKey);
      await _prefs.remove(_userDataKey);

      _authStateController.add(null);

      return const Right(null);
    } catch (e) {
      return Left(Failure.server(message: 'Delete account failed: $e'));
    }
  }

  /// Load user from SharedPreferences
  Future<User?> _loadUser() async {
    final userId = _prefs.getString(_userIdKey);
    if (userId == null) return null;

    final userJson = _prefs.getString(_userDataKey);
    if (userJson == null) return null;

    try {
      // In a real app, we would deserialize from JSON
      // For now, just return the default mock user with stored ID
      return MockUsers.defaultUser.toEntity();
    } catch (e) {
      return null;
    }
  }

  /// Save user to SharedPreferences
  Future<void> _saveUser(User user) async {
    await _prefs.setString(_userIdKey, user.id);
    // In a real app, we would serialize to JSON
    // For now, just save the ID
  }

  void dispose() {
    _authStateController.close();
  }
}
