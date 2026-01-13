import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/coaching_repository.dart';
import '../../domain/repositories/routine_repository.dart';
import '../constants/enums.dart';
import '../mocks/repositories/mock_auth_repository.dart';
import '../mocks/repositories/mock_coaching_repository.dart';
import '../mocks/repositories/mock_routine_repository.dart';
import '../notifications/notification_service.dart';

/// SharedPreferences instance provider
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('SharedPreferences not initialized');
});

/// Theme mode provider
/// Controls Faith/Universal theme switching
final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, AppTheme>(
  (ref) => ThemeModeNotifier(ref.read(sharedPreferencesProvider)),
);

class ThemeModeNotifier extends StateNotifier<AppTheme> {
  final SharedPreferences _prefs;
  static const String _key = 'app_theme';

  ThemeModeNotifier(this._prefs) : super(_loadTheme(_prefs));

  static AppTheme _loadTheme(SharedPreferences prefs) {
    final themeString = prefs.getString(_key);
    if (themeString == 'universal') {
      return AppTheme.universal;
    }
    return AppTheme.faith; // Default to faith theme
  }

  void setTheme(AppTheme theme) {
    state = theme;
    _prefs.setString(_key, theme.name);
  }

  void toggleTheme() {
    state = state == AppTheme.faith ? AppTheme.universal : AppTheme.faith;
    _prefs.setString(_key, state.name);
  }
}

/// Repository Providers
///
/// For Week 3-6, we use mock repositories
/// Later, these will switch to real API implementations via feature flags

/// Auth repository provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  // For now, always use mock
  return MockAuthRepository(prefs);

  // Future: Use feature flags to switch
  // if (FeatureFlags.useMockAuth) {
  //   return MockAuthRepository(prefs);
  // }
  // return AuthRepositoryImpl(ref.read(dioProvider));
});

/// Routine repository provider
final routineRepositoryProvider = Provider<RoutineRepository>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  // For now, always use mock
  return MockRoutineRepository(prefs);

  // Future: Use feature flags to switch
  // if (FeatureFlags.useMockRoutines) {
  //   return MockRoutineRepository(prefs);
  // }
  // return RoutineRepositoryImpl(
  //   ref.read(routineApiProvider),
  //   ref.read(routineDaoProvider),
  // );
});

/// Coaching repository provider
final coachingRepositoryProvider = Provider<CoachingRepository>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  // For now, always use mock
  return MockCoachingRepository(prefs);

  // Future: Use feature flags to switch
  // if (FeatureFlags.useMockCoaching) {
  //   return MockCoachingRepository(prefs);
  // }
  // return CoachingRepositoryImpl(ref.read(aiApiProvider));
});

/// Notification service provider
final notificationServiceProvider = Provider<NotificationService>((ref) {
  return NotificationService();
});
