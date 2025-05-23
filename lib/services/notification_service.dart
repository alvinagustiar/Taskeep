import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import '../models/reminder.dart';

class NotificationException implements Exception {
  final String message;
  final dynamic error;

  NotificationException(this.message, [this.error]);

  @override
  String toString() =>
      'NotificationException: $message${error != null ? '\nError: $error' : ''}';
}

final notificationServiceProvider =
    Provider<NotificationService>((ref) => NotificationService());

class NotificationService {
  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();
  bool _initialized = false;
  bool _hasPermission = false;

  Future<void> initialize() async {
    if (_initialized) return;

    try {
      // Initialize timezone
      tz.initializeTimeZones();

      // Initialize notification settings
      const androidSettings =
          AndroidInitializationSettings('@mipmap/ic_launcher');
      const iosSettings = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      );

      const settings = InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      );

      final success = await _notifications.initialize(
        settings,
        onDidReceiveNotificationResponse: (NotificationResponse details) {
          // Handle notification tap
          debugPrint('Notification tapped: ${details.payload}');
        },
      );

      if (success == false) {
        throw NotificationException('Failed to initialize notifications');
      }

      // Request permissions immediately after initialization
      await requestPermissions();

      _initialized = true;
    } catch (e) {
      _initialized = false;
      throw NotificationException(
          'Failed to initialize notification service', e);
    }
  }

  Future<void> scheduleTaskReminder({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
  }) async {
    if (!_initialized) {
      throw NotificationException('Notification service not initialized');
    }

    if (!_hasPermission) {
      throw NotificationException('Notification permission not granted');
    }

    try {
      if (scheduledDate.isBefore(DateTime.now())) {
        throw NotificationException(
            'Cannot schedule notification for past time');
      }

      await _notifications.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(scheduledDate, tz.local),
        NotificationDetails(
          android: const AndroidNotificationDetails(
            'task_reminders',
            'Task Reminders',
            channelDescription: 'Notifications for task reminders',
            importance: Importance.high,
            priority: Priority.high,
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    } catch (e) {
      throw NotificationException('Failed to schedule notification', e);
    }
  }

  Future<void> cancelNotification(int id) async {
    if (!_initialized) {
      throw NotificationException('Notification service not initialized');
    }

    try {
      await _notifications.cancel(id);
    } catch (e) {
      throw NotificationException('Failed to cancel notification', e);
    }
  }

  Future<void> cancelAllNotifications() async {
    if (!_initialized) {
      throw NotificationException('Notification service not initialized');
    }

    try {
      await _notifications.cancelAll();
    } catch (e) {
      throw NotificationException('Failed to cancel all notifications', e);
    }
  }

  Future<List<PendingNotificationRequest>> getPendingReminders() async {
    if (!_initialized) {
      throw NotificationException('Notification service not initialized');
    }

    try {
      return await _notifications.pendingNotificationRequests();
    } catch (e) {
      throw NotificationException('Failed to get pending reminders', e);
    }
  }

  Future<void> requestPermissions() async {
    try {
      // Request permissions for iOS
      final iOS = await _notifications
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );

      // Request permissions for Android
      final android = await _notifications
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestPermission();

      _hasPermission = (iOS ?? false) || (android ?? false);

      if (!_hasPermission) {
        debugPrint('Warning: Notification permissions not granted');
      }
    } catch (e) {
      _hasPermission = false;
      throw NotificationException(
          'Failed to request notification permissions', e);
    }
  }

  bool get isInitialized => _initialized;
  bool get hasPermission => _hasPermission;
}
