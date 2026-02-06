import 'package:al_wasyeah/utils/app_dimentions.dart';
import 'package:al_wasyeah/utils/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../controllers/controllers.dart';
import '../../helpers/helpers.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_constant.dart';

import '../widgets/widgets.dart';

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

  AuthController authController = Get.find<AuthController>();

  String? _selectedQuestionId;

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
    authController.getSecurityQuestion();
  }

  @override
  Widget build(BuildContext context) {
    print(authController.securityQuestionResponseModel.length);
    return Scaffold(
      body: BackgroundImageContainer(
        child: Container(
          height: Get.height,
          width: double.infinity,
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: Dimensions.radiusExtraLarge),
            child: SingleChildScrollView(
              child: Form(
                key: _forRegKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Center(
                        child: SvgPicture.asset(AppIcons.logo,
                            height: 100, width: 140)),
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                        child: CustomText(
                      text: 'registration'.tr,
                      fontsize: 28,
                      textAlign: TextAlign.center,
                    )),
                    // SizedBox(height: 16,),
                    // Center(child: CustomText(text: "Enter your details to register Al Wasyyah",fontsize: 16,textAlign: TextAlign.center,)),

                    SizedBox(
                      height: 16,
                    ),
                    CustomText(
                      text: 'firstName'.tr,
                      color: AppColors.hitTextColor000000,
                      fontsize: 20,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: CustomTextField(
                        controller: firstNameController,
                        hintText: 'firstName'.tr,
                        borderColor: AppColors.secondaryPrimaryColor,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'enterFirstNameError'.tr;
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
                      text: 'lastName'.tr,
                      color: AppColors.hitTextColor000000,
                      fontsize: 20,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: CustomTextField(
                        controller: secondNameController,
                        hintText: 'lastName'.tr,
                        borderColor: AppColors.secondaryPrimaryColor,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'enterLastNameError'.tr;
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
                      text: 'mobile'.tr,
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
                        keyboardType: TextInputType.number,
                        hintText: 'mobile'.tr,
                        borderColor: AppColors.secondaryPrimaryColor,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'enterMobileError'.tr;
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
                      text: 'email'.tr,
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
                            return 'enterEmailError'.tr;
                          } else if (!AppConstants.emailValidate
                              .hasMatch(value)) {
                            return 'invalidEmail'.tr;
                          }
                          return null;
                        },
                      ),
                    ),

                    ///==========================Date of birth*==========================
                    CustomText(
                      text: 'dateOfBirth'.tr,
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
                        hintText: 'dateOfBirth'.tr,
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
                            return 'writeDateOfBirthError'.tr;
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    CustomText(
                      text: 'securityQuestion'.tr,
                      fontsize: 16,
                      color: AppColors.hitTextColor000000,
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.secondaryPrimaryColor),
                            borderRadius: BorderRadius.circular(14)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.secondaryPrimaryColor,
                            ),
                            borderRadius: BorderRadius.circular(14)),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.primaryColor),
                            borderRadius: BorderRadius.circular(16)),
                      ),
                      isExpanded: true,
                      hint: CustomText(text: 'selectYourQuestion'.tr),
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
                    SizedBox(height: 10),

                    ///=============Answer====================
                    SizedBox(
                      height: 16,
                    ),
                    CustomText(
                      text: 'answer'.tr,
                      color: AppColors.hitTextColor000000,
                      fontsize: 20,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: CustomTextField(
                        controller: securityController,
                        hintText: 'answer'.tr,
                        borderColor: AppColors.secondaryPrimaryColor,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'enterAnswerError'.tr;
                          }
                          return null;
                        },
                      ),
                    ),

                    ///=============Sign In Button====================
                    Obx(
                      () => CustomButtonCommon(
                        loading: authController.signUpLoading.value == true,
                        title: 'registerButton'.tr,
                        onpress: () {
                          // Get.toNamed(AppRoutes.otpScreen,preventDuplicates: false);
                          if (_forRegKey.currentState!.validate()) {
                            authController.signUpHandle(
                              agreeTerms: true,
                              firstName: firstNameController.text,
                              lastName: secondNameController.text,
                              email: emailController.text,
                              mobile: mobileController.text,
                              dob: dateOfBirthController.text,
                              securityAnswer: securityController.text,
                              source: "mobile",
                              securityCode: _selectedQuestionId.toString(),
                            );
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    ///=============SignUp====================
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                            onTap: () {
                              //  Get.toNamed(AppRoutes.otpVirifyScreen,preventDuplicates: false);
                            },
                            child: CustomText(
                              text: "${'allReadyAccount'.tr} ",
                              fontsize: 18,
                            )),
                        InkWell(
                            onTap: () {
                              Get.toNamed(AppRoutes.loginScreen,
                                  preventDuplicates: false);
                            },
                            child: CustomText(
                              text: 'signIn'.tr,
                              fontsize: 18,
                              color: AppColors.primaryColor,
                            )),
                      ],
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
      ),
    );
  }
}
