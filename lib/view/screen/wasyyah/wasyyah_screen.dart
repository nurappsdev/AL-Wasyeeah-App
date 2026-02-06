import 'package:al_wasyeah/helpers/app_routes.dart';
import 'package:al_wasyeah/utils/app_colors.dart';
import 'package:al_wasyeah/view/widgets/custom_button.dart';
import 'package:al_wasyeah/view/widgets/custom_loader.dart';
import 'package:al_wasyeah/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../controllers/controllers.dart';
import '../no_internet_screen.dart';

import 'wasiyah_preview_screen.dart';

class WasyyahScreen extends StatelessWidget {
  WasyyahScreen({super.key});

  WasyyahController wasyyahController = Get.find<WasyyahController>();

  @override
  Widget build(BuildContext context) {
    wasyyahController.getWasyyahData();
    print("wasyyah data${wasyyahController.wasyyahYouData.length}");
    return ConnectivityWrapper(
      child: Scaffold(
        appBar: AppBar(
          title: CustomText(
            text: 'wasyyah'.tr,
            fontsize: 18,
            fontWeight: FontWeight.w600,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton(
                title: 'preview'.tr,
                onpress: () {
                  Get.toNamed(
                    AppRoutes.wasyyahPriviewScreen,
                    preventDuplicates: false,
                    arguments: wasyyahController.wasyyahYouData,
                  );
                  // Get.off(()=>WasyyahPreviewScreen(),preventDuplicates: false);
                },
                width: 100,
                height: 40,
                color: AppColors.primaryColor,
              ),
            )
          ],
        ),
        body: Container(
          height: Get.height,
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  CustomText(
                    text: 'bismillah'.tr,
                    fontsize: 14,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: AppColors.primaryColor,
                    height: 14,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomText(
                    text: 'wasyyahTitleInBangla'.tr,
                    fontsize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: AppColors.primaryColor,
                    height: 14,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomText(
                      text:
                          "???????? ??????? ???? ??????????? ??????????????????? ??????? ?'????? \n ??????????? ??????????? ??? ??????????? \n (???????????? ????????????)?",
                      maxline: 4),
                  SizedBox(
                    height: 20,
                  ),

                  ///====================================????? ???????================================
                  SizedBox(
                    height: 20,
                  ),
                  // SizedBox(
                  //   height: 440,
                  //   width: double.infinity,
                  //   child: Obx(() => wasyyahController.isWasyyah.value
                  //       ? Center(child: CustomLoader())
                  //       : ListView.builder(
                  //     padding: EdgeInsets.all(8.0),
                  //     itemCount: wasyyahController.wasyyahYouData.length,
                  //     itemBuilder: (context, index) {
                  //       final data = wasyyahController.wasyyahYouData[index];
                  //       return  Padding(
                  //         padding: const EdgeInsets.symmetric(vertical: 8.0),
                  //         child:  Opacity(
                  //       opacity: data.visible == "N" ? 0.3 : 1.0, // ?? Faded if not visible
                  //         child: Container(
                  //           decoration: BoxDecoration(
                  //             borderRadius: BorderRadius.circular(10),
                  //             color: Colors.white,
                  //             boxShadow: [
                  //               BoxShadow(
                  //                 color: Colors.grey.withOpacity(0.5),
                  //                 spreadRadius: 2,
                  //                 blurRadius: 5,
                  //                 offset: Offset(0, 3),
                  //               ),
                  //             ],
                  //           ),
                  //           child: Padding(
                  //             padding: const EdgeInsets.all(8.0),
                  //             child: Column(
                  //               children: [
                  //                 SizedBox(height: 5),
                  //                 CustomText(
                  //                   text: "${data.title ?? "N/A"}".tr,
                  //                   fontsize: 16,
                  //                 ),
                  //                 Padding(
                  //                   padding: EdgeInsets.symmetric(horizontal: 20),
                  //                   child: Divider(
                  //                     color: AppColors.primaryColor,
                  //                     endIndent: 2.2,
                  //                     thickness: 1.2,
                  //                   ),
                  //                 ),
                  //                 SizedBox(height: 6),
                  //                 CustomText(
                  //                   textAlign: TextAlign.start,
                  //                   fontWeight: FontWeight.w500,
                  //                   maxline: 100,
                  //                   text: data.content ?? "",
                  //                 ),
                  //                 SizedBox(height: 10),
                  //                 Row(
                  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //                   children: [
                  //                     data.visible == "N" ? SizedBox.shrink(): GestureDetector(
                  //                       onTap: () {
                  //                         Get.toNamed(
                  //                           AppRoutes.wasyyahEditScreen,
                  //                           preventDuplicates: false,
                  //                           arguments: data,
                  //                         );
                  //                       },
                  //                       child: _iconTextCon(Icons.edit_calendar_outlined, "Edit"),
                  //                     ),
                  //                     _iconTextCon(Icons.remove_red_eye_outlined, "View"),
                  //                   ],
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //
                  //         // child: Container(
                  //         //   decoration: BoxDecoration(
                  //         //     borderRadius: BorderRadius.circular(10),
                  //         //     color: Colors.white,
                  //         //     boxShadow: [
                  //         //       BoxShadow(
                  //         //         color: Colors.grey.withOpacity(0.5),
                  //         //         spreadRadius: 2,
                  //         //         blurRadius: 5,
                  //         //         offset: Offset(0, 3),
                  //         //       ),
                  //         //     ],
                  //         //   ),
                  //         //   child: data.visible == "N"? Padding(
                  //         //     padding: const EdgeInsets.all(8.0),
                  //         //     child: Column(
                  //         //       children: [
                  //         //         SizedBox(height: 5),
                  //         //         CustomText(
                  //         //           text: "${data.title ?? "N/A"}".tr,
                  //         //           fontsize: 16,
                  //         //         ),
                  //         //         Padding(
                  //         //           padding: EdgeInsets.symmetric(horizontal: 20),
                  //         //           child: Divider(
                  //         //             color: AppColors.primaryColor,
                  //         //             endIndent: 2.2,
                  //         //             thickness: 1.2,
                  //         //           ),
                  //         //         ),
                  //         //         SizedBox(height: 6),
                  //         //         CustomText(
                  //         //           textAlign: TextAlign.start,
                  //         //           fontWeight: FontWeight.w500,
                  //         //           maxline: 100,
                  //         //           text: data.content ?? "",
                  //         //         ),
                  //         //         SizedBox(height: 10),
                  //         //         Row(
                  //         //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         //           children: [
                  //         //             GestureDetector(
                  //         //               onTap: () {
                  //         //                 //  Get.toNamed(AppRoutes.wasyyahEditScreen,preventDuplicates: false);
                  //         //                 Get.toNamed(
                  //         //                     AppRoutes.wasyyahEditScreen,
                  //         //                     preventDuplicates: false,
                  //         //                     arguments: data
                  //         //                 );
                  //         //                 // implement your logic here
                  //         //               },
                  //         //               child: _iconTextCon(Icons.edit_calendar_outlined, "Edit"),
                  //         //             ),
                  //         //             _iconTextCon(Icons.remove_red_eye_outlined, "View"),
                  //         //           ],
                  //         //         ),
                  //         //       ],
                  //         //     ),
                  //         //   ):Padding(
                  //         //     padding: const EdgeInsets.all(8.0),
                  //         //     child: Column(
                  //         //       children: [
                  //         //         SizedBox(height: 5),
                  //         //         CustomText(
                  //         //           text: "${data.title ?? "N/A"}".tr,
                  //         //           fontsize: 16,
                  //         //         ),
                  //         //         Padding(
                  //         //           padding: EdgeInsets.symmetric(horizontal: 20),
                  //         //           child: Divider(
                  //         //             color: AppColors.primaryColor,
                  //         //             endIndent: 2.2,
                  //         //             thickness: 1.2,
                  //         //           ),
                  //         //         ),
                  //         //         SizedBox(height: 6),
                  //         //         CustomText(
                  //         //           textAlign: TextAlign.start,
                  //         //           fontWeight: FontWeight.w500,
                  //         //           maxline: 100,
                  //         //           text: data.content ?? "",
                  //         //         ),
                  //         //         SizedBox(height: 10),
                  //         //         Row(
                  //         //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         //           children: [
                  //         //             GestureDetector(
                  //         //               onTap: () {
                  //         //               //  Get.toNamed(AppRoutes.wasyyahEditScreen,preventDuplicates: false);
                  //         //                 Get.toNamed(
                  //         //                   AppRoutes.wasyyahEditScreen,
                  //         //                   preventDuplicates: false,
                  //         //                   arguments: data
                  //         //                 );
                  //         //                 // implement your logic here
                  //         //               },
                  //         //               child: _iconTextCon(Icons.edit_calendar_outlined, "Edit"),
                  //         //             ),
                  //         //             _iconTextCon(Icons.remove_red_eye_outlined, "View"),
                  //         //           ],
                  //         //         ),
                  //         //       ],
                  //         //     ),
                  //         //   ),
                  //         // ),
                  //       );
                  //     },
                  //   )),
                  // ),
                  SizedBox(
                    height: 440,
                    width: double.infinity,
                    child: Obx(() => wasyyahController.isWasyyah.value
                        ? Center(child: CustomLoader())
                        : ScrollConfiguration(
                            behavior:
                                ScrollBehavior().copyWith(overscroll: false),
                            child: ReorderableListView.builder(
                              itemCount:
                                  wasyyahController.wasyyahYouData.length,
                              padding: EdgeInsets.all(8.0),

                              // onReorder: (int oldIndex, int newIndex) {
                              //   wasyyahController.changeOrderApi(requestKey: oldIndex.toString(), order: newIndex); // ?? method call ????
                              //
                              //  // wasyyahController.onReorderItems(oldIndex, newIndex); // ?? method call ????
                              // },
                              onReorder: (int oldIndex, int newIndex) {
                                /// Update local list visually
                                wasyyahController.onReorderItems(
                                    oldIndex, newIndex);
                              },

                              buildDefaultDragHandles: true,

                              itemBuilder: (context, index) {
                                final data =
                                    wasyyahController.wasyyahYouData[index];
                                return Container(
                                  key: ValueKey(data.requestKey ??
                                      index), // MUST be on direct child
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Opacity(
                                    opacity: data.visible == "N" ? 0.3 : 1.0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            SizedBox(height: 5),
                                            CustomText(
                                              text: "${data.title ?? "N/A"}".tr,
                                              fontsize: 16,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20),
                                              child: Divider(
                                                color: AppColors.primaryColor,
                                                endIndent: 2.2,
                                                thickness: 1.2,
                                              ),
                                            ),
                                            SizedBox(height: 6),
                                            CustomText(
                                              textAlign: TextAlign.start,
                                              fontWeight: FontWeight.w500,
                                              maxline: 100,
                                              text: data.content ?? "",
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                data.visible == "N"
                                                    ? SizedBox.shrink()
                                                    : GestureDetector(
                                                        onTap: () {
                                                          Get.toNamed(
                                                            AppRoutes
                                                                .wasyyahEditScreen,
                                                            preventDuplicates:
                                                                false,
                                                            arguments: data,
                                                          );
                                                        },
                                                        child: _iconTextCon(
                                                            Icons
                                                                .edit_calendar_outlined,
                                                            'edit'.tr),
                                                      ),
                                                GestureDetector(
                                                  onTap: () {
                                                    wasyyahController
                                                        .contentVisible(data);
                                                  },
                                                  child: _iconTextCon(
                                                      Icons
                                                          .remove_red_eye_outlined,
                                                      'view'.tr),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )),
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    title: 'addMoreContent'.tr,
                    titlecolor: AppColors.primaryColor,
                    onpress: () {
                      Get.toNamed(AppRoutes.addNewWashyiaScreen,
                          preventDuplicates: false);
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _iconTextCon(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 35,
        width: 80,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xff757575)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            CustomText(
              text: text,
              color: Colors.white,
              fontsize: 16,
            )
          ],
        ),
      ),
    );
  }
}
