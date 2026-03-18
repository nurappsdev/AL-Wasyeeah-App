import 'package:al_wasyeah/controllers/controllers.dart';
import 'package:al_wasyeah/models/profile_info_model/branch_model.dart';
import 'package:al_wasyeah/utils/app_colors.dart';
import 'package:al_wasyeah/view/widgets/custom_button_common.dart';
import 'package:al_wasyeah/view/widgets/custom_dropdown.dart';
import 'package:al_wasyeah/view/widgets/custom_text.dart';
import 'package:al_wasyeah/view/widgets/custom_text_field.dart';
import 'package:al_wasyeah/view/widgets/file_choose_and_download_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../helpers/file_picker_util.dart';

import 'package:al_wasyeah/models/profile_info_model/bank_list_model.dart';
import 'package:al_wasyeah/models/profile_info_model/wealth_list_model.dart';
import 'package:al_wasyeah/models/profile_info_model/document_type_form.dart';
import 'package:al_wasyeah/l10n/app_localizations.dart';

class ProfileSettingStepFiveWidget extends StatelessWidget {
  ProfileSettingStepFiveWidget({super.key});

  final ProfileController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: controller.step5formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== Bank Information =====
            _sectionTitle(AppLocalizations.of(context)!.bank_information),
            _BankWidget(controller: controller),

            // ===== Wealth Information =====
            _sectionTitle(AppLocalizations.of(context)!.wealth_information),
            _WealthWidget(controller: controller),

            // ===== Account Receivable Information =====
            _sectionTitle(AppLocalizations.of(context)!.account_receivable_information),
            _ReceivableWidget(controller: controller),

            // ===== Account Payable Information =====
            _sectionTitle(AppLocalizations.of(context)!.account_payable_information),
            _PayableWidget(controller: controller),

            SizedBox(height: 20.h),
            Row(
              spacing: 16.w,
              children: [
                Expanded(
                  child: CustomButtonCommon(
                    title: AppLocalizations.of(context)!.previous,
                    onpress: () {
                      controller.onStepTapped(controller.currentStep.value - 1);
                    },
                  ),
                ),
                Expanded(
                  child: CustomButtonCommon(
                    title: AppLocalizations.of(context)!.finish,
                    onpress: () {
                      if (controller.step5formKey.currentState!.validate()) {
                        controller.submitProfile();
                      }
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Column(
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
            title,
            style: TextStyle(color: Colors.white, fontSize: 22.sp),
          ),
        ),
        SizedBox(height: 16.h),
      ],
    );
  }
}

class _BankWidget extends StatelessWidget {
  const _BankWidget({required this.controller});
  final ProfileController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (controller.bankListForm.isEmpty)
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.addBank(),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                backgroundColor: Colors.white,
                foregroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Icon(Icons.add), SizedBox(width: 8.w), Text(AppLocalizations.of(context)!.add_bank)],
              ),
            ),
          ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.bankListForm.length,
          itemBuilder: (context, index) {
            final form = controller.bankListForm[index];
            return Obx(() {
              return Container(
                margin: EdgeInsets.only(bottom: 24.h),
                padding: EdgeInsets.all(16.h),
                decoration: BoxDecoration(color: AppColors.whiteColor, borderRadius: BorderRadius.circular(24.r), border: Border.all(color: Colors.black.withValues(alpha: 0.3))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CustomText(text: AppLocalizations.of(context)!.bank, fontsize: 16.sp),
                        Text(' *', style: TextStyle(color: Colors.red, fontSize: 16.sp)),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    CustomDropdown<BankModel>(
                      hint: AppLocalizations.of(context)!.select_bank,
                      items: controller.bankList,
                      value: form.bank.value,
                      itemToString: (e) => e.bankEn ?? "",
                      onChanged: (v) => controller.onBankChanged(form, v),
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        CustomText(text: AppLocalizations.of(context)!.branch, fontsize: 16.sp),
                        Text(' *', style: TextStyle(color: Colors.red, fontSize: 16.sp)),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    CustomDropdown<BranchModel>(
                      key: ValueKey("branch_${form.bank.value?.bankId}_$index"),
                      hint: AppLocalizations.of(context)!.select_branch,
                      items: form.branchList,
                      value: form.branch.value,
                      itemToString: (e) => e.branchNameEn ?? "",
                      onChanged: (v) => form.branch.value = v,
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        CustomText(text: AppLocalizations.of(context)!.account_name, fontsize: 16.sp),
                        Text(' *', style: TextStyle(color: Colors.red, fontSize: 16.sp)),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    CustomTextFormField(
                      controller: form.accountName,
                      hint: AppLocalizations.of(context)!.account_name,
                      validator: (value) => value!.isEmpty ? AppLocalizations.of(context)!.please_enter_account_name : null,
                    ),
                    SizedBox(height: 16.h),
                    CustomText(text: AppLocalizations.of(context)!.account_balance, fontsize: 16.sp),
                    SizedBox(height: 4.h),
                    CustomTextFormField(
                      controller: form.accountBalance,
                      hint: AppLocalizations.of(context)!.account_balance,
                      keyboardType: TextInputType.number,
                      validator: (value) => value!.isEmpty ? AppLocalizations.of(context)!.please_enter_account_balance : null,
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      spacing: 4.w,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => controller.removeBank(index),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [Icon(Icons.delete_forever, color: Colors.white), SizedBox(width: 8.w), Text(AppLocalizations.of(context)!.remove)],
                            ),
                          ),
                        ),
                        Expanded(
                            child: ElevatedButton(
                          onPressed: () => controller.addBank(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: AppColors.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Icon(Icons.add), SizedBox(width: 8.w), Expanded(child: Text(AppLocalizations.of(context)!.add_more_bank, maxLines: 2, overflow: TextOverflow.ellipsis))],
                          ),
                        ))
                      ],
                    ),
                  ],
                ),
              );
            });
          },
        ),
      ],
    );
  }
}

class _WealthWidget extends StatelessWidget {
  const _WealthWidget({required this.controller});
  final ProfileController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (controller.wealthListForm.isEmpty)
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.addWealth(),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                backgroundColor: Colors.white,
                foregroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Icon(Icons.add), SizedBox(width: 8.w), Text(AppLocalizations.of(context)!.add_wealth)],
              ),
            ),
          ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.wealthListForm.length,
          itemBuilder: (context, index) {
            final form = controller.wealthListForm[index];
            return Obx(() {
              return Container(
                margin: EdgeInsets.only(bottom: 24.h),
                padding: EdgeInsets.all(16.h),
                decoration: BoxDecoration(color: AppColors.whiteColor, borderRadius: BorderRadius.circular(24.r), border: Border.all(color: Colors.black.withValues(alpha: 0.3))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CustomText(text: AppLocalizations.of(context)!.wealth, fontsize: 16.sp),
                        Text(' *', style: TextStyle(color: Colors.red, fontSize: 16.sp)),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    CustomDropdown<WealthModel>(
                      hint: AppLocalizations.of(context)!.select_wealth,
                      items: controller.wealthList,
                      value: form.wealth.value,
                      itemToString: (e) => e.wealth ?? "",
                      onChanged: (v) => controller.onWealthChanged(form, v),
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        CustomText(text: AppLocalizations.of(context)!.document_type, fontsize: 16.sp),
                        Text(' *', style: TextStyle(color: Colors.red, fontSize: 16.sp)),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    CustomDropdown<DocumentTypeForm>(
                      key: ValueKey("doc_${form.wealth.value?.wealthId}_$index"),
                      hint: AppLocalizations.of(context)!.select_document_type,
                      items: form.documentTypeList,
                      value: form.selectedDocumentType.value,
                      itemToString: (e) => e.documentType ?? "",
                      onChanged: (v) => form.selectedDocumentType.value = v,
                    ),
                    SizedBox(height: 16.h),
                    CustomText(text: AppLocalizations.of(context)!.land_area_in_shotangsho, fontsize: 16.sp),
                    SizedBox(height: 4.h),
                    CustomTextFormField(
                      controller: form.landArea,
                      hint: AppLocalizations.of(context)!.land_area,
                      keyboardType: TextInputType.number,
                      validator: (value) => value!.isEmpty ? AppLocalizations.of(context)!.please_enter_land_area : null,
                    ),
                    SizedBox(height: 16.h),
                    CustomText(text: AppLocalizations.of(context)!.location, fontsize: 16.sp),
                    SizedBox(height: 4.h),
                    CustomTextFormField(
                      controller: form.location,
                      hint: AppLocalizations.of(context)!.location,
                      validator: (value) => value!.isEmpty ? AppLocalizations.of(context)!.please_enter_location : null,
                    ),
                    SizedBox(height: 16.h),
                    CustomText(text: AppLocalizations.of(context)!.note, fontsize: 16.sp),
                    SizedBox(height: 4.h),
                    CustomTextFormField(
                      controller: form.note,
                      hint: AppLocalizations.of(context)!.note,
                      maxLines: 3,
                    ),
                    SizedBox(height: 16.h),
                    CustomText(
                      text: AppLocalizations.of(context)!.wealth_documents,
                      fontsize: 16.sp,
                    ),
                    SizedBox(height: 4.h),
                    Obx(
                      () => FileChooseAndDownloadButton(
                        pickedFile: form.documentFile,
                        isDownloading: (controller.isDownloadingMap['wealthDocument$index'] ?? false).obs,
                        progress: (controller.downloadProgressMap['wealthDocument$index'] ?? 0.0).obs,
                        onPickFile: () async {
                          var result = await FilePickerUtil.pickSingleFile();
                          if (result != null) form.documentFile.value = result;
                        },
                        onDownload: () async {
                          bool isComplete = await controller.downloadFile(
                            urlPath: form.documentUrl,
                            filePrefix: "Wealth",
                            type: 'wealthDocument$index',
                          );
                          if (isComplete) {
                            Fluttertoast.showToast(
                              msg: AppLocalizations.of(context)!.wealth_document_file_downloaded_successfully,
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.TOP,
                              timeInSecForIosWeb: 2,
                              backgroundColor: AppColors.primaryColor,
                              textColor: AppColors.whiteColor,
                            );
                          }
                        },
                        fileUrl: form.documentUrl,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      spacing: 4.w,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => controller.removeWealth(index),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [Icon(Icons.delete_forever, color: Colors.white), SizedBox(width: 8.w), Text(AppLocalizations.of(context)!.remove)],
                            ),
                          ),
                        ),
                        Expanded(
                            child: ElevatedButton(
                          onPressed: () => controller.addWealth(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: AppColors.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Icon(Icons.add), SizedBox(width: 8.w), Expanded(child: Text(AppLocalizations.of(context)!.add_more_wealth, maxLines: 2, overflow: TextOverflow.ellipsis))],
                          ),
                        ))
                      ],
                    ),
                  ],
                ),
              );
            });
          },
        ),
      ],
    );
  }
}

class _ReceivableWidget extends StatelessWidget {
  const _ReceivableWidget({required this.controller});
  final ProfileController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        children: [
          if (controller.receivableListForm.isEmpty)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.addReceivable(),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  backgroundColor: Colors.white,
                  foregroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Icon(Icons.add), SizedBox(width: 8.w), Text(AppLocalizations.of(context)!.add_receivable)],
                ),
              ),
            ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.receivableListForm.length,
            itemBuilder: (context, index) {
              final form = controller.receivableListForm[index];
              return Container(
                margin: EdgeInsets.only(bottom: 24.h),
                padding: EdgeInsets.all(16.h),
                decoration: BoxDecoration(color: AppColors.whiteColor, borderRadius: BorderRadius.circular(24.r), border: Border.all(color: Colors.black.withValues(alpha: 0.3))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(text: AppLocalizations.of(context)!.receivable_amount, fontsize: 16.sp),
                    SizedBox(height: 4.h),
                    CustomTextFormField(
                      controller: form.amount,
                      hint: AppLocalizations.of(context)!.amount,
                      keyboardType: TextInputType.number,
                      validator: (value) => value!.isEmpty ? AppLocalizations.of(context)!.please_enter_amount : null,
                    ),
                    SizedBox(height: 16.h),
                    CustomText(text: AppLocalizations.of(context)!.receivable_person, fontsize: 16.sp),
                    SizedBox(height: 4.h),
                    CustomTextFormField(
                      controller: form.personName,
                      hint: AppLocalizations.of(context)!.person_name,
                      validator: (value) => value!.isEmpty ? AppLocalizations.of(context)!.please_enter_person_name : null,
                    ),
                    SizedBox(height: 16.h),
                    CustomText(text: AppLocalizations.of(context)!.receivable_person_mobile, fontsize: 16.sp),
                    SizedBox(height: 4.h),
                    CustomTextFormField(
                      controller: form.personMobile,
                      hint: AppLocalizations.of(context)!.mobile,
                      keyboardType: TextInputType.phone,
                      validator: (value) => value!.isEmpty ? AppLocalizations.of(context)!.please_enter_mobile : null,
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      spacing: 4.w,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => controller.removeReceivable(index),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [Icon(Icons.delete_forever, color: Colors.white), SizedBox(width: 8.w), Text(AppLocalizations.of(context)!.remove)],
                            ),
                          ),
                        ),
                        Expanded(
                            child: ElevatedButton(
                          onPressed: () => controller.addReceivable(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: AppColors.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Icon(Icons.add), SizedBox(width: 8.w), Expanded(child: Text(AppLocalizations.of(context)!.add_more_receivable, maxLines: 2, overflow: TextOverflow.ellipsis))],
                          ),
                        ))
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      );
    });
  }
}

class _PayableWidget extends StatelessWidget {
  const _PayableWidget({required this.controller});
  final ProfileController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        children: [
          if (controller.payableListForm.isEmpty)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.addPayable(),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  backgroundColor: Colors.white,
                  foregroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Icon(Icons.add), SizedBox(width: 8.w), Text(AppLocalizations.of(context)!.add_payable)],
                ),
              ),
            ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.payableListForm.length,
            itemBuilder: (context, index) {
              final form = controller.payableListForm[index];
              return Container(
                margin: EdgeInsets.only(bottom: 24.h),
                padding: EdgeInsets.all(16.h),
                decoration: BoxDecoration(color: AppColors.whiteColor, borderRadius: BorderRadius.circular(24.r), border: Border.all(color: Colors.black.withValues(alpha: 0.3))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(text: AppLocalizations.of(context)!.payable_amount, fontsize: 16.sp),
                    SizedBox(height: 4.h),
                    CustomTextFormField(
                      controller: form.amount,
                      hint: AppLocalizations.of(context)!.amount,
                      keyboardType: TextInputType.number,
                      validator: (value) => value!.isEmpty ? AppLocalizations.of(context)!.please_enter_amount : null,
                    ),
                    SizedBox(height: 16.h),
                    CustomText(text: AppLocalizations.of(context)!.payable_person, fontsize: 16.sp),
                    SizedBox(height: 4.h),
                    CustomTextFormField(
                      controller: form.personName,
                      hint: AppLocalizations.of(context)!.person_name,
                      validator: (value) => value!.isEmpty ? AppLocalizations.of(context)!.please_enter_person_name : null,
                    ),
                    SizedBox(height: 16.h),
                    CustomText(text: AppLocalizations.of(context)!.payable_person_mobile, fontsize: 16.sp),
                    SizedBox(height: 4.h),
                    CustomTextFormField(
                      controller: form.personMobile,
                      hint: AppLocalizations.of(context)!.mobile,
                      keyboardType: TextInputType.phone,
                      validator: (value) => value!.isEmpty ? AppLocalizations.of(context)!.please_enter_mobile : null,
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      spacing: 4.w,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => controller.removePayable(index),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [Icon(Icons.delete_forever, color: Colors.white), SizedBox(width: 8.w), Text(AppLocalizations.of(context)!.remove)],
                            ),
                          ),
                        ),
                        Expanded(
                            child: ElevatedButton(
                          onPressed: () => controller.addPayable(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: AppColors.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Icon(Icons.add), SizedBox(width: 8.w), Expanded(child: Text(AppLocalizations.of(context)!.add_more_payable, maxLines: 2, overflow: TextOverflow.ellipsis))],
                          ),
                        ))
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      );
    });
  }
}
