import 'dart:convert';
import 'dart:developer';
import 'package:alarm/alarm.dart';
import 'package:get/get.dart';
import 'package:wasiyyat/app/core/services/shared_pref/prefs_service.dart';

class AlarmController extends GetxController {
  static const String _keyVibrate = 'alarm_vibrate';
  static const String _keyLoopAudio = 'alarm_loop_audio';
  static const String _keyFullScreenIntent = 'alarm_full_screen_intent';
  static const String _keyRingtone = 'alarm_ringtone';
  static const String _keyEnableSnooze = 'alarm_enable_snooze';
  static const String _keySnoozeDuration = 'alarm_snooze_duration';
  static const String _keyPrayerAlarms = 'alarm_prayer_states';
  static const String _keyPrayerSnooze = 'alarm_prayer_snooze';

  final RxBool vibrate = true.obs;
  final RxBool loopAudio = true.obs;
  final RxBool androidFullScreenIntent = true.obs;
  final RxString selectedRingtone = 'assets/audio/azan.mp3'.obs;
  final RxBool enableSnooze = true.obs;
  final RxInt snoozeDurationMinutes = 5.obs;

  final RxMap<String, bool> prayerAlarms = <String, bool>{
    'Fajr': false,
    'Dhuhr': false,
    'Asr': false,
    'Maghrib': false,
    'Isha': false,
    'Test Prayer': false,
  }.obs;

  final RxMap<String, bool> prayerSnooze = <String, bool>{
    'Fajr': true,
    'Dhuhr': true,
    'Asr': true,
    'Maghrib': true,
    'Isha': true,
    'Test Prayer': true,
  }.obs;

  int _getAlarmId(String prayerName) {
    switch (prayerName) {
      case 'Fajr':
        return 101;
      case 'Dhuhr':
        return 102;
      case 'Asr':
        return 103;
      case 'Maghrib':
        return 104;
      case 'Isha':
        return 105;
      case 'Test Prayer':
        return 999;
      default:
        return prayerName.hashCode.abs() % 10000;
    }
  }

  @override
  void onInit() {
    super.onInit();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    vibrate.value = await PrefsHelper.getBool(_keyVibrate);
    loopAudio.value = await PrefsHelper.getBool(_keyLoopAudio);
    androidFullScreenIntent.value = await PrefsHelper.getBool(_keyFullScreenIntent);

    final ringtone = await PrefsHelper.getString(_keyRingtone);
    if (ringtone.isNotEmpty) {
      selectedRingtone.value = ringtone;
    }

    enableSnooze.value = await PrefsHelper.getBool(_keyEnableSnooze);
    final snoozeDur = await PrefsHelper.getInt(_keySnoozeDuration);
    if (snoozeDur > 0) {
      snoozeDurationMinutes.value = snoozeDur;
    }

    final alarmsJson = await PrefsHelper.getString(_keyPrayerAlarms);
    if (alarmsJson.isNotEmpty) {
      try {
        final Map<String, dynamic> decoded = json.decode(alarmsJson);
        decoded.forEach((key, value) {
          if (value is bool) {
            prayerAlarms[key] = value;
          }
        });
      } catch (e) {
        log('Error parsing prayer alarms JSON: $e');
      }
    }

    final snoozeJson = await PrefsHelper.getString(_keyPrayerSnooze);
    if (snoozeJson.isNotEmpty) {
      try {
        final Map<String, dynamic> decoded = json.decode(snoozeJson);
        decoded.forEach((key, value) {
          if (value is bool) {
            prayerSnooze[key] = value;
          }
        });
      } catch (e) {
        log('Error parsing prayer snooze JSON: $e');
      }
    }
  }

  Future<void> setVibrate(bool value) async {
    vibrate.value = value;
    await PrefsHelper.setBool(_keyVibrate, value);
  }

  Future<void> setLoopAudio(bool value) async {
    loopAudio.value = value;
    await PrefsHelper.setBool(_keyLoopAudio, value);
  }

  Future<void> setAndroidFullScreenIntent(bool value) async {
    androidFullScreenIntent.value = value;
    await PrefsHelper.setBool(_keyFullScreenIntent, value);
  }

  Future<void> setRingtone(String ringtone) async {
    selectedRingtone.value = ringtone;
    await PrefsHelper.setString(_keyRingtone, ringtone);
  }

  Future<void> setEnableSnooze(bool value) async {
    enableSnooze.value = value;
    await PrefsHelper.setBool(_keyEnableSnooze, value);
  }

  Future<void> setSnoozeDuration(int minutes) async {
    snoozeDurationMinutes.value = minutes;
    await PrefsHelper.setInt(_keySnoozeDuration, minutes);
  }

  Future<void> togglePrayerAlarm(
    String prayerName,
    DateTime prayerTime,
    bool enable, {
    String? titleText,
    String? bodyText,
    String? stopButtonText,
  }) async {
    prayerAlarms[prayerName] = enable;
    await PrefsHelper.setString(_keyPrayerAlarms, json.encode(prayerAlarms));

    if (enable) {
      await scheduleAlarm(
        prayerName: prayerName,
        prayerTime: prayerTime,
        titleText: titleText,
        bodyText: bodyText,
        stopButtonText: stopButtonText,
      );
    } else {
      await cancelAlarm(prayerName);
    }
  }

  Future<void> togglePrayerSnooze(String prayerName, bool enable) async {
    prayerSnooze[prayerName] = enable;
    await PrefsHelper.setString(_keyPrayerSnooze, json.encode(prayerSnooze));
  }

  Future<void> scheduleAlarm({
    required String prayerName,
    required DateTime prayerTime,
    String? titleText,
    String? bodyText,
    String? stopButtonText,
  }) async {
    try {
      DateTime scheduledDate = prayerTime;
      if (scheduledDate.isBefore(DateTime.now())) {
        scheduledDate = scheduledDate.add(const Duration(days: 1));
      }

      final id = _getAlarmId(prayerName);
      final isSnoozeEnabledForThisPrayer =
          enableSnooze.value && (prayerSnooze[prayerName] ?? true);

      final audioPath = selectedRingtone.value;

      final alarmSettings = AlarmSettings(
        id: id,
        dateTime: scheduledDate,
        assetAudioPath: audioPath,
        loopAudio: loopAudio.value,
        vibrate: vibrate.value,
        androidFullScreenIntent: androidFullScreenIntent.value,
        volumeSettings: VolumeSettings.fixed(volume: 1.0, volumeEnforced: true),
        notificationSettings: NotificationSettings(
          title: titleText ?? '$prayerName Time',
          body: bodyText ?? 'Time for $prayerName prayer',
          stopButton: stopButtonText ?? 'Stop',
          icon: 'app_icon',
        ),
        androidSnoozeDuration: isSnoozeEnabledForThisPrayer
            ? Duration(minutes: snoozeDurationMinutes.value)
            : null,
      );

      await Alarm.set(alarmSettings: alarmSettings);
      log('Alarm scheduled for $prayerName at $scheduledDate (ID: $id)');
    } catch (e, s) {
      log('Failed to schedule alarm for $prayerName: $e\n$s');
    }
  }

  Future<void> cancelAlarm(String prayerName) async {
    final id = _getAlarmId(prayerName);
    await Alarm.stop(id);
    log('Alarm canceled for $prayerName (ID: $id)');
  }
}
