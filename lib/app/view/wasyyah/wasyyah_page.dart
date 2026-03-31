import 'package:al_wasyeah/app/controllers/wasyyah/wasyyah_controller.dart';
import 'package:al_wasyeah/app/view/widgets/custom_app_bar.dart';
import 'package:al_wasyeah/core/services/toast_message_helper.dart';
import 'package:al_wasyeah/app/models/wasyyah/get_wasyyah_response_model.dart';
import 'package:al_wasyeah/core/utils/app_colors.dart';
import 'package:al_wasyeah/core/widgets/custom_button_common.dart';
import 'package:al_wasyeah/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:al_wasyeah/core/l10n/app_localizations.dart';
import 'package:al_wasyeah/core/services/app_routes.dart';
import 'package:open_file/open_file.dart';

class WasyyahPage extends GetView<WasyyahController> {
  WasyyahPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.wasiyyah_ichanama_title,
        actions: [
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
      //   onPressed: () {}, // TODO: Connect to AddNewWashyiaScreen if implemented
      //   backgroundColor: AppColors.primaryColor,
      //   icon: const Icon(Icons.add, color: Colors.white),
      //   label: CustomText(
      //     text: AppLocalizations.of(context)!.add_more_content,
      //     color: Colors.white,
      //   ),
      // ),
    );
  }

  Widget _buildWasyyahCard(
      BuildContext context, GetWasyyahResponseModel item, int index) {
    bool isHidden = item.visible == "N";

    return Container(
      key: ValueKey(item.requestKey ?? index.toString()),
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
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
                      isHidden ? "Show" : "Hide",
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

  void _showEditBottomSheet(
      BuildContext context, GetWasyyahResponseModel item) {
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
                text: "Edit ${item.title}",
                fontsize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(height: 16.h),
              TextField(
                controller: textController,
                maxLines: 8,
                onChanged: (val) => currentText.value = val,
                decoration: InputDecoration(
                  hintText: "Enter content here...",
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
                    title: "Save",
                    color: AppColors.primaryColor,
                    onpress: () async {
                      item.content = currentText.value;
                      bool success = await controller.saveWasiyyah(item);
                      if (success) {
                        Get.back();
                        ToastMessageHelper.successMessageShowToster(
                            "Updated successfully");
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
          title: const Text("Open PDF"),
          children: [
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context, _PreviewChoice.inApp),
              child: const Text("Open in app"),
            ),
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context, _PreviewChoice.external),
              child: const Text("Open in other app"),
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
        AppRoutes.wasyyahPdfPreviewPage,
        arguments: {"filePath": file.path},
      );
    } else {
      await OpenFile.open(file.path);
    }
  }
}

enum _PreviewChoice { inApp, external }
