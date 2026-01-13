import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../entities/user.dart';
import '../../repositories/auth_repository.dart';

/// Use case for updating user settings
class UpdateUserSettings {
  final AuthRepository repository;

  UpdateUserSettings(this.repository);

  Future<Either<Failure, User>> call(UserSettings settings) async {
    return await repository.updateSettings(settings);
  }
}
