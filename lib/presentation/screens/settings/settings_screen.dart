import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../core/constants/enums.dart';
import '../../../core/providers/core_providers.dart';
import '../../providers/auth/auth_provider.dart';

/// Settings screen
class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  String _version = '';

  @override
  void initState() {
    super.initState();
    _loadVersion();
  }

  Future<void> _loadVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _version = '${packageInfo.version}+${packageInfo.buildNumber}';
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final userAsync = ref.watch(authProvider);
    final currentTheme = ref.watch(themeModeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('설정'),
      ),
      body: userAsync.when(
        data: (user) {
          if (user == null) {
            return const Center(child: Text('로그인이 필요합니다'));
          }

          return ListView(
            children: [
              // Profile Section
              _buildProfileSection(context, user),

              const Divider(height: 32),

              // Appearance Section
              _buildSection(
                context,
                title: '외관',
                children: [
                  _buildThemeSelector(context, currentTheme),
                ],
              ),

              const Divider(height: 32),

              // Coaching Section
              _buildSection(
                context,
                title: 'AI 코칭',
                children: [
                  _buildCoachingStyleSelector(context, user.settings.personality),
                ],
              ),

              const Divider(height: 32),

              // Notifications Section
              _buildSection(
                context,
                title: '알림',
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.notifications,
                      color: colorScheme.primary,
                    ),
                    title: const Text('알림 설정'),
                    subtitle: const Text('루틴 알림 관리'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => context.push('/settings/notifications'),
                  ),
                ],
              ),

              const Divider(height: 32),

              // Account Section
              _buildSection(
                context,
                title: '계정',
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.person,
                      color: colorScheme.primary,
                    ),
                    title: const Text('프로필 수정'),
                    subtitle: const Text('이름, 이메일 변경'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => context.push('/settings/profile'),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.logout,
                      color: colorScheme.error,
                    ),
                    title: Text(
                      '로그아웃',
                      style: TextStyle(color: colorScheme.error),
                    ),
                    onTap: () => _handleLogout(context),
                  ),
                ],
              ),

              const Divider(height: 32),

              // About Section
              _buildSection(
                context,
                title: '정보',
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.info_outline,
                      color: colorScheme.primary,
                    ),
                    title: const Text('버전'),
                    subtitle: Text(_version.isEmpty ? '로딩 중...' : _version),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.privacy_tip_outlined,
                      color: colorScheme.primary,
                    ),
                    title: const Text('개인정보 처리방침'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      // TODO: Show privacy policy
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('개인정보 처리방침은 추후 구현 예정입니다'),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.description_outlined,
                      color: colorScheme.primary,
                    ),
                    title: const Text('이용약관'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      // TODO: Show terms of service
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('이용약관은 추후 구현 예정입니다'),
                        ),
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: 32),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('오류: ${error.toString()}')),
      ),
    );
  }

  Widget _buildProfileSection(BuildContext context, user) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: colorScheme.primary,
            child: Text(
              user.name[0].toUpperCase(),
              style: theme.textTheme.headlineMedium?.copyWith(
                color: colorScheme.onPrimary,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (user.email != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    user.email!,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required List<Widget> children,
  }) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            title,
            style: theme.textTheme.titleSmall?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...children,
      ],
    );
  }

  Widget _buildThemeSelector(BuildContext context, AppTheme currentTheme) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ListTile(
      leading: Icon(
        Icons.palette,
        color: colorScheme.primary,
      ),
      title: const Text('테마'),
      subtitle: Text(
        currentTheme == AppTheme.faith ? 'Faith (신앙)' : 'Universal (보편)',
      ),
      trailing: Switch(
        value: currentTheme == AppTheme.universal,
        onChanged: (_) {
          ref.read(themeModeProvider.notifier).toggleTheme();
        },
      ),
    );
  }

  Widget _buildCoachingStyleSelector(
    BuildContext context,
    PersonalityType personality,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ListTile(
      leading: Icon(
        Icons.psychology,
        color: colorScheme.primary,
      ),
      title: const Text('코칭 스타일'),
      subtitle: Text(
        personality == PersonalityType.feeling
            ? 'Feeling (공감형)'
            : 'Thinking (사고형)',
      ),
      trailing: Switch(
        value: personality == PersonalityType.thinking,
        onChanged: (value) {
          // TODO: Implement personality change
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('코칭 스타일 변경은 추후 구현 예정입니다'),
            ),
          );
        },
      ),
    );
  }

  Future<void> _handleLogout(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('로그아웃'),
        content: const Text('정말 로그아웃하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('취소'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('로그아웃'),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;

    try {
      await ref.read(authProvider.notifier).logout();
      if (!mounted) return;
      context.go('/login');
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('오류: ${e.toString()}')),
      );
    }
  }
}
