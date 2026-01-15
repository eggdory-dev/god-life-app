// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProfileModelImpl _$$ProfileModelImplFromJson(Map<String, dynamic> json) =>
    _$ProfileModelImpl(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      profileImageUrl: json['profile_image_url'] as String?,
      provider: json['provider'] as String?,
      interests: (json['interests'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      isFaithUser: json['is_faith_user'] as bool?,
      coachingStyle: json['coaching_style'] as String?,
      themeMode: json['theme_mode'] as String?,
      onboardingCompleted: json['onboarding_completed'] as bool?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      lastLoginAt: json['last_login_at'] == null
          ? null
          : DateTime.parse(json['last_login_at'] as String),
    );

Map<String, dynamic> _$$ProfileModelImplToJson(_$ProfileModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'profile_image_url': instance.profileImageUrl,
      'provider': instance.provider,
      'interests': instance.interests,
      'is_faith_user': instance.isFaithUser,
      'coaching_style': instance.coachingStyle,
      'theme_mode': instance.themeMode,
      'onboarding_completed': instance.onboardingCompleted,
      'created_at': instance.createdAt?.toIso8601String(),
      'last_login_at': instance.lastLoginAt?.toIso8601String(),
    };
