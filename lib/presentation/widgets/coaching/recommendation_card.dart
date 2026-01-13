import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/enums.dart';
import '../../../domain/entities/coaching_report.dart';
import '../../../domain/entities/routine.dart';
import '../../providers/routine/routine_list_provider.dart';

/// Card widget for displaying a single recommendation
class RecommendationCard extends ConsumerWidget {
  final Recommendation recommendation;
  final VoidCallback? onAddRoutine;

  const RecommendationCard({
    required this.recommendation,
    this.onAddRoutine,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Priority badge + Title
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPriorityBadge(context, recommendation.priority),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    recommendation.title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Description
            Text(
              recommendation.description,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),

            // Suggested routine (if available)
            if (recommendation.suggestedRoutine != null) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: colorScheme.primary.withOpacity(0.3),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.emoji_events,
                          size: 16,
                          color: colorScheme.primary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '추천 루틴',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    _buildSuggestedRoutineInfo(
                      context,
                      recommendation.suggestedRoutine!,
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: () => _handleAddRoutine(context, ref),
                        icon: const Icon(Icons.add, size: 18),
                        label: const Text('루틴 추가하기'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPriorityBadge(
    BuildContext context,
    RecommendationPriority priority,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    Color backgroundColor;
    Color textColor;
    String label;

    switch (priority) {
      case RecommendationPriority.high:
        backgroundColor = colorScheme.errorContainer;
        textColor = colorScheme.onErrorContainer;
        label = '높음';
        break;
      case RecommendationPriority.medium:
        backgroundColor = Colors.amber.withOpacity(0.2);
        textColor = Colors.amber.shade900;
        label = '보통';
        break;
      case RecommendationPriority.low:
        backgroundColor = colorScheme.primaryContainer;
        textColor = colorScheme.onPrimaryContainer;
        label = '낮음';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            priority.emoji,
            style: const TextStyle(fontSize: 12),
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestedRoutineInfo(
    BuildContext context,
    RoutineCreateRequest routine,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Name
        Row(
          children: [
            Icon(
              Icons.check_circle_outline,
              size: 16,
              color: colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                routine.name,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        if (routine.description != null) ...[
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Text(
              routine.description!,
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],

        // Schedule info
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Wrap(
            spacing: 8,
            runSpacing: 4,
            children: [
              _buildInfoChip(
                context,
                icon: Icons.access_time,
                label: routine.schedule.time,
              ),
              _buildInfoChip(
                context,
                icon: Icons.calendar_today,
                label: _getFrequencyText(routine.schedule),
              ),
              if (routine.category != null)
                _buildInfoChip(
                  context,
                  icon: Icons.label_outline,
                  label: routine.category!,
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoChip(
    BuildContext context, {
    required IconData icon,
    required String label,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: colorScheme.onSurfaceVariant),
          const SizedBox(width: 4),
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  String _getFrequencyText(RoutineSchedule schedule) {
    switch (schedule.frequency) {
      case RoutineFrequency.daily:
        return '매일';
      case RoutineFrequency.weekly:
        if (schedule.days.length == 7) {
          return '매일';
        } else if (schedule.days.length == 1) {
          final dayNames = ['월', '화', '수', '목', '금', '토', '일'];
          return '매주 ${dayNames[schedule.days.first - 1]}';
        } else {
          return '주 ${schedule.days.length}회';
        }
      case RoutineFrequency.custom:
        return '커스텀';
    }
  }

  Future<void> _handleAddRoutine(BuildContext context, WidgetRef ref) async {
    if (recommendation.suggestedRoutine == null) return;

    try {
      final suggestedRoutine = recommendation.suggestedRoutine!;

      // Create routine from suggestion
      final routine = Routine(
        id: '', // Will be generated by repository
        userId: '', // Will be set by repository
        name: suggestedRoutine.name,
        description: suggestedRoutine.description,
        category: suggestedRoutine.category,
        schedule: suggestedRoutine.schedule,
        streak: 0,
        status: RoutineStatus.active,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      // Add routine
      await ref.read(routineListProvider().notifier).createRoutine(routine);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('루틴이 추가되었습니다: ${routine.name}'),
            action: SnackBarAction(
              label: '확인',
              onPressed: () {},
            ),
          ),
        );
      }

      // Call callback if provided
      onAddRoutine?.call();
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('오류: ${e.toString()}'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }
}
