import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/enums.dart';
import '../../providers/routine/routine_detail_provider.dart';
import '../../providers/routine/routine_list_provider.dart';
import '../../widgets/common/app_error_widget.dart';
import '../../widgets/common/loading_indicator.dart';
import 'routine_form_screen.dart';

/// Routine detail screen
class RoutineDetailScreen extends ConsumerWidget {
  final String routineId;

  const RoutineDetailScreen({
    super.key,
    required this.routineId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routineAsync = ref.watch(routineDetailProvider(routineId));

    return routineAsync.when(
      data: (routine) => Scaffold(
        appBar: AppBar(
          title: const Text('루틴 상세'),
          actions: [
            PopupMenuButton(
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      Icon(Icons.edit),
                      SizedBox(width: 8),
                      Text('수정'),
                    ],
                  ),
                ),
                if (routine.status == RoutineStatus.active)
                  const PopupMenuItem(
                    value: 'archive',
                    child: Row(
                      children: [
                        Icon(Icons.archive),
                        SizedBox(width: 8),
                        Text('보관'),
                      ],
                    ),
                  )
                else
                  const PopupMenuItem(
                    value: 'unarchive',
                    child: Row(
                      children: [
                        Icon(Icons.unarchive),
                        SizedBox(width: 8),
                        Text('복원'),
                      ],
                    ),
                  ),
                const PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete, color: Colors.red),
                      SizedBox(width: 8),
                      Text('삭제', style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ],
              onSelected: (value) async {
                switch (value) {
                  case 'edit':
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RoutineFormScreen(routine: routine),
                      ),
                    );
                    ref.invalidate(routineDetailProvider(routineId));
                    break;
                  case 'archive':
                    await _handleArchive(context, ref);
                    break;
                  case 'unarchive':
                    await _handleUnarchive(context, ref);
                    break;
                  case 'delete':
                    await _handleDelete(context, ref);
                    break;
                }
              },
            ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Header
            _buildHeader(context, routine),
            const SizedBox(height: 24),

            // Statistics
            _buildStatistics(context, ref),
            const SizedBox(height: 24),

            // Schedule info
            _buildScheduleInfo(context, routine),
            const SizedBox(height: 24),

            // Recent completions
            _buildRecentCompletions(context, ref),
          ],
        ),
      ),
      loading: () => const Scaffold(
        body: LoadingIndicator(),
      ),
      error: (error, stack) => Scaffold(
        appBar: AppBar(title: const Text('루틴 상세')),
        body: AppErrorWidget(
          message: error.toString(),
          onRetry: () => ref.invalidate(routineDetailProvider(routineId)),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, routine) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    routine.name,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                if (routine.status == RoutineStatus.archived)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '보관됨',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
              ],
            ),
            if (routine.description != null) ...[
              const SizedBox(height: 8),
              Text(
                routine.description!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
            ],
            if (routine.category != null) ...[
              const SizedBox(height: 12),
              Chip(
                label: Text(routine.category!),
                avatar: const Icon(Icons.category, size: 16),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatistics(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(routineStatsProvider(
      routineId,
      startDate: DateTime.now().subtract(const Duration(days: 30)),
      endDate: DateTime.now(),
    ));

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '통계 (최근 30일)',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            statsAsync.when(
              data: (stats) => Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatItem(
                        context,
                        '현재 연속 달성',
                        '${stats.currentStreak}일',
                        Icons.local_fire_department,
                        Colors.orange,
                      ),
                      _buildStatItem(
                        context,
                        '최대 연속 달성',
                        '${stats.maxStreak}일',
                        Icons.emoji_events,
                        Colors.amber,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatItem(
                        context,
                        '완료율',
                        '${(stats.completionRate * 100).toStringAsFixed(0)}%',
                        Icons.check_circle,
                        Colors.green,
                      ),
                      _buildStatItem(
                        context,
                        '완료 횟수',
                        '${stats.completedDays}/${stats.totalScheduledDays}',
                        Icons.event_available,
                        Colors.blue,
                      ),
                    ],
                  ),
                ],
              ),
              loading: () => const Center(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: CircularProgressIndicator(),
                ),
              ),
              error: (_, __) => const Text('통계를 불러올 수 없습니다'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(
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
        ),
      ],
    );
  }

  Widget _buildScheduleInfo(BuildContext context, routine) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '스케줄',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            _buildInfoRow(
              context,
              Icons.repeat,
              '반복',
              routine.schedule.frequency.displayName,
            ),
            if (routine.schedule.frequency != RoutineFrequency.daily) ...[
              const SizedBox(height: 12),
              _buildInfoRow(
                context,
                Icons.calendar_today,
                '요일',
                _formatDays(routine.schedule.days),
              ),
            ],
            const SizedBox(height: 12),
            _buildInfoRow(
              context,
              Icons.access_time,
              '시간',
              routine.schedule.time,
            ),
            const SizedBox(height: 12),
            _buildInfoRow(
              context,
              Icons.notifications,
              '알림',
              routine.schedule.reminderEnabled
                  ? '${routine.schedule.reminderMinutesBefore}분 전'
                  : '없음',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(width: 12),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
        const Spacer(),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }

  Widget _buildRecentCompletions(BuildContext context, WidgetRef ref) {
    final completionsAsync = ref.watch(routineCompletionsProvider(
      routineId,
      startDate: DateTime.now().subtract(const Duration(days: 30)),
      endDate: DateTime.now(),
    ));

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '최근 완료 기록',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            completionsAsync.when(
              data: (completions) {
                if (completions.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(
                      child: Text('완료 기록이 없습니다'),
                    ),
                  );
                }

                final recent = completions.take(10).toList();
                return Column(
                  children: recent.map((completion) {
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.check_circle, color: Colors.green),
                      title: Text(
                        '${completion.completedAt.year}-${completion.completedAt.month.toString().padLeft(2, '0')}-${completion.completedAt.day.toString().padLeft(2, '0')}',
                      ),
                      subtitle: completion.note != null
                          ? Text(completion.note!)
                          : null,
                    );
                  }).toList(),
                );
              },
              loading: () => const Center(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: CircularProgressIndicator(),
                ),
              ),
              error: (_, __) => const Text('완료 기록을 불러올 수 없습니다'),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDays(List<int> days) {
    final dayNames = ['월', '화', '수', '목', '금', '토', '일'];
    return days.map((d) => dayNames[d - 1]).join(', ');
  }

  Future<void> _handleArchive(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('루틴 보관'),
        content: const Text('이 루틴을 보관하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('취소'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('보관'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      try {
        await ref
            .read(routineListProvider(status: RoutineStatus.active).notifier)
            .archiveRoutine(routineId);

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('루틴이 보관되었습니다')),
          );
          context.pop();
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('오류: ${e.toString()}')),
          );
        }
      }
    }
  }

  Future<void> _handleUnarchive(BuildContext context, WidgetRef ref) async {
    try {
      await ref
          .read(routineListProvider(status: RoutineStatus.archived).notifier)
          .unarchiveRoutine(routineId);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('루틴이 복원되었습니다')),
        );
        context.pop();
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('오류: ${e.toString()}')),
        );
      }
    }
  }

  Future<void> _handleDelete(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('루틴 삭제'),
        content: const Text('이 루틴을 영구적으로 삭제하시겠습니까?\n삭제된 데이터는 복구할 수 없습니다.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('취소'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('삭제'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      try {
        await ref
            .read(routineListProvider().notifier)
            .deleteRoutine(routineId);

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('루틴이 삭제되었습니다')),
          );
          context.pop();
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('오류: ${e.toString()}')),
          );
        }
      }
    }
  }
}
