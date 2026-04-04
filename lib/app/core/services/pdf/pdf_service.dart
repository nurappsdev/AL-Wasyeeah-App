import 'dart:convert';
import 'dart:io';
import 'package:al_wasyeah/app/core/services/qr_barcode/qr_barcode_service.dart';
import 'package:al_wasyeah/app/view/wasiyyah/model/wasyyah_model.dart';
import 'package:al_wasyeah/app/core/utils/app_image.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_html_to_pdf/flutter_native_html_to_pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class PdfService {
  static Future<File> generateWasyyahPdf(
    List<WasyyahContentModel> wasyyahList,
    Map<String, dynamic> qrData,
  ) async {
    final outputDir = await getTemporaryDirectory();

    // Step 1: Build HTML
    final html = await _buildHtml(wasyyahList, qrData);

    // Step 2: Generate PDF bytes from HTML using native WebView
    final converter = HtmlToPdfConverter();
    final Uint8List? htmlPdfBytes = await converter.convertHtmlToPdfBytes(
      html: html,
    );

    if (htmlPdfBytes == null || htmlPdfBytes.isEmpty) {
      throw Exception('Failed to generate PDF from HTML.');
    }

    // Step 3: Add "Page X of Y" to every page footer using Syncfusion
    final Uint8List finalPdfBytes = await _addPageNumberFooter(htmlPdfBytes);

    // Step 4: Save file
    final file = File('${outputDir.path}/Wasyyah.pdf');
    await file.writeAsBytes(finalPdfBytes, flush: true);
    return file;
  }

  static Future<Uint8List> _addPageNumberFooter(Uint8List inputBytes) async {
    final PdfDocument document = PdfDocument(inputBytes: inputBytes);

    final ByteData regularFontData = await rootBundle.load(
      'assets/fonts/NotoSansBengali-Regular.ttf',
    );

    final PdfFont footerFont = PdfTrueTypeFont(
      regularFontData.buffer.asUint8List(),
      10,
    );

    final int totalPages = document.pages.count;

    // Must match your HTML footer height
    const double footerHeight = 78;

    // Left padding inside footer image
    const double leftPadding = 36;

    // Text box size
    const double textWidth = 120;
    const double textHeight = 16;

    for (int i = 0; i < totalPages; i++) {
      final PdfPage page = document.pages[i];
      final Size pageSize = page.getClientSize();

      final String footerText = 'Page ${i + 1} of $totalPages';

      // Place text inside footer image, left-center vertically
      final double x = leftPadding;
      final double y = pageSize.height -
          footerHeight -
          textHeight -
          5 /*+ ((footerHeight - textHeight) / 2)*/;

      page.graphics.drawString(
        footerText,
        footerFont,
        brush: PdfBrushes.green,
        bounds: Rect.fromLTWH(x, y, textWidth, textHeight),
        format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle,
        ),
      );
    }

    final List<int> bytes = await document.save();
    document.dispose();
    return Uint8List.fromList(bytes);
  }

  static Future<String> _buildHtml(
    List<WasyyahContentModel> wasyyahList,
    Map<String, dynamic> qrData,
  ) async {
    final qrBase64 = await QrBarcodeService.generateQrBase64(qrData);
    final barcodeBase64 = await QrBarcodeService.generateBarcodeBase64(qrData);
    final bgBase64 = await _assetToBase64(AppImages.pdfbgImage);
    final firstHeaderBase64 =
        await _assetToBase64(AppImages.firstPdfHeaderImage);
    final footerBase64 = await _assetToBase64(AppImages.pdfFooterImage);
    final logoBase64 = await _assetToBase64(AppImages.transparent_app_logo);

    final regularFontBase64 = await _assetToBase64(
      'assets/fonts/NotoSansBengali-Regular.ttf',
    );
    final boldFontBase64 = await _assetToBase64(
      'assets/fonts/NotoSansBengali-Bold.ttf',
    );

    final visibleItems = wasyyahList.where((e) => e.visible == "Y").toList();

    final contentHtml = visibleItems.map((item) {
      final title = _escapeHtml(
        (item.title?.trim().isNotEmpty ?? false) ? item.title! : 'Untitled',
      );

      final content = _escapeHtml(item.content ?? '').replaceAll('\n', '<br>');

      return '''
        <div class="section-card">
          <div class="section-title">$title</div>
          <div class="section-divider"></div>
          <div class="section-content">$content</div>
        </div>
      ''';
    }).join();

    return '''
<!DOCTYPE html>
<html lang="bn">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <style>
    @font-face {
      font-family: 'NotoSansBengali';
      src: url(data:font/ttf;base64,$regularFontBase64) format('truetype');
      font-weight: 400;
      font-style: normal;
    }

    @font-face {
      font-family: 'NotoSansBengali';
      src: url(data:font/ttf;base64,$boldFontBase64) format('truetype');
      font-weight: 700;
      font-style: normal;
    }

    :root {
      --page-top: 38px;
      --page-right: 32px;
      --page-bottom: 90px;
      --page-left: 32px;
      --footer-height: 78px;
      --footer-side-padding: 36px;
    }

    @page {
      size: A4;
      margin: var(--page-top) var(--page-right) var(--page-bottom) var(--page-left);
    }

    * {
      box-sizing: border-box;
      -webkit-print-color-adjust: exact !important;
      print-color-adjust: exact !important;
    }

    html, body {
      margin: 0;
      padding: 0;
    }

    body {
      font-family: 'NotoSansBengali', sans-serif;
      font-size: 14px;
      line-height: 1.8;
      color: #1a1a1a;
      background-image: url("data:image/png;base64,$bgBase64");
      background-size: cover;
      background-repeat: no-repeat;
      background-position: center center;
      word-break: break-word;
    }

    .page-header {
  position: relative;
  display: block;
  width: calc(100% + var(--page-left) + var(--page-right));
  margin-left: calc(-1 * var(--page-left));
  margin-right: calc(-1 * var(--page-right));
  margin-top: calc(-1 * var(--page-top));
  margin-bottom: 18px;
}

   .header-qr {
  position: absolute;
  right: 32px;
  top: 44px;
  width: 200px;
  height: 200px;
  background-color: white;
  padding: 5px;
  border: 1px solid #14532d;
  border-radius: 8px;
}

.header-qr img {
  width: 100%;
  height: 100%;
  object-fit: contain;
  image-rendering: pixelated;
  image-rendering: -webkit-optimize-contrast;
}

.header-barcode {
  position: absolute;
  left: 32px;
  top: 44px;
  width: 200px;
  height: 200px;
  background-color: white;
  padding: 5px;
  border: 1px solid #14532d;
  border-radius: 8px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.header-barcode img {
  width: 100%;
  height: auto;
  object-fit: contain;
  image-rendering: -webkit-optimize-contrast;
}

    .section-card {
      margin-bottom: 20px;
      padding: 15px;
      border: 1px solid #14532d;
      border-radius: 12px;
      background: rgba(255, 255, 255, 0.88);
      page-break-inside: avoid;
      break-inside: avoid;
    }

    .section-title {
      font-size: 18px;
      font-weight: 700;
      color: #14532d;
      margin-bottom: 10px;
    }

    .section-divider {
      height: 2px;
      background: #166534;
      margin-bottom: 12px;
    }

    .section-content {
      font-size: 14px;
      text-align: justify;
      white-space: normal;
    }

    .footer-space {
      height: calc(var(--footer-height) + 20px);
    }

    .pdf-footer {
      position: fixed;
      left: calc(-1 * var(--page-left));
      right: calc(-1 * var(--page-right));
      bottom: 0;
      height: var(--footer-height);
      background-image: url("data:image/png;base64,$footerBase64");
      background-size: 100% 100%;
      background-repeat: no-repeat;
      background-position: center;
      z-index: 999;
    }

    .pdf-footer-inner {
      position: relative;
      width: 100%;
      height: 100%;
    }

    .footer-logo {
      position: absolute;
      right: var(--footer-side-padding);
      top: 50%;
      transform: translateY(-50%);
      display: flex;
      align-items: center;
      justify-content: center;
      height: 36px;
    }

    .footer-logo img {
      display: block;
      height: 36px;
      width: auto;
      object-fit: contain;
    }
  </style>
</head>
<body>
<div class="page-header">
  <img src="data:image/png;base64,$firstHeaderBase64" alt="header" />

  <div class="header-qr">
    <img src="data:image/png;base64,$qrBase64" />
  </div>
  <div class="header-barcode">
  <img src="data:image/svg+xml;base64,$barcodeBase64" />
</div>
</div>

  $contentHtml

  <div class="footer-space"></div>

  <div class="pdf-footer">
    <div class="pdf-footer-inner">
      <div class="footer-logo">
        <img src="data:image/png;base64,$logoBase64" alt="logo" />
      </div>
    </div>
  </div>
</body>
</html>
''';
  }

  static Future<String> _assetToBase64(String assetPath) async {
    final ByteData data = await rootBundle.load(assetPath);
    return base64Encode(data.buffer.asUint8List());
  }

  static String _escapeHtml(String text) {
    return text
        .replaceAll('&', '&amp;')
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;')
        .replaceAll('"', '&quot;')
        .replaceAll("'", '&#39;');
  }
}
