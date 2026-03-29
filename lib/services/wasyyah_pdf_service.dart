import 'dart:io';
import 'package:al_wasyeah/models/wasyyah/get_wasyyah_response_model.dart';
import 'package:al_wasyeah/utils/app_image.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class WasyyahPdfService {
  static Future<File> generateWasyyahPdf(List<GetWasyyahResponseModel> wasyyahList) async {
    final pdf = pw.Document();

    // Load assets
    final bgImageSrc = await rootBundle.load(AppImages.pdfbgImage);
    final bgImage = pw.MemoryImage(bgImageSrc.buffer.asUint8List());

    final firstHeaderSrc = await rootBundle.load(AppImages.firstPdfHeaderImage);
    final firstHeader = pw.MemoryImage(firstHeaderSrc.buffer.asUint8List());

    final secondHeaderSrc = await rootBundle.load(AppImages.secondPdfHeaderImage);
    final secondHeader = pw.MemoryImage(secondHeaderSrc.buffer.asUint8List());

    final footerBgSrc = await rootBundle.load(AppImages.pdfFooterImage);
    final footerBg = pw.MemoryImage(footerBgSrc.buffer.asUint8List());

    final logoSrc = await rootBundle.load(AppImages.app_logo);
    final logo = pw.MemoryImage(logoSrc.buffer.asUint8List());

    // Load Bengali Font
    final fontData = await rootBundle.load("assets/fonts/NotoSansBengali-Regular.ttf");
    final ttf = pw.Font.ttf(fontData);

    final pageTheme = pw.PageTheme(
      pageFormat: PdfPageFormat.a4,
      theme: pw.ThemeData.withFont(
        base: pw.Font.helvetica(),
        bold: pw.Font.helveticaBold(),
        fontFallback: [ttf],
      ),
      margin: const pw.EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      buildBackground: (context) {
        return pw.FullPage(
          ignoreMargins: true,
          child: pw.Image(bgImage, fit: pw.BoxFit.cover),
        );
      },
    );

    pdf.addPage(
      pw.MultiPage(
        pageTheme: pageTheme,
        header: (context) {
          final isFirstPage = context.pageNumber == 1;
          return pw.Container(
            alignment: pw.Alignment.center,
            margin: const pw.EdgeInsets.only(bottom: 20),
            child: pw.Image(
              isFirstPage ? firstHeader : secondHeader,
              fit: pw.BoxFit.contain,
              height: 100,
            ),
          );
        },
        footer: (context) {
          return pw.Container(
            height: 100,
            width: double.infinity,
            alignment: pw.Alignment.bottomCenter,
            child: pw.Stack(
              alignment: pw.Alignment.bottomCenter,
              children: [
                pw.Image(footerBg, fit: pw.BoxFit.fill),
                pw.Padding(
                  padding: const pw.EdgeInsets.only(left: 40, right: 40, bottom: 20),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text(
                        'Page ${context.pageNumber} of ${context.pagesCount}',
                        style: pw.TextStyle(
                          fontSize: 10,
                          color: PdfColors.black,
                        ),
                      ),
                      pw.Image(logo, height: 40),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        build: (context) => [
          pw.SizedBox(height: 20),
          ...wasyyahList.where((e) => e.visible == "Y").map((item) {
            return pw.Container(
              margin: const pw.EdgeInsets.only(bottom: 20),
              padding: const pw.EdgeInsets.all(15),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColors.green900, width: 1),
                borderRadius: const pw.BorderRadius.all(pw.Radius.circular(12)),
                color: const PdfColor(1, 1, 1, 0.8),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    item.title ?? "Untitled",
                    style: pw.TextStyle(
                      fontSize: 18,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.green900,
                    ),
                  ),
                  pw.Divider(thickness: 2, color: PdfColors.green800),
                  pw.SizedBox(height: 12),
                  pw.Text(
                    item.content ?? "",
                    style: const pw.TextStyle(fontSize: 14),
                    textAlign: pw.TextAlign.justify,
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File("${output.path}/Wasyyah.pdf");
    await file.writeAsBytes(await pdf.save());
    return file;
  }
}
