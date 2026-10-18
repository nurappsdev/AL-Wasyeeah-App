import 'package:wasiyyat/app/core/services/qr_barcode/qr_barcode_service.dart';
import 'package:wasiyyat/app/core/utils/toast_message.dart';
import 'package:wasiyyat/app/view/wasiyyah/controller/wasyyah_controller.dart';
import 'package:wasiyyat/app/view/profile/controller/profile_controller.dart';
import 'package:wasiyyat/app/core/widgets/custom_app_bar.dart';
import 'package:wasiyyat/app/view/wasiyyah/model/wasyyah_model.dart';
import 'package:wasiyyat/app/core/utils/app_colors.dart';
import 'package:wasiyyat/app/core/widgets/custom_button_common.dart';
import 'package:wasiyyat/app/core/widgets/custom_text.dart';
import 'package:wasiyyat/app/view/wasiyyah/qr_barcode_test_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wasiyyat/app/core/l10n/app_localizations.dart';
import 'package:wasiyyat/app/core/route/route_names.dart';
import 'package:open_file/open_file.dart';
import 'package:skeletonizer/skeletonizer.dart';

class WasyyahPage extends GetView<WasyyahController> {
  WasyyahPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.wasiyyah_ichanama_title,
        actions: [
          // IconButton(
          //   icon: const Icon(Icons.qr_code_scanner, color: Colors.black),
          //   tooltip: "QR & Barcode Tester",
          //   onPressed: () => _openQrBarcodeTestPage(),
          // ),
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
          return _buildSkeletonLoading(context);
        }

        if (controller.wasyyahList.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                    text: AppLocalizations.of(context)!.no_content_available),
                SizedBox(height: 16.h),
                CustomButton(
                  title: AppLocalizations.of(context)!.create_wasyyah,
                  onpress: () => _showCreateWasiyyahBottomSheet(context),
                  color: AppColors.primaryColor,
                  width: 200.w,
                ),
              ],
            ),
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
              SizedBox(height: 12.h),
              Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: CustomButton(
                  title: AppLocalizations.of(context)!.create_wasyyah,
                  width: double.infinity,
                  onpress: () => _showCreateWasiyyahBottomSheet(context),
                  color: AppColors.primaryColor,
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
        "gn": personalData.value.selectedGender.value?.gender ?? "N/A",
        "ms": personalData.value.selectedMarried.value?.maritalType ?? "N/A",
        "p_addr": user.value.userProfile?.permanentAddress ?? "N/A",
        "pr_addr": user.value.userProfile?.presentAddress ?? "N/A",
        "cnt": personalData.value.selectedCountry.value?.country ?? "N/A",
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

  Widget _buildSkeletonLoading(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Skeletonizer(
      enabled: true,
      effect: ShimmerEffect(
        baseColor: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
        highlightColor: isDark ? Colors.grey.shade700 : Colors.grey.shade100,
      ),
      containersColor: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            CustomText(
              text: AppLocalizations.of(context)!.bismillahir_rahmanir_raheem,
              fontsize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
            SizedBox(
              height: 16.h,
            ),
            CustomText(
              text: AppLocalizations.of(context)!
                  .assalamu_alaykum_wa_rahmatullah_innallillah_rabbil_alamin_wassalatu_wassalamu_ala_rasulillah_sallallahu_alaihi_wassallam,
              fontsize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return _buildWasyyahCard(
                    context,
                    WasyyahContentModel(
                      requestKey: "skeleton_$index",
                      title: "ওয়াসীয়্যাহ / ইচ্ছানামা শিরোনাম",
                      content:
                          "এখানে ওয়াসীয়্যাহর বিবরণ বা বিস্তারিত তথ্য থাকবে যা লোডিং অবস্থায় স্কেলিটন ইফেক্ট হিসেবে প্রদর্শিত হবে।",
                      visible: "Y",
                    ),
                    index,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWasyyahCard(
      BuildContext context, WasyyahContentModel item, int index) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    bool isHidden = item.visible == "N";

    return Container(
      key: ValueKey(item.requestKey ?? index.toString()),
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isDark ? const Color(0xFF2C3E35) : Colors.transparent,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.05),
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
                      fontsize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: isDark
                          ? const Color(0xFF4ADE80)
                          : AppColors.primaryColor,
                    ),
                  ),
                  Icon(
                    Icons.drag_indicator,
                    color: isDark ? Colors.grey.shade400 : Colors.grey,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Divider(
                  color: isDark ? const Color(0xFF2C3E35) : null,
                ),
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
                      style: TextButton.styleFrom(
                        foregroundColor:
                            isDark ? const Color(0xFF60A5FA) : Colors.blue,
                      ),
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
                      foregroundColor: isHidden
                          ? (isDark ? const Color(0xFF4ADE80) : Colors.green)
                          : (isDark ? Colors.grey.shade400 : Colors.grey),
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final TextEditingController textController =
        TextEditingController(text: item.content);
    final RxString currentText = (item.content ?? "").obs;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
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
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black,
                ),
                onChanged: (val) => currentText.value = val,
                decoration: InputDecoration(
                  hintText:
                      AppLocalizations.of(context)!.enter_the_content_here,
                  hintStyle: TextStyle(
                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(
                      color: isDark
                          ? const Color(0xFF384046)
                          : Colors.grey.shade400,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(
                      color: isDark
                          ? const Color(0xFF384046)
                          : Colors.grey.shade400,
                    ),
                  ),
                  filled: true,
                  fillColor: isDark ? const Color(0xFF25282B) : Colors.grey[50],
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

  void _showCreateWasiyyahBottomSheet(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final TextEditingController titleController = TextEditingController();
    final TextEditingController contentController = TextEditingController();
    final RxString titleRx = "".obs;
    final RxString contentRx = "".obs;

    int countWords(String text) {
      final trimmed = text.trim();
      if (trimmed.isEmpty) return 0;
      return trimmed.split(RegExp(r'\s+')).where((w) => w.isNotEmpty).length;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 16.h,
            left: 20.w,
            right: 20.w,
            top: 20.h,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: AppLocalizations.of(context)!.create_wasyyah,
                      fontsize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    IconButton(
                      icon: Icon(Icons.close,
                          color: isDark ? Colors.white : Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                CustomText(
                  text: "Title *",
                  fontsize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: 8.h),
                TextField(
                  controller: titleController,
                  style: TextStyle(color: isDark ? Colors.white : Colors.black),
                  onChanged: (val) => titleRx.value = val,
                  decoration: InputDecoration(
                    hintText: "Enter title",
                    hintStyle: TextStyle(
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(
                        color: isDark
                            ? const Color(0xFF384046)
                            : Colors.grey.shade400,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(
                        color: isDark
                            ? const Color(0xFF384046)
                            : Colors.grey.shade400,
                      ),
                    ),
                    filled: true,
                    fillColor:
                        isDark ? const Color(0xFF25282B) : Colors.grey[50],
                  ),
                ),
                SizedBox(height: 16.h),
                CustomText(
                  text: "Content * (Minimum 10 words)",
                  fontsize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: 8.h),
                TextField(
                  controller: contentController,
                  maxLines: 6,
                  style: TextStyle(color: isDark ? Colors.white : Colors.black),
                  onChanged: (val) => contentRx.value = val,
                  decoration: InputDecoration(
                    hintText:
                        AppLocalizations.of(context)!.enter_the_content_here,
                    hintStyle: TextStyle(
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(
                        color: isDark
                            ? const Color(0xFF384046)
                            : Colors.grey.shade400,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(
                        color: isDark
                            ? const Color(0xFF384046)
                            : Colors.grey.shade400,
                      ),
                    ),
                    filled: true,
                    fillColor:
                        isDark ? const Color(0xFF25282B) : Colors.grey[50],
                  ),
                ),
                SizedBox(height: 8.h),
                Obx(() {
                  final words = countWords(contentRx.value);
                  return Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "$words words ${words < 10 ? '(min 10 required)' : '✓'}",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: words >= 10
                            ? (isDark ? const Color(0xFF4ADE80) : Colors.green)
                            : (isDark
                                ? Colors.grey.shade400
                                : Colors.grey.shade600),
                        fontWeight:
                            words >= 10 ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  );
                }),
                SizedBox(height: 20.h),
                Obx(() {
                  final title = titleRx.value.trim();
                  final content = contentRx.value.trim();
                  final words = countWords(content);
                  final bool isValid =
                      title.isNotEmpty && content.isNotEmpty && words >= 10;

                  if (!isValid) return const SizedBox.shrink();

                  return SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      title: "New Entry",
                      color: AppColors.primaryColor,
                      loading: controller.isSaveLoading.value,
                      onpress: () async {
                        final success = await controller.createWasiyyah(
                          title: titleRx.value.trim(),
                          content: contentRx.value.trim(),
                        );
                        if (success) {
                          Get.back();
                          ToastMessage.successMessageShowToster(
                            AppLocalizations.of(context)
                                    ?.wasiyyah_update_successfully ??
                                "Wasyyah created successfully",
                          );
                        }
                      },
                    ),
                  );
                }),
                SizedBox(height: 12.h),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _showPreviewOptions(BuildContext context) async {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final choice = await showDialog<_PreviewChoice>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
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
