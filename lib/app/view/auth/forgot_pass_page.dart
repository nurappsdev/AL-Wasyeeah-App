import 'package:al_wasyeah/app/view/auth/controller/auth_controller.dart';
import 'package:al_wasyeah/app/core/widgets/custom_app_bar.dart';
import 'package:al_wasyeah/app/core/utils/app_colors.dart';
import 'package:al_wasyeah/app/core/utils/app_constant.dart';
import 'package:al_wasyeah/app/core/utils/app_icons.dart';
import 'package:al_wasyeah/app/core/widgets/custom_button_common.dart';
import 'package:al_wasyeah/app/core/widgets/custom_text.dart';
import 'package:al_wasyeah/app/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:al_wasyeah/app/core/l10n/app_localizations.dart';

class ForgotPasswordPage extends StatefulWidget {
  ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final GlobalKey<FormState> _logRegKey = GlobalKey<FormState>();

  TextEditingController securityController = TextEditingController();

  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  DateTime? birthDate;
  AuthController authController = Get.put(AuthController());

  String? _selectedQuestionId;

  @override
  Widget build(BuildContext context) {
    authController.getSecurityQuestion();
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.forgot_password,
      ),
      body: Container(
        height: Get.height,
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SingleChildScrollView(
            child: Form(
              key: _logRegKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: SvgPicture.asset(AppIcons.logo, height: 100.h, width: 140.w)),
                  SizedBox(
                    height: 30.h,
                  ),
                  Center(
                      child: CustomText(
                    text: AppLocalizations.of(context)!.forgot_password,
                    fontsize: 20.sp,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w600,
                  )),
                  SizedBox(
                    height: 16.h,
                  ),
                  Center(
                      child: CustomText(
                    text: AppLocalizations.of(context)!.don_t_worry_it_happens_please_enter_the_address_associate_with_your_account,
                    maxline: 2,
                    fontsize: 14.sp,
                    textAlign: TextAlign.center,
                  )),

                  ///=============Mobile====================

                  CustomText(
                    text: AppLocalizations.of(context)!.mobile,
                    color: AppColors.hitTextColor000000,
                  ),

                  CustomTextField(
                    controller: mobileController,
                    hintText: AppLocalizations.of(context)!.mobile,
                    borderColor: AppColors.secondaryPrimaryColor,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.please_enter_your_mobile_number;
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 16.h,
                  ),

                  ///=============Email====================

                  CustomText(
                    text: AppLocalizations.of(context)!.email,
                    color: AppColors.hitTextColor000000,
                  ),

                  CustomTextField(
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
                  SizedBox(
                    height: 16.h,
                  ),

                  ///==========================Date of birth*==========================
                  CustomText(
                    text: AppLocalizations.of(context)!.date_of_birth,
                    color: AppColors.hitTextColor000000,
                    textAlign: TextAlign.left,
                  ),

                  CustomTextField(
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
                        dateOfBirthController.text = DateFormat('yyyy-MM-dd', Get.locale!.languageCode).format(birthDate!);
                      }
                      print(dateOfBirthController.text);
                    },
                    suffixIcon: Icon(
                      Icons.calendar_month,
                      color: AppColors.primaryColor,
                    ),
                    validator: (value) {
                      // if(value == null || value.isEmpty){
                      //   return 'Please enter a title';
                      // }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  CustomText(
                    text: AppLocalizations.of(context)!.security_question,
                    color: AppColors.hitTextColor000000,
                    textAlign: TextAlign.left,
                  ),

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
                      initialValue: _selectedQuestionId,
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

                  SizedBox(
                    height: 16.h,
                  ),

                  ///=============Answer====================

                  CustomText(
                    text: AppLocalizations.of(context)!.answer,
                    color: AppColors.hitTextColor000000,
                  ),

                  CustomTextField(
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
                  SizedBox(
                    height: 16.h,
                  ),

                  ///=============Submit button====================
                  Obx(
                    () => Align(
                      alignment: Alignment.bottomCenter,
                      child: CustomButton(
                        loading: authController.forgotLoading.value == true,
                        title: AppLocalizations.of(context)!.submit,
                        onpress: () {
                          if (_logRegKey.currentState!.validate()) {
                            authController.sendOtp(
                                mobile: mobileController.text, email: emailController.text, dob: dateOfBirthController.text, securityAnswer: securityController.text, securityCode: _selectedQuestionId.toString());
                          }
                        },
                      ),
                    ),
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
