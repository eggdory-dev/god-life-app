import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/providers/core_providers.dart';
import '../../../domain/entities/routine.dart';
import '../../../domain/repositories/routine_repository.dart';

part 'routine_detail_provider.g.dart';

/// Provider for a single routine detail
@riverpod
Future<Routine> routineDetail(RoutineDetailRef ref, String routineId) async {
  final repo = ref.watch(routineRepositoryProvider);
  final result = await repo.getRoutine(routineId);

  return result.fold(
    (failure) => throw failure,
    (routine) => routine,
  );
}

/// Provider for routine statistics
@riverpod
Future<RoutineStats> routineStats(
  RoutineStatsRef ref,
  String routineId, {
  DateTime? startDate,
  DateTime? endDate,
}) async {
  final repo = ref.watch(routineRepositoryProvider);
  final result = await repo.getRoutineStats(
    routineId: routineId,
    startDate: startDate,
    endDate: endDate,
  );

  return result.fold(
    (failure) => throw failure,
    (stats) => stats,
  );
}

/// Provider for routine completions
@riverpod
Future<List<RoutineCompletion>> routineCompletions(
  RoutineCompletionsRef ref,
  String routineId, {
  DateTime? startDate,
  DateTime? endDate,
}) async {
  final repo = ref.watch(routineRepositoryProvider);
  final result = await repo.getCompletions(
    routineId: routineId,
    startDate: startDate,
    endDate: endDate,
  );

  return result.fold(
    (failure) => throw failure,
    (completions) => completions,
  );
}
