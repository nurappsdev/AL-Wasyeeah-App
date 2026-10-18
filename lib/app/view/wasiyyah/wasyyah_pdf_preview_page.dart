import 'dart:developer';
import 'dart:io';
import 'package:wasiyyat/app/core/widgets/custom_app_bar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wasiyyat/app/core/l10n/app_localizations.dart';
import 'package:wasiyyat/app/core/utils/extensions.dart';
import 'package:wasiyyat/app/core/utils/toast_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

class WasyyahPdfPreviewPage extends StatefulWidget {
  const WasyyahPdfPreviewPage({super.key});

  @override
  State<WasyyahPdfPreviewPage> createState() => _WasyyahPdfPreviewPageState();
}

class _WasyyahPdfPreviewPageState extends State<WasyyahPdfPreviewPage> {
  String? _filePath;
  int _totalPages = 0;
  int _currentPage = 0;
  bool _isReady = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    if (args is Map && args["filePath"] is String) {
      _filePath = args["filePath"] as String;
    } else if (args is String) {
      _filePath = args;
    }
  }

  Future<void> _downloadPdf() async {
    if (_filePath == null) return;
    await requestStoragePermission();

    try {
      final source = File(_filePath!);
      if (!await source.exists()) {
        ToastMessage.errorMessageShowToster(
            AppLocalizations.of(context)!.no_content_available);
        return;
      }

      final targetDir = Directory("/storage/emulated/0/Download/AlWasyeeah");

      await targetDir.create(recursive: true);
      final targetPath =
          "${targetDir.path}${Platform.pathSeparator}Wasiyyah_legal.pdf";
      await source.copy(targetPath);
      ToastMessage.successMessageShowToster(
        AppLocalizations.of(context)!.file_downloaded_successfully,
      );
    } catch (e, s) {
      log("Error is $e", error: e, stackTrace: s);
      ToastMessage.errorMessageShowToster(e.toString());
    }
  }

  Future<void> requestStoragePermission() async {
    if (Platform.isAndroid) {
      if (await _isAndroid11OrAbove()) {
        // For Android 11 and above, request MANAGE_EXTERNAL_STORAGE permission
        if (!await Permission.manageExternalStorage.isGranted) {
          await Permission.manageExternalStorage.request();
        }
      } else {
        // For Android versions below 11, request READ/WRITE_EXTERNAL_STORAGE permissions
        if (!await Permission.storage.isGranted) {
          await Permission.storage.request();
        }
      }
    }
  }

  Future<bool> _isAndroid11OrAbove() async {
    return (await Permission.manageExternalStorage.isGranted) ||
        Platform.version.contains('API 30');
  }

  @override
  Widget build(BuildContext context) {
    if (_filePath == null) {
      return Scaffold(
        body: Center(child: Text(AppLocalizations.of(context)!.no_data)),
      );
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.wasiyyah_preview,
        actions: [
          IconButton(
            onPressed: _downloadPdf,
            icon: const Icon(Icons.download),
            tooltip: AppLocalizations.of(context)!.download,
          ),
        ],
      ),
      body: Stack(
        children: [
          PDFView(
            filePath: _filePath!,
            enableSwipe: true,
            swipeHorizontal: true,
            autoSpacing: false,
            pageFling: true,
            fitEachPage: true,
            fitPolicy: FitPolicy.WIDTH,
            onRender: (pages) {
              setState(() {
                _totalPages = pages ?? 0;
                _isReady = true;
              });
            },
            onError: (error) {
              setState(() => _error = error.toString());
            },
            onPageError: (page, error) {
              setState(() {
                _error =
                    "${AppLocalizations.of(context)!.page}" + " $page: $error";
              });
            },
            onPageChanged: (page, total) {
              setState(() => _currentPage = page ?? 0);
            },
          ),
          if (!_isReady && _error == null) _buildPdfSkeleton(),
          if (_error != null) Center(child: Text(_error!)),
        ],
      ),
      bottomNavigationBar: _isReady
          ? Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                "${AppLocalizations.of(context)!.page} ${(_currentPage + 1).toLocal()} of ${_totalPages.toLocal()}",
                textAlign: TextAlign.center,
              ),
            )
          : null,
    );
  }

  Widget _buildPdfSkeleton() {
    return Positioned.fill(
      child: Container(
        color: const Color(0xFFF0F2F5),
        child: Skeletonizer(
          enabled: true,
          effect: ShimmerEffect(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
          ),
          containersColor: Colors.grey.shade200,
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Center(
              child: Container(
                width: double.infinity,
                constraints: BoxConstraints(maxWidth: 420.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Container(
                            width: 50.w,
                            height: 50.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey.shade300,
                            ),
                          ),
                          SizedBox(height: 12.h),
                          Container(
                            width: 160.w,
                            height: 16.h,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Container(
                            width: 220.w,
                            height: 12.h,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),
                    const Divider(),
                    SizedBox(height: 16.h),
                    Container(
                      width: 130.w,
                      height: 14.h,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Container(
                      width: double.infinity,
                      height: 10.h,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Container(
                      width: double.infinity,
                      height: 10.h,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Container(
                      width: 220.w,
                      height: 10.h,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Container(
                      width: 150.w,
                      height: 14.h,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Container(
                      width: double.infinity,
                      height: 10.h,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Container(
                      width: double.infinity,
                      height: 10.h,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Container(
                      width: 180.w,
                      height: 10.h,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Container(
                      width: double.infinity,
                      height: 60.h,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Container(
                      width: 110.w,
                      height: 14.h,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Container(
                      width: double.infinity,
                      height: 10.h,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Container(
                      width: 200.w,
                      height: 10.h,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                    SizedBox(height: 32.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 80.w,
                              height: 2.h,
                              color: Colors.grey.shade300,
                            ),
                            SizedBox(height: 6.h),
                            Container(
                              width: 60.w,
                              height: 10.h,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(2.r),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              width: 80.w,
                              height: 2.h,
                              color: Colors.grey.shade300,
                            ),
                            SizedBox(height: 6.h),
                            Container(
                              width: 60.w,
                              height: 10.h,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(2.r),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
