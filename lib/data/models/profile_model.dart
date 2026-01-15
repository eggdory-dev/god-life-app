import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/constants/enums.dart';
import '../../domain/entities/user.dart';

part 'profile_model.freezed.dart';
part 'profile_model.g.dart';

/// Profile model for Supabase profiles table
@freezed
class ProfileModel with _$ProfileModel {
  const ProfileModel._();

  const factory ProfileModel({
    required String id,
    required String email,
    required String name,
    @JsonKey(name: 'profile_image_url') String? profileImageUrl,
    String? provider,
    List<String>? interests,
    @JsonKey(name: 'is_faith_user') bool? isFaithUser,
    @JsonKey(name: 'coaching_style') String? coachingStyle,
    @JsonKey(name: 'theme_mode') String? themeMode,
    @JsonKey(name: 'onboarding_completed') bool? onboardingCompleted,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'last_login_at') DateTime? lastLoginAt,
  }) = _ProfileModel;

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);

  /// Convert ProfileModel to User entity
  User toEntity() {
    // Parse theme
    AppTheme theme = AppTheme.universal;
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
    if (coachingStyle != null) {
      try {
        personality = PersonalityType.values.firstWhere(
          (e) => e.name == coachingStyle,
          orElse: () => PersonalityType.feeling,
        );
      } catch (_) {}
    }

    return User(
      id: id,
      name: name,
      email: email,
      photoUrl: profileImageUrl,
      settings: UserSettings(
        theme: theme,
        personality: personality,
        notificationsEnabled: true,
        onboardingCompleted: onboardingCompleted ?? false,
        interests: interests,
        isFaithUser: isFaithUser,
        coachingStyle: coachingStyle,
        provider: provider,
      ),
      createdAt: createdAt ?? DateTime.now(),
      lastLoginAt: lastLoginAt,
    );
  }
}
