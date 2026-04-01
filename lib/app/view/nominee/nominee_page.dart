import 'package:al_wasyeah/app/view/nominee/controller/nominee_controller.dart';
import 'package:al_wasyeah/app/core/widgets/custom_app_bar.dart';
import 'package:al_wasyeah/app/core/route/route_names.dart';
import 'package:al_wasyeah/app/view/witnessess/model/get_witness_response_model.dart';
import 'package:al_wasyeah/app/core/utils/api_constants.dart';
import 'package:al_wasyeah/app/core/utils/app_colors.dart';
import 'package:al_wasyeah/app/core/widgets/custom_button_common.dart';
import 'package:al_wasyeah/app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:al_wasyeah/app/core/l10n/app_localizations.dart';
import 'package:skeletonizer/skeletonizer.dart';

class NomineesPage extends GetView<NomineeController> {
  const NomineesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.nominee,
      ),
      body: Column(
        children: [
          SizedBox(height: 16.h),
          _buildCustomTabBar(),
          Expanded(
            child: TabBarView(
              controller: controller.tabController,
              children: [
                _buildNomineeListTab(
                  context,
                  status: controller.nomineeStatus,
                  data: controller.nomineeData,
                  showAddButton: true,
                ),
                _buildNomineeListTab(
                  context,
                  status: controller.nomineesYouStatus,
                  data: controller.nomineesYouData,
                  showAddButton: null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// ================= LIST TAB =================
  Widget _buildNomineeListTab(
    BuildContext context, {
    required Rx<RxStatus> status,
    required RxList<GetWitnessNomineeResponseModel> data,
    bool? showAddButton,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showAddButton != null && showAddButton) ...[
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
                      return _buildNomineeCard(
                        context,
                        GetWitnessNomineeResponseModel(), // empty model
                        true,
                      );
                    },
                  ),
                );
              }

              /// ❌ ERROR
              if (currentStatus.isError) {
                return _buildErrorState(context, currentStatus.errorMessage ?? "");
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
                  return _buildNomineeCard(context, witness, showAddButton);
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
      title: AppLocalizations.of(context)!.add_more_nominees,
      titlecolor: Colors.white,
      onpress: () {
        controller.showAddNomineeBottomSheet();
      },
    );
  }

  /// ================= CARD =================
  Widget _buildNomineeCard(BuildContext context, GetWitnessNomineeResponseModel witness, bool? canEdit) {
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
          Get.toNamed(RouteName.nomineeDetailsPage, arguments: {"nominee": witness, "canRemove": canEdit});
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
              controller.getNomineeData();
              controller.getNomineesYouData();
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
        unselectedLabelStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        tabs: [
          Tab(text: AppLocalizations.of(Get.context!)!.your_nominee),
          Tab(text: AppLocalizations.of(Get.context!)!.i_m_the_nominee),
        ],
      ),
    );
  }
}
