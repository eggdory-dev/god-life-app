import 'package:dartz/dartz.dart';

import '../../core/constants/enums.dart';
import '../../core/errors/failures.dart';
import '../entities/routine.dart';

/// Repository interface for routine operations
abstract class RoutineRepository {
  /// Get all routines for current user, optionally filtered by status
  Future<Either<Failure, List<Routine>>> getRoutines({
    RoutineStatus? status,
  });

  /// Get a single routine by ID
  Future<Either<Failure, Routine>> getRoutine(String id);

  /// Create a new routine
  Future<Either<Failure, Routine>> createRoutine(Routine routine);

  /// Update an existing routine
  Future<Either<Failure, Routine>> updateRoutine(Routine routine);

  /// Delete a routine permanently
  Future<Either<Failure, void>> deleteRoutine(String id);

  /// Archive a routine (soft delete)
  Future<Either<Failure, Routine>> archiveRoutine(String id);

  /// Unarchive a routine (restore from archive)
  Future<Either<Failure, Routine>> unarchiveRoutine(String id);

  /// Mark a routine as completed for a specific date
  Future<Either<Failure, RoutineCompletion>> completeRoutine({
    required String routineId,
    required DateTime date,
    String? note,
  });

  /// Unmark a routine completion
  Future<Either<Failure, void>> uncompleteRoutine({
    required String routineId,
    required DateTime date,
  });

  /// Get all completions for a routine
  Future<Either<Failure, List<RoutineCompletion>>> getCompletions({
    required String routineId,
    DateTime? startDate,
    DateTime? endDate,
  });

  /// Get completions for a specific date
  Future<Either<Failure, List<RoutineCompletion>>> getCompletionsForDate({
    required DateTime date,
  });

  /// Check if a routine is completed on a specific date
  Future<Either<Failure, bool>> isCompleted({
    required String routineId,
    required DateTime date,
  });

  /// Calculate and update streak for a routine
  Future<Either<Failure, int>> calculateStreak(String routineId);

  /// Get statistics for a routine (completion rate, etc.)
  Future<Either<Failure, RoutineStats>> getRoutineStats({
    required String routineId,
    DateTime? startDate,
    DateTime? endDate,
  });
}

/// Statistics for a routine
class RoutineStats {
  final String routineId;
  final int totalScheduledDays;
  final int completedDays;
  final double completionRate;
  final int currentStreak;
  final int maxStreak;
  final DateTime? lastCompletedAt;

  const RoutineStats({
    required this.routineId,
    required this.totalScheduledDays,
    required this.completedDays,
    required this.completionRate,
    required this.currentStreak,
    required this.maxStreak,
    this.lastCompletedAt,
  });
}
