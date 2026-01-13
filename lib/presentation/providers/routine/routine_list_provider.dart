import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/constants/enums.dart';
import '../../../core/providers/core_providers.dart';
import '../../../domain/entities/routine.dart';

part 'routine_list_provider.g.dart';

/// Provider for routine list
/// Supports filtering by status (active/archived)
@riverpod
class RoutineList extends _$RoutineList {
  @override
  Future<List<Routine>> build({RoutineStatus? status}) async {
    final repo = ref.watch(routineRepositoryProvider);
    final result = await repo.getRoutines(status: status);

    return result.fold(
      (failure) => throw failure,
      (routines) => routines,
    );
  }

  /// Complete a routine for today
  Future<void> completeRoutine(String routineId) async {
    final repo = ref.read(routineRepositoryProvider);
    final result = await repo.completeRoutine(
      routineId: routineId,
      date: DateTime.now(),
    );

    result.fold(
      (failure) => throw failure,
      (_) {
        // Invalidate to refresh list
        ref.invalidateSelf();
      },
    );
  }

  /// Uncomplete a routine for today
  Future<void> uncompleteRoutine(String routineId) async {
    final repo = ref.read(routineRepositoryProvider);
    final result = await repo.uncompleteRoutine(
      routineId: routineId,
      date: DateTime.now(),
    );

    result.fold(
      (failure) => throw failure,
      (_) {
        // Invalidate to refresh list
        ref.invalidateSelf();
      },
    );
  }

  /// Create a new routine
  Future<void> createRoutine(Routine routine) async {
    final repo = ref.read(routineRepositoryProvider);

    // Check active routine limit
    final activeRoutines = await ref.read(
      routineListProvider(status: RoutineStatus.active).future,
    );

    if (activeRoutines.length >= 5) {
      throw Exception('활성 루틴은 최대 5개까지만 가능합니다');
    }

    final result = await repo.createRoutine(routine);

    result.fold(
      (failure) => throw failure,
      (_) {
        // Invalidate all routine lists
        ref.invalidate(routineListProvider);
      },
    );
  }

  /// Update a routine
  Future<void> updateRoutine(Routine routine) async {
    final repo = ref.read(routineRepositoryProvider);
    final result = await repo.updateRoutine(routine);

    result.fold(
      (failure) => throw failure,
      (_) {
        // Invalidate to refresh list
        ref.invalidate(routineListProvider);
      },
    );
  }

  /// Archive a routine
  Future<void> archiveRoutine(String routineId) async {
    final repo = ref.read(routineRepositoryProvider);
    final result = await repo.archiveRoutine(routineId);

    result.fold(
      (failure) => throw failure,
      (_) {
        // Invalidate all routine lists
        ref.invalidate(routineListProvider);
      },
    );
  }

  /// Unarchive a routine
  Future<void> unarchiveRoutine(String routineId) async {
    final repo = ref.read(routineRepositoryProvider);

    // Check active routine limit
    final activeRoutines = await ref.read(
      routineListProvider(status: RoutineStatus.active).future,
    );

    if (activeRoutines.length >= 5) {
      throw Exception('활성 루틴은 최대 5개까지만 가능합니다');
    }

    final result = await repo.unarchiveRoutine(routineId);

    result.fold(
      (failure) => throw failure,
      (_) {
        // Invalidate all routine lists
        ref.invalidate(routineListProvider);
      },
    );
  }

  /// Delete a routine permanently
  Future<void> deleteRoutine(String routineId) async {
    final repo = ref.read(routineRepositoryProvider);
    final result = await repo.deleteRoutine(routineId);

    result.fold(
      (failure) => throw failure,
      (_) {
        // Invalidate all routine lists
        ref.invalidate(routineListProvider);
      },
    );
  }
}

/// Provider for today's completions
@riverpod
Future<List<String>> todayCompletedRoutineIds(
  TodayCompletedRoutineIdsRef ref,
) async {
  final repo = ref.watch(routineRepositoryProvider);
  final result = await repo.getCompletionsForDate(date: DateTime.now());

  return result.fold(
    (failure) => [],
    (completions) => completions.map((c) => c.routineId).toList(),
  );
}

/// Provider for checking if a routine is completed today
@riverpod
Future<bool> isRoutineCompletedToday(
  IsRoutineCompletedTodayRef ref,
  String routineId,
) async {
  final completedIds = await ref.watch(todayCompletedRoutineIdsProvider.future);
  return completedIds.contains(routineId);
}
