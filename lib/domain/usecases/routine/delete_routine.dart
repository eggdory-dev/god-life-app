import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../repositories/routine_repository.dart';

/// Use case for permanently deleting a routine
class DeleteRoutine {
  final RoutineRepository repository;

  DeleteRoutine(this.repository);

  Future<Either<Failure, void>> call(String routineId) async {
    return await repository.deleteRoutine(routineId);
  }
}
