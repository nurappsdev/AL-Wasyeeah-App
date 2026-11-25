import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wasiyyat/app/core/l10n/app_localizations.dart';
import 'package:wasiyyat/app/core/utils/app_colors.dart';
import 'package:wasiyyat/app/core/widgets/custom_app_bar.dart';
import 'package:wasiyyat/app/core/widgets/custom_text.dart';
import 'package:wasiyyat/app/view/home/controller/home_controller.dart';
import 'controller/alarm_controller.dart';

class AlarmSettingsPage extends StatelessWidget {
  const AlarmSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<AlarmController>()
        ? Get.find<AlarmController>()
        : Get.put(AlarmController());
    final homeController = Get.isRegistered<HomeController>()
        ? Get.find<HomeController>()
        : Get.put(HomeController());
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.alarm_settings,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section 1: General Alarm Preferences
            _buildSectionHeader(
              context,
              AppLocalizations.of(context)!.alarm_settings,
              Icons.alarm,
              isDark,
            ),
            SizedBox(height: 12.h),

            Container(
              decoration: _cardDecoration(isDark),
              child: Column(
                children: [
                  // Vibrate option
                  Obx(
                    () => _buildSwitchTile(
                      context,
                      title: AppLocalizations.of(context)!.vibrate,
                      icon: Icons.vibration,
                      value: controller.vibrate.value,
                      onChanged: (val) => controller.setVibrate(val),
                      isDark: isDark,
                    ),
                  ),
                  Divider(height: 1, color: isDark ? Colors.grey[800] : Colors.grey[200]),

                  // Loop Audio option
                  Obx(
                    () => _buildSwitchTile(
                      context,
                      title: AppLocalizations.of(context)!.loop_audio,
                      icon: Icons.repeat,
                      value: controller.loopAudio.value,
                      onChanged: (val) => controller.setLoopAudio(val),
                      isDark: isDark,
                    ),
                  ),
                  Divider(height: 1, color: isDark ? Colors.grey[800] : Colors.grey[200]),

                  // Android Full Screen Intent option
                  Obx(
                    () => _buildSwitchTile(
                      context,
                      title: AppLocalizations.of(context)!.full_screen_intent,
                      subtitle: AppLocalizations.of(context)!.full_screen_intent_desc,
                      icon: Icons.fullscreen,
                      value: controller.androidFullScreenIntent.value,
                      onChanged: (val) => controller.setAndroidFullScreenIntent(val),
                      isDark: isDark,
                    ),
                  ),
                  Divider(height: 1, color: isDark ? Colors.grey[800] : Colors.grey[200]),

                  // Ringtone Selection Option
                  Obx(
                    () => ListTile(
                      leading: Icon(Icons.music_note, color: AppColors.primaryColor),
                      title: CustomText(
                        text: AppLocalizations.of(context)!.ringtone,
                        fontsize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      subtitle: CustomText(
                        text: controller.selectedRingtone.value == 'assets/audio/azan.mp3'
                            ? AppLocalizations.of(context)!.default_azan
                            : AppLocalizations.of(context)!.device_ringtone,
                        fontsize: 12.sp,
                        color: isDark ? Colors.white60 : Colors.grey[600],
                      ),
                      trailing: DropdownButton<String>(
                        dropdownColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                        value: controller.selectedRingtone.value,
                        underline: const SizedBox(),
                        items: [
                          DropdownMenuItem(
                            value: 'assets/audio/azan.mp3',
                            child: Text(
                              AppLocalizations.of(context)!.default_azan,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: isDark ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'system_ringtone',
                            child: Text(
                              AppLocalizations.of(context)!.device_ringtone,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: isDark ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        ],
                        onChanged: (val) {
                          if (val != null) {
                            controller.setRingtone(val);
                          }
                        },
                      ),
                    ),
                  ),
                  Divider(height: 1, color: isDark ? Colors.grey[800] : Colors.grey[200]),

                  // Enable Snooze Option
                  Obx(
                    () => _buildSwitchTile(
                      context,
                      title: AppLocalizations.of(context)!.enable_snooze,
                      icon: Icons.snooze,
                      value: controller.enableSnooze.value,
                      onChanged: (val) => controller.setEnableSnooze(val),
                      isDark: isDark,
                    ),
                  ),
                  Obx(() {
                    if (!controller.enableSnooze.value) return const SizedBox.shrink();
                    return Column(
                      children: [
                        Divider(height: 1, color: isDark ? Colors.grey[800] : Colors.grey[200]),
                        ListTile(
                          leading: Icon(Icons.timer, color: AppColors.primaryColor),
                          title: CustomText(
                            text: AppLocalizations.of(context)!.snooze_duration,
                            fontsize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          trailing: DropdownButton<int>(
                            dropdownColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                            value: controller.snoozeDurationMinutes.value,
                            underline: const SizedBox(),
                            items: [5, 10, 15, 20].map((int duration) {
                              return DropdownMenuItem<int>(
                                value: duration,
                                child: Text(
                                  '$duration ${AppLocalizations.of(context)!.minutes}',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: isDark ? Colors.white : Colors.black,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (val) {
                              if (val != null) {
                                controller.setSnoozeDuration(val);
                              }
                            },
                          ),
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),

            SizedBox(height: 24.h),

            // Section 2: Prayer Alarms List
            _buildSectionHeader(
              context,
              AppLocalizations.of(context)!.prayer_alarm_settings,
              Icons.access_time_filled,
              isDark,
            ),
            SizedBox(height: 12.h),

            Container(
              decoration: _cardDecoration(isDark),
              child: Obx(() {
                final prayers = ['Fajr', 'Dhuhr', 'Asr', 'Maghrib', 'Isha'];
                return Column(
                  children: prayers.asMap().entries.map((entry) {
                    final index = entry.key;
                    final prayerName = entry.value;
                    final isLast = index == prayers.length - 1;

                    final timeStr = homeController.prayerTimes[prayerName] ?? '';
                    final formattedTime = timeStr.isNotEmpty
                        ? homeController.formatTime(timeStr)
                        : '';

                    final isAlarmEnabled = controller.prayerAlarms[prayerName] ?? false;
                    final isSnoozeEnabled = controller.prayerSnooze[prayerName] ?? true;

                    return Column(
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                          title: Text(
                            prayerName == 'Fajr'
                                ? AppLocalizations.of(context)!.fajr
                                : prayerName == 'Dhuhr'
                                    ? AppLocalizations.of(context)!.dhuhr
                                    : prayerName == 'Asr'
                                        ? AppLocalizations.of(context)!.asr
                                        : prayerName == 'Maghrib'
                                            ? AppLocalizations.of(context)!.maghrib
                                            : AppLocalizations.of(context)!.isha,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                          ),
                          subtitle: Text(
                            formattedTime.isNotEmpty ? formattedTime : '--:--',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: isDark ? Colors.white70 : Colors.grey[600],
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Snooze toggle for prayer
                              if (controller.enableSnooze.value) ...[
                                IconButton(
                                  icon: Icon(
                                    Icons.snooze,
                                    color: isSnoozeEnabled
                                        ? AppColors.primaryColor
                                        : Colors.grey,
                                  ),
                                  tooltip: AppLocalizations.of(context)!.enable_snooze,
                                  onPressed: () {
                                    controller.togglePrayerSnooze(
                                        prayerName, !isSnoozeEnabled);
                                  },
                                ),
                                SizedBox(width: 4.w),
                              ],

                              // Alarm switch for prayer
                              Switch(
                                value: isAlarmEnabled,
                                activeThumbColor: AppColors.primaryColor,
                                onChanged: (val) {
                                  DateTime prayerDate = DateTime.now();
                                  if (timeStr.isNotEmpty) {
                                    try {
                                      final parts = timeStr.split(':');
                                      prayerDate = DateTime(
                                        prayerDate.year,
                                        prayerDate.month,
                                        prayerDate.day,
                                        int.parse(parts[0]),
                                        int.parse(parts[1]),
                                      );
                                    } catch (_) {}
                                  }
                                  controller.togglePrayerAlarm(
                                    prayerName,
                                    prayerDate,
                                    val,
                                    titleText: '$prayerName Alarm',
                                    bodyText: 'Time for $prayerName prayer',
                                    stopButtonText: AppLocalizations.of(context)!.stop,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        if (!isLast)
                          Divider(height: 1, color: isDark ? Colors.grey[800] : Colors.grey[200]),
                      ],
                    );
                  }).toList(),
                );
              }),
            ),

            SizedBox(height: 24.h),

            // Section 3: Test Alarm
            _buildSectionHeader(
              context,
              AppLocalizations.of(context)!.test_prayer,
              Icons.bug_report,
              isDark,
            ),
            SizedBox(height: 12.h),

            Container(
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E1E1E) : Colors.amber.shade50,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.amber, width: 1.5),
              ),
              child: Obx(() {
                final testTime = DateTime.now().add(const Duration(minutes: 1));
                final formattedTestTime =
                    "${testTime.hour.toString().padLeft(2, '0')}:${testTime.minute.toString().padLeft(2, '0')}";
                final isAlarmEnabled = controller.prayerAlarms['Test Prayer'] ?? false;

                return ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                  title: Text(
                    AppLocalizations.of(context)!.test_prayer,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.amber : Colors.amber.shade900,
                    ),
                  ),
                  subtitle: Text(
                    'Trigger time: ${homeController.formatTime(formattedTestTime)} (+1 min)',
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: isDark ? Colors.white70 : Colors.black87,
                    ),
                  ),
                  trailing: Switch(
                    value: isAlarmEnabled,
                    activeThumbColor: Colors.amber,
                    onChanged: (val) {
                      controller.togglePrayerAlarm(
                        'Test Prayer',
                        testTime,
                        val,
                        titleText: 'Test Prayer Alarm',
                        bodyText: 'This is a test alarm for prayer time',
                        stopButtonText: AppLocalizations.of(context)!.stop,
                      );
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context,
    String title,
    IconData icon,
    bool isDark,
  ) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primaryColor, size: 22.sp),
        SizedBox(width: 8.w),
        Text(
          title,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : AppColors.textColor4E4E4E,
          ),
        ),
      ],
    );
  }

  Widget _buildSwitchTile(
    BuildContext context, {
    required String title,
    String? subtitle,
    required IconData icon,
    required bool value,
    required ValueChanged<bool> onChanged,
    required bool isDark,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primaryColor),
      title: CustomText(
        text: title,
        fontsize: 16.sp,
        fontWeight: FontWeight.w600,
      ),
      subtitle: subtitle != null
          ? CustomText(
              text: subtitle,
              fontsize: 12.sp,
              color: isDark ? Colors.white60 : Colors.grey[600],
              maxline: 2,
            )
          : null,
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeThumbColor: AppColors.primaryColor,
      ),
    );
  }

  BoxDecoration _cardDecoration(bool isDark) {
    return BoxDecoration(
      color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
      borderRadius: BorderRadius.circular(12.r),
      border: Border.all(
        color: isDark ? const Color(0xFF2C3E35) : const Color(0xffB0E3D3),
        width: 1.5,
      ),
    );
  }
}
