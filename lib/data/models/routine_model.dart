import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/constants/enums.dart';
import '../../domain/entities/routine.dart';

part 'routine_model.freezed.dart';
part 'routine_model.g.dart';

@freezed
class RoutineModel with _$RoutineModel {
  const RoutineModel._();

  const factory RoutineModel({
    required String id,
    required String userId,
    required String name,
    String? description,
    String? category,
    required RoutineScheduleModel schedule,
    @Default(0) int streak,
    @Default(0) int maxStreak,
    @Default('active') String status,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _RoutineModel;

  factory RoutineModel.fromJson(Map<String, dynamic> json) =>
      _$RoutineModelFromJson(json);

  /// Convert to domain entity
  Routine toEntity() {
    return Routine(
      id: id,
      userId: userId,
      name: name,
      description: description,
      category: category,
      schedule: schedule.toEntity(),
      streak: streak,
      maxStreak: maxStreak,
      status: _parseStatus(status),
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  /// Create from domain entity
  factory RoutineModel.fromEntity(Routine routine) {
    return RoutineModel(
      id: routine.id,
      userId: routine.userId,
      name: routine.name,
      description: routine.description,
      category: routine.category,
      schedule: RoutineScheduleModel.fromEntity(routine.schedule),
      streak: routine.streak,
      maxStreak: routine.maxStreak,
      status: routine.status.name,
      createdAt: routine.createdAt,
      updatedAt: routine.updatedAt,
    );
  }

  static RoutineStatus _parseStatus(String status) {
    return RoutineStatus.values.firstWhere(
      (e) => e.name == status,
      orElse: () => RoutineStatus.active,
    );
  }
}

@freezed
class RoutineScheduleModel with _$RoutineScheduleModel {
  const RoutineScheduleModel._();

  const factory RoutineScheduleModel({
    required String frequency,
    @Default([]) List<int> days,
    required String time,
    @Default(true) bool reminderEnabled,
    @Default(10) int reminderMinutesBefore,
  }) = _RoutineScheduleModel;

  factory RoutineScheduleModel.fromJson(Map<String, dynamic> json) =>
      _$RoutineScheduleModelFromJson(json);

  /// Convert to domain entity
  RoutineSchedule toEntity() {
    return RoutineSchedule(
      frequency: _parseFrequency(frequency),
      days: days,
      time: time,
      reminderEnabled: reminderEnabled,
      reminderMinutesBefore: reminderMinutesBefore,
    );
  }

  /// Create from domain entity
  factory RoutineScheduleModel.fromEntity(RoutineSchedule schedule) {
    return RoutineScheduleModel(
      frequency: schedule.frequency.name,
      days: schedule.days,
      time: schedule.time,
      reminderEnabled: schedule.reminderEnabled,
      reminderMinutesBefore: schedule.reminderMinutesBefore,
    );
  }

  static RoutineFrequency _parseFrequency(String frequency) {
    return RoutineFrequency.values.firstWhere(
      (e) => e.name == frequency,
      orElse: () => RoutineFrequency.daily,
    );
  }
}

@freezed
class RoutineCompletionModel with _$RoutineCompletionModel {
  const RoutineCompletionModel._();

  const factory RoutineCompletionModel({
    required String id,
    required String routineId,
    required String userId,
    required DateTime completedAt,
    String? note,
  }) = _RoutineCompletionModel;

  factory RoutineCompletionModel.fromJson(Map<String, dynamic> json) =>
      _$RoutineCompletionModelFromJson(json);

  /// Convert to domain entity
  RoutineCompletion toEntity() {
    return RoutineCompletion(
      id: id,
      routineId: routineId,
      userId: userId,
      completedAt: completedAt,
      note: note,
    );
  }

  /// Create from domain entity
  factory RoutineCompletionModel.fromEntity(RoutineCompletion completion) {
    return RoutineCompletionModel(
      id: completion.id,
      routineId: completion.routineId,
      userId: completion.userId,
      completedAt: completion.completedAt,
      note: completion.note,
    );
  }
}
