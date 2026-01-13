import '../../../data/models/user_model.dart';

/// Mock user data for development
/// From MOCK_DATA_GUIDE.md
class MockUsers {
  static final user1 = UserModel(
    id: 'user_001',
    name: '홍길동',
    email: 'hong@example.com',
    photoUrl: null,
    settings: const UserSettingsModel(
      theme: 'faith',
      personality: 'feeling',
      notificationsEnabled: true,
      preferredNotificationTime: '07:00',
      onboardingCompleted: true,
    ),
    createdAt: DateTime(2024, 1, 1),
    lastLoginAt: DateTime.now(),
  );

  static final user2 = UserModel(
    id: 'user_002',
    name: '김영희',
    email: 'kim@example.com',
    photoUrl: null,
    settings: const UserSettingsModel(
      theme: 'universal',
      personality: 'thinking',
      notificationsEnabled: true,
      preferredNotificationTime: '09:00',
      onboardingCompleted: true,
    ),
    createdAt: DateTime(2024, 2, 1),
    lastLoginAt: DateTime.now(),
  );

  static final user3 = UserModel(
    id: 'user_003',
    name: '이철수',
    email: 'lee@example.com',
    photoUrl: null,
    settings: const UserSettingsModel(
      theme: 'faith',
      personality: 'thinking',
      notificationsEnabled: false,
      onboardingCompleted: true,
    ),
    createdAt: DateTime(2024, 3, 1),
    lastLoginAt: DateTime.now(),
  );

  /// Get default mock user (for login simulation)
  static UserModel get defaultUser => user1;

  /// Get all mock users
  static List<UserModel> get all => [user1, user2, user3];
}
