import 'package:al_wasyeah/view/widgets/background_image_screen_widget.dart';
import 'package:al_wasyeah/view/widgets/custom_button_common.dart';
import 'package:al_wasyeah/view/widgets/custom_text.dart';
import 'package:al_wasyeah/view/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../controllers/controllers.dart';
import '../../../../utils/utils.dart';
import 'package:al_wasyeah/l10n/app_localizations.dart';

class AddOutsideNominee extends StatefulWidget {
  AddOutsideNominee({super.key});

  @override
  State<AddOutsideNominee> createState() => _AddOutsideNomineeState();
}

class _AddOutsideNomineeState extends State<AddOutsideNominee> {
  TextEditingController firstNameController = TextEditingController();

  TextEditingController relWithController = TextEditingController();

  TextEditingController mobileController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController dateOfBirthController = TextEditingController();

  TextEditingController presentAddressController = TextEditingController();

  TextEditingController permanentAddressController = TextEditingController();
  @override
  void dispose() {
    firstNameController.dispose();
    relWithController.dispose();
    mobileController.dispose();
    emailController.dispose();
    dateOfBirthController.dispose();
    presentAddressController.dispose();
    permanentAddressController.dispose();
    super.dispose();
  }

  DateTime? birthDate;
  NomineeController nomineeController = Get.put(NomineeController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: CustomText(
            text: AppLocalizations.of(context)!.outside_nominee,
            fontsize: 18.sp,
          ),
        ),
        body: BackgroundImageContainer(
          child: Container(
            height: Get.height,
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),

                      ///=============Relation with nominee====================
                      SizedBox(
                        height: 16.h,
                      ),
                      CustomText(
                        text:
                            AppLocalizations.of(context)!.relation_with_nominee,
                        color: AppColors.hitTextColor000000,
                        fontsize: 20.sp,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 16.h),
                        child: CustomTextField(
                          controller: relWithController,
                          hintText: AppLocalizations.of(context)!
                              .relation_with_nominee,
                          borderColor: AppColors.secondaryPrimaryColor,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .relation_with_nominee;
                            }
                            return null;
                          },
                        ),
                      ),

                      ///=============Last Name====================
                      SizedBox(
                        height: 16.h,
                      ),
                      CustomText(
                        text: AppLocalizations.of(context)!.name,
                        color: AppColors.hitTextColor000000,
                        fontsize: 20.sp,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 16.h),
                        child: CustomTextField(
                          controller: firstNameController,
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
                      SizedBox(
                        height: 16.h,
                      ),
                      CustomText(
                        text: AppLocalizations.of(context)!.mobile,
                        color: AppColors.hitTextColor000000,
                        fontsize: 20.sp,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
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
                      SizedBox(
                        height: 16.h,
                      ),
                      CustomText(
                        text: AppLocalizations.of(context)!.email,
                        color: AppColors.hitTextColor000000,
                        fontsize: 20.sp,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 16.h),
                        child: CustomTextField(
                          controller: emailController,
                          hintText: AppLocalizations.of(context)!.email,
                          borderColor: AppColors.secondaryPrimaryColor,
                          // prefixIcon: Padding(
                          //   padding: EdgeInsets.only(left: 16.w, right: 12.w),
                          //   child: SvgPicture.asset(AppIcons.email, color:
                          //   AppColors.primaryColor, height: 20.h, width: 20.w),
                          // ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .please_enter_your_email;
                            } else if (!AppConstants.emailValidate
                                .hasMatch(value)) {
                              return AppLocalizations.of(context)!
                                  .invalid_email;
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),

                      ///==========================Date of birth*==========================
                      CustomText(
                        text: AppLocalizations.of(context)!.date_of_birth,
                        fontsize: 16.sp,
                        color: AppColors.hitTextColor000000,
                        textAlign: TextAlign.left,
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
                            print(dateOfBirthController.text);
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

                      ///============Present Address"===================
                      SizedBox(
                        height: 16.h,
                      ),
                      CustomText(
                        text: AppLocalizations.of(context)!.present_address,
                        color: AppColors.hitTextColor000000,
                        fontsize: 20.sp,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 16.h),
                        child: CustomTextField(
                          controller: presentAddressController,
                          hintText:
                              AppLocalizations.of(context)!.present_address,
                          maxLine: 4,
                          borderColor: AppColors.secondaryPrimaryColor,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .present_address;
                            }
                            return null;
                          },
                        ),
                      ),

                      ///============Permanent Address"===================
                      SizedBox(
                        height: 16.h,
                      ),
                      CustomText(
                        text: AppLocalizations.of(context)!.permanent_address,
                        color: AppColors.hitTextColor000000,
                        fontsize: 20.sp,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 16.h),
                        child: CustomTextField(
                          controller: permanentAddressController,
                          hintText:
                              AppLocalizations.of(context)!.permanent_address,
                          maxLine: 4,
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

                      SizedBox(
                        height: 10,
                      ),
                      Obx(
                        () => CustomButtonCommon(
                            loading:
                                nomineeController.addNomineeLoading.value ==
                                    true,
                            title: AppLocalizations.of(context)!.save,
                            onpress: () {
                              if (_formKey.currentState!.validate()) {
                                nomineeController.addNomineeAndWitness(
                                    isNomineeTrue: true,
                                    userName: firstNameController.text,
                                    mobileNo: mobileController.text,
                                    email: emailController.text,
                                    relationWithUser: relWithController.text,
                                    dob: dateOfBirthController.text,
                                    presentAddress:
                                        presentAddressController.text,
                                    permanentAddress:
                                        permanentAddressController.text);
                              }
                            }),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
