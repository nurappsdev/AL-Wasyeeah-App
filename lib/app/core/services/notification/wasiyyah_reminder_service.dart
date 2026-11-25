import 'dart:convert';
import 'dart:developer';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:wasiyyat/app/core/route/route_names.dart';
import 'package:wasiyyat/app/core/services/api/api_service.dart';
import 'package:wasiyyat/app/core/services/shared_pref/prefs_service.dart';
import 'package:wasiyyat/app/core/utils/api_constants.dart';
import 'package:wasiyyat/app/view/notification/model/reminder_notification_model.dart';

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  log('Notification Action Background Tap: ${notificationResponse.actionId}, payload: ${notificationResponse.payload}');
  WasiyyahReminderService.handleNotificationAction(
    actionId: notificationResponse.actionId,
    payload: notificationResponse.payload,
  );
}

class WasiyyahReminderService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const String _channelId = 'wasiyyah_reminder_channel';
  static const String _channelName = 'Wasiyyah Reminder Notifications';
  static const String _channelDesc = 'Notifications and reminders for updating Wasiyyah';

  static const String keyLastUpdatedAt = 'reminder_last_updated_at';
  static const String keyDaysSinceLastUpdate = 'reminder_days_since_last_update';
  static const String keyReminderDateTime = 'reminder_date_time';
  static const String keyShouldSchedule = 'reminder_should_schedule';
  static const String keyMessage = 'reminder_message';

  static const int immediateNotificationId = 8881;
  static const int scheduledNotificationId = 8882;

  static const String yesActionId = 'YES_ACTION';
  static const String noActionId = 'NO_ACTION';

  static Future<void> init() async {
    try {
      tz.initializeTimeZones();

      const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
      const iosInit = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      );

      const initSettings = InitializationSettings(
        android: androidInit,
        iOS: iosInit,
      );

      await _notificationsPlugin.initialize(
        settings: initSettings,
        onDidReceiveNotificationResponse: (response) {
          log('Notification Response Foreground/Background: ${response.actionId}');
          handleNotificationAction(
            actionId: response.actionId,
            payload: response.payload,
          );
        },
        onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
      );

      // Check if app was launched via notification response (Terminated state)
      final launchDetails =
          await _notificationsPlugin.getNotificationAppLaunchDetails();
      if (launchDetails != null && launchDetails.didNotificationLaunchApp) {
        final response = launchDetails.notificationResponse;
        if (response != null) {
          log('App launched from terminated state via notification: actionId=${response.actionId}');
          Future.delayed(const Duration(milliseconds: 500), () {
            handleNotificationAction(
              actionId: response.actionId,
              payload: response.payload,
            );
          });
        }
      }
    } catch (e, s) {
      log('WasiyyahReminderService init error: $e\n$s');
    }
  }

  static Future<void> fetchAndProcessReminder({bool isYesClick = false}) async {
    try {
      final response = await ApiService.getData(ApiConstants.getReminderNotification);
      log('getReminderNotification status: ${response.statusCode}, body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.body != null) {
          final Map<String, dynamic> bodyJson =
              response.body is String ? json.decode(response.body) : response.body;
          final model = ReminderNotificationResponseModel.fromJson(bodyJson);

          // Save response values in SharedPreferences
          await _saveReminderData(model);

          if (!isYesClick) {
            // Initial post-login call
            if (model.message != null && model.message!.isNotEmpty) {
              await _showImmediateMessageNotification(model.message!);
            }

            if (model.shouldSchedule == true && model.reminderDateTime != null) {
              await _scheduleReminderNotification(model.reminderDateTime!);
            }
          } else {
            // User clicked "Yes"
            if (model.shouldSchedule == false) {
              // Cancel any scheduled notification before end of day
              await _notificationsPlugin.cancel(id: scheduledNotificationId);
            } else if (model.shouldSchedule == true && model.reminderDateTime != null) {
              // Schedule/show another notification between reminderDateTime and device local time
              await _scheduleReminderNotification(model.reminderDateTime!);
            }
          }
        }
      }
    } catch (e, s) {
      log('Error fetching reminder notification: $e\n$s');
    }
  }

  static Future<void> _saveReminderData(ReminderNotificationResponseModel model) async {
    if (model.lastUpdatedAt != null) {
      await PrefsHelper.setString(keyLastUpdatedAt, model.lastUpdatedAt!);
    }
    if (model.daysSinceLastUpdate != null) {
      await PrefsHelper.setInt(keyDaysSinceLastUpdate, model.daysSinceLastUpdate!);
    }
    if (model.reminderDateTime != null) {
      await PrefsHelper.setString(keyReminderDateTime, model.reminderDateTime!);
    }
    if (model.shouldSchedule != null) {
      await PrefsHelper.setBool(keyShouldSchedule, model.shouldSchedule!);
    }
    if (model.message != null) {
      await PrefsHelper.setString(keyMessage, model.message!);
    }
  }

  static Future<void> _showImmediateMessageNotification(String message) async {
    const androidDetails = AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDesc,
      importance: Importance.max,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
    );
    const notificationDetails = NotificationDetails(android: androidDetails);

    await _notificationsPlugin.show(
      id: immediateNotificationId,
      title: 'Wasiyyah Update',
      body: message,
      notificationDetails: notificationDetails,
      payload: 'wasiyyah_immediate',
    );
  }

  static Future<void> _scheduleReminderNotification(String reminderDateTimeStr) async {
    try {
      final DateTime? parsedDate = DateTime.tryParse(reminderDateTimeStr);
      if (parsedDate == null) return;

      DateTime scheduledTime = parsedDate;
      if (scheduledTime.isBefore(DateTime.now())) {
        scheduledTime = DateTime.now().add(const Duration(seconds: 10));
      }

      final isBn = ApiConstants.currentLang == 'bn';
      final title = isBn
          ? 'আপনি কি আপনার ওসিয়ত হালনাগাদ করেছেন?'
          : 'Do you update your wassiyah?';
      final subtitle = isBn
          ? "আপনি যদি নিশ্চিত হন যে আপনি ইতিমধ্যেই হালনাগাদ করেছেন তবে 'হ্যাঁ' তে ক্লিক করুন, যদি না করে থাকেন তবে 'না' তে ক্লিক করুন।"
          : "If you sure that you are already updated then click on 'Yes', if you won't then click on 'No'";
      final yesText = isBn ? 'হ্যাঁ' : 'Yes';
      final noText = isBn ? 'না' : 'No';

      final androidDetails = AndroidNotificationDetails(
        _channelId,
        _channelName,
        channelDescription: _channelDesc,
        importance: Importance.max,
        priority: Priority.high,
        icon: '@mipmap/ic_launcher',
        actions: <AndroidNotificationAction>[
          AndroidNotificationAction(
            yesActionId,
            yesText,
            showsUserInterface: true,
          ),
          AndroidNotificationAction(
            noActionId,
            noText,
            showsUserInterface: true,
          ),
        ],
      );

      final notificationDetails = NotificationDetails(android: androidDetails);

      final location = tz.local;
      final tzScheduledTime = tz.TZDateTime.from(scheduledTime, location);

      await _notificationsPlugin.zonedSchedule(
        id: scheduledNotificationId,
        title: title,
        body: subtitle,
        scheduledDate: tzScheduledTime,
        notificationDetails: notificationDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        payload: 'wasiyyah_reminder_payload',
      );
      log('Wasiyyah Reminder scheduled at $tzScheduledTime');
    } catch (e, s) {
      log('Error scheduling reminder notification: $e\n$s');
    }
  }

  static void handleNotificationAction({String? actionId, String? payload}) {
    log('Handling Notification Action: actionId=$actionId, payload=$payload');

    if (actionId == yesActionId) {
      // User clicked "Yes"
      fetchAndProcessReminder(isYesClick: true);
    } else if (actionId == noActionId || payload == 'wasiyyah_reminder_payload' || payload == 'wasiyyah_immediate') {
      // User clicked "No" or clicked notification body -> Open app and navigate to Wasiyyah page
      _navigateToWasiyyahPage();
    }
  }

  static void _navigateToWasiyyahPage() {
    log('Navigating to Explore Wasiyyah Page...');
    try {
      Get.toNamed(RouteName.wasyyahPage, preventDuplicates: false);
    } catch (e) {
      log('Navigation error: $e');
    }
  }
}
