// import 'package:al_wasyeah/controllers/witness_controller/witness_controller.dart';
// import 'package:al_wasyeah/helpers/app_routes.dart';
// import 'package:al_wasyeah/models/witness/get_witness_response_model.dart';
// import 'package:al_wasyeah/services/api_constants.dart';
// import 'package:al_wasyeah/utils/app_colors.dart';
// import 'package:al_wasyeah/view/widgets/custom_button.dart';
// import 'package:al_wasyeah/view/widgets/custom_button_common.dart';
// import 'package:al_wasyeah/view/widgets/custom_text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:al_wasyeah/l10n/app_localizations.dart';
// import 'package:skeletonizer/skeletonizer.dart';

// class WitnessesScreen extends GetView<WitnessController> {
//   const WitnessesScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: CustomText(
//           text: AppLocalizations.of(context)!.witness,
//           fontsize: 20.sp,
//           fontWeight: FontWeight.bold,
//         ),
//         centerTitle: true,
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//       ),
//       extendBodyBehindAppBar: false,
//       body: Column(
//         children: [
//           const SizedBox(height: 16),
//           _buildCustomTabBar(),
//           Expanded(
//             child: TabBarView(
//               controller: controller.tabController,
//               children: [
//                 _buildWitnessListTab(
//                   context,
//                   status: controller.witnessStatus,
//                   data: controller.witnessData,
//                   showAddButton: true,
//                 ),
//                 _buildWitnessListTab(
//                   context,
//                   status: controller.witnessesYouStatus,
//                   data: controller.witnessesYouData,
//                   showAddButton: false,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildWitnessListTab(
//     BuildContext context, {
//     required Rx<RxStatus> status,
//     required RxList<GetWitnessResponseModel> data,
//     required bool showAddButton,
//   }) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 20.w),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           if (showAddButton) ...[
//             SizedBox(height: 20.h),
//             _buildAddButton(context),
//           ],
//           SizedBox(height: 16.h),
//           Expanded(
//             child: Obx(() {
//               final currentStatus = status.value;

//               if (currentStatus.isError) {
//                 return _buildErrorState(
//                     context, currentStatus.errorMessage ?? "");
//               }

//               if (currentStatus.isEmpty) {
//                 return _buildEmptyState(context);
//               }

//               return Skeletonizer(
//                 enabled: currentStatus.isLoading,
//                 child: ListView.builder(
//                   padding: EdgeInsets.only(bottom: 20.h),
//                   itemCount: currentStatus.isLoading ? 5 : data.length,
//                   itemBuilder: (context, index) {
//                     if (currentStatus.isLoading) {
//                       return _buildWitnessSkeleton();
//                     }
//                     final witness = data[index];
//                     return _buildWitnessCard(context, witness, showAddButton);
//                   },
//                 ),
//               );
//             }),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildAddButton(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12.r),
//         gradient: LinearGradient(
//           colors: [
//             AppColors.primaryColor,
//             AppColors.primaryColor.withOpacity(0.8)
//           ],
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: AppColors.primaryColor.withOpacity(0.3),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: CustomButton(
//         title: AppLocalizations.of(context)!.add_more_witness,
//         titlecolor: Colors.black,
//         onpress: () {
//           Get.toNamed(AppRoutes.addWitnessesScreen, preventDuplicates: false);
//         },
//       ),
//     );
//   }

//   Widget _buildWitnessCard(
//       BuildContext context, GetWitnessResponseModel witness, bool canEdit) {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 8.h),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16.r),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//         border: Border.all(color: Colors.grey.shade100),
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           borderRadius: BorderRadius.circular(16.r),
//           onTap: () {
//             if (canEdit) {
//               showWitnessDetailsDialog(context, witness, controller);
//             } else {
//               Get.toNamed(AppRoutes.witnessDetailsScreen,
//                   arguments: witness, preventDuplicates: false);
//             }
//           },
//           child: Padding(
//             padding: EdgeInsets.all(16.w),
//             child: Row(
//               children: [
//                 Container(
//                   width: 50.w,
//                   height: 50.w,
//                   decoration: BoxDecoration(
//                     color: AppColors.primaryColor.withOpacity(0.1),
//                     shape: BoxShape.circle,
//                   ),
//                   child: witness.imageUrl != null
//                       ? CircleAvatar(
//                           radius: 18,
//                           backgroundImage: NetworkImage(
//                               "${ApiConstants.imageUrl + "${witness.imageUrl}"}"),
//                           backgroundColor: Colors.grey[200],
//                         )
//                       : CircleAvatar(
//                           radius: 18,
//                           child: Icon(Icons.person),
//                           backgroundColor: Colors.grey[200],
//                         ),
//                   //  CachedNetworkImage(
//                   //   imageUrl: witness.image ?? "",
//                   //   fit: BoxFit.cover,
//                   //   placeholder: (context, url) => const Center(
//                   //     child: CircularProgressIndicator(),
//                   //   ),
//                   //   errorWidget: (context, url, error) => const Center(
//                   //     child: Icon(Icons.person, color: Colors.grey),
//                   //   ),
//                   // ),
//                 ),
//                 SizedBox(width: 16.w),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         witness.name ?? AppLocalizations.of(context)!.n_a,
//                         style: TextStyle(
//                           fontSize: 16.sp,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black87,
//                         ),
//                       ),
//                       SizedBox(height: 4.h),
//                       Text(
//                         witness.relation ?? AppLocalizations.of(context)!.n_a,
//                         style: TextStyle(
//                           fontSize: 14.sp,
//                           color: Colors.grey.shade600,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Icon(
//                   Icons.arrow_forward_ios,
//                   size: 16.sp,
//                   color: Colors.grey.shade400,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildWitnessSkeleton() {
//     return Skeletonizer(
//       enabled: true,
//       child: ListView.builder(
//         itemCount: 6,
//         itemBuilder: (_, index) {
//           return _buildWitnessCard(
//             Get.context!,
//             GetWitnessResponseModel(), // empty model
//             true,
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildEmptyState(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.people_outline, size: 80.sp, color: Colors.grey.shade300),
//           SizedBox(height: 16.h),
//           CustomText(
//             text: AppLocalizations.of(context)!.no_data,
//             fontsize: 16.sp,
//             color: Colors.grey.shade500,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildErrorState(BuildContext context, String error) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.error_outline, size: 80.sp, color: Colors.red.shade200),
//           SizedBox(height: 16.h),
//           CustomText(
//             text: error,
//             fontsize: 14.sp,
//             color: Colors.red.shade400,
//           ),
//           TextButton(
//             onPressed: () {
//               controller.getWitnessData();
//               controller.getWitnessesYouData();
//             },
//             child: Text(AppLocalizations.of(context)!.try_again),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildCustomTabBar() {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 20.w),
//       padding: EdgeInsets.all(6.w),
//       decoration: BoxDecoration(
//         color: Colors.grey.shade100,
//         borderRadius: BorderRadius.circular(16.r),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.02),
//             blurRadius: 10,
//             spreadRadius: 2,
//           ),
//         ],
//       ),
//       child: TabBar(
//         controller: controller.tabController,
//         indicator: BoxDecoration(
//           borderRadius: BorderRadius.circular(12.r),
//           color: AppColors.primaryColor,
//           boxShadow: [
//             BoxShadow(
//               color: AppColors.primaryColor.withOpacity(0.2),
//               blurRadius: 8,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         labelColor: Colors.white,
//         unselectedLabelColor: Colors.grey.shade500,
//         labelStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
//         unselectedLabelStyle:
//             TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
//         indicatorSize: TabBarIndicatorSize.tab,
//         dividerColor: Colors.transparent,
//         tabs: [
//           Tab(text: AppLocalizations.of(Get.context!)!.your_witness),
//           Tab(text: AppLocalizations.of(Get.context!)!.i_m_the_witness),
//         ],
//       ),
//     );
//   }

//   Widget _buildDialogRow(IconData icon, String label, String value) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 8.h),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             padding: EdgeInsets.all(6.w),
//             decoration: BoxDecoration(
//               color: Colors.orange.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(8.r),
//             ),
//             child: Icon(icon, color: Colors.orange, size: 18.sp),
//           ),
//           SizedBox(width: 12.w),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   label,
//                   style: TextStyle(
//                     color: Colors.white70,
//                     fontSize: 12.sp,
//                   ),
//                 ),
//                 SizedBox(height: 2.h),
//                 Text(
//                   value,
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 14.sp,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void showWitnessDetailsDialog(BuildContext context,
//       GetWitnessResponseModel user, WitnessController witnessController) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return Dialog(
//           backgroundColor: Colors.transparent,
//           insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
//           child: Container(
//             decoration: BoxDecoration(
//               color: const Color(0xFF1A1A2E), // Modern dark navy
//               borderRadius: BorderRadius.circular(24.r),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.5),
//                   blurRadius: 20,
//                   spreadRadius: 5,
//                 ),
//               ],
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Container(
//                   padding: EdgeInsets.all(20.w),
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.05),
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(24.r),
//                       topRight: Radius.circular(24.r),
//                     ),
//                   ),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: Text(
//                           user.name ?? AppLocalizations.of(context)!.n_a,
//                           style: TextStyle(
//                             fontSize: 18.sp,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                       IconButton(
//                         icon: Icon(Icons.close,
//                             color: Colors.white70, size: 20.sp),
//                         onPressed: () => Navigator.pop(context),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Flexible(
//                   child: SingleChildScrollView(
//                     padding: EdgeInsets.all(20.w),
//                     child: Column(
//                       children: [
//                         _buildDialogRow(
//                             Icons.people,
//                             AppLocalizations.of(context)!.relation,
//                             user.relation ?? AppLocalizations.of(context)!.n_a),
//                         _buildDialogRow(
//                             Icons.email,
//                             AppLocalizations.of(context)!.email,
//                             user.email ?? AppLocalizations.of(context)!.n_a),
//                         _buildDialogRow(
//                             Icons.person,
//                             AppLocalizations.of(context)!.father_s_information,
//                             user.fatherName ??
//                                 AppLocalizations.of(context)!.n_a),
//                         _buildDialogRow(
//                             Icons.phone,
//                             AppLocalizations.of(context)!.mobile,
//                             user.mobile ?? AppLocalizations.of(context)!.n_a),
//                         _buildDialogRow(
//                             Icons.favorite,
//                             AppLocalizations.of(context)!.marital_status,
//                             user.maritalStatus ??
//                                 AppLocalizations.of(context)!.n_a),
//                         _buildDialogRow(
//                             Icons.work,
//                             AppLocalizations.of(context)!.profession,
//                             user.profession ??
//                                 AppLocalizations.of(context)!.n_a),
//                         _buildDialogRow(
//                             Icons.calendar_today,
//                             AppLocalizations.of(context)!.date,
//                             user.wnDate != null
//                                 ? DateFormat('dd-MM-yyyy').format(
//                                     DateTime.parse(user.wnDate.toString()))
//                                 : AppLocalizations.of(context)!.n_a),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.all(20.w),
//                   child: Obx(() => CustomButtonCommon(
//                       title: AppLocalizations.of(context)!.remove_witness_btn,
//                       color: AppColors.redColor,
//                       loading: witnessController.isDelNomineeYou.value,
//                       onpress: () {
//                         witnessController.getWitnessDeleteData(
//                             requestKey: user.requestKey);
//                         Get.back();
//                       })),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:al_wasyeah/controllers/witness_controller/witness_controller.dart';
import 'package:al_wasyeah/helpers/app_routes.dart';
import 'package:al_wasyeah/models/witness/get_witness_response_model.dart';
import 'package:al_wasyeah/services/api_constants.dart';
import 'package:al_wasyeah/utils/app_colors.dart';
import 'package:al_wasyeah/view/widgets/custom_button.dart';
import 'package:al_wasyeah/view/widgets/custom_button_common.dart';
import 'package:al_wasyeah/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:al_wasyeah/l10n/app_localizations.dart';
import 'package:skeletonizer/skeletonizer.dart';

class WitnessesScreen extends GetView<WitnessController> {
  const WitnessesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: AppLocalizations.of(context)!.witness,
          fontsize: 20.sp,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 16.h),
          _buildCustomTabBar(),
          Expanded(
            child: TabBarView(
              controller: controller.tabController,
              children: [
                _buildWitnessListTab(
                  context,
                  status: controller.witnessStatus,
                  data: controller.witnessData,
                  showAddButton: true,
                ),
                _buildWitnessListTab(
                  context,
                  status: controller.witnessesYouStatus,
                  data: controller.witnessesYouData,
                  showAddButton: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// ================= LIST TAB =================
  Widget _buildWitnessListTab(
    BuildContext context, {
    required Rx<RxStatus> status,
    required RxList<GetWitnessResponseModel> data,
    required bool showAddButton,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showAddButton) ...[
            SizedBox(height: 20.h),
            _buildAddButton(context),
          ],
          SizedBox(height: 16.h),
          Expanded(
            child: Obx(() {
              final currentStatus = status.value;

              if (currentStatus.isLoading) {
                return Skeletonizer(
                  enabled: true,
                  child: ListView.builder(
                    itemCount: 6,
                    itemBuilder: (_, index) {
                      return _buildWitnessCard(
                        context,
                        GetWitnessResponseModel(), // empty model
                        true,
                      );
                    },
                  ),
                );
              }

              /// ❌ ERROR
              if (currentStatus.isError) {
                return _buildErrorState(
                    context, currentStatus.errorMessage ?? "");
              }

              /// ❌ EMPTY
              if (currentStatus.isEmpty) {
                return _buildEmptyState(context);
              }

              /// ✅ SUCCESS
              return ListView.builder(
                padding: EdgeInsets.only(bottom: 20.h),
                itemCount: data.length,
                itemBuilder: (_, index) {
                  final witness = data[index];
                  return _buildWitnessCard(context, witness, showAddButton);
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  /// ================= ADD BUTTON =================
  Widget _buildAddButton(BuildContext context) {
    return CustomButton(
      title: AppLocalizations.of(context)!.add_more_witness,
      titlecolor: Colors.black,
      onpress: () {
        Get.toNamed(AppRoutes.addWitnessesScreen);
      },
    );
  }

  /// ================= CARD =================
  Widget _buildWitnessCard(
      BuildContext context, GetWitnessResponseModel witness, bool canEdit) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16.r),
        onTap: () {
          Get.toNamed(AppRoutes.witnessDetailsScreen,
              arguments: {"witness": witness, "canRemove": canEdit});
        },
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Row(
            children: [
              /// Avatar
              Container(
                width: 50.w,
                height: 50.w,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: witness.imageUrl != null && witness.imageUrl!.isNotEmpty
                    ? CircleAvatar(
                        radius: 18,
                        backgroundImage: NetworkImage(
                          ApiConstants.imageUrl + witness.imageUrl!,
                        ),
                        backgroundColor: Colors.grey[200],
                      )
                    : CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.grey[200],
                        child: const Icon(Icons.person),
                      ),
              ),

              SizedBox(width: 16.w),

              /// Text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      witness.name ?? AppLocalizations.of(context)!.n_a,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      AppLocalizations.of(context)!.view_details,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ================= EMPTY =================
  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: CustomText(
        text: AppLocalizations.of(context)!.no_data,
      ),
    );
  }

  /// ================= ERROR =================
  Widget _buildErrorState(BuildContext context, String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(error),
          TextButton(
            onPressed: () {
              controller.getWitnessData();
              controller.getWitnessesYouData();
            },
            child: Text(AppLocalizations.of(context)!.try_again),
          )
        ],
      ),
    );
  }

  /// ================= TAB =================
  Widget _buildCustomTabBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(6.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: TabBar(
        controller: controller.tabController,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: AppColors.primaryColor,
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryColor.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey.shade500,
        labelStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
        unselectedLabelStyle:
            TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        tabs: [
          Tab(text: AppLocalizations.of(Get.context!)!.your_witness),
          Tab(text: AppLocalizations.of(Get.context!)!.i_m_the_witness),
        ],
      ),
    );
  }

  /// ================= DIALOG =================
}
