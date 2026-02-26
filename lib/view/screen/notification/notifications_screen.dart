import 'dart:developer';

import 'package:al_wasyeah/controllers/notification_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../widgets/widgets.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({Key? key}) : super(key: key);
  final NotificationController notificationController =
      Get.put(NotificationController());

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: CustomText(
            text: "Notifications".tr,
            fontsize: 18.sp,
          ),
        ),
        body: notificationController.obx(
          (data) => ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
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
                    color: isUnread ? const Color(0xffF5F9FF) : Colors.white,
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
                        height: 44,
                        width: 44,
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
                            Html(
                              data: item.message ?? '',
                              style: {
                                "body": Style(
                                  margin: Margins.zero,
                                  padding: HtmlPaddings.zero,
                                  fontSize: FontSize(14),
                                  fontWeight: isUnread
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                                  color: Colors.black87,
                                ),
                                "p": Style(
                                  margin: Margins.zero,
                                ),
                              },
                            ),

                            const SizedBox(height: 8),

                            /// Bottom Row (Time + Unread Dot)
                            // Row(
                            //   children: [
                            //     if (item.createdAt != null)
                            //       Text(
                            //         item.createdAt!,
                            //         style: TextStyle(
                            //           fontSize: 12,
                            //           color: Colors.grey.shade500,
                            //           letterSpacing: 0.3,
                            //         ),
                            //       ),
                            //     const Spacer(),
                            //     if (isUnread)
                            //       Container(
                            //         height: 8,
                            //         width: 8,
                            //         decoration: const BoxDecoration(
                            //           color: Colors.blue,
                            //           shape: BoxShape.circle,
                            //         ),
                            //       ),
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          onLoading: Center(child: CircularProgressIndicator()),
          onEmpty: Center(child: Text("No Data")),
          onError: (error) => Center(child: Text("Something went wrong")),
        ));
  }
}
