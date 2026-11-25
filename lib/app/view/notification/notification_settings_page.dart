import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wasiyyat/app/core/l10n/app_localizations.dart';
import 'package:wasiyyat/app/core/utils/app_colors.dart';
import 'package:wasiyyat/app/core/widgets/custom_app_bar.dart';
import 'package:wasiyyat/app/core/widgets/custom_text.dart';
import 'controller/notification_settings_controller.dart';

class NotificationSettingsPage extends StatelessWidget {
  const NotificationSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<NotificationSettingsController>()
        ? Get.find<NotificationSettingsController>()
        : Get.put(NotificationSettingsController());
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.notification_settings,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: isDark ? const Color(0xFF2C3E35) : const Color(0xffB0E3D3),
                  width: 1.5,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.notifications_active_outlined,
                    color: AppColors.primaryColor,
                    size: 28.sp,
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: AppLocalizations.of(context)!.general_notifications,
                          fontsize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(height: 4.h),
                        CustomText(
                          text: AppLocalizations.of(context)!.general_notifications_desc,
                          fontsize: 12.sp,
                          color: isDark ? Colors.white60 : Colors.grey[600],
                          maxline: 2,
                        ),
                      ],
                    ),
                  ),
                  Obx(
                    () => Switch(
                      value: controller.isGeneralNotificationEnabled.value,
                      onChanged: (val) => controller.toggleGeneralNotification(val),
                      activeThumbColor: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
