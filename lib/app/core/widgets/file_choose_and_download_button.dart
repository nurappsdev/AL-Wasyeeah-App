import 'package:al_wasyeah/app/core/services/picker/file_picker_service.dart';
import 'package:al_wasyeah/app/core/l10n/app_localizations.dart';
import 'package:al_wasyeah/app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FileChooseAndDownloadButton extends StatelessWidget {
  final Rxn<PickedFileResult> pickedFile;
  final RxBool isDownloading;
  final RxDouble progress;
  final VoidCallback onPickFile;
  final VoidCallback onDownload;
  final String? fileUrl;
  FileChooseAndDownloadButton({
    required this.pickedFile,
    required this.isDownloading,
    required this.progress,
    required this.onPickFile,
    required this.onDownload,
    this.fileUrl,
  });
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primaryColor,
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                side: BorderSide(color: AppColors.primaryColor),
              ),
              onPressed: onPickFile,
              child: Obx(
                () => Row(
                  children: [
                    // Icon
                    Icon(
                      Icons.attach_file,
                      size: 20.sp,
                      color: AppColors.primaryColor,
                    ),
                    SizedBox(width: 8.w),

                    // Choose file text
                    Text(
                      AppLocalizations.of(context)!.choose_file,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor,
                      ),
                    ),

                    ...[
                      SizedBox(width: 12.w),

                      // Divider
                      Container(
                        height: 18.h,
                        width: 1,
                        color: AppColors.primaryColor.withValues(alpha: 0.4),
                      ),

                      SizedBox(width: 12.w),

                      // File name or placeholder
                      Expanded(
                        child: Text(
                          pickedFile.value?.fileName ??
                              AppLocalizations.of(context)!.no_file_chosen,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: pickedFile.value == null
                                ? Colors.grey
                                : AppColors.hitTextColor000000,
                          ),
                        ),
                      ),
                    ]
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 6.w),
          if (fileUrl != null)
            InkWell(
              onTap: isDownloading.value ? null : onDownload,
              child: Container(
                width: 48.w,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Obx(() {
                  return isDownloading.value
                      ? Center(
                          child: SizedBox(
                            width:
                                40.w, // increase size a bit for text visibility
                            height: 40.w,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                CircularProgressIndicator(
                                  value: progress.value / 100,
                                  strokeWidth: 3,
                                  color: AppColors.whiteColor,
                                ),
                                Text(
                                  "${progress.value.toInt()}%",
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    color: AppColors.whiteColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Icon(Icons.download, color: AppColors.whiteColor);
                }),
              ),
            ),
        ],
      ),
    );
  }
}
