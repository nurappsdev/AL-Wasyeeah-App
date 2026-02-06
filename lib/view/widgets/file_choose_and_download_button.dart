import 'package:al_wasyeah/helpers/file_picker_util.dart';
import 'package:al_wasyeah/utils/app_colors.dart';
import 'package:flutter/material.dart';

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
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
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
                      size: 20,
                      color: AppColors.primaryColor,
                    ),
                    SizedBox(width: 8),

                    // Choose file text
                    Text(
                      "Choose file",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor,
                      ),
                    ),

                    ...[
                      SizedBox(width: 12),

                      // Divider
                      Container(
                        height: 18,
                        width: 1,
                        color: AppColors.primaryColor.withOpacity(0.4),
                      ),

                      SizedBox(width: 12),

                      // File name or placeholder
                      Expanded(
                        child: Text(
                          pickedFile.value?.fileName ?? "No file chosen",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13,
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
          SizedBox(width: 6),
          if (fileUrl != null)
            InkWell(
              onTap: isDownloading.value ? null : onDownload,
              child: Container(
                width: 48,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Obx(() {
                  return isDownloading.value
                      ? Center(
                          child: SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              value: progress.value / 100,
                              strokeWidth: 2,
                              color: AppColors.whiteColor,
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
