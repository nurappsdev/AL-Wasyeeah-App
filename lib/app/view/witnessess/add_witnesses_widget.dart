import 'package:al_wasiyyath/app/view/witnessess/controller/witness_controller.dart';
import 'package:al_wasiyyath/app/core/route/route_names.dart';
import 'package:al_wasiyyath/app/core/utils/api_constants.dart';
import 'package:al_wasiyyath/app/core/utils/app_colors.dart';
import 'package:al_wasiyyath/app/core/utils/app_constant.dart';
import 'package:al_wasiyyath/app/core/widgets/app_error_widget.dart';
import 'package:al_wasiyyath/app/core/widgets/custom_button_common.dart';
import 'package:al_wasiyyath/app/core/widgets/custom_text.dart';
import 'package:al_wasiyyath/app/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:al_wasiyyath/app/core/l10n/app_localizations.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AddWitnesWidget extends StatelessWidget {
  AddWitnesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WitnessController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Center handle for bottom sheet
          Container(
            width: 40.w,
            height: 4.h,
            margin: EdgeInsets.only(bottom: 20.h),
            decoration: BoxDecoration(
              color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: AppLocalizations.of(context)!.add_witness,
                fontsize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
              IconButton(
                onPressed: () => Get.back(),
                icon: Icon(Icons.close,
                    color: isDark ? Colors.white : Colors.black),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///=============Search Field====================
              Padding(
                  padding: EdgeInsets.only(bottom: 16.h),
                  child: Obx(
                    () => CustomTextField(
                      controller: controller.searchWitnessController,
                      hintText: AppLocalizations.of(context)!.search,
                      borderColor: AppColors.secondaryPrimaryColor,
                      onChange: (value) {
                        controller.searchText.value = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!
                              .please_enter_your_email;
                        }
                        if (!AppConstants.emailValidate.hasMatch(value)) {
                          return AppLocalizations.of(context)!.invalid_email;
                        }
                        return null;
                      },
                      suffixIcon: AppConstants.emailValidate
                              .hasMatch(controller.searchText.value)
                          ? Padding(
                              padding: EdgeInsets.all(8.h),
                              child: Obx(
                                () => ElevatedButton(
                                  onPressed: controller
                                          .searchWitnessStatus.value.isLoading
                                      ? null
                                      : controller.searchWitness,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryColor,
                                    foregroundColor: Colors.white,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 12.w),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    visualDensity: VisualDensity.compact,
                                  ),
                                  child: controller
                                          .searchWitnessStatus.value.isLoading
                                      ? SizedBox(
                                          width: 16.h,
                                          height: 16.h,
                                          child:
                                              const CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Colors.white),
                                          ),
                                        )
                                      : Text(
                                          AppLocalizations.of(context)!.search,
                                          style: TextStyle(fontSize: 12.sp),
                                        ),
                                ),
                              ),
                            )
                          : null,
                    ),
                  )),

              Obx(() {
                if (controller.searchWitnessStatus.value.isLoading) {
                  return Skeletonizer(
                    enabled: true,
                    effect: ShimmerEffect(
                      baseColor:
                          isDark ? Colors.grey.shade800 : Colors.grey.shade300,
                      highlightColor:
                          isDark ? Colors.grey.shade700 : Colors.grey.shade100,
                    ),
                    containersColor:
                        isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                    child: Card(
                      color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        side: isDark
                            ? const BorderSide(color: Color(0xFF2C3E35))
                            : BorderSide.none,
                      ),
                      elevation: 3.0,
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundColor:
                              isDark ? Colors.grey.shade800 : Colors.grey[200],
                          child: Icon(Icons.person,
                              color: Colors.white, size: 40.sp),
                        ),
                        title: Text(
                          "Witness Name Placeholder",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                        subtitle: Row(
                          children: [
                            Icon(Icons.visibility,
                                size: 16.0,
                                color: isDark
                                    ? const Color(0xff94A3B8)
                                    : Colors.grey),
                            const SizedBox(width: 4.0),
                            Text(
                              AppLocalizations.of(context)!.view_details,
                              style: TextStyle(
                                  color: isDark
                                      ? const Color(0xff94A3B8)
                                      : Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else if (controller.searchWitnessStatus.value.isEmpty) {
                  return Center(
                    child: Text(
                      AppLocalizations.of(context)!.no_data,
                      style: TextStyle(
                        color: isDark ? Colors.white70 : Colors.black54,
                      ),
                    ),
                  );
                } else if (controller.searchWitnessStatus.value.isSuccess) {
                  return Card(
                    color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      side: isDark
                          ? const BorderSide(color: Color(0xFF2C3E35))
                          : BorderSide.none,
                    ),
                    elevation: 3.0,
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      leading: CircleAvatar(
                          radius: 30,
                          backgroundColor:
                              isDark ? Colors.grey.shade800 : Colors.grey[200],
                          child: controller.searchedWitnesss.value?.imageUrl !=
                                  null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(35.r),
                                  child: Image.network(
                                    ApiConstants.imageUrl +
                                        controller
                                            .searchedWitnesss.value!.imageUrl!,
                                    fit: BoxFit.fill,
                                    width: 70.w,
                                    height: 70.h,
                                  ),
                                )
                              : Icon(Icons.person,
                                  color: Colors.white, size: 40.sp)),
                      title: Text(
                        controller.searchedWitnesss.value?.name ??
                            AppLocalizations.of(context)!.n_a,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                      subtitle: Row(
                        children: [
                          Icon(Icons.visibility,
                              size: 16.0,
                              color: isDark
                                  ? const Color(0xff94A3B8)
                                  : Colors.grey),
                          const SizedBox(width: 4.0),
                          Text(
                            AppLocalizations.of(context)!.view_details,
                            style: TextStyle(
                              color: isDark
                                  ? const Color(0xff94A3B8)
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        if (controller.searchedWitnesss.value != null) {
                          Get.toNamed(
                            RouteName.witnessDetailsPage,
                            preventDuplicates: false,
                            arguments: {
                              'witness': controller.searchedWitnesss.value,
                              'canRemove': false,
                            },
                          );
                        }
                      },
                    ),
                  );
                } else {
                  return AppErrorWidget(
                    message: controller.searchWitnessStatus.value.errorMessage
                        .toString(),
                    onRetry: controller.searchWitness,
                  );
                }
              }),
              SizedBox(height: 20.h),
              CustomButton(
                title: AppLocalizations.of(context)!.add_outside_witness,
                titlecolor: AppColors.whiteColor,
                onpress: () {
                  controller.showAddOutsideWitnessBottomSheet();
                },
              ),
              SizedBox(height: 10.h),
            ],
          ),
        ],
      ),
    );
  }
}
