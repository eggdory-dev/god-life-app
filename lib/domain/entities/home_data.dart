import 'insight.dart';
import 'routine.dart';

/// Aggregated data for home screen
class HomeData {
  final Insight insight;
  final TodayProgress progress;
  final List<Routine> upcomingRoutines;

  const HomeData({
    required this.insight,
    required this.progress,
    required this.upcomingRoutines,
  });

  HomeData copyWith({
    Insight? insight,
    TodayProgress? progress,
    List<Routine>? upcomingRoutines,
  }) {
    return HomeData(
      insight: insight ?? this.insight,
      progress: progress ?? this.progress,
      upcomingRoutines: upcomingRoutines ?? this.upcomingRoutines,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HomeData &&
        other.insight == insight &&
        other.progress == progress &&
        _listEquals(other.upcomingRoutines, upcomingRoutines);
  }

  @override
  int get hashCode {
    return insight.hashCode ^
        progress.hashCode ^
        upcomingRoutines.hashCode;
  }

  bool _listEquals<T>(List<T>? a, List<T>? b) {
    if (a == null) return b == null;
    if (b == null || a.length != b.length) return false;
    for (int index = 0; index < a.length; index += 1) {
      if (a[index] != b[index]) return false;
    }
    return true;
  }
}

/// Today's progress data
class TodayProgress {
  final DateTime date;
  final int totalRoutines;
  final int completedRoutines;
  final double completionRate;
  final int currentStreak;

  const TodayProgress({
    required this.date,
    required this.totalRoutines,
    required this.completedRoutines,
    required this.completionRate,
    required this.currentStreak,
  });

  TodayProgress copyWith({
    DateTime? date,
    int? totalRoutines,
    int? completedRoutines,
    double? completionRate,
    int? currentStreak,
  }) {
    return TodayProgress(
      date: date ?? this.date,
      totalRoutines: totalRoutines ?? this.totalRoutines,
      completedRoutines: completedRoutines ?? this.completedRoutines,
      completionRate: completionRate ?? this.completionRate,
      currentStreak: currentStreak ?? this.currentStreak,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TodayProgress &&
        other.date == date &&
        other.totalRoutines == totalRoutines &&
        other.completedRoutines == completedRoutines &&
        other.completionRate == completionRate &&
        other.currentStreak == currentStreak;
  }

  @override
  int get hashCode {
    return date.hashCode ^
        totalRoutines.hashCode ^
        completedRoutines.hashCode ^
        completionRate.hashCode ^
        currentStreak.hashCode;
  }
}

/// Weekly statistics
class WeeklyStats {
  final DateTime startDate;
  final DateTime endDate;
  final int totalScheduledDays;
  final int completedDays;
  final double completionRate;
  final Map<int, int> dailyCompletion; // weekday (1-7) -> count
  final int currentStreak;
  final int maxStreak;

  const WeeklyStats({
    required this.startDate,
    required this.endDate,
    required this.totalScheduledDays,
    required this.completedDays,
    required this.completionRate,
    required this.dailyCompletion,
    required this.currentStreak,
    required this.maxStreak,
  });

  WeeklyStats copyWith({
    DateTime? startDate,
    DateTime? endDate,
    int? totalScheduledDays,
    int? completedDays,
    double? completionRate,
    Map<int, int>? dailyCompletion,
    int? currentStreak,
    int? maxStreak,
  }) {
    return WeeklyStats(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      totalScheduledDays: totalScheduledDays ?? this.totalScheduledDays,
      completedDays: completedDays ?? this.completedDays,
      completionRate: completionRate ?? this.completionRate,
      dailyCompletion: dailyCompletion ?? this.dailyCompletion,
      currentStreak: currentStreak ?? this.currentStreak,
      maxStreak: maxStreak ?? this.maxStreak,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WeeklyStats &&
        other.startDate == startDate &&
        other.endDate == endDate &&
        other.totalScheduledDays == totalScheduledDays &&
        other.completedDays == completedDays &&
        other.completionRate == completionRate &&
        _mapEquals(other.dailyCompletion, dailyCompletion) &&
        other.currentStreak == currentStreak &&
        other.maxStreak == maxStreak;
  }

  @override
  int get hashCode {
    return startDate.hashCode ^
        endDate.hashCode ^
        totalScheduledDays.hashCode ^
        completedDays.hashCode ^
        completionRate.hashCode ^
        dailyCompletion.hashCode ^
        currentStreak.hashCode ^
        maxStreak.hashCode;
  }

  bool _mapEquals<K, V>(Map<K, V>? a, Map<K, V>? b) {
    if (a == null) return b == null;
    if (b == null || a.length != b.length) return false;
    for (final key in a.keys) {
      if (!b.containsKey(key) || a[key] != b[key]) {
        return false;
      }
    }
    return true;
  }
}
