import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/user.dart';
import '../../providers/auth/auth_provider.dart';
import '../../widgets/common/app_button.dart';

/// Login screen with social login options
class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    // Navigate to onboarding after successful login
    ref.listen<AsyncValue<User?>>(authProvider, (previous, next) {
      next.whenData((user) {
        if (user != null) {
          // Check if onboarding is completed
          if (user.settings.onboardingCompleted) {
            context.go('/home');
          } else {
            context.go('/onboarding');
          }
        }
      });
    });

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),

              // Logo
              Icon(
                Icons.auto_awesome,
                size: 80,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 24),

              // Title
              Text(
                'God Life',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),

              // Subtitle
              Text(
                '갓생 살기를 시작해보세요',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                textAlign: TextAlign.center,
              ),

              const Spacer(),

              // Login buttons
              AppButton.primary(
                text: 'Google로 시작하기',
                icon: Icons.g_mobiledata,
                onPressed: authState.isLoading
                    ? null
                    : () => ref.read(authProvider.notifier).loginWithGoogle(),
                isLoading: authState.isLoading,
                isFullWidth: true,
              ),
              const SizedBox(height: 12),

              AppButton.secondary(
                text: 'Apple로 시작하기',
                icon: Icons.apple,
                onPressed: authState.isLoading
                    ? null
                    : () => ref.read(authProvider.notifier).loginWithApple(),
                isLoading: authState.isLoading,
                isFullWidth: true,
              ),
              const SizedBox(height: 12),

              AppButton.secondary(
                text: 'Kakao로 시작하기',
                icon: Icons.chat_bubble,
                onPressed: authState.isLoading
                    ? null
                    : () => ref.read(authProvider.notifier).loginWithKakao(),
                isLoading: authState.isLoading,
                isFullWidth: true,
              ),

              const SizedBox(height: 24),

              // Terms
              Text(
                '로그인하면 이용약관 및 개인정보처리방침에\n동의하는 것으로 간주됩니다',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }
}
