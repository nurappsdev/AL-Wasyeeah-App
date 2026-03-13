import 'package:al_wasyeah/view/widgets/background_image_screen_widget.dart';
import 'package:al_wasyeah/view/widgets/custom_button.dart';
import 'package:al_wasyeah/view/widgets/custom_loader.dart';
import 'package:al_wasyeah/view/widgets/custom_text.dart';
import 'package:al_wasyeah/view/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controllers/controllers.dart';
import '../../../helpers/helpers.dart';
import '../../../utils/utils.dart';
import 'package:al_wasyeah/l10n/app_localizations.dart';

class AddWitnessScreen extends StatefulWidget {
  AddWitnessScreen({super.key});

  @override
  State<AddWitnessScreen> createState() => _AddWitnessScreenState();
}

class _AddWitnessScreenState extends State<AddWitnessScreen> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WitnessController());
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: AppLocalizations.of(context)!.add_witness,
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
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.h),

                      ///=============Last Name====================
                      SizedBox(
                        height: 10.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 16.h),
                        child: CustomTextField(
                          controller: controller.searchController,
                          hintText: AppLocalizations.of(context)!.search,
                          borderColor: AppColors.secondaryPrimaryColor,
                          suffixIcon: IconButton(
                              onPressed: controller.searchWitness,
                              icon: Icon(
                                Icons.search_rounded,
                                color: AppColors.primaryColor,
                              )),
                        ),
                      ),
                      // Padding(
                      //   padding: EdgeInsets.only(bottom: 16),
                      //   child: TextField(
                      //     controller: controller.searchController,
                      //     decoration: InputDecoration(
                      //       hintText: "Search".tr,
                      //       suffixIcon: IconButton(
                      //         icon: Icon(Icons.search_rounded, color: Colors.blue),
                      //         onPressed: controller.searchWitness,
                      //       ),
                      //       border: OutlineInputBorder(
                      //         borderSide: BorderSide(color: Colors.blue),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // Card(
                      //   shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(15.0),
                      //   ),
                      //   elevation: 3.0,
                      //   margin: EdgeInsets.symmetric(vertical: 8.0),
                      //   child: ListTile(
                      //     leading: CircleAvatar(
                      //       backgroundImage: AssetImage(AppImages.profileIcon),
                      //       radius: 30,
                      //     ),
                      //     title: Text(
                      //       "name",
                      //       style: TextStyle(fontWeight: FontWeight.bold),
                      //     ),
                      //     subtitle: Row(
                      //       children: [
                      //         Icon(Icons.visibility, size: 16.0, color: Colors.grey),
                      //         SizedBox(width: 4.0),
                      //         Text(
                      //           AppLocalizations.of(context)!.view_details,
                      //           style: TextStyle(color: Colors.grey),
                      //         ),
                      //       ],
                      //     ),
                      //     onTap: () {
                      //       Get.toNamed(AppRoutes.witnessDetailsScreen, preventDuplicates: false);
                      //       print("Tapped on ame");
                      //     },
                      //   ),
                      // ),
                      //Spacer(),
                      Obx(() {
                        if (controller.isLoading.value) {
                          return CustomLoader();
                        } else if (controller.witnesssData.value == null) {
                          return Center(
                              child: Text(AppLocalizations.of(context)!
                                  .no_witness_added));
                        } else {
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            elevation: 3.0,
                            margin: EdgeInsets.symmetric(vertical: 8.0),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    AssetImage(AppImages.profileIcon),
                                radius: 30,
                              ),
                              title: Text(
                                controller.witnesssData.value?.name ??
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
                                Get.toNamed(AppRoutes.asignNomineeDetails,
                                    parameters: {
                                      "type": "WITNESS",
                                    },
                                    arguments: controller.witnesssData.value,
                                    preventDuplicates: false);
                              },
                            ),
                          );
                        }
                      }),
                      SizedBox(height: 400.h),
                      CustomButton(
                        title:
                            AppLocalizations.of(context)!.add_outside_witness,
                        titlecolor: AppColors.primaryColor,
                        onpress: () {
                          Get.toNamed(AppRoutes.addOutsideWitnessScreen,
                              preventDuplicates: false);
                        },
                      ),
                      SizedBox(height: 10.h),
                    ],
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
