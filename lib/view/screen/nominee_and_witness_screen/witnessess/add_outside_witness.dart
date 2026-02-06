import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../controllers/controllers.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_constant.dart';

import '../../../widgets/widgets.dart';

class AddOutsideWitness extends StatelessWidget {
  AddOutsideWitness({super.key});

  TextEditingController relNameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();

  TextEditingController presentAddressController = TextEditingController();

  TextEditingController permanentAddressController = TextEditingController();
  DateTime? birthDate;
  NomineeController nomineeController = Get.find<NomineeController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: CustomText(
            text: "Outside Witness".tr,
            fontsize: 18,
          ),
        ),
        body: BackgroundImageContainer(
          child: Container(
            height: Get.height,
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),

                      ///=============Last Name====================
                      SizedBox(
                        height: 16,
                      ),
                      CustomText(
                        text: "Relation with Witness".tr,
                        color: AppColors.hitTextColor000000,
                        fontsize: 20,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 16),
                        child: CustomTextField(
                          controller: relNameController,
                          hintText: "Relation with Witness".tr,
                          borderColor: AppColors.secondaryPrimaryColor,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Relation with Witness'.tr;
                            }
                            return null;
                          },
                        ),
                      ),

                      ///=============Last Name====================
                      SizedBox(
                        height: 16,
                      ),
                      CustomText(
                        text: "Name".tr,
                        color: AppColors.hitTextColor000000,
                        fontsize: 20,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 16),
                        child: CustomTextField(
                          controller: nameController,
                          hintText: "Name".tr,
                          borderColor: AppColors.secondaryPrimaryColor,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your Name'.tr;
                            }
                            return null;
                          },
                        ),
                      ),

                      ///=============Mobile====================
                      SizedBox(
                        height: 16,
                      ),
                      CustomText(
                        text: "Mobile".tr,
                        color: AppColors.hitTextColor000000,
                        fontsize: 20,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 16),
                        child: CustomTextField(
                          controller: mobileController,
                          hintText: "Mobile".tr,
                          borderColor: AppColors.secondaryPrimaryColor,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your Mobile Number'.tr;
                            }
                            return null;
                          },
                        ),
                      ),

                      ///=============Email====================
                      SizedBox(
                        height: 16,
                      ),
                      CustomText(
                        text: "email".tr,
                        color: AppColors.hitTextColor000000,
                        fontsize: 20,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 16),
                        child: CustomTextField(
                          controller: emailController,
                          hintText: 'enterYourEmail'.tr,
                          borderColor: AppColors.secondaryPrimaryColor,
                          // prefixIcon: Padding(
                          //   padding: EdgeInsets.only(left: 16, right: 12),
                          //   child: SvgPicture.asset(AppIcons.email, color:
                          //   AppColors.primaryColor, height: 20, width: 20),
                          // ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your Email'.tr;
                            } else if (!AppConstants.emailValidate
                                .hasMatch(value)) {
                              return "Invalid Email".tr;
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomText(
                        text: "Date of birth".tr,
                        fontsize: 16,
                        color: AppColors.hitTextColor000000,
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: 8),
                      Padding(
                        padding: EdgeInsets.only(bottom: 16),
                        child: CustomTextField(
                          controller: dateOfBirthController,
                          readOnly: true,
                          hintText: "Date of birth".tr,
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
                              return 'Please Write Date of birth'.tr;
                            }
                            return null;
                          },
                        ),
                      ),

                      ///============Present Address"===================
                      SizedBox(
                        height: 16,
                      ),
                      CustomText(
                        text: "Present Address".tr,
                        color: AppColors.hitTextColor000000,
                        fontsize: 20,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 16),
                        child: CustomTextField(
                          controller: presentAddressController,
                          hintText: "Present Address".tr,
                          maxLine: 4,
                          borderColor: AppColors.secondaryPrimaryColor,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Present Address'.tr;
                            }
                            return null;
                          },
                        ),
                      ),

                      ///============Permanent Address"===================
                      SizedBox(
                        height: 16,
                      ),
                      CustomText(
                        text: "Permanent Address".tr,
                        color: AppColors.hitTextColor000000,
                        fontsize: 20,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 16),
                        child: CustomTextField(
                          controller: permanentAddressController,
                          hintText: "Permanent Address".tr,
                          maxLine: 4,
                          borderColor: AppColors.secondaryPrimaryColor,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Permanent Address'.tr;
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
                            title: "Submit",
                            onpress: () {
                              if (_formKey.currentState!.validate()) {
                                nomineeController.addNomineeAndWitness(
                                    isNomineeTrue: false,
                                    userName: nameController.text,
                                    mobileNo: mobileController.text,
                                    email: emailController.text,
                                    relationWithUser: relNameController.text,
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
