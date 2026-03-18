import 'package:al_wasyeah/utils/app_colors.dart';
import 'package:al_wasyeah/utils/app_image.dart';
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

import 'package:al_wasyeah/l10n/app_localizations.dart';

class AddNomineeScreen extends StatelessWidget {
  AddNomineeScreen({super.key});
  final List<bool> isSelected = [true, false];

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NomineeController());
    controller.searchNominee();

    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: AppLocalizations.of(context)!.add_nominee,
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
                          onPressed: controller.searchNominee,
                          icon: Icon(
                            Icons.search_rounded,
                            color: AppColors.primaryColor,
                          )),
                    ),
                  ),
                  Obx(() {
                    if (controller.isLoading.value) {
                      return CustomLoader();
                    } else if (controller.nominessData.value == null) {
                      return Center(child: Text(AppLocalizations.of(context)!.no_nominee_added));
                    } else {
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        elevation: 3.0,
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage(AppImages.profileIcon),
                            radius: 30,
                          ),
                          title: Text(
                            controller.nominessData.value?.name ?? AppLocalizations.of(context)!.n_a,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Row(
                            children: [
                              Icon(Icons.visibility, size: 16.0, color: Colors.grey),
                              SizedBox(width: 4.0),
                              Text(
                                AppLocalizations.of(context)!.view_details,
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          onTap: () {
                            Get.toNamed(AppRoutes.asignNomineeDetails, arguments: controller.nominessData.value, preventDuplicates: false);
                            // Get.toNamed('/witnessDetailsScreen', preventDuplicates: false);
                            // print("dfkjld");
                          },
                        ),
                      );
                    }
                  }),
                  SizedBox(
                    height: 400.h,
                  ),
                  // SizedBox(
                  //   height: 500.0, // Adjust height as per your needs
                  //   child: ListView.builder(
                  //     padding: EdgeInsets.all(8.0),
                  //     itemCount: user.length,
                  //     itemBuilder: (context, index) {
                  //       final users = user[index];
                  //       return Card(
                  //         shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(15.0),
                  //         ),
                  //         elevation: 3.0,
                  //         margin: EdgeInsets.symmetric(vertical: 8.0),
                  //         child: ListTile(
                  //           leading: CircleAvatar(
                  //             backgroundImage: NetworkImage(users["image"]!),
                  //             radius: 30,
                  //           ),
                  //           title: Text(
                  //             users["name"]!,
                  //             style: TextStyle(fontWeight: FontWeight.bold),
                  //           ),
                  //           subtitle: Row(
                  //             children: [
                  //               Icon(Icons.visibility, size: 16.0, color: Colors.grey),
                  //               SizedBox(width: 4.0),
                  //               Text(
                  //                 AppLocalizations.of(context)!.view_details,
                  //                 style: TextStyle(color: Colors.grey),
                  //               ),
                  //             ],
                  //           ),
                  //           onTap: () {
                  //             Get.toNamed(AppRoutes.witnessDetailsScreen, preventDuplicates: false);
                  //             print("Tapped on ${users['name']}");
                  //           },
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),

                  SizedBox(height: 10.h),
                  CustomButton(
                    title: AppLocalizations.of(context)!.add_outside_nominee,
                    titlecolor: AppColors.primaryColor,
                    onpress: () {
                      Get.toNamed(AppRoutes.addOutsideNomineeScreen, preventDuplicates: false);
                    },
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
