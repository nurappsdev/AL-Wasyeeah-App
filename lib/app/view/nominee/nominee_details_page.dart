import 'package:al_wasyeah/app/core/utils/toast_message.dart';
import 'package:al_wasyeah/app/view/nominee/controller/nominee_controller.dart';
import 'package:al_wasyeah/app/core/widgets/custom_app_bar.dart';
import 'package:al_wasyeah/app/view/witnessess/model/get_witness_response_model.dart';
import 'package:al_wasyeah/app/core/utils/api_constants.dart';
import 'package:al_wasyeah/app/core/widgets/custom_button_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:al_wasyeah/app/core/utils/app_colors.dart';
import 'package:al_wasyeah/app/core/l10n/app_localizations.dart';

class NomineeDetailsPage extends StatefulWidget {
  const NomineeDetailsPage({super.key});

  @override
  State<NomineeDetailsPage> createState() => _NomineeDetailsPageState();
}

class _NomineeDetailsPageState extends State<NomineeDetailsPage> {
  final data = Get.arguments;
  final GetWitnessNomineeResponseModel nominee = Get.arguments['nominee'];
  final bool? canRemove = Get.arguments['canRemove'];
  final NomineeController controller = Get.find<NomineeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.nominee_profile_details,
      ),
      body: Container(
        height: Get.height,
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24.h),
                // Profile Header Card
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primaryColor,
                        AppColors.primaryColor.withValues(alpha: 0.8)
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryColor.withValues(alpha: 0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(20.w),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.white.withValues(alpha: 0.2),
                          radius: 35.r,
                          child: nominee.imageUrl != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(35.r),
                                  child: Image.network(
                                    ApiConstants.imageUrl + nominee.imageUrl!,
                                    fit: BoxFit.fill,
                                    width: 70.w,
                                    height: 70.h,
                                  ),
                                )
                              : Icon(Icons.person,
                                  color: Colors.white, size: 40.sp),
                        ),
                      ),
                      SizedBox(width: 20.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              nominee.name ?? "",
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 4.h),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Text(
                                nominee.relation ??
                                    AppLocalizations.of(context)!.n_a,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),

                // Details Section
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                    border: Border.all(color: Colors.grey.shade100),
                  ),
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8.w),
                            decoration: BoxDecoration(
                              color:
                                  AppColors.primaryColor.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Icon(Icons.person_outline,
                                color: AppColors.primaryColor, size: 20.sp),
                          ),
                          SizedBox(width: 12.w),
                          Text(
                            AppLocalizations.of(context)!.personal_details,
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      const Divider(),
                      SizedBox(height: 16.h),
                      _buildDetailRow(context, Icons.phone_android,
                          AppLocalizations.of(context)!.mobile, nominee.mobile),
                      _buildDetailRow(
                          context,
                          Icons.work_outline,
                          AppLocalizations.of(context)!.profession,
                          nominee.profession),
                      _buildDetailRow(context, Icons.email_outlined,
                          AppLocalizations.of(context)!.email, nominee.email),
                      _buildDetailRow(
                          context,
                          Icons.favorite_border,
                          AppLocalizations.of(context)!.marital_status,
                          nominee.maritalStatus),
                      _buildDetailRow(
                          context,
                          Icons.person_add_disabled_outlined,
                          AppLocalizations.of(context)!.mother_s_name_1,
                          nominee.motherName),
                      _buildDetailRow(
                          context,
                          Icons.person_add_alt_1_outlined,
                          AppLocalizations.of(context)!.father_s_name_1,
                          nominee.fatherName),
                      SizedBox(height: 32.h),
                      // if (!canRemove)
                      //   Container(
                      //     width: double.infinity,
                      //     decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(12.r),
                      //       boxShadow: [
                      //         BoxShadow(
                      //           color:
                      //               AppColors.primaryColor.withValues(alpha:0.2),
                      //           blurRadius: 10,
                      //           offset: const Offset(0, 4),
                      //         ),
                      //       ],
                      //     ),
                      //     child: CustomButtonCommon(
                      //       title: AppLocalizations.of(context)!.access_panel,
                      //       onpress: () {
                      //         // Get.toNamed(AppRoutes.nomineePhanelData,
                      //         //     arguments: nominee.requestKey);
                      //       },
                      //     ),
                      //   )
                      // else
                      if (canRemove != null && canRemove!)
                        Obx(() => CustomButton(
                              title: AppLocalizations.of(context)!.remove,
                              color: AppColors.redColor,
                              loading: controller
                                  .deleteNomineeStatus.value.isLoading,
                              onpress: () {
                                nominee.requestKey != null
                                    ? controller
                                        .deleteNominee(
                                            requestKey: nominee.requestKey!)
                                        .then((value) {
                                        if (value) {
                                          Get.back();
                                        }
                                      })
                                    : ToastMessage.errorMessageShowToster(
                                        "Request key not found");
                              },
                            )),
                      SizedBox(height: 16.h),
                      if (canRemove != null && !canRemove!)
                        Container(
                          width: double.infinity,
                          child: CustomButton(
                            title: AppLocalizations.of(context)!.add_nominee,
                            color: AppColors.primaryColor,
                            titlecolor: AppColors.whiteColor,
                            onpress: nominee.email == null
                                ? null
                                : () {
                                    controller.addYourNominee(
                                        email: nominee.email!);
                                  },
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

  Widget _buildDetailRow(
      BuildContext context, IconData icon, String label, String? value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey.shade400, size: 20.sp),
          SizedBox(width: 12.w),
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14.sp,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value ?? AppLocalizations.of(context)!.n_a,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
