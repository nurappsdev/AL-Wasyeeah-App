import 'package:al_wasyeah/app/view/witnessess/controller/witness_controller.dart';
import 'package:al_wasyeah/app/core/route/route_names.dart';
import 'package:al_wasyeah/app/core/utils/api_constants.dart';
import 'package:al_wasyeah/app/core/utils/app_colors.dart';
import 'package:al_wasyeah/app/core/utils/app_constant.dart';
import 'package:al_wasyeah/app/core/widgets/app_error_widget.dart';
import 'package:al_wasyeah/app/core/widgets/custom_button_common.dart';
import 'package:al_wasyeah/app/core/widgets/custom_text.dart';
import 'package:al_wasyeah/app/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:al_wasyeah/app/core/l10n/app_localizations.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AddWitnesWidget extends StatelessWidget {
  AddWitnesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WitnessController>();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
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
              color: Colors.grey.shade300,
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
                icon: const Icon(Icons.close),
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
                          return AppLocalizations.of(context)!.please_enter_your_email;
                        }
                        if (!AppConstants.emailValidate.hasMatch(value)) {
                          return AppLocalizations.of(context)!.invalid_email;
                        }
                        return null;
                      },
                      suffixIcon: AppConstants.emailValidate.hasMatch(controller.searchText.value)
                          ? Padding(
                              padding: EdgeInsets.all(8.h),
                              child: Obx(
                                () => ElevatedButton(
                                  onPressed: controller.searchWitnessStatus.value.isLoading
                                      ? null
                                      : controller.searchWitness,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryColor,
                                    foregroundColor: Colors.white,
                                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    visualDensity: VisualDensity.compact,
                                  ),
                                  child: controller.searchWitnessStatus.value.isLoading
                                      ? SizedBox(
                                          width: 16.h,
                                          height: 16.h,
                                          child: const CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
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
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                    ),
                    containersColor: Colors.grey.shade200,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 3.0,
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.grey[200],
                          child: Icon(Icons.person, color: Colors.white, size: 40.sp),
                        ),
                        title: const Text(
                          "Witness Name Placeholder",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Row(
                          children: [
                            const Icon(Icons.visibility, size: 16.0, color: Colors.grey),
                            const SizedBox(width: 4.0),
                            Text(
                              AppLocalizations.of(context)!.view_details,
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else if (controller.searchWitnessStatus.value.isEmpty) {
                  return Center(child: Text(AppLocalizations.of(context)!.no_data));
                } else if (controller.searchWitnessStatus.value.isSuccess) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 3.0,
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      leading: CircleAvatar(
                          radius: 30,
                          child: controller.searchedWitnesss.value?.imageUrl != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(35.r),
                                  child: Image.network(
                                    ApiConstants.imageUrl + controller.searchedWitnesss.value!.imageUrl!,
                                    fit: BoxFit.fill,
                                    width: 70.w,
                                    height: 70.h,
                                  ),
                                )
                              : Icon(Icons.person, color: Colors.white, size: 40.sp)),
                      title: Text(
                        controller.searchedWitnesss.value?.name ?? AppLocalizations.of(context)!.n_a,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Row(
                        children: [
                          Icon(Icons.visibility, size: 16.0, color: Colors.grey),
                          SizedBox(width: 4.0),
                          Text(
                            AppLocalizations.of(context)!.view_details,
                            style: TextStyle(color: Colors.grey),
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
                    message: controller.searchWitnessStatus.value.errorMessage.toString(),
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
