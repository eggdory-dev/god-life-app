import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/home/home_provider.dart';
import '../../widgets/common/app_error_widget.dart';
import '../../widgets/common/loading_indicator.dart';

/// Statistics screen showing weekly/monthly stats
class StatisticsScreen extends ConsumerWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weeklyStatsAsync = ref.watch(weeklyStatsProvider());

    return Scaffold(
      appBar: AppBar(
        title: const Text('통계'),
      ),
      body: weeklyStatsAsync.when(
        data: (stats) => ListView(
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
          ],
        ),
        loading: () => const LoadingIndicator(),
        error: (error, stack) => AppErrorWidget(
          message: error.toString(),
          onRetry: () => ref.invalidate(weeklyStatsProvider()),
        ),
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
              '스트릭 정보',
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
                  '현재 스트릭',
                  '${stats.currentStreak}일',
                  Icons.local_fire_department,
                  Colors.orange,
                ),
                _buildStat(
                  context,
                  '최고 스트릭',
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
        ),
      ],
    );
  }
}
