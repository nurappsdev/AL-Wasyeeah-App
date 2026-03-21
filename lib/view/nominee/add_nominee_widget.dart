import 'package:al_wasyeah/controllers/nomineee/nominee_controller.dart';
import 'package:al_wasyeah/services/api_constants.dart';
import 'package:al_wasyeah/utils/app_colors.dart';
import 'package:al_wasyeah/utils/app_constant.dart';
import 'package:al_wasyeah/view/widgets/app_error_widget.dart';
import 'package:al_wasyeah/view/widgets/custom_button.dart';
import 'package:al_wasyeah/view/widgets/custom_text.dart';
import 'package:al_wasyeah/view/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:al_wasyeah/l10n/app_localizations.dart';

class AddNomineeWidget extends StatelessWidget {
  AddNomineeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NomineeController>();
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
                child: CustomTextField(
                  controller: controller.searchNomineeController,
                  hintText: AppLocalizations.of(context)!.search,
                  borderColor: AppColors.secondaryPrimaryColor,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!
                          .please_enter_your_email;
                    }
                    if (!!AppConstants.emailValidate.hasMatch(value)) {
                      return AppLocalizations.of(context)!.invalid_email;
                    }
                    return null;
                  },
                  suffixIcon: IconButton(
                      onPressed: controller.searchNominee,
                      icon: Icon(
                        Icons.search_rounded,
                        color: AppColors.primaryColor,
                      )),
                ),
              ),

              Obx(() {
                if (controller.searchNomineeStatus.value.isLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (controller.searchNomineeStatus.value.isEmpty) {
                  return Center(
                      child: Text(AppLocalizations.of(context)!.no_data));
                } else if (controller.searchNomineeStatus.value.isSuccess) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 3.0,
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      leading: CircleAvatar(
                          radius: 30,
                          child:
                              controller.searchedNominee.value?.imageUrl != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(35.r),
                                      child: Image.network(
                                        ApiConstants.imageUrl +
                                            controller.searchedNominee.value!
                                                .imageUrl,
                                        fit: BoxFit.fill,
                                        width: 70.w,
                                        height: 70.h,
                                      ),
                                    )
                                  : Icon(Icons.person,
                                      color: Colors.white, size: 40.sp)),
                      title: Text(
                        controller.searchedNominee.value?.name ??
                            AppLocalizations.of(context)!.n_a,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Row(
                        children: [
                          Icon(Icons.visibility,
                              size: 16.0, color: Colors.grey),
                          SizedBox(width: 4.0),
                          Text(
                            AppLocalizations.of(context)!.view_details,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      onTap: () {
                        controller.showAddNomineeBottomSheet();
                      },
                    ),
                  );
                } else {
                  return AppErrorWidget(
                      message: controller.searchNomineeStatus.value.errorMessage
                          .toString());
                }
              }),
              SizedBox(height: 20.h),
              CustomButton(
                title: AppLocalizations.of(context)!.add_outside_witness,
                titlecolor: AppColors.primaryColor,
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
