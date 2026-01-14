import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/enums.dart';
import '../../providers/auth/auth_provider.dart';
import '../../providers/home/home_provider.dart';
import '../../providers/routine/routine_list_provider.dart';
import '../../widgets/common/loading_indicator.dart';
import '../../widgets/home/insight_card.dart';
import '../../widgets/home/progress_circle.dart';
import '../../widgets/routine/routine_card.dart';

/// Home screen
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('God Life'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.go('/settings'),
          ),
        ],
      ),
      body: userAsync.when(
        data: (user) {
          if (user == null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.go('/login');
            });
            return const LoadingIndicator();
          }

          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(routineListProvider);
              ref.invalidate(todayInsightProvider());
              ref.invalidate(homeDataProvider());
            },
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Greeting
                _buildGreeting(context, user.name),
                const SizedBox(height: 24),

                // Today's Insight
                _buildTodayInsight(context, ref),
                const SizedBox(height: 24),

                // Today's Progress
                _buildTodayProgress(context, ref),
                const SizedBox(height: 24),

                // Today's Routines
                _buildTodayRoutines(context, ref),
                const SizedBox(height: 80),
              ],
            ),
          );
        },
        loading: () => const LoadingIndicator(),
        error: (_, __) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('로그인이 필요합니다'),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () => context.go('/login'),
                child: const Text('로그인'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/routine/create'),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildGreeting(BuildContext context, String name) {
    final hour = DateTime.now().hour;
    String greeting;
    if (hour < 12) {
      greeting = '좋은 아침이에요';
    } else if (hour < 18) {
      greeting = '좋은 오후에요';
    } else {
      greeting = '좋은 저녁이에요';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          greeting,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          '$name님 👋',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }

  Widget _buildTodayInsight(BuildContext context, WidgetRef ref) {
    final insightAsync = ref.watch(todayInsightProvider());

    return insightAsync.when(
      data: (insight) => InsightCard(
        insight: insight,
        onReflect: () {
          // TODO: Navigate to reflection/journal screen
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('묵상 기능은 곧 추가될 예정입니다')),
          );
        },
      ),
      loading: () => const Card(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Center(child: CircularProgressIndicator()),
        ),
      ),
      error: (_, __) => const SizedBox.shrink(),
    );
  }

  Widget _buildTodayProgress(BuildContext context, WidgetRef ref) {
    final routinesAsync = ref.watch(
      routineListProvider(status: RoutineStatus.active),
    );
    final completedIdsAsync = ref.watch(todayCompletedRoutineIdsProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '오늘의 진행률',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            routinesAsync.when(
              data: (routines) => completedIdsAsync.when(
                data: (completedIds) {
                  // Filter today's routines
                  final today = DateTime.now();
                  final todayRoutines = routines.where((r) {
                    return r.schedule.shouldCompleteOn(today);
                  }).toList();

                  final completedCount = todayRoutines
                      .where((r) => completedIds.contains(r.id))
                      .length;
                  final totalCount = todayRoutines.length;
                  final progress = totalCount > 0
                      ? completedCount / totalCount
                      : 0.0;

                  // Calculate total streak
                  final maxStreak = routines.isEmpty
                      ? 0
                      : routines.map((r) => r.streak).reduce((a, b) => a > b ? a : b);

                  return Column(
                    children: [
                      // Circular progress
                      Center(
                        child: ProgressCircle(
                          progress: progress,
                          completed: completedCount,
                          total: totalCount,
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Stats row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildProgressStat(
                            context,
                            '완료',
                            '$completedCount',
                            Icons.check_circle,
                            Colors.green,
                          ),
                          _buildProgressStat(
                            context,
                            '전체',
                            '$totalCount',
                            Icons.event_note,
                            Colors.blue,
                          ),
                          _buildProgressStat(
                            context,
                            '연속 달성',
                            '$maxStreak일',
                            Icons.local_fire_department,
                            Colors.orange,
                          ),
                        ],
                      ),
                    ],
                  );
                },
                loading: () => const CircularProgressIndicator(),
                error: (_, __) => const Text('진행률을 불러올 수 없습니다'),
              ),
              loading: () => const CircularProgressIndicator(),
              error: (_, __) => const Text('루틴을 불러올 수 없습니다'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressStat(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Column(
      children: [
        Icon(icon, color: color, size: 28),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
      ],
    );
  }

  Widget _buildTodayRoutines(BuildContext context, WidgetRef ref) {
    final routinesAsync = ref.watch(
      routineListProvider(status: RoutineStatus.active),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '오늘의 루틴',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            TextButton(
              onPressed: () => context.go('/routine'),
              child: const Text('전체 보기'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        routinesAsync.when(
          data: (routines) {
            final today = DateTime.now();
            final todayRoutines = routines.where((r) {
              return r.schedule.shouldCompleteOn(today);
            }).toList();

            if (todayRoutines.isEmpty) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Center(
                    child: Column(
                      children: [
                        const Icon(Icons.event_available, size: 48),
                        const SizedBox(height: 8),
                        Text(
                          '오늘 예정된 루틴이 없습니다',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }

            return Column(
              children: todayRoutines.map((routine) {
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
              }).toList(),
            );
          },
          loading: () => const LoadingIndicator(),
          error: (_, __) => const Text('루틴을 불러올 수 없습니다'),
        ),
      ],
    );
  }
}
