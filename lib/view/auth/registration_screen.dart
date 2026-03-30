import 'package:al_wasyeah/controllers/auths/auth_controller.dart';
import 'package:al_wasyeah/helpers/app_routes.dart';
import 'package:al_wasyeah/utils/app_colors.dart';
import 'package:al_wasyeah/utils/app_constant.dart';
import 'package:al_wasyeah/utils/app_icons.dart';
import 'package:al_wasyeah/utils/widgets/custom_button_common.dart';
import 'package:al_wasyeah/utils/widgets/custom_text.dart';
import 'package:al_wasyeah/utils/widgets/custom_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../helpers/helpers.dart';
import 'package:al_wasyeah/l10n/app_localizations.dart';

class RegistrationScreen extends StatefulWidget {
  RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<FormState> _forRegKey = GlobalKey<FormState>();

  TextEditingController firstNameController = TextEditingController();

  TextEditingController secondNameController = TextEditingController();

  TextEditingController mobileController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController dateOfBirthController = TextEditingController();

  TextEditingController securityController = TextEditingController();

  AuthController authController = Get.put(AuthController());

  String? _selectedQuestionId;
  RxBool isChecked = false.obs;
  DateTime? birthDate;

  @override
  void dispose() {
    firstNameController.dispose();
    secondNameController.dispose();
    mobileController.dispose();
    emailController.dispose();
    dateOfBirthController.dispose();
    securityController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    authController.getSecurityQuestion();
    print(authController.securityQuestionResponseModel.length);
    return Scaffold(
      body: Container(
        height: Get.height,
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SingleChildScrollView(
            child: Form(
              key: _forRegKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40.h,
                  ),
                  Center(child: SvgPicture.asset(AppIcons.logo, height: 100.h, width: 140.w)),
                  SizedBox(
                    height: 30.h,
                  ),
                  Center(
                      child: CustomText(
                    text: AppLocalizations.of(context)!.registration,
                    fontsize: 28.sp,
                    textAlign: TextAlign.center,
                  )),

                  SizedBox(
                    height: 16.h,
                  ),
                  CustomText(
                    text: AppLocalizations.of(context)!.first_name,
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
                      hintText: AppLocalizations.of(context)!.first_name,
                      borderColor: AppColors.secondaryPrimaryColor,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.please_enter_your_first_name;
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
                    text: AppLocalizations.of(context)!.last_name,
                    color: AppColors.hitTextColor000000,
                    fontsize: 20.sp,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: CustomTextField(
                      controller: secondNameController,
                      hintText: AppLocalizations.of(context)!.last_name,
                      borderColor: AppColors.secondaryPrimaryColor,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.please_enter_your_last_name;
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
                      keyboardType: TextInputType.number,
                      hintText: AppLocalizations.of(context)!.mobile,
                      borderColor: AppColors.secondaryPrimaryColor,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.please_enter_your_mobile_number;
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
                          return AppLocalizations.of(context)!.please_enter_your_email;
                        } else if (!AppConstants.emailValidate.hasMatch(value)) {
                          return AppLocalizations.of(context)!.invalid_email;
                        }
                        return null;
                      },
                    ),
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
                          dateOfBirthController.text = DateFormat('yyyy-MM-dd').format(birthDate!);
                        }
                        print(dateOfBirthController.text);
                      },
                      suffixIcon: Icon(
                        Icons.calendar_month,
                        color: AppColors.primaryColor,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.please_write_date_of_birth;
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 10.h),
                  CustomText(
                    text: AppLocalizations.of(context)!.security_question,
                    fontsize: 16.sp,
                    color: AppColors.hitTextColor000000,
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 10.h),
                  Obx(
                    () => DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.secondaryPrimaryColor), borderRadius: BorderRadius.circular(14.r)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.secondaryPrimaryColor,
                            ),
                            borderRadius: BorderRadius.circular(14.r)),
                        border: OutlineInputBorder(borderSide: BorderSide(color: AppColors.primaryColor), borderRadius: BorderRadius.circular(16.r)),
                      ),
                      isExpanded: true,
                      hint: CustomText(text: AppLocalizations.of(context)!.select_your_question),
                      value: _selectedQuestionId,
                      items: authController.securityQuestionResponseModel
                          .map((model) => DropdownMenuItem<String>(
                                value: model.questionId.toString(),
                                child: Text(model.questionText.toString()),
                              ))
                          .toList(),
                      onChanged: (value) {
                        _selectedQuestionId = value;
                        print(_selectedQuestionId);
                      },
                    ),
                  ),
                  SizedBox(height: 10.h),

                  ///=============Answer====================
                  SizedBox(
                    height: 16.h,
                  ),
                  CustomText(
                    text: AppLocalizations.of(context)!.answer,
                    color: AppColors.hitTextColor000000,
                    fontsize: 20.sp,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: CustomTextField(
                      controller: securityController,
                      hintText: AppLocalizations.of(context)!.answer,
                      borderColor: AppColors.secondaryPrimaryColor,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.please_enter_your_answer;
                        }
                        return null;
                      },
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Obx(
                        () => Checkbox(
                          checkColor: Colors.white,
                          activeColor: AppColors.primaryColor,
                          value: isChecked.value,
                          onChanged: (value) {
                            isChecked.value = value!;
                          },
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: AppLocalizations.of(context)!.i_agree_with,
                          style: TextStyle(color: Colors.black, fontSize: 12.sp),
                          children: [
                            TextSpan(
                              text: AppLocalizations.of(context)!.terms_and_conditions,
                              style: TextStyle(color: AppColors.primaryColor, decoration: TextDecoration.underline, fontSize: 12.sp),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  //  Get.toNamed(AppRoutes.termAndConScreen,preventDuplicates: false);
                                  // Add your custom logic for the Terms & Conditions tap event
                                },
                            ),
                            TextSpan(
                              text: " " + AppLocalizations.of(context)!.and + " ",
                              style: TextStyle(color: Colors.black),
                            ),
                            TextSpan(
                              text: AppLocalizations.of(context)!.privacy_policy,
                              style: TextStyle(color: AppColors.primaryColor, decoration: TextDecoration.underline, fontSize: 12.sp),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  //  Get.toNamed(AppRoutes.aboutScreen,preventDuplicates: false);
                                  // Add your custom logic for the Terms & Conditions tap event
                                },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  ///=============Sign In Button====================
                  Obx(
                    () => CustomButton(
                      loading: authController.signUpLoading.value == true,
                      title: AppLocalizations.of(context)!.registration,
                      onpress: () {
                        // Get.toNamed(AppRoutes.otpScreen,preventDuplicates: false);
                        if (_forRegKey.currentState!.validate()) {
                          authController.signUpHandle(
                              firstName: firstNameController.text,
                              lastName: secondNameController.text,
                              email: emailController.text,
                              mobile: mobileController.text,
                              dob: dateOfBirthController.text,
                              securityAnswer: securityController.text,
                              source: "mobile",
                              securityCode: _selectedQuestionId.toString(),
                              userTypeId: "2");
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),

                  ///=============SignUp====================
                  SizedBox(
                    height: 16.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () {
                            //  Get.toNamed(AppRoutes.otpVirifyScreen,preventDuplicates: false);
                          },
                          child: CustomText(
                            text: AppLocalizations.of(context)!.already_have_an_account,
                            fontsize: 18.sp,
                          )),
                      InkWell(
                          onTap: () {
                            Get.toNamed(AppRoutes.loginPage, preventDuplicates: false);
                          },
                          child: CustomText(
                            text: AppLocalizations.of(context)!.sign_in,
                            fontsize: 18.sp,
                            color: AppColors.primaryColor,
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
