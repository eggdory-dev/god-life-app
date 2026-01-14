import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/coaching/coaching_provider.dart';

/// Banner showing daily usage limit
class UsageLimitBanner extends ConsumerWidget {
  const UsageLimitBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usageAsync = ref.watch(coachingUsageProvider);

    return usageAsync.when(
      data: (usage) {
        final remaining = usage.remaining;
        final isLimitReached = usage.isLimitReached;

        // Don't show banner if not near limit
        if (remaining > 1 && !isLimitReached) {
          return const SizedBox.shrink();
        }

        final color = isLimitReached ? Colors.red : Colors.amber;
        final colorScheme = Theme.of(context).colorScheme;

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            border: Border(
              bottom: BorderSide(
                color: color.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
          ),
          child: Row(
            children: [
              Icon(
                isLimitReached ? Icons.block : Icons.info_outline,
                color: color,
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  isLimitReached
                      ? '오늘의 무료 이용권을 모두 사용했습니다'
                      : '오늘 $remaining회 남았습니다',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurface,
                      ),
                ),
              ),
              if (isLimitReached)
                TextButton(
                  onPressed: () => _showProInfo(context),
                  child: const Text('Pro 알아보기'),
                ),
            ],
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }

  void _showProInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('God Life Pro'),
        content: const Text(
          'Pro 버전에서는 무제한 AI 코칭을 이용하실 수 있습니다.\n\n'
          '현재는 무료 버전으로 하루 3회까지 이용 가능합니다.\n'
          '내일 자정에 이용 횟수가 초기화됩니다.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }
}
