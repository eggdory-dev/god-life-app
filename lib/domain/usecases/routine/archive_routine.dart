import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../entities/routine.dart';
import '../../repositories/routine_repository.dart';

/// Use case for archiving a routine
class ArchiveRoutine {
  final RoutineRepository repository;

  ArchiveRoutine(this.repository);

  Future<Either<Failure, Routine>> call(String routineId) async {
    return await repository.archiveRoutine(routineId);
  }
}

/// Use case for unarchiving a routine
class UnarchiveRoutine {
  final RoutineRepository repository;

  UnarchiveRoutine(this.repository);

  Future<Either<Failure, Routine>> call(String routineId) async {
    return await repository.unarchiveRoutine(routineId);
  }
}
