import 'package:al_wasyeah/view/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// class PropertyDistributionScreen2 extends StatefulWidget {
//   @override
//   _PropertyDistributionScreen2State createState() => _PropertyDistributionScreen2State();
// }
//
// class _PropertyDistributionScreen2State extends State<PropertyDistributionScreen2> {
//   // Checkbox এর স্টেট ম্যানেজমেন্টের জন্য ভ্যারিয়েবল
//   bool isCheckbox1Checked = false;
//   bool isCheckbox2Checked = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Checkbox এবং TextField'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Row(
//                   children: [
//                     Checkbox(
//                       value: isCheckbox1Checked,
//                       onChanged: (value) {
//                         setState(() {
//                           isCheckbox1Checked = value ?? false;
//                         });
//                       },
//                     ),
//                     const Text("পুত্র"),
//                   ],
//                 ),
//                 SizedBox(width: 10.w,),
//                 // যদি Checkbox checked থাকে, তাহলে TextField দেখাবে
//                 isCheckbox1Checked
//                     ? Expanded(
//                   child: CustomTextField(
//                     controller: TextEditingController(),
//                     hintText: "পুত্র এর জন্য ইনপুট দিন",
//                   ),
//                 )
//                     : const SizedBox.shrink(),
//               ],
//             ),
//
//
//              SizedBox(height: 4.h),
//           ],
//         ),
//       ),
//     );
//   }
// }


// Controller Class for State Management


// class PropertyController extends GetxController {
//   var isCheckbox1Checked = false.obs;
// }
//
// class PropertyDistributionScreen2 extends StatelessWidget {
//   final PropertyController controller = Get.put(PropertyController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Checkbox এবং TextField'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Obx(() => Row(
//                   children: [
//                     Checkbox(
//                       value: controller.isCheckbox1Checked.value,
//                       onChanged: (value) {
//                         controller.isCheckbox1Checked.value = value ?? false;
//                       },
//                     ),
//                      Text("Husband".tr),
//                   ],
//                 )),
//                 const SizedBox(width: 10),
//                 Obx(() => controller.isCheckbox1Checked.value
//                     ? Expanded(
//                   child: CustomTextField(
//                     controller: TextEditingController(),
//                     hintText: "Husband".tr,
//                   ),
//                 )
//                     : const SizedBox.shrink()),
//               ],
//             ),
//             SizedBox(height: 10.h,),
//             // Row(
//             //   crossAxisAlignment: CrossAxisAlignment.center,
//             //   children: [
//             //     Obx(() => Row(
//             //       children: [
//             //         Checkbox(
//             //           value: controller.isCheckbox1Checked.value,
//             //           onChanged: (value) {
//             //             controller.isCheckbox1Checked.value = value ?? false;
//             //           },
//             //         ),
//             //          Text("Wife".tr,),
//             //       ],
//             //     )),
//             //     const SizedBox(width: 10),
//             //     Obx(() => controller.isCheckbox1Checked.value
//             //         ? Expanded(
//             //       child: CustomTextField(
//             //         controller: TextEditingController(),
//             //         hintText: "Wife".tr,
//             //       ),
//             //     )
//             //         : const SizedBox.shrink()),
//             //   ],
//             // ),
//             // SizedBox(height: 10.h,),
//             // Row(
//             //   crossAxisAlignment: CrossAxisAlignment.center,
//             //   children: [
//             //     Obx(() => Row(
//             //       children: [
//             //         Checkbox(
//             //           value: controller.isCheckbox1Checked.value,
//             //           onChanged: (value) {
//             //             controller.isCheckbox1Checked.value = value ?? false;
//             //           },
//             //         ),
//             //         const Text("পুত্র"),
//             //       ],
//             //     )),
//             //     const SizedBox(width: 10),
//             //     Obx(() => controller.isCheckbox1Checked.value
//             //         ? Expanded(
//             //       child: CustomTextField(
//             //         controller: TextEditingController(),
//             //         hintText: "পুত্র এর জন্য ইনপুট দিন",
//             //       ),
//             //     )
//             //         : const SizedBox.shrink()),
//             //   ],
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//


import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helpers/helpers.dart';
import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';

// Controller to manage dynamic checkbox and TextEditingController states
class PropertyController extends GetxController {
  // A Map to manage the state of multiple checkboxes
  var checkboxStates = <String, bool>{}.obs;

  // A Map to manage TextEditingControllers for TextFormFields
  var textControllers = <String, TextEditingController>{};

  // Initialize default states
  void initializeStates(List<String> labels) {
    for (var label in labels) {
      checkboxStates[label] = false; // Set all checkboxes to unchecked by default
      textControllers[label] = TextEditingController(); // Create a TextEditingController for each field
    }
  }

  @override
  void onClose() {
    // Dispose of all TextEditingControllers when the controller is closed
    for (var controller in textControllers.values) {
      controller.dispose();
    }
    super.onClose();
  }
}

// Main Screen
class PropertyDistributionScreen2 extends StatelessWidget {
  final PropertyController controller = Get.put(PropertyController());

  // Labels for the checkboxes
  final List<String> checkboxLabels = ['Husband'.tr, 'Wife'.tr, 'Son'.tr,'Dead son'.tr,'Daughter'.tr,
    'Dead daughter'.tr,'Father'.tr,'Mother'.tr,'Grandfather'.tr,'Grandma'.tr,'Granny'.tr,'Brother'.tr,
    'Half-brother (bipartite)'.tr, 'Half-sister (bilateral)'.tr,'Stepbrother (half-brother)'.tr,
    'Half-sister (step-sister)'.tr,"Brother's son".tr,'Son of half-brother (uncle)'.tr,"Brother's son's son".tr,
    "Son of half-brother's son".tr,"Uncle".tr,"Uncle (bilingual)".tr,"Cousin".tr,"Cousin (bipartite)".tr,"Cousin's son".tr,"Cousin's son (Baimatreya).".tr,
    "Cousin's son's son's son".tr,"Cousin's (Vaimatreya's) son's son".tr,];
  final GlobalKey<FormState> _forProKey = GlobalKey<FormState>();
  TextEditingController landCNTR = TextEditingController();



  TextEditingController samiCNTR = TextEditingController();
  TextEditingController wifeCNTR = TextEditingController();
  TextEditingController sonCNTR = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // Initialize states in the controller
    controller.initializeStates(checkboxLabels);

    return Scaffold(
      appBar: AppBar(title: CustomText(text: "Property Distribution".tr,fontsize: 18.sp,),),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: checkboxLabels.map((label) {
                  return Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Obx(() => Checkbox(
                            value: controller.checkboxStates[label],
                            onChanged: (value) {
                              controller.checkboxStates[label] = value ?? false;
                            },
                          )),
                          Text(label.tr),
                          const SizedBox(width: 10),
                          Obx(() => controller.checkboxStates[label] == true
                              ? Expanded(
                            child: TextFormField(
                              controller: controller.textControllers[label],
                              decoration: InputDecoration(

                                hintText: '$label'.tr,
                                hintStyle: TextStyle(color: Colors.grey),
                                border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                              ),
                            ),
                          )
                              : const SizedBox.shrink()),
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  );
                }).toList(),
              ),
              SizedBox(height: 20.h,),
              CustomText(text: "Asset Description".tr,color: AppColors.hitTextColor000000,fontsize: 20.sp,),
              SizedBox(height: 10.h,),
              Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: CustomTextField(
                  controller:  landCNTR,
                  hintText: "'Land' Measurement Unit Percentage".tr,
                  borderColor: AppColors.secondaryPrimaryColor,
                  keyboardType: TextInputType.number,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "'Land' Measurement Unit Percentage".tr;
                    }
                    return null;

                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: CustomTextField(
                  controller:  landCNTR,
                  hintText: "'Gold' Measurement Unit Bhari".tr,
                  borderColor: AppColors.secondaryPrimaryColor,
                  keyboardType: TextInputType.number,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "'Gold' Measurement Unit Bhari".tr;
                    }
                    return null;

                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: CustomTextField(
                  controller:  landCNTR,
                  hintText: "'Silver' Measurement Unit Bhari".tr,
                  borderColor: AppColors.secondaryPrimaryColor,
                  keyboardType: TextInputType.number,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "'Silver' Measurement Unit Bhari".tr;
                    }
                    return null;

                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: CustomTextField(
                  controller:  landCNTR,
                  hintText: "'Money' Measurement Unit Taka".tr,
                  borderColor: AppColors.secondaryPrimaryColor,
                  keyboardType: TextInputType.number,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "'Money' Measurement Unit Taka".tr;
                    }
                    return null;

                  },
                ),
              ),
              SizedBox(height: 12.h,),
              ///=============Sign In Button====================
              CustomButtonCommon(
                // loading: authController.loadingLoading.value == true,
                title: "Result".tr,
                onpress: () {
                  Get.toNamed(AppRoutes.propertyDistributionResultScreen,preventDuplicates: false);
                  // if (_forRegKey.currentState!.validate()) {
                  //   // authController.loginHandle(
                  //   //     emailController.text, passController.text);
                  // }
                },),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Expanded(
              //       child: CustomButtonCommon(
              //         // loading: authController.loadingLoading.value == true,
              //         title: "Reset".tr,
              //         color: Colors.grey,
              //         onpress: () {
              //         //  Get.toNamed(AppRoutes.otpScreen,preventDuplicates: false);
              //           // if (_forRegKey.currentState!.validate()) {
              //           //   // authController.loginHandle(
              //           //   //     emailController.text, passController.text);
              //           // }
              //         },),
              //     ),
              //     SizedBox(width: 8.w,),
              //     Expanded(
              //       child: CustomButtonCommon(
              //         // loading: authController.loadingLoading.value == true,
              //         title: "Result".tr,
              //         onpress: () {
              //           Get.toNamed(AppRoutes.propertyDistributionResultScreen,preventDuplicates: false);
              //           // if (_forRegKey.currentState!.validate()) {
              //           //   // authController.loginHandle(
              //           //   //     emailController.text, passController.text);
              //           // }
              //         },),
              //     ),
              //   ],
              // ),
              SizedBox(height: 12.h,),
            ],
          ),
        ),
      ),
    );
  }
}
