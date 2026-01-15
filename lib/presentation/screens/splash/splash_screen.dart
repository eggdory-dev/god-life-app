import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/auth/auth_provider.dart';

/// Splash screen shown on app startup
/// Checks auth state and navigates to appropriate screen
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    // Show splash screen for 2 seconds
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    // Check auth state
    final authState = ref.read(authProvider);

    authState.when(
      data: (user) async {
        if (user == null) {
          // Not authenticated → go to login
          if (mounted) context.go('/login');
        } else {
          // Check onboarding status
          final onboardingDone = await ref.read(onboardingCompletedProvider.future);
          if (mounted) {
            if (onboardingDone) {
              context.go('/home');
            } else {
              context.go('/onboarding');
            }
          }
        }
      },
      loading: () {
        if (mounted) context.go('/login');
      },
      error: (_, __) {
        if (mounted) context.go('/login');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // TODO: Add app logo
            Icon(
              Icons.auto_awesome,
              size: 80,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 24),
            Text(
              'God Life',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              '갓생 살기',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 48),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
