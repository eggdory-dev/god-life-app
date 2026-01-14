import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../domain/entities/insight.dart';

/// Displays daily insight (Bible verse or inspirational quote)
class InsightCard extends StatelessWidget {
  final Insight insight;
  final VoidCallback? onReflect;
  final VoidCallback? onShare;

  const InsightCard({
    super.key,
    required this.insight,
    this.onReflect,
    this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      elevation: 2,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              colorScheme.primaryContainer,
              colorScheme.primaryContainer.withValues(alpha: 0.7),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Text(
                  insight.type.emoji,
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(width: 8),
                Text(
                  '오늘의 ${insight.type.displayName}',
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onPrimaryContainer,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Content
            Text(
              insight.content,
              style: textTheme.bodyLarge?.copyWith(
                height: 1.5,
                fontWeight: FontWeight.w500,
                color: colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: 12),

            // Source
            Text(
              '- ${insight.source}',
              style: textTheme.bodyMedium?.copyWith(
                fontStyle: FontStyle.italic,
                color: colorScheme.onPrimaryContainer.withValues(alpha: 0.7),
              ),
            ),

            // Reflection (if available)
            if (insight.reflection != null) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: colorScheme.surface.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.lightbulb_outline,
                      size: 20,
                      color: colorScheme.onPrimaryContainer,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        insight.reflection!,
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.onPrimaryContainer,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            // Actions
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (onReflect != null)
                  TextButton.icon(
                    onPressed: onReflect,
                    icon: const Icon(Icons.edit_note, size: 18),
                    label: const Text('묵상하기'),
                    style: TextButton.styleFrom(
                      foregroundColor: colorScheme.onPrimaryContainer,
                    ),
                  ),
                const SizedBox(width: 8),
                TextButton.icon(
                  onPressed: onShare ?? () => _handleShare(context),
                  icon: const Icon(Icons.share, size: 18),
                  label: const Text('공유'),
                  style: TextButton.styleFrom(
                    foregroundColor: colorScheme.onPrimaryContainer,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _handleShare(BuildContext context) {
    final shareText = '${insight.content}\n\n- ${insight.source}';

    // Copy to clipboard
    Clipboard.setData(ClipboardData(text: shareText));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('클립보드에 복사되었습니다'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
