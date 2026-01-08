class AppConstants {
  static const String appName = 'God Life';
  static const String appVersion = '1.0.0';
  
  static const int maxRoutineCount = 5;
  static const int maxArchivedRoutineCount = 20;
  static const int dailyCoachingLimit = 3;
  static const int freeCoachingQuota = 10;
  
  static const Duration apiTimeout = Duration(seconds: 30);
  static const Duration coachingTimeout = Duration(seconds: 60);
  
  static const int maxMessageLength = 500;
  static const int maxRoutineNameLength = 50;
  static const int maxRoutineDescriptionLength = 200;
}

class ApiEndpoints {
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://api.godlife.app',
  );
  
  static const String auth = '/auth';
  static const String users = '/users';
  static const String routines = '/routines';
  static const String coaching = '/coaching';
  static const String reports = '/reports';
  static const String notifications = '/notifications';
}

class StorageKeys {
  static const String accessToken = 'access_token';
  static const String refreshToken = 'refresh_token';
  static const String userId = 'user_id';
  static const String userTheme = 'user_theme';
  static const String personalityType = 'personality_type';
  static const String notificationEnabled = 'notification_enabled';
  static const String onboardingCompleted = 'onboarding_completed';
}
