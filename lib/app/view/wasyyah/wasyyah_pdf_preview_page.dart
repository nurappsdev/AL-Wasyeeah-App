import 'dart:developer';
import 'dart:io';

import 'package:al_wasyeah/core/services/toast_message_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';

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

    try {
      final source = File(_filePath!);
      if (!await source.exists()) {
        ToastMessageHelper.errorMessageShowToster("PDF file not found");
        return;
      }

      final targetDir = Directory("/storage/emulated/0/Download/AlWasyeeah");

      await targetDir.create(recursive: true);
      final targetPath =
          "${targetDir.path}${Platform.pathSeparator}Wasiyyah_legal.pdf";
      await source.copy(targetPath);
      ToastMessageHelper.successMessageShowToster(
        "Saved to ${targetDir.path}",
      );
    } catch (e, s) {
      log("Error is $e", error: e, stackTrace: s);
      ToastMessageHelper.errorMessageShowToster("Download failed: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_filePath == null) {
      return const Scaffold(
        body: Center(child: Text("No PDF found")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Wasyyah Preview"),
        actions: [
          IconButton(
            onPressed: _downloadPdf,
            icon: const Icon(Icons.download),
            tooltip: "Download",
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
              setState(() => _error = "Page $page: $error");
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
                "Page ${_currentPage + 1} of $_totalPages",
                textAlign: TextAlign.center,
              ),
            )
          : null,
    );
  }
}
