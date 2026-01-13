// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String?,
      photoUrl: json['photoUrl'] as String?,
      settings:
          UserSettingsModel.fromJson(json['settings'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastLoginAt: json['lastLoginAt'] == null
          ? null
          : DateTime.parse(json['lastLoginAt'] as String),
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'photoUrl': instance.photoUrl,
      'settings': instance.settings,
      'createdAt': instance.createdAt.toIso8601String(),
      'lastLoginAt': instance.lastLoginAt?.toIso8601String(),
    };

_$UserSettingsModelImpl _$$UserSettingsModelImplFromJson(
        Map<String, dynamic> json) =>
    _$UserSettingsModelImpl(
      theme: json['theme'] as String,
      personality: json['personality'] as String,
      notificationsEnabled: json['notificationsEnabled'] as bool? ?? true,
      preferredNotificationTime: json['preferredNotificationTime'] as String?,
      onboardingCompleted: json['onboardingCompleted'] as bool? ?? false,
    );

Map<String, dynamic> _$$UserSettingsModelImplToJson(
        _$UserSettingsModelImpl instance) =>
    <String, dynamic>{
      'theme': instance.theme,
      'personality': instance.personality,
      'notificationsEnabled': instance.notificationsEnabled,
      'preferredNotificationTime': instance.preferredNotificationTime,
      'onboardingCompleted': instance.onboardingCompleted,
    };
