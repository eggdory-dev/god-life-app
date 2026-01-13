import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/core_providers.dart';
import '../../providers/routine/routine_list_provider.dart';

/// Notification settings screen
class NotificationSettingsScreen extends ConsumerWidget {
  const NotificationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final routinesAsync = ref.watch(routineListProvider());

    return Scaffold(
      appBar: AppBar(
        title: const Text('알림 설정'),
      ),
      body: routinesAsync.when(
        data: (routines) {
          final activeRoutines = routines.where((r) => r.status.name == 'active').toList();

          if (activeRoutines.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_off_outlined,
                    size: 64,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '알림 설정할 루틴이 없습니다',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '루틴을 추가하고 알림을 설정해보세요',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // General notification toggle
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.notifications_active,
                            color: colorScheme.primary,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '루틴 알림',
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '모든 루틴 알림을 관리합니다',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Switch(
                            value: true, // TODO: Implement global notification toggle
                            onChanged: (value) {
                              // TODO: Implement toggle
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('전체 알림 설정은 추후 구현 예정입니다'),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Individual routine notifications
              Text(
                '루틴별 알림',
                style: theme.textTheme.titleSmall?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),

              ...activeRoutines.map((routine) => Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: Icon(
                        routine.schedule.reminderEnabled
                            ? Icons.notifications_active
                            : Icons.notifications_off_outlined,
                        color: routine.schedule.reminderEnabled
                            ? colorScheme.primary
                            : colorScheme.onSurfaceVariant,
                      ),
                      title: Text(routine.name),
                      subtitle: routine.schedule.reminderEnabled
                          ? Text(
                              '${routine.schedule.time} ${routine.schedule.reminderMinutesBefore}분 전 알림',
                              style: theme.textTheme.bodySmall,
                            )
                          : const Text('알림 꺼짐'),
                      trailing: Switch(
                        value: routine.schedule.reminderEnabled,
                        onChanged: (value) async {
                          await _toggleRoutineNotification(
                            context,
                            ref,
                            routine,
                            value,
                          );
                        },
                      ),
                      onTap: () {
                        // TODO: Show time picker for reminder time
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('알림 시간 설정은 추후 구현 예정입니다'),
                          ),
                        );
                      },
                    ),
                  )),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 48,
                color: colorScheme.error,
              ),
              const SizedBox(height: 16),
              Text(
                '오류: ${error.toString()}',
                textAlign: TextAlign.center,
                style: TextStyle(color: colorScheme.error),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _toggleRoutineNotification(
    BuildContext context,
    WidgetRef ref,
    routine,
    bool enabled,
  ) async {
    try {
      final notificationService = ref.read(notificationServiceProvider);

      if (enabled) {
        // Schedule notification
        await notificationService.scheduleRoutineReminder(routine);

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${routine.name} 알림이 설정되었습니다'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } else {
        // Cancel notification
        await notificationService.cancelRoutineReminder(routine);

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${routine.name} 알림이 해제되었습니다'),
            ),
          );
        }
      }

      // Update routine in repository
      // TODO: Implement routine update with notification toggle
      // For now, just refresh the provider
      ref.invalidate(routineListProvider());
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('오류: ${e.toString()}'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }
}
