import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/enums.dart';

/// Onboarding Step 4: Notification Permission
class NotificationPermissionScreen extends ConsumerWidget {
  final AppTheme theme;
  final PersonalityType personality;
  final String name;

  const NotificationPermissionScreen({
    super.key,
    required this.theme,
    required this.personality,
    required this.name,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('알림 설정'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),

              // Icon
              Icon(
                Icons.notifications_active_outlined,
                size: 80,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 32),

              Text(
                '루틴 알림을\n받으시겠어요?',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              Text(
                '설정한 루틴 시간에 맞춰\n알림을 보내드릴게요',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 48),

              // Benefits
              _Benefit(
                icon: Icons.schedule,
                title: '루틴 리마인더',
                description: '설정한 시간에 알림을 보내드려요',
              ),
              const SizedBox(height: 16),
              _Benefit(
                icon: Icons.auto_awesome,
                title: '성장 메시지',
                description: '꾸준한 성장을 응원해드려요',
              ),
              const SizedBox(height: 16),
              _Benefit(
                icon: Icons.insights,
                title: '리포트 완성',
                description: '주간 리포트가 준비되면 알려드려요',
              ),

              const Spacer(),

              FilledButton(
                onPressed: () {
                  // Request notification permission
                  // For now, just proceed
                  context.push(
                    '/onboarding/intro',
                    extra: {
                      'theme': theme,
                      'personality': personality,
                      'name': name,
                      'notificationsEnabled': true,
                    },
                  );
                },
                child: const Text('알림 받기'),
              ),
              const SizedBox(height: 12),

              TextButton(
                onPressed: () {
                  context.push(
                    '/onboarding/intro',
                    extra: {
                      'theme': theme,
                      'personality': personality,
                      'name': name,
                      'notificationsEnabled': false,
                    },
                  );
                },
                child: const Text('나중에 설정하기'),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _Benefit extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _Benefit({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: Theme.of(context).colorScheme.primary,
            size: 24,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
