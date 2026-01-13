import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../entities/routine.dart';
import '../../repositories/routine_repository.dart';

/// Use case for completing a routine on a specific date
/// Includes streak calculation logic
class CompleteRoutine {
  final RoutineRepository repository;

  CompleteRoutine(this.repository);

  Future<Either<Failure, RoutineCompletion>> call({
    required String routineId,
    required DateTime date,
    String? note,
  }) async {
    // Get the routine
    final routineResult = await repository.getRoutine(routineId);

    return await routineResult.fold(
      (failure) async => Left(failure),
      (routine) async {
        // Check if routine should be completed on this date
        final normalizedDate = _normalizeDate(date);
        if (!routine.schedule.shouldCompleteOn(normalizedDate)) {
          return Left(
            Failure.business(message: '이 루틴은 선택한 날짜에 완료할 수 없습니다'),
          );
        }

        // Check if already completed today
        final isCompletedResult = await repository.isCompleted(
          routineId: routineId,
          date: normalizedDate,
        );

        return await isCompletedResult.fold(
          (failure) async => Left(failure),
          (isCompleted) async {
            if (isCompleted) {
              return Left(Failure.business(message: '이미 완료한 루틴입니다'));
            }

            // Mark as completed
            final completionResult = await repository.completeRoutine(
              routineId: routineId,
              date: normalizedDate,
              note: note,
            );

            return await completionResult.fold(
              (failure) async => Left(failure),
              (completion) async {
                // Calculate and update streak
                final streakResult = await repository.calculateStreak(routineId);

                return streakResult.fold(
                  (failure) => Right(completion), // Return completion even if streak calc fails
                  (_) => Right(completion),
                );
              },
            );
          },
        );
      },
    );
  }

  /// Normalize date to remove time component
  DateTime _normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }
}
