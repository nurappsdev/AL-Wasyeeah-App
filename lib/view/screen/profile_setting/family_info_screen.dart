import 'dart:io';

import 'package:al_wasyeah/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/models.dart';
import '../../../utils/utils.dart';
import '../../widgets/custom_text_field_without_border.dart';
import '../../widgets/widgets.dart';

class FamilyInfoScreen extends StatefulWidget {
  const FamilyInfoScreen({super.key});

  @override
  State<FamilyInfoScreen> createState() => _FamilyInfoScreenState();
}

class _FamilyInfoScreenState extends State<FamilyInfoScreen> {
  TextEditingController spouseNameCNTRL = TextEditingController();
  TextEditingController PassOrNIDController = TextEditingController();
  TextEditingController passOrNIDController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nidController = TextEditingController();
  List<bool> isSelected = [true, false];
  bool _isContainerVisible = false;

  void _toggleContainer() {
    setState(() {
      _isContainerVisible = !_isContainerVisible;
    });
  }

  ///----------------NID image=============================
  File? nIDImages;
  String? nidImagePath; // Variable to store the image path
  String get displayImageNIDPath {
    if (nidImagePath == null || nidImagePath!.length <= 30) {
      return nidImagePath ?? 'No image selected';
    }
    return nidImagePath!.substring(nidImagePath!.length - 30); // Get the last 18 characters
  }
  Future<void> _NIDImageFromGallery() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage == null) return;

    setState(() {
      nIDImages = File(pickedImage.path);
      nidImagePath = pickedImage.path; // Save the image path
    });

  }


  TextEditingController medicineNameCtrl = TextEditingController();
  TextEditingController dosageCtrl = TextEditingController();
  TextEditingController frequencyCtrl = TextEditingController();
  TextEditingController durationCtrl = TextEditingController();
  final _formKeyMedicine = GlobalKey<FormState>();

  ProfileController profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Container(
            height: Get.height,
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.h),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    ///=============="Father’s Information================================
                    SizedBox(height: 20.h),
                    Center(child: CustomText(text: "Family Information".tr,fontsize: 20,)),
                    SizedBox(height: 20.h),

                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24.r),
                        color: AppColors.whiteColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10.h),
                          ...profileController.addSpouseList.asMap().entries.map((entry) {
                            int index = entry.key;
                            SpouseItemS doc = entry.value;
                            return Column(
          key: ValueKey(index),
          children: [
            CustomText(text: "Spouse Name".tr,color: AppColors.hitTextColor000000,fontsize: 16 .sp,),
            SizedBox(height: 10.h),
            CustomTextField(
              controller: doc.spouseNameController,
              hintText: "Father’s Name".tr,
              borderColor: AppColors.secondaryPrimaryColor,
              validator: (value){
                if(value == null || value.isEmpty){
                  return 'Spouse Name'.tr;
                }
                return null;

              },
            ),
            SizedBox(height: 20.h),
            CustomDropdown(label: "Profession".tr,items: profileController.profession,selectedValue: profileController.selectedProfession,),
            SizedBox(height: 20.h),
            CustomDropdown(label: "Nationality".tr,items: profileController.profession,selectedValue: profileController.selectedProfession,),
            ///============NID/PASSPORT No*====================
            SizedBox(height: 20.h),
            CustomText(text: "NID/Passport No".tr,color: AppColors.hitTextColor000000,fontsize: 16.sp,),
            SizedBox(height: 10.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomTextField(
                    controller:  passOrNIDController,
                    hintText: "NID/Passport No".tr,
                    borderColor: AppColors.secondaryPrimaryColor,
                    onChange: (value){},
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return 'NID/Passport No'.tr;
                      }
                      return null;

                    },
                  ),
                ),
                SizedBox(width: 6.w,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: IconButton(
                    icon:Icon(Icons.attach_file_outlined,color: AppColors.primaryColor,),
                    onPressed: () {
                      _NIDImageFromGallery();
                      // Add your action here
                    },
                  ),
                ),
              ],
            ),
            if (nIDImages != null)
              Text(
                'Image Path: ${displayImageNIDPath.toString()}',
                style: TextStyle(color: Colors.grey),
              ),
            SizedBox(height: 20.h),
            CustomText(text: "Mobile".tr,color: AppColors.hitTextColor000000,fontsize: 16 .sp,),
            SizedBox(height: 10.h),
            CustomTextField(
              controller: mobileController,
              hintText: "Mobile".tr,
              borderColor: AppColors.secondaryPrimaryColor,
              validator: (value){
                if(value == null || value.isEmpty){
                  return 'Mobile'.tr;
                }
                return null;

              },
            ),
            SizedBox(height: 16.h),
            ///=============Email====================
            CustomText(text: "email".tr,color: AppColors.hitTextColor000000,fontsize: 20.sp,),
            SizedBox(height: 10.h,),
            Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: CustomTextField(
                controller: emailController,
                hintText: "email".tr,
                borderColor: AppColors.secondaryPrimaryColor,
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'Please enter your Email'.tr;
                  }else if(!AppConstants.emailValidate.hasMatch(value)){
                    return "Invalid Email".tr;
                  }
                  return null;

                },
              ),
            ),

            Center(
              child: ToggleButtons(
                isSelected: isSelected,
                onPressed: (index) {
                  setState(() {
                    // Allow only one button to be selected at a time
                    for (int i = 0; i < isSelected.length; i++) {
                      isSelected[i] = i == index;
                    }
                  });
                },
                borderRadius: BorderRadius.circular(8),
                selectedColor: Colors.white,
                fillColor: isSelected[1] ? Colors.red : Colors.green,
                color: Colors.black,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Text('Alive'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Text('Death'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h,),
            SizedBox(width: 10.w),
            if (index != 0) // First item fixed, no delete button
              IconButton(
                color:Colors.grey,
                icon: Icon(Icons.delete_forever, color: Colors.red),
                onPressed: () {
                  setState(() {
                    profileController.addSpouseList.removeAt(index);
                  });
                },
              ),
          ],
        );
                          }).toList(),

                          ///================================= + Add more spouse  =======================================

                          Padding(
                            padding: EdgeInsets.only(left: 50.w, right: 10),
                            child: CustomButton(
                              title: "+ Add More spouse",
                              titlecolor: AppColors.primaryColor,
                              onpress: () {
                                setState(() {
                                  profileController.addSpouseList.add(SpouseItemS());
                                });
                              },
                            ),
                          ),

                        ],
    ),),

                    SizedBox(height: 20.h),
                    Center(child: CustomText(text: "Children's Information".tr,fontsize: 20,)),
                    SizedBox(height: 20.h),

                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24.r),
                        color: AppColors.whiteColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10.h),
                          ...profileController.addChildrenInfoList.asMap().entries.map((entry) {
                            int index = entry.key;
                            ChildrenInfo doc = entry.value;
                            return Column(
                              key: ValueKey(index),
                              children: [
                                CustomText(text: "Spouse Name".tr,color: AppColors.hitTextColor000000,fontsize: 16 .sp,),
                                SizedBox(height: 10.h),
                                CustomTextField(
                                  controller: doc.childNameController,
                                  hintText: "Father’s Name".tr,
                                  borderColor: AppColors.secondaryPrimaryColor,
                                  validator: (value){
                                    if(value == null || value.isEmpty){
                                      return 'Spouse Name'.tr;
                                    }
                                    return null;

                                  },
                                ),
                                SizedBox(height: 20.h),
                                CustomDropdown(label: "Profession".tr,items: profileController.profession,selectedValue: profileController.selectedProfession,),
                                SizedBox(height: 20.h),
                                CustomDropdown(label: "Nationality".tr,items: profileController.profession,selectedValue: profileController.selectedProfession,),
                                ///============NID/PASSPORT No*====================
                                SizedBox(height: 20.h),
                                CustomText(text: "NID/Passport No".tr,color: AppColors.hitTextColor000000,fontsize: 16.sp,),
                                SizedBox(height: 10.h,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: CustomTextField(
                                        controller:  passOrNIDController,
                                        hintText: "NID/Passport No".tr,
                                        borderColor: AppColors.secondaryPrimaryColor,
                                        onChange: (value){},
                                        validator: (value){
                                          if(value == null || value.isEmpty){
                                            return 'NID/Passport No'.tr;
                                          }
                                          return null;

                                        },
                                      ),
                                    ),
                                    SizedBox(width: 6.w,),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 6.w),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(16.r),
                                      ),
                                      child: IconButton(
                                        icon:Icon(Icons.attach_file_outlined,color: AppColors.primaryColor,),
                                        onPressed: () {
                                          _NIDImageFromGallery();
                                          // Add your action here
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                if (nIDImages != null)
                                  Text(
                                    'Image Path: ${displayImageNIDPath.toString()}',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                SizedBox(height: 20.h),
                                CustomText(text: "Mobile".tr,color: AppColors.hitTextColor000000,fontsize: 16 .sp,),
                                SizedBox(height: 10.h),
                                CustomTextField(
                                  controller: mobileController,
                                  hintText: "Mobile".tr,
                                  borderColor: AppColors.secondaryPrimaryColor,
                                  validator: (value){
                                    if(value == null || value.isEmpty){
                                      return 'Mobile'.tr;
                                    }
                                    return null;

                                  },
                                ),
                                SizedBox(height: 16.h),
                                ///=============Email====================
                                CustomText(text: "email".tr,color: AppColors.hitTextColor000000,fontsize: 20.sp,),
                                SizedBox(height: 10.h,),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 16.h),
                                  child: CustomTextField(
                                    controller: emailController,
                                    hintText: "email".tr,
                                    borderColor: AppColors.secondaryPrimaryColor,
                                    validator: (value){
                                      if(value == null || value.isEmpty){
                                        return 'Please enter your Email'.tr;
                                      }else if(!AppConstants.emailValidate.hasMatch(value)){
                                        return "Invalid Email".tr;
                                      }
                                      return null;

                                    },
                                  ),
                                ),

                                Center(
                                  child: ToggleButtons(
                                    isSelected: isSelected,
                                    onPressed: (index) {
                                      setState(() {
                                        // Allow only one button to be selected at a time
                                        for (int i = 0; i < isSelected.length; i++) {
                                          isSelected[i] = i == index;
                                        }
                                      });
                                    },
                                    borderRadius: BorderRadius.circular(8),
                                    selectedColor: Colors.white,
                                    fillColor: isSelected[1] ? Colors.red : Colors.green,
                                    color: Colors.black,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 50),
                                        child: Text('Alive'),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 50),
                                        child: Text('Death'),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 24.h,),
                                SizedBox(width: 10.w),
                                if (index != 0) // First item fixed, no delete button
                                  IconButton(
                                    color:Colors.grey,
                                    icon: Icon(Icons.delete_forever, color: Colors.red),
                                    onPressed: () {
                                      setState(() {
                                        profileController.addChildrenInfoList.removeAt(index);
                                      });
                                    },
                                  ),
                              ],
                            );
                          }).toList(),

                          ///================================= + Add more spouse  =======================================

                          Padding(
                            padding: EdgeInsets.only(left: 50.w, right: 10),
                            child: CustomButton(
                              title: "+ Add More spouse",
                              titlecolor: AppColors.primaryColor,
                              onpress: () {
                                setState(() {
                                  profileController.addChildrenInfoList.add(ChildrenInfo());
                                });
                              },
                            ),
                          ),

                        ],
                      ),),

                    ///================================= + Add more spouse  =======================================
                    // Column(
                    //   children: [
                    //     ElevatedButton(
                    //       onPressed: _toggleContainer,
                    //       child: Text('+ Add more spouse'.tr),
                    //     ),
                    //     if (_isContainerVisible)
                    //
                    //       _buildBodySection(),
                    //     // Container(
                    //     //   padding: EdgeInsets.all(16.0),
                    //     //   margin: EdgeInsets.all(16.0),
                    //     //   decoration: BoxDecoration(
                    //     //     color: Colors.grey[200],
                    //     //     borderRadius: BorderRadius.circular(10.0),
                    //     //     boxShadow: [
                    //     //       BoxShadow(
                    //     //         color: Colors.black26,
                    //     //         blurRadius: 5.0,
                    //     //       ),
                    //     //     ],
                    //     //   ),
                    //     //   child: Column(
                    //     //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     //     children: [
                    //     //       Row(
                    //     //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     //         children: [
                    //     //           Text(
                    //     //             "Children's Information".tr,
                    //     //             style: TextStyle(fontSize: 16),
                    //     //           ),
                    //     //           IconButton(
                    //     //             icon: Icon(Icons.close),
                    //     //             onPressed: _toggleContainer,
                    //     //           ),
                    //     //         ],
                    //     //       ),
                    //     //       SizedBox(height: 10.h),
                    //     //       CustomText(text: "Child  Name".tr,color: AppColors.hitTextColor000000,fontsize: 16 .sp,),
                    //     //       SizedBox(height: 10.h),
                    //     //       CustomTextField(
                    //     //         controller: spouseNameCNTRL,
                    //     //         hintText: "Name".tr,
                    //     //         borderColor: AppColors.secondaryPrimaryColor,
                    //     //         validator: (value){
                    //     //           if(value == null || value.isEmpty){
                    //     //             return 'Name'.tr;
                    //     //           }
                    //     //           return null;
                    //     //
                    //     //         },
                    //     //       ),
                    //     //       SizedBox(height: 10.h,),
                    //     //       ///=============Gender====================
                    //     //       CustomDropdown(label: "Gender".tr,items: profileController.gender,selectedValue: profileController.selectedGender,),
                    //     //
                    //     //       SizedBox(height: 20.h),
                    //     //       CustomDropdown(label: "Profession".tr,items: profileController.profession,selectedValue: profileController.selectedProfession,),
                    //     //       SizedBox(height: 20.h),
                    //     //       CustomDropdown(label: "Nationality".tr,items: profileController.profession,selectedValue: profileController.selectedProfession,),
                    //     //       ///=============Mobile====================
                    //     //       SizedBox(height: 16.h,),
                    //     //       CustomText(text: "Mobile".tr,color: AppColors.hitTextColor000000,fontsize: 16 .sp,),
                    //     //       SizedBox(height: 10.h,),
                    //     //       Padding(
                    //     //         padding: EdgeInsets.only(bottom: 16.h),
                    //     //         child: CustomTextField(
                    //     //           controller:  mobileController,
                    //     //           hintText: "Mobile".tr,
                    //     //           borderColor: AppColors.secondaryPrimaryColor,
                    //     //           validator: (value){
                    //     //             if(value == null || value.isEmpty){
                    //     //               return 'Please enter your Mobile Number'.tr;
                    //     //             }
                    //     //             return null;
                    //     //
                    //     //           },
                    //     //         ),
                    //     //       ),
                    //     //
                    //     //
                    //     //
                    //     //       ///=============Email====================
                    //     //       SizedBox(height: 16.h,),
                    //     //       CustomText(text: "email".tr,color: AppColors.hitTextColor000000,fontsize: 16.sp,),
                    //     //       SizedBox(height: 10.h,),
                    //     //       Padding(
                    //     //         padding: EdgeInsets.only(bottom: 16.h),
                    //     //         child: CustomTextField(
                    //     //           controller:  emailController,
                    //     //           hintText: AppString.enterYourEmail.tr,
                    //     //           borderColor: AppColors.secondaryPrimaryColor,
                    //     //           // prefixIcon: Padding(
                    //     //           //   padding: EdgeInsets.only(left: 16.w, right: 12.w),
                    //     //           //   child: SvgPicture.asset(AppIcons.email, color:
                    //     //           //   AppColors.primaryColor, height: 20.h, width: 20.w),
                    //     //           // ),
                    //     //           validator: (value){
                    //     //             if(value == null || value.isEmpty){
                    //     //               return 'Please enter your Email'.tr;
                    //     //             }else if(!AppConstants.emailValidate.hasMatch(value)){
                    //     //               return "Invalid Email".tr;
                    //     //             }
                    //     //             return null;
                    //     //
                    //     //           },
                    //     //         ),
                    //     //       ),
                    //     //
                    //     //       ///============NID/PASSPORT No*====================
                    //     //       SizedBox(height: 20.h),
                    //     //       CustomText(text: "NID/Passport No".tr,color: AppColors.hitTextColor000000,fontsize: 16.sp,),
                    //     //       SizedBox(height: 10.h,),
                    //     //       Row(
                    //     //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     //         children: [
                    //     //           Expanded(
                    //     //             child: CustomTextField(
                    //     //               controller:  passOrNIDController,
                    //     //               hintText: "NID/Passport No".tr,
                    //     //               borderColor: AppColors.secondaryPrimaryColor,
                    //     //               onChange: (value){},
                    //     //               validator: (value){
                    //     //                 if(value == null || value.isEmpty){
                    //     //                   return 'NID/Passport No'.tr;
                    //     //                 }
                    //     //                 return null;
                    //     //
                    //     //               },
                    //     //             ),
                    //     //           ),
                    //     //           SizedBox(width: 6.w,),
                    //     //           Container(
                    //     //             padding: EdgeInsets.symmetric(horizontal: 6.w),
                    //     //             decoration: BoxDecoration(
                    //     //               border: Border.all(color: Colors.grey),
                    //     //               borderRadius: BorderRadius.circular(16.r),
                    //     //             ),
                    //     //             child: IconButton(
                    //     //               icon:Icon(Icons.attach_file_outlined,color: AppColors.primaryColor,),
                    //     //               onPressed: () {
                    //     //                 // Add your action here
                    //     //               },
                    //     //             ),
                    //     //           ),
                    //     //         ],
                    //     //       ),
                    //     //       SizedBox(height: 16.h),
                    //     //
                    //     //     ],
                    //     //   ),
                    //     // ),
                    //   ],
                    // ),
                    // _buildBodySection(),
                    SizedBox(height: 24.h,),
                    CustomButtonCommon(
                      // loading: authController.loadingLoading.value == true,


                      title: "Next".tr,
                      onpress: () {
                        //    Get.toNamed(AppRoutes.otpScreen,preventDuplicates: false);
                        // if (_forRegKey.currentState!.validate()) {
                        //   // authController.loginHandle(
                        //   //     emailController.text, passController.text);
                        // }
                      },),
                    SizedBox(height: 16.h),
                  ],
                ),
              ),
            )));
  }

}



class SpouseItemS {
  int? spouseId;
  String? spouseName;
  int? professionId;
  int? nationalityId;
  String? nid;
  String? nidPaperUrl;
  String? passport;
  String? passportPaperUrl;
  String? mobile;
  String? email;
  bool? existing;
  int? userId;

  TextEditingController spouseNameController;
  TextEditingController mobileController;
  TextEditingController emailController;
  TextEditingController nidController;
  TextEditingController passportController;

  String? spouseNIDFile;
  String? spousePassportFile;

  SpouseItemS({
    this.spouseId,
    this.spouseName,
    this.professionId,
    this.nationalityId,
    this.nid,
    this.nidPaperUrl,
    this.passport,
    this.passportPaperUrl,
    this.mobile,
    this.email,
    this.existing,
    this.userId,
    this.spouseNIDFile,
    this.spousePassportFile,
  })  : spouseNameController = TextEditingController(text: spouseName ?? ''),
        mobileController = TextEditingController(text: mobile ?? ''),
        emailController = TextEditingController(text: email ?? ''),
        nidController = TextEditingController(text: nid ?? ''),
        passportController = TextEditingController(text: passport ?? '');

}
