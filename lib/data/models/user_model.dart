import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/constants/enums.dart';
import '../../domain/entities/user.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

/// User data model for JSON serialization
@freezed
class UserModel with _$UserModel {
  const UserModel._();

  const factory UserModel({
    required String id,
    required String name,
    String? email,
    String? photoUrl,
    required UserSettingsModel settings,
    required DateTime createdAt,
    DateTime? lastLoginAt,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  /// Convert to domain entity
  User toEntity() {
    return User(
      id: id,
      name: name,
      email: email,
      photoUrl: photoUrl,
      settings: settings.toEntity(),
      createdAt: createdAt,
      lastLoginAt: lastLoginAt,
    );
  }

  /// Create from domain entity
  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      name: user.name,
      email: user.email,
      photoUrl: user.photoUrl,
      settings: UserSettingsModel.fromEntity(user.settings),
      createdAt: user.createdAt,
      lastLoginAt: user.lastLoginAt,
    );
  }
}

/// User settings data model
@freezed
class UserSettingsModel with _$UserSettingsModel {
  const UserSettingsModel._();

  const factory UserSettingsModel({
    required String theme, // 'faith' or 'universal'
    required String personality, // 'feeling' or 'thinking'
    @Default(true) bool notificationsEnabled,
    String? preferredNotificationTime,
    @Default(false) bool onboardingCompleted,
  }) = _UserSettingsModel;

  factory UserSettingsModel.fromJson(Map<String, dynamic> json) =>
      _$UserSettingsModelFromJson(json);

  /// Convert to domain entity
  UserSettings toEntity() {
    return UserSettings(
      theme: theme == 'faith' ? AppTheme.faith : AppTheme.universal,
      personality: personality == 'feeling'
          ? PersonalityType.feeling
          : PersonalityType.thinking,
      notificationsEnabled: notificationsEnabled,
      preferredNotificationTime: preferredNotificationTime,
      onboardingCompleted: onboardingCompleted,
    );
  }

  /// Create from domain entity
  factory UserSettingsModel.fromEntity(UserSettings settings) {
    return UserSettingsModel(
      theme: settings.theme == AppTheme.faith ? 'faith' : 'universal',
      personality: settings.personality == PersonalityType.feeling
          ? 'feeling'
          : 'thinking',
      notificationsEnabled: settings.notificationsEnabled,
      preferredNotificationTime: settings.preferredNotificationTime,
      onboardingCompleted: settings.onboardingCompleted,
    );
  }
}
