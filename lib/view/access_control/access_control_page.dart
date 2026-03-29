import 'package:al_wasyeah/controllers/access_control/access_control_controller.dart';
import 'package:al_wasyeah/models/access_control/access_control_user_model.dart';
import 'package:al_wasyeah/l10n/app_localizations.dart';
import 'package:al_wasyeah/utils/app_colors.dart';
import 'package:al_wasyeah/view/widgets/custom_dropdown.dart';
import 'package:al_wasyeah/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AccessControlPage extends GetView<AccessControlController> {
  const AccessControlPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: AppLocalizations.of(context)!.access_control,
          fontWeight: FontWeight.w600,
          fontsize: 20.sp,
        ),
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
                      ? SizedBox(
                          width: 20,
                          height: 20,
                          child: const CircularProgressIndicator(
                              color: Colors.white))
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
                if (controller.isUsersLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (controller.selectedRole.value != null &&
                    controller.usersList.isEmpty) {
                  return const Center(child: Text("No users found"));
                }
                return ListView.builder(
                  itemCount: controller.usersList.length,
                  itemBuilder: (context, index) {
                    var user = controller.usersList[index];
                    return _buildUserExpansionTile(user, context);
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserExpansionTile(
      AccessControlUserModel user, BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 12.h),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      child: ExpansionTile(
        title: Text(user.name ?? AppLocalizations.of(context)!.n_a,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp)),
        onExpansionChanged: (expanded) {
          if (expanded && user.requestKey != null) {
            controller.fetchContextsData(user.requestKey!);
          }
        },
        children: [
          Obx(() {
            if (controller.loadingContextUsers.contains(user.requestKey)) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: const Center(child: CircularProgressIndicator()),
              );
            }
            if (controller.allContexts.isEmpty) {
              return Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(AppLocalizations.of(context)!.no_data),
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
                    title: Text(contextItem.contextName ??
                        AppLocalizations.of(context)!.n_a),
                    value: isChecked,
                    onChanged: (bool? value) {
                      if (value != null && user.requestKey != null) {
                        controller.toggleContext(
                            user.requestKey!, contextItem.id!, value);
                      }
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: AppColors.primaryColor,
                  );
                }).toList(),
              ],
            );
          }),
        ],
      ),
    );
  }
}
