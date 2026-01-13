import 'package:flutter/material.dart';

/// Empty state for routine list
class EmptyRoutineState extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final VoidCallback? onActionPressed;
  final String? actionLabel;

  const EmptyRoutineState({
    super.key,
    required this.title,
    this.subtitle,
    this.icon = Icons.event_note_outlined,
    this.onActionPressed,
    this.actionLabel,
  });

  /// Empty state for active routines
  factory EmptyRoutineState.noActiveRoutines({
    VoidCallback? onCreatePressed,
  }) {
    return EmptyRoutineState(
      title: '아직 루틴이 없어요',
      subtitle: '새로운 루틴을 만들어 갓생을 시작해보세요!',
      icon: Icons.add_task,
      onActionPressed: onCreatePressed,
      actionLabel: '루틴 만들기',
    );
  }

  /// Empty state for archived routines
  factory EmptyRoutineState.noArchivedRoutines() {
    return const EmptyRoutineState(
      title: '보관된 루틴이 없어요',
      subtitle: '완료하지 못한 루틴을 보관할 수 있어요',
      icon: Icons.archive_outlined,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 80,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 8),
              Text(
                subtitle!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
            if (onActionPressed != null && actionLabel != null) ...[
              const SizedBox(height: 32),
              FilledButton.icon(
                onPressed: onActionPressed,
                icon: const Icon(Icons.add),
                label: Text(actionLabel!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
