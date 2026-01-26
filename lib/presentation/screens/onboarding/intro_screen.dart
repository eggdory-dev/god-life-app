import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants/enums.dart';
import '../../../domain/entities/user.dart';
import '../../providers/auth/auth_provider.dart';

/// Onboarding Step 5: Intro (Complete)
class IntroScreen extends ConsumerStatefulWidget {
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
  ConsumerState<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends ConsumerState<IntroScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
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
                '${widget.name}님,\n갓생 살기를 시작해볼까요?',
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
                      icon: widget.theme == AppTheme.faith
                          ? Icons.church
                          : Icons.auto_awesome,
                      label: '테마',
                      value: widget.theme.displayName,
                    ),
                    const Divider(height: 24),
                    _SummaryItem(
                      icon: Icons.psychology,
                      label: '코칭 스타일',
                      value: widget.personality.displayName,
                    ),
                    const Divider(height: 24),
                    _SummaryItem(
                      icon: Icons.notifications,
                      label: '알림',
                      value: widget.notificationsEnabled ? '설정됨' : '나중에 설정',
                    ),
                  ],
                ),
              ),

              const Spacer(),

              FilledButton(
                onPressed: _isLoading ? null : () => _completeOnboarding(context),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('시작하기'),
              ),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _completeOnboarding(BuildContext context) async {
    setState(() => _isLoading = true);

    try {
      debugPrint('🔵 온보딩 완료 시작');

      // Check Supabase session first
      final supabaseUser = Supabase.instance.client.auth.currentUser;
      if (supabaseUser == null) {
        debugPrint('❌ Supabase 세션이 없습니다');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('로그인 세션이 만료되었습니다')),
          );
          context.go('/login');
        }
        return;
      }

      debugPrint('✅ Supabase 사용자: ${supabaseUser.email}');

      // Check authProvider state
      final authState = ref.read(authProvider);
      debugPrint('📊 AuthProvider 상태: ${authState.hasValue ? "데이터 있음" : authState.isLoading ? "로딩 중" : "에러"}');

      if (authState.hasValue) {
        final currentUser = authState.value;
        if (currentUser != null) {
          debugPrint('✅ AuthProvider 사용자: ${currentUser.name}');
        } else {
          debugPrint('⚠️ AuthProvider value is null');
        }
      }

      final updatedSettings = UserSettings(
        theme: widget.theme,
        personality: widget.personality,
        notificationsEnabled: widget.notificationsEnabled,
        onboardingCompleted: true,
        isFaithUser: widget.theme == AppTheme.faith,
        coachingStyle: widget.personality.name,
      );

      debugPrint('🔵 프로필 업데이트 시작: ${widget.name}');
      // Update profile name directly in Supabase
      await Supabase.instance.client.from('profiles').update({
        'name': widget.name,
      }).eq('id', supabaseUser.id);
      debugPrint('✅ 프로필 업데이트 완료');

      debugPrint('🔵 설정 업데이트 시작');
      // Update settings (saved to Supabase profiles table)
      // Note: coaching_style field has a check constraint, so we skip it for now
      await Supabase.instance.client.from('profiles').update({
        'theme_mode': widget.theme.name,
        'is_faith_user': widget.theme == AppTheme.faith,
        'onboarding_completed': true,
      }).eq('id', supabaseUser.id);
      debugPrint('✅ 설정 업데이트 완료 (theme: ${widget.theme.name}, faith: ${widget.theme == AppTheme.faith})');

      // Invalidate authProvider to refresh user data
      ref.invalidate(authProvider);
      ref.invalidate(onboardingCompletedProvider);

      // Navigate to home
      if (mounted) {
        debugPrint('🔵 홈 화면으로 이동');
        context.go('/home');
      }
    } catch (e, stackTrace) {
      debugPrint('❌ 온보딩 완료 실패: $e');
      debugPrint('Stack trace: $stackTrace');

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('온보딩 완료 중 오류가 발생했습니다: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
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
