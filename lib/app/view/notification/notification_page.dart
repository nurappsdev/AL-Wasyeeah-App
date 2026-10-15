import 'package:al_wasyeah/app/core/l10n/app_localizations.dart';
import 'package:al_wasyeah/app/core/utils/app_colors.dart';
import 'package:al_wasyeah/app/core/widgets/custom_app_bar.dart';
import 'package:al_wasyeah/app/core/widgets/custom_text.dart';
import 'package:al_wasyeah/app/view/notification/controller/notification_controller.dart';
import 'package:al_wasyeah/app/view/notification/model/inapp_notification_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';

class NotificationPage extends StatelessWidget {
  NotificationPage({super.key});

  final NotificationController notificationController =
      Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF9FAFB),
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.notifications,
      ),
      body: notificationController.obx(
        (data) => RefreshIndicator(
          color: AppColors.primaryColor,
          onRefresh: () async {
            await notificationController.getNotificationList();
          },
          child: ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            itemCount: data!.length,
            separatorBuilder: (_, __) => SizedBox(height: 12.h),
            itemBuilder: (context, index) {
              return _buildNotificationCard(
                context,
                item: data[index],
                isSkeleton: false,
              );
            },
          ),
        ),
        onLoading: _buildSkeletonLoading(context),
        onEmpty: _buildEmptyState(context),
        onError: (error) => _buildErrorState(context),
      ),
    );
  }

  /// ================= SKELETON LOADING =================
  Widget _buildSkeletonLoading(BuildContext context) {
    final dummyNotifications = [
      InAppNotificationModel(
        message:
            "You have received a new witness request from an applicant. Please review the details and approve or decline.",
        generateAt: DateTime.now().subtract(const Duration(minutes: 15)),
        status: "UNREAD",
        requestKey: "skeleton_1",
      ),
      InAppNotificationModel(
        message:
            "Your Wasiyyah document has been successfully updated and securely saved to your account.",
        generateAt: DateTime.now().subtract(const Duration(hours: 2)),
        status: "UNREAD",
      ),
      InAppNotificationModel(
        message:
            "Zakat calculation summary for your gold and financial assets is now available for review.",
        generateAt: DateTime.now().subtract(const Duration(days: 1)),
        status: "READ",
      ),
      InAppNotificationModel(
        message:
            "Please verify your nominee details to keep your legal inheritance records up to date.",
        generateAt: DateTime.now().subtract(const Duration(days: 2)),
        status: "READ",
      ),
      InAppNotificationModel(
        message:
            "New Islamic estate distribution guidelines have been updated for your reference.",
        generateAt: DateTime.now().subtract(const Duration(days: 3)),
        status: "READ",
      ),
    ];

    return Skeletonizer(
      enabled: true,
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        itemCount: dummyNotifications.length,
        separatorBuilder: (_, __) => SizedBox(height: 12.h),
        itemBuilder: (context, index) {
          return _buildNotificationCard(
            context,
            item: dummyNotifications[index],
            isSkeleton: true,
          );
        },
      ),
    );
  }

  /// ================= MODERN NOTIFICATION CARD =================
  Widget _buildNotificationCard(
    BuildContext context, {
    required InAppNotificationModel item,
    required bool isSkeleton,
  }) {
    final isUnread = item.status?.toUpperCase() == "UNREAD";
    final isWitnessRequest =
        item.message != null && item.message!.toLowerCase().contains("witness");
    final showActionButtons = isWitnessRequest &&
        (isSkeleton ||
            (item.message != null &&
                item.message!.toLowerCase().contains("<")));

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isUnread
              ? AppColors.primaryColor.withValues(alpha: 0.28)
              : const Color(0xffE5E7EB),
          width: isUnread ? 1.2 : 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: isUnread
                ? AppColors.primaryColor.withValues(alpha: 0.05)
                : Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16.r),
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: isSkeleton
              ? null
              : () {
                  // handle notification tap if needed
                },
          child: Padding(
            padding: EdgeInsets.all(14.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Modern Leading Icon
                Container(
                  height: 42.w,
                  width: 42.w,
                  decoration: BoxDecoration(
                    gradient: isUnread && !isWitnessRequest
                        ? LinearGradient(
                            colors: [
                              AppColors.primaryColor,
                              const Color(0xff0A9B4E),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                        : null,
                    color: isWitnessRequest
                        ? AppColors.primaryColor.withValues(alpha: 0.12)
                        : (isUnread ? null : const Color(0xffF3F4F6)),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    isWitnessRequest
                        ? Icons.how_to_reg_rounded
                        : (isUnread
                            ? Icons.notifications_active_rounded
                            : Icons.notifications_none_rounded),
                    color: isWitnessRequest
                        ? AppColors.primaryColor
                        : (isUnread ? Colors.white : const Color(0xff6B7280)),
                    size: 20.sp,
                  ),
                ),

                SizedBox(width: 12.w),

                /// Message & Action Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Top Meta Row: Badge & Timestamp
                      Row(
                        children: [
                          if (isWitnessRequest)
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 7.w,
                                vertical: 2.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor
                                    .withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(6.r),
                              ),
                              child: Text(
                                AppLocalizations.of(context)!.witness_request,
                                style: TextStyle(
                                  fontSize: 10.5.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            )
                          else if (isUnread)
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 7.w,
                                vertical: 2.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor
                                    .withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(6.r),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 5.w,
                                    height: 5.w,
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  SizedBox(width: 4.w),
                                  Text(
                                    AppLocalizations.of(context)!.new_text.toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 9.5.sp,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primaryColor,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          const Spacer(),
                          if (item.generateAt != null)
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.access_time_rounded,
                                  size: 11.sp,
                                  color: const Color(0xff9CA3AF),
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  DateFormat('dd MMM yyyy, hh:mm a')
                                      .format(item.generateAt!),
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xff9CA3AF),
                                    letterSpacing: 0.2,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),

                      SizedBox(height: 6.h),

                      /// Message Content
                      if (isSkeleton)
                        Text(
                          item.message ?? "",
                          style: TextStyle(
                            fontSize: 13.sp,
                            height: 1.45,
                            color: const Color(0xff1F2937),
                          ),
                          maxLines: 3,
                        )
                      else if (item.message != null &&
                          item.message!.contains("<"))
                        HtmlWidget(
                          item.message ?? '',
                          textStyle: TextStyle(
                            fontSize: 13.sp,
                            color: const Color(0xff1F2937),
                            height: 1.45,
                          ),
                        )
                      else
                        CustomText(
                          text: item.message ?? "",
                          fontsize: 13.sp,
                          color: isUnread
                              ? const Color(0xff111827)
                              : AppColors.textColor4E4E4E,
                          textAlign: TextAlign.left,
                          maxline: 4,
                          textOverflow: TextOverflow.ellipsis,
                          textHeight: 1.45,
                        ),

                      /// Witness Action Buttons
                      if (showActionButtons)
                        Padding(
                          padding: EdgeInsets.only(top: 12.h),
                          child: Row(
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: isSkeleton
                                      ? null
                                      : () => notificationController
                                          .approveOrDeclienNotification(
                                              item.requestKey, "Y"),
                                  icon: Icon(
                                    Icons.check_circle_outline_rounded,
                                    size: 15.sp,
                                    color: Colors.white,
                                  ),
                                  label: Text(
                                    AppLocalizations.of(context)!.approve,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryColor,
                                    foregroundColor: Colors.white,
                                    elevation: 0,
                                    shadowColor: Colors.transparent,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10.w,
                                      vertical: 7.h,
                                    ),
                                    minimumSize: Size(0, 32.h),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: isSkeleton
                                      ? null
                                      : () => notificationController
                                          .approveOrDeclienNotification(
                                              item.requestKey, "N"),
                                  icon: Icon(
                                    Icons.cancel_outlined,
                                    size: 15.sp,
                                    color: Colors.red.shade600,
                                  ),
                                  label: Text(
                                    AppLocalizations.of(context)!.decline,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.red.shade700,
                                    ),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(
                                      color: Colors.red.shade200,
                                      width: 1.2,
                                    ),
                                    backgroundColor: Colors.red.shade50
                                        .withValues(alpha: 0.5),
                                    foregroundColor: Colors.red.shade700,
                                    elevation: 0,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10.w,
                                      vertical: 7.h,
                                    ),
                                    minimumSize: Size(0, 32.h),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// ================= EMPTY STATE =================
  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 76.w,
              width: 76.w,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.notifications_none_rounded,
                size: 38.sp,
                color: AppColors.primaryColor,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              AppLocalizations.of(context)!.no_data,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xff374151),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ================= ERROR STATE =================
  Widget _buildErrorState(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 76.w,
              width: 76.w,
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline_rounded,
                size: 38.sp,
                color: Colors.red.shade400,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              AppLocalizations.of(context)!.something_went_wrong,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xff374151),
              ),
            ),
            SizedBox(height: 16.h),
            TextButton.icon(
              onPressed: () => notificationController.getNotificationList(),
              icon: Icon(
                Icons.refresh_rounded,
                size: 18.sp,
                color: AppColors.primaryColor,
              ),
              label: Text(
                "Retry",
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
