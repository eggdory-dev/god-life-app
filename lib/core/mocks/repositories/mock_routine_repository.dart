import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../../core/constants/enums.dart';
import '../../../core/errors/failures.dart';
import '../../../data/models/routine_model.dart';
import '../../../domain/entities/routine.dart';
import '../../../domain/repositories/routine_repository.dart';
import '../data/mock_routines.dart';

/// Mock implementation of RoutineRepository
/// Used for development before real API is ready
class MockRoutineRepository implements RoutineRepository {
  final SharedPreferences _prefs;
  final List<RoutineModel> _routines = [];
  final List<RoutineCompletionModel> _completions = [];
  final _uuid = const Uuid();

  static const String _routinesKey = 'mock_routines';
  static const String _completionsKey = 'mock_completions';

  MockRoutineRepository(this._prefs) {
    _loadRoutines();
    _loadCompletions();
  }

  /// Load routines from SharedPreferences
  void _loadRoutines() {
    // For now, use static mock data
    // In real implementation, this would load from SharedPreferences
    _routines.clear();
    _routines.addAll(MockRoutines.allRoutines);
  }

  /// Load completions from SharedPreferences
  void _loadCompletions() {
    // Load mock completions (for now, generate some based on current date)
    _completions.clear();
    _generateMockCompletions();
  }

  /// Generate mock completions for active routines
  void _generateMockCompletions() {
    final now = DateTime.now();
    for (final routine in MockRoutines.activeRoutines) {
      final routineEntity = routine.toEntity();

      // Generate completions for the last 30 days
      for (int i = 1; i <= 30; i++) {
        final date = now.subtract(Duration(days: i));

        // Check if routine should be completed on this date
        if (routineEntity.schedule.shouldCompleteOn(date)) {
          // Simulate 80% completion rate
          if (i <= routine.streak || (i > routine.streak && (i % 5) != 0)) {
            _completions.add(
              RoutineCompletionModel(
                id: _uuid.v4(),
                routineId: routine.id,
                userId: MockRoutines.mockUserId,
                completedAt: DateTime(date.year, date.month, date.day, 10, 0),
                note: null,
              ),
            );
          }
        }
      }
    }
  }

  @override
  Future<Either<Failure, List<Routine>>> getRoutines({
    RoutineStatus? status,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300)); // Simulate network delay

    try {
      var filtered = _routines;

      if (status != null) {
        filtered = _routines
            .where((r) => r.status == status.name)
            .toList();
      }

      final entities = filtered.map((r) => r.toEntity()).toList();
      return Right(entities);
    } catch (e) {
      return Left(Failure.server(message: 'Failed to load routines'));
    }
  }

  @override
  Future<Either<Failure, Routine>> getRoutine(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));

    try {
      final routine = _routines.firstWhere((r) => r.id == id);
      return Right(routine.toEntity());
    } catch (e) {
      return Left(Failure.notFound(message: 'Routine not found'));
    }
  }

  @override
  Future<Either<Failure, Routine>> createRoutine(Routine routine) async {
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      final model = RoutineModel.fromEntity(routine);
      final newModel = model.copyWith(
        id: _uuid.v4(),
        userId: MockRoutines.mockUserId,
        createdAt: DateTime.now(),
      );

      _routines.add(newModel);
      return Right(newModel.toEntity());
    } catch (e) {
      return Left(Failure.server(message: 'Failed to create routine'));
    }
  }

  @override
  Future<Either<Failure, Routine>> updateRoutine(Routine routine) async {
    await Future.delayed(const Duration(milliseconds: 400));

    try {
      final index = _routines.indexWhere((r) => r.id == routine.id);
      if (index == -1) {
        return Left(Failure.notFound(message: 'Routine not found'));
      }

      final updatedModel = RoutineModel.fromEntity(routine).copyWith(
        updatedAt: DateTime.now(),
      );

      _routines[index] = updatedModel;
      return Right(updatedModel.toEntity());
    } catch (e) {
      return Left(Failure.server(message: 'Failed to update routine'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteRoutine(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));

    try {
      _routines.removeWhere((r) => r.id == id);
      _completions.removeWhere((c) => c.routineId == id);
      return const Right(null);
    } catch (e) {
      return Left(Failure.server(message: 'Failed to delete routine'));
    }
  }

  @override
  Future<Either<Failure, Routine>> archiveRoutine(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));

    try {
      final index = _routines.indexWhere((r) => r.id == id);
      if (index == -1) {
        return Left(Failure.notFound(message: 'Routine not found'));
      }

      final updated = _routines[index].copyWith(
        status: RoutineStatus.archived.name,
        updatedAt: DateTime.now(),
      );

      _routines[index] = updated;
      return Right(updated.toEntity());
    } catch (e) {
      return Left(Failure.server(message: 'Failed to archive routine'));
    }
  }

  @override
  Future<Either<Failure, Routine>> unarchiveRoutine(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));

    try {
      final index = _routines.indexWhere((r) => r.id == id);
      if (index == -1) {
        return Left(Failure.notFound(message: 'Routine not found'));
      }

      final updated = _routines[index].copyWith(
        status: RoutineStatus.active.name,
        updatedAt: DateTime.now(),
      );

      _routines[index] = updated;
      return Right(updated.toEntity());
    } catch (e) {
      return Left(Failure.server(message: 'Failed to unarchive routine'));
    }
  }

  @override
  Future<Either<Failure, RoutineCompletion>> completeRoutine({
    required String routineId,
    required DateTime date,
    String? note,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));

    try {
      final normalizedDate = _normalizeDate(date);

      final completion = RoutineCompletionModel(
        id: _uuid.v4(),
        routineId: routineId,
        userId: MockRoutines.mockUserId,
        completedAt: normalizedDate,
        note: note,
      );

      _completions.add(completion);
      return Right(completion.toEntity());
    } catch (e) {
      return Left(Failure.server(message: 'Failed to complete routine'));
    }
  }

  @override
  Future<Either<Failure, void>> uncompleteRoutine({
    required String routineId,
    required DateTime date,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));

    try {
      final normalizedDate = _normalizeDate(date);
      _completions.removeWhere((c) =>
          c.routineId == routineId &&
          _isSameDay(c.completedAt, normalizedDate));
      return const Right(null);
    } catch (e) {
      return Left(Failure.server(message: 'Failed to uncomplete routine'));
    }
  }

  @override
  Future<Either<Failure, List<RoutineCompletion>>> getCompletions({
    required String routineId,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    await Future.delayed(const Duration(milliseconds: 200));

    try {
      var filtered = _completions.where((c) => c.routineId == routineId);

      if (startDate != null) {
        filtered = filtered.where((c) => c.completedAt.isAfter(startDate));
      }

      if (endDate != null) {
        filtered = filtered.where((c) => c.completedAt.isBefore(endDate));
      }

      final entities = filtered.map((c) => c.toEntity()).toList();
      return Right(entities);
    } catch (e) {
      return Left(Failure.server(message: 'Failed to load completions'));
    }
  }

  @override
  Future<Either<Failure, List<RoutineCompletion>>> getCompletionsForDate({
    required DateTime date,
  }) async {
    await Future.delayed(const Duration(milliseconds: 200));

    try {
      final normalizedDate = _normalizeDate(date);
      final filtered = _completions
          .where((c) => _isSameDay(c.completedAt, normalizedDate))
          .map((c) => c.toEntity())
          .toList();

      return Right(filtered);
    } catch (e) {
      return Left(Failure.server(message: 'Failed to load completions for date'));
    }
  }

  @override
  Future<Either<Failure, bool>> isCompleted({
    required String routineId,
    required DateTime date,
  }) async {
    await Future.delayed(const Duration(milliseconds: 100));

    try {
      final normalizedDate = _normalizeDate(date);
      final exists = _completions.any((c) =>
          c.routineId == routineId &&
          _isSameDay(c.completedAt, normalizedDate));

      return Right(exists);
    } catch (e) {
      return Left(Failure.server(message: 'Failed to check completion status'));
    }
  }

  @override
  Future<Either<Failure, int>> calculateStreak(String routineId) async {
    await Future.delayed(const Duration(milliseconds: 300));

    try {
      final routineResult = await getRoutine(routineId);

      return routineResult.fold(
        (failure) => Left(failure),
        (routine) async {
          final completionsResult = await getCompletions(routineId: routineId);

          return completionsResult.fold(
            (failure) => Left(failure),
            (completions) async {
              final streak = _calculateStreakFromCompletions(
                completions,
                routine.schedule,
              );

              // Update routine with new streak
              final index = _routines.indexWhere((r) => r.id == routineId);
              if (index != -1) {
                final current = _routines[index];
                _routines[index] = current.copyWith(
                  streak: streak,
                  maxStreak: streak > current.maxStreak ? streak : current.maxStreak,
                  updatedAt: DateTime.now(),
                );
              }

              return Right(streak);
            },
          );
        },
      );
    } catch (e) {
      return Left(Failure.server(message: 'Failed to calculate streak'));
    }
  }

  /// Calculate streak from completions
  int _calculateStreakFromCompletions(
    List<RoutineCompletion> completions,
    RoutineSchedule schedule,
  ) {
    if (completions.isEmpty) return 0;

    // Sort completions by date (newest first)
    final sorted = completions.toList()
      ..sort((a, b) => b.completedAt.compareTo(a.completedAt));

    int streak = 0;
    DateTime checkDate = DateTime.now();
    final normalizedCheckDate = _normalizeDate(checkDate);

    // Check if there's a completion today or yesterday (for continuation)
    final hasRecentCompletion = sorted.any((c) {
      final completedDate = _normalizeDate(c.completedAt);
      return _isSameDay(completedDate, normalizedCheckDate) ||
          _isSameDay(completedDate, normalizedCheckDate.subtract(const Duration(days: 1)));
    });

    if (!hasRecentCompletion) {
      return 0; // Streak broken
    }

    // Calculate streak backwards from today
    for (final completion in sorted) {
      final completedDate = _normalizeDate(completion.completedAt);

      // Check if this is the next expected date
      if (schedule.shouldCompleteOn(checkDate)) {
        if (_isSameDay(completedDate, checkDate)) {
          streak++;
          checkDate = _getPreviousScheduledDate(checkDate, schedule);
        } else {
          break; // Streak broken
        }
      } else {
        // Skip days not in schedule
        checkDate = _getPreviousScheduledDate(checkDate, schedule);
      }

      // Safety limit: don't go back more than 365 days
      if (DateTime.now().difference(checkDate).inDays > 365) {
        break;
      }
    }

    return streak;
  }

  /// Get previous scheduled date based on routine schedule
  DateTime _getPreviousScheduledDate(DateTime date, RoutineSchedule schedule) {
    DateTime previous = date.subtract(const Duration(days: 1));

    // For daily, just go back 1 day
    if (schedule.frequency == RoutineFrequency.daily) {
      return previous;
    }

    // For weekly/custom, find previous scheduled day
    int daysBack = 1;
    while (daysBack < 8) {
      final checkDate = date.subtract(Duration(days: daysBack));
      if (schedule.shouldCompleteOn(checkDate)) {
        return checkDate;
      }
      daysBack++;
    }

    return previous;
  }

  @override
  Future<Either<Failure, RoutineStats>> getRoutineStats({
    required String routineId,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));

    try {
      final routineResult = await getRoutine(routineId);

      return await routineResult.fold(
        (failure) async => Left(failure),
        (routine) async {
          final completionsResult = await getCompletions(
            routineId: routineId,
            startDate: startDate,
            endDate: endDate,
          );

          return completionsResult.fold(
            (failure) => Left(failure),
            (completions) {
              final stats = RoutineStats(
                routineId: routineId,
                totalScheduledDays: _countScheduledDays(
                  routine.schedule,
                  startDate ?? routine.createdAt,
                  endDate ?? DateTime.now(),
                ),
                completedDays: completions.length,
                completionRate: completions.isEmpty
                    ? 0.0
                    : completions.length / _countScheduledDays(
                        routine.schedule,
                        startDate ?? routine.createdAt,
                        endDate ?? DateTime.now(),
                      ),
                currentStreak: routine.streak,
                maxStreak: routine.maxStreak,
                lastCompletedAt: completions.isNotEmpty
                    ? completions.last.completedAt
                    : null,
              );

              return Right(stats);
            },
          );
        },
      );
    } catch (e) {
      return Left(Failure.server(message: 'Failed to get routine stats'));
    }
  }

  /// Count scheduled days in a date range
  int _countScheduledDays(
    RoutineSchedule schedule,
    DateTime start,
    DateTime end,
  ) {
    int count = 0;
    DateTime current = start;

    while (current.isBefore(end) || _isSameDay(current, end)) {
      if (schedule.shouldCompleteOn(current)) {
        count++;
      }
      current = current.add(const Duration(days: 1));
    }

    return count;
  }

  /// Normalize date to remove time component
  DateTime _normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  /// Check if two dates are the same day
  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
