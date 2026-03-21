import 'package:al_wasyeah/controllers/notification/notification_controller.dart';
import 'package:al_wasyeah/view/widgets/background_image_screen_widget.dart';
import 'package:al_wasyeah/view/widgets/custom_back_button_widget.dart';
import 'package:al_wasyeah/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:al_wasyeah/l10n/app_localizations.dart';

class NotificationPage extends StatelessWidget {
  NotificationPage({Key? key}) : super(key: key);
  final NotificationController notificationController =
      Get.put(NotificationController());

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: CustomText(
            text: AppLocalizations.of(context)!.notifications,
            fontsize: 18.sp,
          ),
          leadingWidth: 42.w,
          leading: CustomBackButton(),
        ),
        body: BackgroundImageContainer(
          child: notificationController.obx(
            (data) => RefreshIndicator(
              onRefresh: () async {
                await notificationController.getNotificationList();
              },
              child: ListView.separated(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                itemCount: data!.length,
                separatorBuilder: (_, __) => const SizedBox(height: 14),
                itemBuilder: (context, index) {
                  final item = data[index];
                  final isUnread = !(item.status != "UNREAD");

                  return InkWell(
                    borderRadius: BorderRadius.circular(18),
                    onTap: () {
                      // handle tap
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color:
                            isUnread ? const Color(0xffF5F9FF) : Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: isUnread
                              ? const Color(0xffDCEBFF)
                              : Colors.grey.shade200,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Modern Icon Container
                          Container(
                            height: 36.h,
                            width: 36.w,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.blue.shade400,
                                  Colors.blue.shade600,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Icon(
                              Icons.notifications_outlined,
                              color: Colors.white,
                              size: 22,
                            ),
                          ),

                          const SizedBox(width: 14),

                          /// Message Area
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /// HTML Content
                                item.message != null &&
                                        item.message!.contains("<")
                                    ? Html(
                                        data: item.message ?? '',
                                      )
                                    : CustomText(
                                        text: item.message ?? "",
                                        fontsize: 14.sp,
                                        color: Colors.black,
                                        textAlign: TextAlign.left,
                                        maxline: 3,
                                      ),
                                // const SizedBox(height: 8),

                                /// Bottom Row (Time + Unread Dot)
                                if (item.generateAt != null)
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      textAlign: TextAlign.right,
                                      DateFormat('M/d/yyyy hh:mm a')
                                          .format(item.generateAt!),
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade500,
                                        letterSpacing: 0.3,
                                      ),
                                    ),
                                  ),

                                if (item.message != null &&
                                    item.message!.toLowerCase().contains("<") &&
                                    item.message!
                                        .toLowerCase()
                                        .contains("witness"))
                                  Row(
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () =>
                                              notificationController
                                                  .approveOrDeclienNotification(
                                                      item.requestKey, "Y"),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.green,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 12.w,
                                                vertical: 4.h),
                                            minimumSize: Size(0, 30.h),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.r)),
                                          ),
                                          child: Text(
                                              AppLocalizations.of(context)!
                                                  .approve,
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  color: Colors.white)),
                                        ),
                                      ),
                                      SizedBox(width: 8.w),
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () =>
                                              notificationController
                                                  .approveOrDeclienNotification(
                                                      item.requestKey, "N"),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 12.w,
                                                vertical: 4.h),
                                            minimumSize: Size(0, 30.h),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.r)),
                                          ),
                                          child: Text(
                                              AppLocalizations.of(context)!
                                                  .decline,
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  color: Colors.white)),
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            onLoading: Center(child: CircularProgressIndicator()),
            onEmpty: Center(child: Text(AppLocalizations.of(context)!.no_data)),
            onError: (error) => Center(
                child:
                    Text(AppLocalizations.of(context)!.something_went_wrong)),
          ),
        ));
  }
}
