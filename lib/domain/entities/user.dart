import '../../core/constants/enums.dart';

/// User entity (pure business object)
/// Represents a user in the God Life app
class User {
  final String id;
  final String name;
  final String? email;
  final String? photoUrl;
  final UserSettings settings;
  final DateTime createdAt;
  final DateTime? lastLoginAt;

  const User({
    required this.id,
    required this.name,
    this.email,
    this.photoUrl,
    required this.settings,
    required this.createdAt,
    this.lastLoginAt,
  });

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? photoUrl,
    UserSettings? settings,
    DateTime? createdAt,
    DateTime? lastLoginAt,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      settings: settings ?? this.settings,
      createdAt: createdAt ?? this.createdAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'User{id: $id, name: $name, email: $email}';
  }
}

/// User settings entity
class UserSettings {
  final AppTheme theme; // Faith or Universal
  final PersonalityType personality; // F or T
  final bool notificationsEnabled;
  final String? preferredNotificationTime;
  final bool onboardingCompleted;
  final List<String>? interests;
  final bool? isFaithUser;
  final String? coachingStyle;
  final String? provider; // 'email', 'google', 'apple'

  const UserSettings({
    required this.theme,
    required this.personality,
    this.notificationsEnabled = true,
    this.preferredNotificationTime,
    this.onboardingCompleted = false,
    this.interests,
    this.isFaithUser,
    this.coachingStyle,
    this.provider,
  });

  UserSettings copyWith({
    AppTheme? theme,
    PersonalityType? personality,
    bool? notificationsEnabled,
    String? preferredNotificationTime,
    bool? onboardingCompleted,
    List<String>? interests,
    bool? isFaithUser,
    String? coachingStyle,
    String? provider,
  }) {
    return UserSettings(
      theme: theme ?? this.theme,
      personality: personality ?? this.personality,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      preferredNotificationTime:
          preferredNotificationTime ?? this.preferredNotificationTime,
      onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
      interests: interests ?? this.interests,
      isFaithUser: isFaithUser ?? this.isFaithUser,
      coachingStyle: coachingStyle ?? this.coachingStyle,
      provider: provider ?? this.provider,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserSettings &&
          runtimeType == other.runtimeType &&
          theme == other.theme &&
          personality == other.personality;

  @override
  int get hashCode => theme.hashCode ^ personality.hashCode;
}
