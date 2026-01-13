// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routine_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RoutineModelImpl _$$RoutineModelImplFromJson(Map<String, dynamic> json) =>
    _$RoutineModelImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      category: json['category'] as String?,
      schedule: RoutineScheduleModel.fromJson(
          json['schedule'] as Map<String, dynamic>),
      streak: (json['streak'] as num?)?.toInt() ?? 0,
      maxStreak: (json['maxStreak'] as num?)?.toInt() ?? 0,
      status: json['status'] as String? ?? 'active',
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$RoutineModelImplToJson(_$RoutineModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'name': instance.name,
      'description': instance.description,
      'category': instance.category,
      'schedule': instance.schedule,
      'streak': instance.streak,
      'maxStreak': instance.maxStreak,
      'status': instance.status,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

_$RoutineScheduleModelImpl _$$RoutineScheduleModelImplFromJson(
        Map<String, dynamic> json) =>
    _$RoutineScheduleModelImpl(
      frequency: json['frequency'] as String,
      days: (json['days'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      time: json['time'] as String,
      reminderEnabled: json['reminderEnabled'] as bool? ?? true,
      reminderMinutesBefore:
          (json['reminderMinutesBefore'] as num?)?.toInt() ?? 10,
    );

Map<String, dynamic> _$$RoutineScheduleModelImplToJson(
        _$RoutineScheduleModelImpl instance) =>
    <String, dynamic>{
      'frequency': instance.frequency,
      'days': instance.days,
      'time': instance.time,
      'reminderEnabled': instance.reminderEnabled,
      'reminderMinutesBefore': instance.reminderMinutesBefore,
    };

_$RoutineCompletionModelImpl _$$RoutineCompletionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$RoutineCompletionModelImpl(
      id: json['id'] as String,
      routineId: json['routineId'] as String,
      userId: json['userId'] as String,
      completedAt: DateTime.parse(json['completedAt'] as String),
      note: json['note'] as String?,
    );

Map<String, dynamic> _$$RoutineCompletionModelImplToJson(
        _$RoutineCompletionModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'routineId': instance.routineId,
      'userId': instance.userId,
      'completedAt': instance.completedAt.toIso8601String(),
      'note': instance.note,
    };
