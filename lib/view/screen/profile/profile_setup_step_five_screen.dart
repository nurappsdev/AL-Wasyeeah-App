import 'package:al_wasyeah/controllers/controllers.dart';
import 'package:al_wasyeah/models/profile_info_model/branch_model.dart';
import 'package:al_wasyeah/view/widgets/file_choose_and_download_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../helpers/file_picker_util.dart';
import '../../../utils/app_colors.dart';
import '../../widgets/widgets.dart';
import 'package:al_wasyeah/models/profile_info_model/bank_list_model.dart';
import 'package:al_wasyeah/models/profile_info_model/wealth_list_model.dart';
import 'package:al_wasyeah/models/profile_info_model/document_type_form.dart';

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
            _sectionTitle('bankInformation'),
            _BankWidget(controller: controller),

            // ===== Wealth Information =====
            _sectionTitle('wealthInformation'),
            _WealthWidget(controller: controller),

            // ===== Account Receivable Information =====
            _sectionTitle('accountReceivable'),
            _ReceivableWidget(controller: controller),

            // ===== Account Payable Information =====
            _sectionTitle('accountPayable'),
            _PayableWidget(controller: controller),

            SizedBox(height: 20),
            CustomButtonCommon(
              title: 'finish'.tr,
              onpress: () {
                if (controller.step5formKey.currentState!.validate()) {
                  controller.submitProfile();
                } else {
                  // log("Not validate");
                }
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Column(
      children: [
        Container(
          height: 48,
          alignment: Alignment.center,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.all(8),
          child: Text(
            title.tr,
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
        ),
        SizedBox(height: 16),
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
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.bankListForm.length,
          itemBuilder: (context, index) {
            final form = controller.bankListForm[index];
            return Obx(() {
              return Container(
                margin: EdgeInsets.only(bottom: 24),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(24),
                    border:
                        Border.all(color: Colors.black.withValues(alpha: 0.3))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(text: 'bank'.tr, fontsize: 16),
                    SizedBox(height: 4),
                    CustomDropdown<BankModel>(
                      hint: 'selectBank'.tr,
                      items: controller.bankList,
                      value: form.bank.value,
                      itemToString: (e) => e.bankEn ?? "",
                      onChanged: (v) => controller.onBankChanged(form, v),
                    ),
                    SizedBox(height: 16),
                    CustomText(text: 'branch'.tr, fontsize: 16),
                    SizedBox(height: 4),
                    CustomDropdown<BranchModel>(
                      key: ValueKey("branch_${form.bank.value?.bankId}_$index"),
                      hint: 'selectBranch'.tr,
                      items: form.branchList,
                      value: form.branch.value,
                      itemToString: (e) => e.branchNameEn ?? "",
                      onChanged: (v) => form.branch.value = v,
                    ),
                    SizedBox(height: 16),
                    CustomText(text: 'accountName'.tr, fontsize: 16),
                    SizedBox(height: 4),
                    CustomTextFormField(
                      controller: form.accountName,
                      hint: 'accountName'.tr,
                      validator: (value) => value!.isEmpty
                          ? 'accountNameRequired'.tr
                          : null,
                    ),
                    SizedBox(height: 16),
                    CustomText(
                        text: 'accountBalance'.tr, fontsize: 16),
                    SizedBox(height: 4),
                    CustomTextFormField(
                      controller: form.accountBalance,
                      hint: 'accountBalance'.tr,
                      keyboardType: TextInputType.number,
                      validator: (value) => value!.isEmpty
                          ? 'accountBalanceRequired'.tr
                          : null,
                    ),
                    SizedBox(height: 16),
                    Row(
                      spacing: 4,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => controller.removeBank(index),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.delete_forever, color: Colors.white),
                                SizedBox(width: 8),
                                Text("Remove".tr)
                              ],
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
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add),
                              SizedBox(width: 8),
                              Expanded(
                                  child: Text('addMoreBank'.tr,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis))
                            ],
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
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.wealthListForm.length,
          itemBuilder: (context, index) {
            final form = controller.wealthListForm[index];
            return Obx(() {
              return Container(
                margin: EdgeInsets.only(bottom: 24),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(24),
                    border:
                        Border.all(color: Colors.black.withValues(alpha: 0.3))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(text: 'wealth'.tr, fontsize: 16),
                    SizedBox(height: 4),
                    CustomDropdown<WealthModel>(
                      hint: 'selectWealth'.tr,
                      items: controller.wealthList,
                      value: form.wealth.value,
                      itemToString: (e) => e.wealth ?? "",
                      onChanged: (v) => controller.onWealthChanged(form, v),
                    ),
                    SizedBox(height: 16),
                    CustomText(
                        text: 'documentType'.tr, fontsize: 16),
                    SizedBox(height: 4),
                    CustomDropdown<DocumentTypeForm>(
                      key:
                          ValueKey("doc_${form.wealth.value?.wealthId}_$index"),
                      hint: 'selectDocumentType'.tr,
                      items: form.documentTypeList,
                      value: form.selectedDocumentType.value,
                      itemToString: (e) => e.documentType ?? "",
                      onChanged: (v) => form.selectedDocumentType.value = v,
                    ),
                    SizedBox(height: 16),
                    CustomText(
                        text: 'landAreaInShotangsho'.tr,
                        fontsize: 16),
                    SizedBox(height: 4),
                    CustomTextFormField(
                      controller: form.landArea,
                      hint: 'landArea'.tr,
                      keyboardType: TextInputType.number,
                      validator: (value) =>
                          value!.isEmpty ? 'landAreaRequired'.tr : null,
                    ),
                    SizedBox(height: 16),
                    CustomText(text: 'location'.tr, fontsize: 16),
                    SizedBox(height: 4),
                    CustomTextFormField(
                      controller: form.location,
                      hint: 'location'.tr,
                      validator: (value) =>
                          value!.isEmpty ? 'locationRequired'.tr : null,
                    ),
                    SizedBox(height: 16),
                    CustomText(text: 'note'.tr, fontsize: 16),
                    SizedBox(height: 4),
                    CustomTextFormField(
                      controller: form.note,
                      hint: 'note'.tr,
                      maxLines: 3,
                    ),
                    SizedBox(height: 16),
                    CustomText(
                      text: 'wealthDocuments'.tr,
                      fontsize: 16,
                    ),
                    SizedBox(height: 4),
                    Obx(
                      () => FileChooseAndDownloadButton(
                        pickedFile: form.documentFile,
                        isDownloading: (controller
                                    .isDownloadingMap['wealthDocument$index'] ??
                                false)
                            .obs,
                        progress: (controller.downloadProgressMap[
                                    'wealthDocument$index'] ??
                                0.0)
                            .obs,
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
                              msg: 'wealthDocumentDownloaded'.tr,
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
                    SizedBox(height: 16),
                    SizedBox(height: 16),
                    Row(
                      spacing: 4,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => controller.removeWealth(index),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.delete_forever, color: Colors.white),
                                SizedBox(width: 8),
                                Text("Remove".tr)
                              ],
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
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add),
                              SizedBox(width: 8),
                              Expanded(
                                  child: Text('addMoreWealth'.tr,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis))
                            ],
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
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.receivableListForm.length,
            itemBuilder: (context, index) {
              final form = controller.receivableListForm[index];
              return Container(
                margin: EdgeInsets.only(bottom: 24),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(24),
                    border:
                        Border.all(color: Colors.black.withValues(alpha: 0.3))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                        text: 'receivableAmount'.tr, fontsize: 16),
                    SizedBox(height: 4),
                    CustomTextFormField(
                      controller: form.amount,
                      hint: 'amount'.tr,
                      keyboardType: TextInputType.number,
                      validator: (value) =>
                          value!.isEmpty ? 'amountRequired'.tr : null,
                    ),
                    SizedBox(height: 16),
                    CustomText(
                        text: 'receivablePerson'.tr, fontsize: 16),
                    SizedBox(height: 4),
                    CustomTextFormField(
                      controller: form.personName,
                      hint: 'personName'.tr,
                      validator: (value) => value!.isEmpty
                          ? 'personNameRequired'.tr
                          : null,
                    ),
                    SizedBox(height: 16),
                    CustomText(
                        text: 'receivablePersonMobile'.tr,
                        fontsize: 16),
                    SizedBox(height: 4),
                    CustomTextFormField(
                      controller: form.personMobile,
                      hint: 'mobile'.tr,
                      keyboardType: TextInputType.phone,
                      validator: (value) =>
                          value!.isEmpty ? 'mobileRequired'.tr : null,
                    ),
                    SizedBox(height: 16),
                    Row(
                      spacing: 4,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => controller.removeReceivable(index),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.delete_forever, color: Colors.white),
                                SizedBox(width: 8),
                                Text("Remove".tr)
                              ],
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
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add),
                              SizedBox(width: 8),
                              Expanded(
                                  child: Text('addMore'.tr,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis))
                            ],
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
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.payableListForm.length,
            itemBuilder: (context, index) {
              final form = controller.payableListForm[index];
              return Container(
                margin: EdgeInsets.only(bottom: 24),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(24),
                    border:
                        Border.all(color: Colors.black.withValues(alpha: 0.3))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                        text: 'payableAmount'.tr, fontsize: 16),
                    SizedBox(height: 4),
                    CustomTextFormField(
                      controller: form.amount,
                      hint: 'amount'.tr,
                      keyboardType: TextInputType.number,
                      validator: (value) =>
                          value!.isEmpty ? 'amountRequired'.tr : null,
                    ),
                    SizedBox(height: 16),
                    CustomText(
                        text: 'payablePerson'.tr, fontsize: 16),
                    SizedBox(height: 4),
                    CustomTextFormField(
                      controller: form.personName,
                      hint: 'personName'.tr,
                      validator: (value) => value!.isEmpty
                          ? 'personNameRequired'.tr
                          : null,
                    ),
                    SizedBox(height: 16),
                    CustomText(
                        text: 'payablePersonMobile'.tr,
                        fontsize: 16),
                    SizedBox(height: 4),
                    CustomTextFormField(
                      controller: form.personMobile,
                      hint: 'mobile'.tr,
                      keyboardType: TextInputType.phone,
                      validator: (value) =>
                          value!.isEmpty ? 'mobileRequired'.tr : null,
                    ),
                    SizedBox(height: 16),
                    Row(
                      spacing: 4,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => controller.removePayable(index),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.delete_forever, color: Colors.white),
                                SizedBox(width: 8),
                                Text("Remove".tr)
                              ],
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
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add),
                              SizedBox(width: 8),
                              Expanded(
                                  child: Text('addMore'.tr,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis))
                            ],
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



