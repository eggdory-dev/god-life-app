import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/constants/enums.dart';
import '../../../core/mocks/data/mock_insights.dart';
import '../../../domain/entities/home_data.dart';
import '../../../domain/entities/insight.dart';
import '../auth/auth_provider.dart';
import '../routine/routine_list_provider.dart';

part 'home_provider.g.dart';

/// Provides today's insight based on user's theme
@riverpod
Future<Insight> todayInsight(TodayInsightRef ref, {DateTime? date}) async {
  final userAsync = ref.watch(authProvider);

  return userAsync.when(
    data: (user) {
      if (user == null) {
        // Default to Universal theme if not logged in
        return MockInsights.getTodayInsight(AppTheme.universal, date: date);
      }
      return MockInsights.getTodayInsight(user.settings.theme, date: date);
    },
    loading: () => MockInsights.getTodayInsight(AppTheme.universal, date: date),
    error: (_, __) =>
        MockInsights.getTodayInsight(AppTheme.universal, date: date),
  );
}

/// Provides aggregated home data
@riverpod
Future<HomeData> homeData(HomeDataRef ref, {DateTime? date}) async {
  final today = date ?? DateTime.now();

  // Fetch insight
  final insight = await ref.watch(todayInsightProvider(date: today).future);

  // Fetch all active routines
  final routinesResult = await ref.watch(
    routineListProvider(status: RoutineStatus.active).future,
  );

  // Get today's completed routine IDs
  final completedIdsResult = await ref.watch(
    todayCompletedRoutineIdsProvider.future,
  );

  // Filter routines for today
  final todayRoutines = routinesResult.where((routine) {
    return routine.schedule.shouldCompleteOn(today);
  }).toList();

  // Calculate completion stats
  final completedCount = todayRoutines
      .where((routine) => completedIdsResult.contains(routine.id))
      .length;
  final totalCount = todayRoutines.length;
  final completionRate = totalCount > 0 ? completedCount / totalCount : 0.0;

  // Calculate current max streak across all routines
  final maxStreak = routinesResult.isEmpty
      ? 0
      : routinesResult
          .map((r) => r.streak)
          .reduce((a, b) => a > b ? a : b);

  // Get upcoming (not completed) routines sorted by time
  final upcomingRoutines = todayRoutines
      .where((routine) => !completedIdsResult.contains(routine.id))
      .toList()
    ..sort((a, b) => a.schedule.time.compareTo(b.schedule.time));

  return HomeData(
    insight: insight,
    progress: TodayProgress(
      date: today,
      totalRoutines: totalCount,
      completedRoutines: completedCount,
      completionRate: completionRate,
      currentStreak: maxStreak,
    ),
    upcomingRoutines: upcomingRoutines.take(5).toList(), // Show max 5
  );
}

/// Provides weekly statistics
@riverpod
Future<WeeklyStats> weeklyStats(WeeklyStatsRef ref, {DateTime? date}) async {
  final today = date ?? DateTime.now();

  // Calculate week range (Monday to Sunday)
  final startOfWeek = today.subtract(Duration(days: today.weekday - 1));
  final endOfWeek = startOfWeek.add(const Duration(days: 6));

  // Fetch all active routines
  final routines = await ref.watch(
    routineListProvider(status: RoutineStatus.active).future,
  );

  // Calculate total scheduled days in this week
  int totalScheduledDays = 0;
  final dailyScheduled = <int, int>{}; // weekday -> count

  for (var routine in routines) {
    for (int day = 0; day < 7; day++) {
      final checkDate = startOfWeek.add(Duration(days: day));
      if (routine.schedule.shouldCompleteOn(checkDate)) {
        totalScheduledDays++;
        final weekday = checkDate.weekday;
        dailyScheduled[weekday] = (dailyScheduled[weekday] ?? 0) + 1;
      }
    }
  }

  // Calculate completed days
  int completedDays = 0;
  final dailyCompletion = <int, int>{}; // weekday -> completed count

  // For each day in the week, check completions
  for (int day = 0; day < 7; day++) {
    final checkDate = startOfWeek.add(Duration(days: day));

    // Get completed routine IDs for this date
    // Note: In real implementation, this would fetch from repository
    // For now, we'll use today's completions as a sample
    if (_isSameDay(checkDate, today)) {
      final completedIds = await ref.watch(
        todayCompletedRoutineIdsProvider.future,
      );

      final dayRoutines = routines.where((r) {
        return r.schedule.shouldCompleteOn(checkDate);
      }).toList();

      final dayCompleted = dayRoutines
          .where((r) => completedIds.contains(r.id))
          .length;

      completedDays += dayCompleted;
      dailyCompletion[checkDate.weekday] = dayCompleted;
    }
  }

  final completionRate =
      totalScheduledDays > 0 ? completedDays / totalScheduledDays : 0.0;

  // Calculate max streak
  final maxStreak = routines.isEmpty
      ? 0
      : routines.map((r) => r.maxStreak).reduce((a, b) => a > b ? a : b);

  // Calculate current streak (same as max for now)
  final currentStreak = routines.isEmpty
      ? 0
      : routines.map((r) => r.streak).reduce((a, b) => a > b ? a : b);

  return WeeklyStats(
    startDate: startOfWeek,
    endDate: endOfWeek,
    totalScheduledDays: totalScheduledDays,
    completedDays: completedDays,
    completionRate: completionRate,
    dailyCompletion: dailyCompletion,
    currentStreak: currentStreak,
    maxStreak: maxStreak,
  );
}

bool _isSameDay(DateTime a, DateTime b) {
  return a.year == b.year && a.month == b.month && a.day == b.day;
}
