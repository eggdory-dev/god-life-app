import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/enums.dart';
import '../../../domain/entities/user.dart';
import '../../providers/auth/auth_provider.dart';

/// Onboarding Step 5: Intro (Complete)
class IntroScreen extends ConsumerWidget {
  final AppTheme theme;
  final PersonalityType personality;
  final String name;
  final bool notificationsEnabled;

  const IntroScreen({
    super.key,
    required this.theme,
    required this.personality,
    required this.name,
    required this.notificationsEnabled,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),

              // Icon
              Icon(
                Icons.celebration,
                size: 100,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 32),

              Text(
                '준비가 완료되었어요!',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              Text(
                '$name님,\n갓생 살기를 시작해볼까요?',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 48),

              // Summary
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    _SummaryItem(
                      icon: theme == AppTheme.faith
                          ? Icons.church
                          : Icons.auto_awesome,
                      label: '테마',
                      value: theme.displayName,
                    ),
                    const Divider(height: 24),
                    _SummaryItem(
                      icon: Icons.psychology,
                      label: '코칭 스타일',
                      value: personality.displayName,
                    ),
                    const Divider(height: 24),
                    _SummaryItem(
                      icon: Icons.notifications,
                      label: '알림',
                      value: notificationsEnabled ? '설정됨' : '나중에 설정',
                    ),
                  ],
                ),
              ),

              const Spacer(),

              FilledButton(
                onPressed: () => _completeOnboarding(context, ref),
                child: const Text('시작하기'),
              ),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _completeOnboarding(
      BuildContext context, WidgetRef ref) async {
    // Update user settings with onboarding data
    final currentUser = ref.read(authProvider).value;
    if (currentUser == null) return;

    final updatedSettings = UserSettings(
      theme: theme,
      personality: personality,
      notificationsEnabled: notificationsEnabled,
      onboardingCompleted: true,
    );

    // Update profile name
    await ref.read(authProvider.notifier).updateProfile(name: name);

    // Update settings
    await ref.read(authProvider.notifier).updateSettings(updatedSettings);

    // Navigate to home
    if (context.mounted) {
      context.go('/home');
    }
  }
}

class _SummaryItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _SummaryItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Theme.of(context).colorScheme.primary,
          size: 24,
        ),
        const SizedBox(width: 16),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
        const Spacer(),
        Text(
          value,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}
