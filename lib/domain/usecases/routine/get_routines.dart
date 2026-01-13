import 'package:dartz/dartz.dart';

import '../../../core/constants/enums.dart';
import '../../../core/errors/failures.dart';
import '../../entities/routine.dart';
import '../../repositories/routine_repository.dart';

/// Use case for getting user's routines
class GetRoutines {
  final RoutineRepository repository;

  GetRoutines(this.repository);

  Future<Either<Failure, List<Routine>>> call({
    RoutineStatus? status,
  }) async {
    return await repository.getRoutines(status: status);
  }
}
