import 'dart:developer';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:al_wasyeah/app/core/l10n/app_localizations.dart';
import 'package:al_wasyeah/app/core/utils/extensions.dart';
import 'package:al_wasyeah/app/core/utils/toast_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';

class WasiyyahPdfPreviewPage extends StatefulWidget {
  const WasiyyahPdfPreviewPage({super.key});

  @override
  State<WasiyyahPdfPreviewPage> createState() => _WasiyyahPdfPreviewPageState();
}

class _WasiyyahPdfPreviewPageState extends State<WasiyyahPdfPreviewPage> {
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
        ToastMessage.errorMessageShowToster(AppLocalizations.of(context)!.no_content_available);
        return;
      }

      final targetDir = Directory("/storage/emulated/0/Download/AlWasyeeah");

      await targetDir.create(recursive: true);
      final targetPath = "${targetDir.path}${Platform.pathSeparator}Wasiyyah_legal.pdf";
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
    return (await Permission.manageExternalStorage.isGranted) || Platform.version.contains('API 30');
  }

  @override
  Widget build(BuildContext context) {
    if (_filePath == null) {
      return Scaffold(
        body: Center(child: Text(AppLocalizations.of(context)!.no_data)),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.wasiyyah_preview),
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
                _error = "${AppLocalizations.of(context)!.page}" + " $page: $error";
              });
            },
            onPageChanged: (page, total) {
              setState(() => _currentPage = page ?? 0);
            },
          ),
          if (!_isReady && _error == null) const Center(child: CircularProgressIndicator()),
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
}
