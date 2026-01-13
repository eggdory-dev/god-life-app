import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

import '../constants/enums.dart';
import '../../domain/entities/routine.dart';

/// Service for managing local notifications
class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  bool _initialized = false;

  /// Initialize the notification service
  Future<void> initialize() async {
    if (_initialized) return;

    // Initialize timezone
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Seoul'));

    // Android initialization settings
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');

    // iOS initialization settings
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    // Initialize plugin
    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _plugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    _initialized = true;
  }

  /// Handle notification tap
  void _onNotificationTapped(NotificationResponse response) {
    // TODO: Navigate to routine detail screen
    // This will be implemented when we have navigation service
    final payload = response.payload;
    if (payload != null) {
      print('Notification tapped with payload: $payload');
    }
  }

  /// Request notification permissions (iOS)
  Future<bool> requestPermissions() async {
    final iosPlugin = _plugin.resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>();

    if (iosPlugin != null) {
      final granted = await iosPlugin.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
      return granted ?? false;
    }

    // Android permissions are granted at install time
    return true;
  }

  /// Schedule a notification for a routine
  Future<void> scheduleRoutineReminder(Routine routine) async {
    if (!routine.schedule.reminderEnabled) return;

    final notificationId = routine.id.hashCode;

    // Cancel existing notification first
    await _plugin.cancel(notificationId);

    // Parse time
    final timeParts = routine.schedule.time.split(':');
    final hour = int.parse(timeParts[0]);
    final minute = int.parse(timeParts[1]);

    // Calculate reminder time
    final reminderMinute =
        minute - routine.schedule.reminderMinutesBefore;
    final reminderHour = reminderMinute < 0 ? hour - 1 : hour;
    final adjustedMinute = reminderMinute < 0 ? reminderMinute + 60 : reminderMinute;

    // Create notification details
    final androidDetails = AndroidNotificationDetails(
      'routine_reminders',
      '루틴 알림',
      channelDescription: '루틴 시작 알림',
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    final notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    // Schedule based on frequency
    switch (routine.schedule.frequency) {
      case RoutineFrequency.daily:
        await _scheduleDailyNotification(
          notificationId,
          routine.name,
          '${routine.schedule.time}에 시작할 시간이에요',
          reminderHour,
          adjustedMinute,
          notificationDetails,
          routine.id,
        );
        break;

      case RoutineFrequency.weekly:
        for (final day in routine.schedule.days) {
          await _scheduleWeeklyNotification(
            notificationId + day,
            routine.name,
            '${routine.schedule.time}에 시작할 시간이에요',
            day,
            reminderHour,
            adjustedMinute,
            notificationDetails,
            routine.id,
          );
        }
        break;

      case RoutineFrequency.custom:
        // For custom, treat like weekly for now
        for (final day in routine.schedule.days) {
          await _scheduleWeeklyNotification(
            notificationId + day,
            routine.name,
            '${routine.schedule.time}에 시작할 시간이에요',
            day,
            reminderHour,
            adjustedMinute,
            notificationDetails,
            routine.id,
          );
        }
        break;
    }
  }

  /// Schedule a daily notification
  Future<void> _scheduleDailyNotification(
    int id,
    String title,
    String body,
    int hour,
    int minute,
    NotificationDetails details,
    String payload,
  ) async {
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    // If time has passed today, schedule for tomorrow
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    await _plugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: payload,
    );
  }

  /// Schedule a weekly notification
  Future<void> _scheduleWeeklyNotification(
    int id,
    String title,
    String body,
    int weekday,
    int hour,
    int minute,
    NotificationDetails details,
    String payload,
  ) async {
    final now = tz.TZDateTime.now(tz.local);

    // Find next occurrence of this weekday
    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    while (scheduledDate.weekday != weekday || scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    await _plugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
      payload: payload,
    );
  }

  /// Cancel a routine notification
  Future<void> cancelRoutineReminder(Routine routine) async {
    final notificationId = routine.id.hashCode;

    await _plugin.cancel(notificationId);

    // Cancel all weekly notifications if applicable
    if (routine.schedule.frequency == RoutineFrequency.weekly ||
        routine.schedule.frequency == RoutineFrequency.custom) {
      for (final day in routine.schedule.days) {
        await _plugin.cancel(notificationId + day);
      }
    }
  }

  /// Cancel all notifications
  Future<void> cancelAll() async {
    await _plugin.cancelAll();
  }

  /// Get pending notifications
  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    return await _plugin.pendingNotificationRequests();
  }

  /// Show immediate notification (for testing)
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'general',
      '일반 알림',
      channelDescription: '일반 알림',
      importance: Importance.high,
      priority: Priority.high,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _plugin.show(
      id,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }
}
