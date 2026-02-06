import 'package:al_wasyeah/utils/app_dimentions.dart';
import 'package:al_wasyeah/utils/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../controllers/controllers.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_constant.dart';
import '../widgets/widgets.dart';

class ForgotPassScreen extends StatefulWidget {
  ForgotPassScreen({super.key});

  @override
  State<ForgotPassScreen> createState() => _ForgotPassScreenState();
}

class _ForgotPassScreenState extends State<ForgotPassScreen> {
  final GlobalKey<FormState> _logRegKey = GlobalKey<FormState>();

  TextEditingController securityController = TextEditingController();

  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  DateTime? birthDate;
  AuthController authController = Get.find<AuthController>();

  String? _selectedQuestionId;

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        controller.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: 'forgotPassword'.tr,
          fontsize: 18,
        ),
      ),
      body: BackgroundImageContainer(
        child: Container(
          height: Get.height,
          width: double.infinity,
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: Dimensions.radiusExtraLarge),
            child: SingleChildScrollView(
              child: Form(
                key: _logRegKey,
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
                      text: 'forgotPassword'.tr,
                      fontsize: 20,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w600,
                    )),
                    SizedBox(
                      height: 16,
                    ),
                    Center(
                        child: CustomText(
                      text: 'forgotPassInstructions'.tr,
                      maxline: 2,
                      fontsize: 14,
                      textAlign: TextAlign.center,
                    )),

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
                      height: 20,
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
                          // if(value == null || value.isEmpty){
                          //   return 'Please enter a title';
                          // }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 10),

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
                        loading: authController.forgotLoading.value == true,
                        title: 'submit'.tr,
                        onpress: () {
                          if (_logRegKey.currentState!.validate()) {
                            authController.forgotHandle(
                                mobile: mobileController.text,
                                email: emailController.text,
                                dob: dateOfBirthController.text,
                                securityAnswer: securityController.text,
                                securityCode: _selectedQuestionId.toString());
                          }
                        },
                      ),
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
