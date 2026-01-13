import 'package:dartz/dartz.dart';

import '../../../core/constants/enums.dart';
import '../../../core/errors/failures.dart';
import '../../entities/routine.dart';
import '../../repositories/routine_repository.dart';

/// Use case for creating a new routine
class CreateRoutine {
  final RoutineRepository repository;

  CreateRoutine(this.repository);

  Future<Either<Failure, Routine>> call(Routine routine) async {
    // Validate routine limits
    final routinesResult = await repository.getRoutines(
      status: RoutineStatus.active,
    );

    return routinesResult.fold(
      (failure) => Left(failure),
      (activeRoutines) async {
        // Check if user has reached the limit of 5 active routines
        if (activeRoutines.length >= 5) {
          return Left(
            Failure.business(message: '활성 루틴은 최대 5개까지만 가능합니다'),
          );
        }

        // Create the routine
        return await repository.createRoutine(routine);
      },
    );
  }
}
