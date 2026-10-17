import 'package:al_wasiyyath/app/view/access_control/controller/access_control_controller.dart';
import 'package:al_wasiyyath/app/core/widgets/custom_app_bar.dart';
import 'package:al_wasiyyath/app/view/access_control/model/access_control_user_model.dart';
import 'package:al_wasiyyath/app/core/l10n/app_localizations.dart';
import 'package:al_wasiyyath/app/core/utils/app_colors.dart';
import 'package:al_wasiyyath/app/core/widgets/custom_dropdown.dart';
import 'package:al_wasiyyath/app/core/widgets/app_error_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AccessControlPage extends GetView<AccessControlController> {
  const AccessControlPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.access_control,
      ),
      bottomNavigationBar: Obx(() {
        if (controller.hasAnyChanges) {
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.all(24.w),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.isSaving.value
                      ? null
                      : () {
                          controller.saveAllChanges();
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r)),
                  ),
                  child: controller.isSaving.value
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(color: Colors.white))
                      : Text(AppLocalizations.of(context)!.save,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      }),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            Container(
              height: 48.h,
              alignment: Alignment.center,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(8.r),
              ),
              padding: EdgeInsets.all(8.h),
              child: Text(
                AppLocalizations.of(context)!.access_control_panel,
                style: TextStyle(color: Colors.white, fontSize: 22.sp),
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            Obx(() => CustomDropdown<String>(
                  hint: AppLocalizations.of(context)!.please_select_a_role,
                  items: const <String>["Witness", "Nominee"],
                  value: controller.selectedRole.value,
                  itemToString: (item) => item,
                  onChanged: (val) => controller.selectedRole.value = val,
                )),
            SizedBox(height: 16.h),
            Expanded(
              child: Obx(() {
                final status = controller.usersStatus.value;
                if (controller.isUsersLoading.value || status.isLoading) {
                  return _buildUsersSkeleton(context, isDark);
                }
                if (status.isError) {
                  return AppErrorWidget(
                    message: status.errorMessage,
                    onRetry: () => controller.getUsersByRole(),
                  );
                }
                if (controller.selectedRole.value != null &&
                    controller.usersList.isEmpty) {
                  return Center(
                    child: Text(
                      AppLocalizations.of(context)!.no_data,
                      style: TextStyle(
                        color: isDark ? Colors.white70 : Colors.black54,
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: controller.usersList.length,
                  itemBuilder: (context, index) {
                    var user = controller.usersList[index];
                    return _buildUserExpansionTile(user, context, isDark);
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUsersSkeleton(BuildContext context, bool isDark) {
    return Skeletonizer(
      enabled: true,
      effect: ShimmerEffect(
        baseColor: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
        highlightColor: isDark ? Colors.grey.shade700 : Colors.grey.shade100,
      ),
      containersColor: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
      child: ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.only(bottom: 12.h),
            elevation: 2,
            color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
              side: isDark
                  ? const BorderSide(color: Color(0xFF2C3E35))
                  : BorderSide.none,
            ),
            child: ListTile(
              title: Text(
                "Loading User Name...",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              trailing: Icon(
                Icons.expand_more,
                color: isDark ? Colors.white70 : Colors.black54,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildUserExpansionTile(
      AccessControlUserModel user, BuildContext context, bool isDark) {
    return Card(
      margin: EdgeInsets.only(bottom: 12.h),
      elevation: 2,
      color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
        side: isDark
            ? const BorderSide(color: Color(0xFF2C3E35))
            : BorderSide.none,
      ),
      child: ExpansionTile(
        iconColor: AppColors.primaryColor,
        collapsedIconColor: isDark ? Colors.white70 : Colors.black54,
        title: Text(
          user.name ?? AppLocalizations.of(context)!.n_a,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        onExpansionChanged: (expanded) {
          if (expanded && user.requestKey != null) {
            controller.fetchContextsData(user.requestKey!);
          }
        },
        children: [
          Obx(() {
            if (controller.loadingContextUsers.contains(user.requestKey)) {
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
                child: Column(
                  children: List.generate(
                    4,
                    (index) => CheckboxListTile(
                      title: Text(
                        "Context Feature Option",
                        style: TextStyle(
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                      value: false,
                      onChanged: null,
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  ),
                ),
              );
            }
            if (controller.allContexts.isEmpty) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  AppLocalizations.of(context)!.no_data,
                  style: TextStyle(
                    color: isDark ? Colors.white70 : Colors.black54,
                  ),
                ),
              );
            }
            return Column(
              children: [
                ...controller.allContexts.map((contextItem) {
                  bool isChecked = controller
                          .userSelectedContexts[user.requestKey]
                          ?.contains(contextItem.id) ??
                      false;
                  return CheckboxListTile(
                    title: Text(
                      contextItem.contextName ??
                          AppLocalizations.of(context)!.n_a,
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    value: isChecked,
                    onChanged: (bool? value) {
                      if (value != null && user.requestKey != null) {
                        controller.toggleContext(
                            user.requestKey!, contextItem.id!, value);
                      }
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: AppColors.primaryColor,
                    checkColor: Colors.white,
                  );
                }),
              ],
            );
          }),
        ],
      ),
    );
  }
}
