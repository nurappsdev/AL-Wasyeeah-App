import 'package:al_wasyeah/app/core/services/qr_barcode/qr_barcode_service.dart';
import 'package:al_wasyeah/app/core/utils/toast_message.dart';
import 'package:al_wasyeah/app/view/wasiyyah/controller/wasyyah_controller.dart';
import 'package:al_wasyeah/app/view/profile/controller/profile_controller.dart';
import 'package:al_wasyeah/app/core/widgets/custom_app_bar.dart';
import 'package:al_wasyeah/app/view/wasiyyah/model/wasyyah_model.dart';
import 'package:al_wasyeah/app/core/utils/app_colors.dart';
import 'package:al_wasyeah/app/core/widgets/custom_button_common.dart';
import 'package:al_wasyeah/app/core/widgets/custom_text.dart';
import 'package:al_wasyeah/app/view/wasiyyah/qr_barcode_test_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:al_wasyeah/app/core/l10n/app_localizations.dart';
import 'package:al_wasyeah/app/core/route/route_names.dart';
import 'package:open_file/open_file.dart';

class WasyyahPage extends GetView<WasyyahController> {
  WasyyahPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.wasiyyah_ichanama_title,
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_scanner, color: Colors.black),
            tooltip: "QR & Barcode Tester",
            onPressed: () => _openQrBarcodeTestPage(),
          ),
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: CustomButton(
              title: AppLocalizations.of(context)!.preview,
              onpress: () => _showPreviewOptions(context),
              width: 100.w,
              // height: 40.h,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.wasyyahList.isEmpty) {
          return Center(
            child: CustomText(
                text: AppLocalizations.of(context)!.no_content_available),
          );
        }

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              CustomText(
                text: AppLocalizations.of(context)!.bismillahir_rahmanir_raheem,
                // maxline: 3,
                fontsize: 16.sp,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(
                height: 16.h,
              ),
              CustomText(
                text: AppLocalizations.of(context)!
                    .assalamu_alaykum_wa_rahmatullah_innallillah_rabbil_alamin_wassalatu_wassalamu_ala_rasulillah_sallallahu_alaihi_wassallam,
                // maxline: 3,
                fontsize: 16.sp,
                fontWeight: FontWeight.w700,
              ),
              Expanded(
                child: ReorderableListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.wasyyahList.length,
                  onReorder: controller.onReorder,
                  itemBuilder: (context, index) {
                    final item = controller.wasyyahList[index];
                    return _buildWasyyahCard(context, item, index);
                  },
                ),
              ),
            ],
          ),
        );
      }),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {},
      //   backgroundColor: AppColors.primaryColor,
      //   icon: const Icon(Icons.add, color: Colors.white),
      //   label: CustomText(
      //     text: AppLocalizations.of(context)!.add_more_content,
      //     color: Colors.white,
      //   ),
      // ),
    );
  }

  Future<void> _openQrBarcodeTestPage() async {
    try {
      final profileController = Get.find<ProfileController>();
      final personalData = profileController.personalForm;
      final user = profileController.profileModel;
      final qrData = {
        "n":
            "${personalData.value.firstName.text} ${personalData.value.lastName.text}",
        "e": user.value.userProfile?.email ?? "N/A",
        "p": user.value.userProfile?.mobile ?? "N/A",
        "dob": user.value.userProfile?.dob ?? "N/A",
        "prof":
            personalData.value.selectedProfession.value?.profession ?? "N/A",
        "gn":
            personalData.value.selectedGender.value?.gender ?? "N/A",
        "ms":
            personalData.value.selectedMarried.value?.maritalType ?? "N/A",
        "p_addr":
            user.value.userProfile?.permanentAddress ?? "N/A",
        "pr_addr":
            user.value.userProfile?.presentAddress ?? "N/A",
        "cnt":
            personalData.value.selectedCountry.value?.country ?? "N/A",
        "nid": personalData.value.nid.text,
        "tin": personalData.value.tin.text,
      };

      final qrBase64 = await QrBarcodeService.generateQrBase64(qrData);
      final barcodeBase64 =
          await QrBarcodeService.generateBarcodeBase64(qrData);

      Get.to(() => QrBarcodeTestPage(
            qrBase64: qrBase64,
            barcodeBase64: barcodeBase64,
          ));
    } catch (e) {
      ToastMessage.errorMessageShowToster("Failed to generate QR/Barcode: $e");
    }
  }

  Widget _buildWasyyahCard(
      BuildContext context, WasyyahContentModel item, int index) {
    bool isHidden = item.visible == "N";

    return Container(
      key: ValueKey(item.requestKey ?? index.toString()),
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Opacity(
        opacity: isHidden ? 0.6 : 1.0,
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomText(
                      text: item.title ?? "",
                      // maxline: 3,
                      fontsize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const Icon(Icons.drag_indicator, color: Colors.grey),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: const Divider(),
              ),
              CustomText(
                text: item.content ?? "",
                fontsize: 14.sp,
                maxline: 10,
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (!isHidden)
                    TextButton.icon(
                      onPressed: () => _showEditBottomSheet(context, item),
                      icon: const Icon(Icons.edit, size: 18),
                      label: Text(AppLocalizations.of(context)!.edit),
                      style: TextButton.styleFrom(foregroundColor: Colors.blue),
                    ),
                  SizedBox(width: 8.w),
                  TextButton.icon(
                    onPressed: () => controller.toggleVisibility(item),
                    icon: Icon(
                      isHidden ? Icons.visibility : Icons.visibility_off,
                      size: 18,
                    ),
                    label: Text(
                      isHidden
                          ? AppLocalizations.of(context)!.show
                          : AppLocalizations.of(context)!.hide,
                    ),
                    style: TextButton.styleFrom(
                      foregroundColor: isHidden ? Colors.green : Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showEditBottomSheet(BuildContext context, WasyyahContentModel item) {
    final TextEditingController textController =
        TextEditingController(text: item.content);
    final RxString currentText = (item.content ?? "").obs;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 20.w,
            right: 20.w,
            top: 20.h,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "${AppLocalizations.of(context)!.edit} ${item.title}",
                fontsize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(height: 16.h),
              TextField(
                controller: textController,
                maxLines: 8,
                onChanged: (val) => currentText.value = val,
                decoration: InputDecoration(
                  hintText:
                      AppLocalizations.of(context)!.enter_the_content_here,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
              ),
              SizedBox(height: 20.h),
              Obx(() {
                bool hasChanged = currentText.value != (item.content ?? "");
                if (!hasChanged) return const SizedBox.shrink();

                return SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    title:
                        "${AppLocalizations.of(context)!.enter_the_content_here}....",
                    color: AppColors.primaryColor,
                    onpress: () async {
                      item.content = currentText.value;
                      bool success = await controller.saveWasiyyah(item);
                      if (success) {
                        Get.back();
                        ToastMessage.successMessageShowToster(
                            AppLocalizations.of(context)!
                                .wasiyyah_update_successfully);
                      }
                    },
                  ),
                );
              }),
              SizedBox(height: 20.h),
            ],
          ),
        );
      },
    );
  }

  Future<void> _showPreviewOptions(BuildContext context) async {
    final choice = await showDialog<_PreviewChoice>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text(AppLocalizations.of(context)!.open_pdf),
          children: [
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context, _PreviewChoice.inApp),
              child: Text(AppLocalizations.of(context)!.open_in_app),
            ),
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context, _PreviewChoice.external),
              child: Text(AppLocalizations.of(context)!.open_in_other_app),
            ),
          ],
        );
      },
    );

    if (choice == null) return;

    final file = await controller.generatePdfFile();
    if (file == null) return;

    if (choice == _PreviewChoice.inApp) {
      Get.toNamed(
        RouteName.wasyyahPdfPreviewPage,
        arguments: {"filePath": file.path},
      );
    } else {
      await OpenFile.open(file.path);
    }
  }
}

enum _PreviewChoice { inApp, external }
