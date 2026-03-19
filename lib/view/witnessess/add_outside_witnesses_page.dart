import 'package:al_wasyeah/controllers/nomineee/nominee_controller.dart';
import 'package:al_wasyeah/utils/app_colors.dart';
import 'package:al_wasyeah/utils/app_constant.dart';
import 'package:al_wasyeah/view/widgets/custom_button_common.dart'
    show CustomButtonCommon;
import 'package:al_wasyeah/view/widgets/custom_text.dart';
import 'package:al_wasyeah/view/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:al_wasyeah/l10n/app_localizations.dart';

class AddOutsideWitness extends StatelessWidget {
  AddOutsideWitness({super.key});

  final TextEditingController relNameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();

  final TextEditingController presentAddressController =
      TextEditingController();

  final TextEditingController permanentAddressController =
      TextEditingController();
  DateTime? birthDate;
  final NomineeController nomineeController = Get.put(NomineeController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Center handle for bottom sheet
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 40.w,
                height: 4.h,
                margin: EdgeInsets.only(bottom: 20.h),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: AppLocalizations.of(context)!.outside_witness,
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
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///=============Relation====================
                  CustomText(
                    text: AppLocalizations.of(context)!.relation_with_witness,
                    color: AppColors.hitTextColor000000,
                    fontsize: 16.sp,
                  ),
                  SizedBox(height: 8.h),
                  Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: CustomTextField(
                      controller: relNameController,
                      hintText:
                          AppLocalizations.of(context)!.relation_with_witness,
                      borderColor: AppColors.secondaryPrimaryColor,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!
                              .relation_with_witness;
                        }
                        return null;
                      },
                    ),
                  ),

                  ///=============Name====================
                  CustomText(
                    text: AppLocalizations.of(context)!.name,
                    color: AppColors.hitTextColor000000,
                    fontsize: 16.sp,
                  ),
                  SizedBox(height: 8.h),
                  Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: CustomTextField(
                      controller: nameController,
                      hintText: AppLocalizations.of(context)!.name,
                      borderColor: AppColors.secondaryPrimaryColor,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!
                              .please_enter_name;
                        }
                        return null;
                      },
                    ),
                  ),

                  ///=============Mobile====================
                  CustomText(
                    text: AppLocalizations.of(context)!.mobile,
                    color: AppColors.hitTextColor000000,
                    fontsize: 16.sp,
                  ),
                  SizedBox(height: 8.h),
                  Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: CustomTextField(
                      controller: mobileController,
                      hintText: AppLocalizations.of(context)!.mobile,
                      borderColor: AppColors.secondaryPrimaryColor,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!
                              .please_enter_your_mobile_number;
                        }
                        return null;
                      },
                    ),
                  ),

                  ///=============Email====================
                  CustomText(
                    text: AppLocalizations.of(context)!.email,
                    color: AppColors.hitTextColor000000,
                    fontsize: 16.sp,
                  ),
                  SizedBox(height: 8.h),
                  Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: CustomTextField(
                      controller: emailController,
                      hintText: AppLocalizations.of(context)!.email,
                      borderColor: AppColors.secondaryPrimaryColor,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!
                              .please_enter_your_email;
                        } else if (!AppConstants.emailValidate
                            .hasMatch(value)) {
                          return AppLocalizations.of(context)!.invalid_email;
                        }
                        return null;
                      },
                    ),
                  ),

                  ///=============DOB====================
                  CustomText(
                    text: AppLocalizations.of(context)!.date_of_birth,
                    fontsize: 16.sp,
                    color: AppColors.hitTextColor000000,
                  ),
                  SizedBox(height: 8.h),
                  Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: CustomTextField(
                      controller: dateOfBirthController,
                      readOnly: true,
                      hintText: AppLocalizations.of(context)!.date_of_birth,
                      hintextColor: Colors.black54,
                      borderColor: AppColors.secondaryPrimaryColor,
                      onTap: () async {
                        DateTime? selectedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1930),
                          lastDate: DateTime.now(),
                        );

                        if (selectedDate != null) {
                          birthDate = selectedDate;
                          dateOfBirthController.text =
                              DateFormat('yyyy-MM-dd').format(birthDate!);
                        }
                      },
                      suffixIcon: Icon(
                        Icons.calendar_month,
                        color: AppColors.primaryColor,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!
                              .please_write_date_of_birth;
                        }
                        return null;
                      },
                    ),
                  ),

                  ///============Present Address===================
                  CustomText(
                    text: AppLocalizations.of(context)!.present_address,
                    color: AppColors.hitTextColor000000,
                    fontsize: 16.sp,
                  ),
                  SizedBox(height: 8.h),
                  Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: CustomTextField(
                      controller: presentAddressController,
                      hintText: AppLocalizations.of(context)!.present_address,
                      maxLine: 3,
                      borderColor: AppColors.secondaryPrimaryColor,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.present_address;
                        }
                        return null;
                      },
                    ),
                  ),

                  ///============Permanent Address===================
                  CustomText(
                    text: AppLocalizations.of(context)!.permanent_address,
                    color: AppColors.hitTextColor000000,
                    fontsize: 16.sp,
                  ),
                  SizedBox(height: 8.h),
                  Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: CustomTextField(
                      controller: permanentAddressController,
                      hintText: AppLocalizations.of(context)!.permanent_address,
                      maxLine: 3,
                      borderColor: AppColors.secondaryPrimaryColor,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!
                              .permanent_address;
                        }
                        return null;
                      },
                    ),
                  ),

                  SizedBox(height: 10.h),
                  Obx(
                    () => CustomButtonCommon(
                        loading:
                            nomineeController.addNomineeLoading.value == true,
                        title: AppLocalizations.of(context)!.save,
                        onpress: () {
                          if (_formKey.currentState!.validate()) {
                            nomineeController.addNomineeAndWitness(
                                isNomineeTrue: false,
                                userName: nameController.text,
                                mobileNo: mobileController.text,
                                email: emailController.text,
                                relationWithUser: relNameController.text,
                                dob: dateOfBirthController.text,
                                presentAddress: presentAddressController.text,
                                permanentAddress:
                                    permanentAddressController.text);
                          }
                        }),
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
