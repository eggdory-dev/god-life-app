import '../../core/constants/enums.dart';

/// Routine entity representing a user's habit or routine
class Routine {
  final String id;
  final String userId;
  final String name;
  final String? description;
  final String? category;
  final RoutineSchedule schedule;
  final int streak;
  final int maxStreak;
  final RoutineStatus status;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const Routine({
    required this.id,
    required this.userId,
    required this.name,
    this.description,
    this.category,
    required this.schedule,
    this.streak = 0,
    this.maxStreak = 0,
    this.status = RoutineStatus.active,
    required this.createdAt,
    this.updatedAt,
  });

  Routine copyWith({
    String? id,
    String? userId,
    String? name,
    String? description,
    String? category,
    RoutineSchedule? schedule,
    int? streak,
    int? maxStreak,
    RoutineStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Routine(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      schedule: schedule ?? this.schedule,
      streak: streak ?? this.streak,
      maxStreak: maxStreak ?? this.maxStreak,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Routine &&
        other.id == id &&
        other.userId == userId &&
        other.name == name &&
        other.description == description &&
        other.category == category &&
        other.schedule == schedule &&
        other.streak == streak &&
        other.maxStreak == maxStreak &&
        other.status == status &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      userId,
      name,
      description,
      category,
      schedule,
      streak,
      maxStreak,
      status,
      createdAt,
      updatedAt,
    );
  }
}

/// Schedule configuration for a routine
class RoutineSchedule {
  final RoutineFrequency frequency;
  final List<int> days; // For weekly/custom: [1=Monday, 2=Tuesday, ..., 7=Sunday]
  final String time; // "HH:mm" format, e.g., "09:00"
  final bool reminderEnabled;
  final int reminderMinutesBefore;

  const RoutineSchedule({
    required this.frequency,
    this.days = const [],
    required this.time,
    this.reminderEnabled = true,
    this.reminderMinutesBefore = 10,
  });

  /// Check if routine should be completed on given date
  bool shouldCompleteOn(DateTime date) {
    switch (frequency) {
      case RoutineFrequency.daily:
        return true;
      case RoutineFrequency.weekly:
      case RoutineFrequency.custom:
        // weekday: 1=Monday, 7=Sunday
        return days.contains(date.weekday);
    }
  }

  RoutineSchedule copyWith({
    RoutineFrequency? frequency,
    List<int>? days,
    String? time,
    bool? reminderEnabled,
    int? reminderMinutesBefore,
  }) {
    return RoutineSchedule(
      frequency: frequency ?? this.frequency,
      days: days ?? this.days,
      time: time ?? this.time,
      reminderEnabled: reminderEnabled ?? this.reminderEnabled,
      reminderMinutesBefore: reminderMinutesBefore ?? this.reminderMinutesBefore,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RoutineSchedule &&
        other.frequency == frequency &&
        _listEquals(other.days, days) &&
        other.time == time &&
        other.reminderEnabled == reminderEnabled &&
        other.reminderMinutesBefore == reminderMinutesBefore;
  }

  @override
  int get hashCode {
    return Object.hash(
      frequency,
      Object.hashAll(days),
      time,
      reminderEnabled,
      reminderMinutesBefore,
    );
  }

  bool _listEquals<T>(List<T>? a, List<T>? b) {
    if (a == null) return b == null;
    if (b == null || a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}

/// Completion record for a routine
class RoutineCompletion {
  final String id;
  final String routineId;
  final String userId;
  final DateTime completedAt;
  final String? note;

  const RoutineCompletion({
    required this.id,
    required this.routineId,
    required this.userId,
    required this.completedAt,
    this.note,
  });

  RoutineCompletion copyWith({
    String? id,
    String? routineId,
    String? userId,
    DateTime? completedAt,
    String? note,
  }) {
    return RoutineCompletion(
      id: id ?? this.id,
      routineId: routineId ?? this.routineId,
      userId: userId ?? this.userId,
      completedAt: completedAt ?? this.completedAt,
      note: note ?? this.note,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RoutineCompletion &&
        other.id == id &&
        other.routineId == routineId &&
        other.userId == userId &&
        other.completedAt == completedAt &&
        other.note == note;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      routineId,
      userId,
      completedAt,
      note,
    );
  }
}
