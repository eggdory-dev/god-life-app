import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/enums.dart';
import '../../providers/routine/routine_list_provider.dart';
import '../../widgets/common/app_error_widget.dart';
import '../../widgets/common/loading_indicator.dart';
import '../../widgets/routine/empty_routine_state.dart';
import '../../widgets/routine/routine_card.dart';

/// Routine list screen with Active/Archived tabs
class RoutineListScreen extends ConsumerStatefulWidget {
  const RoutineListScreen({super.key});

  @override
  ConsumerState<RoutineListScreen> createState() => _RoutineListScreenState();
}

class _RoutineListScreenState extends ConsumerState<RoutineListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('루틴'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: '활성'),
            Tab(text: '보관'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          _ActiveRoutinesTab(),
          _ArchivedRoutinesTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to create routine screen
          context.push('/routine/create');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

/// Active routines tab
class _ActiveRoutinesTab extends ConsumerWidget {
  const _ActiveRoutinesTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routinesAsync = ref.watch(
      routineListProvider(status: RoutineStatus.active),
    );

    return routinesAsync.when(
      data: (routines) {
        if (routines.isEmpty) {
          return EmptyRoutineState.noActiveRoutines(
            onCreatePressed: () => context.push('/routine/create'),
          );
        }

        return RefreshIndicator(
          onRefresh: () => ref.refresh(
            routineListProvider(status: RoutineStatus.active).future,
          ),
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 8, bottom: 80),
            itemCount: routines.length,
            itemBuilder: (context, index) {
              final routine = routines[index];
              final isCompletedAsync = ref.watch(
                isRoutineCompletedTodayProvider(routine.id),
              );

              return isCompletedAsync.when(
                data: (isCompleted) => RoutineCard(
                  routine: routine,
                  isCompleted: isCompleted,
                  onTap: () => context.push('/routine/${routine.id}'),
                  onCheckChanged: (value) async {
                    if (value == true) {
                      await ref
                          .read(routineListProvider(
                                  status: RoutineStatus.active)
                              .notifier)
                          .completeRoutine(routine.id);
                    } else {
                      await ref
                          .read(routineListProvider(
                                  status: RoutineStatus.active)
                              .notifier)
                          .uncompleteRoutine(routine.id);
                    }
                    // Refresh completion status
                    ref.invalidate(todayCompletedRoutineIdsProvider);
                  },
                ),
                loading: () => RoutineCard(
                  routine: routine,
                  isCompleted: false,
                ),
                error: (_, __) => RoutineCard(
                  routine: routine,
                  isCompleted: false,
                ),
              );
            },
          ),
        );
      },
      loading: () => const LoadingIndicator(),
      error: (error, stack) => AppErrorWidget(
        message: error.toString(),
        onRetry: () => ref.invalidate(
          routineListProvider(status: RoutineStatus.active),
        ),
      ),
    );
  }
}

/// Archived routines tab
class _ArchivedRoutinesTab extends ConsumerWidget {
  const _ArchivedRoutinesTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routinesAsync = ref.watch(
      routineListProvider(status: RoutineStatus.archived),
    );

    return routinesAsync.when(
      data: (routines) {
        if (routines.isEmpty) {
          return EmptyRoutineState.noArchivedRoutines();
        }

        return RefreshIndicator(
          onRefresh: () => ref.refresh(
            routineListProvider(status: RoutineStatus.archived).future,
          ),
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 8, bottom: 80),
            itemCount: routines.length,
            itemBuilder: (context, index) {
              final routine = routines[index];

              return RoutineCard(
                routine: routine,
                isCompleted: false,
                onTap: () => context.push('/routine/${routine.id}'),
                onCheckChanged: null, // Archived routines can't be completed
              );
            },
          ),
        );
      },
      loading: () => const LoadingIndicator(),
      error: (error, stack) => AppErrorWidget(
        message: error.toString(),
        onRetry: () => ref.invalidate(
          routineListProvider(status: RoutineStatus.archived),
        ),
      ),
    );
  }
}
