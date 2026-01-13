import 'package:flutter/material.dart';

/// Common empty state widget
/// Displays illustration, message, and optional action button
class EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? description;
  final String? actionLabel;
  final VoidCallback? onAction;

  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    this.description,
    this.actionLabel,
    this.onAction,
  });

  const EmptyState.routines({
    super.key,
    this.actionLabel = '루틴 추가하기',
    this.onAction,
  })  : icon = Icons.event_note_outlined,
        title = '아직 루틴이 없어요',
        description = '새로운 루틴을 추가하고\n갓생 살기를 시작해보세요!';

  const EmptyState.conversations({
    super.key,
    this.actionLabel = '대화 시작하기',
    this.onAction,
  })  : icon = Icons.chat_bubble_outline,
        title = '대화 기록이 없어요',
        description = 'AI 코칭과 함께\n성장하는 대화를 시작해보세요!';

  const EmptyState.reports({
    super.key,
    this.onAction,
  })  : icon = Icons.description_outlined,
        title = '리포트가 없어요',
        description = 'AI 코칭과 대화하면\n성장 리포트를 받을 수 있어요',
        actionLabel = null;

  const EmptyState.search({
    super.key,
    this.description,
    this.onAction,
  })  : icon = Icons.search_off,
        title = '검색 결과가 없어요',
        actionLabel = null;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 64,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: 24),

            // Title
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),

            // Description
            if (description != null) ...[
              const SizedBox(height: 8),
              Text(
                description!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                textAlign: TextAlign.center,
              ),
            ],

            // Action button
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: 32),
              FilledButton.icon(
                onPressed: onAction,
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

/// Compact empty state for inline display
class InlineEmptyState extends StatelessWidget {
  final String message;

  const InlineEmptyState({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Center(
        child: Text(
          message,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
