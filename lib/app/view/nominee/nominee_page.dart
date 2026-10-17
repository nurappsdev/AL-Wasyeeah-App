import 'package:al_wasiyyath/app/view/nominee/controller/nominee_controller.dart';
import 'package:al_wasiyyath/app/core/widgets/custom_app_bar.dart';
import 'package:al_wasiyyath/app/core/route/route_names.dart';
import 'package:al_wasiyyath/app/view/witnessess/model/get_witness_response_model.dart';
import 'package:al_wasiyyath/app/core/utils/api_constants.dart';
import 'package:al_wasiyyath/app/core/utils/app_colors.dart';
import 'package:al_wasiyyath/app/core/widgets/custom_button_common.dart';
import 'package:al_wasiyyath/app/core/widgets/custom_text.dart';
import 'package:al_wasiyyath/app/core/widgets/app_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:al_wasiyyath/app/core/l10n/app_localizations.dart';
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
          _buildCustomTabBar(context),
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
                  effect: ShimmerEffect(
                    baseColor:
                        isDark ? Colors.grey.shade800 : Colors.grey.shade300,
                    highlightColor:
                        isDark ? Colors.grey.shade700 : Colors.grey.shade100,
                  ),
                  containersColor:
                      isDark ? Colors.grey.shade800 : Colors.grey.shade200,
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
  Widget _buildNomineeCard(BuildContext context,
      GetWitnessNomineeResponseModel witness, bool? canEdit) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isDark ? const Color(0xFF2C3E35) : Colors.transparent,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.05),
            blurRadius: 10,
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16.r),
        onTap: () {
          Get.toNamed(RouteName.nomineeDetailsPage,
              arguments: {"nominee": witness, "canRemove": canEdit});
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
                  color: AppColors.primaryColor
                      .withValues(alpha: isDark ? 0.25 : 0.1),
                  shape: BoxShape.circle,
                ),
                child: witness.imageUrl != null && witness.imageUrl!.isNotEmpty
                    ? CircleAvatar(
                        radius: 18,
                        backgroundImage: NetworkImage(
                          ApiConstants.imageUrl + witness.imageUrl!,
                        ),
                        backgroundColor:
                            isDark ? const Color(0xFF2C3E35) : Colors.grey[200],
                      )
                    : CircleAvatar(
                        radius: 18,
                        backgroundColor:
                            isDark ? const Color(0xFF2C3E35) : Colors.grey[200],
                        child: Icon(
                          Icons.person,
                          color: isDark ? Colors.white70 : Colors.grey[600],
                        ),
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
                        color: isDark ? Colors.white : const Color(0xff1A1A1A),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      AppLocalizations.of(context)!.view_details,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: isDark ? const Color(0xff94A3B8) : Colors.grey,
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
    return AppErrorWidget(
      message: error.isNotEmpty ? error : "Failed to load nominee data",
      onRetry: () {
        controller.getNomineeData();
        controller.getNomineesYouData();
      },
    );
  }

  /// ================= TAB =================
  Widget _buildCustomTabBar(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(6.w),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16.r),
        border: isDark ? Border.all(color: const Color(0xFF2C3E35)) : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.02),
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
              color: AppColors.primaryColor.withValues(alpha: 0.2),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        labelColor: Colors.white,
        unselectedLabelColor:
            isDark ? Colors.grey.shade400 : Colors.grey.shade500,
        labelStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
        unselectedLabelStyle:
            TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
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
