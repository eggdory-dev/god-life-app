import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/enums.dart';
import '../../providers/routine/routine_list_provider.dart';
import '../../providers/home/home_provider.dart';
import '../../widgets/common/app_error_widget.dart';
import '../../widgets/common/loading_indicator.dart';
import '../../widgets/routine/empty_routine_state.dart';
import '../../widgets/routine/routine_card.dart';

/// Routine list screen with Active/Archived/Statistics tabs
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
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {}); // Rebuild to show/hide FAB
    });
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
            Tab(text: '통계'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          _ActiveRoutinesTab(),
          _ArchivedRoutinesTab(),
          _StatisticsTab(),
        ],
      ),
      floatingActionButton: _tabController.index < 2
          ? FloatingActionButton(
              onPressed: () {
                // Navigate to create routine screen
                context.push('/routine/create');
              },
              child: const Icon(Icons.add),
            )
          : null,
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

/// Statistics tab
class _StatisticsTab extends ConsumerWidget {
  const _StatisticsTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weeklyStatsAsync = ref.watch(weeklyStatsProvider());

    return weeklyStatsAsync.when(
      data: (stats) => RefreshIndicator(
        onRefresh: () => ref.refresh(weeklyStatsProvider().future),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Week summary
            _buildWeekSummary(context, stats),
            const SizedBox(height: 24),

            // Daily completion chart
            _buildDailyChart(context, stats),
            const SizedBox(height: 24),

            // Streak info
            _buildStreakInfo(context, stats),
            const SizedBox(height: 80),
          ],
        ),
      ),
      loading: () => const LoadingIndicator(),
      error: (error, stack) => AppErrorWidget(
        message: error.toString(),
        onRetry: () => ref.invalidate(weeklyStatsProvider()),
      ),
    );
  }

  Widget _buildWeekSummary(BuildContext context, stats) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '이번 주 요약',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStat(
                  context,
                  '완료율',
                  '${(stats.completionRate * 100).toStringAsFixed(0)}%',
                  Icons.trending_up,
                  Colors.blue,
                ),
                _buildStat(
                  context,
                  '완료',
                  '${stats.completedDays}/${stats.totalScheduledDays}',
                  Icons.check_circle,
                  Colors.green,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDailyChart(BuildContext context, stats) {
    final textTheme = Theme.of(context).textTheme;
    final dayNames = ['월', '화', '수', '목', '금', '토', '일'];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '요일별 완료 현황',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 180,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(7, (index) {
                  final weekday = index + 1; // 1=Monday, 7=Sunday
                  final completed = stats.dailyCompletion[weekday] ?? 0;
                  final scheduled = stats.dailyCompletion[weekday] ?? 1;
                  final height = scheduled > 0 ? (completed / scheduled) : 0.0;

                  return _buildBar(
                    context,
                    dayNames[index],
                    height.toDouble(),
                    completed,
                    weekday == DateTime.now().weekday,
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBar(
    BuildContext context,
    String label,
    double height,
    int value,
    bool isToday,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (value > 0)
              Text(
                '$value',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            const SizedBox(height: 4),
            Container(
              height: 120 * (height > 0 ? height : 0.1),
              decoration: BoxDecoration(
                color: height > 0
                    ? (isToday ? colorScheme.primary : Colors.green)
                    : colorScheme.surfaceContainerHighest,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(4),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: isToday ? FontWeight.bold : null,
                    color: isToday ? colorScheme.primary : null,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStreakInfo(BuildContext context, stats) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '연속 달성 정보',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStat(
                  context,
                  '현재 연속 달성',
                  '${stats.currentStreak}일',
                  Icons.local_fire_department,
                  Colors.orange,
                ),
                _buildStat(
                  context,
                  '최고 연속 달성',
                  '${stats.maxStreak}일',
                  Icons.emoji_events,
                  Colors.amber,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Column(
      children: [
        Icon(icon, color: color, size: 32),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
